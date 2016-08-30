class MsgType1 < MsgBase
    def initialize()
        @repl = Hash.new
        @repl = [[1,1],[3,3]]
    end
    
    def prepareCaReqMsg(tc)
        msg = tc.sendMsg
        msg[23..27] = '0420'
        case tc.trcode
        when '10'
            msg[27..29] = '30'
            tc.curr_trcode = '30'
            tc.sendMsg = msg
        end
    end
end