Return-Path: <cgroups+bounces-10170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D5B59A5E
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4F1526EE8
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6128C84F;
	Tue, 16 Sep 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVxUfBMq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4C17B505
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032970; cv=none; b=S5srGpig889TUq5670H7+frDZ8//uRI3xbTptxroH6GIaB/37KajTX9g8Fr7PXQAoYIRriIRI+UIkFw8SbzeVTQTFW1OhlT7nOPOr6xs02MflTfiJQWkPBLcOSybPWct6p1DsotJro7FC+JzV4LS8Zblcfe5+/yX9w906oQqIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032970; c=relaxed/simple;
	bh=gjqXJzjaJn1rDDry9tWMLP6hGLlHwBYHg6FYR5M+1bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJK3M/DXdahnQWX4k+NKLbq7SZAGV1klHdbyfEotRoWeWCnG2Ogf1XBXdsTT0Rk3GjY/oKYpN1C8NOcylGQnDhJKl0Xuxw7WzpD1RJNX5VihylsF3XM5ts24aGOFzWC/k4OFgaXSm2Vnh0fGCMfm4qeB78wb0+YxT16pLqVkgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVxUfBMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758032967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M63ocE/OAKnvfZBGqIjNUc0wLDVbyM9DgUerw+PwVBw=;
	b=SVxUfBMq5kEIY84sgt2E/po8Ul6TplawMa0u2b+x17o320BnE3OqD9f1oQ/EJfa2mGoMz8
	I7JsgUfIwXdG4/knK1nOINp+HbYmhv4OxqyzDNKAU9CKDKWZDy9TqIcmkQGru6NYrVXRD/
	VMhpV5Vgov9ZJ7h0vkiTvkt5rInPM6g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-LN6rBvdON5OmSkoFzM8K0Q-1; Tue, 16 Sep 2025 10:29:24 -0400
X-MC-Unique: LN6rBvdON5OmSkoFzM8K0Q-1
X-Mimecast-MFC-AGG-ID: LN6rBvdON5OmSkoFzM8K0Q_1758032963
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-336e1c46feeso26404351fa.3
        for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 07:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032963; x=1758637763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M63ocE/OAKnvfZBGqIjNUc0wLDVbyM9DgUerw+PwVBw=;
        b=Ek++Gb/z2wsbTKDdMlp23HHzX2Wn9T11m4SMBYi4zUed/U7W/Xd93RA137RtdbL3xo
         ALeoJyz31DUdNn73M303fILBCZwyX/Xgg6ZIdhiP8/Y77b5urGgoLuWHuF/uySPBcxzx
         I+udTtM+LZDbTIw0B1wXvF7VqjjxMbh6LBmHcaXV2/FFSse6bX6M3wJQwUEay8/b+xhO
         TAc/Sno0mG2vPlPqVdVfAPFC84uxSN+OdfrKtr8ceJbpBqA4N5oEXe/cBVv3javP+eqb
         PZPmXyqyLjChqGiwKiJYF9IbTPkMoAieaHCGZXOOf8njVKzUoNLQ41o7eVXqyyyiIutp
         i8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWNpSF/v4vUHqTGb5CJIiuAEv9Qg4uESjAAo9rX1VDrJLl+YmdzCj7WqNini49RE0z6RZ1Qhbry@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+60NL0MRZWvF90ohUP/u6EyJoOCaeF8O0W3GL4fnu0gqLgCMU
	AfRlIyCX7mlHAsZfWBjbdmP+V9pYCw4RZ1v6nXe0hsOzI/JY8QcrwxRfhmFxcMvIJtOGEDAeM74
	0/HfXsa/n0336jF/MOrTSvLLAybDmPqFEZWK5Ek4rdvDZDK+/ePObNiE1XK2gNWuAzbjc+Gtf5x
	oiPwaesAtQaxTsDJxeClSbbg4XWiab7zxcJg==
X-Gm-Gg: ASbGncvbhJcbggNa0EHO1f5Hy7TTcKa9gMZOIrmr++clTvIFn/RgAfZwqgobmQ7M2I1
	oxJgbbP8ZQMjsk9STp4oR264nRovvLAyhBU/ve23EPszQVqp8W6YlNtsT2AWBRRSjUfsD2GwqSy
	ifbxKqHDmqLQxRRbAmYCGzDw==
X-Received: by 2002:a05:651c:4397:20b0:337:e4cd:b2df with SMTP id 38308e7fff4ca-3513db5a478mr47713131fa.20.1758032962871;
        Tue, 16 Sep 2025 07:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH44cKpYwH2sPmQk7wovNh6m9raylyeFgycvqPtt5Vfkmh6pn+dpcb/A1Ugk4/Al8Eb+ZG6GZfu2d03E8rxx44=
X-Received: by 2002:a05:651c:4397:20b0:337:e4cd:b2df with SMTP id
 38308e7fff4ca-3513db5a478mr47712961fa.20.1758032962258; Tue, 16 Sep 2025
 07:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916010947.2891471-1-yukuai1@huaweicloud.com>
 <CAHj4cs9p9H5yx+ywsb3CMUdbqGPhM+8tuBvhW=9ADiCjAqza9w@mail.gmail.com> <5c01287e-b7f8-6ca2-a08f-f6c66fff379c@huaweicloud.com>
In-Reply-To: <5c01287e-b7f8-6ca2-a08f-f6c66fff379c@huaweicloud.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 16 Sep 2025 22:29:09 +0800
X-Gm-Features: AS18NWDWFR_QE7rQunc859gqr4l8eUjvsyLZwTZt3z3aAznxXIOSA9D8YK7O1cc
Message-ID: <CAHj4cs8998+fwUxGLuMNpthxWN6SdCe=5=W5cvpSBYosvOCF9A@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: fix throtl_data leak during disk release
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, liangjie@lixiang.com, 
	hanguangjiang@lixiang.com, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:05=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/09/16 16:15, Yi Zhang =E5=86=99=E9=81=93:
> > Hi Yu
> > A new issue was triggered with the change. Please check it. Thanks.
> >
> > [  285.804104] run blktests throtl/001 at 2025-09-16 04:11:12
> > [  286.161894] null_blk: disk dev_nullb created
> >
> > [  293.388583] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  293.394762] WARNING: possible circular locking dependency detected
> > [  293.400940] 6.17.0-rc6.v1+ #2 Not tainted
> > [  293.404952] ------------------------------------------------------
> > [  293.411131] find/1609 is trying to acquire lock:
> > [  293.415751] ffff8882911b50b0 ((&sq->pending_timer)){+.-.}-{0:0},
> > at: __timer_delete_sync+0x23/0x120
> > [  293.424817]
> >                 but task is already holding lock:
> > [  293.430648] ffff8882b7794948 (&blkcg->lock){....}-{3:3}, at:
> > blkcg_deactivate_policy+0x1e7/0x4e0
> > [  293.439445]
> >                 which lock already depends on the new lock.
> >
> > [  293.447619]
> >                 the existing dependency chain (in reverse order) is:
> > [  293.455096]
> >                 -> #2 (&blkcg->lock){....}-{3:3}:
> > [  293.460948]        __lock_acquire+0x57c/0xbd0
> > [  293.465315]        lock_acquire.part.0+0xbd/0x260
> > [  293.470020]        _raw_spin_lock+0x37/0x80
> > [  293.474214]        blkg_create+0x3e2/0x1060
> > [  293.478401]        blkcg_init_disk+0x8f/0x460
> > [  293.482769]        __alloc_disk_node+0x27f/0x600
> > [  293.487397]        __blk_mq_alloc_disk+0x5f/0xd0
> > [  293.492025]        nvme_alloc_ns+0x202/0x17a0 [nvme_core]
> > [  293.497458]        nvme_scan_ns+0x30b/0x380 [nvme_core]
> > [  293.502709]        async_run_entry_fn+0x9a/0x4f0
> > [  293.507330]        process_one_work+0xd8b/0x1320
> > [  293.511956]        worker_thread+0x5f3/0xfe0
> > [  293.516231]        kthread+0x3b4/0x770
> > [  293.519992]        ret_from_fork+0x393/0x480
> > [  293.524272]        ret_from_fork_asm+0x1a/0x30
> > [  293.528728]
> >                 -> #1 (&q->queue_lock){..-.}-{3:3}:
> > [  293.534749]        __lock_acquire+0x57c/0xbd0
> > [  293.539108]        lock_acquire.part.0+0xbd/0x260
> > [  293.543814]        _raw_spin_lock_irq+0x3f/0x90
> > [  293.548348]        throtl_pending_timer_fn+0x11c/0x15b0
> > [  293.553581]        call_timer_fn+0x19c/0x3e0
> > [  293.557853]        __run_timers+0x627/0x9f0
> > [  293.562041]        run_timer_base+0xe6/0x140
> > [  293.566312]        run_timer_softirq+0x1a/0x30
> > [  293.570758]        handle_softirqs+0x1fd/0x890
> > [  293.575205]        __irq_exit_rcu+0xfd/0x250
> > [  293.579477]        irq_exit_rcu+0xe/0x30
> > [  293.583402]        sysvec_apic_timer_interrupt+0xa1/0xd0
> > [  293.588717]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [  293.594383]        cpuidle_enter_state+0xf5/0x2f0
> > [  293.599090]        cpuidle_enter+0x4e/0xa0
> > [  293.603197]        cpuidle_idle_call+0x213/0x370
> > [  293.607816]        do_idle+0x131/0x200
> > [  293.611568]        cpu_startup_entry+0x54/0x60
> > [  293.616017]        start_secondary+0x20d/0x290
> > [  293.620471]        common_startup_64+0x13e/0x141
> > [  293.625096]
> >                 -> #0 ((&sq->pending_timer)){+.-.}-{0:0}:
> > [  293.631642]        check_prev_add+0xf1/0xcd0
> > [  293.635921]        validate_chain+0x487/0x570
> > [  293.640281]        __lock_acquire+0x57c/0xbd0
> > [  293.644641]        lock_acquire.part.0+0xbd/0x260
> > [  293.649345]        __timer_delete_sync+0x40/0x120
> > [  293.654052]        throtl_pd_free+0x19/0x40
> > [  293.658238]        blkcg_deactivate_policy+0x2c9/0x4e0
> > [  293.663378]        blk_throtl_exit+0xa5/0x100
> > [  293.667743]        blkcg_exit_disk+0x1f/0x270
> > [  293.672104]        disk_release+0x11b/0x3a0
> > [  293.676299]        device_release+0x9f/0x210
> > [  293.680579]        kobject_cleanup+0x105/0x360
> > [  293.685027]        null_del_dev.part.0+0x1e5/0x480 [null_blk]
> > [  293.690788]        nullb_group_drop_item+0xa5/0xd0 [null_blk]
> > [  293.696544]        configfs_rmdir+0x69f/0xac0
> > [  293.700910]        vfs_rmdir+0x1a5/0x5b0
> > [  293.704836]        do_rmdir+0x276/0x330
> > [  293.708677]        __x64_sys_unlinkat+0x16b/0x1e0
> > [  293.713393]        do_syscall_64+0x94/0x8d0
> > [  293.717584]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  293.723160]
> >                 other info that might help us debug this:
> >
> > [  293.731159] Chain exists of:
> >                   (&sq->pending_timer) --> &q->queue_lock --> &blkcg->l=
ock
> >
> > [  293.742045]  Possible unsafe locking scenario:
> >
> > [  293.747972]        CPU0                    CPU1
> > [  293.752511]        ----                    ----
> > [  293.757043]   lock(&blkcg->lock);
> > [  293.760371]                                lock(&q->queue_lock);
> > [  293.766387]                                lock(&blkcg->lock);
> > [  293.772226]   lock((&sq->pending_timer));
> > [  293.776248]
>
> This is true deadlock, however, I think the real problem here is
> pd_free_fn() can be called inside queue_lock, and blk-throttle is
> protecting with this queue_lock. And this problem should already
> exist even before this patch, for example, from blkcg_activate_plicy()
> error patch, pd_free_fn() is called with queue_lock held as well.
>
> We can fix this by moving all the pd_free_fn() outside of queue_lock,
> however, I think we should fix this in blk-throttle, by using internal
> lock instead of reusing queue_lock.
>
> Yi, althrogh I already tested, can you give following patch a test on
> the top of this patch as well?

The issue cannot be reproduced now.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> Thanks,
> Kuai
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index f510ae072868..aaf0aa7756bf 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -33,6 +33,8 @@ static struct workqueue_struct *kthrotld_workqueue;
>
>   struct throtl_data
>   {
> +       spinlock_t lock;
> +
>          /* service tree for active throtl groups */
>          struct throtl_service_queue service_queue;
>
> @@ -1140,7 +1142,7 @@ static void throtl_pending_timer_fn(struct
> timer_list *t)
>          else
>                  q =3D td->queue;
>
> -       spin_lock_irq(&q->queue_lock);
> +       spin_lock_irq(&td->lock);
>
>          if (!q->root_blkg)
>                  goto out_unlock;
> @@ -1166,9 +1168,9 @@ static void throtl_pending_timer_fn(struct
> timer_list *t)
>                          break;
>
>                  /* this dispatch windows is still open, relax and repeat=
 */
> -               spin_unlock_irq(&q->queue_lock);
> +               spin_unlock_irq(&td->lock);
>                  cpu_relax();
> -               spin_lock_irq(&q->queue_lock);
> +               spin_lock_irq(&td->lock);
>          }
>
>          if (!dispatched)
> @@ -1191,7 +1193,7 @@ static void throtl_pending_timer_fn(struct
> timer_list *t)
>                  queue_work(kthrotld_workqueue, &td->dispatch_work);
>          }
>   out_unlock:
> -       spin_unlock_irq(&q->queue_lock);
> +       spin_unlock_irq(&td->lock);
>   }
>
>   /**
> @@ -1207,7 +1209,6 @@ static void blk_throtl_dispatch_work_fn(struct
> work_struct *work)
>          struct throtl_data *td =3D container_of(work, struct throtl_data=
,
>                                                dispatch_work);
>          struct throtl_service_queue *td_sq =3D &td->service_queue;
> -       struct request_queue *q =3D td->queue;
>          struct bio_list bio_list_on_stack;
>          struct bio *bio;
>          struct blk_plug plug;
> @@ -1215,11 +1216,11 @@ static void blk_throtl_dispatch_work_fn(struct
> work_struct *work)
>
>          bio_list_init(&bio_list_on_stack);
>
> -       spin_lock_irq(&q->queue_lock);
> +       spin_lock_irq(&td->lock);
>          for (rw =3D READ; rw <=3D WRITE; rw++)
>                  while ((bio =3D throtl_pop_queued(td_sq, NULL, rw)))
>                          bio_list_add(&bio_list_on_stack, bio);
> -       spin_unlock_irq(&q->queue_lock);
> +       spin_unlock_irq(&td->lock);
>
>          if (!bio_list_empty(&bio_list_on_stack)) {
>                  blk_start_plug(&plug);
> @@ -1324,6 +1325,7 @@ static int blk_throtl_init(struct gendisk *disk)
>          if (!td)
>                  return -ENOMEM;
>
> +       spin_lock_init(&td->lock);
>          INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
>          throtl_service_queue_init(&td->service_queue);
>
> @@ -1694,7 +1696,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>          if (!blk_throtl_activated(q))
>                  return;
>
> -       spin_lock_irq(&q->queue_lock);
> +       spin_lock_irq(&q->td->lock);
>          /*
>           * queue_lock is held, rcu lock is not needed here technically.
>           * However, rcu lock is still held to emphasize that following
> @@ -1713,7 +1715,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>                  tg_flush_bios(blkg_to_tg(blkg));
>          }
>          rcu_read_unlock();
> -       spin_unlock_irq(&q->queue_lock);
> +       spin_unlock_irq(&q->td->lock);
>   }
>
>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio,
> bool rw)
> @@ -1746,7 +1748,6 @@ static bool tg_within_limit(struct throtl_grp *tg,
> struct bio *bio, bool rw)
>
>   bool __blk_throtl_bio(struct bio *bio)
>   {
> -       struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
>          struct blkcg_gq *blkg =3D bio->bi_blkg;
>          struct throtl_qnode *qn =3D NULL;
>          struct throtl_grp *tg =3D blkg_to_tg(blkg);
> @@ -1756,7 +1757,7 @@ bool __blk_throtl_bio(struct bio *bio)
>          struct throtl_data *td =3D tg->td;
>
>          rcu_read_lock();
> -       spin_lock_irq(&q->queue_lock);
> +       spin_lock_irq(&td->lock);
>          sq =3D &tg->service_queue;
>
>          while (true) {
> @@ -1832,7 +1833,7 @@ bool __blk_throtl_bio(struct bio *bio)
>          }
>
>   out_unlock:
> -       spin_unlock_irq(&q->queue_lock);
> +       spin_unlock_irq(&td->lock);
>
>          rcu_read_unlock();
>          return throttled;
>
> >                  *** DEADLOCK ***
> >
> > [  293.782166] 8 locks held by find/1609:
> > [  293.785921]  #0: ffff88813ddf6448 (sb_writers#16){.+.+}-{0:0}, at:
> > do_rmdir+0x1a8/0x330
> > [  293.793945]  #1: ffff88829e48a108 (&default_group_class[depth -
> > 1]/1){+.+.}-{4:4}, at: do_rmdir+0x1ec/0x330
> > [  293.803704]  #2: ffff8881f918cb48
> > (&sb->s_type->i_mutex_key#22){+.+.}-{4:4}, at: vfs_rmdir+0xc0/0x5b0
> > [  293.812943]  #3: ffffffffc1cc4698
> > (&nullb_subsys.su_mutex){+.+.}-{4:4}, at: configfs_rmdir+0x57b/0xac0
> > [  293.822267]  #4: ffffffffc1ccc130 (&lock){+.+.}-{4:4}, at:
> > nullb_group_drop_item+0x50/0xd0 [null_blk]
> > [  293.831516]  #5: ffff88829ddb9980 (&q->blkcg_mutex){+.+.}-{4:4},
> > at: blkcg_deactivate_policy+0xf6/0x4e0
> > [  293.840926]  #6: ffff88829ddb9650 (&q->queue_lock){..-.}-{3:3}, at:
> > blkcg_deactivate_policy+0x10a/0x4e0
> > [  293.850339]  #7: ffff8882b7794948 (&blkcg->lock){....}-{3:3}, at:
> > blkcg_deactivate_policy+0x1e7/0x4e0
> > [  293.859577]
> >                 stack backtrace:
> > [  293.863939] CPU: 11 UID: 0 PID: 1609 Comm: find Kdump: loaded Not
> > tainted 6.17.0-rc6.v1+ #2 PREEMPT(voluntary)
> > [  293.863946] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
> > 2.17.0 12/04/2024
> > [  293.863949] Call Trace:
> > [  293.863953]  <TASK>
> > [  293.863959]  dump_stack_lvl+0x6f/0xb0
> > [  293.863970]  print_circular_bug.cold+0x38/0x45
> > [  293.863981]  check_noncircular+0x148/0x160
> > [  293.863997]  check_prev_add+0xf1/0xcd0
> > [  293.864001]  ? alloc_chain_hlocks+0x13e/0x1d0
> > [  293.864007]  ? srso_return_thunk+0x5/0x5f
> > [  293.864013]  ? add_chain_cache+0x12c/0x310
> > [  293.864022]  validate_chain+0x487/0x570
> > [  293.864027]  ? srso_return_thunk+0x5/0x5f
> > [  293.864037]  __lock_acquire+0x57c/0xbd0
> > [  293.864043]  ? srso_return_thunk+0x5/0x5f
> > [  293.864052]  lock_acquire.part.0+0xbd/0x260
> > [  293.864057]  ? __timer_delete_sync+0x23/0x120
> > [  293.864066]  ? srso_return_thunk+0x5/0x5f
> > [  293.864071]  ? rcu_is_watching+0x15/0xb0
> > [  293.864076]  ? blkcg_deactivate_policy+0x1e7/0x4e0
> > [  293.864080]  ? srso_return_thunk+0x5/0x5f
> > [  293.864085]  ? lock_acquire+0x10b/0x150
> > [  293.864092]  ? __timer_delete_sync+0x23/0x120
> > [  293.864098]  __timer_delete_sync+0x40/0x120
> > [  293.864103]  ? __timer_delete_sync+0x23/0x120
> > [  293.864111]  throtl_pd_free+0x19/0x40
> > [  293.864117]  blkcg_deactivate_policy+0x2c9/0x4e0
> > [  293.864132]  blk_throtl_exit+0xa5/0x100
> > [  293.864140]  blkcg_exit_disk+0x1f/0x270
> > [  293.864150]  disk_release+0x11b/0x3a0
> > [  293.864157]  device_release+0x9f/0x210
> > [  293.864164]  kobject_cleanup+0x105/0x360
> > [  293.864172]  null_del_dev.part.0+0x1e5/0x480 [null_blk]
> > [  293.864189]  nullb_group_drop_item+0xa5/0xd0 [null_blk]
> > [  293.864202]  configfs_rmdir+0x69f/0xac0
> > [  293.864210]  ? __pfx_may_link+0x10/0x10
> > [  293.864221]  ? __pfx_configfs_rmdir+0x10/0x10
> > [  293.864235]  vfs_rmdir+0x1a5/0x5b0
> > [  293.864244]  do_rmdir+0x276/0x330
> > [  293.864252]  ? __pfx_do_rmdir+0x10/0x10
> > [  293.864262]  ? ktime_get_coarse_real_ts64+0x121/0x180
> > [  293.864271]  ? srso_return_thunk+0x5/0x5f
> > [  293.864276]  ? getname_flags.part.0+0xf8/0x480
> > [  293.864285]  __x64_sys_unlinkat+0x16b/0x1e0
> > [  293.864293]  do_syscall_64+0x94/0x8d0
> > [  293.864298]  ? srso_return_thunk+0x5/0x5f
> > [  293.864304]  ? srso_return_thunk+0x5/0x5f
> > [  293.864309]  ? fput_close_sync+0x156/0x1c0
> > [  293.864316]  ? __pfx_fput_close_sync+0x10/0x10
> > [  293.864326]  ? srso_return_thunk+0x5/0x5f
> > [  293.864333]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  293.864337]  ? srso_return_thunk+0x5/0x5f
> > [  293.864342]  ? lockdep_hardirqs_on+0x78/0x100
> > [  293.864347]  ? srso_return_thunk+0x5/0x5f
> > [  293.864351]  ? do_syscall_64+0x139/0x8d0
> > [  293.864355]  ? srso_return_thunk+0x5/0x5f
> > [  293.864362]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  293.864366]  ? srso_return_thunk+0x5/0x5f
> > [  293.864371]  ? lockdep_hardirqs_on+0x78/0x100
> > [  293.864376]  ? srso_return_thunk+0x5/0x5f
> > [  293.864381]  ? do_syscall_64+0x139/0x8d0
> > [  293.864385]  ? srso_return_thunk+0x5/0x5f
> > [  293.864393]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  293.864398] RIP: 0033:0x7f13bc09bb9b
> > [  293.864404] Code: 77 05 c3 0f 1f 40 00 48 8b 15 71 52 0d 00 f7 d8
> > 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 07 01 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 52 0d 00 f7 d8 64 89
> > 01 48
> > [  293.864408] RSP: 002b:00007ffee8a880e8 EFLAGS: 00000216 ORIG_RAX:
> > 0000000000000107
> > [  293.864414] RAX: ffffffffffffffda RBX: 00005593f2ad7fb0 RCX: 00007f1=
3bc09bb9b
> > [  293.864417] RDX: 0000000000000200 RSI: 00005593f2ad7fb0 RDI: 0000000=
000000005
> > [  293.864421] RBP: 0000000000000200 R08: 00000000ffffffff R09: 0000559=
3f2acfd50
> > [  293.864424] R10: 00005593f2ac8010 R11: 0000000000000216 R12: 0000559=
3f2ace330
> > [  293.864427] R13: 0000000000000001 R14: 0000000000000005 R15: 00007ff=
ee8a890bb
> > [  293.864445]  </TASK>
> >
> > On Tue, Sep 16, 2025 at 9:20=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Tightening the throttle activation check in blk_throtl_activated() to
> >> require both q->td presence and policy bit set introduced a memory lea=
k
> >> during disk release:
> >>
> >> blkg_destroy_all() clears the policy bit first during queue deactivati=
on,
> >> causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
> >> blk_throtl_activated() fails policy check.
> >>
> >> Fix by reordering operations in disk_release() to call blk_throtl_exit=
()
> >> while throttle policy is still active. We avoid modifying blk_throtl_e=
xit()
> >> activation check because it's intuitive that blk-throtl start from
> >> blk_throtl_init() and end in blk_throtl_exit().
> >>
> >> Fixes: bd9fd5be6bc0 ("blk-throttle: fix access race during throttle po=
licy activation")
> >> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> >> Closes: https://lore.kernel.org/all/CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kV=
wCrV6ZvRovrr9Z+HA@mail.gmail.com/
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   block/blk-cgroup.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> >> index 7246fc256315..64a56c8697f9 100644
> >> --- a/block/blk-cgroup.c
> >> +++ b/block/blk-cgroup.c
> >> @@ -1539,8 +1539,8 @@ int blkcg_init_disk(struct gendisk *disk)
> >>
> >>   void blkcg_exit_disk(struct gendisk *disk)
> >>   {
> >> -       blkg_destroy_all(disk);
> >>          blk_throtl_exit(disk);
> >> +       blkg_destroy_all(disk);
> >>   }
> >>
> >>   static void blkcg_exit(struct task_struct *tsk)
> >> --
> >> 2.39.2
> >>
> >>
> >
> >
>


--=20
Best Regards,
  Yi Zhang


