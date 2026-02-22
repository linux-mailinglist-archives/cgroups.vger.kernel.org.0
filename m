Return-Path: <cgroups+bounces-14125-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFBCJTXFmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14125-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:58:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C916EBF4
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3E1C303A8A2
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E626E6E1;
	Sun, 22 Feb 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BvfUyP54"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6726D4C7
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750228; cv=none; b=g0Hzn5uTfTzDU5QDYvoW26J/FpNisWlKTcKcWo4Zf6tE4DVn575YKCQzeftgMOzPMnjfm6IhNk+Z1Bn1rk6QVGKRhGFKRn/xMyH7lbQuP4jDs8/5wOf5v50kFvKg2mFz+8nrsW0xxzL5wpRxrL7a1AgHkMQqGG9EfOjvvhEjtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750228; c=relaxed/simple;
	bh=JnJNkHEvCv17WoTFgUj+wKr875IXZ3E8taOLw+Qh4no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKr7emV1SqOsUfo/6CsUWf8Hrp72Le4gDBhiLyRdXcGkkEsYr9+K/4lR8bz00TFMdPB35JSbmamt+p74U3bVxokP4j8WkVPD7Erov3bZ7fd4QrXfunaUxvL0a8vXu2JfuPrT02HwzRfZ/2QMFg036oRJ/UjH0RwxbKteH3cwHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BvfUyP54; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-506e287dd53so27497681cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750225; x=1772355025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGuT6RhCP5I7NLb1YN0up3Sr68HZnKNB2ZvPCLs8MH8=;
        b=BvfUyP54UDGZak5nJ9eplxdAUhFHjsPsKdEiN3gRpa0acaXG/cyDYfb4SHmgf8y9kE
         cPS6Shgu/kaBAfs72fZ/2Sp51R5WBn+TAUvMc50uQO3JXRrfazKlvJq+2qfSlPLxQ+IZ
         gojV4FY6UHCtc9woN5F7DlEiojwnE+mmhf6ZedhLWWwPUiEDgw2aT2YQT0zJ+QX+sLeS
         hXc28dUYoQLun4KjKMris2cvkGS/lEUUcEZlUYk5p/ieDVLrMo4CcUS4GjtlfGhLE/dA
         LD6JbZsGCaxAVAnCJm8gjxsswwcjyQnS9ERLCVh4z6kjg1LHQQt2gq0VGZkv/ZsLukxq
         pcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750225; x=1772355025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGuT6RhCP5I7NLb1YN0up3Sr68HZnKNB2ZvPCLs8MH8=;
        b=YH75W4+CQ8ieZe2FXtZvErJnYTLMVdh3OVtO3S9145JJ98MvAxZtYqxjNnU4HSbMH0
         VLuDXWqJh8SwqlyryoB3VlXhqnsphOfnNBIuR9UnNHWl/bq3KmnMbG/H1v5CKWfGQb0f
         Hg1WNeQEDxCmvqLxp/udE/h7YdflLj08HDEtuabNTjNcgRLU+SbZG5PjLpY3AtVsatnM
         cpU+/EhEtMFBY0stjVo2hzevq9tjsoeID7BJCmvA0zxstldiIAnsaNmANQLiNBDd8Sm3
         kPJE8N/TDdTo8beCl1Y/Td5YTpnL4h8iO0xg+MGNV14ECeBRMa50r2/DKNLLfOaIDK9R
         mhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDZ+94kZ0IYVP74/0cRcwwIOsmzjJhO2H74ZYlbykyR9KQEko6nqHtjgFBExe0u2nHdtp+iOeV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxha9Yh2eOfHqo/4DE1umOM3DhLZkx1v0Ha2Suw0ztUjBEYAl1
	R66ZtSu3WIRPlIAHQf/C5teuLZKNp7vmjGNGP72wr9o5pesIT/nHPABJhjGXbfL7AkI=
X-Gm-Gg: AZuq6aLAvDxqzHKGHHJC3vVBsK/NvZD6vUOOxnFY4k9dMacJB/6SicN2EhANlD66osF
	/hSXtKKU4VJSKp4l94F+R8/ktYUwJY/8S4gpDwh3BADRh3/Xf/L0wo71rXrJTVTaQq1LI1iZhR+
	l4SQN2Naekx+/2D/jmwsNH2L5BZcV/ErSGKdEb1ydnT1HicVVLTK4l8/+HOIzkDZyryf9o0jS2R
	T0hOT3xyhGPfqgwxnRd0rXjPKcTTojS48cZXPEibyccXJGq4+zWgDLMZWLkC/6MZl6INY6fH/Gm
	H3J1anFVggbxSlATuSdcXgkbKoVIPrEv7j7AG7i9u79Yj/3xk2F0zkN6LQ4FFZEJIJW5UyA+oHh
	T+6CotcCUWoP5BGod1PAqSfh2d0HPoxmGDkzCQh7DSeFYsw6NPWJAsS/HD4PIdmblQvWThZL5OW
	rCY0hp3dWCutGCtkJqNKTMvx/stdEudOlNecJ1eBoc/7PA6juGKEtOm4aXl+ZSAeb3nEgIofjdu
	duoNGS5WojxQ5S8hppxqmI2pg==
X-Received: by 2002:ac8:5f8a:0:b0:4ed:b94c:774a with SMTP id d75a77b69052e-5070bba6830mr70961981cf.5.1771750225498;
        Sun, 22 Feb 2026 00:50:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:25 -0800 (PST)
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
Subject: [RFC PATCH v4 24/27] cxl/core: Add cxl_sysram region type
Date: Sun, 22 Feb 2026 03:48:39 -0500
Message-ID: <20260222084842.1824063-25-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14125-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC6C916EBF4
X-Rspamd-Action: no action

Add the CXL sysram region for direct memory hotplug of CXL RAM regions.

This region eliminates the intermediate dax_region/dax device layer by
directly performing memory hotplug operations.

Key features:
- Supports memory tier integration for proper NUMA placement
- Uses the CXL_SYSRAM_ONLINE_* Kconfig options for default online type
- Automatically hotplugs memory on probe if online type is configured
- Will be extended to support private memory nodes in the future

The driver registers a sysram_regionN device as a child of the CXL
region, managing the memory hotplug lifecycle through device add/remove.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile        |   1 +
 drivers/cxl/core/core.h          |   4 +
 drivers/cxl/core/port.c          |   2 +
 drivers/cxl/core/region_sysram.c | 351 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                |  48 +++++
 5 files changed, 406 insertions(+)
 create mode 100644 drivers/cxl/core/region_sysram.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index d3ec8aea64c5..d7ce52c50810 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -18,6 +18,7 @@ cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_REGION) += region_dax.o
 cxl_core-$(CONFIG_CXL_REGION) += region_pmem.o
+cxl_core-$(CONFIG_CXL_REGION) += region_sysram.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6e1f695fd155..973bbcae43f7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -35,6 +35,7 @@ extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
+extern const struct device_type cxl_sysram_type;
 extern const struct device_type cxl_region_type;
 
 int cxl_decoder_detach(struct cxl_region *cxlr,
@@ -46,6 +47,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
+#define CXL_SYSRAM_TYPE(x) (&cxl_sysram_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
@@ -54,6 +56,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
+int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
@@ -88,6 +91,7 @@ static inline void cxl_region_exit(void)
 #define SET_CXL_REGION_ATTR(x)
 #define CXL_PMEM_REGION_TYPE(x) NULL
 #define CXL_DAX_REGION_TYPE(x) NULL
+#define CXL_SYSRAM_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c82e6f32572..d6e82b3c2b64 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -66,6 +66,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_PMEM_REGION;
 	if (dev->type == CXL_DAX_REGION_TYPE())
 		return CXL_DEVICE_DAX_REGION;
+	if (dev->type == CXL_SYSRAM_TYPE())
+		return CXL_DEVICE_SYSRAM;
 	if (is_cxl_port(dev)) {
 		if (is_cxl_root(to_cxl_port(dev)))
 			return CXL_DEVICE_ROOT;
diff --git a/drivers/cxl/core/region_sysram.c b/drivers/cxl/core/region_sysram.c
new file mode 100644
index 000000000000..47a415deb352
--- /dev/null
+++ b/drivers/cxl/core/region_sysram.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
+/*
+ * CXL Sysram Region - Direct memory hotplug for CXL RAM regions
+ *
+ * This interface directly performs memory hotplug for CXL RAM regions,
+ * eliminating the indirection through DAX.
+ */
+
+#include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
+#include <linux/memory.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
+
+static const char *sysram_res_name = "System RAM (CXL)";
+
+/**
+ * cxl_region_find_sysram - Find the sysram device associated with a region
+ * @cxlr: The CXL region
+ *
+ * Finds and returns the sysram child device of a CXL region.
+ * The caller must release the device reference with put_device()
+ * when done with the returned pointer.
+ *
+ * Return: Pointer to cxl_sysram, or NULL if not found
+ */
+struct cxl_sysram *cxl_region_find_sysram(struct cxl_region *cxlr)
+{
+	struct cxl_sysram *sysram;
+	struct device *sdev;
+	char sname[32];
+
+	snprintf(sname, sizeof(sname), "sysram_region%d", cxlr->id);
+	sdev = device_find_child_by_name(&cxlr->dev, sname);
+	if (!sdev)
+		return NULL;
+
+	sysram = to_cxl_sysram(sdev);
+	return sysram;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_find_sysram, "CXL");
+
+static int sysram_get_numa_node(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int nid;
+
+	nid = phys_to_target_node(p->res->start);
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(p->res->start);
+
+	return nid;
+}
+
+static int sysram_hotplug_add(struct cxl_sysram *sysram, enum mmop online_type)
+{
+	struct resource *res;
+	mhp_t mhp_flags;
+	int rc;
+
+	if (sysram->res)
+		return -EBUSY;
+
+	res = request_mem_region(sysram->hpa_range.start,
+				 range_len(&sysram->hpa_range),
+				 sysram->res_name);
+	if (!res)
+		return -EBUSY;
+
+	sysram->res = res;
+
+	/*
+	 * Set flags appropriate for System RAM. Leave ..._BUSY clear
+	 * so that add_memory() can add a child resource.
+	 */
+	res->flags = IORESOURCE_SYSTEM_RAM;
+
+	mhp_flags = MHP_NID_IS_MGID;
+
+	/*
+	 * Ensure that future kexec'd kernels will not treat
+	 * this as RAM automatically.
+	 */
+	rc = __add_memory_driver_managed(sysram->mgid,
+					 sysram->hpa_range.start,
+					 range_len(&sysram->hpa_range),
+					 sysram_res_name, mhp_flags,
+					 online_type);
+	if (rc) {
+		remove_resource(res);
+		kfree(res);
+		sysram->res = NULL;
+		return rc;
+	}
+
+	return 0;
+}
+
+static int sysram_hotplug_remove(struct cxl_sysram *sysram)
+{
+	int rc;
+
+	if (!sysram->res)
+		return 0;
+
+	rc = offline_and_remove_memory(sysram->hpa_range.start,
+				       range_len(&sysram->hpa_range));
+	if (rc)
+		return rc;
+
+	if (sysram->res) {
+		remove_resource(sysram->res);
+		kfree(sysram->res);
+		sysram->res = NULL;
+	}
+
+	return 0;
+}
+
+int cxl_sysram_offline_and_remove(struct cxl_sysram *sysram)
+{
+	return sysram_hotplug_remove(sysram);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_sysram_offline_and_remove, "CXL");
+
+static void cxl_sysram_release(struct device *dev)
+{
+	struct cxl_sysram *sysram = to_cxl_sysram(dev);
+
+	if (sysram->res)
+		sysram_hotplug_remove(sysram);
+
+	kfree(sysram->res_name);
+
+	if (sysram->mgid >= 0)
+		memory_group_unregister(sysram->mgid);
+
+	if (sysram->mtype)
+		clear_node_memory_type(sysram->numa_node, sysram->mtype);
+
+	kfree(sysram);
+}
+
+static ssize_t hotplug_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct cxl_sysram *sysram = to_cxl_sysram(dev);
+	int online_type, rc;
+
+	online_type = mhp_online_type_from_str(buf);
+	if (online_type < 0)
+		return online_type;
+
+	if (online_type == MMOP_OFFLINE)
+		rc = sysram_hotplug_remove(sysram);
+	else
+		rc = sysram_hotplug_add(sysram, online_type);
+
+	if (rc)
+		dev_warn(dev, "hotplug %s failed: %d\n",
+			 online_type == MMOP_OFFLINE ? "offline" : "online", rc);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(hotplug);
+
+static struct attribute *cxl_sysram_attrs[] = {
+	&dev_attr_hotplug.attr,
+	NULL
+};
+
+static const struct attribute_group cxl_sysram_attribute_group = {
+	.attrs = cxl_sysram_attrs,
+};
+
+static const struct attribute_group *cxl_sysram_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	&cxl_sysram_attribute_group,
+	NULL
+};
+
+const struct device_type cxl_sysram_type = {
+	.name = "cxl_sysram",
+	.release = cxl_sysram_release,
+	.groups = cxl_sysram_attribute_groups,
+};
+
+static bool is_cxl_sysram(struct device *dev)
+{
+	return dev->type == &cxl_sysram_type;
+}
+
+struct cxl_sysram *to_cxl_sysram(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_sysram(dev),
+			  "not a cxl_sysram device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_sysram, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_sysram, "CXL");
+
+struct device *cxl_sysram_dev(struct cxl_sysram *sysram)
+{
+	return &sysram->dev;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_sysram_dev, "CXL");
+
+static struct lock_class_key cxl_sysram_key;
+
+static enum mmop cxl_sysram_get_default_online_type(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_SYSRAM_ONLINE_TYPE_SYSTEM_DEFAULT))
+		return mhp_get_default_online_type();
+	if (IS_ENABLED(CONFIG_CXL_SYSRAM_ONLINE_TYPE_MOVABLE))
+		return MMOP_ONLINE_MOVABLE;
+	if (IS_ENABLED(CONFIG_CXL_SYSRAM_ONLINE_TYPE_NORMAL))
+		return MMOP_ONLINE;
+	return MMOP_OFFLINE;
+}
+
+static struct cxl_sysram *cxl_sysram_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_sysram *sysram __free(kfree) = NULL;
+	struct device *dev;
+
+	sysram = kzalloc(sizeof(*sysram), GFP_KERNEL);
+	if (!sysram)
+		return ERR_PTR(-ENOMEM);
+
+	sysram->online_type = cxl_sysram_get_default_online_type();
+	sysram->last_hotplug_cmd = MMOP_OFFLINE;
+	sysram->numa_node = -1;
+	sysram->mgid = -1;
+
+	dev = &sysram->dev;
+	sysram->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_sysram_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_sysram_type;
+
+	return_ptr(sysram);
+}
+
+static void sysram_unregister(void *_sysram)
+{
+	struct cxl_sysram *sysram = _sysram;
+
+	device_unregister(&sysram->dev);
+}
+
+int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type)
+{
+	struct cxl_sysram *sysram __free(put_cxl_sysram) = NULL;
+	struct memory_dev_type *mtype;
+	struct range hpa_range;
+	struct device *dev;
+	int adist = MEMTIER_DEFAULT_LOWTIER_ADISTANCE;
+	int numa_node;
+	int rc;
+
+	rc = cxl_region_get_hpa_range(cxlr, &hpa_range);
+	if (rc)
+		return rc;
+
+	hpa_range = memory_block_align_range(&hpa_range);
+	if (hpa_range.start >= hpa_range.end) {
+		dev_warn(&cxlr->dev, "region too small after alignment\n");
+		return -ENOSPC;
+	}
+
+	sysram = cxl_sysram_alloc(cxlr);
+	if (IS_ERR(sysram))
+		return PTR_ERR(sysram);
+
+	sysram->hpa_range = hpa_range;
+
+	sysram->res_name = kasprintf(GFP_KERNEL, "cxl_sysram%d", cxlr->id);
+	if (!sysram->res_name)
+		return -ENOMEM;
+
+	/* Override default online type if caller specified one */
+	if (online_type >= 0)
+		sysram->online_type = online_type;
+
+	dev = &sysram->dev;
+
+	rc = dev_set_name(dev, "sysram_region%d", cxlr->id);
+	if (rc)
+		return rc;
+
+	/* Setup memory tier before adding device */
+	numa_node = sysram_get_numa_node(cxlr);
+	if (numa_node < 0) {
+		dev_warn(&cxlr->dev, "rejecting region with invalid node: %d\n",
+			 numa_node);
+		return -EINVAL;
+	}
+	sysram->numa_node = numa_node;
+
+	mt_calc_adistance(numa_node, &adist);
+	mtype = mt_get_memory_type(adist);
+	if (IS_ERR(mtype))
+		return PTR_ERR(mtype);
+	sysram->mtype = mtype;
+
+	init_node_memory_type(numa_node, mtype);
+
+	/* Register memory group for this region */
+	rc = memory_group_register_static(numa_node,
+					  PFN_UP(range_len(&hpa_range)));
+	if (rc < 0)
+		return rc;
+	sysram->mgid = rc;
+
+	rc = device_add(dev);
+	if (rc)
+		return rc;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	/*
+	 * Dynamic capacity regions (DCD) will have memory added later.
+	 * For static RAM regions, hotplug the entire range now.
+	 */
+	if (cxlr->mode != CXL_PARTMODE_RAM)
+		goto out;
+
+	/* If default online_type is a valid online mode, immediately hotplug */
+	if (sysram->online_type > MMOP_OFFLINE) {
+		rc = sysram_hotplug_add(sysram, sysram->online_type);
+		if (rc)
+			dev_warn(dev, "hotplug failed: %d\n", rc);
+		else
+			sysram->last_hotplug_cmd = sysram->online_type;
+	}
+
+out:
+	return devm_add_action_or_reset(&cxlr->dev, sysram_unregister,
+					no_free_ptr(sysram));
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_sysram, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f899f240f229..8e8342fd4fde 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -607,6 +607,34 @@ struct cxl_dax_region {
 	enum dax_driver_type dax_driver;
 };
 
+/**
+ * struct cxl_sysram - CXL SysRAM region for system memory hotplug
+ * @dev: device for this sysram
+ * @cxlr: parent cxl_region
+ * @online_type: Default memory online type for new hotplug ops (MMOP_* value)
+ * @last_hotplug_cmd: Last hotplug command submitted (MMOP_* value)
+ * @hpa_range: Host physical address range for the region
+ * @res_name: Resource name for the memory region
+ * @res: Memory resource (set when hotplugged)
+ * @mgid: Memory group id
+ * @mtype: Memory tier type
+ * @numa_node: NUMA node for this memory
+ *
+ * Device that directly performs memory hotplug for CXL RAM regions.
+ */
+struct cxl_sysram {
+	struct device dev;
+	struct cxl_region *cxlr;
+	enum mmop online_type;
+	int last_hotplug_cmd;
+	struct range hpa_range;
+	const char *res_name;
+	struct resource *res;
+	int mgid;
+	struct memory_dev_type *mtype;
+	int numa_node;
+};
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -807,6 +835,7 @@ DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_sysram, struct cxl_sysram *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
@@ -889,6 +918,7 @@ void cxl_destroy_region(struct cxl_region *cxlr);
 struct device *cxl_region_dev(struct cxl_region *cxlr);
 enum cxl_partition_mode cxl_region_mode(struct cxl_region *cxlr);
 int cxl_get_region_range(struct cxl_region *cxlr, struct range *range);
+struct cxl_sysram *cxl_region_find_sysram(struct cxl_region *cxlr);
 int cxl_get_committed_regions(struct cxl_memdev *cxlmd,
 			      struct cxl_region **regions, int max_regions);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
@@ -936,6 +966,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_SYSRAM		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -954,6 +985,10 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+struct cxl_sysram *to_cxl_sysram(struct device *dev);
+struct device *cxl_sysram_dev(struct cxl_sysram *sysram);
+int devm_cxl_add_sysram(struct cxl_region *cxlr, enum mmop online_type);
+int cxl_sysram_offline_and_remove(struct cxl_sysram *sysram);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -972,6 +1007,19 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline struct cxl_sysram *to_cxl_sysram(struct device *dev)
+{
+	return NULL;
+}
+static inline int devm_cxl_add_sysram(struct cxl_region *cxlr,
+				      enum mmop online_type)
+{
+	return -ENXIO;
+}
+static inline int cxl_sysram_offline_and_remove(struct cxl_sysram *sysram)
+{
+	return -ENXIO;
+}
 static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 					       u64 spa)
 {
-- 
2.53.0


