Return-Path: <cgroups+bounces-7397-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE9A7ECC0
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CC37A243A
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C16224225;
	Mon,  7 Apr 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY3q7hlK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8221B18A;
	Mon,  7 Apr 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053190; cv=none; b=Zyz4Fam2Mg57xVffI1eNs3gESEjEJnta64w7ODQcvmqVJpd8D2kDnMy9EsHXQOTB8cWO+NHpsFH35JR7wM28MAYxCJYRgJ9Tl5GH88xB2fjMHxfwM58o8Fl+ZtgOYz4JzXRZbTrJYLU92W/i0Ntwi+rSrB/R8Klmzmr2qQ8ZcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053190; c=relaxed/simple;
	bh=rgPIpw2F1T9FgYHqd7uJN0zkNUTUDI0Hss+Os5iF1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoatxzAnLA4o9GyHQq/t6d9MVrk+Bwg5GJtYIRDxtSf8Fk/Oudft5MZXnCaWSpxkzSi7tMgrZ6MgZDn0qBhsi1hYHFsxsUJRSiJ9kHd4KJqH2ikpgAPrs7WvxqnQ42lwTqIWdT4D7Y5nUgBIz3eAb/xnDVy/Djtbdd7+uLwKwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY3q7hlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4684C4CEDD;
	Mon,  7 Apr 2025 19:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053190;
	bh=rgPIpw2F1T9FgYHqd7uJN0zkNUTUDI0Hss+Os5iF1AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QY3q7hlK55IKhaEPhCKBaoXSTZ1efhgEhO/GbmAf2ioh8W3i7JBXLWmPmTyLQBRsW
	 YIV3mjzamWcAtwNYCWip9EpMOXygLUBo4yU63OlzNStw777ys0ypQOozWjx6bzRZA1
	 /mrVbmngjFdb1LNvhcK3t7mXHJw/GKGUFoPv0RKKdbvmBgd/45XtRZvuK65NMPpLYA
	 lwBYnz2dmrG1smGGNkT8uIk/DyzDA5d0QkMm+7RMyYnHldtW9TFcItf2nRgu68KGL/
	 Ittby44t92B3MwNVFb9FWZMEU5mxEXwLH5+UP0SaLApz7gCzAR8EMyTOF6J6fQ6l1W
	 NlanUd+P2rQQQ==
Date: Mon, 7 Apr 2025 09:13:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND] Circular locking dependency involving, elevator_lock,
 rq_qos_mutex and pcpu_alloc_mutex
Message-ID: <Z_QjxCZW7dh_v22Z@slm.duckdns.org>
References: <Z_QjW7zJLsuO0xp6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_QjW7zJLsuO0xp6@slm.duckdns.org>

[sorry, lost cc list somehow, resending]

Hello,

Jakub reports the following lockdep splat. It looks like q_usage_counter
somehow depends on elevator_lock. After your recent changes, iocost init
path performs memory allocation while holding elevator_lock completing the
circular dependency.

I don't understand q_usage_counter -> elevator_lock dependency. Where is
that coming from? Ah, that's q->io_lockdep_map, not the percpu_ref itself. I
think it's elevator switch acquiring elevator_lock while queue is frozen,
which puts the elevator_lock depended on from io path, and thus you can't do
reclaiming memory allocations while holding it.

The involved commits are:

 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
 9730763f4756 ("block: correct locking order for protecting blk-wbt parameters")

Can you please take a look? It looks like the second one is expanding the
locking scopes too wide.

Thanks.

[  139.119772] fb-cgroups-setu/1238 is trying to acquire lock:
[  139.119776] ffffffff867ca448 (pcpu_alloc_mutex){+.+.}-{4:4}, at: pcpu_alloc_noprof+0x96f/0x1000
[  139.169460] 
               but task is already holding lock:
[  139.169462] ffff88813ba10298 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev_frozen+0x218/0x2b0
[  139.217563] 
               which lock already depends on the new lock.
[  139.217566] 
               the existing dependency chain (in reverse order) is:
[  139.217568] 
               -> #4 (&q->rq_qos_mutex){+.+.}-{4:4}:
[  139.217577]        __mutex_lock+0x17b/0x17c0
[  139.217587]        blkg_conf_open_bdev_frozen+0x218/0x2b0
[  139.280864]        ioc_qos_write+0xc9/0xbc0
[  139.280870]        cgroup_file_write+0x1a3/0x6f0
[  139.280878]        kernfs_fop_write_iter+0x350/0x520
[  139.280885]        vfs_write+0x9b2/0xf50
[  139.280891]        ksys_write+0xf3/0x1d0
[  139.280896]        do_syscall_64+0x6e/0x190
[  139.280901]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.280906] 
               -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[  139.280915]        __mutex_lock+0x17b/0x17c0
[  139.280919]        blkg_conf_open_bdev_frozen+0x1c8/0x2b0
[  139.280925]        ioc_qos_write+0xc9/0xbc0
[  139.280929]        cgroup_file_write+0x1a3/0x6f0
[  139.280934]        kernfs_fop_write_iter+0x350/0x520
[  139.280938]        vfs_write+0x9b2/0xf50
[  139.280943]        ksys_write+0xf3/0x1d0
[  139.280947]        do_syscall_64+0x6e/0x190
[  139.280952]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.280956] 
               -> #2 (&q->q_usage_counter(io)#2){++++}-{0:0}:
[  139.280965]        blk_alloc_queue+0x5c1/0x700
[  139.280971]        blk_mq_alloc_queue+0x14c/0x230
[  139.280978]        __blk_mq_alloc_disk+0x15/0xc0
[  139.280983]        nvme_alloc_ns+0x21d/0x30f0
[  139.280988]        nvme_scan_ns+0x4f1/0x850
[  139.280991]        async_run_entry_fn+0x93/0x4f0
[  139.280997]        process_one_work+0x89e/0x1910
[  139.281001]        worker_thread+0x58d/0xcf0
[  139.281005]        kthread+0x3d5/0x7a0
[  139.281010]        ret_from_fork+0x2d/0x70
[  139.281016]        ret_from_fork_asm+0x11/0x20
[  139.281023] 
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  139.281031]        fs_reclaim_acquire+0xff/0x150
[  139.281037]        __kmalloc_noprof+0xa9/0x5f0
[  139.281042]        pcpu_create_chunk+0x23/0x6e0
[  139.281049]        pcpu_alloc_noprof+0xd34/0x1000
[  139.281054]        bts_init+0xaa/0x180
[  139.281060]        do_one_initcall+0xfa/0x500
[  139.281065]        kernel_init_freeable+0x4af/0x6d0
[  139.281070]        kernel_init+0x1b/0x1d0
[  139.281074]        ret_from_fork+0x2d/0x70
[  139.281078]        ret_from_fork_asm+0x11/0x20
[  139.281083] 
               -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[  139.281091]        __lock_acquire+0x1569/0x2640
[  139.281097]        lock_acquire+0x179/0x330
[  139.281102]        __mutex_lock+0x17b/0x17c0
[  139.281106]        pcpu_alloc_noprof+0x96f/0x1000
[  139.281111]        blk_iocost_init+0x6f/0x820
[  139.281116]        ioc_qos_write+0x468/0xbc0
[  139.281120]        cgroup_file_write+0x1a3/0x6f0
[  139.281125]        kernfs_fop_write_iter+0x350/0x520
[  139.281130]        vfs_write+0x9b2/0xf50
[  139.281134]        ksys_write+0xf3/0x1d0
[  139.281138]        do_syscall_64+0x6e/0x190
[  139.281143]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.281147] 
               other info that might help us debug this:
[  139.281149] Chain exists of:
                 pcpu_alloc_mutex --> &q->elevator_lock --> &q->rq_qos_mutex
[  139.281158]  Possible unsafe locking scenario:
[  139.281159]        CPU0                    CPU1
[  139.281161]        ----                    ----
[  139.281162]   lock(&q->rq_qos_mutex);
[  139.281166]                                lock(&q->elevator_lock);
[  139.281170]                                lock(&q->rq_qos_mutex);
[  139.281174]   lock(pcpu_alloc_mutex);
[  139.281178] 
                *** DEADLOCK ***
[  139.281179] 8 locks held by fb-cgroups-setu/1238:
[  139.281183]  #0: ffff888114b3aaf8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x22c/0x2e0
[  139.281197]  #1: ffff888148a7c400 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0xf3/0x1d0
[  139.281210]  #2: ffff88819c5a1088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x212/0x520
[  139.281223]  #3: ffff888124ec8b48 (kn->active#101){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x235/0x520
[  139.281236]  #4: ffff88813ba100a8 (&q->q_usage_counter(io)#2){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[  139.281249]  #5: ffff88813ba100e0 (&q->q_usage_counter(queue)#2){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[  139.281262]  #6: ffff88813ba105c0 (&q->elevator_lock){+.+.}-{4:4}, at: blkg_conf_open_bdev_frozen+0x1c8/0x2b0
[  139.281275]  #7: ffff88813ba10298 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev_frozen+0x218/0x2b0
[  139.281286] 
               stack backtrace:
[  139.281291] CPU: 34 UID: 0 PID: 1238 Comm: fb-cgroups-setu Tainted: G                 N  6.14.0-13254-g2ecc111972cc #114 PREEMPT(undef) 
[  139.281299] Tainted: [N]=TEST
[  139.281301] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
[  139.281304] Call Trace:
[  139.281307]  <TASK>
[  139.281309]  dump_stack_lvl+0x7e/0xc0
[  139.281318]  print_circular_bug+0x2d8/0x410
[  139.281326]  check_noncircular+0x12b/0x140
[  139.281336]  __lock_acquire+0x1569/0x2640
[  139.281348]  lock_acquire+0x179/0x330
[  139.281353]  ? pcpu_alloc_noprof+0x96f/0x1000
[  139.281365]  __mutex_lock+0x17b/0x17c0
[  139.281370]  ? pcpu_alloc_noprof+0x96f/0x1000
[  139.281375]  ? __kasan_kmalloc+0x77/0x90
[  139.281380]  ? ioc_qos_write+0x468/0xbc0
[  139.281384]  ? cgroup_file_write+0x1a3/0x6f0
[  139.281390]  ? pcpu_alloc_noprof+0x96f/0x1000
[  139.281395]  ? ksys_write+0xf3/0x1d0
[  139.281399]  ? do_syscall_64+0x6e/0x190
[  139.281404]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.281411]  ? mutex_lock_io_nested+0x1570/0x1570
[  139.281418]  ? do_raw_spin_lock+0x12c/0x270
[  139.281425]  ? find_held_lock+0x2b/0x80
[  139.281432]  ? mark_held_locks+0x49/0x70
[  139.281437]  ? _raw_spin_unlock_irqrestore+0x55/0x70
[  139.281442]  ? lockdep_hardirqs_on+0x78/0x100
[  139.281449]  ? pcpu_alloc_noprof+0x96f/0x1000
[  139.281454]  pcpu_alloc_noprof+0x96f/0x1000
[  139.281465]  ? kasan_save_track+0x10/0x30
[  139.281471]  blk_iocost_init+0x6f/0x820
[  139.281480]  ioc_qos_write+0x468/0xbc0
[  139.281485]  ? __lock_acquire+0x42c/0x2640
[  139.281494]  ? ioc_cost_model_write+0x7a0/0x7a0
[  139.281501]  ? __lock_acquire+0x42c/0x2640
[  139.281509]  ? rcu_is_watching+0x11/0xb0
[  139.281519]  ? find_held_lock+0x2b/0x80
[  139.281525]  ? kernfs_root+0xb2/0x1c0
[  139.281532]  ? kernfs_root+0xbc/0x1c0
[  139.281539]  cgroup_file_write+0x1a3/0x6f0
[  139.281546]  ? cgroup_addrm_files+0xa90/0xa90
[  139.281552]  ? __virt_addr_valid+0x1e1/0x3c0
[  139.281563]  ? cgroup_addrm_files+0xa90/0xa90
[  139.281568]  kernfs_fop_write_iter+0x350/0x520
[  139.281576]  vfs_write+0x9b2/0xf50
[  139.281583]  ? kernel_write+0x550/0x550
[  139.281600]  ksys_write+0xf3/0x1d0
[  139.281606]  ? __ia32_sys_read+0xa0/0xa0
[  139.281611]  ? rcu_is_watching+0x11/0xb0
[  139.281620]  do_syscall_64+0x6e/0x190
[  139.281626]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.281631] RIP: 0033:0x7f9d58116f8d
[  139.281643] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 a8 ca f7 ff 41 89 c0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3b 44 89 c7 48 89 45 f8 e8 df ca f7 ff 48 8b
[  139.281648] RSP: 002b:00007ffcdd0a6890 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[  139.281653] RAX: ffffffffffffffda RBX: 0000000000000043 RCX: 00007f9d58116f8d
[  139.281656] RDX: 0000000000000043 RSI: 00007f9d56ecf200 RDI: 0000000000000007
[  139.281659] RBP: 00007ffcdd0a68b0 R08: 0000000000000000 R09: 00007f9d57a19010
[  139.281662] R10: 00007f9d5800afd0 R11: 0000000000000293 R12: 0000000000000043
[  139.281665] R13: 0000000000000007 R14: 00007ffcdd0a70f0 R15: 0000000000000000
[  139.281676]  </TASK>

Thanks.

-- 
tejun

