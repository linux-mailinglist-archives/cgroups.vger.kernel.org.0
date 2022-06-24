Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5F558CCE
	for <lists+cgroups@lfdr.de>; Fri, 24 Jun 2022 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiFXB0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFXB0o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 21:26:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872F609F4;
        Thu, 23 Jun 2022 18:26:42 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTfZG4zZ2zkWl1;
        Fri, 24 Jun 2022 09:25:26 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 09:26:40 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 09:26:39 +0800
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jan Kara <jack@suse.cz>, <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <48edcfc1-030d-f78e-ee88-2a9a8cc467ac@huawei.com>
Date:   Fri, 24 Jun 2022 09:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
request is completed.

2) Then, patch 2 add a counter in bfqg: how many bfqqs have pending
requests, which is updated while tracking if bfqq has pending requests.

3) Finally, patch 3 tracks 'num_groups_with_pending_reqs' based on the
new counter in patch 2:
  - if the counter(how many bfqqs have pending requests) increased from 0
    to 0, increase 'num_groups_with_pending_reqs'.
  - if the counter is decreased from 1 to 0, decrease
    'num_groups_with_pending_reqs'

> Additional comment: if your changes do not cpus the problem above,
> then this function only invokes __bfq_weights_tree_remove.  So what's
> the point in keeping this function)

If this patchset is applied, there are following cleanup patches to
remove this function.

multiple cleanup patches for bfq:
https://lore.kernel.org/all/20220528095958.270455-1-yukuai3@huawei.com/
> 
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
