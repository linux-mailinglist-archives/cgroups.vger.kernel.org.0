Return-Path: <cgroups+bounces-17213-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G65XK0F5O2rMYQgAu9opvQ
	(envelope-from <cgroups+bounces-17213-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:29:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7F6BBC4A
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:29:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=QPiH0Tzh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17213-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17213-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82F77301585C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9803876CC;
	Wed, 24 Jun 2026 06:29:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lf-2-18.ptr.blmpb.com (lf-2-18.ptr.blmpb.com [101.36.218.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5933093B8
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 06:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282559; cv=none; b=lPRBINTAXuR/z8sKJLEc8lwDYh3YKPZm2XgA/n9Ytc6jB4qouyy5baSV1vDpm0A8nxxNKc9zU0FIQkUD14mU74fW5DqT2X8a7AEevXr7QcQe7C7Q9olh6yCPWL/7QzZmHda7u1afJpWxJUrGI0sTyO6qcYNljKgyXOXhaNRbRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282559; c=relaxed/simple;
	bh=7LyTmqqXy9qBFJ32IMbilP0ntUk3PLjNFMxAje/mx8k=;
	h=Cc:Message-Id:References:To:From:Subject:Date:Content-Type:
	 Mime-Version:In-Reply-To; b=riGzXF6l7d8SLOyv+g7G5b9hVF3rzrZZal2WE8u0iHouo//Uz+RoywHPdq8Zw/mj7+8E+rFDvHdn7s/FVZZGnPATVxTXjRk1hBeRMYA1eq8kbhf464YPP/VtQvWpkQdUB6kqvi8/RwKY+dmBMJkviaAgk6ok8+wxuxbojoIgpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=QPiH0Tzh; arc=none smtp.client-ip=101.36.218.18
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782282503;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=GsY9EQEU+gDMLFqCZhSaR8i/2KuctQWb6BdP2GDgBGg=;
 b=QPiH0TzhLwzJgscm6KrMra5lGszhcx56xQd3vG/2Cklkz8UGnrGIpZIUbtGvQaqR8Ux49l
 uE8i30DO8HS5XTaNRht80RHj8hdEJqwzVxRunkWbkrV01WcxUXmmk4M9eZhwyaHhFhz5Rm
 kdNGI+FCyWGLGog+HeAVh05m1XzIczQC8J3gvDRaOX5nbQ6OyVbQ230L6kGtJTxvW+I0fR
 bA4XD6osQDpq/JMczI9V1Iagv10BYgGRxeYki3p2+GcQvaDEZwcWrBu79Dr4WWNfpVO/Rb
 FXCobXElUgcI/adtD89rfwzgSfc+b7ADC3nQlw5OyYPu0QTRdot0AehEpBIahQ==
Cc: <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <baijiaju1990@gmail.com>, 
	<yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a3b7907+5726f0+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Message-Id: <9f26fb06-f749-4db1-a975-19187b87a901@fygo.io>
References: <20260621135930.2657810-1-zzzccc427@gmail.com>
To: "Cen Zhang" <zzzccc427@gmail.com>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>, 
	"Arianna Avanzini" <avanzini.arianna@gmail.com>, 
	"Paolo Valente" <paolo.valente@linaro.org>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH] block, bfq: protect async queue reset with blkcg locks
Date: Wed, 24 Jun 2026 14:28:17 +0800
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260621135930.2657810-1-zzzccc427@gmail.com>
Received: from [192.168.1.104] ([39.182.0.148]) by smtp.larksuite.com with ESMTPS; Wed, 24 Jun 2026 06:28:22 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17213-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,toxicpanda.com,kernel.dk,linaro.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,fygo.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:yukuai@fygo.io,m:zzzccc427@gmail.com,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:avanzini.arianna@gmail.com,m:paolo.valente@linaro.org,m:avanziniarianna@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fygo.io:replyto,fygo.io:mid,fygo.io:from_mime,fygo-io.20200929.dkim.larksuite.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37F7F6BBC4A

Hi,

=E5=9C=A8 2026/6/21 21:59, Cen Zhang =E5=86=99=E9=81=93:
> Writing 0 to BFQ's low_latency attribute ends weight raising for active,
> idle and async queues. The async cgroup path walks q->blkg_list, converts
> each blkg to BFQ policy data and then reads bfqg->async_bfqq and
> bfqg->async_idle_bfqq.
>
> That walk was protected only by bfqd->lock. blkcg release work is
> serialized by q->blkcg_mutex and q->queue_lock instead, and
> blkg_free_workfn() can call BFQ's pd_free_fn before it removes
> blkg->q_node from q->blkg_list. A low_latency reset can therefore still
> find the blkg on the queue list after the BFQ policy data has been freed.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> BFQ low_latency reset:              blkcg blkg release work:
> 1. bfq_low_latency_store()          1. blkg_free_workfn() takes
>     calls bfq_end_wr().                 q->blkcg_mutex.
> 2. bfq_end_wr_async() walks         2. BFQ pd_free_fn drops the
>     q->blkg_list.                       final bfq_group reference.
> 3. blkg_to_bfqg() returns           3. blkg->q_node remains on
>     the stale policy data.              q->blkg_list until list_del_init(=
).
> 4. bfq_end_wr_async_queues()
>     reads async queue fields.
>
> Fix this by taking q->blkcg_mutex and q->queue_lock around the
> q->blkg_list walk, then taking bfqd->lock before touching BFQ async
> queues. The mutex serializes against policy-data free and queue_lock
> stabilizes the list. Move the async reset out of bfq_end_wr()'s existing
> bfqd->lock critical section so the lock order matches blkcg policy
> callbacks.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in bfq_end_wr_async_queues+0x246/0x340
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x66/0xa0
>   print_report+0xce/0x630
>   ? bfq_end_wr_async_queues+0x246/0x340
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __virt_addr_valid+0x20d/0x410
>   ? bfq_end_wr_async_queues+0x246/0x340
>   kasan_report+0xe0/0x110
>   ? bfq_end_wr_async_queues+0x246/0x340
>   bfq_end_wr_async_queues+0x246/0x340
>   bfq_end_wr_async+0xba/0x180
>   bfq_low_latency_store+0x4e5/0x690
>   ? 0xffffffffc02150da
>   ? __pfx_bfq_low_latency_store+0x10/0x10
>   ? __pfx_bfq_low_latency_store+0x10/0x10
>   elv_attr_store+0xc4/0x110
>   kernfs_fop_write_iter+0x2f5/0x4a0
>   vfs_write+0x604/0x11f0
>   ? __pfx_locks_remove_posix+0x10/0x10
>   ? __pfx_vfs_write+0x10/0x10
>   ksys_write+0xf9/0x1d0
>   ? __pfx_ksys_write+0x10/0x10
>   do_syscall_64+0x115/0x6a0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Allocated by task 544:
>   kasan_save_stack+0x33/0x60
>   kasan_save_track+0x14/0x30
>   __kasan_kmalloc+0xaa/0xb0
>   bfq_pd_alloc+0xc0/0x1b0
>   blkg_alloc+0x346/0x960
>   blkg_create+0x8c2/0x10d0
>   bio_associate_blkg_from_css+0x9f3/0xfa0
>   bio_associate_blkg+0xd9/0x200
>   bio_init+0x303/0x640
>   __blkdev_direct_IO_simple+0x56b/0x8a0
>   blkdev_direct_IO+0x8e7/0x2580
>   blkdev_read_iter+0x205/0x400
>   vfs_read+0x7b0/0xda0
>   ksys_read+0xf9/0x1d0
>   do_syscall_64+0x115/0x6a0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 465:
>   kasan_save_stack+0x33/0x60
>   kasan_save_track+0x14/0x30
>   kasan_save_free_info+0x3b/0x60
>   __kasan_slab_free+0x5f/0x80
>   kfree+0x307/0x580
>   blkg_free_workfn+0xef/0x460
>   process_one_work+0x8d0/0x1870
>   worker_thread+0x575/0xf80
>   kthread+0x2e7/0x3c0
>   ret_from_fork+0x576/0x810
>   ret_from_fork_asm+0x1a/0x30
>
> Fixes: 44e44a1b329e ("block, bfq: improve responsiveness")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>   block/bfq-cgroup.c  | 13 ++++++++++++-
>   block/bfq-iosched.c |  3 ++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 0bd0332b3d78..d8fdace464b4 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -936,14 +936,23 @@ static void bfq_pd_offline(struct blkg_policy_data =
*pd)
>  =20
>   void bfq_end_wr_async(struct bfq_data *bfqd)
>   {
> +	struct request_queue *q =3D bfqd->queue;
>   	struct blkcg_gq *blkg;
>  =20
> -	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
> +	mutex_lock(&q->blkcg_mutex);
> +	spin_lock_irq(&q->queue_lock);
> +	spin_lock(&bfqd->lock);

Just notice this patch, the same problem is already fixed by another patchs=
et
that I posted. Since this patch is already applied by Jens, I'll rebase my =
patchset.

BTW, I'm also trying to get rid of queue_lock for blkg protection.

> +
> +	list_for_each_entry(blkg, &q->blkg_list, q_node) {
>   		struct bfq_group *bfqg =3D blkg_to_bfqg(blkg);
>  =20
>   		bfq_end_wr_async_queues(bfqd, bfqg);
>   	}
>   	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
> +
> +	spin_unlock(&bfqd->lock);
> +	spin_unlock_irq(&q->queue_lock);
> +	mutex_unlock(&q->blkcg_mutex);
>   }
>  =20
>   static int bfq_io_show_weight_legacy(struct seq_file *sf, void *v)
> @@ -1416,7 +1425,9 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, s=
truct bio *bio) {}
>  =20
>   void bfq_end_wr_async(struct bfq_data *bfqd)
>   {
> +	spin_lock_irq(&bfqd->lock);
>   	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
> +	spin_unlock_irq(&bfqd->lock);
>   }
>  =20
>   struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 141c602d5e85..eec9be62061b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2653,9 +2653,10 @@ static void bfq_end_wr(struct bfq_data *bfqd)
>   	}
>   	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
>   		bfq_bfqq_end_wr(bfqq);
> -	bfq_end_wr_async(bfqd);
>  =20
>   	spin_unlock_irq(&bfqd->lock);
> +
> +	bfq_end_wr_async(bfqd);
>   }
>  =20
>   static sector_t bfq_io_struct_pos(void *io_struct, bool request)

--=20
Thanks,
Kuai

