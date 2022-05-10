Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1C521EC3
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiEJPfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbiEJPfA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 11:35:00 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380FD9D
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w3so13452570qkb.3
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vinZWgoZEojVZkBqAXTBbUFaPvnoX78F1BhFbj27rbo=;
        b=F5N3EAeITGsvQjoLpfp31Rw1B5NGVlkUpcwT70tPv9+jzCnvmCmw3lnbEAWcdWZcsG
         0BJyzoHYKks79eG4T/YRNHEcLPMJY1D9oGiPLi2FS2jhvYQjYr/BiMYqhTeNwI5dLZpv
         NBEmwpq63Qem0C9Fn+qMcq1HlxK+zikZ1FoUkHf9CXHO/jH+RmcmbHe+Ay4yh2H3hIzU
         u+iBqkp2VCxnWEnhtjpNJoNOwPbsSVTBjzCwgCzwzkXWUOdHH2+NvSnMVGSzUEty2/Pr
         zDN9+vK3r9WEP8a5vL1B2doO5Uf2krYy9NP6SWd7VKkPTwimgIV1r6Tf5bOI5Wbrf31F
         bbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vinZWgoZEojVZkBqAXTBbUFaPvnoX78F1BhFbj27rbo=;
        b=PuD0TYmCiTv0eOqObuP/dg7WvdYebNPRqAykZRFJqYxhkykKtzvOusx4suxcdFIN3Q
         vC291eb5jMmIp2liyFDZ0HlaNbnV9RDSb+SoejHOO4GuP16raZ84qzTB3b6KNR/WpnRS
         +5szIraT9+d11h64eKQKV6Nkd4qyi4W0HEaE7nLxTEtPknCPsrywww8Yg0rxjckTQGWb
         XJaGXxvx4J82G1Lno/7I5PGFHMqIhEaGK+9burYF/BaofLbaCNysC2LijSdhQxUAj8W0
         bpKiFOTzlXDMVgfPKr9ULSMM2V+CcWitnCuu6YwMQjIX3wXG1KDDKjuM1S1p3vWoU0u7
         Mi6g==
X-Gm-Message-State: AOAM5319zzHbIGGxro75MPTRmljR3fTyG1GbZf8uVNfvgsqt1CEUD05f
        Rsy4gdqr8oVKt/gTz2cZPeHkGA==
X-Google-Smtp-Source: ABdhPJyXl/ols5EJ+o05oCyXatKwBy+xeABUaTjyFfV2ZDvEuCCMRSD7UYGhcZCzSewpO/xitlCpDQ==
X-Received: by 2002:a05:620a:28ca:b0:6a0:a0a9:b2e6 with SMTP id l10-20020a05620a28ca00b006a0a0a9b2e6mr6139469qkp.638.1652196592816;
        Tue, 10 May 2022 08:29:52 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85349000000b002f39b99f68bsm9184001qto.37.2022.05.10.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:29:52 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 4/6] mm: Kconfig: simplify zswap configuration
Date:   Tue, 10 May 2022 11:28:45 -0400
Message-Id: <20220510152847.230957-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220510152847.230957-1-hannes@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

- CONFIG_ZRAM: Zram is a user-facing feature, whereas zsmalloc is
  not. Don't make the user chase down a technical dependency like
  that, just select it in automatically when zram is requested. The
  CONFIG_CRYPTO dependency is redundant due to more specific deps.

- CONFIG_ZPOOL: This is not a user-facing feature. Hide the symbol and
  have it selected in as needed.

- CONFIG_ZSWAP: Select CRYPTO instead of depend. Common pattern.

- Make the ZSWAP suboptions and their descriptions (compression,
  allocation backend) a bit more straight-forward for the user.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 drivers/block/zram/Kconfig |  3 ++-
 mm/Kconfig                 | 55 +++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 668c6bf2554d..e4163d4b936b 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
+	depends on BLOCK && SYSFS
 	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
+	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
diff --git a/mm/Kconfig b/mm/Kconfig
index 2c5935a28edf..c87ffd0d98b3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -9,6 +9,9 @@ menu "Memory Management options"
 config ARCH_NO_SWAP
 	bool
 
+config ZPOOL
+	bool
+
 menuconfig SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU && BLOCK && !ARCH_NO_SWAP
@@ -21,8 +24,9 @@ menuconfig SWAP
 
 config ZSWAP
 	bool "Compressed cache for swap pages (EXPERIMENTAL)"
-	depends on SWAP && CRYPTO=y
+	depends on SWAP
 	select FRONTSWAP
+	select CRYPTO
 	select ZPOOL
 	help
 	  A lightweight compressed cache for swap pages.  It takes
@@ -38,8 +42,18 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
+config ZSWAP_DEFAULT_ON
+	bool "Enable the compressed cache for swap pages by default"
+	depends on ZSWAP
+	help
+	  If selected, the compressed cache for swap pages will be enabled
+	  at boot, otherwise it will be disabled.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.enabled=' option.
+
 choice
-	prompt "Compressed cache for swap pages default compressor"
+	prompt "Default compressor"
 	depends on ZSWAP
 	default ZSWAP_COMPRESSOR_DEFAULT_LZO
 	help
@@ -105,7 +119,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
        default ""
 
 choice
-	prompt "Compressed cache for swap pages default allocator"
+	prompt "Default allocator"
 	depends on ZSWAP
 	default ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
@@ -145,26 +159,9 @@ config ZSWAP_ZPOOL_DEFAULT
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
-config ZSWAP_DEFAULT_ON
-	bool "Enable the compressed cache for swap pages by default"
-	depends on ZSWAP
-	help
-	  If selected, the compressed cache for swap pages will be enabled
-	  at boot, otherwise it will be disabled.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.enabled=' option.
-
-config ZPOOL
-	tristate "Common API for compressed memory storage"
-	depends on ZSWAP
-	help
-	  Compressed memory storage API.  This allows using either zbud or
-	  zsmalloc.
-
 config ZBUD
-	tristate "Low (Up to 2x) density storage for compressed pages"
-	depends on ZPOOL
+	tristate "2:1 compression allocator (zbud)"
+	depends on ZSWAP
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to two compressed pages per physical
@@ -173,8 +170,8 @@ config ZBUD
 	  density approach when reclaim will be used.
 
 config Z3FOLD
-	tristate "Up to 3x density storage for compressed pages"
-	depends on ZPOOL
+	tristate "3:1 compression allocator (z3fold)"
+	depends on ZSWAP
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
@@ -182,15 +179,13 @@ config Z3FOLD
 	  still there.
 
 config ZSMALLOC
-	tristate "Memory allocator for compressed pages"
+	tristate
+	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
 	depends on MMU
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
-	  compressed RAM pages.  zsmalloc uses virtual memory mapping
-	  in order to reduce fragmentation.  However, this results in a
-	  non-standard allocator interface where a handle, not a pointer, is
-	  returned by an alloc().  This handle must be mapped in order to
-	  access the allocated space.
+	  pages of various compression levels efficiently. It achieves
+	  the highest storage density with the least amount of fragmentation.
 
 config ZSMALLOC_STAT
 	bool "Export zsmalloc statistics"
-- 
2.35.3

