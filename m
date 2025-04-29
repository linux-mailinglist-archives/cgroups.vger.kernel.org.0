Return-Path: <cgroups+bounces-7917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E2AA3C85
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C44E1FDD
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC82DFA25;
	Tue, 29 Apr 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSO3QXz2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9402DEB86;
	Tue, 29 Apr 2025 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969938; cv=none; b=eo3cHgl3ozyoGDutJW4340HBEcq8tWN3hq6BxzIOgwGEn+DS2tzOgNDEzvwgVHG/MEmeSzI92jwldFm3HXT5kZvZVK9c8ctb6/yzrgIcJSY8gr8riqjRfhH+094UI37IBIY8GWdqIS9y5QGsptuiDQjP3nPRoWnp8bYIplJmUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969938; c=relaxed/simple;
	bh=x8e+MEX/qcRiV4ForD6Sd+jZ2RFE/w1McwyxXE9bSbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czUQaTdZra5trH40f0gm8YrFWGOJM+dJ/gT9bdIfknxVMcMYME3WyaHq7NeWIhqTwSJMZk1rgLgGRGTP2j2hk0BzjS4iqeaZHt8TCHKm8E8AEOfPLCceml5zHlp9aI/qhQrdbDoF11otG/KY7eJjlZd5nLsn3kudSzQ1aMnY5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSO3QXz2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70814384238so57315207b3.0;
        Tue, 29 Apr 2025 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969935; x=1746574735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlPKsWIQtTq0kXJAAHxIhR2EL0TtNwMyl7VzV0J4eyc=;
        b=FSO3QXz2G4NkhsyPqE0faskxOpQTwcAYUadcCBMGQ6Kh4cyWO0ekLPiDCKTROanJwZ
         x+fVHjr4yIjYkFJbvMqKCth2GrE1qAMYb8OuXCi2QG4t2cUSOkjwxWSzUvkvur7GKi9m
         D32cqb16DKcxNychDi075k8FGcPdstMu9fyGymlpJ1eW2KgAHB/AbEMsTnP6JvZfE9gW
         eo38vHBZny/CLEbKSVghEm6Fsx1p7z+gKd6NLEpfy5vCMfBeEd4cOfhpLb52dxPKF3fw
         UW87Y83ROKiwzXE7RZSShcopnVve4tgI2AS+yjYxzdN86ic6t2eDMIJwpoYidKhiNA/K
         zS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969935; x=1746574735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlPKsWIQtTq0kXJAAHxIhR2EL0TtNwMyl7VzV0J4eyc=;
        b=nmDdSadPcQfxOQK0Mssi5fnSKhTFBv9uVwtXE9JOGAQwWU09ddgCgeQhXE68t0cobl
         kHbau0keh6gAYcsPzeqkP3z761zIrfyAEIhCH8hevGPPRA6rZ57cOw2HNu7HGA0E8BdP
         UIQvBeonxoM43oguxmymbodc994xjagpRPJy33NLnxbdiaaCJApRmUx62gDnlSSsWq4V
         pRuF1LcMxlrVEgg1G3xJ6mCxn38BBlGVcTKfmexJ4JvFWzaZkBIkBwfpMVNcEKxOhP9Y
         L/GMsyp7I9chhfAAJgLiT6ISe3pZtKsjlYcOtsFO7I2s97SSlkVxOc9MhtFJIm3DePL8
         RViw==
X-Forwarded-Encrypted: i=1; AJvYcCU5pehxTPxwAHCdi72J8D7BD3DhNlhOIt9g1HEuQaHvCmspUhm54RKbuKaed48SudV8yRo5Q3KR@vger.kernel.org, AJvYcCV2WcjJQeDnk+nD89lsFDXjMGrS3i9BMmDSjwawUZZDvvx7mAEIr03I17pvqVk7ZEDWH2gq6FeY6SI=@vger.kernel.org, AJvYcCVyaUW0zS/6ZRmwvXxtvr5rNbDmo8pJzwv9qYeaLR2Puuhe5mz0TIKhbxvFTQJdNGclBzq0agvEibQX6fnu@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlOBijuxQYhdo+NqI55wlc7ju6bcremH/0T1eSjyUkBgsqbfB
	QyVI39FsAsf8u15hilOMAGWzik8OANemVy+I1K2O71Tsz6m0V1MR
X-Gm-Gg: ASbGncuvBDfavZrGtsr8n1idEIzKZOBflI0y23AGe5V4Yf6oAEjBTs17BxqPRW3uVsy
	U8yMkzfQDcZThBlnZt2XC7yKfCtM+BcSJd5kfSOFmq2DOM7sHsQIYh69/aNqvQA+3T/0phZN9Yi
	sRaBPi+4bUZLCm6hc3El2BsZ4u9rwRzbewKJVCnBr4JGH4qdy9ruKRuiE9AEd1X8kcRQ86YAaIP
	po7SULWjfaLlpWBLwLMBaXI+qELk7eQVA3ZNQFG3N290rb5q2ZBVhZP1veIf1wum1CPPCoBi/gW
	so+Zo6CKkUs+97sk7wBupnH6phC/
X-Google-Smtp-Source: AGHT+IGONTd8guxRHJvy647hbI7ZqJLCliUkJVI8P7gVTtEIytul7Gg3vq/OHI3N/2vGVT3C4NylUg==
X-Received: by 2002:a05:690c:63c7:b0:702:72e3:1cb6 with SMTP id 00721157ae682-708abe0bab9mr20919227b3.26.1745969935407;
        Tue, 29 Apr 2025 16:38:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708adfc8160sm778457b3.6.2025.04.29.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:54 -0700 (PDT)
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
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 06/18] mm: create scaffolds for the new virtual swap implementation
Date: Tue, 29 Apr 2025 16:38:34 -0700
Message-ID: <20250429233848.3093350-7-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepration for the implementation of swap virtualization, add new
scaffolds for the new code:

1. Add a new mm/vswap.c source file, which currently only holds the
   logic to set up the (for now, empty) vswap debugfs directory. Hook
   this up in the swap setup step in mm/swap_state.c. Add a new
   maintainer entry for the new source file.

2. Add a new config option (CONFIG_VIRTUAL_SWAP). We will only get new
   behavior when the kernel is built with this config option. The entry
   for the config option in mm/Kconfig summarizes the pros and cons of
   the new virtual swap design, which the remainder of the patch series
   will implement.

3. Set up vswap compilation in the Makefile.

Other than the debugfs directory, no behavioral change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS          |  7 +++++++
 include/linux/swap.h |  9 +++++++++
 mm/Kconfig           | 25 +++++++++++++++++++++++++
 mm/Makefile          |  1 +
 mm/swap_state.c      |  6 ++++++
 mm/vswap.c           | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 mm/vswap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..65108bf2a5f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25290,6 +25290,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VIRTUAL SWAP SPACE
+M:	Nhat Pham <nphamcs@gmail.com>
+M:	Johannes Weiner <hannes@cmpxchg.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/vswap.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 567fd2ebb0d3..328f6aec9313 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -726,6 +726,15 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+#ifdef CONFIG_VIRTUAL_SWAP
+int vswap_init(void);
+#else /* CONFIG_VIRTUAL_SWAP */
+static inline int vswap_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_VIRTUAL_SWAP */
+
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
  *                         virtual swap slot.
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..2e8eb66c5888 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -22,6 +22,31 @@ menuconfig SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config VIRTUAL_SWAP
+	bool "Swap space virtualization"
+	depends on SWAP
+	default n
+	help
+		When this is selected, the kernel is built with the new swap
+		design, where each swap entry is associated with a virtual swap
+		slot that is decoupled from a specific physical backing storage
+		location. As a result, swap entries that are:
+
+		1. Zero-filled
+
+		2. Stored in the zswap pool.
+
+		3. Rejected by zswap/zram but cannot be written back to a
+		   backing swap device.
+
+		no longer take up any disk storage (i.e they do not occupy any
+		slot in the backing swap device).
+
+		Swapoff is also more efficient.
+
+		There might be more lock contentions with heavy swap use, since
+		the swap cache is no longer range partitioned.
+
 config ZSWAP
 	bool "Compressed cache for swap pages"
 	depends on SWAP
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..b7216c714fa1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -76,6 +76,7 @@ ifdef CONFIG_MMU
 endif
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
+obj-$(CONFIG_VIRTUAL_SWAP)	+= vswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cbd1532b6b24..1607d23a3d7b 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -930,6 +930,12 @@ static int __init swap_init_sysfs(void)
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
index 000000000000..b9c28e819cca
--- /dev/null
+++ b/mm/vswap.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual swap space
+ *
+ * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
+ */
+ #include <linux/swap.h>
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
2.47.1


