Return-Path: <cgroups+bounces-15611-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHKhMKUT+mlRJAMAu9opvQ
	(envelope-from <cgroups+bounces-15611-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:58:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A60F4D0C21
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7A830A9975
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB348A2D7;
	Tue,  5 May 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/pmov+B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA748B38D
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995555; cv=none; b=KjKiWTxGO2g4LGI+RPAK/WbIHQM6Y8RxeS4s0FIVDdxvptWd8t1tmTFCeND5+iZIsleN3Cw9kAdBhrWpMN7tK5Ncq0v3JeNbB2slSaDmiU3izbhsz5DCSDdBywCGOO3HbqPjeHdMmblcaOdf8I/BwQmEcXrRqeOZh+L1xPuYGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995555; c=relaxed/simple;
	bh=I5srizcHGCgPUxo7oRZ08vip5kw+l6siD1GuafibzoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnVOh67HJ9Z2N5Q06fFkJrV1MdwatyFR14xkLFeKzTISiGP3swMOJLLbLqBI0Cp9sfAMg9pOboVFExspx3K/m2q8HYHDsa54fcxlPAmKcnYchwME56DvW5aB57vrT9660MQ1UZPZtVnCej87P75Ry0pS+w9NdWbxAaV4ewwv15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/pmov+B; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbccf6a23dso4774915a34.2
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995552; x=1778600352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlimKByHfZpD1p9OKEabB2ERI5Qs+G3kPUHC9/pb+w8=;
        b=a/pmov+Be6KTdl1Oc3hZyCs8SmV2u54grQwwBa1O/svdjLSKjK6br0kZKZo56lvrRi
         q19DET7E0YH0AaXLkdKd9agrkqehJY+jJVk7RV7ChtyoHyXIA2fOl1Wps9dgsz470XwQ
         4CeUoj4IMOhJjA+YIBFb1cN0Lo4vdW+4y5KQbSJVsXY0QqfQYXT3mMv4vDyrCuqfYmk4
         r0S6cTKct6yTpFET85iGUVehvfa+J53E9MubmKccXkBk/jDS9qLDk0U1ENHalKw/O4T7
         gBhp05J6212klcz5QaQKxSihgHX8Vr9KvzxlFXpnx3X+6MDaaPEAOY6GQV2fB3w7mvgr
         Pfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995552; x=1778600352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlimKByHfZpD1p9OKEabB2ERI5Qs+G3kPUHC9/pb+w8=;
        b=aIIuu12+iadN213VHh6IgzDZdJZrzSAs2uLEb63/GrmSfM/PHrqjfAZ37s3ouHOjrP
         8mWQRKveiEAD7auJrcMvDWefHQSFdDLxFaSfvss4yd+aOdXvXdQiZZRef2Hp95BBunip
         JTq2G0ase0L+/rfWa3aJVxH6I2HjTjiXLZ1ZQxVfYyXOcohsSW98Xr/2rnOZSeqb4CSD
         /AvMpI5O1A02eK3i83tv8udzDho1zuoDBpZJXs31aXwDQEkAQ6I2rBgMuyn+Ee+JIe23
         S2nsnBWgjhiYc83KP03br0plg6AZHOdtn5LZaSlKLyi7QoQ2GP651mBWCtRlL/jr756n
         AgLA==
X-Forwarded-Encrypted: i=1; AFNElJ8FHb7Aep4DYzEhmFnQS3Nmh8OZ1fJJdlVtf/eM0yym6mKoEUWD68qLltdKV2GdhwratAjjcFDj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8EM/Mgrv2V+7/L1M3kTilr7AqBQT3mocey2iHEbkRIdaKCu7
	KJ5xXPxUXYBsJaMzlv4vnIw4jePEF5bu+yl2mwFUUfAT4CrVqNH2EEL8
X-Gm-Gg: AeBDieu2fiO3ifgzR9XP7ZBc/XwAdTID/Mew42HzB231VHwlOuSKZqKf9Kt+kQa89VN
	pVHsAFCcmpv41wGc2a638oZL0kOT7IVPJNPUfukxvu/O92vMR6bFZfBHE4k17b3a3CwsKO0+bZl
	9peDx6Dk5DjFkCMdCtuUgSV308E7V8obu9nwEzA6WIiKpoP+JBI5eaThp42o5dMudxfD17SjUko
	z7orP/8A9O83WoRLXe/55GL3evX5xL6ZfkRrimVaBJA9T4yvSJHbRl9dMSXh7+rDmWTIblmxQ7K
	VhUg7pgjqrwoaYsPC23fnL5Ovww+rUbgm12ToMdT+2x7MHFpHVFU/+Rrqo2sKF/c/hs5mli6sF7
	Yei4Hmmw0Ayu83LQX/D2Sf5S+1a6DEZ7iQ4C85zzKHDLIsnBlCozAp02xuqlcuedZdlj/LOwsFz
	+HD0kOlsG1hDEZoYiCOtAC9oZlRNDvJ5mdqHjRkKoE4E6fnStTFak/Y6U0
X-Received: by 2002:a05:6830:8d1:b0:7dc:a256:5e2e with SMTP id 46e09a7af769-7dee121b678mr8066698a34.1.1777995552105;
        Tue, 05 May 2026 08:39:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a9036sm9855829a34.4.2026.05.05.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:11 -0700 (PDT)
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
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 07/22] mm: create scaffolds for the new virtual swap implementation
Date: Tue,  5 May 2026 08:38:36 -0700
Message-ID: <20260505153854.1612033-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A60F4D0C21
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-15611-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.980];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email,linux-foundation.org:email,kvack.org:email,cmpxchg.org:email]
X-Spam: Yes

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
index d3780bb33037..042dbc06c3d3 100644
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
index 918b47da55f4..df0771903a95 100644
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
index 2d0570a16e5b..67fa4586e7e1 100644
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
index 6714d59fb108..fca17e7e7ae6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -883,6 +883,12 @@ static int __init swap_init(void)
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
index 000000000000..e68234f053fc
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


