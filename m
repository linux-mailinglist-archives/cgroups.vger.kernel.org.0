Return-Path: <cgroups+bounces-10158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D3B59027
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB78D1793A1
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF128850D;
	Tue, 16 Sep 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC/BFMT9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8028643F
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010525; cv=none; b=EZB0qs4YMOOZYDCEmf10GxNFd3Es0ziEjEiMq0/B5zC9NoZZ5dnMaSwisr73ozQYD8tI0hnac4JJX+Pv8F/sMxpjEK+PDCyO5IXIwf3qruhbiJI7+W+BX5NuP2BXpdMG/kaRfSPUw902XLYYRhffvrcZ4OergcSD8P7kjGIiDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010525; c=relaxed/simple;
	bh=IYa01UUPI4nzVnYfKe1Bk46b8x/g231PWrp7VkEdtEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8Fkro3HjbeVCryUaINEaZdVv2x2JdTE9/4S8L4Toucex7vSL2RU7/Lf2Dal9zG1jjJ7GnDZ9TEni3SVK1f7SQQT0wXWS2sXzOx7/Vk3U6bsxqcipLQ9GaWpgAPkYJijtjFydfdPbKf/A6/SBoTXFjWhoYC15x7033JOsm0SKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cC/BFMT9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758010522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnXjzBw0dGQlTbJw62UgReVdw+pNT5//JRB8RBterRU=;
	b=cC/BFMT99Ubb44BL5khP1ep4M2Ru3GGGnKoPsAozZW9Gj6NytG8QAuQWR7BvAxZSmHm+8O
	jmdItMqLuX9aGhuk5p8+EizUtxNhJhl6CZp/FU+ibP0poJvkkdAExWBlS0TTnEEnTz08JF
	biRWmh/pwxjKVVbHaY9aIjyhKJQ85HM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-3ldydUfONMGvX8H2YAO9-A-1; Tue, 16 Sep 2025 04:15:20 -0400
X-MC-Unique: 3ldydUfONMGvX8H2YAO9-A-1
X-Mimecast-MFC-AGG-ID: 3ldydUfONMGvX8H2YAO9-A_1758010519
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55f6f4dea68so3615970e87.0
        for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 01:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010519; x=1758615319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnXjzBw0dGQlTbJw62UgReVdw+pNT5//JRB8RBterRU=;
        b=iJD9jAIOoMSuxXSuZZ1P3lxnARkvgy6NFPG0AcIfbcA9iSW9bzhTstHeyVQgnpgh8e
         F0ukgoZQgG60yaGjw+3nJQ2BQOUxyKSVitjt4Hn6REUGgoSQZyHzzVa2g2boc7n2lvRO
         fqrzAXvyxNCHYGEqmjWJdjoXWDEICykPY4Xqqmh/4EkXrGnMSh778XtUKgmeoKMyM1Yg
         rHV5J1AqX0WD2VzVB7l5GYNMezlr6FNDcTCJXxibP9S1bK0jg1C79ne+aZYsZf3uQ4+Y
         Znh3LA4Pn/wGEQPQffpw+683l9tTphGqP69X2ctfRAqoXd3tvBySRW96ElxdVz3fWnQG
         /SLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGWmFgThTNaUX5voxa5Eakk1NUAdzfVN6qMHOkw37X0q+OwVN573SD4uuwsZRhrV0fd3Ey883v@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcnRjtXR3D2tVMeMa4sldC8e/+E+CeAkS5GZUMWl/jMdpRTfg
	N7kOdA/wqsbDTfcC1D/BLdOYZpm1lMVXuCG16pLoCT6SiVC9ypqfFo+OifKp/frjeWouObnqYfp
	sIn25QO9Yss4VAQCU4ilDrHcibg8I5CpSVOXvbG/cNhhbUkrtFl0Lf6xnOJDyLm9u3J7kwgiaBp
	9iZkkcbLfgUKLjD5jrbr55m3qQfojvL8RFjg==
X-Gm-Gg: ASbGnctSayfuoX66N2jjKCxrBt31wGrVL8+ijB4wFsS4vJgBmnsP7xaOqH7k5sGhuYU
	f4Y/pDIcdOl2S4WR5gGBv4xnU59OQstqxiXTjI36r6+rAe6LsiX89TxkfkWicSopta8cvNLwwGT
	l1cVdkPhI3CyjW2YVAtQ2M4w==
X-Received: by 2002:a05:6512:404c:b0:55f:4ac2:a5a8 with SMTP id 2adb3069b0e04-57048dd4e9emr4675008e87.13.1758010518507;
        Tue, 16 Sep 2025 01:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfmZnapZ6jW8H2ratKBFIoR2HpTAVXjaSxlTVAhrOT2RXhv8ANoXC94+LYKlORORqMh9VbRWVROo8iLV4yg7Y=
X-Received: by 2002:a05:6512:404c:b0:55f:4ac2:a5a8 with SMTP id
 2adb3069b0e04-57048dd4e9emr4674984e87.13.1758010517970; Tue, 16 Sep 2025
 01:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916010947.2891471-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250916010947.2891471-1-yukuai1@huaweicloud.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 16 Sep 2025 16:15:06 +0800
X-Gm-Features: AS18NWD_OS82rbxKs-9AlzUzNmDrl5GJgR3EmMZN2DgWgG40M7uAc1UZb0ZpeWA
Message-ID: <CAHj4cs9p9H5yx+ywsb3CMUdbqGPhM+8tuBvhW=9ADiCjAqza9w@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: fix throtl_data leak during disk release
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, liangjie@lixiang.com, 
	yukuai3@huawei.com, hanguangjiang@lixiang.com, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu
A new issue was triggered with the change. Please check it. Thanks.

[  285.804104] run blktests throtl/001 at 2025-09-16 04:11:12
[  286.161894] null_blk: disk dev_nullb created

[  293.388583] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  293.394762] WARNING: possible circular locking dependency detected
[  293.400940] 6.17.0-rc6.v1+ #2 Not tainted
[  293.404952] ------------------------------------------------------
[  293.411131] find/1609 is trying to acquire lock:
[  293.415751] ffff8882911b50b0 ((&sq->pending_timer)){+.-.}-{0:0},
at: __timer_delete_sync+0x23/0x120
[  293.424817]
               but task is already holding lock:
[  293.430648] ffff8882b7794948 (&blkcg->lock){....}-{3:3}, at:
blkcg_deactivate_policy+0x1e7/0x4e0
[  293.439445]
               which lock already depends on the new lock.

[  293.447619]
               the existing dependency chain (in reverse order) is:
[  293.455096]
               -> #2 (&blkcg->lock){....}-{3:3}:
[  293.460948]        __lock_acquire+0x57c/0xbd0
[  293.465315]        lock_acquire.part.0+0xbd/0x260
[  293.470020]        _raw_spin_lock+0x37/0x80
[  293.474214]        blkg_create+0x3e2/0x1060
[  293.478401]        blkcg_init_disk+0x8f/0x460
[  293.482769]        __alloc_disk_node+0x27f/0x600
[  293.487397]        __blk_mq_alloc_disk+0x5f/0xd0
[  293.492025]        nvme_alloc_ns+0x202/0x17a0 [nvme_core]
[  293.497458]        nvme_scan_ns+0x30b/0x380 [nvme_core]
[  293.502709]        async_run_entry_fn+0x9a/0x4f0
[  293.507330]        process_one_work+0xd8b/0x1320
[  293.511956]        worker_thread+0x5f3/0xfe0
[  293.516231]        kthread+0x3b4/0x770
[  293.519992]        ret_from_fork+0x393/0x480
[  293.524272]        ret_from_fork_asm+0x1a/0x30
[  293.528728]
               -> #1 (&q->queue_lock){..-.}-{3:3}:
[  293.534749]        __lock_acquire+0x57c/0xbd0
[  293.539108]        lock_acquire.part.0+0xbd/0x260
[  293.543814]        _raw_spin_lock_irq+0x3f/0x90
[  293.548348]        throtl_pending_timer_fn+0x11c/0x15b0
[  293.553581]        call_timer_fn+0x19c/0x3e0
[  293.557853]        __run_timers+0x627/0x9f0
[  293.562041]        run_timer_base+0xe6/0x140
[  293.566312]        run_timer_softirq+0x1a/0x30
[  293.570758]        handle_softirqs+0x1fd/0x890
[  293.575205]        __irq_exit_rcu+0xfd/0x250
[  293.579477]        irq_exit_rcu+0xe/0x30
[  293.583402]        sysvec_apic_timer_interrupt+0xa1/0xd0
[  293.588717]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  293.594383]        cpuidle_enter_state+0xf5/0x2f0
[  293.599090]        cpuidle_enter+0x4e/0xa0
[  293.603197]        cpuidle_idle_call+0x213/0x370
[  293.607816]        do_idle+0x131/0x200
[  293.611568]        cpu_startup_entry+0x54/0x60
[  293.616017]        start_secondary+0x20d/0x290
[  293.620471]        common_startup_64+0x13e/0x141
[  293.625096]
               -> #0 ((&sq->pending_timer)){+.-.}-{0:0}:
[  293.631642]        check_prev_add+0xf1/0xcd0
[  293.635921]        validate_chain+0x487/0x570
[  293.640281]        __lock_acquire+0x57c/0xbd0
[  293.644641]        lock_acquire.part.0+0xbd/0x260
[  293.649345]        __timer_delete_sync+0x40/0x120
[  293.654052]        throtl_pd_free+0x19/0x40
[  293.658238]        blkcg_deactivate_policy+0x2c9/0x4e0
[  293.663378]        blk_throtl_exit+0xa5/0x100
[  293.667743]        blkcg_exit_disk+0x1f/0x270
[  293.672104]        disk_release+0x11b/0x3a0
[  293.676299]        device_release+0x9f/0x210
[  293.680579]        kobject_cleanup+0x105/0x360
[  293.685027]        null_del_dev.part.0+0x1e5/0x480 [null_blk]
[  293.690788]        nullb_group_drop_item+0xa5/0xd0 [null_blk]
[  293.696544]        configfs_rmdir+0x69f/0xac0
[  293.700910]        vfs_rmdir+0x1a5/0x5b0
[  293.704836]        do_rmdir+0x276/0x330
[  293.708677]        __x64_sys_unlinkat+0x16b/0x1e0
[  293.713393]        do_syscall_64+0x94/0x8d0
[  293.717584]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  293.723160]
               other info that might help us debug this:

[  293.731159] Chain exists of:
                 (&sq->pending_timer) --> &q->queue_lock --> &blkcg->lock

[  293.742045]  Possible unsafe locking scenario:

[  293.747972]        CPU0                    CPU1
[  293.752511]        ----                    ----
[  293.757043]   lock(&blkcg->lock);
[  293.760371]                                lock(&q->queue_lock);
[  293.766387]                                lock(&blkcg->lock);
[  293.772226]   lock((&sq->pending_timer));
[  293.776248]
                *** DEADLOCK ***

[  293.782166] 8 locks held by find/1609:
[  293.785921]  #0: ffff88813ddf6448 (sb_writers#16){.+.+}-{0:0}, at:
do_rmdir+0x1a8/0x330
[  293.793945]  #1: ffff88829e48a108 (&default_group_class[depth -
1]/1){+.+.}-{4:4}, at: do_rmdir+0x1ec/0x330
[  293.803704]  #2: ffff8881f918cb48
(&sb->s_type->i_mutex_key#22){+.+.}-{4:4}, at: vfs_rmdir+0xc0/0x5b0
[  293.812943]  #3: ffffffffc1cc4698
(&nullb_subsys.su_mutex){+.+.}-{4:4}, at: configfs_rmdir+0x57b/0xac0
[  293.822267]  #4: ffffffffc1ccc130 (&lock){+.+.}-{4:4}, at:
nullb_group_drop_item+0x50/0xd0 [null_blk]
[  293.831516]  #5: ffff88829ddb9980 (&q->blkcg_mutex){+.+.}-{4:4},
at: blkcg_deactivate_policy+0xf6/0x4e0
[  293.840926]  #6: ffff88829ddb9650 (&q->queue_lock){..-.}-{3:3}, at:
blkcg_deactivate_policy+0x10a/0x4e0
[  293.850339]  #7: ffff8882b7794948 (&blkcg->lock){....}-{3:3}, at:
blkcg_deactivate_policy+0x1e7/0x4e0
[  293.859577]
               stack backtrace:
[  293.863939] CPU: 11 UID: 0 PID: 1609 Comm: find Kdump: loaded Not
tainted 6.17.0-rc6.v1+ #2 PREEMPT(voluntary)
[  293.863946] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[  293.863949] Call Trace:
[  293.863953]  <TASK>
[  293.863959]  dump_stack_lvl+0x6f/0xb0
[  293.863970]  print_circular_bug.cold+0x38/0x45
[  293.863981]  check_noncircular+0x148/0x160
[  293.863997]  check_prev_add+0xf1/0xcd0
[  293.864001]  ? alloc_chain_hlocks+0x13e/0x1d0
[  293.864007]  ? srso_return_thunk+0x5/0x5f
[  293.864013]  ? add_chain_cache+0x12c/0x310
[  293.864022]  validate_chain+0x487/0x570
[  293.864027]  ? srso_return_thunk+0x5/0x5f
[  293.864037]  __lock_acquire+0x57c/0xbd0
[  293.864043]  ? srso_return_thunk+0x5/0x5f
[  293.864052]  lock_acquire.part.0+0xbd/0x260
[  293.864057]  ? __timer_delete_sync+0x23/0x120
[  293.864066]  ? srso_return_thunk+0x5/0x5f
[  293.864071]  ? rcu_is_watching+0x15/0xb0
[  293.864076]  ? blkcg_deactivate_policy+0x1e7/0x4e0
[  293.864080]  ? srso_return_thunk+0x5/0x5f
[  293.864085]  ? lock_acquire+0x10b/0x150
[  293.864092]  ? __timer_delete_sync+0x23/0x120
[  293.864098]  __timer_delete_sync+0x40/0x120
[  293.864103]  ? __timer_delete_sync+0x23/0x120
[  293.864111]  throtl_pd_free+0x19/0x40
[  293.864117]  blkcg_deactivate_policy+0x2c9/0x4e0
[  293.864132]  blk_throtl_exit+0xa5/0x100
[  293.864140]  blkcg_exit_disk+0x1f/0x270
[  293.864150]  disk_release+0x11b/0x3a0
[  293.864157]  device_release+0x9f/0x210
[  293.864164]  kobject_cleanup+0x105/0x360
[  293.864172]  null_del_dev.part.0+0x1e5/0x480 [null_blk]
[  293.864189]  nullb_group_drop_item+0xa5/0xd0 [null_blk]
[  293.864202]  configfs_rmdir+0x69f/0xac0
[  293.864210]  ? __pfx_may_link+0x10/0x10
[  293.864221]  ? __pfx_configfs_rmdir+0x10/0x10
[  293.864235]  vfs_rmdir+0x1a5/0x5b0
[  293.864244]  do_rmdir+0x276/0x330
[  293.864252]  ? __pfx_do_rmdir+0x10/0x10
[  293.864262]  ? ktime_get_coarse_real_ts64+0x121/0x180
[  293.864271]  ? srso_return_thunk+0x5/0x5f
[  293.864276]  ? getname_flags.part.0+0xf8/0x480
[  293.864285]  __x64_sys_unlinkat+0x16b/0x1e0
[  293.864293]  do_syscall_64+0x94/0x8d0
[  293.864298]  ? srso_return_thunk+0x5/0x5f
[  293.864304]  ? srso_return_thunk+0x5/0x5f
[  293.864309]  ? fput_close_sync+0x156/0x1c0
[  293.864316]  ? __pfx_fput_close_sync+0x10/0x10
[  293.864326]  ? srso_return_thunk+0x5/0x5f
[  293.864333]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  293.864337]  ? srso_return_thunk+0x5/0x5f
[  293.864342]  ? lockdep_hardirqs_on+0x78/0x100
[  293.864347]  ? srso_return_thunk+0x5/0x5f
[  293.864351]  ? do_syscall_64+0x139/0x8d0
[  293.864355]  ? srso_return_thunk+0x5/0x5f
[  293.864362]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  293.864366]  ? srso_return_thunk+0x5/0x5f
[  293.864371]  ? lockdep_hardirqs_on+0x78/0x100
[  293.864376]  ? srso_return_thunk+0x5/0x5f
[  293.864381]  ? do_syscall_64+0x139/0x8d0
[  293.864385]  ? srso_return_thunk+0x5/0x5f
[  293.864393]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  293.864398] RIP: 0033:0x7f13bc09bb9b
[  293.864404] Code: 77 05 c3 0f 1f 40 00 48 8b 15 71 52 0d 00 f7 d8
64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 07 01 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 52 0d 00 f7 d8 64 89
01 48
[  293.864408] RSP: 002b:00007ffee8a880e8 EFLAGS: 00000216 ORIG_RAX:
0000000000000107
[  293.864414] RAX: ffffffffffffffda RBX: 00005593f2ad7fb0 RCX: 00007f13bc0=
9bb9b
[  293.864417] RDX: 0000000000000200 RSI: 00005593f2ad7fb0 RDI: 00000000000=
00005
[  293.864421] RBP: 0000000000000200 R08: 00000000ffffffff R09: 00005593f2a=
cfd50
[  293.864424] R10: 00005593f2ac8010 R11: 0000000000000216 R12: 00005593f2a=
ce330
[  293.864427] R13: 0000000000000001 R14: 0000000000000005 R15: 00007ffee8a=
890bb
[  293.864445]  </TASK>

On Tue, Sep 16, 2025 at 9:20=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Tightening the throttle activation check in blk_throtl_activated() to
> require both q->td presence and policy bit set introduced a memory leak
> during disk release:
>
> blkg_destroy_all() clears the policy bit first during queue deactivation,
> causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
> blk_throtl_activated() fails policy check.
>
> Fix by reordering operations in disk_release() to call blk_throtl_exit()
> while throttle policy is still active. We avoid modifying blk_throtl_exit=
()
> activation check because it's intuitive that blk-throtl start from
> blk_throtl_init() and end in blk_throtl_exit().
>
> Fixes: bd9fd5be6bc0 ("blk-throttle: fix access race during throttle polic=
y activation")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCr=
V6ZvRovrr9Z+HA@mail.gmail.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 7246fc256315..64a56c8697f9 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1539,8 +1539,8 @@ int blkcg_init_disk(struct gendisk *disk)
>
>  void blkcg_exit_disk(struct gendisk *disk)
>  {
> -       blkg_destroy_all(disk);
>         blk_throtl_exit(disk);
> +       blkg_destroy_all(disk);
>  }
>
>  static void blkcg_exit(struct task_struct *tsk)
> --
> 2.39.2
>
>


--=20
Best Regards,
  Yi Zhang


