Return-Path: <cgroups+bounces-14836-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLG6MrYnuWkAtAEAu9opvQ
	(envelope-from <cgroups+bounces-14836-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:06:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C912A7803
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C9E030F311B
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FA3A4528;
	Tue, 17 Mar 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LV7BfUkj"
X-Original-To: cgroups@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95563603FB;
	Tue, 17 Mar 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741694; cv=none; b=OYNWOKru9Kg5srhcaosjqTIgkqmSKhrhlsaaRZzeaXxuJL3//+Bmv+FE5AtGUATpLMlLuXmUfqxyUKcuDUMg3K+7fmfcbCPIogj3PbavkroeV04moeVu4u9K4kRSRNxVYmqNa9nWojXC09gWrGqhriQwWdKSvEaeO8R7Y4tz50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741694; c=relaxed/simple;
	bh=O6DQX1i3ghyPxBCoFPCcEj5ppTfZr3EyMPXH+i/RwS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMFVfHWihbLmPwiB4goE74ogIrSeir/dzB101Y9H9EwuHBVJQ3yvTkyUEFF2pFYlOjeui2dRnS6FRqzYGeEvTHi52zBvq1xnjfFXvYggtbpFC1ALHoHshdHsTSyhc6iE23PJhCrn2oceMi4b4py3BimuLvtt7xM4IwDOyhmw7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=LV7BfUkj; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D6069808C1;
	Tue, 17 Mar 2026 13:01:15 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:d39::1:8])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 61JriZ1AFGk0-wyXdH7ES;
	Tue, 17 Mar 2026 13:01:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1773741675;
	bh=JcziJH+Lgmx8myte1snEBSSR9HR2TBhqNDuBSlGHOoA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=LV7BfUkjTudv76BV+c8nj0F9NGOK+53stLPSGJDBxMyW79CcXtZw9ELdaxjVbRnEK
	 apHm+bnFS5FlwmAxnMnB/giJdvhqh9ZeLifT+Y8FKoGjg3Iy1JozOiTE71aWL50PkA
	 suomKgNL8Iyepf3E9lTsYHp2w7mK+RyKlxPwTmPY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yc-core@yandex-team.ru
Subject: [PATCH] mm: add memory.compact_unevictable_allowed cgroup attribute
Date: Tue, 17 Mar 2026 13:00:58 +0300
Message-Id: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14836-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:dkim,yandex-team.ru:email,yandex-team.ru:mid]
X-Rspamd-Queue-Id: 31C912A7803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current global sysctl compact_unevictable_allowed is too coarse.
In environments with mixed workloads, we may want to protect specific
important cgroups from compaction to ensure their stability and
responsiveness, while allowing compaction for others.

This patch introduces a per-memcg compact_unevictable_allowed attribute.
This allows granular control over whether unevictable pages in a specific
cgroup can be compacted. The global sysctl still takes precedence if set
to disallow compaction, but this new setting allows opting out specific
cgroups.

This also adds a new ISOLATE_UNEVICTABLE_CHECK_MEMCG flag to
isolate_migratepages_block to preserve the old behavior for the
ISOLATE_UNEVICTABLE flag unconditionally used by
isolage_migratepages_range.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/linux/memcontrol.h | 19 ++++++++++++++++++
 include/linux/mmzone.h     |  5 +++++
 mm/compaction.c            | 21 +++++++++++++++++---
 mm/memcontrol.c            | 40 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 70b685a85bf4..13b7ef6cf511 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -227,6 +227,12 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
+	/*
+	 * Is compaction allowed to take unevictable pages accounted to
+	 * this cgroup?
+	 */
+	bool compact_unevictable_allowed;
+
 	int swappiness;
 
 	/* memory.events and memory.events.local */
@@ -640,6 +646,14 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }
 
+static inline bool mem_cgroup_compact_unevictable_allowed(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled() || !memcg)
+		return true;
+
+	return READ_ONCE(memcg->compact_unevictable_allowed);
+}
+
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
 /**
@@ -1092,6 +1106,11 @@ static inline bool mem_cgroup_disabled(void)
 	return true;
 }
 
+static inline bool mem_cgroup_compact_unevictable_allowed(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e51190a55e4..dadc9b66efa1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -701,6 +701,11 @@ struct lruvec {
 #define ISOLATE_ASYNC_MIGRATE	((__force isolate_mode_t)0x4)
 /* Isolate unevictable pages */
 #define ISOLATE_UNEVICTABLE	((__force isolate_mode_t)0x8)
+/*
+ * Isolate unevictable pages, but honor the page's cgroup settings if it
+ * explicitly disallows unevictable isolation.
+ */
+#define ISOLATE_UNEVICTABLE_CHECK_MEMCG ((__force isolate_mode_t)0x10)
 
 /* LRU Isolation modes. */
 typedef unsigned __bitwise isolate_mode_t;
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..0dbb81aa5d2e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1098,8 +1098,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		is_unevictable = folio_test_unevictable(folio);
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
-			goto isolate_fail_put;
+		if (is_unevictable) {
+			if (mode & ISOLATE_UNEVICTABLE_CHECK_MEMCG) {
+				struct mem_cgroup *memcg;
+
+				rcu_read_lock();
+				memcg = folio_memcg_check(folio);
+
+				if (!mem_cgroup_compact_unevictable_allowed(memcg)) {
+					rcu_read_unlock();
+					goto isolate_fail_put;
+				}
+
+				rcu_read_unlock();
+			} else if (!(mode & ISOLATE_UNEVICTABLE))
+				goto isolate_fail_put;
+		}
 
 		/*
 		 * To minimise LRU disruption, the caller can indicate with
@@ -2049,7 +2063,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	unsigned long low_pfn;
 	struct page *page;
 	const isolate_mode_t isolate_mode =
-		(sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
+		(sysctl_compact_unevictable_allowed ?
+			ISOLATE_UNEVICTABLE_CHECK_MEMCG : 0) |
 		(cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
 	bool fast_find_block;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d155..bd0230d93dd8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3839,6 +3839,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	WRITE_ONCE(memcg->compact_unevictable_allowed,
+		mem_cgroup_compact_unevictable_allowed(parent));
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
@@ -4608,6 +4610,37 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_compact_unevictable_allowed_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->compact_unevictable_allowed));
+
+	return 0;
+}
+
+static ssize_t memory_compact_unevictable_allowed_write(
+	struct kernfs_open_file *of, char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, allowed;
+
+	buf = strstrip(buf);
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtoint(buf, 0, &allowed);
+	if (ret)
+		return ret;
+
+	if (allowed != 0 && allowed != 1)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->compact_unevictable_allowed, allowed);
+
+	return nbytes;
+}
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -4692,6 +4725,13 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	{
+		.name = "compact_unevictable_allowed",
+		/* For root use /proc/sys/vm/compact_unevictable_allowed */
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_compact_unevictable_allowed_show,
+		.write = memory_compact_unevictable_allowed_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.34.1


