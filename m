Return-Path: <cgroups+bounces-5477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17729C1DFE
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978EC1F217B2
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9043C1EC001;
	Fri,  8 Nov 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEZTbB/2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA71EBA18;
	Fri,  8 Nov 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072557; cv=none; b=j8qw6yM/8z7FIzTt3/mdtcYAhJnnVYIs7NEg8SrwAu9VWXgto9eLXHg99jKkoLcvsJPwovzZSnnKcs4WkLwp3JrdqKUu4TUTC+Q2qffZaBNFklE5gu7ajsAYfIXW4Std//K2A887zlcYNZYfhLKfoTx1PYU7ElpbKa2iYA8otiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072557; c=relaxed/simple;
	bh=c30E1/lld3o/ZHf7kUJhQ3IIdEvfGMT4NT58P1RW7lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GdNuURPM9+A8mMzSgyPIBeF7PII51+TYj9wB2juMaAcmc+sBa2ERTvdWcTO5JIHS5m++nukPT687hIWMWOa7qY7FENOtAv4rdFs4Sn+ZAe63ZSx2i/LdamgA5tN4WlnwpImQVm8vHN7is+C/bPPvSOZDMgdEGW0p6k9w/nDj5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEZTbB/2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1532027b3a.1;
        Fri, 08 Nov 2024 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072555; x=1731677355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytmxS4QcqOH2tK4MkIoNkfKYtFlgq0b1sTj7YW/3eik=;
        b=DEZTbB/28KdYHpMZ28T/cmje/QFQ0WSBGmr/fU54qcvPfNEL6ihBg/4k5lyqexMFKz
         I31fcpc+B/+1WTl+w53fvO464hpCCnAaXI8tftZM54U6lrnZzNWwpKdaHV/KAG18S3Ac
         MB1Aox3o5HILI6AQrxvqzFSh1PcQhVC1m84i2n/jjEeRf2bFIbsI4IfJx3pBPWawl/P/
         S1x6nNnl5OUh7DtUp177Cte4YIsCxz8JO2U38gTccZYrXA9AcMOPdfwCYMkeNvTdk5qL
         bUmNKcGgOgI8NfdeuTPCrNDmRWg1MHnn95K1D/hHSw+z5659MBm2DbJ/cZPsizfssUn9
         pisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072555; x=1731677355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytmxS4QcqOH2tK4MkIoNkfKYtFlgq0b1sTj7YW/3eik=;
        b=ZICZZ3Iqh/LsMHJLh3xrmpzxwbz6P+UVthwBYohZJTy8WGjcdK80xvdeJwIVC/TOtm
         vaUT0mETERqTsPeb6xpGutKpQuU3Wp0t+2FZLWHBtdP+lYXpcbr9+Qc3IAdCxzpZ9idO
         dKspEUJ3HNgUiYlGLzGImY/B6+sA4SPlv4op/QJKjb1rUF0cLyx09sTC1XollPZoC1Gd
         mCR1jIj1MSv6UYf0NzqNawsnlKeTixpGNFZMrZMPB++kP49tZx3BQwk1cGg87E3WxFvP
         tSN9BEaiu6HblLM1xCQcNeyZW/6PB7tsgr91wkhbWLYK2xENdIGFlnJknqN/g3o4E1sq
         22DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSTsmm6zCGGN5zlziwRd9zACTl8JDwy5s1Rxqyyrc+8zCAI6NoZQXCGYB8Zhv1WY6vnF4KaeUxSu2Hv6Lx@vger.kernel.org, AJvYcCXtJTI943bYo4mOETv38EMLteT6vin4RmvNJLNV123e8SD5FGtBMTntSz4Teg3U1mt70vtuMvpo@vger.kernel.org
X-Gm-Message-State: AOJu0YxQR7IUmV1s346RhJAA5JeCekDOl7oLtJb7bITF2D0BpFeeUZ0v
	U+F2LqTFmO0zmLmQuJoi1Nb/yOklTKM1TIrm6x/aRwE6F3SHDv4p
X-Google-Smtp-Source: AGHT+IFCHrupnA9dGQ3nTX/CJT4uBx1j1t/FKeaGHa4H42gUeFgoHNvWLX+AAGqRwueMnpMHfwVMxw==
X-Received: by 2002:a05:6a21:1690:b0:1d9:aa1:23e3 with SMTP id adf61e73a8af0-1dc22b664d3mr4031210637.32.1731072555057;
        Fri, 08 Nov 2024 05:29:15 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm3642561b3a.86.2024.11.08.05.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:29:14 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 0/4] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled 
Date: Fri,  8 Nov 2024 21:29:00 +0800
Message-Id: <20241108132904.6932-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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
comparison to its total utilization. Currently, the only ways to
monitor interrupt time are through IRQ PSI or the IRQ time recorded in
delay accounting. However, these metrics are independent of CPU
utilization, which makes it difficult to combine them into a single,
unified measure

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

The load balancer is malfunctioning due to the exclusion of IRQ time from
CPU utilization calculations.

Changes:
v4->v5:
- Don't use static key in the IRQ_TIME_ACCOUNTING=n case (Peter)
- Rename psi_irq_time to irq_time (Peter)
- Use CPUTIME_IRQ instead of CPUTIME_SOFTIRQ (Peter)

v3->v4: https://lore.kernel.org/all/20241101031750.1471-1-laoar.shao@gmail.com/
- Rebase

v2->v3:
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
 kernel/sched/psi.c     | 11 ++----
 kernel/sched/sched.h   | 15 +++++++-
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 81 insertions(+), 45 deletions(-)

-- 
2.43.5


