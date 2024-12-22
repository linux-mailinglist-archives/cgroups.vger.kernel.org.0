Return-Path: <cgroups+bounces-5984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1869FA37E
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 03:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1267166ED3
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592E1AAC9;
	Sun, 22 Dec 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwhx3mN6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5E847C;
	Sun, 22 Dec 2024 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835676; cv=none; b=KMDXYR27ye53r+pInycR/WLNXwilQWBi79QNATI5OoZpPMWMK2kjw4KhUwlNFQbh7bJtPTFGdvu+nmyPFg8XQMNz6MgCqp4StOAyheABBFgXEt3rgNTgdFtMEWfkdPFgu3rpiqciFGqllooA3Xrr9GtStNROg+nXu4QGcWqfK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835676; c=relaxed/simple;
	bh=FlRgg2fiWfBRl1IuZ32hwgRopiOwpnTM7bcJNBlLz0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FtsQ9eOkApIbAy0QtH1WwWA/al4yPrWG6rArgirwx5VnShOlcy4CCDxAwiOBPgf8xCmMuvqUvZsS9ONWh9T0At+RQw9sn95ZRAbp0z7b0WF6CFNsq5Sxn3cf85lCF9ToCKL5ntRFppqgG6f9X2RNRNPagYQoK4Y0bjTjVRQzKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwhx3mN6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso3707650b3a.0;
        Sat, 21 Dec 2024 18:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734835674; x=1735440474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FO8rInDOu2JFbZe/K9RwLg7QhRtOMGb19Km8CUvAsg0=;
        b=Fwhx3mN6xCDmBfGbOnDVUKWwpLoBILg72oPau9ooFWJUCjQw2nmSi15nP2T6XpY5q2
         MYsKu+7MP12eIFE/WQ3txjLRdgdUXM7TghodT3OggIe44SuJ/q8LY+8YZE8huuWd1ZDO
         NS86e91eaBVXxN3roeJM4tXD4OdpEImElpYtqo97m8j5xmQxfJPTh9MeiYaaMsp1DYA4
         yD5sT0tRfukL8WCgy+eDAWPHOVieDlzP+f0I5gyX1S7RyZLLW3kPp0oR5PB1TzaKu5iw
         /wX3ly900cL01LcvCEH6oqwF2w/U7FgVLUUQcbpL66Z1eiNzhzFOte8LHFO24yLj+d2a
         QkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734835674; x=1735440474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO8rInDOu2JFbZe/K9RwLg7QhRtOMGb19Km8CUvAsg0=;
        b=eQF7Bh1Om30VEzmZAEECjl09sqIrYBKGmQeevpFd5TNQ18JW/Kjs911ZqR88aGWRHT
         389kEGJgfg7PRFUds5phjRJhtfXjtAZ7DmrTOFevZ6ZWAVUwqq0Qzin8eJBQXo/VJaTa
         sGIDQOrKlMz7WqF/qBADgJFYmM/neC20tFZx6z1g2yQLHHkgRR+n6rlu7G/mNO4KKLWD
         8EJcHLkq0jz90J6L0yCITAIg4En5ziIEMRj6Uc9yyvQjWNHjAtYo8p93mYF6Xa6XDcVb
         VKYcn76qwrH9SULpjt9HY8IcZZVc0pX78C3Cnv+OgLshJNedV8wEMnjhrGfUlIcHWRIn
         Gkiw==
X-Forwarded-Encrypted: i=1; AJvYcCUYTkZuvEnBCMruhuu9zmnupWCynr2Jwg/FFC23jGYm1pkpoKw9QTXEg64Y+Of31608QaUQ/VsA@vger.kernel.org, AJvYcCW1eq4zgCowSek/JDh4bgXJlDS+Ahb+scY7QEIjRRBQLJToocnW4W3OBg7w3jvupZt+stmjRQO2lsAZM2sN@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKw+qe0N/e4OlPynVSsm3u1NzzJHPySbw0oveou5I/TmDkKFI
	f1GbYn7PUsABn18Ovl+FY6bRgAGcT93l8S6llSvjK/iPwoWmuEHd
X-Gm-Gg: ASbGncurdfmUFsx3A7PVr2KWxlMQkZBvvXng1mbRBnO8rce/3l4wlAjKyjfwkdSiAP5
	SZu5obLyAP82t/H+phPCY4Fdl9O/ZK7kgOyCVUP8eAnuiJsx2zSQxmAGkZUNLRSAChaUHwlKWYx
	uDDLz8fnUtYuF7e8ghV55/heA4ow05C5kkm2NvgK87VvlxfHBqqtIMn+U+G6VVcyGQx8Nw4+viD
	HsjVVAkeknQC6HnS8oqeIwcUMvbZDkr+Xj8S6lffAhD4GLuCulq3kWI9CDW7TxZTJNjLrKXNaSM
	6itE/J4=
X-Google-Smtp-Source: AGHT+IFGrCem6z5j8K4EFgotVihfBEeuRQUgl/QAeOkJis0wFjXRq24SRbQNQupejcfgdgm2cZ9D7A==
X-Received: by 2002:a05:6a21:e8d:b0:1e1:adcd:eae5 with SMTP id adf61e73a8af0-1e5e0846948mr12974405637.42.1734835674072;
        Sat, 21 Dec 2024 18:47:54 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01b8sm4219265a12.20.2024.12.21.18.47.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Dec 2024 18:47:53 -0800 (PST)
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
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 0/4] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled
Date: Sun, 22 Dec 2024 10:47:30 +0800
Message-Id: <20241222024734.63894-1-laoar.shao@gmail.com>
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
comparison to its total utilization. The user will misleadlingly
consider the *interrupted irq time* as *sleep time* as follows,

  |<----Runtime---->|<----Sleep---->|<----Runtime---->|<---Sleep-->|

While actually it is:

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
CPU utilization calculations. What's worse, there is no effective way to
add the irq time back into the CPU utilization based on current
available metrics. Therefore, we have to change the kernel code.

Link: https://lwn.net/Articles/381955/ [0]

Changes:
v7->v8:
- Fix a build failure report by kernel test robot

v6->v7: https://lore.kernel.org/all/20241215032315.43698-1-laoar.shao@gmail.com/
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
 kernel/sched/psi.c     | 16 ++++-----
 kernel/sched/sched.h   | 15 +++++++-
 kernel/sched/stats.h   |  7 ++--
 5 files changed, 86 insertions(+), 45 deletions(-)

-- 
2.43.5


