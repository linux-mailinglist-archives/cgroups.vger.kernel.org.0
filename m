Return-Path: <cgroups+bounces-14127-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jk3E5DFmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14127-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 10:00:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7214C16EC1B
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD2DF30A8FF5
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7B274B2A;
	Sun, 22 Feb 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oozgOm/M"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7A22E3F0
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750236; cv=none; b=m0rw16uWLPpleS37wN46TpcGlNhwEpU4Le0GRnSRnKLchyTcEb5+s1UV6wq4RmEUJD1b45yt7sPpQS0vfKHPzIcNsbgaxgK9lrVPacykZXJNQEnvO+/gvK08BKja8GFmhgjhOkWRoVL6iqbXPmdo017a22jRekIdAymjbXE+oxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750236; c=relaxed/simple;
	bh=BD1MVTGwTR55TmPK5/rBN1KO8hZFn4MwwvbhIkc9tdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1EPQE+zDuL9wNSZVXv/nfEYk/POL5ER+FZC9qjCVQZ3+qsb764aqLklnf2UXQiXfEu8tUFmRoasGvtJFXrLvJHsOHyPnCowrNxKmE2d7GxLnheOSsSwceZcQ3h585xONEV3V6P85/nzn4oiUmQRb6aZq2IcVyKBJYi1jh4q7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oozgOm/M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506251815a3so32516381cf.0
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750234; x=1772355034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYiMdgFVvusXEx98vFRcNZk0pTiGBH9Jq4UQYwtGtaw=;
        b=oozgOm/MLFYG4RK66UZixSN/6xv3vSgrmH8/d6TUug4WeQCcljLjuSoCHdq5FFnBxi
         iITRzWSR9NAyrgVACEMdVUfiE7Qgl0NxeWmwiKOpYjvxUuu4GfgxgzCsOKps7h2o2GNx
         sYWefSiLUwG2AC2E6TUccsf3APei67YwJI5hqi36iyBNYZEx2uAdAesjP4P19WK7wXuk
         r0/uE9P43F3KgJjhAHu+oFluC7Jq946p7O7DeR9YCUy5Nh50Kwy83ZHELlmjxsizpLiW
         XKn52WLmtB4qX5ISTFP/0Wuqx3c5SV3c4kd4ANbx+R/qHjd8nVmiVdYty1klSCcY1o4i
         hz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750234; x=1772355034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYiMdgFVvusXEx98vFRcNZk0pTiGBH9Jq4UQYwtGtaw=;
        b=Ftj38IvW+Aa52zxzm+rgAgzf3KwtzKw5PF1bAjJFN5VUv01jmOyioM6ZkKpAjonfLS
         7o4H8r/GMECT35IlwETM2R9DS/rX8BgsgE/4mlSwXVeCVLHqtGHPJP75TR3vKv0kYBTs
         VgvSfRcLwkJqL6/hJxWp1+29xL3dt5Ilemcm47TOWo1rCF6R6Fqx5INqhYeh+8fDe0Qi
         AOnEPJoa1uDwfGx/qRPWOE6UQ4Tmb1vpS/kuA8t636uOmToBrwbNj4E6wJKhggji+7/C
         r83pW3hyv4PQM02CF6t4rqwg1zvYqFrlce9ilQSRd7w0DoJV4euXPFNO0khhuZ4leysf
         fxHA==
X-Forwarded-Encrypted: i=1; AJvYcCUFAFJ94OF64NToxw67FPrZTS0QORlm7zqGxTjQthI9gWKGI/rW/KN7Hqz//I/dzinUixPlojcM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gl9ld0XjtP+hBWbq5d/CmVjCgu9xmq/lGkQSPMcfofBvIyta
	gUQpjWhfNpVU2bRTO7VM2dKiUN/0XhzyHaVL8u0oppBwdIvJiQJXEK8R5I/SJ9jjTE32MCNS8oX
	tzrj8
X-Gm-Gg: AZuq6aKLTRLnN2VuEmtSsggfIaHQwrozEUYQI8CU6vbju0zmEne8VxJVTNkABaBSB9M
	LLceyCxHZEb9vuYJIU2UAxraIuayPnBMqOpW7H1WqvKPzMIYiMn9zoxLEA1+Gh5lXRrI45ji8XH
	mw2/7UF+VPz6/ZNXOWLWF0a5bePYWiUBOKCqO5CnCXO41os6rBeJ22u9LpsZaH78MpsL6FMPjHk
	MnwmPcAPrB1QpNS07Yqwyl6jpQahqK11Wty4f2vNJNAhf1EYuW6957IjsF2jcIe2fEC5efOAHk7
	bUui5OGzizq5sd4ZEsroVj596OH3cwTlN9dCEWeyvr95JkgYVW+cY6nDPvEb9TtjwNxXV9zUKhg
	C1OZTKb5iiOk8OeV9yyWnOARWJYIKC9dOjgg28WG017ORgWu3dh0xFCD2gEoznoy4yHt2VGXtqv
	bMQOoYxjx16olp2UQmsTXke4NNJwooL6bXnWno06zDg0DiySXV9V77zSb9hyYjAT6EsJXi5Uub1
	5DEY1/gw5M/Dqs=
X-Received: by 2002:ac8:5711:0:b0:506:21ff:af13 with SMTP id d75a77b69052e-5070bba24cemr71385411cf.1.1771750233590;
        Sun, 22 Feb 2026 00:50:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:33 -0800 (PST)
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
Subject: [RFC PATCH v4 26/27] cxl: add cxl_mempolicy sample PCI driver
Date: Sun, 22 Feb 2026 03:48:41 -0500
Message-ID: <20260222084842.1824063-27-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14127-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7214C16EC1B
X-Rspamd-Action: no action

Add a sample CXL type-3 driver that registers device memory as
private-node NUMA memory reachable only via explicit mempolicy
(set_mempolicy / mbind).

Probe flow:
  1. Call cxl_pci_type3_probe_init() for standard CXL device setup
  2. Look for pre-committed RAM regions; if none exist, create one
     using cxl_get_hpa_freespace() + cxl_request_dpa() +
     cxl_create_region()
  3. Convert the region to sysram via devm_cxl_add_sysram() with
     private=true and MMOP_ONLINE_MOVABLE
  4. Register node_private_ops with NP_OPS_MIGRATION | NP_OPS_MEMPOLICY
     so the node is excluded from default allocations

The migrate_to callback uses alloc_migration_target() with
__GFP_THISNODE | __GFP_PRIVATE to keep pages on the target node.

Move struct migration_target_control from mm/internal.h to
include/linux/migrate.h so the driver can use alloc_migration_target()
without depending on mm-internal headers.

Usage:
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_mempolicy/bind

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/Kconfig                           |   2 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/type3_drivers/Kconfig             |   2 +
 drivers/cxl/type3_drivers/Makefile            |   2 +
 .../cxl/type3_drivers/cxl_mempolicy/Kconfig   |  16 +
 .../cxl/type3_drivers/cxl_mempolicy/Makefile  |   4 +
 .../type3_drivers/cxl_mempolicy/mempolicy.c   | 297 ++++++++++++++++++
 include/linux/migrate.h                       |   7 +-
 mm/internal.h                                 |   7 -
 9 files changed, 331 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cxl/type3_drivers/Kconfig
 create mode 100644 drivers/cxl/type3_drivers/Makefile
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index f99aa7274d12..1648cdeaa0c9 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -278,4 +278,6 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+source "drivers/cxl/type3_drivers/Kconfig"
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..94d2b2233bf8 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -19,3 +19,5 @@ cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+
+obj-y += type3_drivers/
diff --git a/drivers/cxl/type3_drivers/Kconfig b/drivers/cxl/type3_drivers/Kconfig
new file mode 100644
index 000000000000..369b21763856
--- /dev/null
+++ b/drivers/cxl/type3_drivers/Kconfig
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+source "drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig"
diff --git a/drivers/cxl/type3_drivers/Makefile b/drivers/cxl/type3_drivers/Makefile
new file mode 100644
index 000000000000..2b82265ff118
--- /dev/null
+++ b/drivers/cxl/type3_drivers/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_MEMPOLICY) += cxl_mempolicy/
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig b/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
new file mode 100644
index 000000000000..3c45da237b9f
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
@@ -0,0 +1,16 @@
+config CXL_MEMPOLICY
+	tristate "CXL Private Memory with Mempolicy Support"
+	depends on CXL_PCI
+	depends on CXL_REGION
+	depends on NUMA
+	depends on MIGRATION
+	help
+	  Minimal driver for CXL memory devices that registers memory as
+	  N_MEMORY_PRIVATE with mempolicy support.  The memory is isolated
+	  from default allocations and can only be reached via explicit
+	  mempolicy (set_mempolicy or mbind).
+
+	  No compression, no PTE controls, the memory behaves like normal
+	  DRAM but is excluded from fallback allocations.
+
+	  If unsure say 'n'.
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile b/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
new file mode 100644
index 000000000000..dfb58fc88ad9
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_MEMPOLICY) += cxl_mempolicy.o
+cxl_mempolicy-y := mempolicy.o
+ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c b/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c
new file mode 100644
index 000000000000..1c19818eb268
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
+/*
+ * CXL Mempolicy Driver
+ *
+ * Minimal driver for CXL memory devices that registers memory as
+ * N_MEMORY_PRIVATE with mempolicy support but no PTE controls.  The
+ * memory behaves like normal DRAM but is isolated from default allocations,
+ * it can only be reached via explicit mempolicy (set_mempolicy/mbind).
+ *
+ * Usage:
+ *   1. Unbind device from cxl_pci:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
+ *   2. Bind to cxl_mempolicy:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_mempolicy/bind
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/xarray.h>
+#include <linux/node_private.h>
+#include <linux/migrate.h>
+#include <cxl/mailbox.h>
+#include "cxlmem.h"
+#include "cxl.h"
+
+struct cxl_mempolicy_ctx {
+	struct cxl_region *cxlr;
+	struct cxl_endpoint_decoder *cxled;
+	int nid;
+};
+
+static DEFINE_XARRAY(ctx_xa);
+
+static struct cxl_mempolicy_ctx *memdev_to_ctx(struct cxl_memdev *cxlmd)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);
+
+	return xa_load(&ctx_xa, (unsigned long)pdev);
+}
+
+static int cxl_mempolicy_migrate_to(struct list_head *folios, int nid,
+				    enum migrate_mode mode,
+				    enum migrate_reason reason,
+				    unsigned int *nr_succeeded)
+{
+	struct migration_target_control mtc = {
+		.nid = nid,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE |
+			    __GFP_PRIVATE,
+		.reason = reason,
+	};
+
+	return migrate_pages(folios, alloc_migration_target, NULL,
+			     (unsigned long)&mtc, mode, reason, nr_succeeded);
+}
+
+static void cxl_mempolicy_folio_migrate(struct folio *src, struct folio *dst)
+{
+}
+
+static const struct node_private_ops cxl_mempolicy_ops = {
+	.migrate_to	= cxl_mempolicy_migrate_to,
+	.folio_migrate	= cxl_mempolicy_folio_migrate,
+	.flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
+};
+
+static struct cxl_region *create_ram_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mempolicy_ctx *ctx = memdev_to_ctx(cxlmd);
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	resource_size_t ram_size, avail;
+
+	ram_size = cxl_ram_size(cxlmd->cxlds);
+	if (ram_size == 0) {
+		dev_info(&cxlmd->dev, "no RAM capacity available\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ram_size = ALIGN_DOWN(ram_size, SZ_256M);
+	if (ram_size == 0) {
+		dev_info(&cxlmd->dev,
+			 "RAM capacity too small (< 256M)\n");
+		return ERR_PTR(-ENOSPC);
+	}
+
+	dev_info(&cxlmd->dev, "creating RAM region for %lld MB\n",
+		 ram_size >> 20);
+
+	cxlrd = cxl_get_hpa_freespace(cxlmd, ram_size, &avail);
+	if (IS_ERR(cxlrd)) {
+		dev_err(&cxlmd->dev, "no HPA freespace: %ld\n",
+			PTR_ERR(cxlrd));
+		return ERR_CAST(cxlrd);
+	}
+
+	cxled = cxl_request_dpa(cxlmd, CXL_PARTMODE_RAM, ram_size);
+	if (IS_ERR(cxled)) {
+		dev_err(&cxlmd->dev, "failed to request DPA: %ld\n",
+			PTR_ERR(cxled));
+		cxl_put_root_decoder(cxlrd);
+		return ERR_CAST(cxled);
+	}
+
+	cxlr = cxl_create_region(cxlrd, &cxled, 1);
+	cxl_put_root_decoder(cxlrd);
+	if (IS_ERR(cxlr)) {
+		dev_err(&cxlmd->dev, "failed to create region: %ld\n",
+			PTR_ERR(cxlr));
+		cxl_dpa_free(cxled);
+		return cxlr;
+	}
+
+	ctx->cxled = cxled;
+	dev_info(&cxlmd->dev, "created region %s\n",
+		 dev_name(cxl_region_dev(cxlr)));
+	return cxlr;
+}
+
+static int setup_private_node(struct cxl_memdev *cxlmd,
+			      struct cxl_region *cxlr)
+{
+	struct cxl_mempolicy_ctx *ctx = memdev_to_ctx(cxlmd);
+	struct range hpa_range;
+	int rc;
+
+	device_release_driver(cxl_region_dev(cxlr));
+
+	rc = devm_cxl_add_sysram(cxlr, true, MMOP_ONLINE_MOVABLE);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to add sysram: %d\n", rc);
+		if (device_attach(cxl_region_dev(cxlr)) < 0)
+			dev_warn(cxl_region_dev(cxlr),
+				 "failed to re-attach driver\n");
+		return rc;
+	}
+
+	rc = cxl_get_region_range(cxlr, &hpa_range);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to get region range: %d\n", rc);
+		return rc;
+	}
+
+	ctx->nid = phys_to_target_node(hpa_range.start);
+	if (ctx->nid == NUMA_NO_NODE)
+		ctx->nid = memory_add_physaddr_to_nid(hpa_range.start);
+
+	rc = node_private_set_ops(ctx->nid, &cxl_mempolicy_ops);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to set ops on node %d: %d\n", ctx->nid, rc);
+		ctx->nid = NUMA_NO_NODE;
+		return rc;
+	}
+
+	dev_info(&cxlmd->dev,
+		 "node %d registered as private mempolicy memory\n", ctx->nid);
+	return 0;
+}
+
+static int cxl_mempolicy_attach_probe(struct cxl_memdev *cxlmd)
+{
+	struct cxl_region *regions[8];
+	struct cxl_region *cxlr;
+	int nr, i;
+	int rc;
+
+	dev_info(&cxlmd->dev,
+		 "cxl_mempolicy attach: looking for regions\n");
+
+	/* Phase 1: look for pre-committed RAM regions */
+	nr = cxl_get_committed_regions(cxlmd, regions, ARRAY_SIZE(regions));
+	for (i = 0; i < nr; i++) {
+		if (cxl_region_mode(regions[i]) != CXL_PARTMODE_RAM) {
+			put_device(cxl_region_dev(regions[i]));
+			continue;
+		}
+
+		cxlr = regions[i];
+		rc = setup_private_node(cxlmd, cxlr);
+		put_device(cxl_region_dev(cxlr));
+		if (rc == 0) {
+			/* Release remaining region references */
+			for (i++; i < nr; i++)
+				put_device(cxl_region_dev(regions[i]));
+			return 0;
+		}
+	}
+
+	/* Phase 2: no committed regions, create one */
+	dev_info(&cxlmd->dev,
+		 "no existing regions, creating RAM region\n");
+
+	cxlr = create_ram_region(cxlmd);
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		if (rc == -ENODEV) {
+			dev_info(&cxlmd->dev,
+				 "no RAM capacity: %d\n", rc);
+			return 0;
+		}
+		return rc;
+	}
+
+	rc = setup_private_node(cxlmd, cxlr);
+	if (rc) {
+		dev_err(&cxlmd->dev,
+			"failed to setup private node: %d\n", rc);
+		return rc;
+	}
+
+	/* Only take ownership of regions we created (Phase 2) */
+	memdev_to_ctx(cxlmd)->cxlr = cxlr;
+
+	return 0;
+}
+
+static const struct cxl_memdev_attach cxl_mempolicy_attach = {
+	.probe = cxl_mempolicy_attach_probe,
+};
+
+static int cxl_mempolicy_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct cxl_mempolicy_ctx *ctx;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	dev_info(&pdev->dev, "cxl_mempolicy: probing device\n");
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->nid = NUMA_NO_NODE;
+
+	rc = xa_insert(&ctx_xa, (unsigned long)pdev, ctx, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	cxlmd = cxl_pci_type3_probe_init(pdev, &cxl_mempolicy_attach);
+	if (IS_ERR(cxlmd)) {
+		xa_erase(&ctx_xa, (unsigned long)pdev);
+		return PTR_ERR(cxlmd);
+	}
+
+	dev_info(&pdev->dev, "cxl_mempolicy: probe complete\n");
+	return 0;
+}
+
+static void cxl_mempolicy_remove(struct pci_dev *pdev)
+{
+	struct cxl_mempolicy_ctx *ctx = xa_erase(&ctx_xa, (unsigned long)pdev);
+
+	dev_info(&pdev->dev, "cxl_mempolicy: removing device\n");
+
+	if (!ctx)
+		return;
+
+	if (ctx->nid != NUMA_NO_NODE)
+		WARN_ON(node_private_clear_ops(ctx->nid, &cxl_mempolicy_ops));
+
+	if (ctx->cxlr) {
+		cxl_destroy_region(ctx->cxlr);
+		ctx->cxlr = NULL;
+	}
+
+	if (ctx->cxled) {
+		cxl_dpa_free(ctx->cxled);
+		ctx->cxled = NULL;
+	}
+}
+
+static const struct pci_device_id cxl_mempolicy_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0d93) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_mempolicy_pci_tbl);
+
+static struct pci_driver cxl_mempolicy_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= cxl_mempolicy_pci_tbl,
+	.probe		= cxl_mempolicy_probe,
+	.remove		= cxl_mempolicy_remove,
+	.driver	= {
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_pci_driver(cxl_mempolicy_driver);
+
+MODULE_DESCRIPTION("CXL: Private Memory with Mempolicy Support");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7b2da3875ff2..1f9fb61f3932 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,7 +10,12 @@
 typedef struct folio *new_folio_t(struct folio *folio, unsigned long private);
 typedef void free_folio_t(struct folio *folio, unsigned long private);
 
-struct migration_target_control;
+struct migration_target_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+	enum migrate_reason reason;
+};
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/mm/internal.h b/mm/internal.h
index 64467ca774f1..85cd11189854 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1352,13 +1352,6 @@ extern const struct trace_print_flags gfpflag_names[];
 
 void setup_zone_pageset(struct zone *zone);
 
-struct migration_target_control {
-	int nid;		/* preferred node id */
-	nodemask_t *nmask;
-	gfp_t gfp_mask;
-	enum migrate_reason reason;
-};
-
 /*
  * mm/filemap.c
  */
-- 
2.53.0


