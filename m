Return-Path: <cgroups+bounces-17210-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MQhMNExLO2rCVggAu9opvQ
	(envelope-from <cgroups+bounces-17210-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:13:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE316BB0BF
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17210-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17210-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B18030B2271
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 03:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1C30ACF1;
	Wed, 24 Jun 2026 03:12:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D6305699;
	Wed, 24 Jun 2026 03:11:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270720; cv=none; b=PUapFakAwUjCGn7358VeVCgfjEkNZ0ld42kRyZ5nChUl2yHn84a4qQ+SsJVZKn/U2lsBUiFB/jolX1bWIL9iNA9rXCT2IGM+IzLs2jRXhoBW4k9D24aqNt8yLjF6Pfn0sNCnaTE1HfxJ8QfoaowJoEfzJUATpmkljDxQx+iM3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270720; c=relaxed/simple;
	bh=JdtE9Xz96GG+EHD8dfofoRF3gyFyNgYRVXos3jUb+G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnfiftogAIHTUfbJBIkWfN0Ba4xVUqwqYiNbMNYmhggq7q2gyTaj+Tqf/3k75t9wfqFgTTrxI9goVhXD2Q2h7pf6u4/hnDnesiFHzoyoaNNv86BFL3D87HNpwCNq4FK2YgbcI4tRhUH/S7i8rgyPwAwAU/FqooqO1XSUD36xZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 7405c4f86f7a11f1aa26b74ffac11d73-20260624
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bdff6945-937d-4e63-b654-f929663874c6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:bdff6945-937d-4e63-b654-f929663874c6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:836d8f13f4505d5698e1a3767275bdb6,BulkI
	D:2606241111567D7I5HI8,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7405c4f86f7a11f1aa26b74ffac11d73-20260624
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 642929655; Wed, 24 Jun 2026 11:11:54 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH 2/2] cgroup/dmem: introduce dmem.events.local for local counts
Date: Wed, 24 Jun 2026 11:11:07 +0800
Message-Id: <20260624031107.667253-3-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624031107.667253-1-lihongfu@kylinos.cn>
References: <20260624031107.667253-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:lihongfu@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17210-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dmem.events:url,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CE316BB0BF

Add dmem.events.local for local-only low/max event counts per DMEM
region.  Refactor the shared events show logic used by dmem.events.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst |  5 ++--
 kernel/cgroup/dmem.c                    | 32 +++++++++++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index afc924539a41..5e4dbe4a75c6 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2881,7 +2881,7 @@ DMEM Interface Files
 	  drm/0000:03:00.0/vram0 12550144
 	  drm/0000:03:00.0/stolen 8650752
 
-  dmem.events
+  dmem.events, dmem.events.local
 	A read-only file that reports the number of times each cgroup
 	has hit its configured memory limits.  The format lists each
 	region on a single line, followed by the event counters::
@@ -2894,7 +2894,8 @@ DMEM Interface Files
 	``max`` counts how many times an allocation failed because the
 	cgroup or one of its ancestors hit ``dmem.max``.
 
-	``dmem.events`` contains hierarchical counts.  This file exists
+	``dmem.events`` contains hierarchical counts.  ``dmem.events.local``
+	contains counts for only the cgroup itself.  These files exist
 	for all cgroups except root.
 
 HugeTLB
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 79d4c5d0a046..29f8719561e6 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -60,6 +60,7 @@ struct dmemcg_state {
 	struct list_head pools;
 
 	struct cgroup_file events_file;
+	struct cgroup_file events_local_file;
 };
 
 enum dmemcg_memory_event {
@@ -84,6 +85,7 @@ struct dmem_cgroup_pool_state {
 	struct dmem_cgroup_pool_state *parent;
 
 	atomic_long_t events[DMEMCG_NR_EVENTS];
+	atomic_long_t events_local[DMEMCG_NR_EVENTS];
 
 	refcount_t ref;
 	bool inited;
@@ -196,6 +198,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 static void dmemcg_memory_event(struct dmem_cgroup_pool_state *pool,
 				enum dmemcg_memory_event event)
 {
+	atomic_long_inc(&pool->events_local[event]);
+	cgroup_file_notify(&pool->cs->events_local_file);
+
 	for (; pool; pool = pool->parent) {
 		atomic_long_inc(&pool->events[event]);
 		cgroup_file_notify(&pool->cs->events_file);
@@ -203,11 +208,14 @@ static void dmemcg_memory_event(struct dmem_cgroup_pool_state *pool,
 }
 
 static long dmemcg_get_event(struct dmem_cgroup_pool_state *pool,
-			     enum dmemcg_memory_event event)
+			     enum dmemcg_memory_event event, bool local)
 {
 	if (!pool)
 		return 0;
 
+	if (local)
+		return atomic_long_read(&pool->events_local[event]);
+
 	return atomic_long_read(&pool->events[event]);
 }
 
@@ -874,7 +882,7 @@ static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
 	return dmemcg_limit_show(sf, v, get_resource_max);
 }
 
-static int dmem_cgroup_region_events_show(struct seq_file *sf, void *v)
+static int dmemcg_events_show(struct seq_file *sf, void *v, bool local)
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(seq_css(sf));
 	struct dmem_cgroup_region *region;
@@ -885,14 +893,24 @@ static int dmem_cgroup_region_events_show(struct seq_file *sf, void *v)
 
 		seq_puts(sf, region->name);
 		seq_printf(sf, " low %ld max %ld\n",
-			   dmemcg_get_event(pool, DMEMCG_LOW),
-			   dmemcg_get_event(pool, DMEMCG_MAX));
+			   dmemcg_get_event(pool, DMEMCG_LOW, local),
+			   dmemcg_get_event(pool, DMEMCG_MAX, local));
 	}
 	rcu_read_unlock();
 
 	return 0;
 }
 
+static int dmem_cgroup_region_events_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_events_show(sf, v, false);
+}
+
+static int dmem_cgroup_region_events_local_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_events_show(sf, v, true);
+}
+
 static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
 				      char *buf, size_t nbytes, loff_t off)
 {
@@ -933,6 +951,12 @@ static struct cftype files[] = {
 		.file_offset = offsetof(struct dmemcg_state, events_file),
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "events.local",
+		.seq_show = dmem_cgroup_region_events_local_show,
+		.file_offset = offsetof(struct dmemcg_state, events_local_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ } /* Zero entry terminates. */
 };
 
-- 
2.25.1


