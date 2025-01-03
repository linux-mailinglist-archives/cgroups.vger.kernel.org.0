Return-Path: <cgroups+bounces-6035-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A516A002B2
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1520A16252B
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9BC535D8;
	Fri,  3 Jan 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsLcqZrD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879F1119A;
	Fri,  3 Jan 2025 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871065; cv=none; b=cxK+K+/ISsfthOXQAcPakMEEX2CjeSfM5JXThPrZp60sLbZRqjaFuw5r25StEva8U6sCkQ5mKgwGdiasvr9I2ayrziKIzrNFbOZOnOTCe+4vHLZKKSMZErQ73ppQlnfLchhptwTpjrgbB5waF/BqzmiJDQ1YfYnLjq7L1GuGXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871065; c=relaxed/simple;
	bh=FlRgg2fiWfBRl1IuZ32hwgRopiOwpnTM7bcJNBlLz0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HAN1XE/n5ojX7oVwZNMDusw5OZny03vWNlUbnzPUUVhnFs6nFrMdQg5tth3+eHkeRCVGV7lYdFGRkd69uCNUyApBvTfLWZqRFF7BjtCqjVUr2ilIXUSA/iGH7gtYTcyMPj21EIDgZDZlXe8tl1iSFUIP2R5Oyu+YfXDPLJzN+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsLcqZrD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so13210894a91.3;
        Thu, 02 Jan 2025 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871063; x=1736475863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FO8rInDOu2JFbZe/K9RwLg7QhRtOMGb19Km8CUvAsg0=;
        b=QsLcqZrDya3fXkKrvmq0Kp97RV0UWbzUW9wgm0qKa7eyQJp6Yrz3WxJRCbl+aWI3v7
         Pf8WSLTcIEjJmuDPZKUBfkOtH3aP36TH0wJUMBHR5RRM/2UVy1teGTKqWXHSy2TMMYgk
         iqxirwPZ/YzR/lqYCnhUOSb/SMhWt/JTu1IQs/JOkPNL83vlD1vpLJONi2yvX0qtdLzT
         A6abGJ4wQlmIlmDZy/BB38enjytmMr0jhGuGEJ3eQgO4Bgvi7gYAGSQJEZ7D+jyjlQDT
         O7tLq5Ugns3uLqZcaV/qIlPWNXaG81xsGkRiwoJpHe3cLg+rDU5x512zc6flwOPKCROf
         14qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871063; x=1736475863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO8rInDOu2JFbZe/K9RwLg7QhRtOMGb19Km8CUvAsg0=;
        b=tsFF+vJRKtq8634ChRXvoTEGEM9S3KdztmRumsiQxXa2M2PXD7SKXRF7vVYNtRHkRn
         GIhfb3M9TOUSijQgKvEDfaHuh2oRehMIZ+1J9sRCIVvMR9+aL0a3/QM/manDa9x8ruHE
         fMyNmNonxI52kJM5DUdrbIe//eK7qC8MsF8l5RQUO/om7Cp1yZmqNIZPVC8OJr9+A9Yt
         rzN4CyhM3ZHsviyWksmVMQ0dEDoCimZ+rpw+c+ySa4Zqs5fQoP0BzmXMB4ypsA0F+847
         7JcNN5wiy9IcRGu9DBEwF3D1um8lbc5A3B374EOFNvpMVJfyLkD5fsm/ei73WF+iCXUQ
         knlw==
X-Forwarded-Encrypted: i=1; AJvYcCUF9Zj4ShnfxI+lo/ovkWPZy5PPUFv/4KDd5AntrkwqyaCh7u0KBl6UDCpU7x/1ijcF72uzzr54btJwzxqA@vger.kernel.org, AJvYcCW4IkRm44BgcAGKMqjT1bX/F7e3lffHAkshhbKMP4uFSMugKasGeJd0OCEXU4xQlMhMA8j/tPyL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6X5UNFPFfeIqsRT5IbbnLb1bsE5il5mXeZlvhXc8Be2Kj7SN
	Mf0m6xXvNaKw3agkH/CKNbwioBQ/6LT4gQkeue883DRfFKuQTiqJ
X-Gm-Gg: ASbGncuVepjCD0+DyRNJsjBYmZjCzAzsJV+KtBw3+oOMzmSzO0oH9F2TZIctDaMFEVg
	XiU8KVAScTO2F6nZsq4OMgFRZLht5NmQmLTV6fcZ70jATwGQyntReZMvAJK4PLXicB4s7v9pIOZ
	59S+gwuwOd9NNCQf3C6pL2bvW35hbh9iKrtxQW7ElVSQ5vS1VXe8DQrvDJyQjcmcuZ4GykOwdBc
	5JgO70/AmIsejlZ4Uq82mJIv0r01xbLY/3LRB21q4gqV66tL6rwXbXDgXPOWMO+15nary3MuGXC
	o47Sq48=
X-Google-Smtp-Source: AGHT+IEh0BLBnTflOxTU/7DCtnNXT50gz3usSn6CSXfIQ72Zl/EGNs45iRw96dMgLKZwCJPOamhMaw==
X-Received: by 2002:a17:90b:2c84:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2f452dfce88mr78632534a91.8.1735871062617;
        Thu, 02 Jan 2025 18:24:22 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca007f3sm234184145ad.228.2025.01.02.18.24.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jan 2025 18:24:22 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: mkoutny@suse.com,
	hannes@cmpxchg.org,
	juri.lelli@redhat.com,
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
Subject: [PATCH v8 resend 0/4] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled
Date: Fri,  3 Jan 2025 10:24:05 +0800
Message-Id: <20250103022409.2544-1-laoar.shao@gmail.com>
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


