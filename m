Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAB230BD1
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgG1NxO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgG1NxO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 09:53:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0FC0619D2
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 06:53:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c12so5818164qtn.9
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tgRhh7GhlvwJN28Hg6FvcPJjSlCFNZBCcfEBizh4lA=;
        b=OrOPrYRy6/fwQ6aJZxoKHj37nZQXmWdOiWabQtaWUFXYjwfCT5sE9cO6f+LyApGEeQ
         WCNtiOtdHpTomMDpBYm+7mQ82h551UubQgKav8SzJLbVHmSmVY/8B4Lx2c5xZhq0b6D6
         40CdMI1nubUEC9YXV5wi2xN1L5cmansyRPHX8W6cndNzKKhZXjE/BXkb8r7R++Y7g2WH
         w2lLlpcXZBfVa7lbGXco0NApwiiHcGPEszEx32e8eqYn6DT6jO1QMZOyqVJ7ogmBbxVP
         lRDVv/TX95XhlUV0VwpKRxPraw1zXLDXGFpdZ6mlN3IRi5yodNbzvlcK2m2/igHELT5i
         O14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tgRhh7GhlvwJN28Hg6FvcPJjSlCFNZBCcfEBizh4lA=;
        b=dczTtkDgjdpVcDsyiFqbcppQKSmuMVRoGU3ruc25xdRyEWvbPJX8hPoKEvHe5/t5GJ
         McFkwIAv35FWGxh+2a7w6Ttwo42waod1g1h2uMUHt9ImIYxrsM9IrUhJoF+Uc87g+Zmk
         jqWg1jJCzCCYf9aou3qdlf7WccmPim8P+xB/NHYwa+33NWWpNBs+IhmSJilcIwBNA/ik
         OjHM1KvYwQeeoQMMJLbs4TPRXwkmfctkfgsfCMIMgYsbn7nZDlFQY4hooEdAKWfBcbLT
         Zj5wNiHVgZrIsEzzM/QJ5iqSMS5HVVhRPk2joBKfeBv26JevELf7DTs1dvANFsMu+A0E
         +ezA==
X-Gm-Message-State: AOAM531q8hpLcUZNNZC00GaKVwgkVLsw2DN00KhnTAS+/SBGWdzuZ6Y1
        7K1bQ63lZcfL5p9KWKykkwTwwQ==
X-Google-Smtp-Source: ABdhPJxd9K5bTJBh6nlLmnKACJ65F+8LJIyhXHdUAcNoMXYaAhNjcMbXjFLQ42inpdZHnptsoE/kzw==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr12668980qtr.135.1595944392965;
        Tue, 28 Jul 2020 06:53:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:53c1])
        by smtp.gmail.com with ESMTPSA id w44sm19714965qtj.86.2020.07.28.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 06:53:12 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: don't count limit-setting reclaim as memory pressure
Date:   Tue, 28 Jul 2020 09:52:10 -0400
Message-Id: <20200728135210.379885-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an outside process lowers one of the memory limits of a cgroup
(or uses the force_empty knob in cgroup1), direct reclaim is performed
in the context of the write(), in order to directly enforce the new
limit and have it being met by the time the write() returns.

Currently, this reclaim activity is accounted as memory pressure in
the cgroup that the writer(!) belongs to. This is unexpected. It
specifically causes problems for senpai
(https://github.com/facebookincubator/senpai), which is an agent that
routinely adjusts the memory limits and performs associated reclaim
work in tens or even hundreds of cgroups running on the host. The
cgroup that senpai is running in itself will report elevated levels of
memory pressure, even though it itself is under no memory shortage or
any sort of distress.

Move the psi annotation from the central cgroup reclaim function to
callsites in the allocation context, and thereby no longer count any
limit-setting reclaim as memory pressure. If the newly set limit
causes the workload inside the cgroup into direct reclaim, that of
course will continue to count as memory pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 12 +++++++++++-
 mm/vmscan.c     |  6 ------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 805a44bf948c..8377640ad494 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2233,11 +2233,18 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			 gfp_t gfp_mask)
 {
 	do {
+		unsigned long pflags;
+
 		if (page_counter_read(&memcg->memory) <=
 		    READ_ONCE(memcg->memory.high))
 			continue;
+
 		memcg_memory_event(memcg, MEMCG_HIGH);
+
+		psi_memstall_enter(&pflags);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
+		psi_memstall_leave(&pflags);
+
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
 }
@@ -2451,10 +2458,11 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
+	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
-	enum oom_status oom_status;
+	unsigned long pflags;
 
 	if (mem_cgroup_is_root(memcg))
 		return 0;
@@ -2514,8 +2522,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
 
+	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
 						    gfp_mask, may_swap);
+	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
 		goto retry;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749d239c62b2..742538543c79 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3318,7 +3318,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   bool may_swap)
 {
 	unsigned long nr_reclaimed;
-	unsigned long pflags;
 	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
@@ -3339,17 +3338,12 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
-
-	psi_memstall_enter(&pflags);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
-
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
 
-- 
2.27.0

