class MsgBase
    def prepareMsg(tc)
        msg = tc.sendMsg
        daoRlt = Ddao.getDataFromDB(sql)
        if (daoRlt.length != daoRltCnt)
            puts 'ERROR : daoRlt.length != daoRltCnt'
            return
        end
        @repl.each do |pos, len|

        end
    end

    def extractRltCd(tc)
        return 'to be overrided'
    end

    def insertTestResult(tc)    # will be called by extractRltCd function
    end

    def doSend(tc)
        @tx_rx = VoucherSock.new
        @dao = Dao.new

        @sendMsg = ''
        @daoRltCnt = 0
        @repl = Hash.new

        @sendMsg = prepareMsg(tc)
        tc.sendMsg = @sendMsg
        tc.recvMsg = @tx_rx.reqServer(tc)
        rltCd = extractRltCd(tc)
        if (rltCd != '0000')
            return
        end

        sleep(1)

        if (tc.caOnline == true)
            tc.sendMsg = prepareCaOnlineMsg(sendMsg)
            tc.recvMsg = @tx_rx.reqServer(tc)
            extractRltCd(tc)
            sleep(1)
        end

        if (tc.caReq == true)
            tc.sendMsg = sendMsg
            tc.recvMsg = @tx_rx.reqServer(tc)
            rltCd = extractRltCd(tc)
            if (rltCd != '0000')
                return
            end

            sleep(1)

            tc.sendMsg = prepareCaReqMsg(tc)
            tc.recvMsg = tx_rx.reqServer(tc)
            extractRltCd(tc)
        end
    end
end
