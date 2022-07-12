Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5472571B47
	for <lists+cgroups@lfdr.de>; Tue, 12 Jul 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiGLNal (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jul 2022 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGLNaj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jul 2022 09:30:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43FEB520C;
        Tue, 12 Jul 2022 06:30:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lj1nj0hCtzl67X;
        Tue, 12 Jul 2022 21:29:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCH6ml5d81iITC0Ag--.41650S3;
        Tue, 12 Jul 2022 21:30:33 +0800 (CST)
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <abdbb5db-e280-62f8-0670-536fcb8ec4d9@huaweicloud.com>
Date:   Tue, 12 Jul 2022 21:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCH6ml5d81iITC0Ag--.41650S3
X-Coremail-Antispam: 1UD129KBjvJXoWfJFW3Jry7CF18Gry8uF1rWFg_yoWDXw18p3
        93Ka1Uuw45Jrn7Jr98Jw40qrn2qrZ3AryUtrs0y34akrsxZFnaqFnIkr4rZry8ur93Aw1I
        vr1j934DuwnFyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
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

Hi!

I'm copying my reply with new mail address, because Paolo seems
didn't receive my reply.

ÔÚ 2022/06/23 23:32, Paolo Valente Ð´µÀ:
> Sorry for the delay.
> 
>> Il giorno 10 giu 2022, alle ore 04:17, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>
>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>
>> Before this patch:
>> 1) root group will never be counted.
>> 2) Count if bfqg or it's child bfqgs have pending requests.
>> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>>
>> After this patch:
>> 1) root group is counted.
>> 2) Count if bfqg have pending requests.
>> 3) Don't count if bfqg complete all the requests.
>>
>> With this change, the occasion that only one group is activated can be
>> detected, and next patch will support concurrent sync io in the
>> occasion.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>> block/bfq-iosched.c | 42 ------------------------------------------
>> block/bfq-iosched.h | 18 +++++++++---------
>> block/bfq-wf2q.c    | 19 ++++---------------
>> 3 files changed, 13 insertions(+), 66 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0ec21018daba..03b04892440c 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>> 			     struct bfq_queue *bfqq)
>> {
>> -	struct bfq_entity *entity = bfqq->entity.parent;
>> -
>> -	for_each_entity(entity) {
>> -		struct bfq_sched_data *sd = entity->my_sched_data;
>> -
>> -		if (sd->next_in_service || sd->in_service_entity) {
>> -			/*
>> -			 * entity is still active, because either
>> -			 * next_in_service or in_service_entity is not
>> -			 * NULL (see the comments on the definition of
>> -			 * next_in_service for details on why
>> -			 * in_service_entity must be checked too).
>> -			 *
>> -			 * As a consequence, its parent entities are
>> -			 * active as well, and thus this loop must
>> -			 * stop here.
>> -			 */
>> -			break;
>> -		}
>> -
>> -		/*
>> -		 * The decrement of num_groups_with_pending_reqs is
>> -		 * not performed immediately upon the deactivation of
>> -		 * entity, but it is delayed to when it also happens
>> -		 * that the first leaf descendant bfqq of entity gets
>> -		 * all its pending requests completed. The following
>> -		 * instructions perform this delayed decrement, if
>> -		 * needed. See the comments on
>> -		 * num_groups_with_pending_reqs for details.
>> -		 */
>> -		if (entity->in_groups_with_pending_reqs) {
>> -			entity->in_groups_with_pending_reqs = false;
>> -			bfqd->num_groups_with_pending_reqs--;
>> -		}
>> -	}
> 
> With this part removed, I'm missing how you handle the following
> sequence of events:
> 1.  a queue Q becomes non busy but still has dispatched requests, so
> it must not be removed from the counter of queues with pending reqs
> yet
> 2.  the last request of Q is completed with Q being still idle (non
> busy).  At this point Q must be removed from the counter.  It seems to
> me that this case is not handled any longer
> 
Hi, Paolo

1) At first, patch 1 support to track if bfqq has pending requests, it's
done by setting the flag 'entity->in_groups_with_pending_reqs' when the
first request is inserted to bfqq, and it's cleared when the last
request is completed(based on weights_tree insertion and removal).

2) Then, patch 2 add a counter in bfqg: how many bfqqs have pending
requests, which is updated while tracking if bfqq has pending requests.

3) Finally, patch 3 tracks 'num_groups_with_pending_reqs' based on the
new counter in patch 2:
  - if the counter(how many bfqqs have pending requests) increased from 0
    to 1, increase 'num_groups_with_pending_reqs'.
  - if the counter is decreased from 1 to 0, decrease
    'num_groups_with_pending_reqs'

> Additional comment: if your changes do not cpus the problem above,
> then this function only invokes __bfq_weights_tree_remove.  So what's
> the point in keeping this function)
> 
If this patchset is applied, there are following cleanup patches to
remove this function.

multiple cleanup patches for bfq:
https://lore.kernel.org/all/20220528095958.270455-1-yukuai3@huawei.com/
>> -
>> -	/*
>> -	 * Next function is invoked last, because it causes bfqq to be
>> -	 * freed if the following holds: bfqq is not in service and
>> -	 * has no dispatched request. DO NOT use bfqq after the next
>> -	 * function invocation.
>> -	 */
> 
> I would really love it if you leave this comment.  I added it after
> suffering a lot for a nasty UAF.  Of course the first sentence may
> need to be adjusted if the code that precedes it is to be removed.
> 
Same as above, if this patch is applied, this function will be gone.

Thanks,
Kuai
> Thanks,
> Paolo
> 
> 
>> 	__bfq_weights_tree_remove(bfqd, bfqq,
>> 				  &bfqd->queue_weights_tree);
>> }
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index de2446a9b7ab..f0fce94583e4 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -496,27 +496,27 @@ struct bfq_data {
>> 	struct rb_root_cached queue_weights_tree;
>>
>> 	/*
>> -	 * Number of groups with at least one descendant process that
>> +	 * Number of groups with at least one process that
>> 	 * has at least one request waiting for completion. Note that
>> 	 * this accounts for also requests already dispatched, but not
>> 	 * yet completed. Therefore this number of groups may differ
>> 	 * (be larger) than the number of active groups, as a group is
>> 	 * considered active only if its corresponding entity has
>> -	 * descendant queues with at least one request queued. This
>> +	 * queues with at least one request queued. This
>> 	 * number is used to decide whether a scenario is symmetric.
>> 	 * For a detailed explanation see comments on the computation
>> 	 * of the variable asymmetric_scenario in the function
>> 	 * bfq_better_to_idle().
>> 	 *
>> 	 * However, it is hard to compute this number exactly, for
>> -	 * groups with multiple descendant processes. Consider a group
>> -	 * that is inactive, i.e., that has no descendant process with
>> +	 * groups with multiple processes. Consider a group
>> +	 * that is inactive, i.e., that has no process with
>> 	 * pending I/O inside BFQ queues. Then suppose that
>> 	 * num_groups_with_pending_reqs is still accounting for this
>> -	 * group, because the group has descendant processes with some
>> +	 * group, because the group has processes with some
>> 	 * I/O request still in flight. num_groups_with_pending_reqs
>> 	 * should be decremented when the in-flight request of the
>> -	 * last descendant process is finally completed (assuming that
>> +	 * last process is finally completed (assuming that
>> 	 * nothing else has changed for the group in the meantime, in
>> 	 * terms of composition of the group and active/inactive state of child
>> 	 * groups and processes). To accomplish this, an additional
>> @@ -525,7 +525,7 @@ struct bfq_data {
>> 	 * we resort to the following tradeoff between simplicity and
>> 	 * accuracy: for an inactive group that is still counted in
>> 	 * num_groups_with_pending_reqs, we decrement
>> -	 * num_groups_with_pending_reqs when the first descendant
>> +	 * num_groups_with_pending_reqs when the first
>> 	 * process of the group remains with no request waiting for
>> 	 * completion.
>> 	 *
>> @@ -533,12 +533,12 @@ struct bfq_data {
>> 	 * carefulness: to avoid multiple decrements, we flag a group,
>> 	 * more precisely an entity representing a group, as still
>> 	 * counted in num_groups_with_pending_reqs when it becomes
>> -	 * inactive. Then, when the first descendant queue of the
>> +	 * inactive. Then, when the first queue of the
>> 	 * entity remains with no request waiting for completion,
>> 	 * num_groups_with_pending_reqs is decremented, and this flag
>> 	 * is reset. After this flag is reset for the entity,
>> 	 * num_groups_with_pending_reqs won't be decremented any
>> -	 * longer in case a new descendant queue of the entity remains
>> +	 * longer in case a new queue of the entity remains
>> 	 * with no request waiting for completion.
>> 	 */
>> 	unsigned int num_groups_with_pending_reqs;
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 6f36f3fe5cc8..9c2842bedf97 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -984,19 +984,6 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>> 		entity->on_st_or_in_serv = true;
>> 	}
>>
>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>> -		struct bfq_group *bfqg =
>> -			container_of(entity, struct bfq_group, entity);
>> -		struct bfq_data *bfqd = bfqg->bfqd;
>> -
>> -		if (!entity->in_groups_with_pending_reqs) {
>> -			entity->in_groups_with_pending_reqs = true;
>> -			bfqd->num_groups_with_pending_reqs++;
>> -		}
>> -	}
>> -#endif
>> -
>> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
>> }
>>
>> @@ -1654,7 +1641,8 @@ void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>> 	if (!entity->in_groups_with_pending_reqs) {
>> 		entity->in_groups_with_pending_reqs = true;
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
>> +		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
>> +			bfqq->bfqd->num_groups_with_pending_reqs++;
>> #endif
>> 	}
>> }
>> @@ -1666,7 +1654,8 @@ void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>> 	if (entity->in_groups_with_pending_reqs) {
>> 		entity->in_groups_with_pending_reqs = false;
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> -		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
>> +		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
>> +			bfqq->bfqd->num_groups_with_pending_reqs--;
>> #endif
>> 	}
>> }
>> -- 
>> 2.31.1
>>
> 
> .
> 

