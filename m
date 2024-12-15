Return-Path: <cgroups+bounces-5896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168F9F2208
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 04:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43846165877
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E414C62;
	Sun, 15 Dec 2024 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD9FSfgS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3F28F3;
	Sun, 15 Dec 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233006; cv=none; b=ln2Z54e9K2fPF6kIZrwaxUpxpQTR0eS4TPUDGBeWsEk8Rl6TR/T+xmR8WynRzXqlL2bqpcG+gAgbLd3jx0+gwDFQrVhruIb3F+sihfBF7iV/QGy2poVsPhuq9y8IBvW2HXyNqZdhucYGK3qEV8o5dw4a4IxKAfOOVALk3nDvuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233006; c=relaxed/simple;
	bh=FM+xIHK421FwawnJDqVUr7at8vnc6h7sv5IrivUGpKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dKpaP/6LPZ5fxfayHXaWDX23UHId0KWGSTp0laohDc+ZG1uQ8+CgVqf0UrtSUDdzdDiks4taW9WQFCmjSKRpwsxB+Z5ohkExogaq/AS0jatFvEIIQclOYm86AL0TH1ZiPmc9/4i1PU4bT55kdqHcLy0bLIbZ9tMoCKSRaUMaBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD9FSfgS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2444126b3a.1;
        Sat, 14 Dec 2024 19:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233004; x=1734837804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9p9Or1aNFBWxwKFWOE57LiaEmm7BZrbXgAUFQfhvNaE=;
        b=nD9FSfgSHCFp0LKpPiyRRvDmPoRexygMZCOFoQDki66gmpF0WYZmwA4y18GaFqD4Sf
         ONCUiSpMKIurvxRn6xFE6ZrQ9hpKt4K0Dwl1DyRl72ciatZxdqeI57odVi2rwAIyn45e
         oXDY6s4P32xNsH1zJSR4WXPl67FmW9ALDWSLhAQyhej4PUVe73hU1Ih42u4h77Var8Bx
         gr3xADPRxKKnzorvXf0Pgcl9QuPQILjqVrCEIxnjk5AnOb9nwmGlUtpmOazJjto8Vhp/
         hGq/mF7jPWXXavgPMDPa9BReqBtKo80XUO3+OS/VdgtSUPSwviKVnn0T9jzc4otqLLn+
         6Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233004; x=1734837804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p9Or1aNFBWxwKFWOE57LiaEmm7BZrbXgAUFQfhvNaE=;
        b=LMTviiBbTAypBdKzHk79oOVxbW0n9OGwmTD6h2ltIuq7rE/K6VXG/bTB8EsS9zt3yZ
         D3rO2z/Y5V4N7Ey3P6+prtjvWgO/GmgKYLRdDJpNg7VLX6KAXxDly2UZDBaRZZAX1Cud
         0SNPy70uobJhPY+BM99WlPke21OFL9kZ3ow5uo/XSrbkbVl919WCD2Ti1qKxk1q7wPOX
         TzEXu0ECXSUfiXXhsz5exYhTloRxk2QUMGv8XlU5bXs1TIddygGdCM4mhAxir/3VZN//
         4nlpGVGIQdZjEv6uUxZct8yOHraX3v4DQ60/AseABXq1kWczNu+3T2PV98btMCmNRKfE
         fqpA==
X-Forwarded-Encrypted: i=1; AJvYcCUDrfXzIQfQIf7yZ9Bfe6jMSMG9oj+kfj2OexQFPxfzxstOSnvOH+d146UBLvt3hlnEmxIkpXfNWvT3Qqps@vger.kernel.org, AJvYcCWw+b0a8zwt9DBtcDJC3yht9sOuQsD7LaSJ+F7Vi+XhapcRFkwVUGlu0LZXKUL8YJie2of6rGmT@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMTWIGAZfGclKWbkx6kiCOOB76ED+Z6o1Nc9bLytbRKncNuYA
	TzcDex6B03IbHac7rOAEheyRNjui5QgcllovEXF3iOU4A6X0mSsk
X-Gm-Gg: ASbGnct76AELRQKXybahdBNyeA2AvdOrRuRdwUWq3ZFTj4lcINHL5Yyz4StBIWmH4oc
	WDKMg64WKWjRO3IY1amZ6iYGCu0iarlQpyuyprucqjHoRfF1AuWlbqgiT/VqcS+0LOzltNRN4yE
	9f/OUgj9QCOGHB00Rj/Vv7JGtOKH83RNtdRDzg5LfIwko+qPeOvWPR35SIzDh4YVy/ejXC6QjSD
	D1PlbPGxNko3B5pb6BuYhJrgA8SfgvVmJhKWfMgOAtkrztjeRwwjKLNSiifGpSQLNBWpOVud0u7
	xJKRVLE=
X-Google-Smtp-Source: AGHT+IGVAbXDYJwGRzG98sNgcQF9wlCH09StuIaqXcNHM3eTlypwplZa8C8g1CT8UlBVv6MAC1aq7g==
X-Received: by 2002:a05:6a20:9186:b0:1e1:bf32:7d30 with SMTP id adf61e73a8af0-1e1dfdd4956mr10126692637.33.1734233003932;
        Sat, 14 Dec 2024 19:23:23 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f1esm2176586b3a.92.2024.12.14.19.23.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Dec 2024 19:23:23 -0800 (PST)
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
Subject: [PATCH v7 0/4] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled
Date: Sun, 15 Dec 2024 11:23:11 +0800
Message-Id: <20241215032315.43698-1-laoar.shao@gmail.com>
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

Enabling CONFIG_IRQ_TIME_ACCOUNTING modifies the way CPU utilization is
reported by excluding the time spent handling interrupts (IRQs) from the
CPU usage metric. As a result, we lose visibility into how much time the
CPU was actually interrupted, relative to its total utilization. This can
lead to a misleading interpretation of the CPU's activity, where
interrupted IRQ time is erroneously perceived as sleep time.

  |<----Runtime---->|<----Sleep---->|<----Runtime---->|<---Sleep-->|

When, in reality, it should be:

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
v6->v7:
- Fix psi_show() (Michal)

v5->v6: https://lore.kernel.org/all/20241211131729.43996-1-laoar.shao@gmail.com/
- Return EOPNOTSUPP in psi_show() if irqtime is disabled (Michal)
- Collect Reviewed-by from Michal 

v4->v5: https://lore.kernel.org/all/20241108132904.6932-1-laoar.shao@gmail.com/
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
 kernel/sched/psi.c     | 14 +++-----
 kernel/sched/sched.h   | 15 +++++++-
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 84 insertions(+), 45 deletions(-)

-- 
2.43.5


