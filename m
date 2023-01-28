Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154B67F8FA
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjA1PLc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 Jan 2023 10:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjA1PLa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 Jan 2023 10:11:30 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041627988
        for <cgroups@vger.kernel.org>; Sat, 28 Jan 2023 07:11:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i65so5125805pfc.0
        for <cgroups@vger.kernel.org>; Sat, 28 Jan 2023 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYAFavlxQFaJhWSxB+w7MwpALqzvK86VNtGnD6AffUs=;
        b=A7xaQz5dHemok/0ttYbrBjrC7bMN6AuElf7lZOsZ6CzdHtggTZRI/zRMQLPpIdI3dX
         P9XlxHrpsneXrWTzR+/TBlt2sphHI+gDEO8qUJRt3ZYz6eVyX7gAbf8FlXx2QQDBmgNX
         VzuAQiEwvuh7jUEVCtPmOfstvNpoNCE5qhUa9lyOWqgQG6PNL59dXZddXoK6P2hSUwwn
         dJK1tVytb7U2F54FknQhST5F2qkGaf+zHT/XOhClLT75cIXBskw6WuBwVStqJt/wu75C
         0h5NE+CJTGBHEhEuQZNzK7KsGlHb3pDcwWHR0T4e5LH0et9yUfdt6olcercDrT14IoLF
         DrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYAFavlxQFaJhWSxB+w7MwpALqzvK86VNtGnD6AffUs=;
        b=dxhiJM77fgHUoufXl5GdgM4e6rRL14VzYJzbV/1GSA287VivBrr65sNEtmspMuVMl0
         8zqie+s+6P2nH67dbb2ZfTMadd4wqXGeTtMNRqglMEJs+/xMk9mKjsZi2EvvCXKccglN
         fC449pOr2FGjAtRnkuuA4zVWSuZMZOY/IYkSCsgpshenGfbXg3EtnWnwNmoIAKA9oH4m
         eyimITJSzcgDPJKWl8pIM8T8JpNYEo2gxJYGvE3pcF7d/WKBBv3a3DuaNLzj1uP+qxpY
         hy6qUtvqGLoPcm7ABOOs4hXyn9mhU73Pae7AwvtFGojg2dRif5o/wI+ATuWZd6Nr10AX
         UrQw==
X-Gm-Message-State: AO0yUKXF0Qwh9uGqm48ciMUeQGZSNcPjtONkIUbze22yr+BWr/qBygIb
        VRIo6QH78VgJMMTv3pRUalK1OQ==
X-Google-Smtp-Source: AK7set90pOtEVLyD4dcvfzZgzRuipb9tAD8OG4+wDIhS1Rai49MW4XoQhUTgh/bCVCEIqegHe3KjnQ==
X-Received: by 2002:aa7:9e51:0:b0:593:40ba:3ee8 with SMTP id z17-20020aa79e51000000b0059340ba3ee8mr4128615pfq.12.1674918682915;
        Sat, 28 Jan 2023 07:11:22 -0800 (PST)
Received: from ?IPV6:2409:8949:3a2b:1a79:8074:917b:21b1:4a3f? ([2409:8949:3a2b:1a79:8074:917b:21b1:4a3f])
        by smtp.gmail.com with ESMTPSA id a194-20020a621acb000000b005939482d9dbsm1338647pfa.101.2023.01.28.07.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 07:11:22 -0800 (PST)
Message-ID: <3140b37c-a2b5-3421-da32-748fc2a54e6f@bytedance.com>
Date:   Sat, 28 Jan 2023 23:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v6] blk-throtl: Introduce sync and async queues for
 blk-throtl
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20230112152549.89298-1-hanjinke.666@bytedance.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230112152549.89298-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi
pinging...

在 2023/1/12 下午11:25, Jinke Han 写道:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> Now we don't distinguish sync write ios from normal buffer write ios
> in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
> until write completion soon after it submit. So it's reasonable for sync
> io to complete as soon as possible.
> 
> In our test, fio writes a 100g file in sequential 4k blocksize in
> a container with low bps limit configured (wbps=10M). More than 1200
> ios were throttled in blk-throtl queue and the avarage throtle time
> of each io is 140s. At the same time, the operation of saving a small
> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
> the sync ios of fsync will be blocked by a huge amount of buffer write
> ios ahead. This is also a priority inversion problem within one cgroup.
> In the database scene, things got really bad with blk-throtle enabled
> as fsync is called very often.
> 
> This patch splits bio queue into sync and async queues for blk-throtl
> and gives a huge priority to sync write ios. Sync queue only make sense
> for write ios as we treat all read io as sync io. I think it's a nice
> respond to the semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO
> gains the same priority as they are important to fs. This may avoid
> some potential priority inversion problems.
> 
> With this patch, do the same test above, the duration of the fsync sent
> by vim drops to several hundreds of milliseconds.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> 
> Changes in v2
> - Make code more simple.
> Changes in v3
> - Fix mismatch of waiting bio and the next dispatched bio.
> - Rename dispatch_sync_cnt to disp_sync_cnt.
> - Add more comments.
> Changes in v4
> - Improve patch in code style and code comments.
> Changes in v5
> - Add more comments for next_to_disp.
> Changes in v6
> - Adjust the comments for next_to_disp.
>    
>   block/blk-throttle.c | 144 ++++++++++++++++++++++++++++++++++++++++---
>   block/blk-throttle.h |  13 +++-
>   2 files changed, 148 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 6fb5a2f9e1ee..966b7ee48fd8 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -21,6 +21,13 @@
>   /* Total max dispatch from all groups in one round */
>   #define THROTL_QUANTUM 32
>   
> +/* For write ios, dispatch 4 sync ios and 1 normal io in one loop */
> +#define THROTL_SYNC_FACTOR 4
> +
> +/* Only make sense for write ios, all read ios are treated as SYNC */
> +#define SYNC	0
> +#define ASYNC	1
> +
>   /* Throttling is performed over a slice and after that slice is renewed */
>   #define DFL_THROTL_SLICE_HD (HZ / 10)
>   #define DFL_THROTL_SLICE_SSD (HZ / 50)
> @@ -241,11 +248,30 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
>   	return bio->bi_iter.bi_size;
>   }
>   
> -static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
> +static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg,
> +			      bool rw)
>   {
>   	INIT_LIST_HEAD(&qn->node);
> -	bio_list_init(&qn->bios);
> +	bio_list_init(&qn->bios[SYNC]);
> +	bio_list_init(&qn->bios[ASYNC]);
>   	qn->tg = tg;
> +	qn->disp_sync_cnt = rw == READ ? UINT_MAX : 0;
> +	qn->next_to_disp = NULL;
> +}
> +
> +static inline void throtl_qnode_add_bio_list(struct throtl_qnode *qn,
> +					     struct bio *bio)
> +{
> +	bool rw = bio_data_dir(bio);
> +
> +	/*
> +	 * All read bios and those write bios with REQ_SYNC, REQ_META or
> +	 * REQ_PRIO flags set are treated as SYNC io.
> +	 */
> +	if (rw == READ || bio->bi_opf & (REQ_SYNC | REQ_META | REQ_PRIO))
> +		bio_list_add(&qn->bios[SYNC], bio);
> +	else
> +		bio_list_add(&qn->bios[ASYNC], bio);
>   }
>   
>   /**
> @@ -261,13 +287,84 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
>   static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
>   				 struct list_head *queued)
>   {
> -	bio_list_add(&qn->bios, bio);
> +	throtl_qnode_add_bio_list(qn, bio);
>   	if (list_empty(&qn->node)) {
>   		list_add_tail(&qn->node, queued);
>   		blkg_get(tg_to_blkg(qn->tg));
>   	}
>   }
>   
> +/**
> + * throtl_qnode_bio_list_pop: pop a bio from sync/async queue
> + * @qn: the qnode to pop a bio from
> + *
> + * For writes, target SYNC or ASYNC queue based on disp_sync_cnt. If empty,
> + * try the other queue.
> + */
> +static struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn)
> +{
> +	struct bio *bio;
> +	int from = qn->disp_sync_cnt == THROTL_SYNC_FACTOR ? ASYNC : SYNC;
> +
> +	bio = bio_list_pop(&qn->bios[from]);
> +	if (!bio) {
> +		from = 1 - from;
> +		bio = bio_list_pop(&qn->bios[from]);
> +	}
> +
> +	if (qn->disp_sync_cnt < THROTL_SYNC_FACTOR && from == SYNC)
> +		qn->disp_sync_cnt++;
> +	else
> +		qn->disp_sync_cnt = 0;
> +
> +	return bio;
> +}
> +
> +/**
> + * throtl_qnode_bio_peek - peek a bio from a qn
> + * @qn: the qnode to peek from
> + *
> + * For read, always peek bio from the SYNC queue.
> + *
> + * For write, we first peek bio from next_to_disp. If it's NULL, a bio
> + * will be popped from SYNC or ASYNC queue to fill it. The next_to_disp
> + * is used to make sure that the previously bio and the next popped bio
> + * are always the same even in case that the spin lock of queue was
> + * released and re-grabbed. Consider the following situation:
> + *
> + * Assume that there are only bios queued in ASYNC queue and the SYNC
> + * queue is empty and all ASYNC bios are 1M in size and the bps limit is
> + * 1M/s. The throtl_slice is 100ms. The current slice is [jiffies1,
> + * jiffies1+100] and the bytes_disp[w] is 0.
> + *
> + * The disp_sync_cnt is 0 as it was set 0 after each dispatching of a
> + * ASYNC bio. A ASYNC bio wil be peeked to check in tg_may_dispatch.
> + * Obviously, it can't be dispatched in current slice and the wait time
> + * is 1000ms. The slice will be extended to [jiffies1, jiffies1+1000] in
> + * tg_may_dispatch. The queue lock is released and a 4k SYNC bio gets
> + * queued during the 1000ms wait. After 1000ms, it's time to dispatch the
> + * tg, the SYNC bio will be popped to dispatched as the disp_sync_cnt is 0
> + * and the SYNC queue is no-empty. The slice will be extended to [jiffies1,
> + * jiffies1+1100] in tg_may_dispatch. Then the slice will be trimed to
> + * [jiffies1+1000, jiffies1+1100] after the SYNC bio was dispatched. This
> + * means that only 4k size was dispatched in last 1000ms and the budget for
> + * this 1000ms has be voided immediately with the trim. If this happens
> + * often, it is hard to fill up the bandwidth considering that the bps
> + * limit is 1M/s.
> + */
> +static inline struct bio *throtl_qnode_bio_peek(struct throtl_qnode *qn)
> +{
> +	/* qn for read ios */
> +	if (qn->disp_sync_cnt == UINT_MAX)
> +		return bio_list_peek(&qn->bios[SYNC]);
> +
> +	/* qn for write ios */
> +	if (!qn->next_to_disp)
> +		qn->next_to_disp  = throtl_qnode_bio_list_pop(qn);
> +
> +	return qn->next_to_disp;
> +}
> +
>   /**
>    * throtl_peek_queued - peek the first bio on a qnode list
>    * @queued: the qnode list to peek
> @@ -281,11 +378,42 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>   		return NULL;
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
> -	bio = bio_list_peek(&qn->bios);
> +	bio = throtl_qnode_bio_peek(qn);
>   	WARN_ON_ONCE(!bio);
>   	return bio;
>   }
>   
> +/**
> + * throtl_qnode_bio_pop: pop a bio from a qnode
> + * @qn: the qnode to pop a bio from
> + */
> +static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
> +{
> +	struct bio *bio;
> +
> +	/* qn for read ios */
> +	if (qn->disp_sync_cnt == UINT_MAX)
> +		return bio_list_pop(&qn->bios[SYNC]);
> +
> +	/* qn for write ios */
> +	if (qn->next_to_disp) {
> +		bio = qn->next_to_disp;
> +		qn->next_to_disp = NULL;
> +		return bio;
> +	}
> +
> +	return throtl_qnode_bio_list_pop(qn);
> +}
> +
> +static inline bool throtl_qnode_empty(struct throtl_qnode *qn)
> +{
> +	if (!qn->next_to_disp &&
> +	    bio_list_empty(&qn->bios[SYNC]) &&
> +			   bio_list_empty(&qn->bios[ASYNC]))
> +		return true;
> +	return false;
> +}
> +
>   /**
>    * throtl_pop_queued - pop the first bio form a qnode list
>    * @queued: the qnode list to pop a bio from
> @@ -310,10 +438,10 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
>   		return NULL;
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
> -	bio = bio_list_pop(&qn->bios);
> +	bio = throtl_qnode_bio_pop(qn);
>   	WARN_ON_ONCE(!bio);
>   
> -	if (bio_list_empty(&qn->bios)) {
> +	if (throtl_qnode_empty(qn)) {
>   		list_del_init(&qn->node);
>   		if (tg_to_put)
>   			*tg_to_put = qn->tg;
> @@ -355,8 +483,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp,
>   	throtl_service_queue_init(&tg->service_queue);
>   
>   	for (rw = READ; rw <= WRITE; rw++) {
> -		throtl_qnode_init(&tg->qnode_on_self[rw], tg);
> -		throtl_qnode_init(&tg->qnode_on_parent[rw], tg);
> +		throtl_qnode_init(&tg->qnode_on_self[rw], tg, rw);
> +		throtl_qnode_init(&tg->qnode_on_parent[rw], tg, rw);
>   	}
>   
>   	RB_CLEAR_NODE(&tg->rb_node);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index ef4b7a4de987..bd4fff65b6d9 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -28,8 +28,19 @@
>    */
>   struct throtl_qnode {
>   	struct list_head	node;		/* service_queue->queued[] */
> -	struct bio_list		bios;		/* queued bios */
> +	struct bio_list		bios[2];	/* queued bios */
>   	struct throtl_grp	*tg;		/* tg this qnode belongs to */
> +
> +	struct bio		*next_to_disp;	/* pinned for next to dispatch */
> +	/*
> +	 * 1) for write throtl_qnode:
> +	 * [0, THROTL_SYNC_FACTOR-1]: dispatch sync io
> +	 * [THROTL_SYNC_FACTOR]: dispatch async io
> +	 *
> +	 * 2) for read throtl_qnode:
> +	 * UINT_MAX
> +	 */
> +	unsigned int disp_sync_cnt;         /* sync io dispatch counter */
>   };
>   
>   struct throtl_service_queue {
