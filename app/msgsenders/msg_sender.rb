class MsgSender
    def sendMsg(comps, msgs)
        tc = TestCaseArg.new
        tc.kind = comps[0]
        tc.port = comps[1]
        tc.trcode = comps[2]

        asmbler = AsmMsg.new
        tc.sendMsg = asmbler.asmMsg(msgs)

        dispatch = Dispatcher.new
        dispatch.doSend(tc)
    end
end