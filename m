Return-Path: <cgroups+bounces-15886-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNNXOSpYBGqjHAIAu9opvQ
	(envelope-from <cgroups+bounces-15886-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:53:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F69531ADE
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07CFF307021A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517053EFD0C;
	Wed, 13 May 2026 10:51:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E783DC4C6
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669490; cv=none; b=T4wGk4r43Pn8sbWHngVHNMjyiKrqR7/WkyeAF27NCsU+lcWcrzaNJlxMu/RbQvWC4YU0fxUbuu65TcjIFZgbzSujDFjH+RMqhQmZH2H1e/7Al7/E27g8WNMuzVlowNFos1fKovWD55rDC+3pMBKt/La/7ToABCsIBPGNM/DLQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669490; c=relaxed/simple;
	bh=tqOL/vi52WwhMwqGhy4HvktVHZOciRjxxuLP3lctfp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ6KlNtzFUmGq9bTD3VbmePZBiNl9vnPKEh9/21H7lXSEV7ShRFbPgTVQqAul913Y4FltJhdsGc2YxtHr+cTjV7eHPGwSIy1JworP5Noz8N1GuzbN9aNAjH8vvC2s3O1PMuGOeMIdvv2QxTRwEaAZd4pv/sDFK9PLJT2r+VUdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad495aea4eb911f1aa26b74ffac11d73-20260513
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba27613f-c148-4952-9a13-a3161a7fcac4,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:ba27613f-c148-4952-9a13-a3161a7fcac4,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:c88a0ea0e1acbec6f1eaa92b6904a11f,BulkI
	D:260513185122J362Y3L0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ad495aea4eb911f1aa26b74ffac11d73-20260513
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 694284855; Wed, 13 May 2026 18:51:20 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 3/4] cgroup/rdma: add rdma.events.local for per-cgroup allocation failure attribution
Date: Wed, 13 May 2026 18:49:55 +0800
Message-ID: <20260513104956.373216-4-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513104956.373216-1-cuitao@kylinos.cn>
References: <20260513104956.373216-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98F69531ADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15886-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rdma.events:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

Add per-cgroup local event counters to track RDMA resource limit
exhaustion from the perspective of individual cgroups. The
rdma.events.local file reports two per-resource counters:

- max: number of times this cgroup's limit was the one that blocked
  an allocation in the subtree
- alloc_fail: number of allocation attempts originating from this
  cgroup that failed due to an ancestor's limit

This mirrors the design of pids.events.local, where events are
attributed to the cgroup that imposed the limit, not necessarily the
cgroup where the allocation was attempted.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 include/linux/cgroup_rdma.h |  3 +-
 kernel/cgroup/rdma.c        | 94 ++++++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index ac691fe7d3f5..404e746552ca 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -25,8 +25,9 @@ struct rdma_cgroup {
 	 */
 	struct list_head		rpools;
 
-	/* Handle for rdma.events */
+	/* Handles for rdma.events[.local] */
 	struct cgroup_file		events_file;
+	struct cgroup_file		events_local_file;
 };
 
 struct rdmacg_device {
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 2b729976b9e9..5c94cf080655 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -82,8 +82,11 @@ struct rdmacg_resource_pool {
 	/* total number counts which are set to max */
 	int			num_max_cnt;
 
-	/* per-resource hierarchical max event counters */
+	/* per-resource event counters */
 	u64			events_max[RDMACG_RESOURCE_MAX];
+	u64			events_alloc_fail[RDMACG_RESOURCE_MAX];
+	u64			events_local_max[RDMACG_RESOURCE_MAX];
+	u64			events_local_alloc_fail[RDMACG_RESOURCE_MAX];
 };
 
 static struct rdma_cgroup *css_rdmacg(struct cgroup_subsys_state *css)
@@ -218,7 +221,10 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 		 */
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			if (rpool->resources[i].peak ||
-			    READ_ONCE(rpool->events_max[i]))
+			    READ_ONCE(rpool->events_max[i]) ||
+			    READ_ONCE(rpool->events_local_max[i]) ||
+			    READ_ONCE(rpool->events_alloc_fail[i]) ||
+			    READ_ONCE(rpool->events_local_alloc_fail[i]))
 				return;
 		}
 		/*
@@ -230,16 +236,19 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 }
 
 /**
- * rdmacg_event_locked - fire hierarchical max event when resource limit is hit
+ * rdmacg_event_locked - fire event when resource allocation exceeds limit
+ * @cg: requesting cgroup
  * @over_cg: cgroup whose limit was exceeded
  * @device: rdma device
  * @index: resource type index
  *
- * Must be called under rdmacg_mutex. Propagates max event counts
- * from @over_cg (including itself) upward to all ancestors with
- * an rpool and notifies userspace.
+ * Must be called under rdmacg_mutex. Updates event counters in the
+ * resource pools of @cg and @over_cg, propagates hierarchical max
+ * events from @over_cg (including itself) upward, and notifies
+ * userspace via cgroup_file_notify().
  */
-static void rdmacg_event_locked(struct rdma_cgroup *over_cg,
+static void rdmacg_event_locked(struct rdma_cgroup *cg,
+				struct rdma_cgroup *over_cg,
 				struct rdmacg_device *device,
 				enum rdmacg_resource_type index)
 {
@@ -248,6 +257,21 @@ static void rdmacg_event_locked(struct rdma_cgroup *over_cg,
 
 	lockdep_assert_held(&rdmacg_mutex);
 
+	/* Increment local alloc_fail in requesting cgroup */
+	rpool = find_cg_rpool_locked(cg, device);
+	if (rpool) {
+		rpool->events_local_alloc_fail[index]++;
+		cgroup_file_notify(&cg->events_local_file);
+	}
+
+	/* Increment local max in the over-limit cgroup */
+	rpool = find_cg_rpool_locked(over_cg, device);
+	if (rpool) {
+		rpool->events_local_max[index]++;
+		cgroup_file_notify(&over_cg->events_local_file);
+	}
+
+	/* Propagate hierarchical max events upward */
 	for (p = over_cg; parent_rdmacg(p); p = parent_rdmacg(p)) {
 		rpool = find_cg_rpool_locked(p, device);
 		if (rpool) {
@@ -255,6 +279,14 @@ static void rdmacg_event_locked(struct rdma_cgroup *over_cg,
 			cgroup_file_notify(&p->events_file);
 		}
 	}
+	/* Propagate hierarchical alloc_fail from requesting cgroup upward */
+	for (p = cg; parent_rdmacg(p); p = parent_rdmacg(p)) {
+		rpool = find_cg_rpool_locked(p, device);
+		if (rpool) {
+			rpool->events_alloc_fail[index]++;
+			cgroup_file_notify(&p->events_file);
+		}
+	}
 }
 
 /**
@@ -368,7 +400,7 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 
 err:
 	if (ret == -EAGAIN)
-		rdmacg_event_locked(p, device, index);
+		rdmacg_event_locked(cg, p, device, index);
 	mutex_unlock(&rdmacg_mutex);
 	rdmacg_uncharge_hierarchy(cg, device, p, index);
 	return ret;
@@ -529,7 +561,10 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
 			if (rpool->resources[i].peak ||
-			    READ_ONCE(rpool->events_max[i]))
+			    READ_ONCE(rpool->events_max[i]) ||
+			    READ_ONCE(rpool->events_local_max[i]) ||
+			    READ_ONCE(rpool->events_alloc_fail[i]) ||
+			    READ_ONCE(rpool->events_local_alloc_fail[i]))
 				goto dev_err;
 		}
 		/*
@@ -618,9 +653,40 @@ static int rdmacg_events_show(struct seq_file *sf, void *v)
 
 		seq_printf(sf, "%s ", device->name);
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
-			seq_printf(sf, "%s.max=%lld",
+			seq_printf(sf, "%s.max=%lld %s.alloc_fail=%lld",
 				   rdmacg_resource_names[i],
-				   rpool ? (s64)READ_ONCE(rpool->events_max[i]) : 0);
+				   rpool ? (s64)READ_ONCE(rpool->events_max[i]) : 0,
+				   rdmacg_resource_names[i],
+				   rpool ? (s64)READ_ONCE(rpool->events_alloc_fail[i]) : 0);
+			if (i < RDMACG_RESOURCE_MAX - 1)
+				seq_putc(sf, ' ');
+		}
+		seq_putc(sf, '\n');
+	}
+
+	mutex_unlock(&rdmacg_mutex);
+	return 0;
+}
+
+static int rdmacg_events_local_show(struct seq_file *sf, void *v)
+{
+	struct rdma_cgroup *cg = css_rdmacg(seq_css(sf));
+	struct rdmacg_resource_pool *rpool;
+	struct rdmacg_device *device;
+	int i;
+
+	mutex_lock(&rdmacg_mutex);
+
+	list_for_each_entry(device, &rdmacg_devices, dev_node) {
+		rpool = find_cg_rpool_locked(cg, device);
+
+		seq_printf(sf, "%s ", device->name);
+		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
+			seq_printf(sf, "%s.max=%lld %s.alloc_fail=%lld",
+				   rdmacg_resource_names[i],
+				   rpool ? (s64)READ_ONCE(rpool->events_local_max[i]) : 0,
+				   rdmacg_resource_names[i],
+				   rpool ? (s64)READ_ONCE(rpool->events_local_alloc_fail[i]) : 0);
 			if (i < RDMACG_RESOURCE_MAX - 1)
 				seq_putc(sf, ' ');
 		}
@@ -657,6 +723,12 @@ static struct cftype rdmacg_files[] = {
 		.file_offset = offsetof(struct rdma_cgroup, events_file),
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "events.local",
+		.seq_show = rdmacg_events_local_show,
+		.file_offset = offsetof(struct rdma_cgroup, events_local_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.43.0


