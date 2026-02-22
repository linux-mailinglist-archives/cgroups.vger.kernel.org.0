Return-Path: <cgroups+bounces-14126-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIEsJiLEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14126-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3FC16EB37
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74AC3019802
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CAD2727FC;
	Sun, 22 Feb 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qQzn8wGy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3226F46E
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750232; cv=none; b=K2ckiscudJPMWLkH3Qda2lKhUjWbFIaJcHFIryTaAKxycy+AFgoudUBloOSIz2xW8mdGOZvtiwx+zlsljBTgFfZkLIz1SQ+tlUT3QuT3s7y2AqF6/Ul+c2/UyoSNSMZzI/dzGAViTRvZMG35VT5BhfC3uM9ieJGPtPi9k3wxmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750232; c=relaxed/simple;
	bh=LTHce9XCprcQ3/di/gbA4Gz5ydpF6pXfobVwEVYqdmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiGCyUEqykFI5V7rsH7rc3920ftbHy7Pq7efrri7mi+0T1jP+Y5xy4yNAIldpTJW7yEQVwd0hU0yrp5G4VqpPd0uGPWOKkvGrP87/D3c8YqzN87YvJXO8Vu3DiJpG8ndDvo1KVkQqSGRlugmc0I8dQN++otRhVkT6WK2rvMQ50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qQzn8wGy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5062fc5d86aso33213041cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750230; x=1772355030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpwyVnUix8AlXytS75zE0sxhDRGKImtyt6+A2dtIhcc=;
        b=qQzn8wGypHBzLW4Uv+gCP4SrBkgnRwhcH8aVi6VpUz0rYGH5K5Op6ObFAZMCy/hKG4
         IF2l2D+aC6DiUjYA+dXUz12bkohB6WVJ9KilXWvrudH2x63/+n5/kIjCF1rnOuS451Dl
         NR2NRVae0M0uRwGylEqv4n1HEPqW9alDiUxUF5PhsIP78R3gIdlR2q/ofpqnxsCBNaOV
         0p7sAbVDF+51/+fLa+9/+bSbAX/4cuapT8tOLvuAlPG7Fl2fEnlbAFQ4DCXVQpzmcoCf
         KpqxIXfdm95BmhWji5H3lKfzj5onm0Hmezuhi9d0mCWrMEFDiRgaKjG0lIQF45G4ftpc
         B/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750230; x=1772355030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpwyVnUix8AlXytS75zE0sxhDRGKImtyt6+A2dtIhcc=;
        b=mnRt282ZCnmTKVYb1qiwhvjGsQSpFHofzA4lXrKFzDhk0nfdOfLZwmVQ4Y5khc40ZG
         Pc2Yb/4oDVrkY7qK9Mq1afTHZ21UGMS9YNqRGnxrEjQ4iPilV4u8XSOggJ55CaaZS5sk
         P4twBp5k2Q5oZWMDMG2GA7C/f6jHgz2qtm+cHlfE/wG5t/5DHsMCWUEUqwmzoAPZCAmy
         gXM463hNHcWOcdcfKbjKkMUh1InSOKK8EkaCtveqhj8jTjrx4DilVKW/krkUEyKuTude
         f96gA2+CzbNhuFcNf/DDCI/gNhTwhoOC/t14DzhmIVWkmjw0PdOoWBpyPUhMGYcD76e0
         D9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTRPsLwVJTnhgY86cgOI7bIqP+wckqRkRLAWe8GeqEOm5Hf7IwgZorbPVBD7S3egylDHbiHVBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVr8wadx1bu02jiRnaSCVol06GvrX754/TMz9dxCEggtX9TkO
	ZmZAGHxY8LdRqrHfr+0i3V5GuKW6lBdZaKVc62NStrhV5tCKRoCzao9EsZKU8uaY0hk=
X-Gm-Gg: AZuq6aLmNMzTHfEXBYGVoYN19kLJIv5ZVABoSepqGHtwWoFIrh0zVaIhLxVPN6vx3/B
	CjT1rLeeb6wCvDERAckBFKel9FuAYUwEKKITkj+U/r6AATsIyFtYHdViO6g+WrPxsoJ+pxSyZeg
	kuycc7eisSsoIZVtthfOjZhD7bFXZ7q7AdRPYYUQ9uoI7XvwtDDHRkqrwBSJmsXe8kaD41Cpi6w
	9Zap1rdHxRM6VEmHF0nnGs6vVsQaZ4jWRqJ2lCHuU2MVpFisWM8PnVUbr3Uxd8+bIp797I9Jg9Y
	ArDWU+vuyZxBrFpd0Mdigrp4x4igk4cZTTKYDbalbxmZlQaxF9eR81XF3ZcJsab68ERiolxtmO4
	VJFYJo2+6aUp73Dx0FZuKJGZd7qtVYNy5wwwelwLYlWYruahBSdue7Ws6ZvK4sXGzqJlAsiLN8M
	qQCH66r89wDyvFgmGYyvpZlgjBFcn9lt2myKDxUF43OuxWQHWPO+lPflUEN8/ZAsq7MgARSbPNE
	eyd5EAy6myI13o=
X-Received: by 2002:ac8:7fc5:0:b0:506:6f78:e091 with SMTP id d75a77b69052e-5070bc91781mr65950941cf.60.1771750229747;
        Sun, 22 Feb 2026 00:50:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:28 -0800 (PST)
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
Subject: [RFC PATCH v4 25/27] cxl/core: Add private node support to cxl_sysram
Date: Sun, 22 Feb 2026 03:48:40 -0500
Message-ID: <20260222084842.1824063-26-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-14126-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C3FC16EB37
X-Rspamd-Action: no action

Extend the cxl_sysram region to support N_MEMORY_PRIVATE hotplug
via add_private_memory_driver_managed(). When a caller passes
private=true to devm_cxl_add_sysram(), the memory is registered
as a private node, isolating it from normal allocations and reclaim.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h          |  2 +-
 drivers/cxl/core/region_sysram.c | 50 +++++++++++++++++++++++++-------
 drivers/cxl/cxl.h                |  9 ++++--
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 973bbcae43f7..8ca3d6d41fe4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -56,7 +56,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
-int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type);
+int devm_cxl_add_sysram(struct cxl_region *cxlr, bool private, enum mmop online_type);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/region_sysram.c b/drivers/cxl/core/region_sysram.c
index 47a415deb352..77aaa52e7332 100644
--- a/drivers/cxl/core/region_sysram.c
+++ b/drivers/cxl/core/region_sysram.c
@@ -85,12 +85,23 @@ static int sysram_hotplug_add(struct cxl_sysram *sysram, enum mmop online_type)
 	/*
 	 * Ensure that future kexec'd kernels will not treat
 	 * this as RAM automatically.
+	 *
+	 * For private regions, use add_private_memory_driver_managed()
+	 * to register as N_MEMORY_PRIVATE which isolates the memory from
+	 * normal allocations and reclaim.
 	 */
-	rc = __add_memory_driver_managed(sysram->mgid,
-					 sysram->hpa_range.start,
-					 range_len(&sysram->hpa_range),
-					 sysram_res_name, mhp_flags,
-					 online_type);
+	if (sysram->private)
+		rc = add_private_memory_driver_managed(sysram->mgid,
+						       sysram->hpa_range.start,
+						       range_len(&sysram->hpa_range),
+						       sysram_res_name, mhp_flags,
+						       online_type, &sysram->np);
+	else
+		rc = __add_memory_driver_managed(sysram->mgid,
+						 sysram->hpa_range.start,
+						 range_len(&sysram->hpa_range),
+						 sysram_res_name, mhp_flags,
+						 online_type);
 	if (rc) {
 		remove_resource(res);
 		kfree(res);
@@ -108,10 +119,23 @@ static int sysram_hotplug_remove(struct cxl_sysram *sysram)
 	if (!sysram->res)
 		return 0;
 
-	rc = offline_and_remove_memory(sysram->hpa_range.start,
-				       range_len(&sysram->hpa_range));
-	if (rc)
-		return rc;
+	if (sysram->private) {
+		rc = offline_and_remove_private_memory(sysram->numa_node,
+						       sysram->hpa_range.start,
+						       range_len(&sysram->hpa_range));
+		/*
+		 * -EBUSY means memory was removed but node_private_unregister()
+		 * could not complete because other regions share the node.
+		 * Continue to resource cleanup since the memory is gone.
+		 */
+		if (rc && rc != -EBUSY)
+			return rc;
+	} else {
+		rc = offline_and_remove_memory(sysram->hpa_range.start,
+					       range_len(&sysram->hpa_range));
+		if (rc)
+			return rc;
+	}
 
 	if (sysram->res) {
 		remove_resource(sysram->res);
@@ -257,7 +281,8 @@ static void sysram_unregister(void *_sysram)
 	device_unregister(&sysram->dev);
 }
 
-int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type)
+int devm_cxl_add_sysram(struct cxl_region *cxlr, bool private,
+			enum mmop online_type)
 {
 	struct cxl_sysram *sysram __free(put_cxl_sysram) = NULL;
 	struct memory_dev_type *mtype;
@@ -291,6 +316,11 @@ int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type)
 	if (online_type >= 0)
 		sysram->online_type = online_type;
 
+	/* Set up private node registration if requested */
+	sysram->private = private;
+	if (private)
+		sysram->np.owner = sysram;
+
 	dev = &sysram->dev;
 
 	rc = dev_set_name(dev, "sysram_region%d", cxlr->id);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8e8342fd4fde..54e5f9ac59dc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/node.h>
+#include <linux/node_private.h>
 #include <linux/io.h>
 #include <linux/range.h>
 #include <linux/dax.h>
@@ -619,6 +620,8 @@ struct cxl_dax_region {
  * @mgid: Memory group id
  * @mtype: Memory tier type
  * @numa_node: NUMA node for this memory
+ * @private: true if this region uses N_MEMORY_PRIVATE hotplug
+ * @np: private node registration state (valid when @private is true)
  *
  * Device that directly performs memory hotplug for CXL RAM regions.
  */
@@ -633,6 +636,8 @@ struct cxl_sysram {
 	int mgid;
 	struct memory_dev_type *mtype;
 	int numa_node;
+	bool private;
+	struct node_private np;
 };
 
 /**
@@ -987,7 +992,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 struct cxl_sysram *to_cxl_sysram(struct device *dev);
 struct device *cxl_sysram_dev(struct cxl_sysram *sysram);
-int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type);
+int devm_cxl_add_sysram(struct cxl_region *cxlr, bool private, enum mmop online_type);
 int cxl_sysram_offline_and_remove(struct cxl_sysram *sysram);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
@@ -1011,7 +1016,7 @@ static inline struct cxl_sysram *to_cxl_sysram(struct device *dev)
 {
 	return NULL;
 }
-static inline int devm_cxl_add_sysram(struct cxl_region *cxlr,
+static inline int devm_cxl_add_sysram(struct cxl_region *cxlr, bool private,
 				      enum mmop online_type)
 {
 	return -ENXIO;
-- 
2.53.0


