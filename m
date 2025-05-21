Return-Path: <cgroups+bounces-8293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E799ABFF67
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA158C4DC2
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B6239E8C;
	Wed, 21 May 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE06+ZzX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6769148827;
	Wed, 21 May 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866231; cv=none; b=E5p1vNoVXi2w3ycWOfTboFg9fbNhqX8zBaLNEzYAWgApvR1GlH2j9GWi6gTVOeOwAXcJDPqb2C3XkBLOZyI1Ibo8bI6Spj0GiicUfcJ3MNRqo79B9tNkYmHQg5FVOCLozTlwpZRGkT59tGyc0z6pT+/GsosbgKBPtIjTN3l4cmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866231; c=relaxed/simple;
	bh=HHAmNHM/apOOc9BcVI+6hHiYUkiPgcmpIqShjTb9gno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7DY/+evuXEvvBpS21RIX4VkCYfjvWZHfXpnqfOkeo1uXN+KlRLvy7PNMRfcMCPLtp6wUuAq0TeZ5p9+dqpQ3a808LeTc6zH6xVUmfub1OzX7/ubveORm6hy6Tbb0xcyfinPHQPeyMUd2Ws/j80quqMXZE/YBhaZx7w+JmSmVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE06+ZzX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-551f00720cfso5280586e87.0;
        Wed, 21 May 2025 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747866227; x=1748471027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YeW/o3C6q32fJLvvgmIu4UgKhie1cDVy4GoBMXXjaM=;
        b=cE06+ZzXZxJ8BkYLw4Mvdmd04mAmw8KsYiWcJzXsWZc/n4HckwmbgHyyJ6FD7FA9PM
         +WU08EQjgAOSrgDU3qOwdzNir5yOMrZ4WEa8riNh2wUbjuGbqDVmUxYqQFq+MGC5CV29
         1iiMpfg3BrpKa4v6/v7uYz5mmO7ce/3yC0t7vq+Y9IWzXKfKiLTZnVqEcwaJOCZOEJ/Y
         TXBZSt3nWZM5GsUHTwI0KaUeXbj8K0LC6JI8wgoszWCIvz1r9ltrM8YlZyYqnAqyyqE9
         H/ftzdIIbpjYKp7q1KhM5EPAQ12ozPUVVI4ZJMf6cpm3M7dUrAMlkYP+9l/zCwonnlsO
         ssiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866227; x=1748471027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YeW/o3C6q32fJLvvgmIu4UgKhie1cDVy4GoBMXXjaM=;
        b=nCQRnGs2PeHQ5DOOEKEv31opaMu09qVGjwCiV9mgbneL/OxfXzxK2X3IXClT9phoIx
         5ENGhqQ1SZBhJKWnzh2zlRAhFMPHoh/soNFEsPIllxKi65cTJZgyWUjkRlaEHCzB8LLF
         s1amEvQntaz8yIV1GVjMoTGitbFT88dBwVr4li6oi+OlBX5iBHQ9nvroXmJ7+qG1WWpt
         k/ihxFPszTuxanvbhNleM+5h9j8BI13IQl7/erMcAhZUiGMNQepH27kmg/LTmOUu4Eok
         Eqr5XztMLBMxUxI6Rk007mdoj0LiD4h+m9g0DdTSdPXFBb+YpX3iB6MmXZaWGh/n5L0h
         3fAA==
X-Forwarded-Encrypted: i=1; AJvYcCVvtOTdbY8cuYMBM8R5z4dQRcrF0S1jrp8K6uGc3TYFTOL9GRX8RIcOpR8gD9Hzzy5MHfHI2GkKCR2bNhqS@vger.kernel.org, AJvYcCWa4kKhaZv1/6toR6C7XQmG6v1qZSflNTjMOrTWqm7OmPwXAlUZ4gUL30FM/+CZ5VweBVAuzXsBJA==@vger.kernel.org, AJvYcCX+wdhEyQLi8BCtsovF6n06lK48OUV1aljN7ZZ/gsVw4sxVgFo0PHWbsPfu2J8VH540Q6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0jitqUs09UcC2UEscvEn4SYjB7kJZmbWAUVMiVCPbksCUsQj
	mIM3aGidMJvgx5DiLq+Uf0Csq/0W9zqLZKV+yf2r+DKEo3QCcr3oIHgm
X-Gm-Gg: ASbGncvWGW60SuR94AVPVqJHE2Qrwqj5DHrOe1+tQ9PjWTc2f+3OJomucJBjazdZ9FQ
	PHvJb8d82LvMZf2PzrnV/unJZlKhrsw/B1vfBd8l7CXuybZWOzfezlP7cQraY4lDs+FRYwQV8GZ
	IPBw/wRb7S/FlxXH54QaXipfp5Y20nS9k++9SMQk1FCYVGQW9fftAoQcxkb9LRrwNO3gkz3SkVx
	diR+4j1j3iEdG9AIJTNHD9LX1icLyrE3P5LrffD+GFjGdrctlD6LQyHCs3hsbJYRQXHoilimG62
	o1lna2XRqk5ZJRkPFIoYG9Im2B6cDo5Tv+L0PLbPlHE9hXECSBhZ1aHmO++CmMDJO2o=
X-Google-Smtp-Source: AGHT+IHBnW41QKLFye2RvryJfNh3P6ImYUPrXAq7oYJjvYi+ln/AmjUix8xjVgYfeHnYIi1YU6wpYQ==
X-Received: by 2002:a05:6512:1387:b0:549:8b24:989d with SMTP id 2adb3069b0e04-550e70f5ec7mr7298089e87.0.1747866226462;
        Wed, 21 May 2025 15:23:46 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-551fd8de25dsm1126343e87.100.2025.05.21.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 15:23:45 -0700 (PDT)
Date: Thu, 22 May 2025 00:23:44 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks
 to avoid contention
Message-ID: <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zpfc6w4vu3f2x2gi"
Content-Disposition: inline
In-Reply-To: <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>


--zpfc6w4vu3f2x2gi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> Please ignore this patch as it was sent by mistake.

This seems to have made it into next:

748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")

It causes a BUG and eventually a panic on my Raspberry Pi 1:

WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
illegal size (0) or align (4) for percpu allocation
CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc7-next-20250521-00086-ga9fb18e56aad #263 NONE
Hardware name: BCM2835
Call trace:
unwind_backtrace from show_stack (arch/arm/kernel/traps.c:259) 
show_stack from dump_stack_lvl (lib/dump_stack.c:122) 
dump_stack_lvl from __warn (kernel/panic.c:729 kernel/panic.c:784) 
__warn from warn_slowpath_fmt (kernel/panic.c:815) 
warn_slowpath_fmt from pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
pcpu_alloc_noprof from ss_rstat_init (kernel/cgroup/rstat.c:515) 
ss_rstat_init from cgroup_init_subsys (kernel/cgroup/cgroup.c:6134 (discriminator 2)) 
cgroup_init_subsys from cgroup_init (kernel/cgroup/cgroup.c:6240) 
cgroup_init from start_kernel (init/main.c:1093) 
 start_kernel from 0x0
...
kernel BUG at kernel/cgroup/cgroup.c:6134!
Internal error: Oops - BUG: 0 [#1] ARM

Reverting resolved it for me.

Regards,
Klara Modin

--zpfc6w4vu3f2x2gi
Content-Type: text/plain; charset=us-ascii
Content-Description: bisect-log
Content-Disposition: attachment; filename=rpi1-no-boot

# bad: [7bac2c97af4078d7a627500c9bcdd5b033f97718] Add linux-next specific files for 20250521
# good: [b36ddb9210e6812eb1c86ad46b66cc46aa193487] Merge tag 'for-linus-6.15-ofs2' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect start 'next/master' 'next/stable'
# good: [d86bd5895658c9c4317ecf66d43bd16995e18483] Merge branch 'spi-nor/next' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good d86bd5895658c9c4317ecf66d43bd16995e18483
# good: [bf65a86fb3f72e1da64f68c29fe6d51de870e463] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
git bisect good bf65a86fb3f72e1da64f68c29fe6d51de870e463
# good: [56baa9ffcd362c315ee1d01bb089b8c2d9d068d3] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect good 56baa9ffcd362c315ee1d01bb089b8c2d9d068d3
# bad: [2c0faaaca998913917026967c2b5adeac3168855] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
git bisect bad 2c0faaaca998913917026967c2b5adeac3168855
# good: [be4e0b332d0f11bd70e2db7a9bccfdfd95f58dec] Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect good be4e0b332d0f11bd70e2db7a9bccfdfd95f58dec
# good: [427ab512c2c8784686738ade287e5eb52bd8292a] staging: gpib: Change error code for no listener
git bisect good 427ab512c2c8784686738ade287e5eb52bd8292a
# good: [3139fde502884920b33404600ae918a08d683703] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
git bisect good 3139fde502884920b33404600ae918a08d683703
# good: [86d2a97e8b5851cfeafc08c9efd7846e4f72adf3] Merge branch 'counter-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git
git bisect good 86d2a97e8b5851cfeafc08c9efd7846e4f72adf3
# good: [9002b75aa8e6f034ffbd1c1ccac46927a1cf0f12] irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
git bisect good 9002b75aa8e6f034ffbd1c1ccac46927a1cf0f12
# good: [541a4219bd66bef56d93dbd306dc64a4d70ae99e] cgroup: compare css to cgroup::self in helper for distingushing css
git bisect good 541a4219bd66bef56d93dbd306dc64a4d70ae99e
# bad: [86aadd4d2347b11a239e755d5eb540488bbf5b8c] Merge branch 'for-6.16' into for-next
git bisect bad 86aadd4d2347b11a239e755d5eb540488bbf5b8c
# bad: [93b35663f2018ff2accf4336a909081883eda76b] cgroup: helper for checking rstat participation of css
git bisect bad 93b35663f2018ff2accf4336a909081883eda76b
# bad: [748922dcfabdd655d25fb6dd09a60e694a3d35e6] cgroup: use subsystem-specific rstat locks to avoid contention
git bisect bad 748922dcfabdd655d25fb6dd09a60e694a3d35e6
# good: [5da3bfa029d6809e192d112f39fca4dbe0137aaf] cgroup: use separate rstat trees for each subsystem
git bisect good 5da3bfa029d6809e192d112f39fca4dbe0137aaf
# first bad commit: [748922dcfabdd655d25fb6dd09a60e694a3d35e6] cgroup: use subsystem-specific rstat locks to avoid contention

--zpfc6w4vu3f2x2gi
Content-Type: text/plain; charset=us-ascii
Content-Description: boot-log
Content-Disposition: attachment; filename=rpi1-earlycon-decoded-2

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.15.0-rc7-next-20250521-00086-ga9fb18e56aad (klara@soda.int.kasm.eu) (armv6j-unknown-linux-gnueabihf-gcc (Gentoo 15.1.0 p55) 15.1.0, GNU ld (Gentoo 2.44 p1) 2.44.0) #263 Wed May 21 23:48:00 CEST 2025
[    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi Model B Rev 2
[    0.000000] earlycon: pl11 at MMIO32 0x20201000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Reserved memory: created CMA memory pool at 0x1b000000, size 64 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x1b000000..0x1effffff (65536 KiB) map reusable linux,cma
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000001effffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000001effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001effffff]
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] Kernel command line: bootargs_pre=coherent_pool=6M smsc95xx.turbo_mode=N dwc_otg.lpm_enable=0 console=tty0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 root=/dev/mmcblk0p2 rw rootfstype=nilfs2 rootflags=discard earlycon=pl011,mmio32,0x20201000
[    0.000000] Unknown kernel command line parameters "bootargs_pre=coherent_pool=6M", will be passed to user space.
[    0.000000] printk: log buffer data + meta data: 16384 + 51200 = 67584 bytes
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 126976
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=32, Order=0-1, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] ftrace: allocating 33191 entries in 65 pages
[    0.000000] ftrace: allocated 65 pages with 2 groups
[    0.000000] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.000000] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000013] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.008502] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.017997] bcm2835: system timer (irq = 27)
[    0.023325] kfence: initialized - using 2097152 bytes for 255 objects at 0x(ptrval)-0x(ptrval)
[    0.032532] Console: colour dummy device 80x30
[    0.037075] printk: legacy console [tty0] enabled
[    0.043066] Calibrating delay loop... 697.95 BogoMIPS (lpj=3489792)
[    0.108806] CPU: Testing write buffer coherency: ok
[    0.113907] pid_max: default: 4096 minimum: 301
[    0.118984] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.126496] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.135751] ------------[ cut here ]------------
[    0.140554] WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
[    0.148469] illegal size (0) or align (4) for percpu allocation
[    0.154511] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc7-next-20250521-00086-ga9fb18e56aad #263 NONE
[    0.164999] Hardware name: BCM2835
[    0.168456] Call trace:
[    0.168485] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:259) 
[    0.176410] show_stack from dump_stack_lvl (lib/dump_stack.c:122) 
[    0.181574] dump_stack_lvl from __warn (kernel/panic.c:729 kernel/panic.c:784) 
[    0.186379] __warn from warn_slowpath_fmt (kernel/panic.c:815) 
[    0.191448] warn_slowpath_fmt from pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
[    0.197674] pcpu_alloc_noprof from ss_rstat_init (kernel/cgroup/rstat.c:515) 
[    0.203393] ss_rstat_init from cgroup_init_subsys (kernel/cgroup/cgroup.c:6134 (discriminator 2)) 
[    0.209267] cgroup_init_subsys from cgroup_init (kernel/cgroup/cgroup.c:6240) 
[    0.215049] cgroup_init from start_kernel (init/main.c:1093) 
[    0.220315]  start_kernel from 0x0
[    0.223837] ---[ end trace 0000000000000000 ]---
[    0.228555] ------------[ cut here ]------------
[    0.233239] kernel BUG at kernel/cgroup/cgroup.c:6134!
[    0.238450] Internal error: Oops - BUG: 0 [#1] ARM
[    0.243323] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W           6.15.0-rc7-next-20250521-00086-ga9fb18e56aad #263 NONE
[    0.255389] Tainted: [W]=WARN
[    0.258403] Hardware name: BCM2835
[    0.261856] PC is at cgroup_init_subsys (kernel/cgroup/cgroup.c:6134 (discriminator 3)) 
[    0.266747] LR is at pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2)) 
[    0.271640] pc : lr : psr: a0000053 
[    0.277988] sp : c0d01f70  ip : 00000000  fp : c0d296fc
[    0.283283] r10: c0d29704  r9 : c0d2a2e8  r8 : c0d29788
[    0.288579] r7 : 00000000  r6 : c0d2a2d8  r5 : c0ddc590  r4 : c0d6d894
[    0.295189] r3 : c0d08c80  r2 : 00000000  r1 : 00000000  r0 : fffffff4
[    0.301800] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.309121] Control: 00c5387d  Table: 00004008  DAC: 00000051
[    0.314940] Register r0 information: non-paged memory
[    0.320077] Register r1 information: NULL pointer
[    0.324858] Register r2 information: NULL pointer
[    0.329637] Register r3 information: non-slab/vmalloc memory
[    0.335384] Register r4 information: non-slab/vmalloc memory
[    0.341130] Register r5 information: non-slab/vmalloc memory
[    0.346875] Register r6 information: non-slab/vmalloc memory
[    0.352620] Register r7 information: NULL pointer
[    0.357399] Register r8 information: non-slab/vmalloc memory
[    0.363141] Register r9 information: non-slab/vmalloc memory
[    0.368885] Register r10 information: non-slab/vmalloc memory
[    0.374716] Register r11 information: non-slab/vmalloc memory
[    0.380549] Register r12 information: NULL pointer
[    0.385416] Process swapper (pid: 0, stack limit = 0x(ptrval))
[    0.391330] Stack: (0xc0d01f70 to 0xc0d02000)
[    0.395761] 1f60:                                     c0d6d894 00000002 c0d296f4 c0dc2278
[    0.404053] 1f80: c0d29788 c0c0ff40 dafff19e c0c1953c c0d2b618 c0d12e18 c0d088e0 c0dba048
[    0.412344] 1fa0: dafff180 00000000 c0dba024 c0d088e0 c0d08960 c0dba010 dafff19e c0c016bc
[    0.420635] 1fc0: ffffffff ffffffff 00000000 c0c00694 00000000 00000000 c0c34f28 00000000
[    0.428921] 1fe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.437197] Call trace:
[    0.437219] cgroup_init_subsys from cgroup_init (kernel/cgroup/cgroup.c:6240) 
[    0.445566] cgroup_init from start_kernel (init/main.c:1093) 
[    0.450828]  start_kernel from 0x0
[ 0.454326] Code: e1a00004 eb0001bb e3500000 0a000001 (e7f001f2)
All code
========
   0:	e1a00004 	mov	r0, r4
   4:	eb0001bb 	bl	0x6f8
   8:	e3500000 	cmp	r0, #0
   c:	0a000001 	beq	0x18
  10:*	e7f001f2 	udf	#18		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	e7f001f2 	udf	#18
[    0.460550] ---[ end trace 0000000000000000 ]---
[    0.465252] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.472066] Rebooting in 30 seconds..

--zpfc6w4vu3f2x2gi
Content-Type: application/gzip
Content-Description: config.gz
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
AkwMxZoBAA==

--zpfc6w4vu3f2x2gi--

