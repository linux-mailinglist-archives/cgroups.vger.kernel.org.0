Return-Path: <cgroups+bounces-13345-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CISXHYbLcGkOaAAAu9opvQ
	(envelope-from <cgroups+bounces-13345-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C25711B
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D09E4969
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704B48AE0E;
	Wed, 21 Jan 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXaeL+YP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3548166B;
	Wed, 21 Jan 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999221; cv=none; b=tPwoxBKVKar5bR2qiMOXisAtzGampz2bDcZyIogUNfvJQgLzAy1RJlI9yVsAjklEXVF5DlwkBmiwKG1ECGEErXvFoJ8y69812hxSSQZtYVLKDn8gfSYSd0gC+e/AYJD43Saw+aBskVd7Sro35reKtCydpsUoa0BPf9K47/nrAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999221; c=relaxed/simple;
	bh=o2PQazJGiOOsfBalbp7C2mvB9kNuqvABUGRvq8ihU8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIhmXZOXzqrghwE9S9uQBCWGx78t1aVGd7YvPvUbPEmF8McdYweJWFPjEwY/zX3E0Y+9h7+816Kf+wVV6cjkQVAi+algbx6GRCwbmD9JxXlm/HXEgKu5iFggaeTXtmGLFn+ysJBbj+DaJKthm8U8wQqM554mgxCPiscmnFPrhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXaeL+YP; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768999215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/OqE0ydtm9JkTAiuYuoK4hbHLjWKG5nWVyw4vzq10Y=;
	b=FXaeL+YPA/JmFJNJXBNvEweyQrlFdOfXe48axrvpijrU//10I6yRcz2r0gEpEw/qP/JWeW
	t8KRG2OxI5b5PhB9BBxnR1zwPG6G2ieHEW46c6c6HTk0bz9Etrn9GRQi4P1dm8p1saIdJu
	YNOBF1YssN94gM/XXAVWojOZGtqtIdI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm/lru_gen: refactor to extract helper functions
Date: Wed, 21 Jan 2026 20:39:47 +0800
Message-ID: <20260121123955.84806-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260121123955.84806-1-jiayuan.chen@linux.dev>
References: <20260121123955.84806-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13345-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,shopee.com:email]
X-Rspamd-Queue-Id: D85C25711B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Extract helper functions from debugfs interface for code reuse:

- lru_gen_print_lruvec(): Print generations for a single lruvec,
  extracted from lru_gen_seq_show().

- __run_cmd(): Core command execution logic, extracted from run_cmd().

These helpers will be used by the upcoming memcg interface.
No functional change.

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/vmscan.c | 82 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 619691aa4393..8ea5b67daa36 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5397,29 +5397,13 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	seq_putc(m, '\n');
 }
 
-/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
-static int lru_gen_seq_show(struct seq_file *m, void *v)
+/* Print generations for a single lruvec - helper for debugfs and memcg */
+static void lru_gen_print_lruvec(struct seq_file *m, struct lruvec *lruvec,
+				 unsigned long max_seq, unsigned long *min_seq,
+				 bool full)
 {
 	unsigned long seq;
-	bool full = debugfs_get_aux_num(m->file);
-	struct lruvec *lruvec = v;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	int nid = lruvec_pgdat(lruvec)->node_id;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
-	DEFINE_MAX_SEQ(lruvec);
-	DEFINE_MIN_SEQ(lruvec);
-
-	if (nid == first_memory_node) {
-		const char *path = memcg ? m->private : "";
-
-#ifdef CONFIG_MEMCG
-		if (memcg)
-			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
-#endif
-		seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg), path);
-	}
-
-	seq_printf(m, " node %5d\n", nid);
 
 	if (!full)
 		seq = evictable_min_seq(min_seq, MAX_SWAPPINESS / 2);
@@ -5431,7 +5415,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	for (; seq <= max_seq; seq++) {
 		int type, zone;
 		int gen = lru_gen_from_seq(seq);
-		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+		unsigned long birth = READ_ONCE(lrugen->timestamps[gen]);
 
 		seq_printf(m, " %10lu %10u", seq, jiffies_to_msecs(jiffies - birth));
 
@@ -5450,7 +5434,31 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 		if (full)
 			lru_gen_seq_show_full(m, lruvec, max_seq, min_seq, seq);
 	}
+}
+
+/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
+static int lru_gen_seq_show(struct seq_file *m, void *v)
+{
+	bool full = debugfs_get_aux_num(m->file);
+	struct lruvec *lruvec = v;
+	int nid = lruvec_pgdat(lruvec)->node_id;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	if (nid == first_memory_node) {
+		const char *path = memcg ? m->private : "";
+
+#ifdef CONFIG_MEMCG
+		if (memcg)
+			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
+#endif
+		seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg), path);
+	}
 
+	seq_printf(m, " node %5d\n", nid);
+
+	lru_gen_print_lruvec(m, lruvec, max_seq, min_seq, full);
 	return 0;
 }
 
@@ -5501,6 +5509,24 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 	return -EINTR;
 }
 
+/* Core command execution - helper for debugfs and memcg */
+static int __run_cmd(char cmd, struct lruvec *lruvec, unsigned long seq,
+		     struct scan_control *sc, int swappiness, unsigned long opt)
+{
+	if (swappiness < MIN_SWAPPINESS)
+		swappiness = get_swappiness(lruvec, sc);
+	else if (swappiness > SWAPPINESS_ANON_ONLY)
+		return -EINVAL;
+
+	switch (cmd) {
+	case '+':
+		return run_aging(lruvec, seq, swappiness, opt);
+	case '-':
+		return run_eviction(lruvec, seq, sc, swappiness, opt);
+	}
+	return -EINVAL;
+}
+
 static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 		   struct scan_control *sc, int swappiness, unsigned long opt)
 {
@@ -5530,19 +5556,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 	sc->target_mem_cgroup = memcg;
 	lruvec = get_lruvec(memcg, nid);
 
-	if (swappiness < MIN_SWAPPINESS)
-		swappiness = get_swappiness(lruvec, sc);
-	else if (swappiness > SWAPPINESS_ANON_ONLY)
-		goto done;
-
-	switch (cmd) {
-	case '+':
-		err = run_aging(lruvec, seq, swappiness, opt);
-		break;
-	case '-':
-		err = run_eviction(lruvec, seq, sc, swappiness, opt);
-		break;
-	}
+	err = __run_cmd(cmd, lruvec, seq, sc, swappiness, opt);
 done:
 	mem_cgroup_put(memcg);
 
-- 
2.43.0


