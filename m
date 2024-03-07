Return-Path: <cgroups+bounces-2011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C82874C33
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC41F21DD6
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766212881F;
	Thu,  7 Mar 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JWcRK8NQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F6127B73;
	Thu,  7 Mar 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806811; cv=none; b=nNjE8/0322ImUezEi5dXnjyEHYhu60Uqp9dlSupPQlejHFXK4AXWcS5h0REqshpO7ju9gGvyFOUOL+aP6eJwKcAE5sS7KP1u9sVt+UK2VkVqYEi2vKdLRyRE0bBvzy6mKR1PpJvdEeTfly+KpuY8PW3tSr0mz96xgKOtEBd4EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806811; c=relaxed/simple;
	bh=sFthArt/S9De8yl4FLLf4O2ocSVPkaTCw6xLaMhpirc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qx5G5XN3kXjV5bZXUymublCLbJp48qZMgXatQ+EBYxnv6NjM48Jt4Ie9JnJOUsnEIiN4D4qm5BzKw+4oUXj65mpMNKwIOuSSnZjIx1bg8qyVuh6AYEGW0ss0TXyn6EZnKCf7787YFs5yn9hxZXQWdyPG26acG1JiW1icP8SDUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JWcRK8NQ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709806802; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k3WrWoGnPi44WJ5pSTMFfxRPEbDLJx7jgfOpgLgyAJA=;
	b=JWcRK8NQ5tsCPRuIUtFk4B7IZdnmMaP5F7VLYzSjxecZL1TctF6VXqV0J+Pu4EssysaYX3dh2KJBy0hDD8lEy/rrQNzmEHavK1S3V2pjj0dq43S468IuoJCalnrEr+HRLNknlh7xy2xobMgFNjT07mg5TjJ19SWPfyi5sM/grVM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W2-P34F_1709806800;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0W2-P34F_1709806800)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 18:20:00 +0800
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
Subject: [PATCH v2 1/3] Documentation: add description of forceidle time statistics
Date: Thu,  7 Mar 2024 18:19:43 +0800
Message-Id: <20240307101945.11280-2-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240307101945.11280-1-CruzZhao@linux.alibaba.com>
References: <20240307101945.11280-1-CruzZhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description of forceidle time statistics, including task perspective
and cgroup perspective.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst       |  3 ++-
 .../admin-guide/hw-vuln/core-scheduling.rst   | 24 +++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..b82717767c61 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1081,8 +1081,9 @@ All time durations are in microseconds.
 	- user_usec
 	- system_usec
 
-	and the following five when the controller is enabled:
+	and the following six when the controller is enabled:
 
+	- core_sched.force_idle_usec
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index cf1eeefdfc32..95a4920a2a9b 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -224,3 +224,27 @@ with SMT enabled. There are other use cases where this feature could be used:
 - Gang scheduling: Requirements for a group of tasks that needs to be scheduled
   together could also be realized using core scheduling. One example is vCPUs of
   a VM.
+
+Statictics
+----------
+A task's forceidle statistics are exported via 1 field in procfs.
+
+/proc/$pid/sched:
+
+ - se.statistics.core_forceidle_sum: Force idle time caused by this task,
+   unit: ms. It is worth noting that, if this task is running on cpux whose SMT
+   siblings are forced idle, the irq time of cpux during this period will be
+   accounted to this task's force idle time.
+
+This interface is read-only.
+
+A group's forceidle statistics are exported via 1 filed in cpu.stat.
+
+cpu.stat:
+
+ - core_sched.force_idle_usec: Force idle time caused by this cgroup' tasks,
+   unit: us. It is worth nothing that, if this cgroup's task is running on cpux
+   whose SMT siblings are forced idle, the irq time of cpux during this period
+   will be accounted to this cgroup's force idle time.
+
+This interface is read-only.
-- 
2.39.3


