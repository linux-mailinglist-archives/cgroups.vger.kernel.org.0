Return-Path: <cgroups+bounces-16780-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WEGDIjUBKGpL7AIAu9opvQ
	(envelope-from <cgroups+bounces-16780-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 14:04:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363565FCEB
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 14:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YAwKpyJI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16780-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16780-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1340C301FE40
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A51405878;
	Tue,  9 Jun 2026 11:58:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36165404BF4
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 11:58:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006291; cv=pass; b=OqSpA/3tlYf1dKyTcqQwrt2Fr2aMSs/w4e+witWJfmXkIRQXX0sXoH4MtYeCLl0KZou5a4YAXLDqVXegKYtpQRoygqcjhKp/IfjKribCRNN2sywMwcpkYfyYMXZoF9yXcUxv/8HmDfrjZeLkBmJ12HKfeYzJB8KZI/4xuKzrOwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006291; c=relaxed/simple;
	bh=AqPEbjuI8O2qmDJizy+1dDD59nTXwsWVKYwrVLKC0WU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QcKNnxYlFPzFuAJqdPRuHx5Mysp31D8lW9PvPHDjXJex2XbOkj0G3QqGi7c6xAFEZdxDqKw2z0QIFa7Fd3vZbXEQox4g6NyKphMOxIFLi/e924oibFGKQpOdTfXkhZZx5KvYWT6qT//g9Z1uqNbSjJizQ/ENG4Zql4Zi+DQ9vc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAwKpyJI; arc=pass smtp.client-ip=209.85.219.65
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so46426896d6.3
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 04:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781006289; cv=none;
        d=google.com; s=arc-20240605;
        b=k95HUWXToflIwbW6BT8t/lNbY0kiLhGX3gVsuieI2GFaNDhBF/eLXtCpWJtp2hU3P7
         IA+SasU6+hTOncP7BK2CF/9pJ2+dbtX0SYAy7lNSSfw7aFFIr8dLyOXNh0Qi8VTw46aq
         kvK0L496odpdJ3SD53bZM1B3xcreP01tZeUmatgNp1erqudxDDTvaI6UZ1REL5mmjS1e
         ho6E7YIs/N/0gOmk+dsvf5gEyzJ9a9SE5hTSef4oJUGCgGVbo6jiArdLxVGwfpeNrlv+
         HIj6bMqVh1CO1J8JTnBXeL9QrZxu/kit1Kj3wjLPPtlUqiHlQfGkLBQcuDRLKEcwVRte
         yCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iZeRKVQ5LbVTuXoF338pmAKQHGvQwIxz8tAlACAULxI=;
        fh=h53ZNAS/y7zdVL2+CvhlmZFQ1rSdSpfv4hTrOWEnM0c=;
        b=VBaomnWKHgoeXGwymk9x83u7uYTjLG4NKLnEIfA0jeUJ/MvfiNFDLwC4NO2FqNRsc6
         ok6VoCFQUVqxLKx+E69XkdqXAVEKYGlu+mr7/YNlbJqj8Zk5mLJGnrgh8qyrK7KjToUO
         Uu676qr681nbY2VyVB75VGFZnDv8vU6dX6UqPr1tJEdxw9C6J0RyjrGvrZgkIlnp2kPR
         B3EpQ/GcuZjoeJUdi/jDLO0rnJ5fMfvSiuS5TmSQmtiEgcJ1qaEmrQoNJTc2dlRdKleq
         ZAXlc+6zKnvXqYMfCVBF3R7FtezK29IuDrQYKRozg3gZbuS7kUwrUrKKIrRfRugSX2oU
         /Hfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781006289; x=1781611089; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZeRKVQ5LbVTuXoF338pmAKQHGvQwIxz8tAlACAULxI=;
        b=YAwKpyJI3iV8RBQyZI/aHhO3H8zkS2/BStViqK428zG/w9CEiaXvg/GztgDXyi97MP
         w4ad67xWWyUk0u2r0JJhr+XzP/r5sOlN8SKN9de8fdZrh5EkvgnHwkbfWXwf5M0l9srb
         dKDIMIDh7rW5Bb7ol4HqAsqe9gG0Dl6uTMAhhTX52Tg+eF9dTKICjAv/1ZKJ/z2jVwIr
         ajHgRvmz8KneLeD1QH4pIOoaMf5/TSJ9F3zxDdyCHQPdPgOUPG52F7Hl/tcJQWZhiY0I
         IRLMJWbnaKcb73xKO+wwkYhk7dq9kU1S0ezGRgA/y/ZVVe98SPS2NrcCq4BcVw7d9pEm
         SUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006289; x=1781611089;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZeRKVQ5LbVTuXoF338pmAKQHGvQwIxz8tAlACAULxI=;
        b=AzbNSnVNUTdIds3iBQJPe5pip6QPqqOhrOhuZJFD7jO3B9QF1ZbU2g3NzdAcm72YEl
         McRuQjsU6BVKCIMeHpPmQC6o1ksrqFu4Q9hbVzk05Avh2IgMtYraH2bJtcDVHo+EmqqB
         bTaGi58aNwk7hbcspAG7F2OXGpnrGT52cyGNe1Iomsd7WpWraUEwusF15fdYm6oZBc00
         sSarXda8HLz5TA+eYZrGjBpHLUgcD8DclQpdJr7HQ5jfTNJGgL9k+fnMqWE46Uc1zYta
         smwDJM2TkNnM8GQMU4km4XxgZnXnPbYEfIdgTZkM1oCg7v6jvepYs37JTK7UH92Ovq9I
         dBtA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ajs31S1U++Fqv04a66phYxXsNcV/y93WQv6F0QJqy1dTW6b5IUxSLqvt2xOZFWLTrd6xxIs5s@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYh6Y6bmOYz74RLlOJ4HV8vIrdh6RBXvwymneHqPtiscZnfln
	qgCpNMqfucJfhkxSpsE+XmglozQi/IqJpprImML1O/PGzJe1vN7uev7hGd0LLFVOkg49gU6IWBY
	9PBeFI/zKVwyWiRK9c1V5+ACdeFgm9RA=
X-Gm-Gg: Acq92OGWiQa8z1A53v+CIh49PMEWp8UhHMqBn7J17ZWi+3hv8utbh9KtOq2yzgzhD3P
	e0yBQ1hZGbMLroSsaEqC0YgmaWkiAazyq0BSzvmBhb3nD3+pUMBCzsdSp00QvpmyJvxESLPIUY6
	EkxQgc/k+6Rgqi4HV/kfYsFWUPW8Rjs5fMxCg6exuRGvnvbTRWtynneZZq+rfbBcPfSQvJCGyre
	QLjpEqsRv8i1zHxlFttbOVDWf5tTk5ifqtnxjBIMJgQdGPNiStNyzg7xrzQQNv7gUADdEpHgbv/
	q/osQsDqAZz7U03aOw==
X-Received: by 2002:a0c:c304:0:b0:8ca:f1c:6493 with SMTP id
 6a1803df08f44-8cee5fb6e13mr208831746d6.1.1781006288937; Tue, 09 Jun 2026
 04:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:57:56 +0800
X-Gm-Features: AVVi8Ce3ZhIf6vufvLeXykI-E_VWQgIfFmK9P2r5yIKN5OfCTKyW7Gf1NkYAYlg
Message-ID: <CAHPqNmzgCY+sHOOG8YVrCFO-7oh6TBeL4SCHEcfVvH6J1SUVdg@mail.gmail.com>
Subject: [Kernel Bug] INFO: rcu detected stall in count_memcg_event_mm
To: syzkaller@googlegroups.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16780-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:syzkaller@googlegroups.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8363565FCEB

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. INFO: rcu
detected stall in count_memcg_event_mm. Details are as follows.

Kernel commit: v5.15.189
Kernel config: see attachment
report: see attachment
Syz repro: see attachment

We are currently analyzing the root cause. We will provide further
updates in this thread as soon as we have more information.

Best regards,
Longxing Li

==================================================================
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: Tasks blocked on level-0 rcu_node (CPUs 0-0): P12059/1:b..l
(detected by 0, t=10502 jiffies, g=18873, q=1488)
task:systemd-sysctl  state:R  running task     stack:28320 pid:12059
ppid: 10470 flags:0x00000200
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5030 [inline]
 __schedule+0xd98/0x5b40 kernel/sched/core.c:6376
 preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:6780
 irqentry_exit+0x31/0x80 kernel/entry/common.c:432
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:676
RIP: 0010:task_css include/linux/cgroup.h:496 [inline]
RIP: 0010:mem_cgroup_from_task+0x9/0x140 mm/memcontrol.c:935
Code: 0f fa ff 31 c0 5b 5d c3 b8 f4 ff ff ff eb f6 e8 3d b4 fa ff eb
be 66 66 2e 0f 1f 84 00 00 00 00 00 48 85 ff 0f 84 0f 01 00 00 <48> b8
00 00 00 00 00 fc ff df 55 53 48 89 fb 48 8d bf 60 13 00 00
RSP: 0000:ffffc9000dbafe58 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81ae3af8
RDX: ffff8880209d24c0 RSI: ffffffff81ae393d RDI: ffff8880209d24c0
RBP: ffff8880209d24c0 R08: 0000000000000000 R09: ffffffff93062a27
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000014
R13: ffffc9000dbaff58 R14: ffff8880209d24c0 R15: 0000000000000010
 count_memcg_event_mm.part.0+0xa5/0x340 include/linux/memcontrol.h:1079
 count_memcg_event_mm include/linux/memcontrol.h:609 [inline]
 handle_mm_fault+0xcf/0x770 mm/memory.c:4863
 do_user_addr_fault+0x4a5/0x1150 arch/x86/mm/fault.c:1357
 handle_page_fault arch/x86/mm/fault.c:1445 [inline]
 exc_page_fault+0x58/0xd0 arch/x86/mm/fault.c:1501
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:606
RIP: 0033:0x7f7a1e783970
RSP: 002b:00007ffeabd9ad48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007f7a1e464608 RCX: fffffffffffffeb8
RDX: 00007f7a1e4661a4 RSI: 00007f7a1e45c8f6 RDI: 00007f7a1e45c827
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000002b0 R11: 0000000000000246 R12: 00007ffeabd9ae88
R13: 0000000000000001 R14: 00007f7a1e464610 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10466 jiffies! g18873 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28656 pid:   15
ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5030 [inline]
 __schedule+0xd98/0x5b40 kernel/sched/core.c:6376
 schedule+0x115/0x250 kernel/sched/core.c:6459
 schedule_timeout+0x153/0x2a0 kernel/time/timer.c:1914
 rcu_gp_fqs_loop+0x1c0/0x980 kernel/rcu/tree.c:1972
 rcu_gp_kthread+0x1e6/0x330 kernel/rcu/tree.c:2145
 kthread+0x3d0/0x4c0 kernel/kthread.c:334
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 0
CPU: 0 PID: 12075 Comm: syz-executor.6 Not tainted 5.15.189 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x22/0x16f lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x23e/0x290 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:166 [inline]
 rcu_check_gp_kthread_starvation.cold+0x1ca/0x1cc kernel/rcu/tree_stall.h:487
 print_other_cpu_stall kernel/rcu/tree_stall.h:592 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:745 [inline]
 rcu_pending kernel/rcu/tree.c:3936 [inline]
 rcu_sched_clock_irq+0x21a2/0x2610 kernel/rcu/tree.c:2619
 update_process_times+0x1c5/0x280 kernel/time/timer.c:1818
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:254
 tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1473
 __run_hrtimer kernel/time/hrtimer.c:1690 [inline]
 __hrtimer_run_queues+0x64c/0xc00 kernel/time/hrtimer.c:1754
 hrtimer_interrupt+0x317/0x7e0 kernel/time/hrtimer.c:1816
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1097 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x430 arch/x86/kernel/apic/apic.c:1114
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1108 [inline]
 sysvec_apic_timer_interrupt+0x4d/0xc0 arch/x86/kernel/apic/apic.c:1108
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:676
RIP: 0010:unwind_next_frame+0xd03/0x1d20 arch/x86/kernel/unwind_orc.c:545
Code: 20 84 c0 4c 8b 44 24 28 48 8b 4c 24 30 0f 84 56 07 00 00 48 b8
00 00 00 00 00 fc ff df 48 8b 54 24 08 48 c1 ea 03 80 3c 02 00 <0f> 85
16 0a 00 00 48 8b 14 24 4d 89 4e 38 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90000007568 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 1ffff92000000eb5 RCX: ffffffff8e89bb65
RDX: 1ffff92000000ecf RSI: ffffc9000dccf678 RDI: ffffc9000dccf678
RBP: 0000000000000001 R08: ffffffff8e89bb60 R09: ffffc9000dccf680
R10: fffff52000000ed3 R11: 000000000008e07d R12: ffffc90000007688
R13: ffffc90000007675 R14: ffffc90000007640 R15: ffffffff8e89bb64
 arch_stack_walk+0x87/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x92/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x2a/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc+0x7f/0xa0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:604 [inline]
 dst_cow_metrics_generic+0x48/0x1e0 net/core/dst.c:202
 dst_metrics_write_ptr include/net/dst.h:118 [inline]
 dst_metric_set include/net/dst.h:179 [inline]
 icmp6_dst_alloc+0x4ee/0x670 net/ipv6/route.c:3281
 ndisc_send_skb+0x10b4/0x1570 net/ipv6/ndisc.c:493
 ndisc_send_rs+0x12f/0x690 net/ipv6/ndisc.c:707
 addrconf_rs_timer+0x413/0x810 net/ipv6/addrconf.c:3957
 call_timer_fn+0x1a5/0x580 kernel/time/timer.c:1451
 expire_timers kernel/time/timer.c:1496 [inline]
 __run_timers+0x75d/0xb20 kernel/time/timer.c:1767
 run_timer_softirq+0x54/0xd0 kernel/time/timer.c:1780
 handle_softirqs+0x21a/0x950 kernel/softirq.c:576
 __do_softirq kernel/softirq.c:610 [inline]
 invoke_softirq kernel/softirq.c:450 [inline]
 __irq_exit_rcu+0xed/0x190 kernel/softirq.c:659
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:671
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1108 [inline]
 sysvec_apic_timer_interrupt+0x9e/0xc0 arch/x86/kernel/apic/apic.c:1108
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:676
RIP: 0010:__preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1170 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online+0x21/0x150 kernel/rcu/tree.c:1162
Code: 00 48 8b 14 24 eb c8 66 90 65 8b 15 39 81 9e 7e 81 e2 00 00 f0
00 b8 01 00 00 00 75 0a 8b 15 f2 2b a2 0c 85 d2 75 01 c3 55 53 <65> ff
05 18 81 9e 7e e8 f3 fc 53 08 48 c7 c3 40 b5 03 00 83 f8 07
RSP: 0018:ffffc9000dccf660 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffff88801cdf0000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8a640000 RDI: ffffffff8bc7b8c0
RBP: ffff88806b299000 R08: 0000000000000000 R09: ffffffff93062a27
R10: fffffbfff260c544 R11: 1ffff11003dd908a R12: 0000000000000cc0
R13: 0000000000000001 R14: ffffffff81d2f5eb R15: 0000000000000000
 rcu_read_lock_held_common kernel/rcu/update.c:112 [inline]
 rcu_read_lock_held+0x1f/0x40 kernel/rcu/update.c:309
 task_css.constprop.0+0xc9/0x130 include/linux/cgroup.h:496
 mem_cgroup_from_task mm/memcontrol.c:935 [inline]
 get_obj_cgroup_from_current+0x120/0x510 mm/memcontrol.c:2926
 memcg_slab_pre_alloc_hook mm/slab.h:283 [inline]
 slab_pre_alloc_hook mm/slab.h:497 [inline]
 slab_alloc_node mm/slub.c:3134 [inline]
 slab_alloc mm/slub.c:3228 [inline]
 kmem_cache_alloc+0x76/0x2f0 mm/slub.c:3233
 __d_alloc+0x2b/0x8e0 fs/dcache.c:1749
 d_alloc+0x4a/0x220 fs/dcache.c:1828
 d_alloc_parallel+0xdd/0x1c70 fs/dcache.c:2582
 lookup_open.isra.0+0xb06/0x1660 fs/namei.c:3387
 open_last_lookups fs/namei.c:3532 [inline]
 path_openat+0xad1/0x2c00 fs/namei.c:3739
 do_filp_open+0x1d4/0x430 fs/namei.c:3769
 do_sys_openat2+0x185/0x4f0 fs/open.c:1253
 do_sys_open fs/open.c:1269 [inline]
 __do_sys_openat fs/open.c:1285 [inline]
 __se_sys_openat fs/open.c:1280 [inline]
 __x64_sys_openat+0x171/0x210 fs/open.c:1280
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x66/0xd0
RIP: 0033:0x46a4e4
Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 06 d9 02 00 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 48 d9 02 00 8b 44
RSP: 002b:00007f2a6d102f60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000000000046a4e4
RDX: 0000000000000002 RSI: 00007f2a6d102ff0 RDI: 00000000ffffff9c
RBP: 00007f2a6d102ff0 R08: 0000000000000000 R09: 00007f2a6d102e70
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 00000000004e9478 R14: 00007f2a6d1035f4 R15: 00000000ffffffff
 </TASK>

https://drive.google.com/file/d/13nr1pPRHCrZqYxz08ngNiCvmcRe-d_oK/view?usp=drive_link

https://drive.google.com/file/d/1RHa5bKm8YN-h9wRh_dJH0q1ZBF5mzYOh/view?usp=drive_link

https://drive.google.com/file/d/15HyqruIzxnkYVh4FXjmU-yY_zTB8kwPI/view?usp=drive_link

