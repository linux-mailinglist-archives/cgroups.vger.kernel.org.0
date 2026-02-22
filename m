Return-Path: <cgroups+bounces-14120-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFAaGcTDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14120-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F516EAD8
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D4CD302FB0C
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F6257423;
	Sun, 22 Feb 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="On3dGfWn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165C257827
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750209; cv=none; b=hyjJpIebhjWMgVPjqYw8OG3bUgizeOTJfcj7ICN9aAaIzqoPDdR0wj7j6Vk7QxMAiDnh9fvTRjmqIrgF5EXgJ4M6oWSFRNz+0B1OoFI1j3fOpKr5XPLHoRLLJY5o4ySX1tAOMZiTb1/RsKsyfU5jGi1q9ID+Dvi14iEaU1PuNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750209; c=relaxed/simple;
	bh=ugHHZgdJqiJXcDB88oSYbue+JadFi16VcX0GKhbfi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tj4ls3GasOmk7kKZfxQxBzPgT8Jl/K48+Ycrpo2fpMInoiuJH4jgcO7VHN0balYaNXX7DaXlkmhyZIIRmLSvMf/8npo1esXdoON0QQBsoE+yYCRVjfS0eGZ96SikHA7H2+mv1gHyRiT+znznoc72hF7Mskt2qm2NbnMSYqUPQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=On3dGfWn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-503347e8715so43174131cf.2
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750207; x=1772355007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=On3dGfWnTNN//RWAohKdA4pL2lZMV7MeYMGS62VGhOuMecRzlrq6gWIUBvvjT5HHaT
         ix0alOvAxYuQ/UF+iHgKCZE1NJ79jby/hFklKqI20yPQKV0JhOMMvBMaZOx6y5VFqasu
         PpoEFeOQ4c5xjZymZwU32/WzBKtFDimqsUNPxVd+Hzs3PhECgFQfjxBc4ZJ7nJ0j4Tav
         GAApuP8InCI4mdI9yqeN6yb7hyMt1wufFWCiqqn5Rp/vjRlXJIeLQSU0ZCV50UEqj30o
         H714Ynl0lEEugwsUlVjrRsqiFuJ8lgwu88JAZR6TsNox+hwHL9BvbHO6/efoXdrXQeu+
         Huew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750207; x=1772355007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=GX0AIbUdUcOMvuVzqMzgTukAr6b6xO7wOF7f0ox5VwU5TBKFtrKHV12nqSjHwtf3bq
         p9QwIGiDHpRBzfzxUXffbzS9Dh6Jbz72KNsFTCUjUHsVrv32n/XrXKJmU72TvPQOAmiz
         RpoDYEVxq8F/kXxolYzrXIrGl7c9PUK2XED+kOwZ2DucaXQvDVVMjYrSMEiYj9tTQ/ML
         FYyuTIYmMYlSFniUnZlEJvpLDaXJJaQW9ETGVtwf6G1v/hd3qivMByi7lJqOnQuunStB
         Uh833JHjf0Ef61UkgMcKi4EefEd8TxbgR6QSTgYM/j2otlY1F/8/p3n0NLesHT3MtaXm
         ZOpg==
X-Forwarded-Encrypted: i=1; AJvYcCXvvvTSwZUQjapeos4/Cg18ywxLdqPrDFk8MKbV05Vot0OGeGJr4RrHVGYuYmsNikMDKVirlpQG@vger.kernel.org
X-Gm-Message-State: AOJu0Yziycd+Xhye6K3ggMd8jwIr7zSEj62BwydMEtOdg7B5v+VySYtW
	ZQTIzJDZXtJknkJgEueBy4Hun9/u+rx60hwooM0J1BKBTPkW/yNOEqoAZxCcraodcLs=
X-Gm-Gg: AZuq6aIZ23s7QJPIm6Sw7UkuhUniegMjILl5xYYD7zwkZiLmed+NfHTbN282sdGFjjF
	KiLvmSpTrucU1jqwU9ltut3yrjqd0STJvllYp4TEO1hVSleV5j4vlapRy+kDZHiyZAGHUqPPxZs
	SDdlOrEhT+YA3rslFRBZH07F7LJXQqxfBh0niHAiWF6JOtZdZMzwIDw3NO6PLMbWO3z1tmD6X9X
	TMoTDU/kJtahAEXFWDhGrZ/eucBUCzOc7UqvGCfjjQmhr605UkZqBCTSQIyG+w4ve5evDnwlZBZ
	6o8AGFbGwQlSF0OuLdN8CN5cUEBZu7AtDIgpxynlnDFKdYdc9VL18aDUOP6sRMiuxVLQjhEFTfH
	7Yrgayd83xqcXv8MhKpe6C8tZ/cl1brDVqU9EoTjSslZ8GbX/skmvf6+jBaGpTErgjMkenBJjiL
	dFzHDbmqlMPO8CciUZvHIUFAwyJf70tQYLGorY6RUhi3Nsz9SfhuuiJmRSlIQ8A4eaM3qU3h/OO
	PasIGPf67zyH6Q=
X-Received: by 2002:a05:622a:209:b0:4ff:4a7c:da11 with SMTP id d75a77b69052e-5070bba08b0mr86322821cf.11.1771750207039;
        Sun, 22 Feb 2026 00:50:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:06 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 19/27] mm/compaction: NP_OPS_COMPACTION - private node compaction support
Date: Sun, 22 Feb 2026 03:48:34 -0500
Message-ID: <20260222084842.1824063-20-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14120-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 2A5F516EAD8
X-Rspamd-Action: no action

Private node zones should not be compacted unless the service explicitly
opts in - as compaction requires migration and services may have
PFN-based metadata that needs updating.

Add a folio_migrate callback which fires from migrate_folio_move() for
each relocated folio before faults are unblocked.

Add zone_supports_compaction() which returns true for normal zones and
checks NP_OPS_COMPACTION for N_MEMORY_PRIVATE zones.

Filter three direct compaction zone loops:
  - compaction_zonelist_suitable() (reclaimer eligibility)
  - try_to_compact_pages()         (direct compaction)
  - compact_node()                 (proactive/manual compaction)

kcompactd paths are intentionally unfiltered -- the service is
responsible for starting kcompactd on its node.

NP_OPS_COMPACTION requires NP_OPS_MIGRATION.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++++
 include/linux/node_private.h |  2 ++
 mm/compaction.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 88aaac45e814..da523aca18fa 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -965,6 +965,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    !(ops->flags & NP_OPS_MIGRATION))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_COMPACTION) &&
+	    !(ops->flags & NP_OPS_MIGRATION))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 5ac60db1f044..fe0336773ddb 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -142,6 +142,8 @@ struct node_private_ops {
 #define NP_OPS_RECLAIM			BIT(4)
 /* Allow NUMA balancing to scan and migrate folios on this node */
 #define NP_OPS_NUMA_BALANCING		BIT(5)
+/* Allow compaction to run on the node.  Service must start kcompactd. */
+#define NP_OPS_COMPACTION		BIT(6)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
diff --git a/mm/compaction.c b/mm/compaction.c
index 6a65145b03d8..d8532b957ec6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,9 +24,26 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/node_private.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
+
+/*
+ * Private node zones require NP_OPS_COMPACTION to opt in.  Normal zones
+ * always support compaction.
+ */
+static inline bool zone_supports_compaction(struct zone *zone)
+{
+#ifdef CONFIG_NUMA
+	if (!node_state(zone_to_nid(zone), N_MEMORY_PRIVATE))
+		return true;
+	return zone_private_flags(zone, NP_OPS_COMPACTION);
+#else
+	return true;
+#endif
+}
+
 /*
  * Fragmentation score check interval for proactive compaction purposes.
  */
@@ -2443,6 +2460,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2832,6 +2852,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2906,6 +2929,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		if (!populated_zone(zone))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (fatal_signal_pending(current))
 			return -EINTR;
 
-- 
2.53.0


