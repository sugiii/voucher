class Dispatcher
    def doSend(tc)
        if (tc.kind == VoucherKind::HMP)
            sender = HmpSender.new
        elsif (tc.kind == VoucherKind::NGC)
            sender = NgcSender.new
        elseif (tc.kind == VoucherKind::SSG)
            sender = SsgSender.new
        end

        sender.doSend(tc)
    end
end