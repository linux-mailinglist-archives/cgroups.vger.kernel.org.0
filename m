Return-Path: <cgroups+bounces-17577-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1/8LAkLaTWqe/AEAu9opvQ
	(envelope-from <cgroups+bounces-17577-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:04:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB6721AF5
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:04:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LzRXOEOU;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17577-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17577-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA880302F4C5
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 05:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25533AC0E9;
	Wed,  8 Jul 2026 05:03:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4F4315F
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 05:03:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487018; cv=none; b=moowB4Gp0rSmcDDRR4LDOC4deragTcFgGDQ/TUZYdWlah4yJrCmsU378IW1ylmFomqrctrFfE3YsViP16c25P6NjILKh3p/ES74BvcJ0IyAkZEjNPetBQY50D2tyksRl/R5j+u5mhNEB+dSumUh3MsAHofhxlXc7/6nTZvDy0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487018; c=relaxed/simple;
	bh=ah/c+yX9TUTh1SBTLeq25Y9O0FN9ukQkNiWz3a13amc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FeGSKXM89CFgYd6/rpFeT6V7dQFVL0oJyk9jThekH0FRXqXKVzI/DhJb3pCaeDL4QWWnruuW7JJakeUBbGiQ97wJik3BHTTbNsp1XtZE25DTIWgDQ+iZpfhWedHLLvNeJ3u46KD+nUwq6Sa4PYpfemOgbZeoJDx1hc8KqfADNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzRXOEOU; arc=none smtp.client-ip=95.215.58.176
Message-ID: <f18106a3-e478-4766-8729-0ffb82a48b88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783487004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lis5/r23AOxGEyOaAb4z0Y74O0+HSoATbA6D50gjh4o=;
	b=LzRXOEOUBPcXPAxUBENQKBoua9DGTi9J3CNvzBHjlmA7HsRWomu5z8G+pBHARTl/5oMaWB
	c9OXezIkEUrbHwLxoTsRr0TXAYZh3v8+PE2yjiQ54nqg59UA6Zc3Z/9MTjwVKPTbvw4Gij
	8BCLCKVVaK1N1jHcyLtkO0f80v+1b8g=
Date: Wed, 8 Jul 2026 13:03:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] blk-iolatency: flush enable work after policy
 deactivation
To: Cen Zhang <zzzccc427@gmail.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
References: <20260621135916.2657247-1-zzzccc427@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260621135916.2657247-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17577-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,toxicpanda.com,kernel.dk];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54CB6721AF5



在 2026/6/21 21:59, Cen Zhang 写道:
> A blk-iolatency rq-qos teardown can free struct blk_iolatency while a
> freshly queued enable_work callback still references it. The observed
> failure is:
> 
> blkcg_iolatency_exit() flushes enable_work before deactivating the
> iolatency policy. However, blkcg_deactivate_policy() calls
> iolatency_pd_offline() for online policy data, and iolatency_pd_offline()
> clears min_lat_nsec through iolatency_set_min_lat_nsec(). If this clears
> the last nonzero latency target, enable_cnt reaches zero and schedules
> enable_work again after the flush has already returned.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> blkcg_iolatency_exit() path:          system_wq worker path:
> 1. Flush old enable_work.             1. enable_work is idle.
> 2. Deactivate the policy.             2. no worker owns it.
> 3. Offline queues new enable_work.    3. work item becomes pending.
> 4. Free blkiolat.                     4. worker later runs the item.
> 5. Owner storage is gone.             5. worker dereferences blkiolat.
> 
> Flush enable_work again after blkcg_deactivate_policy() returns and before
> freeing blkiolat. Policy offline callbacks have completed at that point,
> so the second drain covers the late queueing path without changing the
> normal enable/disable accounting rules.
> 

Acked-by: Tao Cui <cuitao@kylinos.cn>

The first flush_work() above blkcg_deactivate_policy() is now redundant
and can be dropped.

> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in assign_work+0x2a/0x150
> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x53/0x70
>  print_report+0xd0/0x630
>  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0xea/0x1a0
>  ? assign_work+0x2a/0x150
>  kasan_report+0xce/0x100
>  ? assign_work+0x2a/0x150
>  assign_work+0x2a/0x150
>  worker_thread+0x1b7/0x500
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x192/0x1d0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2ac/0x3c0
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __switch_to+0x2d5/0x6e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Allocated by task 470:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  iolatency_set_limit+0x301/0x450
>  cgroup_file_write+0x178/0x2e0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 611:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x43/0x70
>  kfree+0x131/0x390
>  rq_qos_exit+0x5d/0x90
>  __del_gendisk+0x394/0x490
>  del_gendisk+0xa1/0xe0
>  virtblk_remove+0x41/0xd0
>  virtio_dev_remove+0x63/0xe0
>  device_release_driver_internal+0x246/0x2e0
>  unbind_store+0xa9/0xb0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60
>  kasan_record_aux_stack+0x8c/0xa0
>  __queue_work+0x42a/0x800
>  queue_work_on+0x5d/0x70
>  iolatency_set_min_lat_nsec+0x196/0x230
>  iolatency_pd_offline+0x1f/0x40
>  blkcg_deactivate_policy+0x194/0x270
>  blkcg_iolatency_exit+0x33/0x40
>  rq_qos_exit+0x5d/0x90
>  __del_gendisk+0x394/0x490
>  del_gendisk+0xa1/0xe0
>  virtblk_remove+0x41/0xd0
>  virtio_dev_remove+0x63/0xe0
>  device_release_driver_internal+0x246/0x2e0
>  unbind_store+0xa9/0xb0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Second to last potentially related work creation:
>  kasan_save_stack+0x33/0x60
>  kasan_record_aux_stack+0x8c/0xa0
>  __queue_work+0x42a/0x800
>  queue_work_on+0x5d/0x70
>  iolatency_set_min_lat_nsec+0x196/0x230
>  iolatency_set_limit+0x3f1/0x450
>  cgroup_file_write+0x178/0x2e0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  block/blk-iolatency.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 1aaee6fb0f59..a0bdd8a5c94c 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -639,6 +639,11 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
>  	timer_shutdown_sync(&blkiolat->timer);
>  	flush_work(&blkiolat->enable_work);
>  	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
> +	/*
> +	 * blkcg_deactivate_policy() invokes iolatency_pd_offline(), which may
> +	 * queue enable_work again when it clears the last latency target.
> +	 */
> +	flush_work(&blkiolat->enable_work);
>  	kfree(blkiolat);
>  }
>  


