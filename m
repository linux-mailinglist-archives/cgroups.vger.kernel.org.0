Return-Path: <cgroups+bounces-4262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B8952363
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39E61F253FC
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D641C462A;
	Wed, 14 Aug 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZtHF/+X"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAED1C3F31
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667338; cv=none; b=NyocV68EqQ5iltYDRWfWFh8H+FsZsJDpCdNooDPHr2Z24rgIfnjhoVBDyl+2ZgsG8EHRXTwQ+a2F7JlVOKF9n5WLAo/A1JNTzL64YFQz8zrTefDL/lRqjaxoQeAk0gLkf15XW94QocrJXUv968hrZOcRys2Si3DJ5cnOyxEsTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667338; c=relaxed/simple;
	bh=rpAXRvqtwxU1XWUvQl/r9yjpM9n3xJzv6pB0r0+Kbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs3IQsNns2IoJEmPiY6Yyx+r7It8pfhnpkPyWTWdSRvkpwjf2IUGTJRRaKjPz2ibJidAZtbk00QAjO/J7T1i9ZRurGHKth+/+j/sC2+5wWtHDr9IgRtjOnfN3RyK2O8RfJfxJH09fr6fJC7yQxV50mAv2Yr1M6ZJvSV6lv6aVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZtHF/+X; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pUIHp5n0Uar92kH9etH8g4haQHVbq2z8GQwWBMKVbI=;
	b=mZtHF/+X+qPTZcKMFtclAXikUnNlfUnwTEG4tmMmgOnlawA/B7BHf93jTy2dB5PmVWzF+K
	83+QCsTr39iKyFqluczw4EnCKNFyRrQSJyD9+RRQwFrUxEWYBb5TLwf3MV28ldF0WzTUtH
	Y0QfkRW+ayHV894fjUUljDs+3fwec5w=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 2/4] memcg: initiate deprecation of v1 soft limit
Date: Wed, 14 Aug 2024 13:28:23 -0700
Message-ID: <20240814202825.2694077-3-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-1-shakeel.butt@linux.dev>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg v1 provides soft limit functionality for the best effort memory
sharing between multiple workloads on a system. It is usually triggered
through kswapd and at the moment does not reclaim kernel memory.

Memcg v2 provide more straightforward best effort (memory.low) and hard
protection (memory.min) functionalities. Let's initiate the deprecation
of soft limit from v1 and gather if v2 needs something more to move the
existing v1 users to v2 regarding soft limit.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index fb6d3e2a6395..afe5e95e9f7b 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -78,6 +78,8 @@ Brief summary of control files.
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
 				     This knob is not available on CONFIG_PREEMPT_RT systems.
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't be
@@ -701,8 +703,10 @@ For compatibility reasons writing 1 to memory.use_hierarchy will always pass::
 
 	# echo 1 > memory.use_hierarchy
 
-7. Soft limits
-==============
+7. Soft limits (DEPRECATED)
+===========================
+
+THIS IS DEPRECATED!
 
 Soft limits allow for greater sharing of memory. The idea behind soft limits
 is to allow control groups to use as much of the memory as needed, provided
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b8e2ee454eaa..e0bb54e42011 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2458,6 +2458,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			ret = -EOPNOTSUPP;
 		} else {
+			pr_warn_once("soft_limit_in_bytes is deprecated and will be removed. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
 			WRITE_ONCE(memcg->soft_limit, nr_pages);
 			ret = 0;
 		}
-- 
2.43.5


