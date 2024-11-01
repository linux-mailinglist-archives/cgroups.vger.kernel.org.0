Return-Path: <cgroups+bounces-5387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C419B999D
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DB51F220C5
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF91E0DE9;
	Fri,  1 Nov 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DopupVo9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E9168DA;
	Fri,  1 Nov 2024 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493846; cv=none; b=qGK3CV8eOu9H8/svmdxLdLoa7ik+goP669DSPVcPNHHUFbSvUjVlQ1akCaSVoM1AwMKPMjr+9YbzTMFKQ8zXB+II5IHK+ZfAyvMqyPswZfYBSmuvEc/Lngiq/AA8AQ4Je1KtdLq1YkaL5fDES64/qXtC+GaU0nWnSdcVR9qSzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493846; c=relaxed/simple;
	bh=kZgWT+E+imGucwM5FYY+x2OMrD6FaStxjjPGQVYzOuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFgpO165XEjRddiericuEuSqR70to3OL6X9kpU5mSeGTcZJNOeua5Qg7anpmrK5l4qP+LicyT9nexmsa6Ix4qZzNr9V8V4lFTv+GBVj7CjwXSkiTjdwjYp5IMaO5COGVsFT4WIBNzstSy+ibl0pVF168Y1jtFiTLP5Q9i60vzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DopupVo9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so2175747276.0;
        Fri, 01 Nov 2024 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730493844; x=1731098644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCM+fKsGzk5AZDxT4A2dewBEVdVNNm2ySi8AOsEK/l0=;
        b=DopupVo9r7dS5G16picQQmYfaWbV7cnYFKXGhlVOCgsGcrQy4YhX1+lnZeb0mZEMV8
         6ZZFxTj9VJqLUC6JEeeOTmgGwBpXe/SWZ6EjXO5EMlJvgBgFQbZp/korgWGM71wn3FMr
         kH52ekqIelY4BkNHmKY7sZAiGA4zKZ+jFkX1n4WLq7TZA21nIMQMPz47Z9yhZkQvYyDK
         UNnBPD7I9UoVkvMLJvhe3rr2mdlQ1zyPHKQhhHXF4cRgR6HFBwyCg63a7GubU/PXlTBp
         ptflkiFG7gNtwhSGX3Itz/aHrHEOkx03m+6YFUyqiJd2bi5HlaEDXntzoaFXNbJbt/D1
         mDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493844; x=1731098644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCM+fKsGzk5AZDxT4A2dewBEVdVNNm2ySi8AOsEK/l0=;
        b=sVLzmhiteHg5KjAwBUZ5I2/s684K+fFGqc9CRMV53s8xTAAbjbbKTQpA3UiQFxUQTK
         +3Tjaa7DV1C7DV+fAy6ghLRryCCyLzNC2fbj5jvfIOqUgLYwiahs2YlnvA6V39VITNEK
         UIBJADYbjBcRtVio8UOYZXyaOIukZZVbrBNKk2J0PGtv5hnE1LiblHOPNBqLUZW4Txjg
         cqmGmwlnw22sv6L9oldIMSPfkOjyPz1AaWNBYB4BE7nAdnIuvYBhP9CCtXx0ce9LUcDK
         IWzfJ6GA4jA8zp0J4BcLUaGP0PWtKgKII2g0ey1odvWQGDCJw2+/1hytQRVcTkRMHGif
         SOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUi2VDf8aK2XXnDdqUcVSA9Y7Ug6VrbNXIxpvhc8pvoFrf80kRur0zhFTAIwb+mqZFSWlwt9xFW/2Ib@vger.kernel.org, AJvYcCUztViepbTMkDiTqd/OZ0DMiqS2YWNdMvZ9Ez57OFlJo7jsCFj+3KeraszfQMAt0aJ78XsegQlgN2jBl3IZ@vger.kernel.org, AJvYcCWRJ6vAxG5TsVPg1UMow129caJ/cjGAzSrbyvxWE3mIPT8WKP7YAx9N6bCjsVtZHtCtxHmeN7N1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LWG0OHtfJ62BtVb4ao/ejl1GLMgVN7iEDpZTG80gvx1eQsS2
	XYfb99+D+HnK/S3FmTVFZzGIbLxTGHLWVZUdgPsxpLPYXpvzhr3m
X-Google-Smtp-Source: AGHT+IEkuzO5zxQKkn/65x1uoWoqfWH/QbZaag/6vrSeC1yuyVpynp5j/emFlwaPWuvpnu0ognHsMA==
X-Received: by 2002:a05:6902:b0e:b0:e30:cbde:1252 with SMTP id 3f1490d57ef6-e330266ec61mr3601095276.36.1730493843734;
        Fri, 01 Nov 2024 13:44:03 -0700 (PDT)
Received: from localhost (fwdproxy-frc-022.fbsv.net. [2a03:2880:21ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a61797sm871280276.12.2024.11.01.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:44:03 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: nphamcs@gmail.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	chris@chrisdown.name,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	corbet@lwn.net,
	lnyng@meta.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
Date: Fri,  1 Nov 2024 13:44:02 -0700
Message-ID: <20241101204402.1885383-1-joshua.hahnjy@gmail.com>
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

3. Implementation Details:
In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
regardless of whether memcg accounts hugetlb. mem_cgroup_commit_charge
which is called from alloc_hugetlb_folio will set memcg for the folio
only if the CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING cgroup mount option is
used, so lruvec_stat_mod_folio accounts per-memcg hugetlb counters
only if the feature is enabled. Regardless of whether memcg accounts
for hugetlb, the newly added global counter is updated and shown
in /proc/vmstat.

The global counter is added because vmstats is the preferred framework
for cgroup stats. It makes stat items consistent between global and
cgroups. It also provides a per-node breakdown, which is useful.
Because it does not use cgroup-specific hooks, we also keep generic
MM code separate from memcg code.

[1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
[2] Of course, we can't make a new patch for every feature that can be
    duplicated. However, since the existing solution of enabling the
    hugeTLB controller is an imperfect solution that still leaves a
    discrepancy between memory.stat and memory.curent, I think that it
    is reasonable to isolate the feature in this case.
 
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
Changelog
v4:
  * Added {acked,suggested,reviewed}-by to the list
  * Added an extra section detailing why having no checks for mount
    options or configs is ok (handled by lruvec_stat_mod_folio). Also
    includes justifications for adding a global counter
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


