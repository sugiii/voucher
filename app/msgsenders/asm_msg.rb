class AsmMsg
    def asmMsg(msgs)
        i = 0
        msg = ''
        m = msgs[i.to_s]
        while(m != nil)
            msg += m[2].ljust(m[4].to_i)[0..m[4].to_i]
            i = i + 1
            m = msgs[i.to_s]
        end
        return msg
    end
end