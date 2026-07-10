Return-Path: <cgroups+bounces-17649-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DvFGKGXUUGro5wIAu9opvQ
	(envelope-from <cgroups+bounces-17649-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 13:15:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE973A156
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 13:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IFqLqY3D;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17649-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17649-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD473033FBE
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41213411687;
	Fri, 10 Jul 2026 11:13:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBF411685
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 11:12:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681980; cv=none; b=E6vSI7ZlIhMVy7AxbUXZ/HC1amZn4v9kquveFtiPzSzeZ8zFRf03doR5Z2bEt6kLSB2R7FoimkxMGkDMmaw4OmdRU0XsrNJRKmXSMbpGvEmGESptTA6aFwNcZS3uEWGZp78qn6XdDRgKKahpLnUioUcD02jmsOFR4Lq9ZM54MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681980; c=relaxed/simple;
	bh=YAJmIcgFhuEkxoN+buq1tJmz160P3f3NKCnJHSyubrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TnEJSmDo7ZIbnaNNtEflFAgeabGau34ZGHlequYT6q8w1dDAkThWJNk2ERtccwgM+CzqeOYoVafc20ZIk2ab5ludCbckx1AA6lGTs7Ype85uZcGAI0SBOj6GV+lub5R2AkimnciHS+3Dw7ZEz2qXX4pTmmgxdoELRPxIFlKlTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFqLqY3D; arc=none smtp.client-ip=95.215.58.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783681966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ngy3pMTw2oJe0xcoHveOCKAvtR5RPrFr2htiJZs9bhY=;
	b=IFqLqY3DAom4XvqaOjOErkF9/erqvA8chQ+Lvm+KxY9AN68SP4P+GyN8fmmYCaSu1887qi
	KZpk284BSdJmi+2Wm7GfxTubHbzT+HC4h6mpzd6uxoaNVIVToJSbX/IhiC0GLuaRGx3gPf
	wuONTmcM/XJf5DAxbyn0aAfYDwWyLFU=
From: Ridong <ridong.chen@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ridong.chen@linux.dev,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH -next] memcg: move mem_cgroup_swappiness to memcontrol.h
Date: Fri, 10 Jul 2026 19:12:24 +0800
Message-Id: <20260710111224.2355668-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,huaweicloud.com,gmail.com,kernel.org,lge.com,vger.kernel.org,kvack.org,xiaomi.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17649-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:ridong.chen@linux.dev,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0BE973A156

From: Ridong Chen <chenridong@xiaomi.com>

The per-memcg swappiness knob is v1-only; v2 always uses global
vm_swappiness and ignores the per-cgroup field.

Guard memcg->swappiness with CONFIG_MEMCG_V1, and move the helper
to memcontrol.h where it belongs.

No functional change for v1; v2-only kernels drop the unused field.

Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 include/linux/memcontrol.h | 25 +++++++++++++++++++++++--
 include/linux/swap.h       | 19 -------------------
 mm/memcontrol.c            |  3 +--
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fc..f59614956f96 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -239,8 +239,6 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
-	int swappiness;
-
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
 	struct cgroup_file events_local_file;
@@ -318,6 +316,9 @@ struct mem_cgroup {
 	/* List of events which userspace want to receive */
 	struct list_head event_list;
 	spinlock_t event_list_lock;
+
+	int swappiness;
+
 #endif /* CONFIG_MEMCG_V1 */
 
 	struct mem_cgroup_per_node *nodeinfo[];
@@ -365,6 +366,9 @@ enum objext_flags {
 
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
 
+/* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
+extern int vm_swappiness;
+
 #ifdef CONFIG_MEMCG
 /*
  * After the initialization objcg->memcg is always pointing at
@@ -1440,6 +1444,23 @@ static inline void mem_cgroup_flush_workqueue(void) { }
 static inline int mem_cgroup_init(void) { return 0; }
 #endif /* CONFIG_MEMCG */
 
+static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_MEMCG_V1
+	/* Cgroup2 doesn't have per-cgroup swappiness */
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return READ_ONCE(vm_swappiness);
+
+	/* root ? */
+	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
+		return READ_ONCE(vm_swappiness);
+
+	return READ_ONCE(memcg->swappiness);
+#else
+	return READ_ONCE(vm_swappiness);
+#endif
+}
+
 /*
  * Extended information for slab objects stored as an array in page->memcg_data
  * if MEMCG_DATA_OBJEXTS is set.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3f31b6a56788..f27e73f29195 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -366,7 +366,6 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						pg_data_t *pgdat,
 						unsigned long *nr_scanned);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
-extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
@@ -530,25 +529,7 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 #ifdef CONFIG_MEMCG
-static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
-{
-	/* Cgroup2 doesn't have per-cgroup swappiness */
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return READ_ONCE(vm_swappiness);
-
-	/* root ? */
-	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
-		return READ_ONCE(vm_swappiness);
-
-	return READ_ONCE(memcg->swappiness);
-}
-
 void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid);
-#else
-static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
-{
-	return READ_ONCE(vm_swappiness);
-}
 #endif
 
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 938f190a98fe..2d659b76cd77 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4174,11 +4174,10 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
-		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
-
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
+		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 		memcg->memory.track_failcnt = !memcg_on_dfl;
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 		page_counter_init(&memcg->kmem, &parent->kmem, false);
-- 
2.34.1


