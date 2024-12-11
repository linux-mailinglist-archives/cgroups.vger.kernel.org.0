Return-Path: <cgroups+bounces-5798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704169ECCFF
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E90282985
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA513229150;
	Wed, 11 Dec 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyFc2J/y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07A1F193D;
	Wed, 11 Dec 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923066; cv=none; b=So9gVXxUlEPfTP037d57via9EiFPnm3oI7m7dFtLXL57lVc3glEFeaEwtodqAwtfLmcQWmcAXLhoZ2eqZoWIJ5w8zgRAF/HtB1HnDmg9U8ee1h7w7JrixCJxaqp+o1ODycrJjVnr9s0ou0k9HfjbBSB73rT/oWni0NhRQEqlf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923066; c=relaxed/simple;
	bh=EcmnKzRxWRfwen/Ca/S3hfQI1oJaRrl8J3QO3QfSGCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oooqsFSVr9Pi9sTZHoYbosUIy+4KOhGR5O/ghzMDHutfr5irODitACnpzvOLUDlQNH3Ewd24zRxaTGAKffJqHhhkVFITa6200wPZY1USDm2yAKGqIvfQGyPzLAKIa9HYaE+7Cf/bCch4KX90deeFzhblG/0VaRQNyv2CcT2xhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyFc2J/y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso1300726b3a.0;
        Wed, 11 Dec 2024 05:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733923064; x=1734527864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8Tanh2NW1hQ/xTBVE3Ztx2L3hIaKeNFiKJcRQkCmH8=;
        b=kyFc2J/yjjkuL5lLu6fVTI9Iv/MI0+9QyhqFzHtBeLx1DXcvUZTdhNOEaN94UaSj3o
         7Us6hyK/aZnSErLwGseNNohGs5IBqpddRJb331P55K3+Rby2Fs41UTWwUNWllpioYJZg
         MPbsJkxYsWeMsn4kAmNYTmF2GZCzYceV/X+J01rgF2jIhiYfY0WYqseG/Zjsujn8iDZn
         O1ce75BWHVIu6SGoYJx+I/Veqv+bX1xxYUAE7rnXiths+5S0w7eGBDQd4D21rIS3NmC/
         ZmIbJ2BAufY3CgrhyqmptyrQw3YA1yg8F4q7jOKobPGnEzfb8kXqehZPJ/DWBgUwwoJy
         bEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923064; x=1734527864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8Tanh2NW1hQ/xTBVE3Ztx2L3hIaKeNFiKJcRQkCmH8=;
        b=b+HYwTIvnnw2dDNrsHQg8gnZHkcaT3rAFv9DdA14e6Wzp+YhFOK8hepTy4jzUt89zC
         w8BsJUY1ahchizKcDG4yOI7XfWcsssKlBcCmula1qup+HOXLWTJK+pfoZAZMi3uiAW9l
         HPa0pwHAALXbQGDnf1Z4dzvDZOvS/U21SdpOnATqZn74x7JERh8ipU9Ixs8tL9ZyZymp
         hVvXxgLqA98a8CBXfxTVWbFMGcNrM+CSbSVSQLtB9QvjNRPSmHre4zP3Tmj1WbSLrEnq
         TCGPQsobjMOMwJ62TGIOchQDNXHsioeOZ8C+QpNgzRm5He/KoDYUy+d0tpim8CQ5BCkZ
         4Vmw==
X-Forwarded-Encrypted: i=1; AJvYcCWQG/mhRO+JNgg7TvLQ+52KVgfcgojKwiNbA8tR/05p3Hd+Yn83RJnQwEOUPt/AnUF63MGc2TBUlvfuQuXl@vger.kernel.org, AJvYcCXdYEbjdglujc4MbXtnjNtjZbKkCfmjcV9LroXmo5FqHoGo9higPSnZGB8LQukzUPVYOQOZmI/F@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1bG4BFjPELIz3TKdUirUIkeWTZhbaPOySVLUV2XHBC9DdiPQ
	BaZz9bC1EM1etFrNf4VUwI7eBMkv6p6bEZW/veGSVNBEYWdZ56UD
X-Gm-Gg: ASbGncuMTVqe1XhYVMn2P1z+aMoYSo2MCziL3nfU9a9WR39HYxqtbB+rvIaYoxoIyDt
	wzWnxOgKVh+ZsNfQtYQZ9Kqva+LBMMds4r+lKrYCmXG/Z80vQI3vRL1b77kx5X3rvvuYD5Z7uVs
	YhmW2NqenM+64vJ4L8rgaCiFx1LDobQPwYb7NHmAKJOyF7IXPPIMUpqMw73R3cnpd8sFTNcAYuB
	KQD7y69s7C5zQc0Mw/WnK8GIqAKk2Vm3jNxW0VTJ3J+vv6lbYCu4Rv6xOmMfE7l62/s9jXIDugS
	SlkD
X-Google-Smtp-Source: AGHT+IEBTSqQMexlq8FWUe8YcY8xSHSGPsBqZZ3PeXG/2nrokbHN/WoI9SZn+bYbV5vfWCji55SMbA==
X-Received: by 2002:a05:6a21:39a:b0:1e0:9cc2:84b1 with SMTP id adf61e73a8af0-1e1c13d5afemr4963824637.30.1733923064211;
        Wed, 11 Dec 2024 05:17:44 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeb536a1sm5272628b3a.115.2024.12.11.05.17.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Dec 2024 05:17:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 0/4] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled
Date: Wed, 11 Dec 2024 21:17:25 +0800
Message-Id: <20241211131729.43996-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
container environment, we encountered several user-visible behavioral
changes:

- Interrupted IRQ/softirq time is excluded in the cpuacct cgroup

  This breaks userspace applications that rely on CPU usage data from
  cgroups to monitor CPU pressure. This patchset resolves the issue by
  ensuring that IRQ/softirq time is included in the cgroup of the
  interrupted tasks.

- getrusage(2) does not include time interrupted by IRQ/softirq

  Some services use getrusage(2) to check if workloads are experiencing CPU
  pressure. Since IRQ/softirq time is no longer included in task runtime,
  getrusage(2) can no longer reflect the CPU pressure caused by heavy
  interrupts.

This patchset addresses the first issue, which is relatively
straightforward. Once this solution is accepted, I will address the second
issue in a follow-up patchset.

Enabling CONFIG_IRQ_TIME_ACCOUNTING results in the CPU
utilization metric excluding the time spent in IRQs. This means we
lose visibility into how long the CPU was actually interrupted in
comparison to its total utilization. This can mislead users into
interpreting interrupted IRQ time as idle time, as illustrated below:

  |<----Runtime---->|<----Sleep---->|<----Runtime---->|<---Sleep-->|

Actual activity:

  |<----Runtime---->|<--Interrupted time-->|<----Runtime---->|<---Sleep-->|

Currently, the only ways to monitor interrupt time are through IRQ PSI or
the IRQ time recorded in delay accounting. However, these metrics are
independent of CPU utilization, which makes it difficult to combine them
into a single, unified measure

CPU utilization is a critical metric for almost all workloads, and
it's problematic if it fails to reflect the full extent of system
pressure. This situation is similar to iowait: when a task is in
iowait, it could be due to other tasks performing I/O. It doesn’t
matter if the I/O is being done by one of your tasks or by someone
else's; what matters is that your task is stalled and waiting on I/O.
Similarly, a comprehensive CPU utilization metric should reflect all
sources of pressure, including IRQ time, to provide a more accurate
representation of workload behavior.

One of the applications impacted by this issue is our Redis load-balancing
service. The setup operates as follows:

                   ----------------
                   | Load Balancer|
                   ----------------
                /    |      |        \
               /     |      |         \ 
          Server1 Server2 Server3 ... ServerN

Although the load balancer's algorithm is complex, it follows some core
principles:

- When server CPU utilization increases, it adds more servers and deploys
  additional instances to meet SLA requirements.
- When server CPU utilization decreases, it scales down by decommissioning
  servers and reducing the number of instances to save on costs.

On our servers, the majority of IRQ/softIRQ activity originates from
network traffic, and we consistently enable Receive Flow Steering
(RFS) [0]. This configuration ensures that softIRQs are more likely to
interrupt the tasks responsible for processing the corresponding
packets. As a result, the distribution of softIRQs is not random but
instead closely aligned with the packet-handling tasks.

The load balancer is malfunctioning due to the exclusion of IRQ time from
CPU utilization calculations. Unfortunately, there is no effective way to
reintegrate IRQ time into CPU utilization metrics using currently available
tools. Consequently, we are left with no choice but to modify the kernel
code to address this issue. 

Link: https://lwn.net/Articles/381955/ [0]

Changes:
v5->v6:
- Return EOPNOTSUPP in psi_show() if irqtime is disabled (Michal)
- Collect Reviewed-by from Michal 

v4->v5: https://lore.kernel.org/all/20241108132904.6932-1-laoar.shao@gmail.com/
- Don't use static key in the IRQ_TIME_ACCOUNTING=n case (Peter)
- Rename psi_irq_time to irq_time (Peter)
- Use CPUTIME_IRQ instead of CPUTIME_SOFTIRQ (Peter)

v3->v4: https://lore.kernel.org/all/20241101031750.1471-1-laoar.shao@gmail.com/
- Rebase

v2->v3: https://lore.kernel.org/all/20241014031057.8199-1-laoar.shao@gmail.com/
- Add a helper account_irqtime() to avoid redundant code (Johannes)

v1->v2: https://lore.kernel.org/cgroups/20241008061951.3980-1-laoar.shao@gmail.com/
- Fix lockdep issues reported by kernel test robot <oliver.sang@intel.com>

v1: https://lore.kernel.org/all/20240923090028.16368-1-laoar.shao@gmail.com/

Yafang Shao (4):
  sched: Define sched_clock_irqtime as static key
  sched: Don't account irq time if sched_clock_irqtime is disabled
  sched, psi: Don't account irq time if sched_clock_irqtime is disabled
  sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING

 kernel/sched/core.c    | 77 +++++++++++++++++++++++++++++-------------
 kernel/sched/cputime.c | 16 ++++-----
 kernel/sched/psi.c     | 13 ++-----
 kernel/sched/sched.h   | 15 +++++++-
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 82 insertions(+), 46 deletions(-)

-- 
2.43.5


