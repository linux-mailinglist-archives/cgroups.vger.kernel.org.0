Return-Path: <cgroups+bounces-4922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD697DA83
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D01C21053
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C39187329;
	Fri, 20 Sep 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="UrW4QY6k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95843143C49
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870375; cv=none; b=lAxGUUqjV8qKwc7foWrHadWdzh3e1QQaun0U+SCnbwQao1tPu36w1GxYlSvGkBtssqE9iXmfI9Hq/nrtUihgN0XEjomGCYyLW/v0ju0I5ImtTCgU+uGqH0bG5aGbq3Idmtoy7sh8NoQlPiIMS9TXb4HXDQKGroqKwDRW10TUI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870375; c=relaxed/simple;
	bh=GPN7LdArtVbanGJpcjNbS7Q/hybofyXmYBc65htFs7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIsGPacmFPiDymFLfy085226RXEW7Nn/bOzr9c46MVMR26Gjd9YOU/WYmc7GcyhqTIAX2l3EJrRTG5Ii6BVlLBRCqTNzX9XQMZ3T2raP85H2yTgnrOFOLkU5l+C2KGekiHgVK8eWji/zFhDIKGdQZ5WoFwbakFM0/YKVDArDhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=UrW4QY6k; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c548eb3380so12709966d6.1
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1726870372; x=1727475172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dua3EzvkneWM3TAvRq2/3u51msVEEUUg6Zhqmm/qfGM=;
        b=UrW4QY6k9bSi901aaxcUnPPJVqkmJtnd0X30b4dwyF+IrHmenpsgUUpfNoUiF22qNd
         Aoct9lTZNmISpWJJE7QKIPDYqOVgsbKau4jkaWOdHCLZVisFoQjn21h8WKxW0xUDUx04
         f1MdoKJ8Oc5B4W9kCJ0+QQMkUnB5Ut4FBfOVZ1Wl7wiVEvAQDzRvvI2OKj4Qw4Qtv1yh
         9rDr5eEb13ST+/nO11cgCrUV77UDRJEw17KNWs8A2Ida0hcUcc+2TfDqOwc2M4gs5959
         vDa7OEiUrxUsbwaaEU+eI22blfFZSGjQ/5AyPw6EuOYpvqcQFB6zYDLVnFpk3RWqfOSy
         2Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726870372; x=1727475172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dua3EzvkneWM3TAvRq2/3u51msVEEUUg6Zhqmm/qfGM=;
        b=JlNw1Zak10NFIJqwRd3aS5pxb3xvGtON6LXx1XLcQBGhUop5gu6L0FdhuFL9Vq8HyX
         Xi8WszWh4VNzH6JIEF4xd2Kphu77kM7g9ZwVelfx4cN1PSVAH9zYZagYxoSTQH3v+9Z5
         Hv6v2LCBLNhhbN/2NVUQ+4bom/pR1hQ+GzrefTLdBScs5YWbgXeUvVwmVav7+sPsZdrA
         XmLms6/FZiwKfkJLSOFajOO5jQvwfjbtvhNyarV08Kc3OCjHTMC58tCZrR4P4GlribJ/
         PNvSUFN3aRIZbHvJXkbQv4zNoMxvOluESc09VrPGi27b4OBoFJHy+pK7qOZ9rXXeDWSL
         vR5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQVVqA356K6YiQEE+2gNzQHybn9QsZkLN19gQM5u47we01PBX5oxKvS9kVNzH+ZM0g8lquVVmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFvoOOkp44YyLfUI3BHpUwi2eCAEf0PUbGTZlWCr3SI3KyUSD
	vDQoNRHThfyycHW7gy/QbZgG8cWbQPS1dCWfEI3v2Zzk63v4WHXqaCFusAGP2w==
X-Google-Smtp-Source: AGHT+IFt0V61eP797QLmbHgiSqqaJMC8ZiLd28uIJxGM3kNR5lwGLx+JECFMYHwxRLmmCyhdNYC+KA==
X-Received: by 2002:a05:6214:5c4a:b0:6c5:32a5:567a with SMTP id 6a1803df08f44-6c7bd486c6bmr56855866d6.1.1726870372363;
        Fri, 20 Sep 2024 15:12:52 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6c75e557e58sm23236106d6.81.2024.09.20.15.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 15:12:52 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	weixugc@google.com,
	rientjes@google.com,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: [RFC PATCH 3/4] use memory.low local node protection for local node reclaim
Date: Fri, 20 Sep 2024 22:11:50 +0000
Message-ID: <20240920221202.1734227-4-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

When reclaim targets the top-tier node usage by the root memcg,
apply local memory.low protection instead of global protection.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
 include/linux/memcontrol.h | 23 ++++++++++++++---------
 mm/memcontrol.c            |  4 ++--
 mm/vmscan.c                | 19 ++++++++++++++-----
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 94aba4498fca..256912b91922 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -586,9 +586,9 @@ static inline bool mem_cgroup_disabled(void)
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
-					 unsigned long *low)
+					 unsigned long *low, unsigned long *locallow)
 {
-	*min = *low = 0;
+	*min = *low = *locallow = 0;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -631,10 +631,11 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 
 	*min = READ_ONCE(memcg->memory.emin);
 	*low = READ_ONCE(memcg->memory.elow);
+	*locallow = READ_ONCE(memcg->memory.elocallow);
 }
 
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-				     struct mem_cgroup *memcg);
+				     struct mem_cgroup *memcg, int is_local);
 
 static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 					  struct mem_cgroup *memcg)
@@ -651,13 +652,17 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush);
 
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
-					struct mem_cgroup *memcg)
+					struct mem_cgroup *memcg, int is_local)
 {
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
-	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+	if (is_local)
+		return READ_ONCE(memcg->memory.elocallow) >=
+			get_cgroup_local_usage(memcg, true);
+	else
+		return READ_ONCE(memcg->memory.elow) >=
+			page_counter_read(&memcg->memory);
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
@@ -1159,13 +1164,13 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
-					 unsigned long *low)
+					 unsigned long *low, unsigned long *locallow)
 {
 	*min = *low = 0;
 }
 
 static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-						   struct mem_cgroup *memcg)
+						   struct mem_cgroup *memcg, int is_local)
 {
 }
 
@@ -1175,7 +1180,7 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 	return true;
 }
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
-					struct mem_cgroup *memcg)
+					struct mem_cgroup *memcg, int is_local)
 {
 	return false;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d7c5fff12105..61718ba998fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4495,7 +4495,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *          of a top-down tree iteration, not for isolated queries.
  */
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
-				     struct mem_cgroup *memcg)
+				     struct mem_cgroup *memcg, int is_local)
 {
 	bool recursive_protection =
 		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
@@ -4507,7 +4507,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 		root = root_mem_cgroup;
 
 	page_counter_calculate_protection(&root->memory, &memcg->memory,
-					recursive_protection, false);
+					recursive_protection, is_local);
 }
 
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ce471d686a88..a2681d52fc5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2377,6 +2377,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum scan_balance scan_balance;
 	unsigned long ap, fp;
 	enum lru_list lru;
+	int is_local = (pgdat->node_id == 0) && root_reclaim(sc);
 
 	/* If we have no swap space, do not bother scanning anon folios. */
 	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
@@ -2457,12 +2458,14 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	for_each_evictable_lru(lru) {
 		bool file = is_file_lru(lru);
 		unsigned long lruvec_size;
-		unsigned long low, min;
+		unsigned long low, min, locallow;
 		unsigned long scan;
 
 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
 		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
-				      &min, &low);
+				      &min, &low, &locallow);
+		if (is_local)
+			low = locallow;
 
 		if (min || low) {
 			/*
@@ -2494,7 +2497,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			 * again by how much of the total memory used is under
 			 * hard protection.
 			 */
-			unsigned long cgroup_size = mem_cgroup_size(memcg);
+			unsigned long cgroup_size;
+
+			if (is_local)
+				cgroup_size = get_cgroup_local_usage(memcg, true);
+			else
+				cgroup_size = mem_cgroup_size(memcg);
 			unsigned long protection;
 
 			/* memory.low scaling, make sure we retry before OOM */
@@ -5869,6 +5877,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	};
 	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
 	struct mem_cgroup *memcg;
+	int is_local = (pgdat->node_id == 0) && root_reclaim(sc);
 
 	/*
 	 * In most cases, direct reclaimers can do partial walks
@@ -5896,7 +5905,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		cond_resched();
 
-		mem_cgroup_calculate_protection(target_memcg, memcg);
+		mem_cgroup_calculate_protection(target_memcg, memcg, is_local);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
@@ -5904,7 +5913,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
+		} else if (mem_cgroup_below_low(target_memcg, memcg, is_local)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
-- 
2.43.0


