Return-Path: <cgroups+bounces-14887-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6El9BSIou2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14887-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:33:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A24302C3726
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7A231F8616
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214537E319;
	Wed, 18 Mar 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9wqLewo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101C38E11E
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873010; cv=none; b=qnBAK6tZ0maW/Cfp1NYovRsFoLn3v6QBkVoOCOrICXPfMnPBGZ8sbK4KFLqhnjeMaQ5swd0V+zNwKZQwOdbKTrFMI5LUlG8GvIzUgUsaPFi1zOHEmJXruigRMK0UgFZJ8we3ZDtTBO3DFup1sCUXL3djJZLWlQNVLqMt4NtvPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873010; c=relaxed/simple;
	bh=RtjI20tpXl2gzkkeQFik239RRAiwP1G/DuOJFlw72jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJNxDDzyXEvTef7GFH0V+nbnhfmaw8vZ76vPH0/EGgqAukydg2bcvxqmANg4p6+AVpJ5RFh4VdzMLcmwfwzau0o7pDIQffOCFePv1BI6qTb8BCA1vnd2kKyvA0Z6fBmms3jo87KsiVws1puZlVat6GifZiieeLLw6wmnTPiR6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9wqLewo; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40438e0cba6so311564fac.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873007; x=1774477807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uOXWFDfbhJT9tG5Yl+ef83GJnrWQ5V7qgRvvdgSeJQ=;
        b=K9wqLewoSybShJc0AVArPIwS51nucN5E08RGEHDXaZbsq5CE93fWblAZ2pZ7WI0l6p
         mCd82ayyEhxDqgeh99XjSxmbJsdMnLAgsi8/7UAN398nI53qZSiKP8MXqWZMUzwE3li2
         44GpfIm+Y/oIbjoTtTv7non18oj/6T6m3X9b+6gIHxTPQCVBGZyyrjfF7/xPbahBcFyX
         DsgZf+bn3grIXTJ/Po05RsbsOoEkSoFds9/LeLWGUYjbDite97+zfAesmi9OABEOBzfh
         cqOWM2K5SRFF+YHToYD9OALJn6jdC2BdUdw8rBSzQFVoyMIcTmop7MYF5Yt3/a1QIyzb
         BTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873007; x=1774477807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0uOXWFDfbhJT9tG5Yl+ef83GJnrWQ5V7qgRvvdgSeJQ=;
        b=XtB1d1ONI4+zpZJtphA5iiWkrzaliKDgteCRBZpS2t5NdtJnw1ehnfntuKXSrGvAEW
         RjTIr4OkDKDxdH0KvG1cWHG76qA0U6lJ7bfddHlblS4DWU9NJH7yAhID9EAqdQFdpiga
         fWeNSwUxW+FxpCoNHtZ+mWOlQUyNMfnu01GhrDpP+JzOEW8FTxBZrGmOhfOdNvhJt9hw
         ihN2L705ySpahESGJYUVXeP6Fgaz/Wwe7L3q44SBJhp/7DVyhd+wAR5n6opAjf8joeRk
         GwixnGtDD66I51OUvDDX8XbcSCInR3jevv/4ROR0Nxbh6J0/62fuo2uF9em+p5DBgzgj
         ZIiw==
X-Forwarded-Encrypted: i=1; AJvYcCVwNTdqSkI3eYEEpM0AwGTVPQTEQL0ItzCQLz9LxknNhIhdJxq44Bao+lRL0bRZngHdN2/UCtY4@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYiP9yKmeh10xOOiKkH1eI724ST3RrgohG/hUpV6/rUTsUWDI
	3ZJfloRGp2ZIl1WYic9Oqvol8wdVXZ/hoXhuCU2cAXMlQPJWl2nIhrYj
X-Gm-Gg: ATEYQzzMfIivLySMHi8OtCUGf7ef8K4jMey1uJ8q28tufJrujf0KwdQD+QM9DH/ILah
	2HSPsuBov7FajP0czSnYb5h4SDXzznx6hskLEfBroweJK8FCIbOCw4+wG0HiWA0g64BWcFZEgEX
	01pCaAj1rt8offsEjf+auUxs3g7C85H7SZ5ZTaT3SORjh6IN4aeD05iQOAO1HDAD4jv/x+8dPE4
	jCQ8DN6dQb+XKxFLXxXn34Yse92XOSd/YpmHhZyAunzH7aHfmynrvlPnvDm/oSVHH064zsBnz2U
	b9V3yECnnNsiqRfLLGtR2qbiXUr79utAkcGsgAHfY8Swq7zKJzkD1t+6x5CRmM6P8d1atKR3uXw
	jW4P/sk6vhqQ/dmQpK2ggLrKH9AI2LvVGXj/EiuU692AUiqgNlDVhnqTonFqui3w+6hidRF3Mpf
	1ua7SZzElelZ5y0gLlVdrJwOdH9fR/tJUyCvAKo8sqfNTv0A==
X-Received: by 2002:a05:6870:1405:b0:417:14d1:9671 with SMTP id 586e51a60fabf-41bd3f7d47cmr3526021fac.34.1773873006867;
        Wed, 18 Mar 2026 15:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd22dee78sm4108849fac.0.2026.03.18.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:06 -0700 (PDT)
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
Subject: [PATCH v4 07/21] mm: create scaffolds for the new virtual swap implementation
Date: Wed, 18 Mar 2026 15:29:38 -0700
Message-ID: <20260318222953.441758-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14887-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.855];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: A24302C3726
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
index e087673237636..b21038b160a07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16728,6 +16728,7 @@ R:	Kemeng Shi <shikemeng@huaweicloud.com>
 R:	Nhat Pham <nphamcs@gmail.com>
 R:	Baoquan He <bhe@redhat.com>
 R:	Barry Song <baohua@kernel.org>
+R:	Johannes Weiner <hannes@cmpxchg.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/mm/swap-table.rst
@@ -16740,6 +16741,7 @@ F:	mm/swap.h
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


