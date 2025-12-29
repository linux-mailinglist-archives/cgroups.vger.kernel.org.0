Return-Path: <cgroups+bounces-12794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AACE649B
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 663843007975
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B267242D6C;
	Mon, 29 Dec 2025 09:29:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A901FF1C7
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767000569; cv=none; b=Wiu3fjtueINJtGNvvuOTYzs16AcEqRCt2W0rn0EtPcFlHJmBJoRpK0/PRRNB66A02PpdTRhuaD2K77q3sYmxa/eEQPj2Kavh8h2YHeWVROcsTnvjmq4kP+KmePowhhpNlMly0hK8gvZD6UJggriDlWmM7TsIH3T72/qfgrvvcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767000569; c=relaxed/simple;
	bh=ZdixqKKxulgS4Lwauvrc7sHs0a9LOP7skMUeaNO4gk8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JxFOJ15fCQLUKiPKgHVCgj1DXoFUdyj756Cs6UX+lzLSDfy1BAWf373Gze+uu64cZKV/Aotq/5KKykQxYjnus9HS6hg+LPpF1LRysdxz/8KVV9oXijgeShU5isJi2peAiIDPKToeB/Wu3M/bjPIcyJkftuiVGiANyhrSm/cUiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c7032a5b40so9045109a34.1
        for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 01:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767000567; x=1767605367;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4V5os5N56d4yyyFmq0PFU7V1UlQ3pWUZC3tYwP4xdo4=;
        b=LKkmqjzVAXIrEWuTt22VVModUBvySCpS25twNYhZ6Sh8mXZANVd8fDtPi/ZtL9A1xB
         ICbxgVY4vjtnJcMrOb7l91a94O98a3KsZp7MzRr1vRIeegyLDDp8SnTusIY9RjbQEgcs
         botI0B5DAYhfA6K8AINptkByPw2B1GJyExd1C13Mx39QdYPM8S8rXa1rydYHGjG/akQg
         Z9blJbAPOhq7FEOrPKj0UbOOt1tLvR5w6NTZAy5VeBimQv77k7hKfhYjdiPE7Vso8WUm
         E8WvHlmSx8jTWPvtppeH/cGxCIEm+jLncVqUAeqdAroefZH8qBRInDffcn++6yTNmK/h
         9ngQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiJKluHBOYIbmbQTIgzMlp3ZD2ZThNQvPtsXWX4f4CYaUgLC36KVucLt1ZnGu9L0DflHQ2p03k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zWDUt5PEPFj7Q9PAVvIosKAdBdUFQBHTZMB+NlCnKBMz4wUF
	wmk8m4PEItFL/ypo0J/4Vma7INsxJ8pvt/H7kQHf8+rIQlJGn/ExHpGAVJoglCWvP3rf9ujpj5X
	PQL5B5OAEpVVkLBOjsG73bnDw2zxRTHlssdSqG1U7dQEkXadWzOmatFL3KNw=
X-Google-Smtp-Source: AGHT+IHybrkf2tte334BKTttlZzZCy8Cn1CmBYqlYLc4xxHdUJbFlUkjQWFyUepzAAKrGZ++uSyqRin5RUGD12A1uB7t05YGRjJL
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:162a:b0:65d:163:407 with SMTP id
 006d021491bc7-65d0ea47594mr13255234eaf.22.1767000567228; Mon, 29 Dec 2025
 01:29:27 -0800 (PST)
Date: Mon, 29 Dec 2025 01:29:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695249f7.a70a0220.c527.0025.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] KMSAN: uninit-value in __sigqueue_free
From: syzbot <syzbot+6e04171f00f33c0d62fb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccd1cdca5cd4 Merge tag 'nfsd-6.19-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100e9758580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3903bdf68407a14
dashboard link: https://syzkaller.appspot.com/bug?extid=6e04171f00f33c0d62fb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a243709d75f9/disk-ccd1cdca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8eb4fcf14c57/vmlinux-ccd1cdca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bb3fe154e48/bzImage-ccd1cdca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e04171f00f33c0d62fb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __memcg_slab_free_hook+0x466/0x5a0 mm/memcontrol.c:3235
 __memcg_slab_free_hook+0x466/0x5a0 mm/memcontrol.c:3235
 memcg_slab_free_hook mm/slub.c:2364 [inline]
 slab_free mm/slub.c:6667 [inline]
 kmem_cache_free+0x812/0x13c0 mm/slub.c:6781
 __sigqueue_free+0x23a/0x270 kernel/signal.c:475
 flush_sigqueue+0x1c5/0x3f0 kernel/signal.c:486
 release_task+0x1f33/0x29a0 kernel/exit.c:305
 wait_task_zombie kernel/exit.c:1274 [inline]
 wait_consider_task+0x28e0/0x3e00 kernel/exit.c:1501
 do_wait_thread kernel/exit.c:1564 [inline]
 __do_wait+0x206/0xdd0 kernel/exit.c:1682
 do_wait+0x10e/0x470 kernel/exit.c:1716
 kernel_wait4+0x2b5/0x480 kernel/exit.c:1875
 __do_sys_wait4 kernel/exit.c:1903 [inline]
 __se_sys_wait4 kernel/exit.c:1899 [inline]
 __x64_sys_wait4+0x148/0x340 kernel/exit.c:1899
 x64_sys_call+0x31d7/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:62
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x421/0xab0 mm/page_alloc.c:5233
 alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof+0xf7/0x200 mm/mempolicy.c:2557
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x1ea/0x1710 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0x10bf/0x3930 mm/slub.c:4656
 __slab_alloc+0xa3/0x180 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0xbd5/0x1c20 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 neigh_alloc net/core/neighbour.c:522 [inline]
 ___neigh_create+0xd55/0x3b90 net/core/neighbour.c:656
 __neigh_create+0xa6/0xd0 net/core/neighbour.c:744
 ip6_finish_output2+0x160e/0x2d30 net/ipv6/ip6_output.c:128
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x903/0x10d0 net/ipv6/ip6_output.c:220
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x331/0x600 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 mld_sendpack+0xb4a/0x1770 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x1328/0x19b0 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3340
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3421
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x208/0x710 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

CPU: 0 UID: 0 PID: 1 Comm: init Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


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

