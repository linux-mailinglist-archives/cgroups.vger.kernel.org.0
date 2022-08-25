Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163CC5A1019
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiHYMOJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbiHYMOI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 08:14:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50812AB05E;
        Thu, 25 Aug 2022 05:14:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MD20C5tDVzKKvr;
        Thu, 25 Aug 2022 20:12:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD34b2KZwdj4khRAw--.10211S3;
        Thu, 25 Aug 2022 20:14:03 +0800 (CST)
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Paolo Valente <paolo.valente@unimore.it>
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
 <abdbb5db-e280-62f8-0670-536fcb8ec4d9@huaweicloud.com>
 <C2CF100A-9A7C-4300-9A70-1295BC939C66@unimore.it>
 <9b2d667f-6636-9347-08a1-8bd0aa2346f2@huaweicloud.com>
 <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
 <55A07102-BE55-4606-9E32-64E884064FB9@unimore.it>
 <5cb0e5bc-feec-86d6-6f60-3c28ee625efd@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fac90f36-35cb-6027-af35-577a1c714480@huaweicloud.com>
Date:   Thu, 25 Aug 2022 20:14:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5cb0e5bc-feec-86d6-6f60-3c28ee625efd@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD34b2KZwdj4khRAw--.10211S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW8WF1kKr45Gr1UuryrXrb_yoW3Kr1kp3
        yrGa1UAr4UXr1rtr1jqw1UXrySq34fJry8Wr1DJr1xAr1qyFn7tF17tr409ry8Xr4kJr12
        qr1UX3srZw1UtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/08/11 9:19, Yu Kuai 写道:
> Hi, Paolo
> 
> 在 2022/08/10 18:49, Paolo Valente 写道:
>>
>>
>>> Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai 
>>> <yukuai1@huaweicloud.com> ha scritto:
>>>
>>> Hi, Paolo
>>>
>>
>> hi
>>
>>> Are you still interested in this patchset?
>>>
>>
>> Yes. Sorry for replying very late again.
>>
>> Probably the last fix that you suggest is enough, but I'm a little bit
>> concerned that it may be a little hasty.  In fact, before this fix, we
>> exchanged several messages, and I didn't seem to be very good at
>> convincing you about the need to keep into account also in-service
>> I/O.  So, my question is: are you sure that now you have a
> 
> I'm confused here, I'm pretty aware that in-service I/O(as said pending
> requests is the patchset) should be counted, as you suggested in v7, are
> you still thinking that the way in this patchset is problematic?
> 
> I'll try to explain again that how to track is bfqq has pending pending
> requests, please let me know if you still think there are some problems:
> 
> patch 1 support to track if bfqq has pending requests, it's
> done by setting the flag 'entity->in_groups_with_pending_reqs' when the
> first request is inserted to bfqq, and it's cleared when the last
> request is completed. specifically the flag is set in
> bfq_add_bfqq_busy() when 'bfqq->dispatched' if false, and it's cleared
> both in bfq_completed_request() and bfq_del_bfqq_busy() when
> 'bfqq->diapatched' is false.

Hi, Paolo

Can you please have a check if patch 1 is ok?

Thanks,
Kuai
> 
> Thanks,
> Kuai
>> clear/complete understanding of this non-trivial matter?
>> Consequently, are we sure that this last fix is most certainly all we
>> need?  Of course, I will check on my own, but if you reassure me on
>> this point, I will feel more confident.
>>
>> Thanks,
>> Paolo
>>
>>> 在 2022/07/20 19:38, Yu Kuai 写道:
>>>> Hi
>>>>
>>>> 在 2022/07/20 19:24, Paolo VALENTE 写道:
>>>>>
>>>>>
>>>>>> Il giorno 12 lug 2022, alle ore 15:30, Yu Kuai 
>>>>>> <yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha 
>>>>>> scritto:
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> I'm copying my reply with new mail address, because Paolo seems
>>>>>> didn't receive my reply.
>>>>>>
>>>>>> 在 2022/06/23 23:32, Paolo Valente 写道:
>>>>>>> Sorry for the delay.
>>>>>>>> Il giorno 10 giu 2022, alle ore 04:17, Yu Kuai 
>>>>>>>> <yukuai3@huawei.com <mailto:yukuai3@huawei.com>> ha scritto:
>>>>>>>>
>>>>>>>> Currently, bfq can't handle sync io concurrently as long as they
>>>>>>>> are not issued from root group. This is because
>>>>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>>>>> bfq_asymmetric_scenario().
>>>>>>>>
>>>>>>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>>>>>>
>>>>>>>> Before this patch:
>>>>>>>> 1) root group will never be counted.
>>>>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the 
>>>>>>>> requests.
>>>>>>>>
>>>>>>>> After this patch:
>>>>>>>> 1) root group is counted.
>>>>>>>> 2) Count if bfqg have pending requests.
>>>>>>>> 3) Don't count if bfqg complete all the requests.
>>>>>>>>
>>>>>>>> With this change, the occasion that only one group is activated 
>>>>>>>> can be
>>>>>>>> detected, and next patch will support concurrent sync io in the
>>>>>>>> occasion.
>>>>>>>>
>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com 
>>>>>>>> <mailto:yukuai3@huawei.com>>
>>>>>>>> Reviewed-by: Jan Kara <jack@suse.cz <mailto:jack@suse.cz>>
>>>>>>>> ---
>>>>>>>> block/bfq-iosched.c | 42 ------------------------------------------
>>>>>>>> block/bfq-iosched.h | 18 +++++++++---------
>>>>>>>> block/bfq-wf2q.c    | 19 ++++---------------
>>>>>>>> 3 files changed, 13 insertions(+), 66 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>>>> index 0ec21018daba..03b04892440c 100644
>>>>>>>> --- a/block/bfq-iosched.c
>>>>>>>> +++ b/block/bfq-iosched.c
>>>>>>>> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct 
>>>>>>>> bfq_data *bfqd,
>>>>>>>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>>>>>>      struct bfq_queue *bfqq)
>>>>>>>> {
>>>>>>>> -struct bfq_entity *entity = bfqq->entity.parent;
>>>>>>>> -
>>>>>>>> -for_each_entity(entity) {
>>>>>>>> -struct bfq_sched_data *sd = entity->my_sched_data;
>>>>>>>> -
>>>>>>>> -if (sd->next_in_service || sd->in_service_entity) {
>>>>>>>> -/*
>>>>>>>> -* entity is still active, because either
>>>>>>>> -* next_in_service or in_service_entity is not
>>>>>>>> -* NULL (see the comments on the definition of
>>>>>>>> -* next_in_service for details on why
>>>>>>>> -* in_service_entity must be checked too).
>>>>>>>> -*
>>>>>>>> -* As a consequence, its parent entities are
>>>>>>>> -* active as well, and thus this loop must
>>>>>>>> -* stop here.
>>>>>>>> -*/
>>>>>>>> -break;
>>>>>>>> -}
>>>>>>>> -
>>>>>>>> -/*
>>>>>>>> -* The decrement of num_groups_with_pending_reqs is
>>>>>>>> -* not performed immediately upon the deactivation of
>>>>>>>> -* entity, but it is delayed to when it also happens
>>>>>>>> -* that the first leaf descendant bfqq of entity gets
>>>>>>>> -* all its pending requests completed. The following
>>>>>>>> -* instructions perform this delayed decrement, if
>>>>>>>> -* needed. See the comments on
>>>>>>>> -* num_groups_with_pending_reqs for details.
>>>>>>>> -*/
>>>>>>>> -if (entity->in_groups_with_pending_reqs) {
>>>>>>>> -entity->in_groups_with_pending_reqs = false;
>>>>>>>> -bfqd->num_groups_with_pending_reqs--;
>>>>>>>> -}
>>>>>>>> -}
>>>>>>> With this part removed, I'm missing how you handle the following
>>>>>>> sequence of events:
>>>>>>> 1.  a queue Q becomes non busy but still has dispatched requests, so
>>>>>>> it must not be removed from the counter of queues with pending reqs
>>>>>>> yet
>>>>>>> 2.  the last request of Q is completed with Q being still idle (non
>>>>>>> busy).  At this point Q must be removed from the counter.  It 
>>>>>>> seems to
>>>>>>> me that this case is not handled any longer
>>>>>> Hi, Paolo
>>>>>>
>>>>>> 1) At first, patch 1 support to track if bfqq has pending 
>>>>>> requests, it's
>>>>>> done by setting the flag 'entity->in_groups_with_pending_reqs' 
>>>>>> when the
>>>>>> first request is inserted to bfqq, and it's cleared when the last
>>>>>> request is completed(based on weights_tree insertion and removal).
>>>>>>
>>>>>
>>>>> In patch 1 I don't see the flag cleared for the request-completion 
>>>>> event :(
>>>>>
>>>>> The piece of code involved is this:
>>>>>
>>>>> static void bfq_completed_request(struct bfq_queue *bfqq, struct 
>>>>> bfq_data *bfqd)
>>>>> {
>>>>> u64 now_ns;
>>>>> u32 delta_us;
>>>>>
>>>>> bfq_update_hw_tag(bfqd);
>>>>>
>>>>> bfqd->rq_in_driver[bfqq->actuator_idx]--;
>>>>> bfqd->tot_rq_in_driver--;
>>>>> bfqq->dispatched--;
>>>>>
>>>>> if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
>>>>> /*
>>>>> * Set budget_timeout (which we overload to store the
>>>>> * time at which the queue remains with no backlog and
>>>>> * no outstanding request; used by the weight-raising
>>>>> * mechanism).
>>>>> */
>>>>> bfqq->budget_timeout = jiffies;
>>>>>
>>>>> bfq_weights_tree_remove(bfqd, bfqq);
>>>>> }
>>>>> ...
>>>>>
>>>>> Am I missing something?
>>>>
>>>> I add a new api bfq_del_bfqq_in_groups_with_pending_reqs() in patch 1
>>>> to clear the flag, and it's called both from bfq_del_bfqq_busy() and
>>>> bfq_completed_request(). I think you may miss the later:
>>>>
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 0d46cb728bbf..0ec21018daba 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -6263,6 +6263,7 @@ static void bfq_completed_request(struct 
>>>> bfq_queue *bfqq, struct bfq_data *bfqd)
>>>>            */
>>>>           bfqq->budget_timeout = jiffies;
>>>>
>>>> +        bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>>>>           bfq_weights_tree_remove(bfqd, bfqq);
>>>>       }
>>>>
>>>> Thanks,
>>>> Kuai
>>>>>
>>>>> Thanks,
>>>>> Paolo
>>>
>>
>> .
>>
> 
> .
> 

