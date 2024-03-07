Return-Path: <cgroups+bounces-2008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55914874C2D
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790491C20BDB
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AD85269;
	Thu,  7 Mar 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CNesCE0U"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0782D83;
	Thu,  7 Mar 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806806; cv=none; b=CxOzeKSDWCxfIe5loNbsHLxRUDNoP8juDhNdmpFo75/Vp6x20aSdmGZ2Xo63W2KL5rZZVOXFoWR5h9F34EXiyMFu5rBQnxmz55RhDgPEot7Jh/DFwwVk7UqRlUMtDHQfBDIaXigo4NbeLDBgSnImsXsXfmd+SIHszukGa1SYo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806806; c=relaxed/simple;
	bh=ub88lbJOL4Wat28qZNBz2bFPtKjdrcJgNdHz3fHVpk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOfHEDiwjFOOQp78/Dz/SuyVIJSFNSMKuUrj/GpvtWvxpzDZAcgy8hSEggdDI+iVrbL8bdRESi43plwUjnGOUsRam/c3LCcvkenV8uHE4lpcw2K+oU74sU2uzAfLeHnLKTKKjOxkguyHe14q7v2VnfBpsOI4QSUKpQlZ5zegHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CNesCE0U; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709806801; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3p+NFO3SqwENF9m8aZP4ZJnc/MkG/qNo1PyeLiJvKTk=;
	b=CNesCE0UrWJsdI40UlCujF2Aj/GczHsuZJiCq9IB/klbu1VRYltUq0JbHuUXPIBqeNTIIAXBJdbKD19E2fl4HcGq/7LBg9D5A7PXh7WShf1trljtkfduhCsOVawiRJQR1uhMsNfOiHLrUXbB6CAuAOv8i5vn0+fLTEgnkFUZBUo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W2-P305_1709806785;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0W2-P305_1709806785)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 18:19:59 +0800
From: Cruz Zhao <CruzZhao@linux.alibaba.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] introduce CPUTIME_FORCEIDLE_TASK and add
Date: Thu,  7 Mar 2024 18:19:42 +0800
Message-Id: <20240307101945.11280-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As core sched uses rq_clock() as clock source to account forceidle
time, irq time will be accounted into forceidle time. However, in
some scenarios, forceidle sum will be much larger than exec runtime,
e.g., we observed that forceidle time of task calling futex_wake()
is 50% larger than exec runtime, which is confusing.

In our test case, task 26281 is the task with this problem, and we bound
it to cpu0, and it's SMT sibling is running stress-ng -c 1. Then we sample
forceidle time and runtime of task 26281, and stat of cpu0:

  [root@localhost 26281]# cat ./sched |grep -E
  "forceidle|sum_exec_runtime" && cat /proc/stat |grep cpu0 && echo "" &&
  sleep 10 && cat ./sched |grep -E "forceidle|sum_exec_runtime" && cat
  /proc/stat |grep cpu0
  se.sum_exec_runtime                          :          3353.788406
  core_forceidle_sum                           :          4522.497675
  core_forceidle_task_sum                      :          3354.383413
  cpu0 1368 74 190 87023149 1 2463 3308 0 0 0
  
  se.sum_exec_runtime                          :          3952.897106
  core_forceidle_sum                           :          5311.687917
  core_forceidle_task_sum                      :          3953.571613
  cpu0 1368 74 190 87024043 1 2482 3308 0 0 0

As we can see from the data, se.sum_exec_runtime increased by 600ms,
core_forceidle_sum(using rq_clock) increased by 790ms,
and core_forceidle_task_sum(using rq_clock_task, which subtracts irq
time) increased by 600ms, closing to sum_exec_runtime.

As for the irq time from /proc/stat, irq time increased by 19 ticks,
190ms, closing to the difference of increment of core_forceidle_sum and
se.sum_exec_runtime.

We introduce cpustat[CPUTIME_FORCEIDLE_TASK] to account the time
that a task is actually running while the SMT siblings are forced
idle, using rq_clock_task() as clock source.

     |<---------------------forceidle time--------------------->|
     |<--forceidle task time-->|      |<--forceidle task time-->|
     |<------exec runtime----->|      |<-----exec runtime------>|
ht0  |          A running      | irq  |         A running       |

ht1  |                          idle                            |
     |                        B queuing                         |

Interfaces:
 - task level: /proc/$pid/sched, row core_forceidle_task_sum.
 - cgroup level: /sys/fs/cgroup/$cg/cpu.stat, row
     core_sched.force_idle_task_usec.

This pathset also add description of forceidle time and forceidle_task
time in Documentation.

v1--->v2: add description of forceidle time and forceidle_task time in
Documentation.

Cruz Zhao (3):
  Documentation: add description of forceidle time statistics
  sched/core: introduce CPUTIME_FORCEIDLE_TASK
  Documentation: add description of forceidle_task time statistics

 Documentation/admin-guide/cgroup-v2.rst       |  4 ++-
 .../admin-guide/hw-vuln/core-scheduling.rst   | 30 +++++++++++++++++++
 include/linux/cgroup-defs.h                   |  1 +
 include/linux/kernel_stat.h                   |  3 +-
 include/linux/sched.h                         |  1 +
 kernel/cgroup/rstat.c                         | 11 +++++++
 kernel/sched/core.c                           |  5 ++++
 kernel/sched/core_sched.c                     |  5 +++-
 kernel/sched/cputime.c                        |  4 ++-
 kernel/sched/debug.c                          |  1 +
 kernel/sched/sched.h                          |  1 +
 11 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.39.3


