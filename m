Return-Path: <cgroups+bounces-9771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC342B47209
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3651BC2DA1
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14F221DA5;
	Sat,  6 Sep 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWrJe8WR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116A1FF7C8;
	Sat,  6 Sep 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172485; cv=none; b=sEfOPlnkb08Ar+Lob1dPFRh41cyOk4RQJPii+q1tX9bBbYZAmI77EkobbmEF2AXB0ueeTwb4hZsJiq0XV97VSilnzSjz/tpydRKK9l0fsLX6OZ2itcg23wegZchxQoJeobK+7/DjTHH+OkU1bAO+sl6KFnyAUC6Km6rQLPS4qZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172485; c=relaxed/simple;
	bh=Fd+f0h7u71k8ta1mGTmB0yEZENuQafdk6dSDxEsjevU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu4T8k53GpfrFJGyrdjWG+kEXk2zIkE56Y6PYkFzxzCCsoYWRVUhb01LXY7wyqnwQHDbj7FOT9P6MAuM/XU90v/n33TT4tK3dU5+OPPvw03H+FSHWqUzlrcV8lXSmyyrhA4nAckwaof2mm+dV7pKOBGmtdItA2uK8DZEU/OAlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWrJe8WR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757172483; x=1788708483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fd+f0h7u71k8ta1mGTmB0yEZENuQafdk6dSDxEsjevU=;
  b=iWrJe8WRaLdfJTi8G7SYRVqZJUkJ+AZzdcTifXSxprAMAT32qV2tsqYz
   VgmDvgI3Lq7kBSNDKla4oHzDbWBPEEfR1r1VeNHeI62KYYUqJI4AX6RyW
   59nLf9sDZbjh8JWeEl++W1r6hx20B/HkiCdsDkBq6nAhnEcOtCAd5TsYA
   mt49Irzr/01PYy2/B++Wd+gYq11pB6giiXDTnH3Pxp/vsHCUnQNxqZ0V2
   DVDdOxF+vQidsEOGV4kGwXBydXWTEvsqD4JD9r6gu9IrIfu4xA0jGzu1T
   C5dkdKwjDB5cuRungYUmX+jRxImVSh4srZXdR4w+ceekp49Cqri8s5wNu
   Q==;
X-CSE-ConnectionGUID: /sDpFxNyRNWqtRU9PT18Tg==
X-CSE-MsgGUID: m3Ez7pgJTbucsgI05mDkGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="76951434"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="76951434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 08:28:02 -0700
X-CSE-ConnectionGUID: tKpXEcEASZysj9NeJPBqNg==
X-CSE-MsgGUID: 1FVE4y2MRkyIMk6rrBiwfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="176480242"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Sep 2025 08:27:55 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuupV-0001Zn-1S;
	Sat, 06 Sep 2025 15:27:53 +0000
Date: Sat, 6 Sep 2025 23:27:39 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
	hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com,
	bvanassche@acm.org, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
	satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
	akpm@linux-foundation.org, neil@brown.name
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH for-6.18/block 02/16] block: initialize bio issue time in
 blk_mq_submit_bio()
Message-ID: <202509062332.tqE0Bc8k-lkp@intel.com>
References: <20250905070643.2533483-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-3-yukuai1@huaweicloud.com>

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/block-cleanup-bio_issue/20250905-153659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250905070643.2533483-3-yukuai1%40huaweicloud.com
patch subject: [PATCH for-6.18/block 02/16] block: initialize bio issue time in blk_mq_submit_bio()
config: i386-buildonly-randconfig-003-20250906 (https://download.01.org/0day-ci/archive/20250906/202509062332.tqE0Bc8k-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509062332.tqE0Bc8k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509062332.tqE0Bc8k-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-mq.c: In function 'blk_mq_submit_bio':
>> block/blk-mq.c:3171:12: error: 'struct bio' has no member named 'issue_time_ns'
    3171 |         bio->issue_time_ns = blk_time_get_ns();
         |            ^~


vim +3171 block/blk-mq.c

  3097	
  3098	/**
  3099	 * blk_mq_submit_bio - Create and send a request to block device.
  3100	 * @bio: Bio pointer.
  3101	 *
  3102	 * Builds up a request structure from @q and @bio and send to the device. The
  3103	 * request may not be queued directly to hardware if:
  3104	 * * This request can be merged with another one
  3105	 * * We want to place request at plug queue for possible future merging
  3106	 * * There is an IO scheduler active at this queue
  3107	 *
  3108	 * It will not queue the request if there is an error with the bio, or at the
  3109	 * request creation.
  3110	 */
  3111	void blk_mq_submit_bio(struct bio *bio)
  3112	{
  3113		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
  3114		struct blk_plug *plug = current->plug;
  3115		const int is_sync = op_is_sync(bio->bi_opf);
  3116		struct blk_mq_hw_ctx *hctx;
  3117		unsigned int nr_segs;
  3118		struct request *rq;
  3119		blk_status_t ret;
  3120	
  3121		/*
  3122		 * If the plug has a cached request for this queue, try to use it.
  3123		 */
  3124		rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
  3125	
  3126		/*
  3127		 * A BIO that was released from a zone write plug has already been
  3128		 * through the preparation in this function, already holds a reference
  3129		 * on the queue usage counter, and is the only write BIO in-flight for
  3130		 * the target zone. Go straight to preparing a request for it.
  3131		 */
  3132		if (bio_zone_write_plugging(bio)) {
  3133			nr_segs = bio->__bi_nr_segments;
  3134			if (rq)
  3135				blk_queue_exit(q);
  3136			goto new_request;
  3137		}
  3138	
  3139		/*
  3140		 * The cached request already holds a q_usage_counter reference and we
  3141		 * don't have to acquire a new one if we use it.
  3142		 */
  3143		if (!rq) {
  3144			if (unlikely(bio_queue_enter(bio)))
  3145				return;
  3146		}
  3147	
  3148		/*
  3149		 * Device reconfiguration may change logical block size or reduce the
  3150		 * number of poll queues, so the checks for alignment and poll support
  3151		 * have to be done with queue usage counter held.
  3152		 */
  3153		if (unlikely(bio_unaligned(bio, q))) {
  3154			bio_io_error(bio);
  3155			goto queue_exit;
  3156		}
  3157	
  3158		if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
  3159			bio->bi_status = BLK_STS_NOTSUPP;
  3160			bio_endio(bio);
  3161			goto queue_exit;
  3162		}
  3163	
  3164		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
  3165		if (!bio)
  3166			goto queue_exit;
  3167	
  3168		if (!bio_integrity_prep(bio))
  3169			goto queue_exit;
  3170	
> 3171		bio->issue_time_ns = blk_time_get_ns();
  3172		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
  3173			goto queue_exit;
  3174	
  3175		if (bio_needs_zone_write_plugging(bio)) {
  3176			if (blk_zone_plug_bio(bio, nr_segs))
  3177				goto queue_exit;
  3178		}
  3179	
  3180	new_request:
  3181		if (rq) {
  3182			blk_mq_use_cached_rq(rq, plug, bio);
  3183		} else {
  3184			rq = blk_mq_get_new_requests(q, plug, bio);
  3185			if (unlikely(!rq)) {
  3186				if (bio->bi_opf & REQ_NOWAIT)
  3187					bio_wouldblock_error(bio);
  3188				goto queue_exit;
  3189			}
  3190		}
  3191	
  3192		trace_block_getrq(bio);
  3193	
  3194		rq_qos_track(q, rq, bio);
  3195	
  3196		blk_mq_bio_to_request(rq, bio, nr_segs);
  3197	
  3198		ret = blk_crypto_rq_get_keyslot(rq);
  3199		if (ret != BLK_STS_OK) {
  3200			bio->bi_status = ret;
  3201			bio_endio(bio);
  3202			blk_mq_free_request(rq);
  3203			return;
  3204		}
  3205	
  3206		if (bio_zone_write_plugging(bio))
  3207			blk_zone_write_plug_init_request(rq);
  3208	
  3209		if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
  3210			return;
  3211	
  3212		if (plug) {
  3213			blk_add_rq_to_plug(plug, rq);
  3214			return;
  3215		}
  3216	
  3217		hctx = rq->mq_hctx;
  3218		if ((rq->rq_flags & RQF_USE_SCHED) ||
  3219		    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
  3220			blk_mq_insert_request(rq, 0);
  3221			blk_mq_run_hw_queue(hctx, true);
  3222		} else {
  3223			blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
  3224		}
  3225		return;
  3226	
  3227	queue_exit:
  3228		/*
  3229		 * Don't drop the queue reference if we were trying to use a cached
  3230		 * request and thus didn't acquire one.
  3231		 */
  3232		if (!rq)
  3233			blk_queue_exit(q);
  3234	}
  3235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

