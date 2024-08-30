Return-Path: <cgroups+bounces-4603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C602965960
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D945C2819BD
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D916A92F;
	Fri, 30 Aug 2024 08:05:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB2166F0D
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005123; cv=none; b=OH1JdGhG1JYZNIbYcvjos6WlfergT5fMz+VArvZ2QEJyZdrT8/A7GmCyWzP2vAJ27kNEr/zg+8SzDKWjiPXsa/OUKRMJgNIZkGAsyH+/nXTaIHZqJhgcVZxMMwhXRvemDDIC3VRypnOeMMHr6Z2Q9oN8JogCb+8oaPTCODAHr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005123; c=relaxed/simple;
	bh=5bxH43X77Gu2Y9/t8j76aLLa2m9qKHtm2jfHVQ3UmXc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E7jHL90dr+S7470gp6f9F/Lyoc60iUE3YcH2u2B1FO3em6jwVdIB1/Iey9iRqqW76sIfP0PgYSQDfNY/ZvFR/6xmye4Jh8yZPld1Ab5XL98A6bXfhEgH/5y2fGMFYMirVqKuEy3PuGxbm//SibrAzBPzXE5xJ1svQDytlTeqY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a29c9d39dso24750139f.2
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 01:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005121; x=1725609921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9D39ijUcX6E97R2kAMdljqeFOm8YJ4EqXsQjchNZiY=;
        b=pHrW0ktDBxhrXTdGoL+76Oku7dRT0SXZ5mJoRWlJs3sk1/6/dZOj3gWqoCB4vRbllr
         b8IP9WqehjMid46SKaGoK2KdbB5q2AIuroBvhRSJ0ZzY33QuWlCq+S3nWZi8i2DhNB+i
         1TChXudUQDd17EX5EIA9i5sMrohjpSO7x0XRL3Ml1Yimi1ICwqj3xjtEyEqmjXQJ2Yj2
         NidxYPcbngOWYvY5UVLFHGsCWmzZSgGqyJb2BxfAhi7AZwCTLdAQO0rlZsJ3AKbb95Qp
         XM1MFrs/YzDo82Y3spVkk8JctVm8kjAjtTidhk38YCLAQHDWuQMpbRb4jt1ekfk7Xj4/
         2pjw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSBelHJY9CsScWbrGF8B7frJMhJ0ceWY/bKH1c1GQBOldeiDaXj5hxHc641dG3vzfqCtqO2qj@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbzCl85u00hlVAnkQBQnGkGqTvHJoki8LNZo+GRG5Up7K6fP+
	h+CN3uBI1mD7GlX57fqQPusjH7ZweKeNkCHQtTQsOCwlY844qslpFeCG0ET4i2jbCOKu893V0My
	I+F3F9WIfgy5hS8WlorZ1GVXSflJpzFaal3+S2N/c/YsrLhkEWr2NC8c=
X-Google-Smtp-Source: AGHT+IH6dTGzDaHrL29Cb2aP05jI7sTyMfIbtjCfwK9fwwhTB7LcWl252s1jdPMPExyEnJ6/XTmAd/D8Zrder1VHeO2X1txxNHvh
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39f40ed447cmr493765ab.1.1725005121545; Fri, 30 Aug 2024
 01:05:21 -0700 (PDT)
Date: Fri, 30 Aug 2024 01:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000817cf10620e20d33@google.com>
Subject: [syzbot] [cgroups?] [mm?] KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter
From: syzbot <syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107a8463980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fafac02e339cc84
dashboard link: https://syzkaller.appspot.com/bug?extid=e099d407346c45275ce9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a8763df1c20/disk-20371ba1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9678a905383/vmlinux-20371ba1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef6e49adc393/bzImage-20371ba1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter

read-write to 0xffff888114b82668 of 4 bytes by task 5527 on cpu 1:
 mem_cgroup_iter+0x28e/0x380 mm/memcontrol.c:1080
 shrink_node_memcgs mm/vmscan.c:5924 [inline]
 shrink_node+0x74a/0x1d40 mm/vmscan.c:5948
 shrink_zones mm/vmscan.c:6192 [inline]
 do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
 try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
 try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
 try_charge mm/memcontrol-v1.h:20 [inline]
 charge_memcg mm/memcontrol.c:4439 [inline]
 mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
 __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
 swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
 swapin_readahead+0xe4/0x760 mm/swap_state.c:882
 do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
 handle_pte_fault mm/memory.c:5524 [inline]
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x3b9/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

read to 0xffff888114b82668 of 4 bytes by task 5528 on cpu 0:
 mem_cgroup_iter+0xba/0x380 mm/memcontrol.c:1018
 shrink_node_memcgs mm/vmscan.c:5869 [inline]
 shrink_node+0x458/0x1d40 mm/vmscan.c:5948
 shrink_zones mm/vmscan.c:6192 [inline]
 do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
 try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
 try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
 try_charge mm/memcontrol-v1.h:20 [inline]
 charge_memcg mm/memcontrol.c:4439 [inline]
 mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
 __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
 swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
 swapin_readahead+0xe4/0x760 mm/swap_state.c:882
 do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
 handle_pte_fault mm/memory.c:5524 [inline]
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 __get_user_8+0x11/0x20 arch/x86/lib/getuser.S:94
 fetch_robust_entry kernel/futex/core.c:783 [inline]
 exit_robust_list+0x31/0x280 kernel/futex/core.c:811
 futex_cleanup kernel/futex/core.c:1043 [inline]
 futex_exit_release+0xe3/0x130 kernel/futex/core.c:1144
 exit_mm_release+0x1a/0x30 kernel/fork.c:1637
 exit_mm+0x38/0x190 kernel/exit.c:544
 do_exit+0x55e/0x1720 kernel/exit.c:869
 do_group_exit+0x102/0x150 kernel/exit.c:1031
 get_signal+0xf2f/0x1080 kernel/signal.c:2917
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000522 -> 0x00000528

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 5528 Comm: syz.3.488 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================
syz.3.488 (5528) used greatest stack depth: 9096 bytes left


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

