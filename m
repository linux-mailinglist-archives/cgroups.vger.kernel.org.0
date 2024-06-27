Return-Path: <cgroups+bounces-3426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73F91B168
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26721283868
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384B1A072B;
	Thu, 27 Jun 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkyRYQwe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA71A0714;
	Thu, 27 Jun 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523122; cv=none; b=TUYWCM+qctlYidjXF2KMUxKHBA2/tJYltRsL1EyJqUXhiz4IWJtSHe1XnRv9apGPUH2mlojIChHDaByKbjD6RzvMFBt+w31XciwompUN30CjYihI5kfY5YNLy+LbTuyZdgyio4XGpimkWVHjZkAwmR5umlD4T1aAKJ82M7LZ458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523122; c=relaxed/simple;
	bh=REm3K5MgPmRQpONdIW7zODAdzetyL88KjbhiskxYUbE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=dpphlWMbEmVBntP9JC2hkwSjBqZQnCOVG7gdvx3m4UL0LBNPuXxUXGrgP/Tbd/9RJmXw1pnUdRtMB3QgIq/8maY+cT568nWHvBOMovzGsOIpF7Tu8yz+KoeJqDpGbIYzBH1c0Fg9Y6wIz+gJMoulzJWMPfuRtC+IqbpNDlne/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkyRYQwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C82EC2BBFC;
	Thu, 27 Jun 2024 21:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719523121;
	bh=REm3K5MgPmRQpONdIW7zODAdzetyL88KjbhiskxYUbE=;
	h=Subject:From:To:Cc:Date:From;
	b=pkyRYQweScIoKsig8Cx8MbjTacXVSRPGcIEGoeD3unqvHPRg/t60L1fhyf9i23RUa
	 728VwKM2V4BVQaeT4grDh9MuO+z/bkex68PhC7wocdyfeUIitbBr/i0trodAKM7XBb
	 i021/EsBdOGXLGlO6elkx8EbmOg3951IHGWPSEMplKmfAEdqSLt/YRhfoEf5jdFIim
	 NcmviQ7QCsRyLW78MKkfGZoXPRZrAgUFa2mOLR5lVeQFspxY+g7kLDw5W9O7cPDyNr
	 1ly2VzW5LS8eFEMjlgKUV4N7wmwPAouFuXEZIz7riBNAaHzkbinkRFhXw8MQU347x2
	 f/OegnvAdIVLg==
Subject: [PATCH V4 1/2] cgroup/rstat: Helper functions for locking expose
 trylock
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 23:18:37 +0200
Message-ID: <171952310959.1810550.17003659816794335660.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/cgroup/rstat.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..2a42be3a9bb3 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -279,17 +279,30 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
+{
+	bool locked;
+
+	locked = spin_trylock_irq(&cgroup_rstat_lock);
+	if (!locked)
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, !locked);
+
+	return locked;
+}
+
+static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
+				       bool check_contention)
 	__acquires(&cgroup_rstat_lock)
 {
-	bool contended;
+	bool locked = false;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
-	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
+	if (check_contention)
+		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
+
+	if (!locked)
 		spin_lock_irq(&cgroup_rstat_lock);
-	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+
+	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, !locked);
 }
 
 static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
@@ -328,7 +341,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(cgrp, cpu, true);
 		}
 	}
 }
@@ -348,9 +361,16 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
+	bool locked;
+
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
+	locked = __cgroup_rstat_trylock(cgrp, -1);
+	if (!locked) {
+		/* Opportunity to ongoing flush detection */
+		__cgroup_rstat_lock(cgrp, -1, false);
+	}
+
 	cgroup_rstat_flush_locked(cgrp);
 	__cgroup_rstat_unlock(cgrp, -1);
 }
@@ -368,7 +388,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
+	__cgroup_rstat_lock(cgrp, -1, true);
 	cgroup_rstat_flush_locked(cgrp);
 }
 



