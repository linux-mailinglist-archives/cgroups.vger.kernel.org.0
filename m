Return-Path: <cgroups+bounces-14128-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OPiFSfFmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14128-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:58:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD516EBE6
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D461C3063AC9
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE824A069;
	Sun, 22 Feb 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="i6aT9/J5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995122773FF
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750241; cv=none; b=CXXhyfeC0D1F1zmHLPJBUjnx3kjEKj6FNU/XefzGP7zPgjL3/AQ+2ddDhDnCIQ0RShN1BFnvveBm8SSVhy5kAkpUFAV60MVmyBInB9nR8PaQvfFImF8FUZYB7RXBQfdEN6JATW2RGqTZizNemfaB6BxUjgZOnFEtqvvdvJwT/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750241; c=relaxed/simple;
	bh=L39OSoun5mIdNUdUOii/YFUFnjn5985tCIlOqzIkR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgOe8RaOUjjh7GJAZhlRrFLHBA1LYhf9Lwz+rVbRst5cp5gs26NMpzlcte/7oXNqfgIRX3ZfkxbaOPSGxBsAurUWzZLQYAbPfYrrImqI9HPiNxJx4V36UfTw78PDBlfA5JGwdpQx3qa0+j48qMooYS6DVX+7yqJoUWcVOHRW+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=i6aT9/J5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5069ad750b7so30025561cf.2
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750237; x=1772355037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA1eNtOuG/uqMtPYaXXL4O8NEWGMm6Tbd8ozL7DNrg8=;
        b=i6aT9/J5xws4obu8ruADP65rYh3zKyws88wQhtr64fcuAwOcDGH70ytcX4NP+j68/A
         Td7eaKjqdFujPyEkqU+AbQzYJGglgtWw9pyIhjT2yzeV7NeH7dgK9as3TrvF7xORp6Vs
         N7cTBu8kyzkwGtTU4XO6P3r3fLscvzxdjVx5rEibAAU12duXIZcEKXGdwMEvUaVbEgDw
         YN7gRJhAnYIlMLHawt1q2DAw1mSt5k4LFd2fxObCo2LBzfR2zHX52SrRH6rDjNekU6Mw
         w/pUVj7dGDC4ezRQmED0ezcxB0jPrNhbkWv1NHjyxBULozfZVnwg0jhuLpqsxh5Dxpmn
         I0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750237; x=1772355037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SA1eNtOuG/uqMtPYaXXL4O8NEWGMm6Tbd8ozL7DNrg8=;
        b=sET+p7gyOD5zYwDoY2yVliEe+NqWdgxaMrndS1etourlJuDUl22w+fDgHbQO2KdtMl
         Yqvec3Hq+cBfB+vOqJGRx8f2hRARZO98OayjlE6A+4SVJBrGWPqAcauhHCSp1R+co90n
         OKwAsuIVAWsYP88trpEF2bEHS7h4DOQ0hbFdtXB4MxampEply4Euerujm3icUjEuXG+8
         WoT92kRKP4/Poje2opxEteXhVWSwzq9ogeqnTM+ZBaMkdUc7BQYN1pAvhbqS4EJvRDBW
         7QA4FSj0VBrJZabZO02TPEnTqe7p/3NO6kbrvbOAmRLFsmnl4LTmkpWtFma3yhydx30e
         XwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP7MyO/AZqvcUQyMYX0yeee6pvw8zS8ocUk+b1g0TRKlKKnt3oOAj0czwUEeuBqHGafiZeqMo9@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcgFocNPLkRxtw+OoRyB/ZLfAtrGV6mT/tIxT+0OOefPGJjHN
	MmOq9bA72i/pXaABgfv7n+J00MpelgKQ0mS4oxrDmbViOqmXwRtwsdULeBSSxFbLYoM=
X-Gm-Gg: AZuq6aIkbxwcgP5pRrpJxbsW7gPXbTp1WuCU7tn/hpAKGR1yh42aFFxTWJSv54lgBEM
	bw+5vuNNDdlgZhH37Nnp1Kh7rxvUbCsAlg3O5pGkatFN4v8tP1lNw7kO6XllSagNn/ltx69brTC
	tGPRwlT5TLDxZe9d3vuzqePwCWeLsUQc8pk+yT6UmPBpLQXqJ4e/EZ68VvgC8bOB2wt7gk9iyMk
	HHDpjpZEjTqpFm5h1cLmoyPZK76AcWjcWOuHRRQ7h+313rD9mdeKiJexjOZtP7XEOMqf4k2A5Xf
	S8+QuU3rJ5rXFhL++NAVSZjnzxxjoZgR1758Hj7zFaBpfgnsxutKBtkysuV7cFxaD/G/SJFUzGy
	1UHDT89/ql2dAVjXzvVzhflJI5n4HS1C37ezJiwinTO7xp4jRy7/a23UvMnn3B4Lf4PkAYElJnG
	2HkWUVWTBRb40sPQ77rcQtyiJ/qjyG9TOC78VPnRLSqDIqqMdRpU8nlVQbdb/uXePjGLFzysTyd
	XpKOhMrvELrLKY=
X-Received: by 2002:ac8:7c55:0:b0:501:3b8c:7d72 with SMTP id d75a77b69052e-5070bbdb9e4mr72387751cf.27.1771750237141;
        Sun, 22 Feb 2026 00:50:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:36 -0800 (PST)
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
Subject: [RFC PATCH v4 27/27] cxl: add cxl_compression PCI driver
Date: Sun, 22 Feb 2026 03:48:42 -0500
Message-ID: <20260222084842.1824063-28-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14128-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: C4DD516EBE6
X-Rspamd-Action: no action

Add a generic CXL type-3 driver for compressed memory controllers.

The driver provides an alternative PCI binding that converts CXL
RAM regions to private-node sysram and registers them with the
CRAM subsystem for transparent demotion/promotion.

Probe flow:
  1. cxl_pci_type3_probe_init() for standard CXL device setup
  2. Discover/convert auto-RAM regions or create a RAM region
  3. Convert to private-node sysram via devm_cxl_add_sysram()
  4. Register with CRAM via cram_register_private_node()

Page flush pipeline:
  When a CRAM folio is freed, the CRAM free_folio   callback buffers
  it into a per-CPU RCU-protected flush buffer to offload the operation.

  A periodic kthread swaps the per-CPU buffers under RCU, then sends
  batched Sanitize-Zero commands so the device can zero pages.

  A flush_record bitmap tracks in-flight pages to avoid re-buffering on
  the second free_folio entry after folio_put().

  Overflow from full buffers is handled by a per-CPU workqueue fallback.

Watermark interrupts:
  MSI-X vector 12 - delivers "Low" watermark interrupts
  MSI-X vector 13 - delivers "High" watermark interrupts
  This adjusts CRAM pressure:
	Low  - increases pressure.
  	High - reduces pressure.

  A dynamic watermark mode cycles through four phases with
  progressively tighter thresholds.

  Static watermark mode sets pressure 0 or MAX respectively.

Teardown ordering:
  pre_teardown  - cram_unregister + retry-loop memory offline
  post_teardown - kthread stop, drain all flush buffers via CCI

Usage:
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_compression/bind

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/type3_drivers/Kconfig             |    1 +
 drivers/cxl/type3_drivers/Makefile            |    1 +
 .../cxl/type3_drivers/cxl_compression/Kconfig |   20 +
 .../type3_drivers/cxl_compression/Makefile    |    4 +
 .../cxl_compression/compression.c             | 1025 +++++++++++++++++
 5 files changed, 1051 insertions(+)
 create mode 100644 drivers/cxl/type3_drivers/cxl_compression/Kconfig
 create mode 100644 drivers/cxl/type3_drivers/cxl_compression/Makefile
 create mode 100644 drivers/cxl/type3_drivers/cxl_compression/compression.c

diff --git a/drivers/cxl/type3_drivers/Kconfig b/drivers/cxl/type3_drivers/Kconfig
index 369b21763856..98f73e46730e 100644
--- a/drivers/cxl/type3_drivers/Kconfig
+++ b/drivers/cxl/type3_drivers/Kconfig
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 source "drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig"
+source "drivers/cxl/type3_drivers/cxl_compression/Kconfig"
diff --git a/drivers/cxl/type3_drivers/Makefile b/drivers/cxl/type3_drivers/Makefile
index 2b82265ff118..f5b0766d92af 100644
--- a/drivers/cxl/type3_drivers/Makefile
+++ b/drivers/cxl/type3_drivers/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_MEMPOLICY) += cxl_mempolicy/
+obj-$(CONFIG_CXL_COMPRESSION) += cxl_compression/
diff --git a/drivers/cxl/type3_drivers/cxl_compression/Kconfig b/drivers/cxl/type3_drivers/cxl_compression/Kconfig
new file mode 100644
index 000000000000..8c891a48b000
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_compression/Kconfig
@@ -0,0 +1,20 @@
+config CXL_COMPRESSION
+	tristate "CXL Compression Memory Driver"
+	depends on CXL_PCI
+	depends on CXL_REGION
+	depends on CRAM
+	help
+	  This driver provides an alternative PCI binding for CXL memory
+	  devices with compressed memory support. It converts CXL RAM
+	  regions to sysram for direct memory hotplug and registers with
+	  the CRAM subsystem for transparent compression.
+
+	  Page reclamation uses the standard CXL Media Operations Zero
+	  command (opcode 0x4402). If the device does not support it,
+	  the driver falls back to inline CPU zeroing.
+
+	  Usage: First unbind the device from cxl_pci, then bind to
+	  cxl_compression. The driver will initialize the CXL device and
+	  convert any RAM regions to use direct memory hotplug via sysram.
+
+	  If unsure say 'n'.
diff --git a/drivers/cxl/type3_drivers/cxl_compression/Makefile b/drivers/cxl/type3_drivers/cxl_compression/Makefile
new file mode 100644
index 000000000000..46f34809bf74
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_compression/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_COMPRESSION) += cxl_compression.o
+cxl_compression-y := compression.o
+ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/type3_drivers/cxl_compression/compression.c b/drivers/cxl/type3_drivers/cxl_compression/compression.c
new file mode 100644
index 000000000000..e4c8b62227e2
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_compression/compression.c
@@ -0,0 +1,1025 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
+/*
+ * CXL Compression Driver
+ *
+ * This driver provides an alternative binding for CXL memory devices that
+ * converts all associated RAM regions to sysram_regions for direct memory
+ * hotplug, bypassing the standard dax region path.
+ *
+ * Page reclamation uses the standard CXL Media Operations Zero command
+ * (opcode 0x4402, class 0x01, subclass 0x01).  Watermark interrupts
+ * are delivered via separate MSI-X vectors (12 for lthresh, 13 for
+ * hthresh), injected externally via QMP.
+ *
+ * Usage:
+ *   1. Device initially binds to cxl_pci at boot
+ *   2. Unbind from cxl_pci:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
+ *   3. Bind to cxl_compression:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_compression/bind
+ */
+
+#include <linux/unaligned.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sizes.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/bitmap.h>
+#include <linux/highmem.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <linux/rcupdate.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/cram.h>
+#include <linux/memory_hotplug.h>
+#include <linux/xarray.h>
+#include <cxl/mailbox.h>
+#include "cxlmem.h"
+#include "cxl.h"
+
+/*
+ * Per-device compression context lookup.
+ *
+ * pci_set_drvdata() MUST store cxlds because mbox_to_cxlds() uses
+ * dev_get_drvdata() to recover the cxl_dev_state from the mailbox host
+ * device.  Storing anything else in pci drvdata breaks every CXL mailbox
+ * command.  Use an xarray keyed by pci_dev pointer so that multiple
+ * devices can bind concurrently without colliding.
+ */
+static DEFINE_XARRAY(comp_ctx_xa);
+
+static struct cxl_compression_ctx *pdev_to_comp_ctx(struct pci_dev *pdev)
+{
+	return xa_load(&comp_ctx_xa, (unsigned long)pdev);
+}
+
+#define CXL_MEDIA_OP_OPCODE		0x4402
+#define CXL_MEDIA_OP_CLASS_SANITIZE	0x01
+#define CXL_MEDIA_OP_SUBC_ZERO		0x01
+
+struct cxl_dpa_range {
+	__le64 starting_dpa;
+	__le64 length;
+} __packed;
+
+struct cxl_media_op_input {
+	u8 media_operation_class;
+	u8 media_operation_subclass;
+	__le16 reserved;
+	__le32 dpa_range_count;
+	struct cxl_dpa_range ranges[];
+} __packed;
+
+#define CXL_CT3_MSIX_LTHRESH		12
+#define CXL_CT3_MSIX_HTHRESH		13
+#define CXL_CT3_MSIX_VECTOR_NR		14
+#define CXL_FLUSH_INTERVAL_DEFAULT_MS	1000
+
+static unsigned int flush_buf_size;
+module_param(flush_buf_size, uint, 0444);
+MODULE_PARM_DESC(flush_buf_size,
+		 "Max DPA ranges per media ops CCI command (0 = use hw max)");
+
+static unsigned int flush_interval_ms = CXL_FLUSH_INTERVAL_DEFAULT_MS;
+module_param(flush_interval_ms, uint, 0644);
+MODULE_PARM_DESC(flush_interval_ms,
+		 "Flush worker interval in ms (default 1000)");
+
+struct cxl_flush_buf {
+	unsigned int count;
+	unsigned int max;			/* max ranges per command */
+	struct cxl_media_op_input *cmd;		/* pre-allocated CCI payload */
+	struct folio **folios;			/* parallel folio tracking */
+};
+
+struct cxl_flush_ctx;
+
+struct cxl_pcpu_flush {
+	struct cxl_flush_buf __rcu *active;	/* callback writes here */
+	struct cxl_flush_buf *overflow_spare;	/* spare for overflow work */
+	struct work_struct overflow_work;	/* per-CPU overflow flush */
+	struct cxl_flush_ctx *ctx;		/* backpointer */
+};
+
+/**
+ * struct cxl_flush_ctx - Per-region flush context
+ * @flush_record: two-level bitmap, 1 bit per 4KB page, tracks in-flight ops
+ * @flush_record_pages: number of pages in the flush_record array
+ * @nr_pages: total number of 4KB pages in the region
+ * @base_pfn: starting PFN of the region (for DPA offset calculation)
+ * @buf_max: max DPA ranges per CCI command
+ * @media_ops_supported: true if device supports media operations zero
+ * @pcpu: per-CPU flush state
+ * @kthread_spares: array[nr_cpu_ids] of spare buffers for the kthread
+ * @flush_thread: round-robin kthread
+ * @mbox: pointer to CXL mailbox for sending CCI commands
+ * @dev: device for logging
+ * @nid: NUMA node of the private region
+ */
+struct cxl_flush_ctx {
+	unsigned long	**flush_record;
+	unsigned int	 flush_record_pages;
+	unsigned long	 nr_pages;
+	unsigned long	 base_pfn;
+	unsigned int	 buf_max;
+	bool		 media_ops_supported;
+	struct cxl_pcpu_flush __percpu *pcpu;
+	struct cxl_flush_buf **kthread_spares;
+	struct task_struct *flush_thread;
+	struct cxl_mailbox *mbox;
+	struct device	*dev;
+	int		 nid;
+};
+
+/* Bits per page-sized bitmap chunk */
+#define FLUSH_RECORD_BITS_PER_PAGE	(PAGE_SIZE * BITS_PER_BYTE)
+#define FLUSH_RECORD_SHIFT		(PAGE_SHIFT + 3)
+
+static unsigned long **flush_record_alloc(unsigned long nr_bits,
+					  unsigned int *nr_pages_out)
+{
+	unsigned int nr_pages = DIV_ROUND_UP(nr_bits, FLUSH_RECORD_BITS_PER_PAGE);
+	unsigned long **pages;
+	unsigned int i;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+		if (!pages[i])
+			goto err;
+	}
+
+	*nr_pages_out = nr_pages;
+	return pages;
+
+err:
+	while (i--)
+		free_page((unsigned long)pages[i]);
+	kfree(pages);
+	return NULL;
+}
+
+static void flush_record_free(unsigned long **pages, unsigned int nr_pages)
+{
+	unsigned int i;
+
+	if (!pages)
+		return;
+
+	for (i = 0; i < nr_pages; i++)
+		free_page((unsigned long)pages[i]);
+	kfree(pages);
+}
+
+static inline bool flush_record_test_and_clear(unsigned long **pages,
+					       unsigned long idx)
+{
+	return test_and_clear_bit(idx & (FLUSH_RECORD_BITS_PER_PAGE - 1),
+				  pages[idx >> FLUSH_RECORD_SHIFT]);
+}
+
+static inline void flush_record_set(unsigned long **pages, unsigned long idx)
+{
+	set_bit(idx & (FLUSH_RECORD_BITS_PER_PAGE - 1),
+		pages[idx >> FLUSH_RECORD_SHIFT]);
+}
+
+static struct cxl_flush_buf *cxl_flush_buf_alloc(unsigned int max, int nid)
+{
+	struct cxl_flush_buf *buf;
+
+	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, nid);
+	if (!buf)
+		return NULL;
+
+	buf->max = max;
+	buf->cmd = kvzalloc_node(struct_size(buf->cmd, ranges, max),
+				 GFP_KERNEL, nid);
+	if (!buf->cmd)
+		goto err_cmd;
+
+	buf->folios = kcalloc_node(max, sizeof(struct folio *),
+				   GFP_KERNEL, nid);
+	if (!buf->folios)
+		goto err_folios;
+
+	return buf;
+
+err_folios:
+	kvfree(buf->cmd);
+err_cmd:
+	kfree(buf);
+	return NULL;
+}
+
+static void cxl_flush_buf_free(struct cxl_flush_buf *buf)
+{
+	if (!buf)
+		return;
+	kvfree(buf->cmd);
+	kfree(buf->folios);
+	kfree(buf);
+}
+
+static inline void cxl_flush_buf_reset(struct cxl_flush_buf *buf)
+{
+	buf->count = 0;
+}
+
+static void cxl_flush_buf_send(struct cxl_flush_ctx *ctx,
+			       struct cxl_flush_buf *buf)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	unsigned int count = buf->count;
+	unsigned int i;
+	int rc;
+
+	if (count == 0)
+		return;
+
+	if (!ctx->media_ops_supported) {
+		/* No device support, zero all folios inline */
+		for (i = 0; i < count; i++)
+			folio_zero_range(buf->folios[i], 0,
+					 folio_size(buf->folios[i]));
+		goto release;
+	}
+
+	buf->cmd->media_operation_class = CXL_MEDIA_OP_CLASS_SANITIZE;
+	buf->cmd->media_operation_subclass = CXL_MEDIA_OP_SUBC_ZERO;
+	buf->cmd->reserved = 0;
+	buf->cmd->dpa_range_count = cpu_to_le32(count);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MEDIA_OP_OPCODE,
+		.payload_in = buf->cmd,
+		.size_in = struct_size(buf->cmd, ranges, count),
+		.poll_interval_ms = 1000,
+		.poll_count = 30,
+	};
+
+	rc = cxl_internal_send_cmd(ctx->mbox, &mbox_cmd);
+	if (rc) {
+		dev_warn(ctx->dev,
+			 "media ops zero CCI command failed: %d\n", rc);
+
+		/* Zero all folios inline on failure */
+		for (i = 0; i < count; i++)
+			folio_zero_range(buf->folios[i], 0,
+					 folio_size(buf->folios[i]));
+	}
+
+release:
+	for (i = 0; i < count; i++)
+		folio_put(buf->folios[i]);
+
+	cxl_flush_buf_reset(buf);
+}
+
+static int cxl_compression_flush_cb(struct folio *folio, void *private)
+{
+	struct cxl_flush_ctx *ctx = private;
+	unsigned long pfn = folio_pfn(folio);
+	unsigned long idx = pfn - ctx->base_pfn;
+	unsigned long nr = folio_nr_pages(folio);
+	struct cxl_pcpu_flush *pcpu;
+	struct cxl_flush_buf *buf;
+	unsigned long flags;
+	unsigned int pos;
+
+	/* Case (a): flush record bit set, resolution from our media op */
+	if (flush_record_test_and_clear(ctx->flush_record, idx))
+		return 0;
+
+	dev_dbg_ratelimited(ctx->dev,
+			     "flush_cb: folio pfn=%lx order=%u idx=%lu cpu=%d\n",
+			     pfn, folio_order(folio), idx,
+			     raw_smp_processor_id());
+
+	local_irq_save(flags);
+	rcu_read_lock();
+
+	pcpu = this_cpu_ptr(ctx->pcpu);
+	buf = rcu_dereference(pcpu->active);
+
+	if (unlikely(!buf || buf->count >= buf->max)) {
+		rcu_read_unlock();
+		local_irq_restore(flags);
+		if (buf)
+			schedule_work_on(raw_smp_processor_id(),
+					 &pcpu->overflow_work);
+		return 2;
+	}
+
+	/* Case (b): write DPA range directly into pre-formatted CCI buffer */
+	folio_get(folio);
+	flush_record_set(ctx->flush_record, idx);
+
+	pos = buf->count;
+	buf->folios[pos] = folio;
+	buf->cmd->ranges[pos].starting_dpa = cpu_to_le64((u64)idx * PAGE_SIZE);
+	buf->cmd->ranges[pos].length = cpu_to_le64((u64)nr * PAGE_SIZE);
+	buf->count = pos + 1;
+
+	rcu_read_unlock();
+	local_irq_restore(flags);
+
+	return 1;
+}
+
+static int cxl_flush_kthread_fn(void *data)
+{
+	struct cxl_flush_ctx *ctx = data;
+	struct cxl_flush_buf *dirty;
+	struct cxl_pcpu_flush *pcpu;
+	int cpu;
+	bool any_dirty;
+
+	while (!kthread_should_stop()) {
+		any_dirty = false;
+
+		/* Phase 1: Swap all per-CPU buffers */
+		for_each_possible_cpu(cpu) {
+			struct cxl_flush_buf *spare = ctx->kthread_spares[cpu];
+
+			if (!spare)
+				continue;
+
+			pcpu = per_cpu_ptr(ctx->pcpu, cpu);
+			cxl_flush_buf_reset(spare);
+			dirty = rcu_replace_pointer(pcpu->active, spare, true);
+			ctx->kthread_spares[cpu] = dirty;
+
+			if (dirty && dirty->count > 0) {
+				dev_dbg(ctx->dev,
+					 "flush_kthread: cpu=%d has %u dirty ranges\n",
+					 cpu, dirty->count);
+				any_dirty = true;
+			}
+		}
+
+		if (!any_dirty)
+			goto sleep;
+
+		/* Phase 2: Single synchronize_rcu for all swaps */
+		synchronize_rcu();
+
+		/* Phase 3: Send CCI commands for dirty buffers */
+		for_each_possible_cpu(cpu) {
+			dirty = ctx->kthread_spares[cpu];
+			if (dirty && dirty->count > 0)
+				cxl_flush_buf_send(ctx, dirty);
+			/* dirty is now clean, stays as kthread_spares[cpu] */
+		}
+
+sleep:
+		schedule_timeout_interruptible(
+			msecs_to_jiffies(flush_interval_ms));
+	}
+
+	return 0;
+}
+
+static void cxl_flush_overflow_work(struct work_struct *work)
+{
+	struct cxl_pcpu_flush *pcpu =
+		container_of(work, struct cxl_pcpu_flush, overflow_work);
+	struct cxl_flush_ctx *ctx = pcpu->ctx;
+	struct cxl_flush_buf *dirty, *spare;
+	unsigned long flags;
+
+	dev_dbg(ctx->dev, "flush_overflow: cpu=%d buffer full, flushing\n",
+		 raw_smp_processor_id());
+
+	spare = pcpu->overflow_spare;
+	if (!spare)
+		return;
+
+	cxl_flush_buf_reset(spare);
+
+	local_irq_save(flags);
+	dirty = rcu_replace_pointer(pcpu->active, spare, true);
+	local_irq_restore(flags);
+
+	pcpu->overflow_spare = dirty;
+
+	synchronize_rcu();
+	cxl_flush_buf_send(ctx, dirty);
+}
+
+struct cxl_teardown_ctx {
+	struct cxl_flush_ctx *flush_ctx;
+	struct cxl_sysram *sysram;
+	int nid;
+};
+
+static void cxl_compression_pre_teardown(void *data)
+{
+	struct cxl_teardown_ctx *tctx = data;
+
+	if (!tctx->flush_ctx)
+		return;
+
+	/*
+	 * Unregister the CRAM node before memory goes offline.
+	 * node_private_clear_ops requires the node_private to still
+	 * exist, which is destroyed during memory removal.
+	 */
+	cram_unregister_private_node(tctx->nid);
+
+	/*
+	 * Offline and remove CXL memory with retry.  CXL compressed
+	 * memory may have pages pinned by in-flight flush operations;
+	 * keep retrying until they complete.  Once done, sysram->res
+	 * is NULL so the devm sysram_unregister action that follows
+	 * will skip the hotplug removal.
+	 */
+	if (tctx->sysram) {
+		int rc, retries = 0;
+
+		while (true) {
+			rc = cxl_sysram_offline_and_remove(tctx->sysram);
+			if (!rc)
+				break;
+			if (++retries > 60) {
+				pr_err("cxl_compression: memory offline failed after %d retries, giving up\n",
+				       retries);
+				break;
+			}
+			pr_info("cxl_compression: memory offline failed (%d), retrying...\n",
+				rc);
+			msleep(1000);
+		}
+	}
+}
+
+static void cxl_compression_post_teardown(void *data)
+{
+	struct cxl_teardown_ctx *tctx = data;
+	struct cxl_flush_ctx *ctx = tctx->flush_ctx;
+	struct cxl_pcpu_flush *pcpu;
+	struct cxl_flush_buf *buf;
+	int cpu;
+
+	if (!ctx)
+		return;
+
+	/* cram_unregister_private_node already called in pre_teardown */
+
+	if (ctx->flush_thread) {
+		kthread_stop(ctx->flush_thread);
+		ctx->flush_thread = NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		pcpu = per_cpu_ptr(ctx->pcpu, cpu);
+		cancel_work_sync(&pcpu->overflow_work);
+	}
+
+	for_each_possible_cpu(cpu) {
+		pcpu = per_cpu_ptr(ctx->pcpu, cpu);
+
+		buf = rcu_dereference_raw(pcpu->active);
+		if (buf && buf->count > 0)
+			cxl_flush_buf_send(ctx, buf);
+
+		if (pcpu->overflow_spare && pcpu->overflow_spare->count > 0)
+			cxl_flush_buf_send(ctx, pcpu->overflow_spare);
+
+		if (ctx->kthread_spares && ctx->kthread_spares[cpu]) {
+			buf = ctx->kthread_spares[cpu];
+			if (buf->count > 0)
+				cxl_flush_buf_send(ctx, buf);
+		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		pcpu = per_cpu_ptr(ctx->pcpu, cpu);
+
+		buf = rcu_dereference_raw(pcpu->active);
+		cxl_flush_buf_free(buf);
+
+		cxl_flush_buf_free(pcpu->overflow_spare);
+
+		if (ctx->kthread_spares)
+			cxl_flush_buf_free(ctx->kthread_spares[cpu]);
+	}
+
+	kfree(ctx->kthread_spares);
+	free_percpu(ctx->pcpu);
+	flush_record_free(ctx->flush_record, ctx->flush_record_pages);
+}
+
+/**
+ * struct cxl_compression_ctx - Per-device context for compression driver
+ * @mbox: CXL mailbox for issuing CCI commands
+ * @pdev: PCI device
+ * @flush_ctx: Flush context for deferred page reclamation
+ * @tctx: Teardown context for devm actions
+ * @sysram: Sysram device for offline+remove in remove path
+ * @nid: NUMA node ID, NUMA_NO_NODE if unset
+ * @cxlmd: The memdev associated with this context
+ * @cxlr: Region created by this driver (NULL if pre-existing)
+ * @cxled: Endpoint decoder with DPA allocated by this driver
+ * @regions_converted: Number of regions successfully converted
+ * @media_ops_supported: Device supports media operations zero (0x4402)
+ */
+struct cxl_compression_ctx {
+	struct cxl_mailbox *mbox;
+	struct pci_dev *pdev;
+	struct cxl_flush_ctx *flush_ctx;
+	struct cxl_teardown_ctx *tctx;
+	struct cxl_sysram *sysram;
+	int nid;
+	struct cxl_memdev *cxlmd;
+	struct cxl_region *cxlr;
+	struct cxl_endpoint_decoder *cxled;
+	int regions_converted;
+	bool media_ops_supported;
+};
+
+/*
+ * Probe whether the device supports Media Operations Zero (0x4402).
+ * Send a zero-count command, a conforming device returns SUCCESS,
+ * a device that doesn't support it returns UNSUPPORTED (-ENXIO).
+ */
+static bool cxl_probe_media_ops_zero(struct cxl_mailbox *mbox,
+				     struct device *dev)
+{
+	struct cxl_media_op_input probe = {
+		.media_operation_class = CXL_MEDIA_OP_CLASS_SANITIZE,
+		.media_operation_subclass = CXL_MEDIA_OP_SUBC_ZERO,
+		.dpa_range_count = 0,
+	};
+	struct cxl_mbox_cmd cmd = {
+		.opcode = CXL_MEDIA_OP_OPCODE,
+		.payload_in = &probe,
+		.size_in = sizeof(probe),
+	};
+	int rc;
+
+	rc = cxl_internal_send_cmd(mbox, &cmd);
+	if (rc) {
+		dev_info(dev,
+			 "media operations zero not supported (rc=%d), using inline zeroing\n",
+			 rc);
+		return false;
+	}
+
+	dev_info(dev, "media operations zero (0x4402) supported\n");
+	return true;
+}
+
+struct cxl_compression_wm_ctx {
+	struct device *dev;
+	int nid;
+};
+
+static irqreturn_t cxl_compression_lthresh_irq(int irq, void *data)
+{
+	struct cxl_compression_wm_ctx *wm = data;
+
+	dev_info(wm->dev, "lthresh watermark: pressuring node %d\n", wm->nid);
+	cram_set_pressure(wm->nid, CRAM_PRESSURE_MAX);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_compression_hthresh_irq(int irq, void *data)
+{
+	struct cxl_compression_wm_ctx *wm = data;
+
+	dev_info(wm->dev, "hthresh watermark: resuming node %d\n", wm->nid);
+	cram_set_pressure(wm->nid, 0);
+	return IRQ_HANDLED;
+}
+
+static int convert_region_to_sysram(struct cxl_region *cxlr,
+				    struct pci_dev *pdev)
+{
+	struct cxl_compression_ctx *comp_ctx = pdev_to_comp_ctx(pdev);
+	struct device *dev = cxl_region_dev(cxlr);
+	struct cxl_compression_wm_ctx *wm_ctx;
+	struct cxl_teardown_ctx *tctx;
+	struct cxl_flush_ctx *flush_ctx;
+	struct cxl_pcpu_flush *pcpu;
+	resource_size_t region_start, region_size;
+	struct range hpa_range;
+	int nid;
+	int irq;
+	int cpu;
+	int rc;
+
+	if (cxl_region_mode(cxlr) != CXL_PARTMODE_RAM) {
+		dev_dbg(dev, "skipping non-RAM region (mode=%d)\n",
+			cxl_region_mode(cxlr));
+		return 0;
+	}
+
+	dev_info(dev, "converting region to sysram\n");
+
+	rc = devm_cxl_add_sysram(cxlr, true, MMOP_ONLINE_MOVABLE);
+	if (rc) {
+		dev_err(dev, "failed to add sysram region: %d\n", rc);
+		return rc;
+	}
+
+	tctx = devm_kzalloc(dev, sizeof(*tctx), GFP_KERNEL);
+	if (!tctx)
+		return -ENOMEM;
+
+	rc = devm_add_action_or_reset(dev, cxl_compression_post_teardown, tctx);
+	if (rc)
+		return rc;
+
+	/* Find the sysram child device for pre_teardown */
+	comp_ctx->sysram = cxl_region_find_sysram(cxlr);
+	if (comp_ctx->sysram)
+		tctx->sysram = comp_ctx->sysram;
+
+	rc = cxl_get_region_range(cxlr, &hpa_range);
+	if (rc) {
+		dev_err(dev, "failed to get region range: %d\n", rc);
+		return rc;
+	}
+
+	nid = phys_to_target_node(hpa_range.start);
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(hpa_range.start);
+
+	region_start = hpa_range.start;
+	region_size = range_len(&hpa_range);
+
+	flush_ctx = devm_kzalloc(dev, sizeof(*flush_ctx), GFP_KERNEL);
+	if (!flush_ctx)
+		return -ENOMEM;
+
+	flush_ctx->base_pfn = PHYS_PFN(region_start);
+	flush_ctx->nr_pages = region_size >> PAGE_SHIFT;
+	flush_ctx->flush_record = flush_record_alloc(flush_ctx->nr_pages,
+						     &flush_ctx->flush_record_pages);
+	if (!flush_ctx->flush_record)
+		return -ENOMEM;
+
+	flush_ctx->mbox = comp_ctx->mbox;
+	flush_ctx->dev = dev;
+	flush_ctx->nid = nid;
+	flush_ctx->media_ops_supported = comp_ctx->media_ops_supported;
+
+	/*
+	 * Cap buffer at max DPA ranges that fit in one CCI payload.
+	 * Header is 8 bytes (struct cxl_media_op_input), each range
+	 * is 16 bytes (struct cxl_dpa_range).  The module parameter
+	 * flush_buf_size can further limit this (0 = use hw max).
+	 */
+	flush_ctx->buf_max = (flush_ctx->mbox->payload_size -
+			      sizeof(struct cxl_media_op_input)) /
+			     sizeof(struct cxl_dpa_range);
+	if (flush_buf_size && flush_buf_size < flush_ctx->buf_max)
+		flush_ctx->buf_max = flush_buf_size;
+	if (flush_ctx->buf_max == 0)
+		flush_ctx->buf_max = 1;
+
+	dev_info(dev,
+		 "flush buffer: %u DPA ranges per command (payload %zu bytes, media_ops %s)\n",
+		 flush_ctx->buf_max, flush_ctx->mbox->payload_size,
+		 flush_ctx->media_ops_supported ? "yes" : "no");
+
+	flush_ctx->pcpu = alloc_percpu(struct cxl_pcpu_flush);
+	if (!flush_ctx->pcpu)
+		return -ENOMEM;
+
+	flush_ctx->kthread_spares = kcalloc(nr_cpu_ids,
+					    sizeof(struct cxl_flush_buf *),
+					    GFP_KERNEL);
+	if (!flush_ctx->kthread_spares)
+		goto err_pcpu_init;
+
+	for_each_possible_cpu(cpu) {
+		struct cxl_flush_buf *active_buf, *overflow_buf, *spare_buf;
+
+		active_buf = cxl_flush_buf_alloc(flush_ctx->buf_max, nid);
+		if (!active_buf)
+			goto err_pcpu_init;
+
+		overflow_buf = cxl_flush_buf_alloc(flush_ctx->buf_max, nid);
+		if (!overflow_buf) {
+			cxl_flush_buf_free(active_buf);
+			goto err_pcpu_init;
+		}
+
+		spare_buf = cxl_flush_buf_alloc(flush_ctx->buf_max, nid);
+		if (!spare_buf) {
+			cxl_flush_buf_free(active_buf);
+			cxl_flush_buf_free(overflow_buf);
+			goto err_pcpu_init;
+		}
+
+		pcpu = per_cpu_ptr(flush_ctx->pcpu, cpu);
+		pcpu->ctx = flush_ctx;
+		rcu_assign_pointer(pcpu->active, active_buf);
+		pcpu->overflow_spare = overflow_buf;
+		INIT_WORK(&pcpu->overflow_work, cxl_flush_overflow_work);
+
+		flush_ctx->kthread_spares[cpu] = spare_buf;
+	}
+
+	flush_ctx->flush_thread = kthread_create_on_node(
+		cxl_flush_kthread_fn, flush_ctx, nid, "cxl-flush/%d", nid);
+	if (IS_ERR(flush_ctx->flush_thread)) {
+		rc = PTR_ERR(flush_ctx->flush_thread);
+		flush_ctx->flush_thread = NULL;
+		goto err_pcpu_init;
+	}
+	wake_up_process(flush_ctx->flush_thread);
+
+	rc = cram_register_private_node(nid, cxlr,
+					cxl_compression_flush_cb, flush_ctx);
+	if (rc) {
+		dev_err(dev, "failed to register cram node %d: %d\n", nid, rc);
+		goto err_pcpu_init;
+	}
+
+	tctx->flush_ctx = flush_ctx;
+	tctx->nid = nid;
+
+	rc = devm_add_action_or_reset(dev, cxl_compression_pre_teardown, tctx);
+	if (rc)
+		return rc;
+
+	comp_ctx->flush_ctx = flush_ctx;
+	comp_ctx->tctx = tctx;
+	comp_ctx->nid = nid;
+
+	/*
+	 * Register watermark IRQ handlers on &pdev->dev for
+	 * MSI-X vector 12 (lthresh) and vector 13 (hthresh).
+	 */
+	wm_ctx = devm_kzalloc(&pdev->dev, sizeof(*wm_ctx), GFP_KERNEL);
+	if (!wm_ctx)
+		return -ENOMEM;
+
+	wm_ctx->dev = &pdev->dev;
+	wm_ctx->nid = nid;
+
+	irq = pci_irq_vector(pdev, CXL_CT3_MSIX_LTHRESH);
+	if (irq >= 0) {
+		rc = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					       cxl_compression_lthresh_irq,
+					       IRQF_ONESHOT,
+					       "cxl-lthresh", wm_ctx);
+		if (rc)
+			dev_warn(&pdev->dev,
+				 "failed to register lthresh IRQ: %d\n", rc);
+	}
+
+	irq = pci_irq_vector(pdev, CXL_CT3_MSIX_HTHRESH);
+	if (irq >= 0) {
+		rc = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					       cxl_compression_hthresh_irq,
+					       IRQF_ONESHOT,
+					       "cxl-hthresh", wm_ctx);
+		if (rc)
+			dev_warn(&pdev->dev,
+				 "failed to register hthresh IRQ: %d\n", rc);
+	}
+
+	return 0;
+
+err_pcpu_init:
+	if (flush_ctx->flush_thread)
+		kthread_stop(flush_ctx->flush_thread);
+	for_each_possible_cpu(cpu) {
+		struct cxl_flush_buf *buf;
+
+		pcpu = per_cpu_ptr(flush_ctx->pcpu, cpu);
+
+		buf = rcu_dereference_raw(pcpu->active);
+		cxl_flush_buf_free(buf);
+
+		cxl_flush_buf_free(pcpu->overflow_spare);
+
+		if (flush_ctx->kthread_spares)
+			cxl_flush_buf_free(flush_ctx->kthread_spares[cpu]);
+	}
+	kfree(flush_ctx->kthread_spares);
+	free_percpu(flush_ctx->pcpu);
+	flush_record_free(flush_ctx->flush_record, flush_ctx->flush_record_pages);
+	return rc ? rc : -ENOMEM;
+}
+
+static struct cxl_region *create_ram_region(struct cxl_memdev *cxlmd)
+{
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
+		dev_info(&cxlmd->dev, "RAM capacity too small (< 256M)\n");
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
+	dev_info(&cxlmd->dev, "created region %s\n",
+		 dev_name(cxl_region_dev(cxlr)));
+	pdev_to_comp_ctx(to_pci_dev(cxlmd->dev.parent))->cxled = cxled;
+	return cxlr;
+}
+
+static int cxl_compression_attach_probe(struct cxl_memdev *cxlmd)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);
+	struct cxl_compression_ctx *comp_ctx = pdev_to_comp_ctx(pdev);
+	struct cxl_region *regions[8];
+	struct cxl_region *cxlr;
+	int nr, i, converted = 0, errors = 0;
+	int rc;
+
+	comp_ctx->cxlmd = cxlmd;
+	comp_ctx->mbox = &cxlmd->cxlds->cxl_mbox;
+
+	/* Probe device for media operations zero support */
+	comp_ctx->media_ops_supported =
+		cxl_probe_media_ops_zero(comp_ctx->mbox,
+					 &cxlmd->dev);
+
+	dev_info(&cxlmd->dev, "compression attach: looking for regions\n");
+
+	nr = cxl_get_committed_regions(cxlmd, regions, ARRAY_SIZE(regions));
+	for (i = 0; i < nr; i++) {
+		if (cxl_region_mode(regions[i]) == CXL_PARTMODE_RAM) {
+			rc = convert_region_to_sysram(regions[i], pdev);
+			if (rc)
+				errors++;
+			else
+				converted++;
+		}
+		put_device(cxl_region_dev(regions[i]));
+	}
+
+	if (converted > 0) {
+		dev_info(&cxlmd->dev,
+			 "converted %d regions to sysram (%d errors)\n",
+			 converted, errors);
+		return errors ? -EIO : 0;
+	}
+
+	dev_info(&cxlmd->dev, "no existing regions, creating RAM region\n");
+
+	cxlr = create_ram_region(cxlmd);
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		if (rc == -ENODEV) {
+			dev_info(&cxlmd->dev,
+				 "could not create RAM region: %d\n", rc);
+			return 0;
+		}
+		return rc;
+	}
+
+	rc = convert_region_to_sysram(cxlr, pdev);
+	if (rc) {
+		dev_err(&cxlmd->dev,
+			"failed to convert region to sysram: %d\n", rc);
+		return rc;
+	}
+
+	comp_ctx->cxlr = cxlr;
+
+	dev_info(&cxlmd->dev, "created and converted region %s to sysram\n",
+		 dev_name(cxl_region_dev(cxlr)));
+
+	return 0;
+}
+
+static const struct cxl_memdev_attach cxl_compression_attach = {
+	.probe = cxl_compression_attach_probe,
+};
+
+static int cxl_compression_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	struct cxl_compression_ctx *comp_ctx;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	dev_info(&pdev->dev, "cxl_compression: probing device\n");
+
+	comp_ctx = devm_kzalloc(&pdev->dev, sizeof(*comp_ctx), GFP_KERNEL);
+	if (!comp_ctx)
+		return -ENOMEM;
+	comp_ctx->nid = NUMA_NO_NODE;
+	comp_ctx->pdev = pdev;
+
+	rc = xa_insert(&comp_ctx_xa, (unsigned long)pdev, comp_ctx, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	cxlmd = cxl_pci_type3_probe_init(pdev, &cxl_compression_attach);
+	if (IS_ERR(cxlmd)) {
+		xa_erase(&comp_ctx_xa, (unsigned long)pdev);
+		return PTR_ERR(cxlmd);
+	}
+
+	comp_ctx->cxlmd = cxlmd;
+	comp_ctx->mbox = &cxlmd->cxlds->cxl_mbox;
+
+	dev_info(&pdev->dev, "cxl_compression: probe complete\n");
+	return 0;
+}
+
+static void cxl_compression_remove(struct pci_dev *pdev)
+{
+	struct cxl_compression_ctx *comp_ctx = xa_erase(&comp_ctx_xa,
+							(unsigned long)pdev);
+
+	dev_info(&pdev->dev, "cxl_compression: removing device\n");
+
+	if (!comp_ctx || comp_ctx->nid == NUMA_NO_NODE)
+		return;
+
+	/*
+	 * Destroy the region, devm actions on the region device handle teardown
+	 * in registration-reverse order:
+	 *   1. pre_teardown:  cram_unregister + retry-forever memory offline
+	 *   2. sysram_unregister: device_unregister (sysram->res is NULL
+	 *      after pre_teardown, so cxl_sysram_release skips hotplug)
+	 *   3. post_teardown: kthread stop, flush cleanup
+	 *
+	 * PCI MMIO is still live so CCI commands in post_teardown work.
+	 */
+	if (comp_ctx->cxlr) {
+		cxl_destroy_region(comp_ctx->cxlr);
+		comp_ctx->cxlr = NULL;
+	}
+
+	if (comp_ctx->cxled) {
+		cxl_dpa_free(comp_ctx->cxled);
+		comp_ctx->cxled = NULL;
+	}
+}
+
+static const struct pci_device_id cxl_compression_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0d93) },
+	{ /* terminate list */ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_compression_pci_tbl);
+
+static struct pci_driver cxl_compression_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= cxl_compression_pci_tbl,
+	.probe		= cxl_compression_probe,
+	.remove		= cxl_compression_remove,
+	.driver	= {
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_pci_driver(cxl_compression_driver);
+
+MODULE_DESCRIPTION("CXL: Compression Memory Driver with SysRAM regions");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");
-- 
2.53.0


