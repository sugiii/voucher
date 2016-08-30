class MsgBase
    def prepareMsg(tc)
        msg = tc.sendMsg
        daoRlt = @dao.getDataFromDB(@sql)
        if (daoRlt.length != @daoRltCnt)
            puts 'ERROR : daoRlt.length != daoRltCnt'
            return
        end
        i = 0
        @repl.each do |pos, len|
            msg[pos..pos+len] = daoRlt[i].ljust(len)[0..len]
            i = i + 1
        end
    end

    def prepareCaOnlineMsg(tc)
        case tc.kind
        when VoucherKind::NGC
            if (tc.port == 'TDM')
                tc.sendMsg[23..27] = '0420'
            end
        end
    end

    def prepareCaReqMsg(tc)
    end

    def extractRltCd(tc)
        rltCd = ''
        case tc.kind
        when VoucherKind::HMP
            if (tc.port == 'TDM')
                rltCd = tc.recvMsg[88..92]
            end
        end
        tc.rltCd.replace rltCd
        insertTestResult(tc)
    end

    def insertTestResult(tc)
        @test_result.push(tc)
    end

    def doSend(tc)
        @tx_rx = VoucherSock.new
        @dao = Dao.new

        @sendMsg = ''
        @daoRltCnt = 2
        @sql = ''
        @test_result = Array.new

        @sendMsg = prepareMsg(tc)
        tc.sendMsg.replace @sendMsg.to_s
        tc.recvMsg.replace @tx_rx.reqServer(tc)
        extractRltCd(tc)
        if (tc.rltCd != '0000')
            MsgformsController.setTestResult @test_result
            return 
        end

        sleep(1)

        if (tc.caOnline == true)
            tc.sendMsg.replace prepareCaOnlineMsg(sendMsg)
            tc.recvMsg.replace @tx_rx.reqServer(tc)
            extractRltCd(tc)
            sleep(1)
        end

        if (tc.caReq == true)
            tc.sendMsg.replace sendMsg
            tc.recvMsg.replace @tx_rx.reqServer(tc)
            extractRltCd(tc)
            if (tc.rltCd != '0000')
                return
            end

            sleep(1)

            tc.sendMsg.replace prepareCaReqMsg(tc)
            tc.recvMsg.replace tx_rx.reqServer(tc)
            extractRltCd(tc)
        end
        MsgformsController.setTestResult @test_result
        return 
    end
end
