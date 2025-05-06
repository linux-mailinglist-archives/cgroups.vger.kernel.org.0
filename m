Return-Path: <cgroups+bounces-8050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76368AAD18A
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874453BDFFD
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE021CC5F;
	Tue,  6 May 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFr4u0Pr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99922B9BC
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574162; cv=none; b=cAF5/EOeBfQtXj9RxGQ4znr9ikLA6Jm+0bX4g+a03zAuomG4ApIZUQx5InNZ2/taNNrn9VuB/aT5hEC198wmayeVFx7e+3xZmqpFTGD0J3UUt4fScJmv0wiRKKCIxz9I5tG/iFJ2DQ1f2BZR8W8gGidmJ9vzTtMXcMDuMM55TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574162; c=relaxed/simple;
	bh=xY6YYe2GYoKVZw+f9s8dfafobXkPx9NB/Hd/IiGn3IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dI8m4FB1eOCLoDvqJHnjNTV21DNZG3z0UXviPyyMlga2HQelNENVzHN4XnvG9fVDNxQxa5MgLfTZZqNC4l0/AkIRd4AGsKIk9fk/Oj8Z3xE8X/ZGy+cHBgW13q/xi4p1tBCkO0WOcfn6x9F/RBkfKFEpZjbm4ylTy13DdGypciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFr4u0Pr; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746574148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eB/pxS466hu2BDocFMJ63R81TtZQoooOTz+zlJGkYJE=;
	b=gFr4u0Pr7scrdoo7r+h+fr2G8JwoY+yMH2twxlnwYXea89RBtI7Vc1z8B7yCX1PxqC3X7O
	a+H+rDOyJhHpdGBvs5Oxh2lK7CN1IlZqLQO14Z99pWtpwsiavQ27hu2SB5dqM1pSoaz7id
	1zetIEpIl0TvAYuSQqUfeRmxzPSK1zc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Greg Thelen <gthelen@google.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3] memcg: introduce non-blocking limit setting option
Date: Tue,  6 May 2025 16:28:33 -0700
Message-ID: <20250506232833.3109790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Setting the max and high limits can trigger synchronous reclaim and/or
oom-kill if the usage is higher than the given limit.  This behavior is
fine for newly created cgroups but it can cause issues for the node
controller while setting limits for existing cgroups.

In our production multi-tenant and overcommitted environment, we are
seeing priority inversion when the node controller dynamically adjusts the
limits of running jobs of different priorities.  Based on the system
situation, the node controller may reduce the limits of lower priority
jobs and increase the limits of higher priority jobs.  However we are
seeing node controller getting stuck for long period of time while
reclaiming from lower priority jobs while setting their limits and also
spends a lot of its own CPU.

One of the workaround we are trying is to fork a new process which sets
the limit of the lower priority job along with setting an alarm to get
itself killed if it get stuck in the reclaim for lower priority job.
However we are finding it very unreliable and costly.  Either we need a
good enough time buffer for the alarm to be delivered after setting limit
and potentialy spend a lot of CPU in the reclaim or be unreliable in
setting the limit for much shorter but cheaper (less reclaim) alarms.

Let's introduce new limit setting option which does not trigger reclaim
and/or oom-kill and let the processes in the target cgroup to trigger
reclaim and/or throttling and/or oom-kill in their next charge request.
This will make the node controller on multi-tenant overcommitted
environment much more reliable.

Explanation from Johannes on side-effects of O_NONBLOCK limit change:
  It's usually the allocating tasks inside the group bearing the cost of
  limit enforcement and reclaim. This allows a (privileged) updater from
  outside the group to keep that cost in there - instead of having to
  help, from a context that doesn't necessarily make sense.

  I suppose the tradeoff with that - and the reason why this was doing
  sync reclaim in the first place - is that, if the group is idle and
  not trying to allocate more, it can take indefinitely for the new
  limit to actually be met.

  It should be okay in most scenarios in practice. As the capacity is
  reallocated from group A to B, B will exert pressure on A once it
  tries to claim it and thereby shrink it down. If A is idle, that
  shouldn't be hard. If A is running, it's likely to fault/allocate
  soon-ish and then join the effort.

  It does leave a (malicious) corner case where A is just busy-hitting
  its memory to interfere with the clawback. This is comparable to
  reclaiming memory.low overage from the outside, though, which is an
  acceptable risk. Users of O_NONBLOCK just need to be aware.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v2:
- Added more explanation in doc and commit message on O_NONBLOCK
  side-effects (Johannes)

Changes since v1:
- Instead of new interfaces use O_NONBLOCK flag (Greg, Roman & Tejun)

 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++++++++++++++++++
 mm/memcontrol.c                         | 10 ++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a497db5e6496..b3e0fdc00614 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1299,6 +1299,18 @@ PAGE_SIZE multiple when read back.
 	monitors the limited cgroup to alleviate heavy reclaim
 	pressure.
 
+	If memory.high is opened with O_NONBLOCK then the synchronous
+	reclaim is bypassed. This is useful for admin processes that
+	need to dynamically adjust the job's memory limits without
+	expending their own CPU resources on memory reclamation. The
+	job will trigger the reclaim and/or get throttled on its
+	next charge request.
+
+	Please note that with O_NONBLOCK, there is a chance that the
+	target memory cgroup may take indefinite amount of time to
+	reduce usage below the limit due to delayed charge request or
+	busy-hitting its memory to slow down reclaim.
+
   memory.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
@@ -1316,6 +1328,18 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+	If memory.max is opened with O_NONBLOCK, then the synchronous
+	reclaim and oom-kill are bypassed. This is useful for admin
+	processes that need to dynamically adjust the job's memory limits
+	without expending their own CPU resources on memory reclamation.
+	The job will trigger the reclaim and/or oom-kill on its next
+	charge request.
+
+	Please note that with O_NONBLOCK, there is a chance that the
+	target memory cgroup may take indefinite amount of time to
+	reduce usage below the limit due to delayed charge request or
+	busy-hitting its memory to slow down reclaim.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29860f067952..f8b9c7aa6771 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4328,6 +4328,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	page_counter_set_high(&memcg->memory, high);
 
+	if (of->file->f_flags & O_NONBLOCK)
+		goto out;
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 		unsigned long reclaimed;
@@ -4350,7 +4353,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		if (!reclaimed && !nr_retries--)
 			break;
 	}
-
+out:
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
@@ -4377,6 +4380,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 	xchg(&memcg->memory.max, max);
 
+	if (of->file->f_flags & O_NONBLOCK)
+		goto out;
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 
@@ -4404,7 +4410,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 			break;
 		cond_resched();
 	}
-
+out:
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
-- 
2.47.1


