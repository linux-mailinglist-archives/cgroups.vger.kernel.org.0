Return-Path: <cgroups+bounces-14373-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHmLHlYjn2mPZAQAu9opvQ
	(envelope-from <cgroups+bounces-14373-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:29:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379B19AA2E
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9615B307AFF5
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9FC2ED846;
	Wed, 25 Feb 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7IbmXIw"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A013806AD
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036609; cv=none; b=hOcE2Ln/xKlOcpp+Da6LAGzOKqC5Rw28JrWvZj1bhF5dHQyvRL89zVf+07jLqofzY08EYBrjmbCN9fpA5gXGzuS039qlX/qAllDxE59xVHWKWKbG3o+1hrS2FK8abk0/GRZhYVuuyNvm42e4nZsAp+p+IEkE5jxSnuwGSMsAgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036609; c=relaxed/simple;
	bh=0fkZhn6yZmrbUSMPtreEX8vJcDIgtcXmAflDN4CbTwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RllgOpHvAv5w98sdUeO4EWTBH9K3PZ08maGAhDtjLPVQHk4mp1/5/YqEhlTAlxJMSroLhZjaG9OWymzb0JdPX+pSs8ZQzqBx5rd4iv9ldQ/JpgzhdLsl0029ttWV/tVF14pnpxWztQLd5hqhzfJPA4BpzxMdoIpi4ijjUu4ve08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P7IbmXIw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+00XNNy3xKzd0oEXtdRXCr3SQsysWVmAOu1hobMNKdc=; b=P7IbmXIwZtyE5OQxnBdjckNY8C
	4Zuk08aWMGTKp+JopyVLEXINpIAkr0i+j+1BVVwHbP5/KHfLay3/rAr8ymGGXp4XDQ1id1t4J/EI0
	FBtB3lf+QeLEM5SNYqTeB2D7oo5W7x9M+GnPBCs/wEY+46n/7JeRtYrFJGIRYcjYwXTdm7WqeOH6j
	NvGciAVHFwU/Nq1PmiG237ZA8tbQpPwTWcA0ixRCvNXrhpr7tkPM3AE1cn4PcOO2dCWtCPu2QfhDu
	9+Ai6ePkPAn+XFoyxycKLLLbTcTxsS9TMHOFWaPUIeMOh8aixmZteNMgHxBXHdiSWPRg/iWC/TNQ6
	4Gn1YIjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHfV-00000001K4o-2W75;
	Wed, 25 Feb 2026 16:23:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/3] memcg: Add memcg_stat_mod()
Date: Wed, 25 Feb 2026 16:22:15 +0000
Message-ID: <20260225162319.315281-2-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225162319.315281-1-willy@infradead.org>
References: <20260225162319.315281-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14373-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 0379B19AA2E
X-Rspamd-Action: no action

This function lets the caller find the memcg somewhere other than
page->memcg_data.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/vmstat.h |  9 ++++++++-
 mm/memcontrol.c        | 23 +++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..0da38ea25c97 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -518,7 +518,8 @@ static inline const char *vm_event_name(enum vm_event_item item)
 
 void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
-
+void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val);
 void lruvec_stat_mod_folio(struct folio *folio,
 			     enum node_stat_item idx, int val);
 
@@ -536,6 +537,12 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
+static inline void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val)
+{
+	mod_node_page_state(pgdat, idx, val);
+}
+
 static inline void lruvec_stat_mod_folio(struct folio *folio,
 					 enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a52da3a5e4fd..b356ef312bc2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -787,24 +787,27 @@ void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
+void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val)
+{
+	/* Untracked pages have no memcg, no lruvec. Update only the node */
+	if (!memcg) {
+		mod_node_page_state(pgdat, idx, val);
+	} else {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		mod_lruvec_state(lruvec, idx, val);
+	}
+}
+
 void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
 	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = folio_pgdat(folio);
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	memcg = folio_memcg(folio);
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg) {
-		rcu_read_unlock();
-		mod_node_page_state(pgdat, idx, val);
-		return;
-	}
-
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_lruvec_state(lruvec, idx, val);
+	memcg_stat_mod(memcg, pgdat, idx, val);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(lruvec_stat_mod_folio);
-- 
2.47.3


