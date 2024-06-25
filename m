Return-Path: <cgroups+bounces-3330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C17915B62
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D62C283ECE
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527148781;
	Tue, 25 Jun 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eV89MCas"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95044C77
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277189; cv=none; b=kOsBhXNJBOL4sOFxmklrDyLo1+rJ3vPJWRyiSCZyh72QU7NVE4n19G/t7tr8DK+M+qIjH4uVc0J7MNweknbDsKxMK8yY2vrTiSTSszc8UgJwQWuf/nDHvjZ92pyheTRQlxUht3FPYebUoB+klPcJsSrhz9MNc3HbFFYDCaXiq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277189; c=relaxed/simple;
	bh=TeuSUGNM7krOR1ImWUbyFCeUYRReVvBXyseqinm1CaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbPVPZHPZnqRFG9uj+EHBv0Coa9wBeTvPN2jLBZ26BGjbBrExZN88h9M0drnscPw2zy2ET74IqOIFlMoZXsRCArqWKImERCyicmsqLi2h4NPnzuiWIrz0obht0nXiFa/GGGagdlaqOxLkGW2TNRoylVPGyK/ACpc0kpbM89a/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eV89MCas; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbzH39LFdgO7g4Zh8QO5WwcNo4wg+o7OIMv0JFj+P7c=;
	b=eV89MCast7EgJhdesN7qSvQtr85YMmOO0k2w6ijFUtydlNQ78AauHRfRhUjsPEeOfbC5Gx
	dtcK/V9nKa9SNmF/5FFvf0Xxi6O7J2yw96sE17lemuK/TV1CjppWoMQQb/mE6M7L50bNMj
	8VHqifkS/V/BI3Pm3oEoZbviAukkS9Q=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 09/14] mm: memcg: rename memcg_oom_recover()
Date: Mon, 24 Jun 2024 17:59:01 -0700
Message-ID: <20240625005906.106920-10-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename memcg_oom_recover() into memcg1_oom_recover() for consistency
with other memory cgroup v1-related functions.

Move the declaration in mm/memcontrol-v1.h to be nearby other
memcg v1 oom handling functions.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 6 +++---
 mm/memcontrol-v1.h | 2 +-
 mm/memcontrol.c    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 253d49d5fb12..1d5608ee1606 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1090,8 +1090,8 @@ static void __mem_cgroup_clear_mc(void)
 
 		mc.moved_swap = 0;
 	}
-	memcg_oom_recover(from);
-	memcg_oom_recover(to);
+	memcg1_oom_recover(from);
+	memcg1_oom_recover(to);
 	wake_up_all(&mc.waitq);
 }
 
@@ -2067,7 +2067,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
 
-void memcg_oom_recover(struct mem_cgroup *memcg)
+void memcg1_oom_recover(struct mem_cgroup *memcg)
 {
 	/*
 	 * For the following lockless ->under_oom test, the only required
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 3de956b2422f..972c493a8ae3 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -13,7 +13,6 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
 void memcg1_check_events(struct mem_cgroup *memcg, int nid);
-void memcg_oom_recover(struct mem_cgroup *memcg);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
 
@@ -92,5 +91,6 @@ ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
+void memcg1_oom_recover(struct mem_cgroup *memcg);
 
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8abd364ac837..37e0af5b26f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3167,7 +3167,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	} while (true);
 
 	if (!ret && enlarge)
-		memcg_oom_recover(memcg);
+		memcg1_oom_recover(memcg);
 
 	return ret;
 }
@@ -3752,7 +3752,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 
 	WRITE_ONCE(memcg->oom_kill_disable, val);
 	if (!val)
-		memcg_oom_recover(memcg);
+		memcg1_oom_recover(memcg);
 
 	return 0;
 }
@@ -5479,7 +5479,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
 		if (ug->nr_kmem)
 			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
+		memcg1_oom_recover(ug->memcg);
 	}
 
 	local_irq_save(flags);
-- 
2.45.2


