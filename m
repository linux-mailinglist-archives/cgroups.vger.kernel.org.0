Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7A2437E4
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMJr1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 05:47:27 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55560 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMJr1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 05:47:27 -0400
Received: by mail-io1-f71.google.com with SMTP id k10so3611701ioh.22
        for <cgroups@vger.kernel.org>; Thu, 13 Aug 2020 02:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9Dlz59NWZ1Pt0j6oxZ7rlutFZtxOxRW52eAAmLe4yhU=;
        b=PpkxlhRjWiGKxYJdvy5QF3U28I756kXfqtv8EWgi9NkQYkDviErOJxfzcRqWFLa2RF
         BKAy+OuM1nkWGLb0YiNo+/kmoclg6LvdMYnakRNp+mBys2HouXs5IDBvHXKPYCljYlLd
         J3wWHy+LpsM5bgELu19aJRddQi31XEicAcg9UU6IWDsb7tcPCK+msarJXyr2StkTZeRT
         iojMETOiAAGM+P2HgGeGY8LFgN+m0BsZVBIswISmNvD7mj5UAMrgBAySnnng6R5HlHd1
         tk7RVGlJjcEZIN02LvwtRU6pXjrx1i09hYuzgRMUpRhn16ZnsVr+uVVpbjlBwabEzfqp
         plgA==
X-Gm-Message-State: AOAM530w+qEQSR1v/XGyGS0IlKRXSbLVnJ78NXEQ3pjN+SKo4Pzvnp5C
        f1aobnS/gkbHbGcPJlomTO0Hm2bWQw7VYoG2uYUJbOennkCJ
X-Google-Smtp-Source: ABdhPJxAdxBg2PCfzqxKDb9uJ/FqI62zx/scKeu/gYbyeE2wehZKlTYjqh7jAud1uZ0jJLwLBtyxlnFRbB4E9Fy3wsNYrRhX7xH/
MIME-Version: 1.0
X-Received: by 2002:a6b:ba03:: with SMTP id k3mr3995605iof.72.1597312046218;
 Thu, 13 Aug 2020 02:47:26 -0700 (PDT)
Date:   Thu, 13 Aug 2020 02:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c467c05acbf3196@google.com>
Subject: linux-next boot error: WARNING in mem_cgroup_css_alloc
From:   syzbot <syzbot+f96cbc69d9803e663664@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e6d113ac Add linux-next specific files for 20200813
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11db9fd6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2055bd0d83d5ee16
dashboard link: https://syzkaller.appspot.com/bug?extid=f96cbc69d9803e663664
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f96cbc69d9803e663664@syzkaller.appspotmail.com

mem auto-init: stack:off, heap alloc:on, heap free:off
Memory: 6458876K/7863916K available (116743K kernel code, 18258K rwdata, 21644K rodata, 2812K init, 25364K bss, 1404784K reserved, 0K cma-reserved)
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug enabled.
rcu: 	RCU debug extended QS entry/exit.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
random: get_random_bytes called from boot_init_stack_canary arch/x86/include/asm/stackprotector.h:80 [inline] with crng_init=0
random: get_random_bytes called from start_kernel+0x23b/0x46a init/main.c:957 with crng_init=0
Console: colour VGA+ 80x25
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 6301 kB
 memory used for stack traces: 4224 kB
 per task-struct memory footprint: 1920 bytes
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
ACPI: Core revision 20200717
APIC: Switch to symmetric I/O mode setup
x2apic enabled
Switched APIC routing to physical x2apic.
..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212735223b2, max_idle_ns: 440795277976 ns
Calibrating delay loop (skipped) preset value.. 4600.00 BogoMIPS (lpj=23000000)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
LSM: security= is ignored because it is superseded by lsm=
Yama: becoming mindful.
TOMOYO Linux initialized
AppArmor: AppArmor initialized
LSM support for eBPF active
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/memcontrol.c:5226 memalloc_unuse_memcg include/linux/sched/mm.h:331 [inline]
WARNING: CPU: 0 PID: 0 at mm/memcontrol.c:5226 mem_cgroup_css_alloc+0x535/0x1c30 mm/memcontrol.c:5285
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-next-20200813-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:mem_cgroup_alloc mm/memcontrol.c:5226 [inline]
RIP: 0010:mem_cgroup_css_alloc+0x535/0x1c30 mm/memcontrol.c:5284
Code: 01 00 48 8d bb 48 14 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 74 81 e8 a0 79 c0 f9 e9 77 ff ff ff <0f> 0b e9 21 fc ff ff 48 89 ef e8 3c af c5 f9 48 b8 00 00 00 00 00
RSP: 0000:ffffffff89a07e20 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffff89a99dc0 RCX: 1ffff110436f4c28
RDX: 1ffffffff1353641 RSI: ffffffff83b2f532 RDI: ffffffff89a9b208
RBP: ffff88821b7a6000 R08: 0000000000000001 R09: ffff8880a9c06b6f
R10: 0000000000000000 R11: ffffffff810000d4 R12: ffffffff8abb6bb4
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8abb6bd0
 cgroup_init_subsys+0x215/0x4d7 kernel/cgroup/cgroup.c:5587
 cgroup_init+0x359/0xa63 kernel/cgroup/cgroup.c:5713
 start_kernel+0x426/0x46a init/main.c:1035
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
