Return-Path: <cgroups+bounces-2844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AC8C17C8
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B28E1C21D6E
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571C7F7F5;
	Thu,  9 May 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZSJQ0Tk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788F811E0
	for <cgroups@vger.kernel.org>; Thu,  9 May 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287418; cv=none; b=JoY2TxsGA4PLHLq8vm3RqOnvvaelyC4vEFClxZbXz8hE9bXKQ7KLxKrXCHyehBlV3Yrre+O3gA5QB12J66YjvFNboFqfLlraONYKTQvdRHvFEWh4b1DHTtzzpnJVnl/IMaaBvmZZeTMhK7CNAKcVX38JGp7wU/CufysdV1hzmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287418; c=relaxed/simple;
	bh=GdvpxFT42CDKwuUMF85vnf6gLm9iuggvRLM0H9Yu/RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=XJ+++CgHaD4rhLajCVUnUKddtc9gfgtbjNA43Wb8nX/3Y7X/rRHpEoBN/qABn+DzSOLYdfk/rL6mHaO45Ain9FZBvI1S60XRql3TugWQlXe2dcBWogU/a348KUzx+aW1gkQMKyVpjY7VgJG5AVbWqopGWDG7MMwI+RYTfbJsC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZSJQ0Tk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715287413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKx0S7FzwqaZ25i9u3aRmby5t1CJ8YR9Zqwq3RwKUt4=;
	b=TZSJQ0TkxMLVJs8v4V4R0wY/OwkQx0n7kL7PT+9t4mNwGoB7rGDJVgG+jejIFDIV0kbfXS
	Danr81HNXfHVrXX4af2d4F239zlt/9HUD19/PC3fknNfZkgclvhE3+kg8hQ7Bp+ZjJNV2p
	iHhvqQfcK4II+TXcdnKCtWpgziDAbN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-oQ-iO5sKMVeULXi4UoE1Nw-1; Thu, 09 May 2024 16:43:29 -0400
X-MC-Unique: oQ-iO5sKMVeULXi4UoE1Nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F3F800A03;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FBF61D69461;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	aviv.coro@ibm.com
Subject: [PATCH v3 2/3] nvme: add 'latency' iopolicy
Date: Thu,  9 May 2024 16:43:23 -0400
Message-Id: <20240509204324.832846-3-jmeneghi@redhat.com>
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Hannes Reinecke <hare@kernel.org>

Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
latency tracker to provide latencies for each node, and schedules
I/O on the path with the least latency for the submitting node.

Signed-off-by: Hannes Reinecke <hare@kernel.org>

Make this compile when CONFIG_BLK_NODE_LATENCY is not set.
Advertise the 'latency' iopolicy in modinfo.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 63 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d916a5ddf5d4..e9330bb1990b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_LAT]	= "latency",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -32,6 +33,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+#ifdef CONFIG_BLK_NODE_LATENCY
+	else if (!strncmp(val, "latency", 7))
+		iopolicy = NVME_IOPOLICY_LAT;
+#endif
 	else
 		return -EINVAL;
 
@@ -43,10 +48,36 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
 }
 
+static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ns_head *h;
+	struct nvme_ns *ns;
+	bool enable = iopolicy == NVME_IOPOLICY_LAT;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		list_for_each_entry_rcu(ns, &h->list, siblings) {
+			if (enable) {
+				ret = blk_nlat_enable(ns->disk);
+				if (ret)
+					break;
+			} else
+				blk_nlat_disable(ns->disk);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
+#if defined(CONFIG_BLK_NODE_LATENCY)
+	"Default multipath I/O policy; 'numa' (default) , 'round-robin', 'queue-depth' or 'latency'");
+#else
 	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
+#endif
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -250,14 +281,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
-		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (iopolicy == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
+		else if (iopolicy == NVME_IOPOLICY_LAT)
+			distance = blk_nlat_latency(ns->disk, node);
 		else
 			distance = LOCAL_DISTANCE;
 
@@ -381,8 +414,8 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 	int node;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 	struct nvme_ns *ns;
 
 	/*
@@ -401,8 +434,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 
 	if (iopolicy == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
-
-	if (unlikely(!nvme_path_is_optimized(ns)))
+	if (iopolicy == NVME_IOPOLICY_LAT ||
+	    unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
@@ -872,15 +905,18 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			nvme_subsys_iopolicy_update(subsys, i);
-			return count;
+			ret = nvme_activate_iopolicy(subsys, i);
+			if (!ret) {
+				nvme_subsys_iopolicy_update(subsys, i);
+				return count;
+			}
+			return ret;
 		}
 	}
-
 	return -EINVAL;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
@@ -916,6 +952,15 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	if (!blk_nlat_init(ns->disk) &&
+	    READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_LAT) {
+		int ret = blk_nlat_enable(ns->disk);
+
+		if (unlikely(ret))
+			pr_warn("%s: Failed to enable latency tracking, error %d\n",
+				ns->disk->disk_name, ret);
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a557b4577c01..66bf003a6c48 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_LAT,
 };
 
 struct nvme_subsystem {
-- 
2.39.3


