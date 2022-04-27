Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E051211D
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbiD0QF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbiD0QEm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 12:04:42 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBA26BAD6
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s4so1651068qkh.0
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vinZWgoZEojVZkBqAXTBbUFaPvnoX78F1BhFbj27rbo=;
        b=ZFL07umLq+hzQI4JolWQKoGpTL0cqgEy7zHkI4QwTmDPIsOs1WMGvS7YKH6pyMPPxP
         UDKKdA1rtfogn3yQj8wj+jjyPk5ABVEcfAZYXVUsDsIrVEgPqWCDmxa71Lf1xkrJfYFn
         dh1oWnFrnf6S/5Ok7DskR7ExlS/0oJ42h+aEi7TG0jLCb9E2yQAtyGS5JPjx+CE9kOku
         U73pXh265MAmidgNSHGd4assyIkcTVYgjYAuN24Xt2l31JS3jXVQJVnM/XNry4qtPkr7
         Cwb54hSIIw959Ok1y0OGpocs6mYukblcRcQkqv3Lmy7oZkOLxZmQ65fW2zrNWY63dR2K
         u1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vinZWgoZEojVZkBqAXTBbUFaPvnoX78F1BhFbj27rbo=;
        b=Co1Jlxspe2hbsez1Ocd+aEV1fQId7RVWx2HyDilLozB6wIwcb5cKVx1KjoA/Nx+j++
         dwLv48R6d4/8epJmYU0XgP3c5Vh0cijCfnGVFhz21u5p32e4C0hVDvV1QMWxBccK1jsZ
         FbabkKkbMFhbVWK+fv9TmVkZU7Hdu5my1xmK7cDiO1k46rbljnhr+GNrUH2QmmQU04bI
         0mfAmM8SaYGcrRhRjU8MfAYEB4VfITeRtrddHrX3sOFb+VLSnpdZuMFRyaVu8t7Q3raZ
         dPFkRMkRylGVY6qBguhqlksKRoHnZslaDo3BqvlBn/IwIOXK7jaeXMNKfsEYyYqS1QZS
         1VMA==
X-Gm-Message-State: AOAM533J48XuNR7RvGZ7AurwS6iexuNcT5Eqcmy3C/XR8nwge+P1TLjh
        AijDjV2GPIuOKzVE2RMdrajEvg==
X-Google-Smtp-Source: ABdhPJzRBAx6aLov/suPqj6dRMHWr7HI8Dkvw0gLToUQyrwMqcKGOlz+ixNHNMGVvP7o8B/92dk1GA==
X-Received: by 2002:a05:620a:bd4:b0:47b:4c75:894e with SMTP id s20-20020a05620a0bd400b0047b4c75894emr16456770qki.425.1651075261659;
        Wed, 27 Apr 2022 09:01:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0a8c00b0069eabadd6dasm7954916qkg.41.2022.04.27.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:01:01 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/5] mm: Kconfig: simplify zswap configuration
Date:   Wed, 27 Apr 2022 12:00:14 -0400
Message-Id: <20220427160016.144237-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427160016.144237-1-hannes@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

