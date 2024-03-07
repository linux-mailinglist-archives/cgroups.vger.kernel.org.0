Return-Path: <cgroups+bounces-2009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112A874C2F
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197C01F221C2
	for <lists+cgroups@lfdr.de>; Thu,  7 Mar 2024 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5885636;
	Thu,  7 Mar 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kz4Pymdl"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6A84FD3;
	Thu,  7 Mar 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806807; cv=none; b=bv76Tur9gIhhWWPJgabufcDv+KoWAKU9gq0vR0LePxoEPoccl2Wq0vctKKbA6szn1q016llne4Z53l+K9IndXiUP84s+Kak4jiWsCOduffjB1N8r7DeZAocqQbgTAUpMVL5g9IDXRNE/vuhJRor5vLgSSJI3OmddgZoL7RLWZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806807; c=relaxed/simple;
	bh=gtK73kFCrJuZi6iIsM8K67PHNoTnit0Yg4agxJUmBk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMnKet7jt/XWyDbGZbJ3uO0cA92bdgLeJ05LD+l+/XcWUbqWsDPMR9q8OGcDRpObFvQNGMx1v3Lk8j6hdPJVDSnE91VyLF0oSeaEeaa6UDXNmyqHLnVuv3Rlt+9LxaGEw3MY2kGNz1+zmKkijclt7on1QxysUA9Q0MibmFDxa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kz4Pymdl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709806803; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b/oRXxd/jiv8L0kKEtNlIWGs+JB+BD0A/RGPs/ecHVg=;
	b=kz4PymdlLVh3B70wQeY9DuxQY9ulp4CamIOGz9MH69u4yesCXS68fyc8Qby+IYAr7XGFdNddKDpTNTBhsrl64/XL9mjtqevlTr1fLo0jD/YtV2tlbs3RWo+sMuPYdnDCmPkwXk6d07J/E3Q2t8hqRj67kAZpXMAM0S9Vd05ZhRk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W2-P34e_1709806801;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0W2-P34e_1709806801)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 18:20:02 +0800
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
Subject: [PATCH v2 3/3] Documentation: add description of forceidle_task time statistics
Date: Thu,  7 Mar 2024 18:19:45 +0800
Message-Id: <20240307101945.11280-4-CruzZhao@linux.alibaba.com>
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

Add description of forceidle_task time statistics, including task
perspective and cgroup perspective. The difference from forceidle
time is that, forceidle_task time doesn't contain irq time.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst               | 3 ++-
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b82717767c61..46de2bfa9a0f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1081,9 +1081,10 @@ All time durations are in microseconds.
 	- user_usec
 	- system_usec
 
-	and the following six when the controller is enabled:
+	and the following seven when the controller is enabled:
 
 	- core_sched.force_idle_usec
+	- core_sched.force_idle_task_usec
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index 95a4920a2a9b..536931ed283a 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -227,7 +227,7 @@ with SMT enabled. There are other use cases where this feature could be used:
 
 Statictics
 ----------
-A task's forceidle statistics are exported via 1 field in procfs.
+A task's forceidle statistics are exported via 2 field in procfs.
 
 /proc/$pid/sched:
 
@@ -236,6 +236,9 @@ A task's forceidle statistics are exported via 1 field in procfs.
    siblings are forced idle, the irq time of cpux during this period will be
    accounted to this task's force idle time.
 
+ - se.statistics.core_forceidle_task_sum: The time that this task is actually
+   running on cpu whose SMT siblings are forced idle, unit: ms.
+
 This interface is read-only.
 
 A group's forceidle statistics are exported via 1 filed in cpu.stat.
@@ -247,4 +250,7 @@ cpu.stat:
    whose SMT siblings are forced idle, the irq time of cpux during this period
    will be accounted to this cgroup's force idle time.
 
+ - core_sched.force_idle_task_usec: The time that this cgroup's tasks are
+   actually running on cpu whose SMT siblings are forced idle, unit: us.
+
 This interface is read-only.
-- 
2.39.3


