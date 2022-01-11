Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8D48AAE6
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 10:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiAKJ4M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 04:56:12 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44045 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237061AbiAKJ4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 04:56:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1ZVy34_1641894961;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V1ZVy34_1641894961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jan 2022 17:56:07 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Accounting forced idle time per cpu and per cgroup
Date:   Tue, 11 Jan 2022 17:55:58 +0800
Message-Id: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are two types of forced idle time: forced idle time from cookie'd 
task and forced idle time form uncookie'd task. The forced idle time from
uncookie'd task is actually caused by the cookie'd task in runqueue
indirectly, and it's more accurate to measure the capacity loss with the
sum of both.

This patch set accounts forced idle time for each cpu to measure how long
the cpu is forced idle, which is displayed via via /proc/schedstat, and
also accounts for each cgroup to measure how long it forced its SMT siblings
into idle, which is displayed via /sys/fs/cgroup/cpuacct/cpuacct.forceidle
and /sys/fs/cgroup/cpuacct/cpuacct.forceidle_percpu. It is worth noting that
the forced idle time and the force idle time have different meanings.

We can get the total system forced idle time by looking at the root cgroup,
and we can get how long the cgroup forced it SMT siblings into idle. If the
force idle time of a cgroup is high, that can be rectified by making some
changes(ie. affinity, cpu budget, etc.) to the cgroup.

Cruz Zhao (3):
  sched/core: Accounting forceidle time for all tasks except idle task
  sched/core: Forced idle accounting per-cpu
  sched/core: Force idle accounting per cgroup

 include/linux/cgroup.h    |  7 +++++
 kernel/sched/core.c       | 10 ++++--
 kernel/sched/core_sched.c | 10 ++++--
 kernel/sched/cpuacct.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h      |  4 +++
 kernel/sched/stats.c      | 17 ++++++++--
 6 files changed, 119 insertions(+), 8 deletions(-)

-- 
1.8.3.1

