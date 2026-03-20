Return-Path: <cgroups+bounces-14949-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEA2AzCgvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14949-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44A2DFF61
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8593050439
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A53E1D18;
	Fri, 20 Mar 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFvIcVCu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747C3D34AA
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034869; cv=none; b=Oc8CvqmCub2/xwijfALd+VbSqYm+PMmq5CmiU6QuOdhK2rbXazl1UqAUF4Usf9psK/FGAV4fzXOwwf0eErq/JTGoYjpVzUGnLrrFE9GUPy5taQWuMfPkZgVvi1XX7g/Gmlh+nSik0/xFSwBZSJOugLcf2bKSxD+e1DbflNH7O0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034869; c=relaxed/simple;
	bh=p2EM42jZS59AXKFtUANlEILN4sRBHLRYcGgRVQjo4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5fmsqoLS0NaXJ3OeCIW7QdB55KyBjMHQRYq1V0TFn6Wq/ZRY+vYZErz+h2kx+Izybn8C5HwZ+RSDlNf13BplUo8yhFpVuscLiS9AW7ZeSziKGx4Z/QFJP/5bS1b0lORhgX4hnoOV+RfAwofA8Igf4ah9/5odewygMGrOMAenRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFvIcVCu; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467e044082dso352317b6e.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034867; x=1774639667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=augNyOBtiYJ0dgm3cOulQaqdWfbdzgL3KEY1IT/V5Xs=;
        b=PFvIcVCu2sG2GtvWxUB/Xx3Mr9+x29qpOB/mobLSCm5kqHDsvLyyDb30UDOM1LhXGp
         VO/RZL92lG+6yJ0rUp+WAu/Lr4bgEBY1ZISndY9ZuMvL2K9k0NEKRDxe4rQYW3zuwI2a
         bttBgnc6kgiUMIm1o/hn4ZHubpPBuBcWdGX5YvQfNBgJ6Zq+RST6ZsO6lNZA4e197Yln
         jxFuXll2PiXV8iQlOW+U224kKemm5F2s/+lyH5beKFgm2rWMRYvOzsA0x0Bn5lMLdDOx
         vWa7uSfIIhTS7k8mocDUfTFhPq2Z/uFsSWIi+RLHm+YdNKH1MK2inUX5YHeNiLf2Epd2
         EmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034867; x=1774639667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=augNyOBtiYJ0dgm3cOulQaqdWfbdzgL3KEY1IT/V5Xs=;
        b=b9Gwuw90QzyZ8/D/Fr3btS8y7IBuNXRzT+fqXyZ2B23azjgTjiLUAkZwpYrgPvSwtC
         veolXKLBHJu740OcW8uNXxeSNpx6Ta5GAfxafDoRXZpkO5SnD1ty49y/hQsWiyFZBSEE
         kjGlcAXaUvYRYlaJe2eMlig7Ok/AVGPsUqY45bxSmfgT5MQ0jSNRiaPK7eKMk1kdxI9G
         tUErJ0N+1LlQo1TBXCGiubSX8l5COhCrAZdn4jDinKEGWDHMGjC3H3PeD7p41PjH4kVV
         Z9Ot0tv5wEhCJoPJCT2ocIVOc6u4E0pw/weW0LokrhZrcaIQHMPg2OL4JIl8hXPNzHtB
         64Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXVup/+oOfqTbdKLe3F8DoLtqRJBGgivwBcyhL7t/4PkEof8kFDwM3J0kI9aIbGR8ly+B0HmBx3@vger.kernel.org
X-Gm-Message-State: AOJu0YzirtXRyRH2eRcvnMJBAE1PpUeZnZ2ZSMFQY41gPAH1exN6L3Zo
	tm6EUEmchXbdfQf31fPoyqVzUEQJWi2k2YZ2ypdlsO1ZuqSPRNUDb/TJ
X-Gm-Gg: ATEYQzzkBc3VbCHjH1BwzGvJLE5YHW4zYVcPI/hzO5RzQQfBaSHB02df4wKh9Dp6coH
	d7i+MBpu+U0jT5Xm8BYBVWMUL5LyICc2TuTdifnBmeXFKwsydFpjOpHG457P7vuqu58UkSJoxIC
	tLsiWMRs6wOtnBuYZScndvmeq2VSIqnLXXbj6bfVddC1MtpriagbRiTpjaKsSQraU67YaMRMPqd
	kOVTSXPnNIz2yUaQhhN+S4Hcz0oZmrxUPeLpz6Qi6KjAMDrXUKksv3s7/S0LUaDW1lAjwHvosk5
	sQW7NPJp/zmzoxHtaHb36X47QwZm7fWNElIS96hdn1nq33A3+VdIlRdq54ebe/lW1q7TDwULXnf
	+4Uidigx6fkaTgiJopTVk8Wl/VZ1VaZM+o0p9T7mQK3HlPC/4HRV9Z1snfeB/VqD6jALP/urwL2
	Ja3hjPrWydES4NXA+HsIZCD3iPfmubW7nB/7vkknmzgxF8SQ==
X-Received: by 2002:a05:6808:190d:b0:466:f054:c3b6 with SMTP id 5614622812f47-467e5fe7105mr2485514b6e.59.1774034866661;
        Fri, 20 Mar 2026 12:27:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d19abfsm1824746b6e.2.2026.03.20.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:46 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com
Subject: [PATCH v5 07/21] mm: create scaffolds for the new virtual swap implementation
Date: Fri, 20 Mar 2026 12:27:21 -0700
Message-ID: <20260320192735.748051-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14949-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.862];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kvack.org:email,huaweicloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: BE44A2DFF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In prepration for the implementation of swap virtualization, add new
scaffolds for the new code: a new mm/vswap.c source file, which
currently only holds the logic to set up the (for now, empty) vswap
debugfs directory. Hook this up in the swap setup step in
mm/swap_state.c, and set up vswap compilation in the Makefile.

Other than the debugfs directory, no behavioral change intended.

Finally, make Johannes a swap reviewer, given that he has contributed
majorly to the developments of virtual swap.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS          |  2 ++
 include/linux/swap.h |  3 +++
 mm/Makefile          |  2 +-
 mm/swap_state.c      |  6 ++++++
 mm/vswap.c           | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 mm/vswap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3780bb330378..042dbc06c3d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16728,6 +16728,7 @@ R:	Kemeng Shi <shikemeng@huaweicloud.com>
 R:	Nhat Pham <nphamcs@gmail.com>
 R:	Baoquan He <bhe@redhat.com>
 R:	Barry Song <baohua@kernel.org>
+R:	Johannes Weiner <hannes@cmpxchg.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/swap.h
@@ -16739,6 +16740,7 @@ F:	mm/swap.h
 F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
+F:	mm/vswap.c
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 918b47da55f44..df0771903a952 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -423,6 +423,9 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
+/* Virtual swap space API (mm/vswap.c) */
+int vswap_init(void);
+
 /* Lifecycle swap API (mm/swapfile.c) */
 int folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
diff --git a/mm/Makefile b/mm/Makefile
index 2d0570a16e5be..67fa4586e7e18 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -75,7 +75,7 @@ ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o vswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o hugetlb_sysfs.o hugetlb_sysctl.o
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e2e9f55bea3bb..29ec666be4204 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -882,6 +882,12 @@ static int __init swap_init(void)
 	int err;
 	struct kobject *swap_kobj;
 
+	err = vswap_init();
+	if (err) {
+		pr_err("failed to initialize virtual swap space\n");
+		return err;
+	}
+
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
diff --git a/mm/vswap.c b/mm/vswap.c
new file mode 100644
index 0000000000000..e68234f053fc9
--- /dev/null
+++ b/mm/vswap.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual swap space
+ *
+ * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
+ */
+#include <linux/swap.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *vswap_debugfs_root;
+
+static int vswap_debug_fs_init(void)
+{
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	vswap_debugfs_root = debugfs_create_dir("vswap", NULL);
+	return 0;
+}
+#else
+static int vswap_debug_fs_init(void)
+{
+	return 0;
+}
+#endif
+
+int vswap_init(void)
+{
+	if (vswap_debug_fs_init())
+		pr_warn("Failed to initialize vswap debugfs\n");
+
+	return 0;
+}
-- 
2.52.0


