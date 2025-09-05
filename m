Return-Path: <cgroups+bounces-9744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EDDB458AE
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C938D5A4E93
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDB30CD93;
	Fri,  5 Sep 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQvEThw6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485A1D5CC9
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078509; cv=none; b=a5L3YDUckCjoy6SKNKIZyXjEQ57yJExJBL0V3xB2XDXBWycC+S/U02q+1T6/xhbM3Uyb5kNWPivLRFUgT+DLCLenKwZzxFwPpxXzSuLPYUImZQXL1RaFCp9dKa2YMzbPt2b328HNOgOJ83s2OJZAmbFdIIePjgx5mCeaqeRcepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078509; c=relaxed/simple;
	bh=9mDoi6LM/1M15H0qUd3lUWkKBmRMc7KMMvsoeJoL5fM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oTi+6mr2KOKh/xeTuhUXznRZ+faUNzcp3YYlwriVOQfontUuY0mFC2sNkmqxy54bwUbZl4l1nXb3b5Prtr3UPX2IzrLi1N8l8YOU7ZkqyJw3UGbti20/2ycVK2ixnf0EoW2hp9HAz/FeaDwSSXx0E9+EzR+S+8AtrSXkL43TqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQvEThw6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso1760461a12.2
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757078506; x=1757683306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vqf5jZApOZXImUvf7d+PDbTEFRnl9YOqDB+msnfnaR4=;
        b=nQvEThw6lv3c538isbbuHkzvJwBwy3n1o6hY06nZTCv9RfROK4TDnHuma5PgZ79tPg
         RiCXV44K3G7GWX0wZ9RYMmUluDJBB7LcFekWfFHTMBaKl+whtjDBWqmfEKRbvRIw09LX
         Pq+sfHtf4BAOIITBY1KB8VVk4COOfOPOafFeiOwDBp6zLJ2U6vxLdTL8rN6zHoAfYTKw
         YNGVCyU0B7PSRkGeaXlhwXzt+j38gGyoMLh2Y3XK3Yfi3UMGTSbcOndy5UGNIQC0p680
         y3odkj9g1BaxMjO5sFQyKlbKjLVdf/n/D+VLEjYf+Zra1h0paxVfpQgsH02UE9JxzwzQ
         DyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078506; x=1757683306;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqf5jZApOZXImUvf7d+PDbTEFRnl9YOqDB+msnfnaR4=;
        b=NHBY31IqhhOlkT7bObkivaT6102+fiUXVIFqxM+h3CkKVjLu4/js8MT6o74EywZoRM
         g8sMrsCzXdmolKAKFsnkWe7RygowXOVhOhhnCxi8Wq1sr3z0D2F83aMS4BLTk35Xvgje
         PCpvEVPQTk1KpuXr0+Mvc3Mi6f8LWie3QWZcMzDEbdkc5FLloZGcMTTRpIJO8H4RsbdJ
         Sml+G0OKquUkfHUef8q/AwLbrwAONqXYBvfjQ2Xh9HEMcyWzhV+5HVJAKtWZ2jxQeXXW
         mHU+mvQ3gnGGs3wB6yNrY6XsP01NFpZFRRhvBWqyA0HqATWoQezfVRvVpVmPKGXTIk73
         pgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS0nayUNxD6YkD7bTKdrQRQhauNfmA1FMc+Dr1dJH3CQlFGWVkmrtgXnqvmngQVDqAXMkU/gI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZDrNCMX1HZIvXKYCZ/H7jHa0ctoCknkKXYYoaGjJloryVk21
	lyeB55XX1tTlPrtG1NzrVMhj2wlHBgz+7gcFo2k4pjjDknRcyCSRFr2yY3ar4nB7SxGoNaifG1g
	/+GWcvlljB3EYC3BQPoUI9WEpE4kMiEGZXz/LqTEZsA==
X-Gm-Gg: ASbGncv0gGoP1y1pRSlPOa1cukBYDPorwbz5YESEDEnozu0sPiE310nzoNd/bPz6dBE
	JvLkBQd03lvV08wP+zY57cVNswUvM3etWQWWVXPxG1ecqKWSYRDZkj2IJ/JsN3ww71W7tR8u66u
	omYM9KCrsFB250dlJ6lo8gUkSvs8oW2JJIWFYTRZy+EAJr1aycfN3c2KoomOv+m+zIUSRT7+N3U
	K/T1l21pQbul2J6QMkRCewxc1bl7m4Fpr2usgBOpcp2By2wmx4=
X-Google-Smtp-Source: AGHT+IHIrghsl/YelmGfQe/X3UG5MxYSntb1FbdGSiNftIY2R2l0wnkLivmcJRILX4OAb2+KqxgaW1tz7aGUlThd0Vo=
X-Received: by 2002:a17:903:f8d:b0:246:255a:1913 with SMTP id
 d9443c01a7336-24944b29d4fmr293099855ad.39.1757078506183; Fri, 05 Sep 2025
 06:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Sep 2025 18:51:33 +0530
X-Gm-Features: Ac12FXxQOU9K4qqJhThdvxXyAV48yJE93vCtDOM1jkvPUHrfTSlejpUqZy-anv4
Message-ID: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
Subject: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Cgroups <cgroups@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

Kernel warnings and a panic were observed on Juno-r2 while running
LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
SCHED_PROXY_EXEC=y enabled build.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250904
Bad: next-20250904
Good: next-20250822

Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel panic

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Juno-r2:
 * LTP controllers
   * cgroup_fj_stress.sh

Test crash:
cgroup_fj_stress_net_cls_1_200_one:
[  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_200_one:
start (command: cgroup_fj_stress.sh net_cls 1 200 one)
[  374.230110] ------------[ cut here ]------------
[  374.230132] WARNING: lib/timerqueue.c:55 at
timerqueue_del+0x68/0x70, CPU#5: swapper/5/0
[  374.242899] Modules linked in: tda9950 panfrost tda998x hdlcd
drm_shmem_helper cec drm_client_lib gpu_sched onboard_usb_dev
drm_dma_helper drm_kms_helper fuse drm backlight
[  374.258403] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted
6.17.0-rc4-next-20250904 #1 PREEMPT
[  374.267300] Hardware name: ARM Juno development board (r2) (DT)
[  374.273232] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  374.280213] pc : timerqueue_del (lib/timerqueue.c:55 (discriminator 1))
[  374.284236] lr : __hrtimer_run_queues (kernel/time/hrtimer.c:1121
(discriminator 1) kernel/time/hrtimer.c:1741 (discriminator 1)
kernel/time/hrtimer.c:1825 (discriminator 1))
[  374.288960] sp : ffff800083283d40
[  374.292279] x29: ffff800083283d40 x28: ffff00097edac1c0 x27: ffff00097edac730
[  374.299445] x26: 0000000000000001 x25: 00000000000000c0 x24: ffff800082a9feb0
[  374.306611] x23: 0000000000000060 x22: ffff000800396040 x21: ffff00097edac180
[  374.313776] x20: ffff00097edac1e0 x19: ffff00097edac730 x18: ffff80008f8b3be0
[  374.320942] x17: ffff8008fc418000 x16: ffff800083280000 x15: 0000000000000000
[  374.328108] x14: 00003d0900000000 x13: 0000000000000000 x12: 003d090000000000
[  374.335273] x11: 0000000000000000 x10: ffff800081754498 x9 : ffff8000801aa89c
[  374.342439] x8 : 1fffe001044892a1 x7 : 0000000000000004 x6 : 0000000000000004
[  374.349603] x5 : 0000000014000000 x4 : 0000000000000001 x3 : 0000000000000001
[  374.356768] x2 : 00000000000000c0 x1 : ffff00097edac730 x0 : ffff00097edac730
[  374.363933] Call trace:
[  374.366383] timerqueue_del (lib/timerqueue.c:55 (discriminator 1)) (P)
[  374.370410] __hrtimer_run_queues (kernel/time/hrtimer.c:1121
(discriminator 1) kernel/time/hrtimer.c:1741 (discriminator 1)
kernel/time/hrtimer.c:1825 (discriminator 1))
[  374.374786] hrtimer_interrupt (kernel/time/hrtimer.c:1890)
[  374.378813] tick_handle_oneshot_broadcast (kernel/time/tick-broadcast.c:768)
[  374.383970] arch_timer_mmio_handler
(drivers/clocksource/arm_arch_timer_mmio.c:192)
[  374.388434] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[  374.393158] handle_irq_event (kernel/irq/handle.c:193
kernel/irq/handle.c:210)
[  374.397010] handle_fasteoi_irq (kernel/irq/chip.c:766)
[  374.401208] handle_irq_desc (kernel/irq/irqdesc.c:670)
[  374.404974] generic_handle_domain_irq (kernel/irq/irqdesc.c:726)
[  374.409609] gic_handle_irq (arch/arm64/include/asm/io.h:80
include/asm-generic/io.h:336 drivers/irqchip/irq-gic.c:341)
[  374.413285] call_on_irq_stack (arch/arm64/kernel/entry.S:893)
[  374.417223] do_interrupt_handler (arch/arm64/kernel/entry-common.c:314)
[  374.421424] el1_interrupt (arch/arm64/kernel/entry-common.c:654
arch/arm64/kernel/entry-common.c:668)
[  374.425013] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:674)
[  374.429123] el1h_64_irq (arch/arm64/kernel/entry.S:592)
[  374.432536] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:293
(discriminator 1)) (P)
[  374.437085] cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2))
[  374.440680] ------------[ cut here ]------------
[  374.445303] WARNING: arch/arm64/kernel/stacktrace.c:211 at
dump_backtrace+0x624/0x6f0, CPU#5: swapper/5/0
[  374.454901] Modules linked in: tda9950 panfrost tda998x hdlcd
drm_shmem_helper cec drm_client_lib gpu_sched onboard_usb_dev
drm_dma_helper drm_kms_helper fuse drm backlight
[  374.470392] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted
6.17.0-rc4-next-20250904 #1 PREEMPT
[  374.479288] Hardware name: ARM Juno development board (r2) (DT)
[  374.485218] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  374.492197] pc : dump_backtrace (arch/arm64/kernel/stacktrace.c:211
(discriminator 1) arch/arm64/kernel/stacktrace.c:236 (discriminator 1)
arch/arm64/kernel/stacktrace.c:266 (discriminator 1)
arch/arm64/kernel/stacktrace.c:295 (discriminator 1)
arch/arm64/kernel/stacktrace.c:366 (discriminator 1)
arch/arm64/kernel/stacktrace.c:492 (discriminator 1))
[  374.496392] lr : dump_backtrace (arch/arm64/kernel/stacktrace.c:198
arch/arm64/kernel/stacktrace.c:236 arch/arm64/kernel/stacktrace.c:266
arch/arm64/kernel/stacktrace.c:295 arch/arm64/kernel/stacktrace.c:366
arch/arm64/kernel/stacktrace.c:492)
[  374.500586] sp : ffff800083283980
[  374.503905] x29: ffff800083283a50 x28: ffff000800396040 x27: ffff000800396040
[  374.511070] x26: ffff800082561000 x25: ffff800082561650 x24: ffff800080038848
[  374.518236] x23: ffff800081731bf8 x22: ffff8000822d00a8 x21: ffff80008231a5c0
[  374.525401] x20: ffff000800396040 x19: ffff8000833dbde0 x18: 0000000000000000
[  374.532566] x17: 3337636164653739 x16: 3030306666666620 x15: 0000000000000000
[  374.539731] x14: 0000000000000000 x13: 303678302f303478 x12: 302b7265746e655f
[  374.546896] x11: 746174735f726574 x10: ffff800082b1f8c0 x9 : ffff800080022c7c
[  374.554061] x8 : ffff8000832836e8 x7 : ffff800082ac78c0 x6 : 00000000ffffefff
[  374.561226] x5 : 0000000000000a00 x4 : ffff8000833dc000 x3 : ffff8000833dbdf8
[  374.568390] x2 : 0000000000000018 x1 : ffff8000833dbde0 x0 : ffff000800396040
[  374.575555] Call trace:
[  374.578003] dump_backtrace (arch/arm64/kernel/stacktrace.c:211
(discriminator 1) arch/arm64/kernel/stacktrace.c:236 (discriminator 1)
arch/arm64/kernel/stacktrace.c:266 (discriminator 1)
arch/arm64/kernel/stacktrace.c:295 (discriminator 1)
arch/arm64/kernel/stacktrace.c:366 (discriminator 1)
arch/arm64/kernel/stacktrace.c:492 (discriminator 1)) (P)
[  374.582201] show_regs (arch/arm64/kernel/process.c:249)
[  374.585444] __warn (kernel/panic.c:899)
[  374.588515] report_bug (lib/bug.c:176 lib/bug.c:215)
[  374.592021] bug_brk_handler (arch/arm64/kernel/traps.c:1000
(discriminator 1))
[  374.595783] do_el1_brk64 (arch/arm64/kernel/debug-monitors.c:266
(discriminator 1))
[  374.599285] el1_brk64 (arch/arm64/kernel/entry-common.c:466
arch/arm64/kernel/entry-common.c:577)
[  374.602523] el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:630)
[  374.606720] el1h_64_sync (arch/arm64/kernel/entry.S:591)
[  374.610220] timerqueue_del (lib/timerqueue.c:55 (discriminator 1)) (P)
[  374.614246] __hrtimer_run_queues (kernel/time/hrtimer.c:1121
(discriminator 1) kernel/time/hrtimer.c:1741 (discriminator 1)
kernel/time/hrtimer.c:1825 (discriminator 1))
[  374.618621] hrtimer_interrupt (kernel/time/hrtimer.c:1890)
[  374.622648] tick_handle_oneshot_broadcast (kernel/time/tick-broadcast.c:768)
[  374.627803] arch_timer_mmio_handler
(drivers/clocksource/arm_arch_timer_mmio.c:192)
[  374.632265] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[  374.636988] handle_irq_event (kernel/irq/handle.c:193
kernel/irq/handle.c:210)
[  374.640840] handle_fasteoi_irq (kernel/irq/chip.c:766)
[  374.645037] handle_irq_desc (kernel/irq/irqdesc.c:670)
[  374.648801] generic_handle_domain_irq (kernel/irq/irqdesc.c:726)
[  374.653437] gic_handle_irq (arch/arm64/include/asm/io.h:80
include/asm-generic/io.h:336 drivers/irqchip/irq-gic.c:341)
[  374.657111] call_on_irq_stack (arch/arm64/kernel/entry.S:893)
[  374.661048] do_interrupt_handler (arch/arm64/kernel/entry-common.c:314)
[  374.665247] el1_interrupt (arch/arm64/kernel/entry-common.c:654
arch/arm64/kernel/entry-common.c:668)
[  374.668835] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:674)
[  374.672945] el1h_64_irq (arch/arm64/kernel/entry.S:592)
[  374.676358] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:293
(discriminator 1)) (P)
[  374.680905] cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2))
[  374.684502] ---[ end trace 0000000000000000 ]---
[  374.689128] ---[ end trace 0000000000000000 ]---
[  374.693835] Unable to handle ker
** replaying previous printk message **
[  374.693835] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  374.693868] Mem abort info:
[  374.693886]   ESR = 0x0000000086000004
[  374.693905]   EC = 0x21: IABT (current EL), IL = 32 bits
[  374.693927]   SET = 0, FnV = 0
[  374.693947]   EA = 0, S1PTW = 0
[  374.693962]   FSC = 0x04: level 0 translation fault
[  374.693977] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008aea5a000
[  374.693994] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  374.694035] Internal error: Oops: 0000000086000004 [#1]  SMP
[  374.703134] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[  374.703143] Mem abort info:
[  374.703147]   ESR = 0x0000000096000004
[  374.703151]   EC = 0x25: DABT (current EL), IL = 32 bits
[  374.703157]   SET = 0, FnV = 0
[  374.703161]   EA = 0, S1PTW = 0
[  374.703165]   FSC = 0x04: level 0 translation fault
[  374.703169] Data abort info:
[  374.703172]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  374.703177]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  374.703182]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  374.703187] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008a41ec000
[  374.703193] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[  374.815063] Modules linked in: tda9950 panfrost tda998x hdlcd
drm_shmem_helper cec drm_client_lib gpu_sched onboard_usb_dev
drm_dma_helper drm_kms_helper fuse drm backlight
[  374.830558] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G
W           6.17.0-rc4-next-20250904 #1 PREEMPT
[  374.841022] Tainted: [W]=WARN
[  374.843993] Hardware name: ARM Juno development board (r2) (DT)
[  374.849923] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  374.856902] pc : 0x0
[  374.859095] lr : 0x0
[  374.861286] sp : ffff8000833dbe10
[  374.864605] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
[  374.871770] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[  374.878934] x23: 0000000000000000 x22: ffff800082a9fff0 x21: ffff000800396040
[  374.886100] x20: ffff80008012a008 x19: ffff8000833dbe20 x18: ffff80008f8b3be0
[  374.893265] x17: 000000040044ffff x16: 00500072b5503510 x15: 0000000000000000
[  374.900430] x14: ffff000800396040 x13: ffff8008fc418000 x12: ffff8000817397a4
[  374.907596] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80008170625c
[  374.914761] x8 : ffff8000833dbc78 x7 : 0000000000000001 x6 : 0000000000186a00
[  374.921925] x5 : 0000000000000003 x4 : 00000011010e3938 x3 : 0000000000000002
[  374.929090] x2 : ffff00097edba678 x1 : 0000000000000003 x0 : 0000000000000002
[  374.936254] Call trace:
[  374.938703]  0x0 (P)
[ 374.940907] Code: io_uring LICENSES Makefile security io_uring
LICENSES Makefile security io_uring LICENSES Makefile security
io_uring LICENSES Makefile security (????????)
All code
========

Code starting with the faulting instruction
===========================================
[  374.947014] ---[ end trace 0000000000000000 ]---
[  374.951641] Internal error: Oops: 0000000096000004 [#2]  SMP
[  374.951658] Kernel panic - not syncing: Attempted to kill the idle task!
[  374.953970] SMP: stopping secondary CPUs
[  376.060825] SMP: failed to stop secondary CPUs 0
[  376.076083] Kernel Offset: disabled
[  376.079576] CPU features: 0x040000,020c3c00,20002000,0400421b
[  376.085335] Memory Limit: none
[  376.088411] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---


## Source
* Kernel version: 6.17.0-rc4-next-20250904
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250904
* Git commit: 4ac65880ebca1b68495bd8704263b26c050ac010
* Architectures: arm64 juno-r2
* Toolchains: gcc-13
* Kconfigs: defconfig+CONFIG_SCHED_PROXY_EXEC=y

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29766906/log_file/
* LAVA test log: https://lkft.validation.linaro.org/scheduler/job/8432765#L2200
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250904/log-parser-test/internal-error-oops-oops-smp/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32E6y9CzIvIeuyHJXf1h2OhxJQ7
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6udmeNgo23dOYnG0U5g38mql/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32E6udmeNgo23dOYnG0U5g38mql/config

--
Linaro LKFT
https://lkft.linaro.org

