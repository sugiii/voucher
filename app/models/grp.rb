class Grp < ActiveRecord::Base
    has_many :msgform
    has_many :testcase
    has_many :msgdatum
    
    def findMsg (comps, msgs)
        msgId = Grp
            .select('msgforms.id')
            .joins(:msgform)
            .find_by('grps.comp' => comps[0], 'grps.port' => comps[1], 'grps.trcode' => comps[2], 'msgforms.seq' => msgs[0])
        return msgId
    end

    def getMsgform (comps)
        Grp
            .select('msgforms.seq, msgforms.name, msgforms.pos, msgforms.len, msgforms.desc')
            .joins(:msgform)
            .where('grps.comp' => comps[0], 'grps.port' => comps[1], 'grps.trcode' => comps[2])
            .order('msgforms.seq ASC')
    end

    def getHistdata (comps, msgs)
        Grp
            .select('testcases.name, testcases.desc, testcases.exprlt, testcases.trydate, testcases.id')
            .joins(:testcase)
            .where('grps.comp' => comps[0], 'grps.port' => comps[1], 'grps.trcode' => comps[2])
            .order('testcases.trydate DESC')
    end

    def deleteMsgform (comps, msgs)
        msgId = Grp
            .select('msgforms.id')
            .joins(:msgform)
            .find_by('grps.comp' => comps[0], 'grps.port' => comps[1], 'grps.trcode' => comps[2], 'msgforms.seq' => msgs[0])
        return msgId
    end
end
