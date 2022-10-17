Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA16008A4
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJQI2J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 04:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQI2H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 04:28:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D636DF0;
        Mon, 17 Oct 2022 01:28:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MrVS54shfzKFKd;
        Mon, 17 Oct 2022 16:25:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHiMoREk1jMTWiAQ--.65146S3;
        Mon, 17 Oct 2022 16:28:02 +0800 (CST)
Subject: Re: [PATCH 2/2] block: Make refcnt of bfq_group/bfq_queue atomic
To:     Dawei Li <set_pte_at@outlook.com>, axboe@kernel.dk, tj@kernel.org,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221011145246.8656-1-set_pte_at@outlook.com>
 <TYCP286MB2323F5B27A24ABA2CD1A3F70CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6e6aa502-01d0-d5d8-9193-a3fee2a17335@huaweicloud.com>
Date:   Mon, 17 Oct 2022 16:28:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <TYCP286MB2323F5B27A24ABA2CD1A3F70CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHiMoREk1jMTWiAQ--.65146S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15JrW7WryfJrW7uF17Wrg_yoW3KFWUpa
        y5KayUWa1rJF45Xr4UJw4jvwn3Kr1S93srK34xX343trnxAr9Fq3ZIvw1FvF4SvF1kAr4f
        Zr1jg3yvkr1xXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/10/11 22:52, Dawei Li Ð´µÀ:
> For most implementations of reference count, atomic_t is preferred
> for their natural-born atomic ops capability.
> Change the reference count of bfq_group/bfq_queue, both data structures
> and related ops, into atomic.

I'm afraid that this is unnecessary, the modifications of reference
count are inside spin_lock() in bfq.

Thanks,
Kuai
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   block/bfq-cgroup.c  |  8 +++----
>   block/bfq-iosched.c | 54 +++++++++++++++++++++++----------------------
>   block/bfq-iosched.h |  6 ++---
>   block/bfq-wf2q.c    |  6 ++---
>   4 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 144bca006463..714126ba21b6 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>   
>   static void bfqg_get(struct bfq_group *bfqg)
>   {
> -	bfqg->ref++;
> +	atomic_inc(&bfqg->ref);
>   }
>   
>   static void bfqg_put(struct bfq_group *bfqg)
>   {
> -	bfqg->ref--;
> -
> -	if (bfqg->ref == 0)
> +	if (atomic_dec_and_test(&bfqg->ref))
>   		kfree(bfqg);
>   }
>   
> @@ -659,7 +657,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   	 * Get extra reference to prevent bfqq from being freed in
>   	 * next possible expire or deactivate.
>   	 */
> -	bfqq->ref++;
> +	atomic_inc(&bfqq->ref);
>   
>   	/* If bfqq is empty, then bfq_bfqq_expire also invokes
>   	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..fbe5624be71f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -935,7 +935,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   
>   inc_counter:
>   	bfqq->weight_counter->num_active++;
> -	bfqq->ref++;
> +	atomic_inc(&bfqq->ref);
>   }
>   
>   /*
> @@ -1224,9 +1224,10 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>   
>   static int bfqq_process_refs(struct bfq_queue *bfqq)
>   {
> -	return bfqq->ref - bfqq->entity.allocated -
> +	return atomic_read(&bfqq->ref) - bfqq->entity.allocated -
>   		bfqq->entity.on_st_or_in_serv -
> -		(bfqq->weight_counter != NULL) - bfqq->stable_ref;
> +		(bfqq->weight_counter != NULL) -
> +		atomic_read(&bfqq->stable_ref);
>   }
>   
>   /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
> @@ -2818,7 +2819,7 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
>   	 * expected to be associated with new_bfqq as they happen to
>   	 * issue I/O.
>   	 */
> -	new_bfqq->ref += process_refs;
> +	atomic_add(process_refs, &new_bfqq->ref);
>   	return new_bfqq;
>   }
>   
> @@ -5255,10 +5256,10 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>   	struct hlist_node *n;
>   	struct bfq_group *bfqg = bfqq_group(bfqq);
>   
> -	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
> +	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq,
> +		     atomic_read(&bfqq->ref));
>   
> -	bfqq->ref--;
> -	if (bfqq->ref)
> +	if (!atomic_dec_and_test(&bfqq->ref))
>   		return;
>   
>   	if (!hlist_unhashed(&bfqq->burst_list_node)) {
> @@ -5328,7 +5329,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>   
>   static void bfq_put_stable_ref(struct bfq_queue *bfqq)
>   {
> -	bfqq->stable_ref--;
> +	atomic_dec(&bfqq->stable_ref);
>   	bfq_put_queue(bfqq);
>   }
>   
> @@ -5358,7 +5359,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>   		bfq_schedule_dispatch(bfqd);
>   	}
>   
> -	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
> +	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, atomic_read(&bfqq->ref));
>   
>   	bfq_put_cooperator(bfqq);
>   
> @@ -5507,7 +5508,7 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   	INIT_HLIST_NODE(&bfqq->woken_list_node);
>   	INIT_HLIST_HEAD(&bfqq->woken_list);
>   
> -	bfqq->ref = 0;
> +	atomic_set(&bfqq->ref, 0);
>   	bfqq->bfqd = bfqd;
>   
>   	if (bic)
> @@ -5710,12 +5711,12 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>   			 * to prevent it from being freed,
>   			 * until we decide whether to merge
>   			 */
> -			last_bfqq_created->ref++;
> +			atomic_inc(&last_bfqq_created->ref);
>   			/*
>   			 * need to keep track of stable refs, to
>   			 * compute process refs correctly
>   			 */
> -			last_bfqq_created->stable_ref++;
> +			atomic_inc(&last_bfqq_created->stable_ref);
>   			/*
>   			 * Record the bfqq to merge to.
>   			 */
> @@ -5767,20 +5768,21 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
>   	 * prune it.
>   	 */
>   	if (async_bfqq) {
> -		bfqq->ref++; /*
> -			      * Extra group reference, w.r.t. sync
> -			      * queue. This extra reference is removed
> -			      * only if bfqq->bfqg disappears, to
> -			      * guarantee that this queue is not freed
> -			      * until its group goes away.
> -			      */
> +		atomic_inc(&bfqq->ref);
> +		/*
> +		 * Extra group reference, w.r.t. sync
> +		 * queue. This extra reference is removed
> +		 * only if bfqq->bfqg disappears, to
> +		 * guarantee that this queue is not freed
> +		 * until its group goes away.
> +		 */
>   		bfq_log_bfqq(bfqd, bfqq, "get_queue, bfqq not in async: %p, %d",
> -			     bfqq, bfqq->ref);
> +			     bfqq, atomic_read(&bfqq->ref));
>   		*async_bfqq = bfqq;
>   	}
>   
>   out:
> -	bfqq->ref++; /* get a process reference to this queue */
> +	atomic_inc(&bfqq->ref); /* get a process reference to this queue */
>   
>   	if (bfqq != &bfqd->oom_bfqq && is_sync && !respawn)
>   		bfqq = bfq_do_or_sched_stable_merge(bfqd, bfqq, bic);
> @@ -6059,7 +6061,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
>   		 */
>   		bfqq_request_allocated(new_bfqq);
>   		bfqq_request_freed(bfqq);
> -		new_bfqq->ref++;
> +		atomic_inc(&new_bfqq->ref);
>   		/*
>   		 * If the bic associated with the process
>   		 * issuing this request still points to bfqq
> @@ -6803,10 +6805,10 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>   	}
>   
>   	bfqq_request_allocated(bfqq);
> -	bfqq->ref++;
> +	atomic_inc(&bfqq->ref);
>   	bic->requests++;
>   	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
> -		     rq, bfqq, bfqq->ref);
> +		     rq, bfqq, atomic_read(&bfqq->ref));
>   
>   	rq->elv.priv[0] = bic;
>   	rq->elv.priv[1] = bfqq;
> @@ -6939,7 +6941,7 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
>   		bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
>   
>   		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
> -			     bfqq, bfqq->ref);
> +			     bfqq, atomic_read(&bfqq->ref));
>   		bfq_put_queue(bfqq);
>   		*bfqq_ptr = NULL;
>   	}
> @@ -7092,7 +7094,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>   	 * will not attempt to free it.
>   	 */
>   	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
> -	bfqd->oom_bfqq.ref++;
> +	atomic_inc(&bfqd->oom_bfqq.ref);
>   	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
>   	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
>   	bfqd->oom_bfqq.entity.new_weight =
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 64ee618064ba..71ac0de80bb0 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -234,9 +234,9 @@ struct bfq_ttime {
>    */
>   struct bfq_queue {
>   	/* reference counter */
> -	int ref;
> +	atomic_t ref;
>   	/* counter of references from other queues for delayed stable merge */
> -	int stable_ref;
> +	atomic_t stable_ref;
>   	/* parent bfq_data */
>   	struct bfq_data *bfqd;
>   
> @@ -928,7 +928,7 @@ struct bfq_group {
>   	char blkg_path[128];
>   
>   	/* reference counter (see comments in bfq_bic_update_cgroup) */
> -	int ref;
> +	atomic_t ref;
>   	/* Is bfq_group still online? */
>   	bool online;
>   
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 8fc3da4c23bb..60a9a2c1fc8d 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -512,9 +512,9 @@ static void bfq_get_entity(struct bfq_entity *entity)
>   	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>   
>   	if (bfqq) {
> -		bfqq->ref++;
> +		atomic_inc(&bfqq->ref);
>   		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
> -			     bfqq, bfqq->ref);
> +			     bfqq, atomic_read(&bfqq->ref));
>   	}
>   }
>   
> @@ -1611,7 +1611,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
>   		 * reference to the queue. If this is the case, then
>   		 * bfqq gets freed here.
>   		 */
> -		int ref = in_serv_bfqq->ref;
> +		int ref = atomic_read(&in_serv_bfqq->ref);
>   		bfq_put_queue(in_serv_bfqq);
>   		if (ref == 1)
>   			return true;
> 

