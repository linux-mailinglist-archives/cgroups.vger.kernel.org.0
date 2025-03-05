Return-Path: <cgroups+bounces-6834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7FA4F5FB
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 05:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6477716E362
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BD1A5B87;
	Wed,  5 Mar 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COvuuk+S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429921A23AF;
	Wed,  5 Mar 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147989; cv=none; b=g2kIwV+Q5pyHqJl+0bB8WdcCKF8/YqmC07oxTv7UsyTW0g1xEX3/FlvCgu/aM6fkLUHfAwnhnR+bVd5ZwcECMifFC4IxXX5ctmk1HiLlkS1pyez3V5TQGYaCTKVbUVjIUE5HJuJZGlzQesARWHTCV+/QNN/u59X2bHl3mtzpFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147989; c=relaxed/simple;
	bh=RBsh/xDj4vd4BAKgWWaorA7r/mUYNpFPasyRXkkSQEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WiLyGbHa49sOqM6SjM6KTglClI3u6mChQzKdbrZbbYCs90O3nDmtWGBypkN5U5IISAQbsXYFlxkV74Fo+fshvU5ELMk/8G7mf8WRPzcoEoGO/JmDew4utj2BUTe35IFQddRTAzXghhOnmXbYmBtyw4lRWWOgjBMzbgaMyKO9N8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COvuuk+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C129FC4CEEB;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741147988;
	bh=RBsh/xDj4vd4BAKgWWaorA7r/mUYNpFPasyRXkkSQEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=COvuuk+ShgIppQ6Ihy1TUO9D39jQ3ibKNx+bE9FsBoqL980OPhD1D1WTp3pmi4+OZ
	 3FuFgn7nTTPBiboTaxvRR23TZN5tCxba+H5EGb+CtdO3SiiA5adNfoFFnFX2Xf1EyR
	 JNaLAXP18n3FYPxNj+ozt3hXUKvvPMplWITGYT6qTsQnYu86C0uc+VL2BmReakb4RM
	 F52IkM3dJcpyl354lM5nf/I3muacTjwaXRFJkpt8eLmcOWYAik7cbvdsz7i++6lWPg
	 fn2uId5LhUaMmXQPZjJ1YVcCKdPj2/XufF7Gk5VVdIpFegZC0JQC24XHzdJC882hh6
	 wDXEY0Y+RdvFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC62C282DE;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Date: Wed, 05 Mar 2025 13:12:44 +0900
Subject: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=C7JgnbF46KXkV/sLIdJxl+OtmX2NjXxlaJ2fLtetvIs=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGNKPnw9e//2RmAhj3o5Du+SOLT0Xfi9vQYeCx84HZxYwC
 vzvemXwu6OUhUGMi0FWTJHlncy6CwetLJu+Hmf4BjOHlQlkCAMXpwBMxG8VI0NzIlvCn5hrrx4x
 iPRL7MhbL7J4AZ+BcWTx1e7fikX8J2Yz/A9+WhAhdXtX9QvT+uPMHMKiUusO/G6y/eXmc2Ptv5X
 Xv7EDAA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

From: Shashank Balaji <shashank.mahadasyam@sony.com>

If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED
disabled setting, cpu.stat and cpu.pressure account for realtime
processes, and cpu.uclamp.{min, max} affect realtime processes as well.
None of the other interface files are affected by or affect realtime
processes.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f293a13b42ed69e7c6bf5e974cb86e228411af4e..2c267f42e5fef9c4e2c3530ce73330d680b9b2dc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1095,7 +1095,9 @@ realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
 CPU Interface Files
 ~~~~~~~~~~~~~~~~~~~
 
-All time durations are in microseconds.
+All time durations are in microseconds. Only cpu.stat and cpu.pressure account
+for realtime processes, and only cpu.uclamp.min and cpu.uclamp.max
+affect realtime processes.
 
   cpu.stat
 	A read-only flat-keyed file.
@@ -1115,6 +1117,9 @@ All time durations are in microseconds.
 	- nr_bursts
 	- burst_usec
 
+    The runtime of realtime processes is accounted for only by the usage_usec,
+	user_usec, and system_usec fields.
+
   cpu.weight
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "100".
@@ -1158,8 +1163,9 @@ All time durations are in microseconds.
   cpu.pressure
 	A read-write nested-keyed file.
 
-	Shows pressure stall information for CPU. See
-	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+	Shows pressure stall information for CPU, including the contribution of
+	realtime processes. See :ref:`Documentation/accounting/psi.rst <psi>`
+	for details.
 
   cpu.uclamp.min
         A read-write single value file which exists on non-root cgroups.
@@ -1170,7 +1176,8 @@ All time durations are in microseconds.
 
         This interface allows reading and setting minimum utilization clamp
         values similar to the sched_setattr(2). This minimum utilization
-        value is used to clamp the task specific minimum utilization clamp.
+        value is used to clamp the task specific minimum utilization clamp,
+        including those of realtime processes.
 
         The requested minimum utilization (protection) is always capped by
         the current value for the maximum utilization (limit), i.e.
@@ -1185,7 +1192,8 @@ All time durations are in microseconds.
 
         This interface allows reading and setting maximum utilization clamp
         values similar to the sched_setattr(2). This maximum utilization
-        value is used to clamp the task specific maximum utilization clamp.
+        value is used to clamp the task specific maximum utilization clamp,
+        including those of realtime processes.
 
   cpu.idle
 	A read-write single value file which exists on non-root cgroups.

-- 
2.43.0



