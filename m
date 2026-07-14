Return-Path: <cgroups+bounces-17778-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLK7M84qVmo40gAAu9opvQ
	(envelope-from <cgroups+bounces-17778-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:25:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314AC754812
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=honor.com header.s=dkim header.b=bm6kt+pb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17778-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17778-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=honor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9073203344
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF3C1085;
	Tue, 14 Jul 2026 12:15:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B403BF68E;
	Tue, 14 Jul 2026 12:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031346; cv=none; b=d1OZhmTByxhpIV69xMPIyWGs9pEqiDDUtNeaofjYWur4SY/oLxwNcUMq6dEMyyabFxD/uMS7YHpOg6wEFytI7sBfa2qqoqa5xcQuva3slsA3p/VfkKZe83MxUeaBeIkSTX8xZk7vFvvNSofnYI1Ocu8eSMLhtpYYQch6TUoVgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031346; c=relaxed/simple;
	bh=AxrVQYJ2HupDfKvNptWjmg28qti3Iy59r7OC4/bVxqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAj2/aHqYHiQufVdgvuLY9fofXHhdOodCoYtL+fqkS0NEsbdClfik8tTt0y/B9BKEl4leyUpeYXVfwxE+Y7sVtvrG2F1syRyV146pB2R+aVZ8vTFv0CawYgxOofnGYMoAvrBHiF5Y777xWOnlQG5rcdMEn8gpzOVHmGYwZS6ebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=bm6kt+pb; arc=none smtp.client-ip=81.70.192.198
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=ajWSzJC8ZX5c1v8s4BktWV/r3nVerPCf8q26E0mJDVo=;
	b=bm6kt+pb2YDJ5eFS0HrJFxTuF9vH6LOkgpTUnkcRQTtLsSA/bEK9RLS/PrwpIVrNghjNzIqy2
	SFBNTEKjWgbRLxSRRmvtZukmApB7kuHnmFJIgDjsFRX+4lgotpouNZW4YA5qOASCYC6UFRzhqnM
	2uuiYcIdTBtzmE4M9vyA7OI=
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gzytq1bcMzYlJxV;
	Tue, 14 Jul 2026 20:15:31 +0800 (CST)
Received: from TA012-1.hihonor.com (10.77.199.132) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 20:15:31 +0800
Received: from localhost.localdomain (10.144.5.36) by TA012-1.hihonor.com
 (10.77.199.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Jul
 2026 20:15:20 +0800
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
Subject: [RFC v2 3/3] mm/lru_gen: expose oldest-generation page counts in memory.stat
Date: Tue, 14 Jul 2026 20:15:29 +0800
Message-ID: <20260714121529.2237261-4-wangzicheng@honor.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[honor.com,none];
	R_DKIM_ALLOW(-0.20)[honor.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-17778-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yuanchu@google.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:willy@infradead.org,m:denghaojie@honor.com,m:baoquan.he@linux.dev,m:kaleshsingh@google.com,m:tjmercier@google.com,m:tao.wangtao@honor.com,m:zhangji1@honor.com,m:wangzhen5@honor.com,m:wangzicheng@honor.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[honor.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,honor.com:from_mime,honor.com:mid,honor.com:email,honor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 314AC754812

Add nr_oldest_anon and nr_oldest_file to memory.stat: pages in the
oldest generation (min_seq) of each type, aggregated over the cgroup
subtree and all N_MEMORY nodes.  This is the observation half of the
proactive-aging loop - it shows a policy how much anon/file memory the
next reclaim can evict directly, so it can decide whether aging is
needed.

Computed on demand from lrugen->nr_pages; no per-page maintenance, no
hot-path cost.  Paired with the AGING counter and workingset_refault_*
to confirm an aging pass took effect and was not too aggressive.

Gated by CONFIG_LRU_GEN; reported in pages, matching the lru_gen dump.

Signed-off-by: Zicheng Wang <wangzicheng@honor.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++++++++
 mm/internal.h                           |  2 ++
 mm/memcontrol.c                         | 24 +++++++++++++++++++++
 mm/vmscan.c                             | 28 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f42ac6dddbf6..a071175d11be 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1658,6 +1658,24 @@ The following nested keys are defined.
 		the value for the foo counter, since the foo counter is type-based, not
 		list-based.
 
+	  nr_oldest_anon, nr_oldest_file
+		Number of pages in the oldest generation of the anonymous and
+		file types. Only present when CONFIG_LRU_GEN is enabled.
+
+		With MGLRU, page reclaim starts from the oldest generation
+		(min_seq) of each type, so these counts show how much anonymous
+		and file memory the next reclaim pass (or a proactive
+		memory.reclaim) can directly evict. They are aggregated across
+		this cgroup's subtree and all NUMA nodes, and are reported in
+		pages, matching the per-generation breakdown in the ``lru_gen``
+		debugfs file.
+
+		Proactive-aging policy can use them together with the ``aging``
+		counter and ``workingset_refault_*``: a large ``nr_oldest_file``
+		with near-zero ``nr_oldest_anon`` indicates file cache piling up
+		in the oldest generation while anonymous pages stay young, which
+		is the condition ``memory.aging`` is meant to rebalance.
+
 	  slab_reclaimable
 		Part of "slab" that might be reclaimed, such as
 		dentries and inodes.
diff --git a/mm/internal.h b/mm/internal.h
index 96add6cd4627..959d376c02a6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -636,6 +636,8 @@ int user_proactive_reclaim(char *buf,
 
 #ifdef CONFIG_LRU_GEN
 int lru_gen_age_memcg(struct mem_cgroup *memcg, unsigned long nr_gens);
+void lru_gen_nr_oldest_pages(struct lruvec *lruvec,
+			     unsigned long *nr_anon, unsigned long *nr_file);
 #endif
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c6a969b56878..016194cabd60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1733,6 +1733,30 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		}
 	}
 
+#ifdef CONFIG_LRU_GEN
+	/* Oldest-generation (min_seq) anon/file pages over this cgroup's
+	 * subtree and all N_MEMORY nodes; see lru_gen_nr_oldest_pages().
+	 */
+	{
+		struct mem_cgroup *mi;
+		int nid;
+		unsigned long oldest_anon = 0, oldest_file = 0;
+
+		for_each_mem_cgroup_tree(mi, memcg) {
+			for_each_node_state(nid, N_MEMORY) {
+				unsigned long nr_anon, nr_file;
+				struct lruvec *lruvec = mem_cgroup_lruvec(mi, NODE_DATA(nid));
+
+				lru_gen_nr_oldest_pages(lruvec, &nr_anon, &nr_file);
+				oldest_anon += nr_anon;
+				oldest_file += nr_file;
+			}
+		}
+		seq_buf_printf(s, "nr_oldest_anon %lu\n", oldest_anon);
+		seq_buf_printf(s, "nr_oldest_file %lu\n", oldest_file);
+	}
+#endif
+
 	/* Accumulated memory events */
 	seq_buf_printf(s, "pgscan %lu\n",
 		       memcg_page_state(memcg, PGSCAN_KSWAPD) +
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 805e29c499c8..3800f0c4f1f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5935,6 +5935,34 @@ int lru_gen_age_memcg(struct mem_cgroup *memcg, unsigned long nr_gens)
 	return ret;
 }
 
+/**
+ * lru_gen_nr_oldest_pages - pages in the oldest generation of a lruvec
+ * @lruvec: target lruvec
+ * @nr_anon: filled with oldest-generation anonymous page count
+ * @nr_file: filled with oldest-generation file page count
+ *
+ * Reclaim starts from the oldest generation (min_seq) of each type, so these
+ * count what the next reclaim can evict directly.  Computed from
+ * lrugen->nr_pages[min_seq type][zone]; eventually consistent, clamped to 0.
+ */
+void lru_gen_nr_oldest_pages(struct lruvec *lruvec,
+			     unsigned long *nr_anon, unsigned long *nr_file)
+{
+	int type, zone;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	unsigned long size[ANON_AND_FILE] = {};
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		int gen = lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
+
+		for (zone = 0; zone < MAX_NR_ZONES; zone++)
+			size[type] += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+	}
+
+	*nr_anon = size[LRU_GEN_ANON];
+	*nr_file = size[LRU_GEN_FILE];
+}
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
-- 
2.25.1


