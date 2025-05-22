Return-Path: <cgroups+bounces-8306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD9AC0252
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DCE4E246C
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C03FBA7;
	Thu, 22 May 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="U/B8bx8S"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149113C8EA;
	Thu, 22 May 2025 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879728; cv=none; b=k9Ep1kzQly8UKwY+XE1A0UYPUSejQc6Wg1CZe74Yzz+V/6mIqm9SlwEzW97O7IClR5MHDD+EL+MoRDf/4PR5Fe8WFv9fRzs6gNx13KYfFRKZ6+QIkOJZ7eu7SgrUGlZMxX+0bYQiYXDN6UVp2T8HJBRK6C9yGGDFNX2rYlWhfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879728; c=relaxed/simple;
	bh=MGo2TrgSAZGTFTpzSDFpvC5bIS+2JtNwvhLtjp0qW2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNaakyT4iXdmk59tHP+G/WgOU8O1xFuCK8duos4YoTnLlEjtBjtkXOYgRI7pYuL9EW55S5dXeYnjLgDy9jEMP+FPn43IBEeBCvEQbuYdrdFfrvdG1Ef0ewp8htPZi3zbWgEqXcqmXViEdOKODBWvtuk9ZmqONNR7lsFLpQ9MIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=U/B8bx8S; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747879725; x=1779415725;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WbwhPICS6LwqTgL/dS5U0nx5A28yOdYsAxPjKnNaSCg=;
  b=U/B8bx8SScSRuVXCDD6Q4G4qWT0RlG4S+89p6xs0OOQhPeiw6WXkdGLx
   +XKK8AprtMf5Z0SVwdnVKoisyswFxX7u0/WWufK8ddio11citAUG5/bTM
   M7bwvlcTVjek1MnjzPF/33qqqciOamDKdTM2rKmdoGSVwICiVnixRRJjD
   fn7htdFVniir9WIBqLjDMsWM5krJXmUuMkdsfy6zm0GTnWMYnejFZxCFn
   L2xeWfUjicOyt8UEHqJtt9Zr+JbBOPiVd8sZYLx2ABdEpeThPxZ79ymD8
   1r0RaCwAIrloAz5xm8hUrBEr797BFZ3GEwFmvb6sQHdogClhEVi4g+RVD
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:08:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; 
   d="scan'208";a="562451316"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2025 11:08:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Thu, 22 May 2025 11:08:14 +0900
Subject: [PATCH v3 3/3] cgroup, docs: cpu controller's interaction with
 various scheduling policies
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-rt-and-cpu-controller-doc-v3-3-483fc9cca591@sony.com>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=MGo2TrgSAZGTFTpzSDFpvC5bIS+2JtNwvhLtjp0qW2Q=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDL02lUuXjsg/PfQj6Q/J+9qFta4bw6+zLM7feWK6nViA
 vebiprDO0pZGMS4GGTFFFneyay7cNDKsunrcYZvMHNYmUCGMHBxCsBEZIQY/vDnRrj/eltRvoAj
 4tfThfcXqqf9sO5adTU9z1WKY7L+wV8M/4MO+nPM8Za9zNG1vM1eZzpHwM67e3S+CXzzKMg7YrD
 +Ah8A
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

The cpu controller interface files account for or affect processes
differently based on their scheduling policy, and the underlying
scheduler used (fair-class vs. BPF scheduler). Document these
differences

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 226fc7f9212eafcbf83c81f5b08391f215c1d894..f6dc95608d239d586b482154c4367baaf5614fb6 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1095,19 +1095,34 @@ realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
 CPU Interface Files
 ~~~~~~~~~~~~~~~~~~~
 
-All time durations are in microseconds.
+The interaction of a process with the cpu controller depends on its scheduling
+policy and the underlying scheduler. From the point of view of the cpu controller,
+processes can be categorized as follows:
+
+* Processes under the fair-class scheduler
+* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
+* Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
+  without the ``cgroup_set_weight`` callback
+
+For details on when a process is under the fair-class scheduler or a BPF scheduler,
+check out :ref:`Documentation/scheduler/sched-ext.rst <sched-ext>`.
+
+For each of the following interface files, the above categories
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
@@ -1125,6 +1140,10 @@ All time durations are in microseconds.
 	If the cgroup has been configured to be SCHED_IDLE (cpu.idle = 1),
 	then the weight will show as a 0.
 
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_weight`` callback depending on what the
+	callback actually does.
+
   cpu.weight.nice
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
@@ -1137,6 +1156,10 @@ All time durations are in microseconds.
 	granularity is coarser for the nice values, the read value is
 	the closest approximation of the current weight.
 
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_weight`` callback depending on what the
+	callback actually does.
+
   cpu.max
 	A read-write two value file which exists on non-root cgroups.
 	The default is "max 100000".
@@ -1149,18 +1172,24 @@ All time durations are in microseconds.
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
 
 	Shows pressure stall information for CPU. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+	This file accounts for all the processes in the cgroup.
+
   cpu.uclamp.min
 	A read-write single value file which exists on non-root cgroups.
 	The default is "0", i.e. no utilization boosting.
@@ -1177,6 +1206,8 @@ All time durations are in microseconds.
 	the current value for the maximum utilization (limit), i.e.
 	`cpu.uclamp.max`.
 
+	This file affects all the processes in the cgroup.
+
   cpu.uclamp.max
 	A read-write single value file which exists on non-root cgroups.
 	The default is "max". i.e. no utilization capping
@@ -1189,6 +1220,8 @@ All time durations are in microseconds.
 	value is used to clamp the task specific maximum utilization clamp,
 	including those of realtime processes.
 
+	This file affects all the processes in the cgroup.
+
   cpu.idle
 	A read-write single value file which exists on non-root cgroups.
 	The default is 0.
@@ -1199,7 +1232,7 @@ All time durations are in microseconds.
 	own relative priorities, but the cgroup itself will be treated as
 	very low priority relative to its peers.
 
-
+	This file affects only processes under the fair-class scheduler.
 
 Memory
 ------

-- 
2.43.0


