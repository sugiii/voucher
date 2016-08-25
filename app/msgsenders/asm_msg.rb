class AsmMsg
    def asmMsg(msgs)
        i = 0
        msg = ''
        m = msgs[i]
        while(m != nil)
            msg += m[2].ljust(m[4])[0..m[4]]
            i++
            m = msgs[i]
        end
        return msg
    end
end