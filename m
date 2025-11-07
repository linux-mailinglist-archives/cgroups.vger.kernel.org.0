Return-Path: <cgroups+bounces-11671-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1AC41E1B
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 23:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B1189B4B6
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB2315D46;
	Fri,  7 Nov 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cXUpI7/c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3C315D49
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555816; cv=none; b=Q6+dUeUAKNn+xzIELATpXIPSgub0KXWr4yWVinrxLkGeRx8+vlTVd4Pm/3OQwAh9DVg9KWJtXgcPMvHQTtHqWQQ8hYAUR4l85JCDnFqobUytYDNEWsNO2NsmZ+8BvymCvEaYBwos2dSNM6ZCvuWLblsog9edpx6nKFAb/mjKJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555816; c=relaxed/simple;
	bh=t1PWd9W4F3MKCeCrtb+bV5TXG4Q3iLBygfAXlk1bL90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNtAVqPK0Z1hWmbpLIIMdKOQQT/yDbNwlnSHfwisd1ox/n3zFJ1nGGnN7XYSPAfWpK2408FY1ZVY8yleS5XKO+R9T9DiG/GTEyrPMl9arWWGy1byu4v1I49jWumD/rIQvFRqTCIwSpwj0nA94mTixZ8q9AnrGBR5uh6KECYhkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cXUpI7/c; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-791fd6bffbaso12940446d6.3
        for <cgroups@vger.kernel.org>; Fri, 07 Nov 2025 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555813; x=1763160613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R64FiI16+WP3yeCxBiatrBL599beZnZfURxXJrYPjuA=;
        b=cXUpI7/cMn5k+awQtKL0FOzd4sXqQOWsxwGnDkd9pHvPNP+VRHtl8gsSOyJyTCFgX/
         +G9lsv3XAV5wWJM9ARO5AdGiKzvD52sYV4xiL8xlQs9V2UMJmSq60vKt4NmyFbn1twF6
         v6ghTCtaqQ0N5MB3q7rDjxd4NWvCR7yN3v5a9eUjboC+PtXIHKyz2pVRo9//APtD26/0
         2qV4sDsrJfNFMsg9eEGrkM67O2Ws/6dmR6CyRctDXzf7cxQDCM6XGC18mccYnyoChcKL
         hzeeGpQSoN85dnIWy/EuE0jLbCtB20DwePbYgQsQXoVaE+tCKpDZsPI8q6oY0HpeT3bD
         d4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555813; x=1763160613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R64FiI16+WP3yeCxBiatrBL599beZnZfURxXJrYPjuA=;
        b=tmpdUQAmEHI3MlMfBXG1Z/PmZTNjTEvYuPEyPf/ihJ3CfNUXWgt5QJOWYPWRBgbTwJ
         fT4GWgvNajwjbrLUjkt3M6V42wDJLiV/929TcptvRtiogS5iAGWlfmUIGOhOCr/j+Ujm
         5gd7L0XFiiZyCGqrWhi1I2SnocERxoqaJI0O93GvlZXOpFRS2zl3PJpb+GQ96q88RF+p
         SFBViQmG21YnTXaspMkm41/3JJ2LHdUzEEcyLeMgSjfXLpptZJ1OG2CRGkEfxNxscDWj
         tU3y09LlXXY0l8Sgh2tCB8G6w3UkMQWl44PAfc57KBqycDonPTSLS+yG1gYiZALdIKmt
         kVLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjXMJ9r22qRgxvg1mBiUQqgDlduDLhjUo/KSTNxn4AqEeIxpeILtOfuuD/Ot0cRI1ybBzmwNBK@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJndqdo4jUoRj4jFW6mtLYxkQ7nBVvqxUWieSQBb5a3agfd8P
	X4AdqXAtteIgrzGMKc2UU8PP0DxLKNc5P1gd4ydA6gwyU0j89reEsbfvWxf5gdjBgh8=
X-Gm-Gg: ASbGncuyoFMjiUfhfW2gbpZTgw5A2N5Xz7q9wzmZPQtVk+rXmPefVglkZbfk1gUS3p6
	SxoiGEc+XoIgQUovGD5Qd1xbIBMnQCb305y2t7qK/WncGeVybGMtO1GR4FB3c+Y6f4MdEJnN4Kk
	w/Vt0DGGsJqVdTcF6rNtpHrQ1ePINTzeaUX16vKXlzTDvGCPKK4xJsVuBPAV09gWR+AMWTe0zN7
	m624b3ydGonTawcTRbkZkmv0b5pTaHPppOrr3AdsqePOxdUvC+V5DhQu7b62ZY06KZ19FwTZQAS
	Nrn1wmg9hhyJ5RSIUoOmjLUo3+q9fooJ0O/kG6SmxOpk1vb9yY3U982Jb3lZLFdDoFPjbP5RojH
	l1arM6UipMAX9+MzlQXcyj42MeYIsFrH3uc5uRPxnkT4iicLtFX5BaS7gUxRvHDdqlPXunhZXfA
	sdn0qgKif5RXw/1powsodNWC3Ld7AT1DHPaKtHY81AetC0ddIcw98S+zEommUCzP4Rc9voCzBfR
	5IgRDL9kdvACw==
X-Google-Smtp-Source: AGHT+IG4CM60aE94hoVAm6WlLLrQN78GzB6+sZgYXWXWNkYKc0tId9Jl3T1QS1663TlSzExe8IcNow==
X-Received: by 2002:a05:6214:20eb:b0:882:36d3:2c60 with SMTP id 6a1803df08f44-88238616f43mr9660116d6.19.1762555812276;
        Fri, 07 Nov 2025 14:50:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 3/9] mm: default slub, oom_kill, compaction, and page_alloc to sysram
Date: Fri,  7 Nov 2025 17:49:48 -0500
Message-ID: <20251107224956.477056-4-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constrain core users of nodemasks to the default_sysram_nodemask,
which is guaranteed to either be NULL or contain the set of nodes
with sysram memory blocks.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/oom_kill.c   |  5 ++++-
 mm/page_alloc.c | 12 ++++++++----
 mm/slub.c       |  4 +++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c145b0feecc1..e0b6137835b2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -34,6 +34,7 @@
 #include <linux/export.h>
 #include <linux/notifier.h>
 #include <linux/memcontrol.h>
+#include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
@@ -1118,6 +1119,8 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
+	if (!oc->nodemask)
+		oc->nodemask = default_sysram_nodes;
 
 	if (oom_killer_disabled)
 		return false;
@@ -1154,7 +1157,7 @@ bool out_of_memory(struct oom_control *oc)
 	 */
 	oc->constraint = constrained_alloc(oc);
 	if (oc->constraint != CONSTRAINT_MEMORY_POLICY)
-		oc->nodemask = NULL;
+		oc->nodemask = default_sysram_nodes;
 	check_panic_on_oom(oc);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd5401fb5e00..18213eacf974 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -34,6 +34,7 @@
 #include <linux/cpuset.h>
 #include <linux/pagevec.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
@@ -4610,7 +4611,7 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	 */
 	if (cpusets_enabled() && ac->nodemask &&
 			!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
-		ac->nodemask = NULL;
+		ac->nodemask = default_sysram_nodes;
 		return true;
 	}
 
@@ -4794,7 +4795,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * user oriented.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
-		ac->nodemask = NULL;
+		ac->nodemask = default_sysram_nodes;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
 	}
@@ -4946,7 +4947,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
-	}
+	} else if (!ac->nodemask) /* sysram_nodes may be NULL during __init */
+		ac->nodemask = default_sysram_nodes;
 
 	might_alloc(gfp_mask);
 
@@ -5190,8 +5192,10 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	/*
 	 * Restore the original nodemask if it was potentially replaced with
 	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
+	 *
+	 * If not set, default to sysram nodes.
 	 */
-	ac.nodemask = nodemask;
+	ac.nodemask = nodemask ? nodemask : default_sysram_nodes;
 
 	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
 
diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..b8358a961c4c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/mempolicy.h>
+#include <linux/memory-tiers.h>
 #include <linux/ctype.h>
 #include <linux/stackdepot.h>
 #include <linux/debugobjects.h>
@@ -3570,7 +3571,8 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
-		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+		for_each_zone_zonelist_nodemask(zone, z, zonelist, highest_zoneidx,
+						default_sysram_nodes) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
-- 
2.51.1


