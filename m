Return-Path: <cgroups+bounces-15250-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPfoFC2S3Gl9TAkAu9opvQ
	(envelope-from <cgroups+bounces-15250-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 08:50:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995D3E7EDF
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 08:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C270300FB76
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 06:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6535F5E2;
	Mon, 13 Apr 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GGVCDxLE"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521C1FC101;
	Mon, 13 Apr 2026 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063015; cv=none; b=StyVufGPLEFhuWkLXG1u4/rpgfLwrBF/aimFqE6295bgdYfwb0rhE98uwnpuWFeQWLt+cK6zcuiESWUQ3C6cVaFJi1jA2yF0sMTJ3/OWUFS9UesAyIxOiU7tS4g0zr0cnTYx3CtnVM/I32VBe5OnrAJiqeY5XdOIOTS+WIVoueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063015; c=relaxed/simple;
	bh=1c+oQ5XqxvspiGn/S5QU54NrjGTo0h82WESWxud8Uko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtSA3FzkQ1nAn/aieczYykbjPEKWECXp3ahChLUB02NsZeEO+h4CxnfnhKX6KHtEdZPkKnhkp21vb0FKqiWDwJ+4xtO+5IAVdZU/POBSjhzA2xG7BaUwpIQoDNCmHZO2Vjn/zCF7q15/aSJWSHb+gHhT61o3Jwo1Iyg93LxP27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GGVCDxLE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zf
	duVNm09jkIhQ0je1BjJHQXUBdHMcI7s4tD6ILgtWg=; b=GGVCDxLE1P+Yqxfwm0
	FIWfflqakXtJXGvBj5M29AMd6A4wyG0laUlAIqT1BMsEbBAMSb/fftCbrEHJfjc6
	Ydr1Ma6Y7jXFibeb6nMLZKmx4V1sZMWotyiGtzDVINCgr83aITaNHvvalup6G6lk
	LJwZV+XFVS3hssr2Dtm3TABk4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3oOrOkdxp7MvIUw--.32984S2;
	Mon, 13 Apr 2026 14:48:52 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Cao Ruichuang <create0818@163.com>,
	syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com
Subject: [PATCH] mm/memcontrol: restore irq wrapper for lruvec_stat_mod_folio()
Date: Mon, 13 Apr 2026 14:48:33 +0800
Message-Id: <20260413064833.964-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3oOrOkdxp7MvIUw--.32984S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF45XF4UCw13ur4fKw1UGFg_yoWrAFWkpF
	4DKrs5C397JFyagF17Xw4qy345Z34IqrW5ZFWxWr4fZF9Iq343Kw1DKay7WFyUuFy8ZF4f
	X34jyrn3Xa1jvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zio5dtUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5xQrZGnckdRsXgAA3+
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15250-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[create0818@163.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kernel.org,oracle.com,google.com,vger.kernel.org,kvack.org,163.com,syzkaller.appspotmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 7995D3E7EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit c1bd09994c4d ("memcg: remove __lruvec_stat_mod_folio") removed
the local_irq_save/restore wrapper around lruvec_stat_mod_folio(), based
on the assumption that the underlying stat update path was already
IRQ-safe.

That assumption is too broad for lruvec_stat_mod_folio() callers.
This helper is not just a thin stat primitive.  It also resolves
folio -> memcg -> lruvec under a helper-managed RCU read-side section.

syzbot now reports a PREEMPT_RT warning from:

  __filemap_add_folio()
    -> lruvec_stat_mod_folio()
       -> __rcu_read_unlock()

ending in bad unlock balance / negative RCU nesting.

The PREEMPT_RT detail matters here.  The affected filemap path calls
lruvec_stat_mod_folio() under xas_lock_irq(), but on PREEMPT_RT
xas_lock_irq() maps to spin_lock_irq(), and spin_lock_irq() does not
disable hard IRQs.  Before c1bd09994c4d, lruvec_stat_mod_folio() still
provided explicit hard-IRQ masking around the folio-based memcg/lruvec
lookup path.  After that commit, those callers no longer get real
hard-IRQ masking from either the xarray lock or the helper itself.

Direct mod_lruvec_state() callers do not have the same problem surface:
they already operate on a stable lruvec under caller-provided locking or
caller-provided RCU coverage.  The narrower regression boundary is the
folio-based helper that combines ownership lookup with helper-managed
RCU.  Restore only that helper's irq wrapper instead of reverting the
lower-level lruvec state update cleanups.

This restores the previous calling contract for lruvec_stat_mod_folio()
without changing the lower-level lruvec state interfaces.

Fixes: c1bd09994c4d ("memcg: remove __lruvec_stat_mod_folio")
Link: https://syzkaller.appspot.com/bug?extid=1a3353a77896e73a8f53
Reported-by: syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 include/linux/vmstat.h | 18 +++++++++++++++++-
 mm/memcontrol.c        |  4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf78..59cf2676649 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -519,9 +519,19 @@ static inline const char *vm_event_name(enum vm_event_item item)
 void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 
-void lruvec_stat_mod_folio(struct folio *folio,
+void __lruvec_stat_mod_folio(struct folio *folio,
 			     enum node_stat_item idx, int val);
 
+static inline void lruvec_stat_mod_folio(struct folio *folio,
+					 enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__lruvec_stat_mod_folio(folio, idx, val);
+	local_irq_restore(flags);
+}
+
 static inline void mod_lruvec_page_state(struct page *page,
 					 enum node_stat_item idx, int val)
 {
@@ -536,6 +546,12 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
+static inline void __lruvec_stat_mod_folio(struct folio *folio,
+					 enum node_stat_item idx, int val)
+{
+	mod_node_page_state(folio_pgdat(folio), idx, val);
+}
+
 static inline void lruvec_stat_mod_folio(struct folio *folio,
 					 enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d15..ffe6ae885f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -787,7 +787,7 @@ void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
-void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
+void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
 	struct mem_cgroup *memcg;
@@ -807,7 +807,7 @@ void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 	mod_lruvec_state(lruvec, idx, val);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(lruvec_stat_mod_folio);
+EXPORT_SYMBOL(__lruvec_stat_mod_folio);
 
 void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
-- 
2.39.5 (Apple Git-154)


