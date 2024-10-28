Return-Path: <cgroups+bounces-5299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CA9B3C73
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E153B21A26
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C11E0E0D;
	Mon, 28 Oct 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auQDsa9M"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEF18FC75;
	Mon, 28 Oct 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149509; cv=none; b=uMWtCwT6/ThqSUtRmaEY71+M9eMxWpz8VHFPir/zjSMjG68afCyMt7IANQSqC0u0JO76Y4LcDZ9ueiGy93swtUvDSQvH10rIP89RYn0Sjr9NxJDTN8PTGl7CGrYXWxA5t9ynYjOhcXISG9icsKRZmyXlH3AitgoHDjiAJhUvoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149509; c=relaxed/simple;
	bh=/eqOJMR5/kRv1PZUjhCMyPYy8GBp0CAd6+vdfLRQbdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gkz1kV8NsMaJvfL14ryPE/WajsY/caB1/WnagiiT1D7tb6sFt0i0iTNnivSu3gc4FBkGxfpSGsGbGrWVYQyOIC0x2Ob6MFq2m5129THHADSzKcG+UoIabHi0136XMhKk4GKHZ5BSIXFE4pC4Cd9BATdXmfrpwzceX6hdKj9DL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auQDsa9M; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea051d04caso12213177b3.0;
        Mon, 28 Oct 2024 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730149506; x=1730754306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLEBUO3zgTSFGN59d665N/08QPwfc0hewb2QT9/bCXo=;
        b=auQDsa9MSurdqhXqznEynN05nQULs+sEUrDUJtpCKqMJcAyDCYdAghDJI36+VRjffh
         iRhvJfuaUjpeELxtMxY+S1o0gIp9ya5zxCGvMiCmdb+9fKDg3hYRcLo+Xn5FS4dM599P
         M6YIG+sMnIgDwiDm4C3ci/r18EoaPs/pN664w3OcKrWrOhLWS1hpeTsWJAy2Vw8Rjczz
         X7ycBRcs9akzzS6CgpobV54lCblm+xy9C8CWBWNTJa+gwD/1DeUFTqpP6YCMXCQBwK5j
         ugzmOSaUT2IwHeLDAdeBWzKUs0UlvezccU+CZyisHywOWB44PqlZWWBBJn/04UEks5yz
         wooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149506; x=1730754306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLEBUO3zgTSFGN59d665N/08QPwfc0hewb2QT9/bCXo=;
        b=uBVRJmsnYw+wl6S3rCR9Z0LBxqPIOoRi3lJhfL9BNGrY82oW4bNfNdmNslyxLS7n29
         JkF+QRWaRlVqIkegij8KOmRmrGvKwXjriT7lvCAbBYtRYeAL1rnJwWCJ2yrKDuGuHJDW
         T61yoIQ3vYegh4OiRXTTH+9YzFQWqSWsG4ZQI99haaZ1WzMBWchLHtBNstQe005Akq5C
         P5I2RcUUw3wkeeEotizbC3AFRK+rg7jou0i4A2Hx8bDbVmrEQCnR2VqrDG9A9fPvxwo1
         rKkTZ1HK2Il5HeZ0utjTz4Eg0/2IlgUGff+D3xGZppoc9u7nwzEXnIA6VzD0nBLYp5S0
         sjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTwQjDCeUc5+/q0jqqqGHrS5T5U+UBAcnkLWyYD62h25ex4NpwTEWvjocXFnI7mdZWqKBEyXQNKt6CFi0n@vger.kernel.org, AJvYcCV33y/D5GMiilnqJ7IFB8o100Pe03BEj9wO1s7+diM42+d988SpxdKnYa4FarZMX3J/5gyrrIQmchnQ@vger.kernel.org, AJvYcCWlOYOKC3CnCQXn7qpyFZehC/SNtZrBsKnLKM0jjrFBZPfCdeYKgdEY8hjIqoOWNBsdYX7NLpew@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52Bw98U5zEF9e18SujQolLmO+/tbaZzoCfT6C54INHge2kfk8
	yiNBPcixAcshGGhLmRA8oBgNnzEwP9Qw3uSdKfIXwiDiy7Oa4N0N
X-Google-Smtp-Source: AGHT+IG+IPKm2Fw3hNr6RVtM0QZGyoPz7y6L5l00CFINrofIoAx5v5ae8AlvQ2HENfUdx2ayHL2eZA==
X-Received: by 2002:a05:690c:6085:b0:6d5:7b2f:60a0 with SMTP id 00721157ae682-6e9d8afb26dmr97249987b3.34.1730149506371;
        Mon, 28 Oct 2024 14:05:06 -0700 (PDT)
Received: from localhost (fwdproxy-frc-034.fbsv.net. [2a03:2880:21ff:22::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c76a07sm16223747b3.81.2024.10.28.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:05:06 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org
Cc: nphamcs@gmail.com,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	corbet@lwn.net,
	lnyng@meta.com,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Date: Mon, 28 Oct 2024 14:05:05 -0700
Message-ID: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new counter to memory.stat that tracks hugeTLB
usage, only if hugeTLB accounting is done to memory.current. This
feature is enabled the same way hugeTLB accounting is enabled, via
the memory_hugetlb_accounting mount flag for cgroupsv2.

1. Why is this patch necessary?
Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
hugeTLB usage to memory.current. However, the metric is not reported in
memory.stat. Given that users often interpret memory.stat as a breakdown
of the value reported in memory.current, the disparity between the two
reports can be confusing. This patch solves this problem by including
the metric in memory.stat as well, but only if it is also reported in
memory.current (it would also be confusing if the value was reported in
memory.stat, but not in memory.current)

Aside from the consistency between the two files, we also see benefits
in observability. Userspace might be interested in the hugeTLB footprint
of cgroups for many reasons. For instance, system admins might want to
verify that hugeTLB usage is distributed as expected across tasks: i.e.
memory-intensive tasks are using more hugeTLB pages than tasks that
don't consume a lot of memory, or are seen to fault frequently. Note that
this is separate from wanting to inspect the distribution for limiting
purposes (in which case, hugeTLB controller makes more sense).

2. We already have a hugeTLB controller. Why not use that?
It is true that hugeTLB tracks the exact value that we want. In fact, by
enabling the hugeTLB controller, we get all of the observability
benefits that I mentioned above, and users can check the total hugeTLB
usage, verify if it is distributed as expected, etc.

With this said, there are 2 problems:
(a) They are still not reported in memory.stat, which means the
    disparity between the memcg reports are still there.
(b) We cannot reasonably expect users to enable the hugeTLB controller
    just for the sake of hugeTLB usage reporting, especially since
    they don't have any use for hugeTLB usage enforcing [2].

[1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
[2] Of course, we can't make a new patch for every feature that can be
    duplicated. However, since the existing solution of enabling the
    hugeTLB controller is an imperfect solution that still leaves a
    discrepancy between memory.stat and memory.curent, I think that it
    is reasonable to isolate the feature in this case.
 
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
Changelog
v3:
  * Removed check for whether CGRP_ROOT_HUGETLB_ACCOUNTING is on, since
    this check is already handled by lruvec_stat_mod (and doing the
    check in hugetlb.c actually breaks the build if MEMCG is not
    enabled.
  * Because there is now only one check for the flags, I've opted to
    do all of the cleanup in a separate patch series.
  * Added hugetlb information in cgroup-v2.rst
  * Added Suggested-by: Shakeel Butt
v2:
  * Enables the feature only if memcg accounts for hugeTLB usage
  * Moves the counter from memcg_stat_item to node_stat_item
  * Expands on motivation & justification in commitlog
  * Added Suggested-by: Nhat Pham

 Documentation/admin-guide/cgroup-v2.rst |  5 +++++
 include/linux/mmzone.h                  |  3 +++
 mm/hugetlb.c                            |  2 ++
 mm/memcontrol.c                         | 11 +++++++++++
 mm/vmstat.c                             |  3 +++
 5 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69af2173555f..bd7e81c2aa2b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1646,6 +1646,11 @@ The following nested keys are defined.
 	  pgdemote_khugepaged
 		Number of pages demoted by khugepaged.
 
+	  hugetlb
+		Amount of memory used by hugetlb pages. This metric only shows
+		up if hugetlb usage is accounted for in memory.current (i.e.
+		cgroup is mounted with the memory_hugetlb_accounting option).
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..972795ae5946 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,6 +220,9 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+#ifdef CONFIG_HUGETLB_PAGE
+	NR_HUGETLB,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..fbb10e52d7ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1925,6 +1925,7 @@ void free_huge_folio(struct folio *folio)
 				     pages_per_huge_page(h), folio);
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, -pages_per_huge_page(h));
 	mem_cgroup_uncharge(folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
@@ -3093,6 +3094,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	if (!memcg_charge_ret)
 		mem_cgroup_commit_charge(folio, memcg);
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
 	mem_cgroup_put(memcg);
 
 	return folio;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845c64a2c57..5444d0e7bb64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -310,6 +310,9 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+#ifdef CONFIG_HUGETLB_PAGE
+	NR_HUGETLB,
+#endif
 };
 
 static const unsigned int memcg_stat_items[] = {
@@ -1346,6 +1349,9 @@ static const struct memory_stat memory_stats[] = {
 	{ "unevictable",		NR_UNEVICTABLE			},
 	{ "slab_reclaimable",		NR_SLAB_RECLAIMABLE_B		},
 	{ "slab_unreclaimable",		NR_SLAB_UNRECLAIMABLE_B		},
+#ifdef CONFIG_HUGETLB_PAGE
+	{ "hugetlb",			NR_HUGETLB			},
+#endif
 
 	/* The memory events */
 	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
@@ -1441,6 +1447,11 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
 
+#ifdef CONFIG_HUGETLB_PAGE
+		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
+		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+			continue;
+#endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
 		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea423e1..871566b04b79 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1273,6 +1273,9 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
+#ifdef CONFIG_HUGETLB_PAGE
+	"nr_hugetlb",
+#endif
 	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
-- 
2.43.5


