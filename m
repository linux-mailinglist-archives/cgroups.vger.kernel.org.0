Return-Path: <cgroups+bounces-13779-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNzIGcMHiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13779-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE610A593
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6535C304CA70
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51735EDC1;
	Sun,  8 Feb 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZdQK67i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5835D613
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587938; cv=none; b=tQAgXqg+CZ+0HYNUG+WM39O+QIntS0u17ZJ2JjROGQeIUZwOi9orze/hA8abcjmTbBJo8s6S/5MGZPl6itWB3FLFijHk/X92dnWF2zOLTra6Kig2bJ3bFCR5OCRdYYOW/jKe0aqpvF/ux+JZnqyPrH8rnHBcsznmWhzb7UO9BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587938; c=relaxed/simple;
	bh=hMYJkWqt5SRZ9hrREEyYUKQBPS2WDzY73VTSLMkQ4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSpZWKv2XYPdONr7f5xpdj7NJyaaV2N3IdG2OTwW0XtoxBYZ8si6raOFVKtsaL90WsQXVn3xYLMtTLf5DKWpaXn+55a6Io+hsyekgM/lw4JPxTS8fgZTS3qbivlM2kgPBK17VVgonq8TZ4XrPtuUPYqXIfc0QcwN74C2Od4vDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZdQK67i; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c7c841904so1649545b6e.3
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587937; x=1771192737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAYGpIpTp87S2/ee6Fydv9Vv1Hcay3Vy8wBGMvAXEzA=;
        b=lZdQK67iWJAHL7JGqSbW628gYhVUpecwY2VhyZOxTrrWA9miY6RTBYUIRetakIP8cx
         KPc0sEsxpSIjAx5VMYh1cpCcPYdjTV7BcInUkRo/8X8zaOaH+3EVVtmQqVAZUr7AnRGC
         C0m/YiqEShQAShnDiCv3W/YCUcR3MJLeZu3Bkv7IQSfdZj6RxHigwizARFnWiK6KtiZc
         BBWNVzaEj5W9w3eYCb70oG5vOMU//9dKtpZSy4clzWBxAMxdPwl6tuyx+lxOAT7QxMqH
         qu7mJi1J+aNSa6YAqaC2XrQqdUuuTO03xubyhBsYxi8o/v5qfHFIVl6x2Z2tpT2SoLMG
         i6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587937; x=1771192737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAYGpIpTp87S2/ee6Fydv9Vv1Hcay3Vy8wBGMvAXEzA=;
        b=RnhdUs5wAA9qdJVZuPKz3qn+VbrVO0tjVrjze8y8di/Qjxq1RQmw9v2BLBDVSmv0Ru
         VejvPswIFWeqJOtmnwc2G15hNQ1hAYp9TolCM7zHW3kRGgzn2gwt3U0d9JPoPBZ5LewU
         Lgx37LIhJWTOR6rKyjItZGCDaBsMtG4BwqeLraucNiYWTryk02SdDe83C7e0Sv6ZTCbt
         JVfSAPlyWriUNp93VDvKJRZ8uKbrvZKdAMGkk1jaPLhzbgOP5ugUxXyQPqN2CDz6eviM
         rl4U7cP1kqlW1F4u5qxzWNZOd2SVdT5gxK6pyTzl317amQOdUGSVpZ36QSAkM/zAROKL
         KWCw==
X-Forwarded-Encrypted: i=1; AJvYcCVJWZfMni+IWtHHSGP7a6hiaOydQh8FsM74FvjXOSNZIoVOZa1OeDmdlF9629KE6qEkyapaV/2b@vger.kernel.org
X-Gm-Message-State: AOJu0YwDndjcclswPs8O4THbqkb1cSN5TpBkSwimaAPo3mlf8wmvNZoA
	Y6+Fxal5sDoMT7Xl1ukjOR5Wce4pQFDUuR+YSumYoi6U5S/AjcXPKIp48aj1oToeeajETw==
X-Gm-Gg: AZuq6aKf6cz/6mwDlYZ6Z3K3MLwXOeWqa8YIRv7tUSCa9pWuoWWCvkY9yGAPtRkun2D
	kN2ST6TQuxZGf0LHKpWkOK6EoDkxylkyONinApgNwfcU8ijQbqeQO/mQ0sH5EfBBO92en4RnDAX
	dqcljgtGDfgxE9FdgYgvC2f2ldz6BCMbato8oCwciNhbdvjOnvdi281Z/VHPIvlVjpAGWwJDWvR
	0LyyRqXPe4HFGgTKBdN5fp8wO1YHmvEqTqx6SohqbXAZNoAYXTQ91jK0WD3kLbW9R3rB67WiNz3
	1OeLZGUvbj9Yvw72PJVjLRR8Lh4C0M5VpMa4klWBAtldeSOBBpZ3COXzps5SlXSwZ+fcajwQFQm
	dqrjgXpYiCikrWu3p240XcqkkDjFRQuxo1lCq5S7AwPLv7R5BjIL/5zurFeybFc5YhSMxCNeyIo
	22f8ev4jzuVptI8GgLrz4gZaez/k2OH7S+
X-Received: by 2002:a05:6808:6a83:b0:45e:84ec:f163 with SMTP id 5614622812f47-462fcbf61f5mr5120530b6e.64.1770587937297;
        Sun, 08 Feb 2026 13:58:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d464785674sm6238015a34.19.2026.02.08.13.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:58:56 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 07/20] mm: create scaffolds for the new virtual swap implementation
Date: Sun,  8 Feb 2026 13:58:20 -0800
Message-ID: <20260208215839.87595-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13779-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,cmpxchg.org:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAAE610A593
X-Rspamd-Action: no action

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
 include/linux/swap.h |  2 ++
 mm/Makefile          |  2 +-
 mm/swap_state.c      |  6 ++++++
 mm/vswap.c           | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)
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
index 918b47da55f44..1ff463fb3a966 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -669,6 +669,8 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+int vswap_init(void);
+
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
  *                         virtual swap slot.
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
2.47.3


