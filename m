Return-Path: <cgroups+bounces-12988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB68D047A0
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7030C3116F02
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15627E07E;
	Thu,  8 Jan 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="gZlWrrRD"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A927F017
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889383; cv=none; b=haqNEIJdodAt2dHNpxX81XN2wSt7mURfmaXezD3mTQI53KgtZAee9juwTGaCFHnGCHZ97N1S7hsXyIJA82C8lHkrJlX9pBZ2TIjNHFqOCePbQifTjn8w5ueOYy2VGHZo4sB+w+AuYjXiaLnXC6wZO/mSvzL8xoXsIBueIokapb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889383; c=relaxed/simple;
	bh=FJaLd9TU8617lJusr9HisNHpHUfyjk6T681tOFVFY1g=;
	h=Date:Message-Id:Content-Type:To:Cc:From:Subject:References:
	 In-Reply-To:Mime-Version; b=huTOein0AelomlGUz3xaCzk7faVkA28zs4wT19MOXSDhWjBVYugAgpVEeQLX573kP5OeSfqFXwb0od6WCg+Tbxm8l3ZvbNlPGnx03rCX6thSavuizvunqEPqR4jNZ3tbT2j6ehQ3uA2MDhKMPhZX3DxRIUG2tuofKEcTbaEJAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=gZlWrrRD; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767889370;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PAH/SG88QWqO0Mu8EJHRgmAHkctrTflT9r3ltKLmURg=;
 b=gZlWrrRDcfe1QY9wzo8CZJvPncWyAsynY9W9C5A787Yx4zYkbsf5Ir+HmyBSa6716slJiV
 GaNI8KKOC99NTwKHiIFjPrDGfIMgsdrKSmmLmpU3TlJrKz4lr+Ohju6QVYv3Y9ieDTrbsZ
 q+ZhgcIQMlyAexZbL2aRrGCeVbVorgtwt3YkRHM9JyGl2yE7TNIPVx2eIldvabXSXSEhTA
 rvrBzZhygoPpN7itZkM/YyO1iyf4YPFRi4VxnYzaUNKPSQrLliEkrBo4oGUraBQzbm2WuR
 vYbp/BkCmeH+oRKD0Y5Hcs2BGcR3D/hkdfaDzuN9qf8qfo9WkcvgVhgr6qraSQ==
Date: Fri, 9 Jan 2026 00:22:46 +0800
Message-Id: <8b5487db-d15a-4dd1-901c-e33ec1418c75@fnnas.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, 
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <zhengqixing@huawei.com>, 
	<yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 00:22:47 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH 3/3] blk-cgroup: skip dying blkg in blkcg_activate_policy()
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com> <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
X-Lms-Return-Path: <lba+2695fd9d8+e6d211+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hi,

=E5=9C=A8 2026/1/8 9:44, Zheng Qixing =E5=86=99=E9=81=93:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> When switching IO schedulers on a block device, blkcg_activate_policy()
> can race with concurrent blkcg deletion, leading to a use-after-free of
> the blkg.
>
> T1:				  T2:
> elv_iosched_store		  blkg_destroy
> elevator_switch			  kill(&blkg->refcnt) // blkg->refcnt=3D0
> ...				  blkg_release // call_rcu
> blkcg_activate_policy		  __blkg_release
> list for blkg			  blkg_free
> 				  blkg_free_workfn
> 				  ->pd_free_fn(pd)
> blkg_get(blkg) // blkg->refcnt=3D0->1
> 				  list_del_init(&blkg->q_node)
> 				  kfree(blkg)
> blkg_put(pinned_blkg) // blkg->refcnt=3D1->0
> blkg_release // call_rcu again
> call_rcu(..., __blkg_release)

This stack is not clear to me, can this problem be fixed by protecting
q->blkg_list iteration with blkcg_mutex as I said in patch 2?

>
> Fix this by replacing blkg_get() with blkg_tryget(), which fails if
> the blkg's refcount has already reached zero. If blkg_tryget() fails,
> skip processing this blkg since it's already being destroyed.
>
> The uaf call trace is as follows:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in rcu_accelerate_cbs+0x114/0x120
>   Read of size 8 at addr ffff88815a20b5d8 by task bash/1068
>   CPU: 0 PID: 1068 Comm: bash Not tainted 6.6.0-g6918ead378dc-dirty #31
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc=
37 04/01/2014
> Call Trace:
>   <IRQ>
>   rcu_accelerate_cbs+0x114/0x120
>   rcu_report_qs_rdp+0x1fb/0x3e0
>   rcu_core+0x4d7/0x6f0
>   handle_softirqs+0x198/0x550
>   irq_exit_rcu+0x130/0x190
>   sysvec_apic_timer_interrupt+0x6e/0x90
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x16/0x20
>
> Allocated by task 1031:
>   kasan_save_stack+0x1c/0x40
>   kasan_set_track+0x21/0x30
>   __kasan_kmalloc+0x8b/0x90
>   blkg_alloc+0xb6/0x9c0
>   blkg_create+0x8c6/0x1010
>   blkg_lookup_create+0x2ca/0x660
>   bio_associate_blkg_from_css+0xfb/0x4e0
>   bio_associate_blkg+0x62/0xf0
>   bio_init+0x272/0x8d0
>   bio_alloc_bioset+0x45a/0x760
>   ext4_bio_write_folio+0x68e/0x10d0
>   mpage_submit_folio+0x14a/0x2b0
>   mpage_process_page_bufs+0x1b1/0x390
>   mpage_prepare_extent_to_map+0xa91/0x1060
>   ext4_do_writepages+0x948/0x1c50
>   ext4_writepages+0x23f/0x4a0
>   do_writepages+0x162/0x5e0
>   filemap_fdatawrite_wbc+0x11a/0x180
>   __filemap_fdatawrite_range+0x9d/0xd0
>   file_write_and_wait_range+0x91/0x110
>   ext4_sync_file+0x1c1/0xaa0
>   __x64_sys_fsync+0x55/0x90
>   do_syscall_64+0x55/0x100
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>
> Freed by task 24:
>   kasan_save_stack+0x1c/0x40
>   kasan_set_track+0x21/0x30
>   kasan_save_free_info+0x27/0x40
>   __kasan_slab_free+0x106/0x180
>   __kmem_cache_free+0x162/0x350
>   process_one_work+0x573/0xd30
>   worker_thread+0x67f/0xc30
>   kthread+0x28b/0x350
>   ret_from_fork+0x30/0x70
>   ret_from_fork_asm+0x1b/0x30
>
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   block/blk-cgroup.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index af468676cad1..ac7702db0836 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1645,9 +1645,10 @@ int blkcg_activate_policy(struct gendisk *disk, co=
nst struct blkcg_policy *pol)
>   			 * GFP_NOWAIT failed.  Free the existing one and
>   			 * prealloc for @blkg w/ GFP_KERNEL.
>   			 */

Why this check is not done before pd_alloc_fn()? What if pd_alloc_fn() succ=
eed for
removed blkg?

> +			if (!blkg_tryget(blkg))
> +				continue;
>   			if (pinned_blkg)
>   				blkg_put(pinned_blkg);
> -			blkg_get(blkg);
>   			pinned_blkg =3D blkg;
>  =20
>   			spin_unlock_irq(&q->queue_lock);

--=20
Thansk,
Kuai

