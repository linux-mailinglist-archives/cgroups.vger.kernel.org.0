Return-Path: <cgroups+bounces-15932-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBgdD9pwBWoTXAIAu9opvQ
	(envelope-from <cgroups+bounces-15932-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:51:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49953E880
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D896830347D5
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2553ACA41;
	Thu, 14 May 2026 06:50:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFE3ACA52
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741459; cv=none; b=P8QAKt1g7iJphzK8sfAOkiTJhc7l93cBb4gvqhVqSHK70xCTOnS3+NRmtYFG+6VAx/GFxU/yg41fibPHXugT8WZGTRNnAuUo5wYkC58RFny2ly+V+TpLoJrNtBejqw9lNkSVmPIJWw2i8IdxgkG53nM6mqRlmhi5AA+ajbB0CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741459; c=relaxed/simple;
	bh=BOBBG7JlURTbju3ucV7cGkGTR12eOksoHjQg0mBDJcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goSaO2ZRrMqP8rClbR7R6TB3KLN1E0BSV/AIBJqBnEa0bM7m+wml43G6vu6Hc7aaxtPT26LqMShOhKQpJl54SKPd7jTIQliGRzf9FVqw9sylDJbKbU4dnqBnG/9kW8KbLCFxnriucwPAIGN7MJ4asxjZFRULeKiiIdIRv+6QmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4000acc44f6111f1aa26b74ffac11d73-20260514
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
X-CID-O-INFO: VERSION:1.3.12,REQID:c9509f90-8cbe-40b2-abf9-c366e1be902c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:c9509f90-8cbe-40b2-abf9-c366e1be902c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa2cc50b75602311f00992c08ed937ff,BulkI
	D:260514145054HMZ8RI4M,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4000acc44f6111f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 634510468; Thu, 14 May 2026 14:50:52 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 2/4] cgroup/rdma: add rdma.events to track resource limit exhaustion
Date: Thu, 14 May 2026 14:50:32 +0800
Message-ID: <20260514065034.387197-3-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514065034.387197-1-cuitao@kylinos.cn>
References: <20260514065034.387197-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A49953E880
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-15932-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

Add per-device hierarchical event counters to track when RDMA resource
limits are exceeded. The rdma.events file reports max event counts
propagated upward from the cgroup whose limit was hit to all ancestors.

This mirrors the design of pids.events, where events are attributed to
the cgroup that imposed the limit, not necessarily the cgroup where the
allocation was attempted. Userspace can monitor this file via
poll/epoll for real-time notification of resource exhaustion.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 include/linux/cgroup_rdma.h |  3 ++
 kernel/cgroup/rdma.c        | 72 +++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 80edae03c313..ac691fe7d3f5 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -24,6 +24,9 @@ struct rdma_cgroup {
 	 * that belongs to this cgroup.
 	 */
 	struct list_head		rpools;
+
+	/* Handle for rdma.events */
+	struct cgroup_file		events_file;
 };
 
 struct rdmacg_device {
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 4e3bf0bade18..927bbf1eb949 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -81,6 +81,9 @@ struct rdmacg_resource_pool {
 	u64			usage_sum;
 	/* total number counts which are set to max */
 	int			num_max_cnt;
+
+	/* per-resource hierarchical max event counters */
+	u64			events_max[RDMACG_RESOURCE_MAX];
 };
 
 static struct rdma_cgroup *css_rdmacg(struct cgroup_subsys_state *css)
@@ -214,7 +217,8 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 		 * watermark even after all resources are freed.
 		 */
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
-			if (rpool->resources[i].peak)
+			if (rpool->resources[i].peak ||
+			    READ_ONCE(rpool->events_max[i]))
 				return;
 		}
 		/*
@@ -225,6 +229,34 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 	}
 }
 
+/**
+ * rdmacg_event_locked - fire hierarchical max event when resource limit is hit
+ * @over_cg: cgroup whose limit was exceeded
+ * @device: rdma device
+ * @index: resource type index
+ *
+ * Must be called under rdmacg_mutex. Propagates max event counts
+ * from @over_cg (including itself) upward to all ancestors with
+ * an rpool and notifies userspace.
+ */
+static void rdmacg_event_locked(struct rdma_cgroup *over_cg,
+				struct rdmacg_device *device,
+				enum rdmacg_resource_type index)
+{
+	struct rdmacg_resource_pool *rpool;
+	struct rdma_cgroup *p;
+
+	lockdep_assert_held(&rdmacg_mutex);
+
+	for (p = over_cg; parent_rdmacg(p); p = parent_rdmacg(p)) {
+		rpool = get_cg_rpool_locked(p, device);
+		if (!IS_ERR(rpool)) {
+			rpool->events_max[index]++;
+			cgroup_file_notify(&p->events_file);
+		}
+	}
+}
+
 /**
  * rdmacg_uncharge_hierarchy - hierarchically uncharge rdma resource count
  * @cg: pointer to cg to uncharge and all parents in hierarchy
@@ -335,6 +367,8 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 	return 0;
 
 err:
+	if (ret == -EAGAIN)
+		rdmacg_event_locked(p, device, index);
 	mutex_unlock(&rdmacg_mutex);
 	rdmacg_uncharge_hierarchy(cg, device, p, index);
 	return ret;
@@ -494,7 +528,8 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		int i;
 
 		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
-			if (rpool->resources[i].peak)
+			if (rpool->resources[i].peak ||
+			    READ_ONCE(rpool->events_max[i]))
 				goto dev_err;
 		}
 		/*
@@ -569,6 +604,33 @@ static int rdmacg_resource_read(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static int rdmacg_events_show(struct seq_file *sf, void *v)
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
+			seq_printf(sf, "%s.max=%llu",
+				   rdmacg_resource_names[i],
+				   rpool ? READ_ONCE(rpool->events_max[i]) : 0ULL);
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
 static struct cftype rdmacg_files[] = {
 	{
 		.name = "max",
@@ -589,6 +651,12 @@ static struct cftype rdmacg_files[] = {
 		.private = RDMACG_RESOURCE_TYPE_PEAK,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "events",
+		.seq_show = rdmacg_events_show,
+		.file_offset = offsetof(struct rdma_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.43.0


