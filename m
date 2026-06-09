Return-Path: <cgroups+bounces-16748-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ob1vLIBeJ2rxvAIAu9opvQ
	(envelope-from <cgroups+bounces-16748-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 02:29:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9765B56F
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 02:29:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b="mnw/2vwE";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16748-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16748-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E354E302297D
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6623C4F2;
	Tue,  9 Jun 2026 00:29:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C122AE48
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 00:29:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964968; cv=none; b=atMcn90Cu04UefnitMnqQCJ/Jg5nwKMJVL6Ov1HjrOoqTTGufuAKUPrqT3wjnMGhKBULrEVhz3UWcTMci9RjOUzO695FFycrsSlpV8649OCzjPdKy1XqcZpZrUSBG2jty+h0qzonCnzGXtPQCVm5961uUGkDlQX1Bm/23qhOWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964968; c=relaxed/simple;
	bh=UagVPClxp+cjnTWf8zGOxjH11P50OflKkUDCJGOX//M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTKicFES0FpmZBc979BuecACE1ooVbx8s9DfPI+aBpcX/jKoDuLZbsPoYxqMtW/I/NctBhYVlzHQmFuXJAWRAUtwYk/obzQNHeQYYrNm5IiRsYsWBLjpt65P2vblh1o8DNwTX8eMtHVZbRxvLDlUk69JPf6XH3I5mdN+rpHaBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mnw/2vwE; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157d3f2098so596966885a.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780964965; x=1781569765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OuP5xJRvipAvyXVi1m7B0jtySHplOxvFb6PPG4kpb8=;
        b=mnw/2vwEUArGVmZS0JwH5VwFd0BitLZv3RB5r7i2KjoeRDUv80EnsslnF9Hz34daC0
         jgs0e1C3rqwzoCpsjE6Jw8oqr7sUqAVlHUursoqgAF3pRgQVVPcnEh9smIPjUDgZ2HdY
         96GC25NrfXyjFV84sxFidAMPmHOG0Jm+HGrbUc9xICV4ZjMeWKbVllFukpTAGAv+22Qo
         GzseO3Sn9xvmXjOfdOL8/ibHb0u8vh/5LjK7KMwbQvAyN5mS7tDkejKbi70qPikdgPSU
         nDQeux3RkR4oC7+U1OQ95Ysj/vchW/xLRzM30ZPxGk9tSgEKUcP50uWF0l4tEayRsMuq
         qVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964965; x=1781569765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OuP5xJRvipAvyXVi1m7B0jtySHplOxvFb6PPG4kpb8=;
        b=izdpYGqp7LTVQrfZ0ViBhOp7F/BUQ8V/eTSPPe7CpSxC0LBWdSM3aLV/DfiH5ZJ+Et
         811jEOCWaeZ09oTAtJT7idU7ki4q5RJ0DVKdOv3yY13Bzf9AfDxBOLqtZW/mrVWWIP8z
         /dgxPaUvry2JWyD8pL8x/TBqaH6gBJhj/zQCm7khvz1pGsiIXjbhh9jWCkwl9lbNe1yd
         3DnBHRl5eWHjpLHbrtO7p5SZOIzSXijl+cSMTEUc07rLuRDVBHhev6Gk+EI8BKHWG0Qg
         1dnYVqbtOc5suMDG/gemmyBdAR+7U2vaNSBwxB+f9AjkNuWi1EKAV5a6PkKawTcDYzID
         Sl8g==
X-Forwarded-Encrypted: i=1; AFNElJ+nOsYyX9MXVyCC3O+ai7CdTULulKJrgdX34VCxjLZg47W0x05i16hK0FLnOfxntbwEppS3xinz@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+y56tq4Qa3t67yqRNRX5LNgDhSLwkf1RBAuB9rQHqOW9WXjX
	EuX6dKGsf02jLQwt2BaRbDAgd2Q0Lwas3pyfcA0iNwts9tptpElfs4NhVC4hHIEFXDwHN64q44r
	dctd1
X-Gm-Gg: Acq92OHiTeb9Mzs+MtskXhdhbJYCaEmCIURNBbrmcLoHZasURFWfBalJhEy0EWZRBz/
	QKWV0mbuKC8uVb0s8bLh2q5MalslMjrPGLWjqEFLbFN2q8zQCIMGiQA8GrAmjxuA9HbchSsVXTB
	LkiwF3yclsVk1Y0wsLMAatgmcIdeOn+suqu+UX+yCY8ikkev8IYRNRQUadJeZL0MEc3NoCZnVJn
	ZDxh8ILHPYkephgtCWRjD/WXfDrRp/aoVN+ifdY5j7/9mb3ZWE4iIcKCyEsVhUm82fruXT7rKKW
	jPNvyfnSGDRcPDztpVbWVS8xGVrgK/g49fnmAyH78iWhf9X6jwLZ6vy95D3IxEvawQRwMWqoDEd
	QqUODewDRgOqRMDP29rxxwCB4RKEX3c7OBKpAZMZDtvck3LD4vvxPXOgIwWczmgWbx0sV3cmU19
	hS6/VgQtFU0KbTpQAE3VDPGrrXwjg7p1VliI+A682JH48pNPsnbRQw4cpxkUnwXuN6l8xwUHMfJ
	BeQEfzwrYgeSkVJORuYSS0=
X-Received: by 2002:a05:620a:270d:b0:8cd:9033:1724 with SMTP id af79cd13be357-915a9c29334mr2833428885a.9.1780964965287;
        Mon, 08 Jun 2026 17:29:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d7280sm1909268085a.41.2026.06.08.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 17:29:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	chenridong@huaweicloud.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rientjes@google.com,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	youngjun.park@lge.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com
Subject: [PATCH] mm: constify oom_control, scan_control, and alloc_context nodemask
Date: Mon,  8 Jun 2026 20:29:19 -0400
Message-ID: <20260609002919.3967782-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16748-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,nvidia.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C9765B56F

The nodemasks in these structures may come from a variety of sources,
including tasks and cpusets - and should never be modified by any code
when being passed around inside another context.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h | 4 ++--
 include/linux/mm.h     | 4 ++--
 include/linux/mmzone.h | 6 +++---
 include/linux/oom.h    | 2 +-
 include/linux/swap.h   | 2 +-
 kernel/cgroup/cpuset.c | 2 +-
 mm/internal.h          | 2 +-
 mm/mmzone.c            | 5 +++--
 mm/page_alloc.c        | 6 +++---
 mm/show_mem.c          | 9 ++++++---
 mm/vmscan.c            | 6 +++---
 11 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 65d76a38974b..a80d38e752d2 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -83,7 +83,7 @@ extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
 
 extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
@@ -224,7 +224,7 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 #define cpuset_current_mems_allowed (node_states[N_MEMORY])
 static inline void cpuset_init_current_mems_allowed(void) {}
 
-static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+static inline int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return 1;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..2101e5205fc0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4042,7 +4042,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 
-extern void __show_mem(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
+extern void __show_mem(unsigned int flags, const nodemask_t *nodemask, int max_zone_idx);
 static inline void show_mem(void)
 {
 	__show_mem(0, NULL, MAX_NR_ZONES - 1);
@@ -4052,7 +4052,7 @@ extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
 extern __printf(3, 4)
-void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
+void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca2712187147..919be0d9b4fa 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1815,7 +1815,7 @@ static inline int zonelist_node_idx(const struct zoneref *zoneref)
 
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes);
+					const nodemask_t *nodes);
 
 /**
  * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
@@ -1834,7 +1834,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
  */
 static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	if (likely(!nodes && zonelist_zone_idx(z) <= highest_zoneidx))
 		return z;
@@ -1860,7 +1860,7 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
  */
 static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	return next_zones_zonelist(zonelist->_zonerefs,
 							highest_zoneidx, nodes);
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7b02bc1d0a7e..00da05d227e6 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -30,7 +30,7 @@ struct oom_control {
 	struct zonelist *zonelist;
 
 	/* Used to determine mempolicy */
-	nodemask_t *nodemask;
+	const nodemask_t *nodemask;
 
 	/* Memory cgroup in which oom is invoked, or NULL for global oom */
 	struct mem_cgroup *memcg;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245ba..bf76356d94fe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -351,7 +351,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-					gfp_t gfp_mask, nodemask_t *mask);
+					gfp_t gfp_mask, const nodemask_t *mask);
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c33ab20cc20..536ce591c7ba 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4153,7 +4153,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
  *
  * Are any of the nodes in the nodemask allowed in current->mems_allowed?
  */
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return nodes_intersects(*nodemask, current->mems_allowed);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..a2ef9512b5bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -668,7 +668,7 @@ void page_alloc_sysctl_init(void);
  */
 struct alloc_context {
 	struct zonelist *zonelist;
-	nodemask_t *nodemask;
+	const nodemask_t *nodemask;
 	struct zoneref *preferred_zoneref;
 	int migratetype;
 
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 0c8f181d9d50..59dc3f2076a6 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,7 +43,8 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
+static inline int zref_in_nodemask(struct zoneref *zref,
+				   const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
 	return node_isset(zonelist_node_idx(zref), *nodes);
@@ -55,7 +56,7 @@ static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 /* Returns the next zone at or below highest_zoneidx in a zonelist */
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	/*
 	 * Find the next suitable zone to use for the allocation.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81a9d4d1e6c0..586524bbde9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3979,7 +3979,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	return NULL;
 }
 
-static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
+static void warn_alloc_show_mem(gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned int filter = SHOW_MEM_FILTER_NODES;
 
@@ -3999,7 +3999,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	mem_cgroup_show_protected_memory(NULL);
 }
 
-void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
+void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -4687,7 +4687,7 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	return false;
 }
 
-static void check_alloc_stall_warn(gfp_t gfp_mask, nodemask_t *nodemask,
+static void check_alloc_stall_warn(gfp_t gfp_mask, const nodemask_t *nodemask,
 				unsigned int order, unsigned long alloc_start_time)
 {
 	static DEFINE_SPINLOCK(alloc_stall_lock);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 43aca5a2ac99..1b721a8ade67 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -116,7 +116,8 @@ void si_meminfo_node(struct sysinfo *val, int nid)
  * Determine whether the node should be displayed or not, depending on whether
  * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
  */
-static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
+static bool show_mem_node_skip(unsigned int flags, int nid,
+			       const nodemask_t *nodemask)
 {
 	if (!(flags & SHOW_MEM_FILTER_NODES))
 		return false;
@@ -177,7 +178,8 @@ static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
  * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
  *   cpuset.
  */
-static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
+			    int max_zone_idx)
 {
 	unsigned long free_pcp = 0;
 	int cpu, nid;
@@ -402,7 +404,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 	show_swap_cache_info();
 }
 
-void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+void __show_mem(unsigned int filter, const nodemask_t *nodemask,
+		int max_zone_idx)
 {
 	unsigned long total = 0, reserved = 0, highmem = 0;
 	struct zone *zone;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e8a90911bf88..47d3f3361fb9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -79,7 +79,7 @@ struct scan_control {
 	 * Nodemask of nodes allowed by the caller. If NULL, all nodes
 	 * are scanned.
 	 */
-	nodemask_t	*nodemask;
+	const nodemask_t *nodemask;
 
 	/*
 	 * The memory cgroup that hit its limit and as a result is the
@@ -6599,7 +6599,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
  * happens, the page allocator should not consider triggering the OOM killer.
  */
 static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
-					nodemask_t *nodemask)
+				    const nodemask_t *nodemask)
 {
 	struct zoneref *z;
 	struct zone *zone;
@@ -6679,7 +6679,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 }
 
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-				gfp_t gfp_mask, nodemask_t *nodemask)
+				gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
-- 
2.54.0


