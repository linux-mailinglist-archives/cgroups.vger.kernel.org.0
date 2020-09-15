Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7C26A5A5
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIOMy0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgIOMxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 08:53:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88ADC06174A
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 05:53:40 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e2so1814148vsr.7
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVw5oFpZQxlIPS34GtsTwPTcUKJcK/naikR5mIzdcG8=;
        b=sFZVpzKN7psJXeyvNzH7SERnOdmFLVumI6DSTp1n6xTZkbd/Kht4080XC/pRPiLL8O
         gUhEWCubO4RKD+wW5AQjsQXrYWQY1gUyFV1iQODHKHacoTMrDuBDe4kwOec6lHtgyQLm
         tD3rslYWhrhad5BxVom4T0iNJTqOH3IhBNndBs+d203IAq/BFYM5wsn31GyWcH1dc1xe
         OoHl9/uzg0oG63l5mJ7WEOwILpERqZ8GR2yMKxf92KZdAS31/I3R0lH9y5i/qpoChG5A
         6loAfmQfZUrFFX2tKkEd0ODdi8FaVIIAqEPGykkq0bCwKPkuJKXO7JUZjcz5sTcB/RHI
         6u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVw5oFpZQxlIPS34GtsTwPTcUKJcK/naikR5mIzdcG8=;
        b=WCwjGRXyU++WAe0XoC2L5iCS7oUL9EHy5Jma5f5PuJZhOwcjf4rnTbyYal5ZRrXrc0
         i73OU5x7f0ATdVtyn0h3LKDdICLe28PfmkjuVNbl+b74GfVnVUgh5zkBsNFhjqyXbztU
         p7JZpZuOpQiHdGC4567tsj9S3vyo5lz8LhXjn4I2aj4eHsyg7qQtsZBGbHjhIwiaG4Rt
         IiluXriIAaZEfGx2GiHWyc4I3zzsuG81vRMkn8UR0vOmt/V+zs/8f0fgfGObLfLsUIkX
         xw/pT68MaDYWf6yFdpnsQQ826pa39NkkgAc0k7h29Sj619Fvcls6v8nalWN2RePBj6Qh
         wEWA==
X-Gm-Message-State: AOAM531CK/ZuXMaIbkoFw6Hd2hNfI8Qc3qNsLU5QOG0gYzlUCEMITTAL
        1bBHAXBMEkX8WDyGKGyU2wy3tE0jDujDcpt2RZ5hJg==
X-Google-Smtp-Source: ABdhPJxjmcbfNwvT9QQ2mNrQCHtqVf/08lf9rc87+6FSs4ZSQ/7xgWjyWXM74vSzJsqHNxK/sUvLTnWPGgnD/Y3TFcY=
X-Received: by 2002:a67:80d2:: with SMTP id b201mr10001565vsd.12.1600174419320;
 Tue, 15 Sep 2020 05:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910183318.20139-1-willy@infradead.org> <alpine.LSU.2.11.2009150059310.1550@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2009150059310.1550@eggly.anvils>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Sep 2020 18:23:27 +0530
Message-ID: <CA+G9fYvqbKPHoYbU7w2bPkOF_vgbYgEHavLDxXQ4O5xUFHGCuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Return head pages from find_*_entry
To:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ricardo.canuelo@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 15 Sep 2020 at 13:56, Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 10 Sep 2020, Matthew Wilcox (Oracle) wrote:
>
> > This patch series started out as part of the THP patch set, but it has
> > some nice effects along the way and it seems worth splitting it out and
> > submitting separately.
> >
> > Currently find_get_entry() and find_lock_entry() return the page
> > corresponding to the requested index, but the first thing most callers do
> > is find the head page, which we just threw away.  As part of auditing
> > all the callers, I found some misuses of the APIs and some plain
> > inefficiencies that I've fixed.
> >
> > The diffstat is unflattering, but I added more kernel-doc and a new wrapper.
> >
> > v2:
> >  - Rework how shmem_getpage_gfp() handles getting a head page back from
> >    find_lock_entry()
> >  - Renamed find_get_swap_page() to find_get_incore_page()
> >  - Make sure find_get_incore_page() doesn't return a head page
> >  - Fix the missing include of linux/shmem_fs.h
> >  - Move find_get_entry and find_lock_entry prototypes to mm/internal.h
> >  - Rename thp_valid_index() to thp_contains()
> >  - Fix thp_contains() for hugetlbfs and swapcache
> >  - Add find_lock_head() wrapper around pagecache_get_page()
> >
> > Matthew Wilcox (Oracle) (8):
> >   mm: Factor find_get_incore_page out of mincore_page
> >   mm: Use find_get_incore_page in memcontrol
> >   mm: Optimise madvise WILLNEED
> >   proc: Optimise smaps for shmem entries
> >   i915: Use find_lock_page instead of find_lock_entry
> >   mm: Convert find_get_entry to return the head page
> >   mm/shmem: Return head page from find_lock_entry
> >   mm: Add find_lock_head

While running kselftest mincore tests the following kernel BUG reported on the
linux next-20200915 tag on x86_64, i386 and arm64.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 6b02addb1d1748d21dd1261e46029b264be4e5a0
  git describe: next-20200915
  make_kernelversion: 5.9.0-rc5
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/860/config

Test case:
---------------

 * Tests the user interface. This test triggers most of the documented
 * error conditions in mincore().
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/plain/tools/testing/selftests/mincore/mincore_selftest.c

kernel BUG:
-----------------
[  710.472860] kselftest: Running tests in mincore
[  710.554790] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  710.561765] #PF: supervisor read access in kernel mode
[  710.566920] #PF: error_code(0x0000) - not-present page
[  710.572065] PGD 80000003fd5b9067 P4D 80000003fd5b9067 PUD 45903f067 PMD 0
[  710.578957] Oops: 0000 [#1] SMP PTI
[  710.582450] CPU: 0 PID: 19025 Comm: mincore_selftes Tainted: G
  W     K   5.9.0-rc5-next-20200915 #1
[  710.592094] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  710.599574] RIP: 0010:PageHuge+0x6/0x40
[  710.603411] Code: c3 0f 1f 00 0f 1f 44 00 00 55 48 89 d6 48 89 e5
e8 ef fe ff ff 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00 55 <48> 8b 07 48 89 e5 a9 00 00 01 00 75 09 48 8b 47 08 83 e0 01
74 17
[  710.622149] RSP: 0018:ffffb0e2002bfcc0 EFLAGS: 00010246
[  710.627373] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  710.634498] RDX: ffff9f231b2518c0 RSI: ffffffffa272b340 RDI: 0000000000000000
[  710.641620] RBP: ffffb0e2002bfce8 R08: 0000000000000002 R09: 0000000000000000
[  710.648747] R10: ffffb0e2002bfb20 R11: ffffffffa272b340 R12: ffff9f23193c5e68
[  710.655876] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
[  710.663003] FS:  00007fa4c9ea24c0(0000) GS:ffff9f231fc00000(0000)
knlGS:0000000000000000
[  710.671088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  710.676824] CR2: 0000000000000000 CR3: 00000004044d0004 CR4: 00000000003706f0
[  710.683949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  710.691073] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  710.698196] Call Trace:
[  710.700644]  ? find_get_incore_page+0xc6/0x120
[  710.705089]  mincore_page+0x12/0x60
[  710.708580]  __mincore_unmapped_range+0x78/0xc0
[  710.713105]  mincore_pte_range+0x269/0x300
[  710.717206]  __walk_page_range+0x5ab/0xb60
[  710.721308]  walk_page_range+0xab/0x150
[  710.725152]  __x64_sys_mincore+0x13c/0x330
[  710.729251]  do_syscall_64+0x37/0x50
[  710.732831]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  710.737882] RIP: 0033:0x7fa4c99be2d7
[  710.741462] Code: 73 01 c3 48 8b 0d c1 fb 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 1b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 fb 2b 00 f7 d8 64 89
01 48
[  710.760206] RSP: 002b:00007ffcb103baf8 EFLAGS: 00000203 ORIG_RAX:
000000000000001b
[  710.767770] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa4c99be2d7
[  710.774897] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00007fa4c9ea6000
[  710.782020] RBP: 00007ffcb103bc40 R08: 00000000ffffffff R09: 0000000000000000
[  710.789144] R10: 0000000000000021 R11: 0000000000000203 R12: 0000000000400d00
[  710.796268] R13: 00007ffcb103be10 R14: 0000000000000000 R15: 0000000000000000
[  710.803395] Modules linked in: sch_fq 8021q iptable_filter xt_mark
ip_tables cls_bpf sch_ingress veth algif_hash x86_pkg_temp_thermal
fuse [last unloaded: memory_notifier_error_inject]
[  710.819814] CR2: 0000000000000000
[  710.823128] ---[ end trace 67d1a6d0ea1b24e3 ]---
[  710.827746] RIP: 0010:PageHuge+0x6/0x40
[  710.831584] Code: c3 0f 1f 00 0f 1f 44 00 00 55 48 89 d6 48 89 e5
e8 ef fe ff ff 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00 55 <48> 8b 07 48 89 e5 a9 00 00 01 00 75 09 48 8b 47 08 83 e0 01
74 17
[  710.850322] RSP: 0018:ffffb0e2002bfcc0 EFLAGS: 00010246
[  710.855546] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  710.862672] RDX: ffff9f231b2518c0 RSI: ffffffffa272b340 RDI: 0000000000000000
[  710.869803] RBP: ffffb0e2002bfce8 R08: 0000000000000002 R09: 0000000000000000
[  710.876928] R10: ffffb0e2002bfb20 R11: ffffffffa272b340 R12: ffff9f23193c5e68
[  710.884050] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
[  710.891175] FS:  00007fa4c9ea24c0(0000) GS:ffff9f231fc00000(0000)
knlGS:0000000000000000
[  710.899253] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  710.904990] CR2: 0000000000000000 CR3: 00000004044d0004 CR4: 00000000003706f0
[  710.912113] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  710.919236] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  710.926360] note: mincore_selftes[19025] exited with preempt_count 1
[  710.932704] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:49
[  710.942950] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
19025, name: mincore_selftes
[  710.951631] INFO: lockdep is turned off.
[  710.955551] irq event stamp: 190
[  710.958785] hardirqs last  enabled at (189): [<ffffffffa0bda53c>]
get_page_from_freelist+0x24c/0x14b0
[  710.967995] hardirqs last disabled at (190): [<ffffffffa18c7921>]
irqentry_enter+0x21/0x50
[  710.976247] softirqs last  enabled at (36): [<ffffffffa1c00308>]
__do_softirq+0x308/0x42a
[  710.984419] softirqs last disabled at (11): [<ffffffffa1a00f82>]
asm_call_on_stack+0x12/0x20
[  710.992852] CPU: 0 PID: 19025 Comm: mincore_selftes Tainted: G
D W     K   5.9.0-rc5-next-20200915 #1
[  711.002496] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  711.009967] Call Trace:
[  711.012412]  dump_stack+0x7d/0x9f
[  711.015724]  ___might_sleep+0x163/0x250
[  711.019562]  __might_sleep+0x4a/0x80
[  711.023141]  exit_signals+0x33/0x2f0
[  711.026713]  do_exit+0xa9/0xcb0
[  711.029858]  ? __x64_sys_mincore+0x13c/0x330
[  711.034125]  rewind_stack_do_exit+0x17/0x20
[  711.038308] RIP: 0033:0x7fa4c99be2d7
[  711.041888] Code: 73 01 c3 48 8b 0d c1 fb 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 1b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 fb 2b 00 f7 d8 64 89
01 48
[  711.060633] RSP: 002b:00007ffcb103baf8 EFLAGS: 00000203 ORIG_RAX:
000000000000001b
[  711.068197] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa4c99be2d7
[  711.075321] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00007fa4c9ea6000
[  711.082445] RBP: 00007ffcb103bc40 R08: 00000000ffffffff R09: 0000000000000000
[  711.089570] R10: 0000000000000021 R11: 0000000000000203 R12: 0000000000400d00
[  711.096693] R13: 00007ffcb103be10 R14: 0000000000000000 R15: 0000000000000000
[  737.104310] rcu: INFO: rcu_sched self-detected stall on CPU
[  737.109887] rcu: 0-....: (26000 ticks this GP)
idle=1a2/1/0x4000000000000000 softirq=102446/102446 fqs=6463
[  737.119792] (t=26016 jiffies g=173197 q=1522)
[  737.124238] NMI backtrace for cpu 0
[  737.127731] CPU: 0 PID: 19025 Comm: mincore_selftes Tainted: G
D W     K   5.9.0-rc5-next-20200915 #1
[  737.137376] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  737.144856] Call Trace:
[  737.147309]  <IRQ>
[  737.149330]  dump_stack+0x7d/0x9f
[  737.152649]  nmi_cpu_backtrace+0xa4/0xc0
[  737.156574]  ? lapic_can_unplug_cpu+0xa0/0xa0
[  737.160931]  nmi_trigger_cpumask_backtrace+0x97/0xd0
[  737.165889]  arch_trigger_cpumask_backtrace+0x19/0x20
[  737.170933]  rcu_dump_cpu_stacks+0xbc/0xec
[  737.175025]  rcu_sched_clock_irq+0x729/0x9c0
[  737.179296]  ? account_system_index_time+0x112/0x1f0
[  737.184256]  ? tick_sched_do_timer+0x60/0x60
[  737.188528]  update_process_times+0x28/0x60
[  737.192711]  tick_sched_handle.isra.21+0x34/0x50
[  737.197322]  tick_sched_timer+0x6d/0x80
[  737.201154]  __hrtimer_run_queues+0x1d0/0x450
[  737.205514]  hrtimer_interrupt+0xe7/0x240
[  737.209527]  __sysvec_apic_timer_interrupt+0x79/0x1f0
[  737.214578]  asm_call_on_stack+0x12/0x20
[  737.218504]  </IRQ>
[  737.220611]  sysvec_apic_timer_interrupt+0x75/0xa0
[  737.225402]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  737.230541] RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0
[  737.236017] Code: f6 85 f6 75 3e f0 0f ba 2f 08 0f 92 c0 0f b6 c0
c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 18 85 c0 75 04 eb
08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 5d c3 f6 c4 01 75
04 c6
[  737.254755] RSP: 0018:ffffb0e2002bfc48 EFLAGS: 00000202
[  737.259980] RAX: 0000000000000101 RBX: ffff9f23167158c0 RCX: 0000000000000000
[  737.267103] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f23167158c0
[  737.274230] RBP: ffffb0e2002bfc48 R08: 0000000000000001 R09: 0000000000000000
[  737.281353] R10: 0000000000000000 R11: 0000000000000000 R12: 00007fa4c9ea1000
[  737.288478] R13: 00007fa4c9ea1000 R14: ffffb0e2002bfe20 R15: 00007fa4c9ea1000
[  737.295605]  do_raw_spin_lock+0xb6/0xc0
[  737.299440]  _raw_spin_lock+0x37/0x40
[  737.303098]  ? unmap_page_range+0x4a6/0xd00
[  737.307275]  unmap_page_range+0x4a6/0xd00
[  737.311294]  unmap_single_vma+0x7d/0xf0
[  737.315138]  unmap_vmas+0xd4/0x160
[  737.318544]  exit_mmap+0xb1/0x1c0
[  737.321866]  mmput+0x6a/0x130
[  737.324843]  do_exit+0x359/0xcb0
[  737.328076]  rewind_stack_do_exit+0x17/0x20
[  737.332260] RIP: 0033:0x7fa4c99be2d7
[  737.335831] Code: Bad RIP value.
[  737.339054] RSP: 002b:00007ffcb103baf8 EFLAGS: 00000203 ORIG_RAX:
000000000000001b
[  737.346613] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa4c99be2d7
[  737.353743] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00007fa4c9ea6000
[  737.360867] RBP: 00007ffcb103bc40 R08: 00000000ffffffff R09: 0000000000000000
[  737.367992] R10: 0000000000000021 R11: 0000000000000203 R12: 0000000000400d00
[  737.375116] R13: 00007ffcb103be10 R14: 0000000000000000 R15: 0000000000000000
[  815.107312] rcu: INFO: rcu_sched self-detected stall on CPU
[  815.112890] rcu: 0-....: (103727 ticks this GP)
idle=1a2/1/0x4000000000000000 softirq=102446/102446 fqs=25897
[  815.122966] (t=104019 jiffies g=173197 q=1545)
[  815.127492] NMI backtrace for cpu 0
[  815.130985] CPU: 0 PID: 19025 Comm: mincore_selftes Tainted: G
D W     K   5.9.0-rc5-next-20200915 #1
[  815.140628] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  815.148099] Call Trace:
[  815.150542]  <IRQ>
[  815.152556]  dump_stack+0x7d/0x9f
[  815.155876]  nmi_cpu_backtrace+0xa4/0xc0
[  815.159799]  ? lapic_can_unplug_cpu+0xa0/0xa0
[  815.164150]  nmi_trigger_cpumask_backtrace+0x97/0xd0
[  815.169108]  arch_trigger_cpumask_backtrace+0x19/0x20
[  815.174151]  rcu_dump_cpu_stacks+0xbc/0xec
[  815.178245]  rcu_sched_clock_irq+0x729/0x9c0
[  815.182515]  ? account_system_index_time+0x112/0x1f0
[  815.187473]  ? tick_sched_do_timer+0x60/0x60
[  815.191744]  update_process_times+0x28/0x60
[  815.195922]  tick_sched_handle.isra.21+0x34/0x50
[  815.200533]  tick_sched_timer+0x6d/0x80
[  815.204365]  __hrtimer_run_queues+0x1d0/0x450
[  815.208725]  hrtimer_interrupt+0xe7/0x240
[  815.212738]  __sysvec_apic_timer_interrupt+0x79/0x1f0
[  815.217789]  asm_call_on_stack+0x12/0x20
[  815.221713]  </IRQ>
[  815.223811]  sysvec_apic_timer_interrupt+0x75/0xa0
[  815.228597]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  815.233734] RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0

full test log link,
https://lkft.validation.linaro.org/scheduler/job/1765602#L12129
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915/testrun/3198585/suite/linux-log-parser/test/check-kernel-warning-1765604/log
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915/testrun/3198610/suite/linux-log-parser/test/check-kernel-oops-1765633/log

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

-- 
Linaro LKFT
https://lkft.linaro.org
