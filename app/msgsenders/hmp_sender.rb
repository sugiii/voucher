class HmpSender
    def doSend(tc)
        case tc.trcode
        when '10', '30', '50'
            msgType1 = MsgType1.new
            msgType1.doSend(tc)
        end
    end
end
