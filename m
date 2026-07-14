Return-Path: <cgroups+bounces-17776-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GFEgBrcpVmrJ0QAAu9opvQ
	(envelope-from <cgroups+bounces-17776-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:21:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F071D75473F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17776-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17776-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=honor.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C7293022A40
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428D83C0606;
	Tue, 14 Jul 2026 12:15:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD53BED42;
	Tue, 14 Jul 2026 12:15:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031343; cv=none; b=dZ47tgDSKHTdUA0MzOobAJ/vBlkVPFPj574mJXxDR/2EJ/mYDTC+Md/LpZMLilH4uDHXheJllryXZh0cAy5l+8KVAX+zW+ikb+qrKpkgnRtbN0bmahFIrf7GLwnqCROvI85ichzEFLq57P9s0f+KupQyGUNBimWIWRCvnqOirYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031343; c=relaxed/simple;
	bh=K5trL+Ani1qoBuWhLNtvjSFzEzNw+uYS2pyP1NmYRrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjSi4jXPtSfpw/F3rokhaWv80n6Qoj+qOrrNrWQWfDlO+pbrSDLgcN66jk8N3riVqJIF1SRPkLK04t9jX639J/FaWwGHdC+JyRpXiX2Hgf44Q1IY6voeyo6Dp5qMuws8prJ0rTqXqzRAJhXbac1OISNe+GGQUmAk87Ci2zGdSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gzytp3XY4zYlLgc;
	Tue, 14 Jul 2026 20:15:30 +0800 (CST)
Received: from TA012-1.hihonor.com (10.77.199.132) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 20:15:28 +0800
Received: from localhost.localdomain (10.144.5.36) by TA012-1.hihonor.com
 (10.77.199.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Jul
 2026 20:15:19 +0800
From: Zicheng Wang <wangzicheng@honor.com>
To: <akpm@linux-foundation.org>, <yuanchu@google.com>
CC: <tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<corbet@lwn.net>, <kasong@tencent.com>, <qi.zheng@linux.dev>,
	<shakeel.butt@linux.dev>, <baohua@kernel.org>, <axelrasmussen@google.com>,
	<weixugc@google.com>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <roman.gushchin@linux.dev>,
	<muchun.song@linux.dev>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<willy@infradead.org>, <denghaojie@honor.com>, <baoquan.he@linux.dev>,
	<kaleshsingh@google.com>, <tjmercier@google.com>, <tao.wangtao@honor.com>,
	<zhangji1@honor.com>, <wangzhen5@honor.com>, Zicheng Wang
	<wangzicheng@honor.com>
Subject: [RFC v2 1/3] mm/lru_gen: add AGING counter and proactive aging helper
Date: Tue, 14 Jul 2026 20:15:27 +0800
Message-ID: <20260714121529.2237261-2-wangzicheng@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714121529.2237261-1-wangzicheng@honor.com>
References: <20260714121529.2237261-1-wangzicheng@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TW004-1.hihonor.com (10.77.232.85) To TA012-1.hihonor.com
 (10.77.199.132)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[honor.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17776-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yuanchu@google.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:willy@infradead.org,m:denghaojie@honor.com,m:baoquan.he@linux.dev,m:kaleshsingh@google.com,m:tjmercier@google.com,m:tao.wangtao@honor.com,m:zhangji1@honor.com,m:wangzhen5@honor.com,m:wangzicheng@honor.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,honor.com:from_mime,honor.com:email,honor.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F071D75473F

Add the two pieces the rest of the series builds on: an AGING node
stat counter (the observation an aging policy pairs with
workingset_refault to spot over-aging) and a reusable helper,
lru_gen_age_memcg(), that ages a memcg by advancing max_seq without
reclaim (the control primitive memory.aging wraps).

The counter counts every pass in inc_max_seq(), regardless of caller.
The helper mirrors lru_gen_seq_write()'s reclaim_state /
memalloc_noreclaim / mm_walk setup; swappiness comes from
get_swappiness() so anon is not rotated without swap, and a racing
lruvec is skipped (-EAGAIN) without blocking other nodes.

Gated by CONFIG_LRU_GEN.  No user-visible change yet.

Signed-off-by: Zicheng Wang <wangzicheng@honor.com>
---
 include/linux/mmzone.h |  3 ++
 mm/internal.h          |  4 +++
 mm/memcontrol.c        |  9 +++++
 mm/vmscan.c            | 80 ++++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c            |  3 ++
 5 files changed, 99 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da5..ab5137c272ca 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -323,6 +323,9 @@ enum node_stat_item {
 	PGSCAN_ANON,
 	PGSCAN_FILE,
 	PGREFILL,
+#ifdef CONFIG_LRU_GEN
+	AGING,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..96add6cd4627 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -634,6 +634,10 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
 int user_proactive_reclaim(char *buf,
 			   struct mem_cgroup *memcg, pg_data_t *pgdat);
 
+#ifdef CONFIG_LRU_GEN
+int lru_gen_age_memcg(struct mem_cgroup *memcg, unsigned long nr_gens);
+#endif
+
 /*
  * in mm/rmap.c:
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d978e18b9b2d..e42f97e004b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -420,6 +420,9 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGSCAN_ANON,
 	PGSCAN_FILE,
 	PGREFILL,
+#ifdef CONFIG_LRU_GEN
+	AGING,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
@@ -1606,6 +1609,9 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
 #endif
+#ifdef CONFIG_LRU_GEN
+	{ "aging",		AGING	},
+#endif
 };
 
 /* The actual unit of the state item, not the same as the output unit */
@@ -1655,6 +1661,9 @@ static int memcg_page_state_output_unit(int item)
 	case PGSCAN_KHUGEPAGED:
 	case PGSCAN_PROACTIVE:
 	case PGREFILL:
+#ifdef CONFIG_LRU_GEN
+	case AGING:
+#endif
 #ifdef CONFIG_NUMA_BALANCING
 	case PGPROMOTE_SUCCESS:
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b3e555561417..805e29c499c8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3987,6 +3987,9 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+
+	/* Count every aging pass for over-aging diagnosis. */
+	mod_lruvec_state(lruvec, AGING, 1);
 unlock:
 	lruvec_unlock_irq(lruvec);
 
@@ -5855,6 +5858,83 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
 
+/**
+ * lru_gen_age_memcg - Proactively age a memcg by N generations
+ * @memcg: target memcg
+ * @nr_gens: number of generations to age (1..MAX_NR_GENS)
+ *
+ * Advances max_seq without page reclaim on all nodes of @memcg, using
+ * the same lock/walk protocol as lru_gen_seq_write().  Swappiness comes
+ * from get_swappiness() so anon rotation is skipped without swap.
+ * to the next node.
+ *
+ * Return: 0 on success, -EINVAL on bad input, -EAGAIN if a lruvec did
+ * not advance, -ENOMEM on mm_walk failure, -EINTR on signal.
+ */
+int lru_gen_age_memcg(struct mem_cgroup *memcg, unsigned long nr_gens)
+{
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+		.proactive = true,
+	};
+	int nid, swappiness;
+	unsigned long i;
+	int ret = 0;
+	unsigned int flags;
+	struct blk_plug plug;
+	struct lruvec *lruvec;
+
+	if (!memcg)
+		return -EINVAL;
+
+	if (nr_gens == 0 || nr_gens > MAX_NR_GENS)
+		return -EINVAL;
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+	flags = memalloc_noreclaim_save();
+	blk_start_plug(&plug);
+	if (!set_mm_walk(NULL, true)) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto done;
+		}
+
+		lruvec = get_lruvec(memcg, nid);
+		if (!lruvec)
+			continue;
+
+		swappiness = get_swappiness(lruvec, &sc);
+
+		for (i = 0; i < nr_gens; i++) {
+			DEFINE_MAX_SEQ(lruvec);
+
+			if (!try_to_inc_max_seq(lruvec, max_seq,
+						swappiness, false)) {
+				ret = -EAGAIN;
+				break;
+			}
+		}
+
+		cond_resched();
+	}
+
+done:
+	clear_mm_walk();
+	blk_finish_plug(&plug);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+	return ret;
+}
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..78ea093428c7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1290,6 +1290,9 @@ const char * const vmstat_text[] = {
 	[I(PGSCAN_ANON)]			= "pgscan_anon",
 	[I(PGSCAN_FILE)]			= "pgscan_file",
 	[I(PGREFILL)]				= "pgrefill",
+#ifdef CONFIG_LRU_GEN
+	[I(AGING)]			= "aging",
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-- 
2.25.1


