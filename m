Return-Path: <cgroups+bounces-17549-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q63MNmNkTGqZjwEAu9opvQ
	(envelope-from <cgroups+bounces-17549-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 04:28:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB25716D0F
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 04:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="IOeWT/f8";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17549-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17549-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE22F300B9FB
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5634B697;
	Tue,  7 Jul 2026 02:28:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67731348C79
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 02:28:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391318; cv=pass; b=ac264O50qU2Md05/HY45mCmHDVDwJB+9LDf++lkPK2sKpIryWa8gqizcBUh/PikjZ7WCDoAX6SIvk4MrhapQ1O++P7yednxFL0+NgcPIrQhlbSEy7gJSxLmAzC3PxzOQh078SjXmWjxcAKSeVwRVv0vQa9v+7M8rs+PuCtAfB4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391318; c=relaxed/simple;
	bh=6W8O92UiA79DWd1L2UFfMr/QL8xVI13/QY5YPPSzdiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8Q1qkuebkIw6FLXuGLg5XVeQC5VgAb/pUzXKIs4vs5BC+RxqpcjIfWtWEC1DPRve7/94GcgvrpwR5jfOWLLOHc8ricjMx+bGkKCo41r9WlUzCOBD2kO/v9wW2fCkHT3loaakYOKfOolBj9uvUXENGp25xxOlthB8vAWAOjsRLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOeWT/f8; arc=pass smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8111c0c7439so27791517b3.2
        for <cgroups@vger.kernel.org>; Mon, 06 Jul 2026 19:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783391314; cv=none;
        d=google.com; s=arc-20260327;
        b=onCRaVlXYGqQInY+c55UiIS7oxBzSslRWZBu2jAc6Yjlb/xcLHtCUnFUG797ljj6yi
         KjEJHlny37/pCsUcXULq7HAg+ZRKP8VcB6UR2IVrbqcmO5uyWvzgb6Qnqzrd8RwMkNvQ
         1DkJbmdUwVtje2rtdhPL6CF6JZP1i5f4TgZtSZcmeBtcX/kLlqSg+186rq7DwkPkCFQP
         zGBdF8GuU+fWB3/XVmaM6f/A0LqulTxPiwjoe1MDdn3kYilmtqpSfNTSN5jcX2VO3YD+
         l2os1UP37rZyA4rqDZhhzs5zb0mDYsRH6zOo0Uc29qMHLTGM6j6vQ2ZilAWyGealapmS
         g6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        fh=mCPczqr9FgwsEcJRCIoG7UoSmzXSpTo+WG6bfEBEpXc=;
        b=jG/CVgeHs3t+JlZawWFVlWU/tONKX3xnmZRPGSB3eskFBYqYgg5HkxNuOW+Y/xxxNl
         xTwsvYh5Y/E5gyn/SPMu1xPmfdfsYNgQLTQaoeqyfXxEXHjZMK3H6F1xoi74HBZTr6TC
         +g1dVkJKiscxFLQ0SDvx5kx9g4iPack2xuAjRaTwbPJ50+zA+FkHBivvILiXqeeK6OPX
         W3IaoOrtzfVhqRkUwtIpfwwj4Rn0+KuhGVlau9MCCf7gTbPsTcV/uohfWwM0zkhH7Xra
         e4NWei06kVsHZWms76IbG9FNmY9sGdxZ7QkYSki9+trmniVOF8kfq/q6NazAsJIoSRnI
         thRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783391314; x=1783996114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        b=IOeWT/f8GEFbMfcWusWMefPMt1/nVvrMP4n9sg5AybZ1n/G7MzNHgGKqFbIIooUAjX
         xwc/6YXzD44WDrG3u0OtWNnrLsQgXgWJZG4TQ0VulQ1u9EtSsMPYvkzzdlXqRbHaLQzz
         x+VVGCP5M+Zm6Obm/kc/477lK8ePeLVy9wOvoo+nCM8NTUAnzmBFGqG0V+NzB5ospjCP
         +ORVr2E27TguVMmmG1nHoTljaJ8YL5lINg6vLncMof2209zrWNkgoFwXhlJggefiMDxo
         oXcyo1YeZjsfvFSx66/BPYsfmgPqnpyZu/tTZUOAHHZFr4VrxmRwLGd5kjg8yicqtsfm
         hjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391314; x=1783996114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        b=ENMtEDT3KmvSkUe0NvKQXy9Y0VxOHhV+fmjdXVK5Vv409+L/2k7FyWV+TFnEde6qcb
         NKbRFlf5tLgDTQv1KGa5hfkJbWVibnlCVkKKPR9s/rN9Bo6+qfnG3LfL1lxo7+MdrQ6A
         ZioLwARf6fkOPybNVab4WA08ry6qASApUq8xCUiee9zcPEBOK6mWdkaQtG/mW52lHp1f
         iQITCKkJPu3TEUPBXN/WATU5T5gEaM+Qxs08FpiA0F1iz0IoUmkObSHv2nsL9htqcIuw
         GrUk7qI/695Iqu/J4z7esxBog9QcTQ+sw6cZ3J1zCZLE2nwJ71bfuCGF/RHcizGUF2Pf
         ddKQ==
X-Gm-Message-State: AOJu0YyGvB+ED5JcI3ACLEehaJhe5+lTJO4GTZRaCF6U2pkLZtFOm2/p
	zgmxMubmfedpJBPu519VRTIztDRzkELMgrJnFG9COJRSORR1vAq5pNVJPTKLNF0ot2l+lC9+Iyj
	U/tG2ObhsxjGbffasIUTqLZFzmgDdMAFRXh3p20yYcA==
X-Gm-Gg: AfdE7cmiGK2rg9PzgBd9TSjr+4FBuxlq0A1BRzHsofIkp6W71XaIIT2ChIFekpUT+E3
	JRnWe9GZVySXeXkEd96DvW2GcdpAm9wHcEEhDzqEw1PepgAVb7phMSM9xGbCspdqYuvcEzs/kuk
	xjjJOuPwEKj16y/8Cj9skDodOJo5lqrwSIQGNJTu7IXO54Vls6nGrlvazNDZo8p1PKBic4JUxZh
	IP2isbNV/Igr8lIX6mAulh7iV1g8shPr2OQQt3gjG9zeSabG7ujbwizqLDofQjG7Z+KCVbun8g=
X-Received: by 2002:a05:690c:4a02:b0:80c:85b6:764b with SMTP id
 00721157ae682-81be3dd5f38mr24315517b3.64.1783391313848; Mon, 06 Jul 2026
 19:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621135916.2657247-1-zzzccc427@gmail.com>
In-Reply-To: <20260621135916.2657247-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 7 Jul 2026 10:28:20 +0800
X-Gm-Features: AVVi8CfnnNKkDInUTXgjVMLCp7oBm7r0SraFmHbJ_HK7RJmtNGneYk1TwT5pq4U
Message-ID: <CAFRLqsWb=_LVBKfYR0Y5=ym8M5Fddy3EmWj54PYFcuYA+fK_fw@mail.gmail.com>
Subject: Re: [PATCH] blk-iolatency: flush enable work after policy deactivation
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17549-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BB25716D0F

Hi all,

Sorry for the noise, but I wanted to gently follow up on this patch in
case it got buried.

I would really appreciate any feedback when you have a chance. Please
let me know if I should make any changes or provide more testing
results.

Thanks a lot.

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8821=E6=97=A5=
=E5=91=A8=E6=97=A5 21:59=E5=86=99=E9=81=93=EF=BC=9A
>
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
> Flush enable_work again after blkcg_deactivate_policy() returns and befor=
e
> freeing blkiolat. Policy offline callbacks have completed at that point,
> so the second drain covers the late queueing path without changing the
> normal enable/disable accounting rules.
>
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
> Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO=
 hangs on offline")
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
> @@ -639,6 +639,11 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos=
)
>         timer_shutdown_sync(&blkiolat->timer);
>         flush_work(&blkiolat->enable_work);
>         blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
> +       /*
> +        * blkcg_deactivate_policy() invokes iolatency_pd_offline(), whic=
h may
> +        * queue enable_work again when it clears the last latency target=
.
> +        */
> +       flush_work(&blkiolat->enable_work);
>         kfree(blkiolat);
>  }
>
> --
> 2.43.0
>

