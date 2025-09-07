Return-Path: <cgroups+bounces-9774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8FB47977
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239683BF09E
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256320E005;
	Sun,  7 Sep 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="ITckcUML"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538C20C001;
	Sun,  7 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757231964; cv=pass; b=J8tlngLTZCb+weUqhIltOORXBolNzohOhiFnpjMgWKQ9Mb/k+Oka1YHzkpyu1ThQJL/JAyaTwd7ZUEVBjpLH7hiWwJn8fBLq/d5oGM4etVA5pS1YWkdZpiQBkJiL+K5Ue1GGf3AoRIPte5r4uKSuJAm8aXDpE6vmLHH8Z/KhORk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757231964; c=relaxed/simple;
	bh=bceuT68gqsDMF4TNyJ22n2FepSM/6gukiJKQSTOnqUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbThZuYJc8ZzLJJ7z8SS9QDIbY7rBUyCd8AJGWQrKNpHzOQEP75dt28WFSXoVkTLJIYWpEwf4BAiql/I/zrd8LkG9RsWhPZXLuKv6hE25jxeUrJBb+07TCd1AiPhc7wklJEoAOSxaNAaMquELX8ptf6snQy4Pzkll3QyWGqG9+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=ITckcUML; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1757231879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AyhSX1nRAoBCgQZytDqP73HE8tPC8zBIQU1NicP0a19bVm/b/voWai6Gsqc2pi4khqVZgWVh+2OSjx8Xtf0+MAWP3Wt7D0XorfPPpKv1o9AbJPrm1bHmDV6HroqGsokkUMeScuOxuFIwV+dwGZmFkGHV9W7y15JnJjG9JrlDd7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757231879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1zL3s3OBirXX73TaUZOE/4KjYhwaz1Ly//egXWV/bgc=; 
	b=KVoaPUbwFi641r5BGI89IPb9wvy/hBD+ybecBzBpaUFUPdERvF5d/Egf94fgjjYNks8NRNYrh9lJBiA5ODdOC9if36IJZc0PHQYAiic3KAwvuejp/1G3qP7cQLxTA9GuFxby9YYedJlkcLpYF3xrHF5lO7zkZU5zlABE2mShMTI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757231879;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1zL3s3OBirXX73TaUZOE/4KjYhwaz1Ly//egXWV/bgc=;
	b=ITckcUMLZFXVhyAg5vbBV0erosb4aKETXrandH1GA+Rqu3ugcg2NHi7+xGNnbLLS
	hYfouJGpyCSLvLm31RPFNzBdoMZq82ZHVaAkjz0bL3IugjZrRir5/jvevm+z38SKtd1
	UkvFfNhNl7FTRIPVVX4z1r/kSODbE6sEAPeGHawo=
Received: by mx.zohomail.com with SMTPS id 1757231875364926.6023354554346;
	Sun, 7 Sep 2025 00:57:55 -0700 (PDT)
Message-ID: <9c763646-f320-4975-ae19-2a40607757b1@yukuai.org.cn>
Date: Sun, 7 Sep 2025 15:57:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 02/16] block: initialize bio issue time in
 blk_mq_submit_bio()
To: kernel test robot <lkp@intel.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, bvanassche@acm.org, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250905070643.2533483-3-yukuai1@huaweicloud.com>
 <202509062332.tqE0Bc8k-lkp@intel.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <202509062332.tqE0Bc8k-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/6 23:27, kernel test robot 写道:
> Hi Yu,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe-block/for-next]
> [also build test ERROR on linus/master v6.17-rc4 next-20250905]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/block-cleanup-bio_issue/20250905-153659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> patch link:    https://lore.kernel.org/r/20250905070643.2533483-3-yukuai1%40huaweicloud.com
> patch subject: [PATCH for-6.18/block 02/16] block: initialize bio issue time in blk_mq_submit_bio()
> config: i386-buildonly-randconfig-003-20250906 (https://download.01.org/0day-ci/archive/20250906/202509062332.tqE0Bc8k-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509062332.tqE0Bc8k-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509062332.tqE0Bc8k-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     block/blk-mq.c: In function 'blk_mq_submit_bio':
>>> block/blk-mq.c:3171:12: error: 'struct bio' has no member named 'issue_time_ns'
>      3171 |         bio->issue_time_ns = blk_time_get_ns();

This should be included inside BLK_CGROUP config, sorry about this.

Thanks,
Kuai

>           |            ^~
>
>
> vim +3171 block/blk-mq.c
>
>    3097	
>    3098	/**
>    3099	 * blk_mq_submit_bio - Create and send a request to block device.
>    3100	 * @bio: Bio pointer.
>    3101	 *
>    3102	 * Builds up a request structure from @q and @bio and send to the device. The
>    3103	 * request may not be queued directly to hardware if:
>    3104	 * * This request can be merged with another one
>    3105	 * * We want to place request at plug queue for possible future merging
>    3106	 * * There is an IO scheduler active at this queue
>    3107	 *
>    3108	 * It will not queue the request if there is an error with the bio, or at the
>    3109	 * request creation.
>    3110	 */
>    3111	void blk_mq_submit_bio(struct bio *bio)
>    3112	{
>    3113		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>    3114		struct blk_plug *plug = current->plug;
>    3115		const int is_sync = op_is_sync(bio->bi_opf);
>    3116		struct blk_mq_hw_ctx *hctx;
>    3117		unsigned int nr_segs;
>    3118		struct request *rq;
>    3119		blk_status_t ret;
>    3120	
>    3121		/*
>    3122		 * If the plug has a cached request for this queue, try to use it.
>    3123		 */
>    3124		rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
>    3125	
>    3126		/*
>    3127		 * A BIO that was released from a zone write plug has already been
>    3128		 * through the preparation in this function, already holds a reference
>    3129		 * on the queue usage counter, and is the only write BIO in-flight for
>    3130		 * the target zone. Go straight to preparing a request for it.
>    3131		 */
>    3132		if (bio_zone_write_plugging(bio)) {
>    3133			nr_segs = bio->__bi_nr_segments;
>    3134			if (rq)
>    3135				blk_queue_exit(q);
>    3136			goto new_request;
>    3137		}
>    3138	
>    3139		/*
>    3140		 * The cached request already holds a q_usage_counter reference and we
>    3141		 * don't have to acquire a new one if we use it.
>    3142		 */
>    3143		if (!rq) {
>    3144			if (unlikely(bio_queue_enter(bio)))
>    3145				return;
>    3146		}
>    3147	
>    3148		/*
>    3149		 * Device reconfiguration may change logical block size or reduce the
>    3150		 * number of poll queues, so the checks for alignment and poll support
>    3151		 * have to be done with queue usage counter held.
>    3152		 */
>    3153		if (unlikely(bio_unaligned(bio, q))) {
>    3154			bio_io_error(bio);
>    3155			goto queue_exit;
>    3156		}
>    3157	
>    3158		if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
>    3159			bio->bi_status = BLK_STS_NOTSUPP;
>    3160			bio_endio(bio);
>    3161			goto queue_exit;
>    3162		}
>    3163	
>    3164		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
>    3165		if (!bio)
>    3166			goto queue_exit;
>    3167	
>    3168		if (!bio_integrity_prep(bio))
>    3169			goto queue_exit;
>    3170	
>> 3171		bio->issue_time_ns = blk_time_get_ns();
>    3172		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
>    3173			goto queue_exit;
>    3174	
>    3175		if (bio_needs_zone_write_plugging(bio)) {
>    3176			if (blk_zone_plug_bio(bio, nr_segs))
>    3177				goto queue_exit;
>    3178		}
>    3179	
>    3180	new_request:
>    3181		if (rq) {
>    3182			blk_mq_use_cached_rq(rq, plug, bio);
>    3183		} else {
>    3184			rq = blk_mq_get_new_requests(q, plug, bio);
>    3185			if (unlikely(!rq)) {
>    3186				if (bio->bi_opf & REQ_NOWAIT)
>    3187					bio_wouldblock_error(bio);
>    3188				goto queue_exit;
>    3189			}
>    3190		}
>    3191	
>    3192		trace_block_getrq(bio);
>    3193	
>    3194		rq_qos_track(q, rq, bio);
>    3195	
>    3196		blk_mq_bio_to_request(rq, bio, nr_segs);
>    3197	
>    3198		ret = blk_crypto_rq_get_keyslot(rq);
>    3199		if (ret != BLK_STS_OK) {
>    3200			bio->bi_status = ret;
>    3201			bio_endio(bio);
>    3202			blk_mq_free_request(rq);
>    3203			return;
>    3204		}
>    3205	
>    3206		if (bio_zone_write_plugging(bio))
>    3207			blk_zone_write_plug_init_request(rq);
>    3208	
>    3209		if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
>    3210			return;
>    3211	
>    3212		if (plug) {
>    3213			blk_add_rq_to_plug(plug, rq);
>    3214			return;
>    3215		}
>    3216	
>    3217		hctx = rq->mq_hctx;
>    3218		if ((rq->rq_flags & RQF_USE_SCHED) ||
>    3219		    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
>    3220			blk_mq_insert_request(rq, 0);
>    3221			blk_mq_run_hw_queue(hctx, true);
>    3222		} else {
>    3223			blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
>    3224		}
>    3225		return;
>    3226	
>    3227	queue_exit:
>    3228		/*
>    3229		 * Don't drop the queue reference if we were trying to use a cached
>    3230		 * request and thus didn't acquire one.
>    3231		 */
>    3232		if (!rq)
>    3233			blk_queue_exit(q);
>    3234	}
>    3235	
>

