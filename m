Return-Path: <cgroups+bounces-7026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6061A5E761
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649A817376C
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884241F03D6;
	Wed, 12 Mar 2025 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QDGH1kxg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73801F03C2
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818388; cv=none; b=TsiA69RdMZzr0UgoZFggjf8TeS2/GgIbweoYz2LXAtDXnimVGn6p+onHXS3U9dYAUqPesagSC+nmJORIJb8p9kuI5DfnmaTqBLHfccm1Ya1vE7xfKfBoHXsZeujzZOyXG+Y08eApZY90Yb3puEHyFblFDQkVqzyof8a1C7gwOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818388; c=relaxed/simple;
	bh=It8g9/rZbPtw2Kfw76dZUtMYOYZvwoGmZubDu5gyXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXTL3oqrX/vJjD0bmQwU6YJRZpfYQC4ocxSOVvHIkZDCM8YGrbt5W0bU/f0gw1TDjtYFMN4g5uoGA01NvH3cebRAHtimuQISJt+6am7XJRegYXzhcxQKUgqqO52HcLeAL/YLYQSEI2xd1gFN6StJSe+u7NYp0zwpCuhCFkuyjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QDGH1kxg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741818383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AFPGE3NPG2ZVG/y8e2qb1wahSmn2Ta6Uouhe/XHQ2mk=;
	b=QDGH1kxgBQDIZIVNIJ/FPtae8q7wBN0php2sCcnEruis6Xcbnx+qQh59arbRhlfFXYPoWb
	bovPKIkiCMKW9BRyWIx5xy725Lf0QHgisp8i62QTkCrbzylESvSWtQmTyYTUeAaFmASiZi
	N9UJ50PI0Ix63ZPRbaYWdf0LkM3Zw1M=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: move do_memsw_account() to CONFIG_MEMCG_V1
Date: Wed, 12 Mar 2025 15:25:52 -0700
Message-ID: <20250312222552.3284173-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The do_memsw_account() is used to enable or disable legacy memory+swap
accounting in memory cgroup. However with disabled CONFIG_MEMCG_V1, we
don't need to keep checking it. So, let's always return false for
!CONFIG_MEMCG_V1 configs.

Before the patch:

$ size mm/memcontrol.o
   text    data     bss     dec     hex filename
  49928   10736    4172   64836    fd44 mm/memcontrol.o

After the patch:

$ size mm/memcontrol.o
   text    data     bss     dec     hex filename
  49430   10480    4172   64082    fa52 mm/memcontrol.o

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol-v1.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 653ff1bad244..6358464bb416 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -22,12 +22,6 @@
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-/* Whether legacy memory+swap accounting is active */
-static inline bool do_memsw_account(void)
-{
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
-}
-
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
 void drain_all_stock(struct mem_cgroup *root_memcg);
@@ -42,6 +36,12 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
+/* Whether legacy memory+swap accounting is active */
+static inline bool do_memsw_account(void)
+{
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
+}
+
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
@@ -94,6 +94,7 @@ extern struct cftype mem_cgroup_legacy_files[];
 
 #else	/* CONFIG_MEMCG_V1 */
 
+static inline bool do_memsw_account(void) { return false; }
 static inline bool memcg1_alloc_events(struct mem_cgroup *memcg) { return true; }
 static inline void memcg1_free_events(struct mem_cgroup *memcg) {}
 
-- 
2.47.1


