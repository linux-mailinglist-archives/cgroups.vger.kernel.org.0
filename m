Return-Path: <cgroups+bounces-4690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B013896BB4B
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6692B2814DD
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1C1D5894;
	Wed,  4 Sep 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPKFqhI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPL6vdw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPKFqhI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPL6vdw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8F1D47CC;
	Wed,  4 Sep 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450717; cv=none; b=RGsKBliAdrDLeGOOjHUGaaXF3kXNQn+t+4U7vF5pv55WO0+7k+tRwxSbIc/YtiXYO9kni9xW2WrkYVzgU6SPSC5/f9SwhYngazK0iNpI0SUm2KRAGH/9cxvGQFJsfimQUQ+E7v5SikOHbZkjx+GAZYTG8HVO4GdA0o0l0Lp1guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450717; c=relaxed/simple;
	bh=BS0C6V1TPRpS++Us+az3PSmRcgheodjctMNwqzAz2tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYR8XoNRtwIllBYFBkr0LvCwq8NhES/j5gYdLWwCiqGgsNL+eqUC8rkQvQiPq0xxrUTiHnADpX4FxpicsqWKdBkFPM6L9B4oQxhjUvIofA1x2yO429pazYXYLcYNA5EMCB6wgNMzV9RGbEAfLaMtID8wq6nLJ28fe9h1Gx+eC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPKFqhI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPL6vdw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPKFqhI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPL6vdw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A62EE21211;
	Wed,  4 Sep 2024 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725450712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbPfZepknqMSgHZzyQWxxpz8e0QOwNQWM8aSi7zGGjE=;
	b=KVPKFqhINV3lR+7TxR9q556eQT7tYmOsX4hKE0R7jrgJV7vuh0STMNs8hdH34iJvx1EY5L
	X5GJ/Ld5YT7jkJi8MSs++NRek8SXPkzRB331nCJAcpXIp+v4r6b5xz5aKzIa98RuVBNXfL
	CKKYbODQ2tTO+o9tTEgkjNx80wNjykg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725450712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbPfZepknqMSgHZzyQWxxpz8e0QOwNQWM8aSi7zGGjE=;
	b=KVPL6vdw80arQl5Ph+58cMsN/xMegDLBUj2DRHnPS/kKBU9QBVFe7E+3jSUrv4eABvvpaT
	ouc/pCA87H4d2ODw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KVPKFqhI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KVPL6vdw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725450712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbPfZepknqMSgHZzyQWxxpz8e0QOwNQWM8aSi7zGGjE=;
	b=KVPKFqhINV3lR+7TxR9q556eQT7tYmOsX4hKE0R7jrgJV7vuh0STMNs8hdH34iJvx1EY5L
	X5GJ/Ld5YT7jkJi8MSs++NRek8SXPkzRB331nCJAcpXIp+v4r6b5xz5aKzIa98RuVBNXfL
	CKKYbODQ2tTO+o9tTEgkjNx80wNjykg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725450712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbPfZepknqMSgHZzyQWxxpz8e0QOwNQWM8aSi7zGGjE=;
	b=KVPL6vdw80arQl5Ph+58cMsN/xMegDLBUj2DRHnPS/kKBU9QBVFe7E+3jSUrv4eABvvpaT
	ouc/pCA87H4d2ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E206139D2;
	Wed,  4 Sep 2024 11:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OkBhIthJ2GYNRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 11:51:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A1F2A0968; Wed,  4 Sep 2024 13:51:48 +0200 (CEST)
Date: Wed, 4 Sep 2024 13:51:48 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	paolo.valente@unimore.it, mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 1/4] block, bfq: fix possible UAF for bfqq->bic
 with merge chain
Message-ID: <20240904115148.ed46quqe7bavjeei@quack3>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <20240902130329.3787024-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902130329.3787024-2-yukuai1@huaweicloud.com>
X-Rspamd-Queue-Id: A62EE21211
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,toxicpanda.com,kernel.dk,unimore.it,gmail.com,vger.kernel.org,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 02-09-24 21:03:26, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 1) initial state, three tasks:
> 
> 		Process 1       Process 2	Process 3
> 		 (BIC1)          (BIC2)		 (BIC3)
> 		  |  Λ            |  Λ		  |  Λ
> 		  |  |            |  |		  |  |
> 		  V  |            V  |		  V  |
> 		  bfqq1           bfqq2		  bfqq3
> process ref:	   1		    1		    1
> 
> 2) bfqq1 merged to bfqq2:
> 
> 		Process 1       Process 2	Process 3
> 		 (BIC1)          (BIC2)		 (BIC3)
> 		  |               |		  |  Λ
> 		  \--------------\|		  |  |
> 		                  V		  V  |
> 		  bfqq1--------->bfqq2		  bfqq3
> process ref:	   0		    2		    1
> 
> 3) bfqq2 merged to bfqq3:
> 
> 		Process 1       Process 2	Process 3
> 		 (BIC1)          (BIC2)		 (BIC3)
> 	 here -> Λ                |		  |
> 		  \--------------\ \-------------\|
> 		                  V		  V
> 		  bfqq1--------->bfqq2---------->bfqq3
> process ref:	   0		    1		    3
> 
> In this case, IO from Process 1 will get bfqq2 from BIC1 first, and then
> get bfqq3 through merge chain, and finially handle IO by bfqq3.
> Howerver, current code will think bfqq2 is owned by BIC1, like initial
> state, and set bfqq2->bic to BIC1.
> 
> bfq_insert_request
> -> by Process 1
>  bfqq = bfq_init_rq(rq)
>   bfqq = bfq_get_bfqq_handle_split
>    bfqq = bic_to_bfqq
>    -> get bfqq2 from BIC1
>  bfqq->ref++
>  rq->elv.priv[0] = bic
>  rq->elv.priv[1] = bfqq
>  if (bfqq_process_refs(bfqq) == 1)
>   bfqq->bic = bic
>   -> record BIC1 to bfqq2
> 
>   __bfq_insert_request
>    new_bfqq = bfq_setup_cooperator
>    -> get bfqq3 from bfqq2->new_bfqq
>    bfqq_request_freed(bfqq)
>    new_bfqq->ref++
>    rq->elv.priv[1] = new_bfqq
>    -> handle IO by bfqq3
> 
> Fix the problem by checking bfqq is from merge chain fist. And this
> might fix a following problem reported by our syzkaller(unreproducible):
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in bfq_do_early_stable_merge block/bfq-iosched.c:5692 [inline]
> BUG: KASAN: slab-use-after-free in bfq_do_or_sched_stable_merge block/bfq-iosched.c:5805 [inline]
> BUG: KASAN: slab-use-after-free in bfq_get_queue+0x25b0/0x2610 block/bfq-iosched.c:5889
> Write of size 1 at addr ffff888123839eb8 by task kworker/0:1H/18595
> 
> CPU: 0 PID: 18595 Comm: kworker/0:1H Tainted: G             L     6.6.0-07439-gba2303cacfda #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Workqueue: kblockd blk_mq_requeue_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0x10d/0x610 mm/kasan/report.c:475
>  kasan_report+0x8e/0xc0 mm/kasan/report.c:588
>  bfq_do_early_stable_merge block/bfq-iosched.c:5692 [inline]
>  bfq_do_or_sched_stable_merge block/bfq-iosched.c:5805 [inline]
>  bfq_get_queue+0x25b0/0x2610 block/bfq-iosched.c:5889
>  bfq_get_bfqq_handle_split+0x169/0x5d0 block/bfq-iosched.c:6757
>  bfq_init_rq block/bfq-iosched.c:6876 [inline]
>  bfq_insert_request block/bfq-iosched.c:6254 [inline]
>  bfq_insert_requests+0x1112/0x5cf0 block/bfq-iosched.c:6304
>  blk_mq_insert_request+0x290/0x8d0 block/blk-mq.c:2593
>  blk_mq_requeue_work+0x6bc/0xa70 block/blk-mq.c:1502
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
>  worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
>  kthread+0x33c/0x440 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305
>  </TASK>
> 
> Allocated by task 20776:
>  kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:763 [inline]
>  slab_alloc_node mm/slub.c:3458 [inline]
>  kmem_cache_alloc_node+0x1a4/0x6f0 mm/slub.c:3503
>  ioc_create_icq block/blk-ioc.c:370 [inline]
>  ioc_find_get_icq+0x180/0xaa0 block/blk-ioc.c:436
>  bfq_prepare_request+0x39/0xf0 block/bfq-iosched.c:6812
>  blk_mq_rq_ctx_init.isra.7+0x6ac/0xa00 block/blk-mq.c:403
>  __blk_mq_alloc_requests+0xcc0/0x1070 block/blk-mq.c:517
>  blk_mq_get_new_requests block/blk-mq.c:2940 [inline]
>  blk_mq_submit_bio+0x624/0x27c0 block/blk-mq.c:3042
>  __submit_bio+0x331/0x6f0 block/blk-core.c:624
>  __submit_bio_noacct_mq block/blk-core.c:703 [inline]
>  submit_bio_noacct_nocheck+0x816/0xb40 block/blk-core.c:732
>  submit_bio_noacct+0x7a6/0x1b50 block/blk-core.c:826
>  xlog_write_iclog+0x7d5/0xa00 fs/xfs/xfs_log.c:1958
>  xlog_state_release_iclog+0x3b8/0x720 fs/xfs/xfs_log.c:619
>  xlog_cil_push_work+0x19c5/0x2270 fs/xfs/xfs_log_cil.c:1330
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
>  worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
>  kthread+0x33c/0x440 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305
> 
> Freed by task 946:
>  kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  __kasan_slab_free+0x12c/0x1c0 mm/kasan/common.c:244
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1815 [inline]
>  slab_free_freelist_hook mm/slub.c:1841 [inline]
>  slab_free mm/slub.c:3786 [inline]
>  kmem_cache_free+0x118/0x6f0 mm/slub.c:3808
>  rcu_do_batch+0x35c/0xe30 kernel/rcu/tree.c:2189
>  rcu_core+0x819/0xd90 kernel/rcu/tree.c:2462
>  __do_softirq+0x1b0/0x7a2 kernel/softirq.c:553
> 
> Last potentially related work creation:
>  kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:492
>  __call_rcu_common kernel/rcu/tree.c:2712 [inline]
>  call_rcu+0xce/0x1020 kernel/rcu/tree.c:2826
>  ioc_destroy_icq+0x54c/0x830 block/blk-ioc.c:105
>  ioc_release_fn+0xf0/0x360 block/blk-ioc.c:124
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
>  worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
>  kthread+0x33c/0x440 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305
> 
> Second to last potentially related work creation:
>  kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:492
>  __call_rcu_common kernel/rcu/tree.c:2712 [inline]
>  call_rcu+0xce/0x1020 kernel/rcu/tree.c:2826
>  ioc_destroy_icq+0x54c/0x830 block/blk-ioc.c:105
>  ioc_release_fn+0xf0/0x360 block/blk-ioc.c:124
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x432/0x13f0 kernel/workqueue.c:2700
>  worker_thread+0x6f2/0x1160 kernel/workqueue.c:2781
>  kthread+0x33c/0x440 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:305
> 
> The buggy address belongs to the object at ffff888123839d68
>  which belongs to the cache bfq_io_cq of size 1360
> The buggy address is located 336 bytes inside of
>  freed 1360-byte region [ffff888123839d68, ffff88812383a2b8)
> 
> The buggy address belongs to the physical page:
> page:ffffea00048e0e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88812383f588 pfn:0x123838
> head:ffffea00048e0e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x17ffffc0000a40(workingset|slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> page_type: 0xffffffff()
> raw: 0017ffffc0000a40 ffff88810588c200 ffffea00048ffa10 ffff888105889488
> raw: ffff88812383f588 0000000000150006 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff888123839d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888123839e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888123839e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                         ^
>  ffff888123839f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888123839f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Fixes: 36eca8948323 ("block, bfq: add Early Queue Merge (EQM)")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 36a4998c4b37..83adac3e71db 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6934,7 +6934,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	 * addition, if the queue has also just been split, we have to
>  	 * resume its state.
>  	 */
> -	if (likely(bfqq != &bfqd->oom_bfqq) && bfqq_process_refs(bfqq) == 1) {
> +	if (likely(bfqq != &bfqd->oom_bfqq) && !bfqq->new_bfqq &&
> +	    bfqq_process_refs(bfqq) == 1) {
>  		bfqq->bic = bic;
>  		if (split) {
>  			/*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

