Return-Path: <cgroups+bounces-5207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1A9AD58C
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 22:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE41C22424
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477531D14E4;
	Wed, 23 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwEn4okM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A11AC448
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715677; cv=none; b=TiPwdnEYYHP95ISI7ANQmSpi2CTYHBmSIzJtUYht0D203SCy5rPRf84UWtKfGLwnGXjtcE4vKl2ehEYWIT65DLg7ya0AI+i1wkhxpaj/RjA8nlA2ZX8Ge680H8fYEsa1hn4D1HZM7BsLG2MHOxZ+g2XiS1p0GT7xDWewMUiyRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715677; c=relaxed/simple;
	bh=PTdC9CxnM9UVCmDhjyOuOn1ymfCMb2RSaLSHnTXimnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5jOdZpMn69T0PBbrpd4uF1XunHJ+sXUjBV/Ww5VPalJu6T8fH4nEdUKjx0jVDSrhh9bE+sA3eHe/BNxecAklxS4S2solyiYIan+45lWP8NyT63eYl3C2XoSNhJtcMVew75H1sayD9L1bA/bazbiuOmb1M9xHljTAStMkrEJ5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwEn4okM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2f4c1f79bso1633397b3.1
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729715674; x=1730320474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCDEmxrLlEgqQcoQ5OC1Q+/92BbOzEefcs59gFTl5nw=;
        b=lwEn4okMqEd9pSzKwXRwNoDI0nGFGxvPZnD8+Ejw/+mBR7IU4U83cpww5Gz4vmCpLG
         ZbA55JlY5WNm7pVERhnGMyrSCXez3gCtqpcOHUSiSTT/jUpZ1qLe8r1/66IDYoD5hsQj
         9n6rmhVgTJVijkOpJs/P1F6w9GPAjNOlbPMlBwmx0k4rQdGU/PilM3nutK51NRLZCYXq
         zqaR+zLLd/BrL4z4ju7KQNxAevhTqc+27Bu6cW9MmLNlr9iNa8eIl0jf/AwWO5XHrM3D
         V4Cl4fKv4SZrwgV/Zy5CGDD8Q4YnxI4jCgMbRA+P5vO5wLyp04onx1F9pma+/JxrojYF
         6kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715674; x=1730320474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCDEmxrLlEgqQcoQ5OC1Q+/92BbOzEefcs59gFTl5nw=;
        b=Z3nnFZfAXULKBB3GEqVRtSqPw2A4svS7iBGXowqD+2yzGy6BQiUylphE40/xePzfCf
         nPowh5cs23ugvta0gZKvwychdPqSNvaSke1X6QCh8Ld0Y7n/TjMVpQZnQix9vHzp061l
         wVpW8EQNEjWmtD8C/q5BJVBMJ9CKyAAvBy2D7L9o+yNDuPDS3+fxt2bSISpmRzITcxCy
         i1V+3WEYfS08jyYLQpAahXCt0JFF54Z1VmkXvIfd/sXtbYCX4d221X+ZvzNKMfRhBxNK
         hgSPAjQvBrXs42yUAo/jtbGWuOVgVg/PFrtkad7g9COaThQC0521bf2Ou5PmSRUdCAMX
         5C7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPM2uR/Wo+libTS45fyAAFFnyLHSdwBtPOaOu3CFdk8rxxPuOJKLL9KsXHpmNLmj9STGVq4/O0@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtrG8XqIZs7HYr+455N0CG8WImipOSYhJ2uHRej3R/8lpdfao
	ODO0X84/9lUEDRxn9jPxWcBE3DlEVi2taIRKBf6Lm/bNzLbdRFUR
X-Google-Smtp-Source: AGHT+IHs8qgREiXS70QAeOk3N0f0I4HEEwNbNY1/Q7mOBG7UqMYDWBIWS9+DipoxWm4IRo8OchiTmw==
X-Received: by 2002:a05:690c:2d86:b0:6e2:413:f19 with SMTP id 00721157ae682-6e7f0e550b8mr33279067b3.27.1729715674250;
        Wed, 23 Oct 2024 13:34:34 -0700 (PDT)
Received: from localhost (fwdproxy-frc-021.fbsv.net. [2a03:2880:21ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f8e9sm16962987b3.139.2024.10.23.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:34:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org
Cc: nphamcs@gmail.com,
	mhocko@kernel.org,
	roman.gushcin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	lnyng@meta.com,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org
Subject: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Date: Wed, 23 Oct 2024 13:34:33 -0700
Message-ID: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
v2:
  * Enables the feature only if memcg accounts for hugeTLB usage
  * Moves the counter from memcg_stat_item to node_stat_item
  * Expands on motivation & justification in commitlog
  * Added Suggested-by: Nhat Pham

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

Aside from the consistentcy between the two files, we also see benefits
in observability. Userspace might be interested in the hugeTLB footprint
of cgroups for many reasons. For instance, system admins might want to
verify that hugeTLB usage is distributed as expected across tasks: i.e.
memory-intensive tasks are using more hugeTLB pages than tasks that
don't consume a lot of memory, or is seen to fault frequently. Note that
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
    duplicated. However, since the exsting solution of enabling the
    hugeTLB controller is an imperfect solution that still leaves a
    discrepancy between memory.stat and memory.curent, I think that it
    is reasonable to isolate the feature in this case.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

---
 include/linux/mmzone.h |  3 +++
 mm/hugetlb.c           |  4 ++++
 mm/memcontrol.c        | 11 +++++++++++
 mm/vmstat.c            |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..d3ba49a974b2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -215,6 +215,9 @@ enum node_stat_item {
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	HUGETLB_B,
 #endif
 	/* PGDEMOTE_*: pages demoted */
 	PGDEMOTE_KSWAPD,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..055bc91858e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
 				     pages_per_huge_page(h), folio);
 	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					  pages_per_huge_page(h), folio);
+	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
+		lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge_page(h));
 	mem_cgroup_uncharge(folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
@@ -3094,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (!memcg_charge_ret)
 		mem_cgroup_commit_charge(folio, memcg);
 	mem_cgroup_put(memcg);
+	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
+		lruvec_stat_mod_folio(folio, HUGETLB_B, pages_per_huge_page(h));
 
 	return folio;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845c64a2c57..de5899eb8203 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -306,6 +306,9 @@ static const unsigned int memcg_node_stat_items[] = {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	HUGETLB_B,
 #endif
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
@@ -1327,6 +1330,9 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	{ "hugeTLB",			HUGETLB_B			},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -1441,6 +1447,11 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
 
+#ifdef CONFIG_HUGETLB_PAGE
+		if (unlikely(memory_stats[i].idx == HUGETLB_B) &&
+				!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
+			continue;
+#endif
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
 		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b5a4cea423e1..466c40cffeb0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1269,6 +1269,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	"hugeTLB",
 #endif
 	"pgdemote_kswapd",
 	"pgdemote_direct",
-- 
2.43.5


