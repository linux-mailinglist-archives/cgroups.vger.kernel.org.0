Return-Path: <cgroups+bounces-8274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB11ABDBC9
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32358C7E6F
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68499248F5C;
	Tue, 20 May 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bItC7brG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F34248176;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750114; cv=none; b=Yq3oBo55wReroiKK2IFPvBfW6Rv+UJegVqpclQOFRiDMbZ49X86a7VVsRIwwkiwdj9W/DMac/2x92Jyejegib2RImRXImX81yRMu/kkm6ASJtwkGlSGJ9lcXnPqh2FuIoKN/6DW0NNRN5xBeE3mK3R4Amw2JheuzqqeTp0kGjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750114; c=relaxed/simple;
	bh=l6NyJxgbMKkiqXQMWfcr7PprX3akeyGEjA7TdV4pWGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7lFJysX8ASwpO5oYdNCDN9NXR8OreLWgKaRB12Q7vQkuilBDDkZ3nSKUknCaOqIMcBWwQ1Obloxlq3x0dLnZSAERD+khi31was+quMGRu9xvVxp89cZhm/9a/eOTQVHoZWfTnkuFUymijY7GnHy8Q2qDbCTxeEBNLFtGuA5qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bItC7brG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C32C9C4CEE9;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750113;
	bh=l6NyJxgbMKkiqXQMWfcr7PprX3akeyGEjA7TdV4pWGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bItC7brGS8ZP5VWuZFLwP7yFt0/J86kDGqKjFzNA/AAYZhibYCWgYaNjT547hQb/v
	 QJn/QHreM6xchZ2evspfrBKgLlnqNUKwr5yzHKYriPHESmoAKLcBOY9wEWCEU1w8zc
	 Z9gF2dbNCX8uQjzpNQFKnrT7aKsk42oS2bE7HfcFTAtEjMwNHVInNfttvMfRdAFdf1
	 qmW89NgYRLEX2HV8vjt9UkQmMkOY13eINdXJ7lTmMeQr6CdRgT/s9/eZNJsDrpRAei
	 TdYfjIO3L07y/STrppH3atGRBndqzDNjzpXY1CowvhA0U80kurxmvZ18KI2SIj07ZQ
	 lU3BQ48QKAEcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93AAC5479B;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Date: Tue, 20 May 2025 23:07:47 +0900
Subject: [PATCH v2 3/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-rt-and-cpu-controller-doc-v2-3-70a2b6a1b703@sony.com>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7702;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=MmQ9GGMqJKCPP6MCEAtfk55g9AJEIdzdq8BB1ZmAe8w=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJ0eh7ENrL9PsGcxHRim8rHPVJBFawlZuq3ff/O8m2o5
 pEIYJLsKGVhEONikBVTZHkns+7CQSvLpq/HGb7BzGFlAhnCwMUpABNhaGFkWL5Nq7J37ecczdBu
 DsM5Cg9Nr58xf7o0y2yT32y9Rv7KrQz/K7a2Bu84/iZ9pbN/4M5svZYZD38lf0hx2RAydRLD7Kv
 +bAA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

From: Shashank Balaji <shashank.mahadasyam@sony.com>

The cpu controller interface files account for or affect processes
differently based on their scheduling policy, and the underlying
scheduler used (fair-class vs. BPF scheduler). Document these
differences

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 98 +++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3b3685736fe9b12e96a273248dfb4a8c62a4b698..0f79bf42a3e3b2fcbe6409f9e182ba9de1fbb79c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1095,19 +1095,50 @@ realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
 CPU Interface Files
 ~~~~~~~~~~~~~~~~~~~
 
-All time durations are in microseconds.
+The interaction of a process with the cpu controller depends on its scheduling
+policy. We have the following scheduling policies: ``SCHED_IDLE``, ``SCHED_BATCH``,
+``SCHED_OTHER``, ``SCHED_EXT`` (if ``CONFIG_SCHED_CLASS_EXT`` is enabled), ``SCHED_FIFO``,
+``SCHED_RR``, and ``SCHED_DEADLINE``. ``SCHED_{IDLE,BATCH,OTHER,EXT}`` can be scheduled
+either by the fair-class scheduler or by a BPF scheduler::
+
+    CONFIG_SCHED_CLASS_EXT
+    ├─ Disabled
+    |   └─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
+    └─ Enabled
+        ├─ BPF scheduler disabled
+        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> fair-class scheduler
+        ├─ BPF scheduler without SCX_OPS_SWITCH_PARTIAL enabled
+        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> BPF scheduler
+        └─ BPF scheduler with SCX_OPS_SWITCH_PARTIAL enabled
+            ├─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
+            └─ SCHED_EXT -> BPF scheduler
+
+For more details on ``SCHED_EXT``, check out :ref:`Documentation/scheduler/sched-ext.rst. <sched-ext>`
+From the point of view of the cpu controller, processes can be categorized as
+follows:
+
+* Processes under the fair-class scheduler
+* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
+* Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
+  without the ``cgroup_set_weight`` callback
+
+Note that the ``cgroup_*`` family of callbacks require ``CONFIG_EXT_GROUP_SCHED``
+to be enabled. For each of the following interface files, the above categories
+will be referred to. All time durations are in microseconds.
 
   cpu.stat
 	A read-only flat-keyed file.
 	This file exists whether the controller is enabled or not.
 
-	It always reports the following three stats:
+	It always reports the following three stats, which account for all the
+	processes in the cgroup:
 
 	- usage_usec
 	- user_usec
 	- system_usec
 
-	and the following five when the controller is enabled:
+	and the following five when the controller is enabled, which account for
+	only the processes under the fair-class scheduler:
 
 	- nr_periods
 	- nr_throttled
@@ -1125,6 +1156,10 @@ All time durations are in microseconds.
 	If the cgroup has been configured to be SCHED_IDLE (cpu.idle = 1),
 	then the weight will show as a 0.
 
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_weight`` callback depending on what the
+	callback actually does.
+
   cpu.weight.nice
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
@@ -1137,6 +1172,10 @@ All time durations are in microseconds.
 	granularity is coarser for the nice values, the read value is
 	the closest approximation of the current weight.
 
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_weight`` callback depending on what the
+	callback actually does.
+
   cpu.max
 	A read-write two value file which exists on non-root cgroups.
 	The default is "max 100000".
@@ -1149,43 +1188,56 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
+	This file affects only processes under the fair-class scheduler.
+
   cpu.max.burst
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
 
 	The burst in the range [0, $MAX].
 
+	This file affects only processes under the fair-class scheduler.
+
   cpu.pressure
 	A read-write nested-keyed file.
 
-	Shows pressure stall information for CPU. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Shows pressure stall information for CPU, including the contribution of
+	realtime processes. See :ref:`Documentation/accounting/psi.rst <psi>`
+	for details.
+
+	This file accounts for all the processes in the cgroup.
 
   cpu.uclamp.min
-        A read-write single value file which exists on non-root cgroups.
-        The default is "0", i.e. no utilization boosting.
+	A read-write single value file which exists on non-root cgroups.
+	The default is "0", i.e. no utilization boosting.
 
-        The requested minimum utilization (protection) as a percentage
-        rational number, e.g. 12.34 for 12.34%.
+	The requested minimum utilization (protection) as a percentage
+	rational number, e.g. 12.34 for 12.34%.
 
-        This interface allows reading and setting minimum utilization clamp
-        values similar to the sched_setattr(2). This minimum utilization
-        value is used to clamp the task specific minimum utilization clamp.
+	This interface allows reading and setting minimum utilization clamp
+	values similar to the sched_setattr(2). This minimum utilization
+	value is used to clamp the task specific minimum utilization clamp,
+	including those of realtime processes.
 
-        The requested minimum utilization (protection) is always capped by
-        the current value for the maximum utilization (limit), i.e.
-        `cpu.uclamp.max`.
+	The requested minimum utilization (protection) is always capped by
+	the current value for the maximum utilization (limit), i.e.
+	`cpu.uclamp.max`.
+
+	This file affects all the processes in the cgroup.
 
   cpu.uclamp.max
-        A read-write single value file which exists on non-root cgroups.
-        The default is "max". i.e. no utilization capping
+	A read-write single value file which exists on non-root cgroups.
+	The default is "max". i.e. no utilization capping
 
-        The requested maximum utilization (limit) as a percentage rational
-        number, e.g. 98.76 for 98.76%.
+	The requested maximum utilization (limit) as a percentage rational
+	number, e.g. 98.76 for 98.76%.
 
-        This interface allows reading and setting maximum utilization clamp
-        values similar to the sched_setattr(2). This maximum utilization
-        value is used to clamp the task specific maximum utilization clamp.
+	This interface allows reading and setting maximum utilization clamp
+	values similar to the sched_setattr(2). This maximum utilization
+	value is used to clamp the task specific maximum utilization clamp,
+	including those of realtime processes.
+
+	This file affects all the processes in the cgroup.
 
   cpu.idle
 	A read-write single value file which exists on non-root cgroups.
@@ -1197,7 +1249,7 @@ All time durations are in microseconds.
 	own relative priorities, but the cgroup itself will be treated as
 	very low priority relative to its peers.
 
-
+	This file affects only processes under the fair-class scheduler.
 
 Memory
 ------

-- 
2.43.0



