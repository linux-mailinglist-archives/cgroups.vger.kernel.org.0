Return-Path: <cgroups+bounces-17209-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bwjbNwZLO2qgVggAu9opvQ
	(envelope-from <cgroups+bounces-17209-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:12:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78946BB0A5
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17209-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17209-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 942B7300D564
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67461307AC6;
	Wed, 24 Jun 2026 03:11:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBF2F531B;
	Wed, 24 Jun 2026 03:11:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270719; cv=none; b=ghSXNQFD+YqZFI5L5VCvZR+fKUQ2S2qv9otAX7vlBDTczyc1ROWYOZre+VJgzluvbWUQeDLZnCQvSVupSZm9zE43QATg5ax0gb+dnG6skbEdO+ajV7w+qvTVBzuUFeNbwLTuI434EZAPei98BY6h8ybRRYeW+EorCbGr3evk2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270719; c=relaxed/simple;
	bh=4qsavpkirUKzNMJEcaHG5o0RN6XEfcnBqWib6V2oumM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wvi8S6YWe+/iniI/gJc9UREJf2c6smhWl5F4gKazzZGAtxsyndWavwe4dckJkJvggqm9RjHCaxkqwV+xI+xCZ0AVVJOq8HMbEFMMk7tCwBflnkaKXsPabaag5aUcFgmPz7KeFIjxoIaihOdkm1aHMEKmDWlBJxvRDNPNTaZCBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 7270852e6f7a11f1aa26b74ffac11d73-20260624
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1a7d0415-8cb6-437d-9ab6-1ae93295b15c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:1a7d0415-8cb6-437d-9ab6-1ae93295b15c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:b1868db27b4e9bc5e0410cfea7783c84,BulkI
	D:260624111150J8X2XGI2,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7270852e6f7a11f1aa26b74ffac11d73-20260624
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 319534201; Wed, 24 Jun 2026 11:11:52 +0800
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
Subject: [PATCH 1/2] cgroup/dmem: add per-region event counters
Date: Wed, 24 Jun 2026 11:11:06 +0800
Message-Id: <20260624031107.667253-2-lihongfu@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17209-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,dmem.events:url,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D78946BB0A5

Add dmem.events to report hierarchical low/max event counts per DMEM
region.  Increment counters on dmem.max allocation failures and
dmem.low protection events.  The file is available for non-root cgroups
only.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++
 kernel/cgroup/dmem.c                    | 61 ++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..afc924539a41 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2881,6 +2881,22 @@ DMEM Interface Files
 	  drm/0000:03:00.0/vram0 12550144
 	  drm/0000:03:00.0/stolen 8650752
 
+  dmem.events
+	A read-only file that reports the number of times each cgroup
+	has hit its configured memory limits.  The format lists each
+	region on a single line, followed by the event counters::
+
+	  drm/0000:03:00.0/vram0 low 0 max 3
+	  drm/0000:03:00.0/stolen low 0 max 0
+
+	``low`` counts how many times reclaim or eviction considered
+	the cgroup to be below its effective ``dmem.low`` protection.
+	``max`` counts how many times an allocation failed because the
+	cgroup or one of its ancestors hit ``dmem.max``.
+
+	``dmem.events`` contains hierarchical counts.  This file exists
+	for all cgroups except root.
+
 HugeTLB
 -------
 
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f..79d4c5d0a046 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2016 Parav Pandit <pandit.parav@gmail.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/cgroup.h>
 #include <linux/cgroup_dmem.h>
 #include <linux/list.h>
@@ -57,6 +58,14 @@ struct dmemcg_state {
 	struct cgroup_subsys_state css;
 
 	struct list_head pools;
+
+	struct cgroup_file events_file;
+};
+
+enum dmemcg_memory_event {
+	DMEMCG_LOW,
+	DMEMCG_MAX,
+	DMEMCG_NR_EVENTS,
 };
 
 struct dmem_cgroup_pool_state {
@@ -74,6 +83,8 @@ struct dmem_cgroup_pool_state {
 	struct page_counter cnt;
 	struct dmem_cgroup_pool_state *parent;
 
+	atomic_long_t events[DMEMCG_NR_EVENTS];
+
 	refcount_t ref;
 	bool inited;
 };
@@ -182,6 +193,24 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static void dmemcg_memory_event(struct dmem_cgroup_pool_state *pool,
+				enum dmemcg_memory_event event)
+{
+	for (; pool; pool = pool->parent) {
+		atomic_long_inc(&pool->events[event]);
+		cgroup_file_notify(&pool->cs->events_file);
+	}
+}
+
+static long dmemcg_get_event(struct dmem_cgroup_pool_state *pool,
+			     enum dmemcg_memory_event event)
+{
+	if (!pool)
+		return 0;
+
+	return atomic_long_read(&pool->events[event]);
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
@@ -345,6 +374,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 			return true;
 
 		*ret_hit_low = true;
+		dmemcg_memory_event(test_pool, DMEMCG_LOW);
 		return false;
 	}
 	return true;
@@ -675,8 +705,12 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	}
 
 	if (!page_counter_try_charge(&pool->cnt, size, &fail)) {
+		struct dmem_cgroup_pool_state *limit_pool;
+
+		limit_pool = container_of(fail, struct dmem_cgroup_pool_state, cnt);
+		dmemcg_memory_event(limit_pool, DMEMCG_MAX);
 		if (ret_limit_pool) {
-			*ret_limit_pool = container_of(fail, struct dmem_cgroup_pool_state, cnt);
+			*ret_limit_pool = limit_pool;
 			css_get(&(*ret_limit_pool)->cs->css);
 			dmemcg_pool_get(*ret_limit_pool);
 		}
@@ -840,6 +874,25 @@ static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
 	return dmemcg_limit_show(sf, v, get_resource_max);
 }
 
+static int dmem_cgroup_region_events_show(struct seq_file *sf, void *v)
+{
+	struct dmemcg_state *dmemcs = css_to_dmemcs(seq_css(sf));
+	struct dmem_cgroup_region *region;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(region, &dmem_cgroup_regions, region_node) {
+		struct dmem_cgroup_pool_state *pool = find_cg_pool_locked(dmemcs, region);
+
+		seq_puts(sf, region->name);
+		seq_printf(sf, " low %ld max %ld\n",
+			   dmemcg_get_event(pool, DMEMCG_LOW),
+			   dmemcg_get_event(pool, DMEMCG_MAX));
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
 				      char *buf, size_t nbytes, loff_t off)
 {
@@ -874,6 +927,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_max_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "events",
+		.seq_show = dmem_cgroup_region_events_show,
+		.file_offset = offsetof(struct dmemcg_state, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ } /* Zero entry terminates. */
 };
 
-- 
2.25.1


