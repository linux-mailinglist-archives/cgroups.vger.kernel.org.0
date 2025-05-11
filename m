Return-Path: <cgroups+bounces-8127-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB96AB2649
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E83B1C96
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A531A12F399;
	Sun, 11 May 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQGWkVgB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4252BA27;
	Sun, 11 May 2025 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746932910; cv=none; b=atDhho3df94/pXsFZhh/w6dNKD3iq+SIYVOFZp0Gz9auCEmjK/eklgn9uYojfuMMwvXs7kjDef52vrFJKvZH2Z3EOL0UFluArkNlnaMHiWsWRx/YYmvYY3Lm6FgL7/XCzDlq2ieo1UVDkoWqpooLFjX/29ahDvTal9ENxdU254M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746932910; c=relaxed/simple;
	bh=kx64QZDTPZPnu1wUpgf4ckQoLynaZa1qtfkMrzccrq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nFwYr6D+/MocT38eh/TpNWHhcon73bxcQqhdJk+pRGsBmrqsVJ7E4FTNQCt6gbUZu18+1HdZk63l0gU9LAm4L1wB+TkgaZqqOLXFoDsKa7UoE34LoRzFK6NDW9vzQXR6/qpcIc5Yof5MoLIQgI9Wlwadn7YFSlJzD5ZLeX/0Z3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQGWkVgB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7403f3ece96so4620168b3a.0;
        Sat, 10 May 2025 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746932908; x=1747537708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMEeBBL3sWvEKe588wbTfbAbFclKjYZq5MxNFVNZF/Q=;
        b=TQGWkVgBWxuE19ODkzbUOopi+4xxU6/SDrMQXGbz9/+IZAG7FJzTx5GmLZhEU7kmKB
         b6rSbqsf2sO/D/QTr8RfMGOfbF3zlr0EkjDnKzQSokYs+yFLuPStA437s20mjggEDriq
         ETVwPYZTH6zhhws1bFFZXFPfzuOj/ADOznO+zf9zmv4VS7wxQiMno2ISrXxIgfwaQxjI
         dd0dY1vzdOhePjTBnH3ShjYAPFYY1XtpFVdbTw7Al62j+vPpOgs5fXIj4IMkmJA5o8i9
         j4DCyRp9RiL1CcYSExA4sUIaUiNAYfSwEUaKWYPUC/RUBFNosLWjRLuPfgG1fXonn7WQ
         POYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746932908; x=1747537708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMEeBBL3sWvEKe588wbTfbAbFclKjYZq5MxNFVNZF/Q=;
        b=JfRm4IoByf/7wZ3b7Z5SDN/5gUTc7RNynmBcFBoJDbC9ffE2qB04MwDJOxjI92l+XJ
         Xu338qaxQydvqcP1aTz0PrIzi6k+abPs3gOxGEaL/Gda2iERpylqSI2o6vR7pYHsP0QR
         TTgfmZ3KTqq1KgrEEmd9h03M4mRUe9CDdpvgmrb+qLAl17iI3YyErEf2dhMZc1Qu9tPs
         4D0ys/3tujhVOlBI2iBGLU4iDBOILNfOQxho8UTA8mvpljObAqJzD0qrtmH1LlMhug+0
         eGfBiW0bbbEYFST2t3OmvlHS5SxLss8J/b2CsdD9T2kbcxYQOLDJwnYKpAQVa2KyLUsw
         o9aw==
X-Forwarded-Encrypted: i=1; AJvYcCWH8Y4gvdgyLFHYE+niMFkk+2tgSH2YcT8M+I1EukwHvP3851JkOVXUrhDVDSpDTgmC6lVRj7p0MMrPkDmW@vger.kernel.org, AJvYcCXatPoJ5EFOH0IHSETIVHDa6zWZ7YoATBMOUnCOTvWXxU/6p3eKkjJrw0Fgw93kjZZw6G10N/Dw@vger.kernel.org
X-Gm-Message-State: AOJu0YyTB2FoIOjIwHcv6c2Q4z7be494J6j9kanoUcD2wZhbXKmgreUJ
	aDnSUQ9RBgpt7mNGqBDLH++M4gRy2WFxNLsHH7FGcmDKbvZJ1dIb
X-Gm-Gg: ASbGncvkoEwd7y6OgbnpZ7Qqi6kGEiIdSjnkFCpsrZRIur+ICWW/pWIcM5xtUjvmhlw
	h0pqYDRqWMDHFIF/RPxNDsKvnhX/F+4buhqeCU7tMaywi30VlBTMFzdefXWhhXpvULiMOMNpH79
	EiNbElEchc8B45htdcV0cvCGk1WstziANacEOlNeyPImMX5NqSzphGJ6JRN0uD1PZyQiLjMqHFk
	8Zj1CJ9f8ySJXZJNmIsnlg9BMD2jzQjtIze9JD/0VWKAXSnY3Kn+t5pIP/Uo5QjbbxKGexYXMdQ
	UvS4pxpUA59gpkcBdRWax2iXzHRi0AF7odBawNj8OXWSVlSXUcLf7sM2aRqLRiVLln2uiwegngc
	N
X-Google-Smtp-Source: AGHT+IFbonlK1edREGxO+w2TOGZ+3sc1i2K+F2d6ulIngB5qVPe66BP1fXHH5dlc4vms5O/QxfJ+Pw==
X-Received: by 2002:a05:6a00:a83:b0:742:362c:d2e4 with SMTP id d2e1a72fcca58-7423ba8a855mr11589957b3a.5.1746932907888;
        Sat, 10 May 2025 20:08:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.107.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a105fdsm3956883b3a.100.2025.05.10.20.08.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 May 2025 20:08:27 -0700 (PDT)
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
Subject: [PATCH v9 0/2] sched: Fix missing irq time when CONFIG_IRQ_TIME_ACCOUNTING is enabled
Date: Sun, 11 May 2025 11:07:58 +0800
Message-Id: <20250511030800.1900-1-laoar.shao@gmail.com>
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
v8->v9:
- Rebase it after the discussion with Ingo
  https://lore.kernel.org/all/aBuI36FCDbj20x28@gmail.com/
- Mark sched_clock_irqtime with __read_mostly to avoid possible
  cacheline false sharing issue

v7->v8: https://lore.kernel.org/all/20250103022409.2544-1-laoar.shao@gmail.com/
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

Yafang Shao (2):
  sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
  sched: Annotate sched_clock_irqtime with __read_mostly

 kernel/sched/core.c    | 33 +++++++++++++++++++++++++++++++--
 kernel/sched/cputime.c |  2 +-
 kernel/sched/psi.c     | 13 +++----------
 kernel/sched/sched.h   |  2 +-
 kernel/sched/stats.h   |  7 ++++---
 5 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.43.5


