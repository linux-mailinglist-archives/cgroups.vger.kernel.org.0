Return-Path: <cgroups+bounces-15060-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BQ5OKYCxWlZ5gQAu9opvQ
	(envelope-from <cgroups+bounces-15060-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 10:55:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45220332BEB
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE79D30214FD
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3E390C85;
	Thu, 26 Mar 2026 09:48:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17D383C60
	for <cgroups@vger.kernel.org>; Thu, 26 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518512; cv=none; b=GoyiJg5HjVjf7eKTdW8004f30ZfTgeDEzpvo7wSHShIUerDx5iuNPLC0Z9ByekJd5yE6mSFX+yfsD3cRZKuAnyJSfSYsMdVDbWaejAXZ+kN4esv4+mKbHZju5DaAZZf8KqxrCSjJmKTN5zdcOqpgJeZ1QnqsgVpCkbrdJonE830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518512; c=relaxed/simple;
	bh=wlPdDfgqUR/fzj19hhiVk9ZIZdbJizMj731AQtKiM9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cf4uDJD10dcBVtyuV5quY9RlEaCzydHv8i5sdVdVUcNJktuDn/T7rlEbxqVqDIbFd7v3dXOLyKuhTSXRKZWeiUG/5XLvyO1gpGkIaU8XUpX2mX5RoY5T+t2dbvP/JFWLVZWjw3PKn5dS+GAw+x0UzdDxHkh4RYlt2HyGywkYtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-415e1e9aa5dso1619943fac.0
        for <cgroups@vger.kernel.org>; Thu, 26 Mar 2026 02:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774518506; x=1775123306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mV9qxyNpxIpit9zhhJvu6Ts4rH2PT5dFxsnJpRoxiK8=;
        b=CjHHNcoMO/u6ZvwlSVVPpqMvEqXUwDOlAhLsGdqox6r57NTYSHo8QrLQzjPeQCe7Z2
         8HL0eFF893c0pGH0TwUcfsiIaUVf7tFvrCQgkNSiIPu21cGl9yfesACASLO+0mDQI8QO
         LwX7yjDKcbr1huncGB4E7cFGPI+X6rkF0d21g/+wPJNxccwqldj3jrFNvapMfLn0KAIs
         Q4IFQvW32Hq8exsGGqJNb7C70xMk96dYpN133ztvsiDH1V9WNgqcEIlXUGpxTNAPARRn
         5EwfIs9N8Kv5V17tGM7Ju++0uqxbFiGDWicHRb3I/BJUSdQ+vSI/YEGzgwxTUcjTBgXg
         xyeg==
X-Gm-Message-State: AOJu0Yx6xQC/phEDnzJASntKG0u4xO4RcSBS5xaqh6fvj7uE+pRoSXFQ
	8Z1S2Ru0UhqBrAnfPqvFZpDjTLSdDxKF/7j4uSEdl9JE/azci/s0fpuOaUexLJ8vUuWyNRwV/EX
	qIcc0BuV4/ycPTnLFhKgS7aJ95zLWK4+gq0nQ3UNf3HiIzz9pderVoyv1T1ymYA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f00a:b0:67c:170c:d90a with SMTP id
 006d021491bc7-67dff515bd3mr3600933eaf.33.1774518506570; Thu, 26 Mar 2026
 02:48:26 -0700 (PDT)
Date: Thu, 26 Mar 2026 02:48:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c500ea.a70a0220.234938.0084.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in copy_process
From: syzbot <syzbot+327400a7d1255e319efb@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=22bf3527036b9be1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15060-lists,cgroups=lfdr.de,327400a7d1255e319efb];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 45220332BEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    785f0eb2f85d Add linux-next specific files for 20260320
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105e2a06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22bf3527036b9be1
dashboard link: https://syzkaller.appspot.com/bug?extid=327400a7d1255e319efb
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e684d8ea98b/disk-785f0eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b33fd1111047/vmlinux-785f0eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c5ee1287187/bzImage-785f0eb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+327400a7d1255e319efb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.9.3615/18333 is trying to acquire lock:
ffffffff8ea843c0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8ea843c0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4520 [inline]
ffffffff8ea843c0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4875 [inline]
ffffffff8ea843c0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x45/0x640 mm/slub.c:4917

but task is already holding lock:
ffffffff8e99cfd0 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x2a1a/0x4430 kernel/fork.c:2375

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (cgroup_threadgroup_rwsem){++++}-{0:0}:
       percpu_down_write+0x54/0x320 kernel/locking/percpu-rwsem.c:232
       cgroup_attach_lock kernel/cgroup/cgroup.c:2484 [inline]
       cgroup_procs_write_start+0x574/0x900 kernel/cgroup/cgroup.c:3043
       __cgroup_procs_write+0x9b/0x300 kernel/cgroup/cgroup.c:5326
       cgroup_procs_write+0x27/0x50 kernel/cgroup/cgroup.c:5361
       cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4249
       kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x61d/0xb90 fs/read_write.c:688
       ksys_write+0x150/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1342 [inline]
       nbd_genl_reconfigure+0x132f/0x1ea0 drivers/block/nbd.c:2431
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:796
       __sock_sendmsg net/socket.c:811 [inline]
       ____sys_sendmsg+0x589/0x8c0 net/socket.c:2668
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2722
       __sys_sendmsg net/socket.c:2754 [inline]
       __do_sys_sendmsg net/socket.c:2759 [inline]
       __se_sys_sendmsg net/socket.c:2757 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2757
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x19e/0x1420 kernel/locking/mutex.c:794
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x37b/0x1100 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2842 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4693 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4852
       do_file_open+0x23e/0x4a0 fs/namei.c:4881
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x19e/0x1420 kernel/locking/mutex.c:794
       nbd_queue_rq+0xc6/0x1100 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2842 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4693 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4852
       do_file_open+0x23e/0x4a0 fs/namei.c:4881
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x3e0 kernel/rcu/srcutree.c:1505
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x3e9/0x4e0 block/blk-sysfs.c:987
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:793 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1386
       do_initcall_level+0x104/0x190 init/main.c:1448
       do_initcalls+0x59/0xa0 init/main.c:1464
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1696
       kernel_init+0x1d/0x1d0 init/main.c:1586
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x19e/0x1420 kernel/locking/mutex.c:794
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5131 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5176 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5241
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:796
       __sock_sendmsg net/socket.c:811 [inline]
       ____sys_sendmsg+0x589/0x8c0 net/socket.c:2668
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2722
       __sys_sendmsg net/socket.c:2754 [inline]
       __do_sys_sendmsg net/socket.c:2759 [inline]
       __se_sys_sendmsg net/socket.c:2757 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2757
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4450 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4497
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1386
       do_initcall_level+0x104/0x190 init/main.c:1448
       do_initcalls+0x59/0xa0 init/main.c:1464
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1696
       kernel_init+0x1d/0x1d0 init/main.c:1586
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4312 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4326
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4520 [inline]
       slab_alloc_node mm/slub.c:4875 [inline]
       kmem_cache_alloc_lru_noprof+0x45/0x640 mm/slub.c:4917
       alloc_inode+0xb8/0x1b0 fs/inode.c:349
       iget_locked+0x131/0x6a0 fs/inode.c:1480
       kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:252
       cgroup_may_write kernel/cgroup/cgroup.c:5252 [inline]
       cgroup_css_set_fork kernel/cgroup/cgroup.c:6693 [inline]
       cgroup_can_fork+0xaf9/0xe70 kernel/cgroup/cgroup.c:6783
       copy_process+0x2a1a/0x4430 kernel/fork.c:2375
       kernel_clone+0x26d/0x8e0 kernel/fork.c:2720
       __do_sys_clone3 kernel/fork.c:3021 [inline]
       __se_sys_clone3+0x33c/0x360 kernel/fork.c:3000
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpu_hotplug_lock --> cgroup_threadgroup_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(cgroup_threadgroup_rwsem);
                               lock(cpu_hotplug_lock);
                               lock(cgroup_threadgroup_rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.9.3615/18333:
 #0: ffffffff8e99cd20 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:455 [inline]
 #0: ffffffff8e99cd20 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_css_set_fork kernel/cgroup/cgroup.c:6651 [inline]
 #0: ffffffff8e99cd20 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_can_fork+0x7c/0xe70 kernel/cgroup/cgroup.c:6783
 #1: ffffffff8e99cfd0 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x2a1a/0x4430 kernel/fork.c:2375

stack backtrace:
CPU: 1 UID: 0 PID: 18333 Comm: syz.9.3615 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4312 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4326
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4520 [inline]
 slab_alloc_node mm/slub.c:4875 [inline]
 kmem_cache_alloc_lru_noprof+0x45/0x640 mm/slub.c:4917
 alloc_inode+0xb8/0x1b0 fs/inode.c:349
 iget_locked+0x131/0x6a0 fs/inode.c:1480
 kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:252
 cgroup_may_write kernel/cgroup/cgroup.c:5252 [inline]
 cgroup_css_set_fork kernel/cgroup/cgroup.c:6693 [inline]
 cgroup_can_fork+0xaf9/0xe70 kernel/cgroup/cgroup.c:6783
 copy_process+0x2a1a/0x4430 kernel/fork.c:2375
 kernel_clone+0x26d/0x8e0 kernel/fork.c:2720
 __do_sys_clone3 kernel/fork.c:3021 [inline]
 __se_sys_clone3+0x33c/0x360 kernel/fork.c:3000
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49a759c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f49a8387ef8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f49a759c799
RDX: 00007f49a8387f10 RSI: 0000000000000058 RDI: 00007f49a8387f10
RBP: 00007f49a7632c99 R08: 0000000000000000 R09: 0000000000000058
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f49a7816038 R14: 00007f49a7815fa0 R15: 00007fff59f21a58
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

