class Msgdatum < ActiveRecord::Base

    def getMsgdata (tc_id)
        Msgdatum
            .select('msgdata.seq, msgdata.value')
            .where('msgdata.testcase_id' => tc_id)
            .order('msgdata.seq ASC')
    end

end
