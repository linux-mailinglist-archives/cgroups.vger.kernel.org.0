Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9B511EE8
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiD0QGB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbiD0QEh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 12:04:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584432EFF3A
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:16 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id iy15so1343610qvb.9
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/0K4rhg5IgvB73PlrQVfwuUAVK4bF/MkHixi5HKK+E=;
        b=azivg7zPNFD5+jwnj9eFiWNBsth+HzyDUKu7UpW+HW+EAUT65CWXq+g8WatJBzyg0R
         FPMFrc1b90UaLW2+spq18zhQHWkbYd/pQ9OtyW/dgSVVO3LLHoAjuglyE/vzbXXvNnxI
         epAvtx3YTJjoMiKDnpqZKdZw0spF3AQr9u43CA93HTyPZNtJtiMw3g4ARpKwgGkNwbSN
         iD4nkLl4hzfhmWu4p0q5AudvxQW5FvrVSXuQUYgqK8a5Of0BcTlTt6cBGn2+xhQAwJsw
         hrLmwUG3spQAsfoUacVCbmo5Gf13VOqRVv8r9Hhzz+R2GEG3b2gnL5W3YohnKcKEOPUN
         T5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/0K4rhg5IgvB73PlrQVfwuUAVK4bF/MkHixi5HKK+E=;
        b=7oqRH7RzhgMRtFGApHrnV0Rt/PCm+n5wdQ9aUz2MKJVG9ulVWYotloCiz1mrhgegdJ
         k+CyAlakJHvTWalHRfTQvEA6mQ3ebvAFuHCh/lseDo30PoUE5StW+vhSxmF+kLDmLh80
         wbYPnST2EOpX8aQvL6yKDfBEQKVAvEd2qbdBsfV+os0FjYAzlKSAyxWabIO8mwn0wAsr
         63pEm6e1cl5Lwd3Emkl4J2GIbkLYkP/jMX7fHD4w71W9WTX6+aXAQXVhLr4yC/b9FHt2
         7jKvmFK/cP7w+3aGtfmGjMLwx/gE/feehd68lmsGE7R4phmYzphw+inN3QY4GB7aQvF4
         1GbA==
X-Gm-Message-State: AOAM530rR227Nd24GiS9+3ZyCIXLMXvh/RF+CnUv6llaYdM8wRJM8Jyn
        zYd6hOEyquVlmnDKzDSZPKDE0A==
X-Google-Smtp-Source: ABdhPJzEwvhzqs1UuJm8LYCNgaMSHPJlROKkK0LCzd4dEmfy2ScYs1a/bOe1K6xjltmKgT6YFs5Gsw==
X-Received: by 2002:a05:6214:2304:b0:438:458e:eafc with SMTP id gc4-20020a056214230400b00438458eeafcmr20372999qvb.118.1651075259325;
        Wed, 27 Apr 2022 09:00:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a12eb00b0069c88d15b6asm8032759qkl.68.2022.04.27.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:00:59 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/5] mm: Kconfig: group swap, slab, hotplug and thp options into submenus
Date:   Wed, 27 Apr 2022 12:00:13 -0400
Message-Id: <20220427160016.144237-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427160016.144237-1-hannes@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are several clusters of related config options spread throughout
the mostly flat MM submenu. Group them together and put specialization
options into further subdirectories to make the MM submenu a bit more
organized and easier to navigate.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/Kconfig | 429 +++++++++++++++++++++++++++--------------------------
 1 file changed, 221 insertions(+), 208 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 675a6be43739..2c5935a28edf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -9,7 +9,7 @@ menu "Memory Management options"
 config ARCH_NO_SWAP
 	bool
 
-config SWAP
+menuconfig SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU && BLOCK && !ARCH_NO_SWAP
 	default y
@@ -19,6 +19,191 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config ZSWAP
+	bool "Compressed cache for swap pages (EXPERIMENTAL)"
+	depends on SWAP && CRYPTO=y
+	select FRONTSWAP
+	select ZPOOL
+	help
+	  A lightweight compressed cache for swap pages.  It takes
+	  pages that are in the process of being swapped out and attempts to
+	  compress them into a dynamically allocated RAM-based memory pool.
+	  This can result in a significant I/O reduction on swap device and,
+	  in the case where decompressing from RAM is faster that swap device
+	  reads, can also improve workload performance.
+
+	  This is marked experimental because it is a new feature (as of
+	  v3.11) that interacts heavily with memory reclaim.  While these
+	  interactions don't cause any known issues on simple memory setups,
+	  they have not be fully explored on the large set of potential
+	  configurations and workloads that exist.
+
+choice
+	prompt "Compressed cache for swap pages default compressor"
+	depends on ZSWAP
+	default ZSWAP_COMPRESSOR_DEFAULT_LZO
+	help
+	  Selects the default compression algorithm for the compressed cache
+	  for swap pages.
+
+	  For an overview what kind of performance can be expected from
+	  a particular compression algorithm please refer to the benchmarks
+	  available at the following LWN page:
+	  https://lwn.net/Articles/751795/
+
+	  If in doubt, select 'LZO'.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.compressor=' option.
+
+config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+	bool "Deflate"
+	select CRYPTO_DEFLATE
+	help
+	  Use the Deflate algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZO
+	bool "LZO"
+	select CRYPTO_LZO
+	help
+	  Use the LZO algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_842
+	bool "842"
+	select CRYPTO_842
+	help
+	  Use the 842 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4
+	bool "LZ4"
+	select CRYPTO_LZ4
+	help
+	  Use the LZ4 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+	bool "LZ4HC"
+	select CRYPTO_LZ4HC
+	help
+	  Use the LZ4HC algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+	bool "zstd"
+	select CRYPTO_ZSTD
+	help
+	  Use the zstd algorithm as the default compression algorithm.
+endchoice
+
+config ZSWAP_COMPRESSOR_DEFAULT
+       string
+       depends on ZSWAP
+       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
+       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
+       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
+       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+       default ""
+
+choice
+	prompt "Compressed cache for swap pages default allocator"
+	depends on ZSWAP
+	default ZSWAP_ZPOOL_DEFAULT_ZBUD
+	help
+	  Selects the default allocator for the compressed cache for
+	  swap pages.
+	  The default is 'zbud' for compatibility, however please do
+	  read the description of each of the allocators below before
+	  making a right choice.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.zpool=' option.
+
+config ZSWAP_ZPOOL_DEFAULT_ZBUD
+	bool "zbud"
+	select ZBUD
+	help
+	  Use the zbud allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+	bool "z3fold"
+	select Z3FOLD
+	help
+	  Use the z3fold allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+	bool "zsmalloc"
+	select ZSMALLOC
+	help
+	  Use the zsmalloc allocator as the default allocator.
+endchoice
+
+config ZSWAP_ZPOOL_DEFAULT
+       string
+       depends on ZSWAP
+       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+       default ""
+
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
+config ZPOOL
+	tristate "Common API for compressed memory storage"
+	depends on ZSWAP
+	help
+	  Compressed memory storage API.  This allows using either zbud or
+	  zsmalloc.
+
+config ZBUD
+	tristate "Low (Up to 2x) density storage for compressed pages"
+	depends on ZPOOL
+	help
+	  A special purpose allocator for storing compressed pages.
+	  It is designed to store up to two compressed pages per physical
+	  page.  While this design limits storage density, it has simple and
+	  deterministic reclaim properties that make it preferable to a higher
+	  density approach when reclaim will be used.
+
+config Z3FOLD
+	tristate "Up to 3x density storage for compressed pages"
+	depends on ZPOOL
+	help
+	  A special purpose allocator for storing compressed pages.
+	  It is designed to store up to three compressed pages per physical
+	  page. It is a ZBUD derivative so the simplicity and determinism are
+	  still there.
+
+config ZSMALLOC
+	tristate "Memory allocator for compressed pages"
+	depends on MMU
+	help
+	  zsmalloc is a slab-based memory allocator designed to store
+	  compressed RAM pages.  zsmalloc uses virtual memory mapping
+	  in order to reduce fragmentation.  However, this results in a
+	  non-standard allocator interface where a handle, not a pointer, is
+	  returned by an alloc().  This handle must be mapped in order to
+	  access the allocated space.
+
+config ZSMALLOC_STAT
+	bool "Export zsmalloc statistics"
+	depends on ZSMALLOC
+	select DEBUG_FS
+	help
+	  This option enables code in the zsmalloc to collect various
+	  statistics about what's happening in zsmalloc and exports that
+	  information to userspace via debugfs.
+	  If unsure, say N.
+
+menu "SLAB allocator options"
+
 choice
 	prompt "Choose SLAB allocator"
 	default SLUB
@@ -90,6 +275,19 @@ config SLAB_FREELIST_HARDENED
 	  sanity-checking than others. This option is most effective with
 	  CONFIG_SLUB.
 
+config SLUB_CPU_PARTIAL
+	default y
+	depends on SLUB && SMP
+	bool "SLUB per cpu partial cache"
+	help
+	  Per cpu partial caches accelerate objects allocation and freeing
+	  that is local to a processor at the price of more indeterminism
+	  in the latency of the free. On overflow these caches will be cleared
+	  which requires the taking of locks that may cause latency spikes.
+	  Typically one would choose no for a realtime system.
+
+endmenu # SLAB allocator options
+
 config SHUFFLE_PAGE_ALLOCATOR
 	bool "Page allocator randomization"
 	default SLAB_FREELIST_RANDOM && ACPI_NUMA
@@ -114,17 +312,6 @@ config SHUFFLE_PAGE_ALLOCATOR
 
 	  Say Y if unsure.
 
-config SLUB_CPU_PARTIAL
-	default y
-	depends on SLUB && SMP
-	bool "SLUB per cpu partial cache"
-	help
-	  Per cpu partial caches accelerate objects allocation and freeing
-	  that is local to a processor at the price of more indeterminism
-	  in the latency of the free. On overflow these caches will be cleared
-	  which requires the taking of locks that may cause latency spikes.
-	  Typically one would choose no for a realtime system.
-
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
@@ -250,14 +437,16 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 	bool
 
 # eventually, we can have this option just 'select SPARSEMEM'
-config MEMORY_HOTPLUG
-	bool "Allow for memory hot-add"
+menuconfig MEMORY_HOTPLUG
+	bool "Memory hotplug"
 	select MEMORY_ISOLATION
 	depends on SPARSEMEM
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT
 	select NUMA_KEEP_MEMINFO if NUMA
 
+if MEMORY_HOTPLUG
+
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
 	bool "Online the newly added memory blocks by default"
 	depends on MEMORY_HOTPLUG
@@ -287,6 +476,8 @@ config MHP_MEMMAP_ON_MEMORY
 	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
 	depends on ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 
+endif # MEMORY_HOTPLUG
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
@@ -501,7 +692,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 
 	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
-config TRANSPARENT_HUGEPAGE
+menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
 	select COMPACTION
@@ -516,6 +707,8 @@ config TRANSPARENT_HUGEPAGE
 
 	  If memory constrained on embedded, you may want to say N.
 
+if TRANSPARENT_HUGEPAGE
+
 choice
 	prompt "Transparent Hugepage Support sysfs defaults"
 	depends on TRANSPARENT_HUGEPAGE
@@ -556,6 +749,19 @@ config THP_SWAP
 
 	  For selection by architectures with reasonable THP sizes.
 
+config READ_ONLY_THP_FOR_FS
+	bool "Read-only THP for filesystems (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && SHMEM
+
+	help
+	  Allow khugepaged to put read-only file-backed pages in THP.
+
+	  This is marked experimental because it is a new feature. Write
+	  support of file THPs will be developed in the next few release
+	  cycles.
+
+endif # TRANSPARENT_HUGEPAGE
+
 #
 # UP and nommu archs use km based percpu allocator
 #
@@ -640,188 +846,6 @@ config MEM_SOFT_DIRTY
 
 	  See Documentation/admin-guide/mm/soft-dirty.rst for more details.
 
-config ZSWAP
-	bool "Compressed cache for swap pages (EXPERIMENTAL)"
-	depends on SWAP && CRYPTO=y
-	select FRONTSWAP
-	select ZPOOL
-	help
-	  A lightweight compressed cache for swap pages.  It takes
-	  pages that are in the process of being swapped out and attempts to
-	  compress them into a dynamically allocated RAM-based memory pool.
-	  This can result in a significant I/O reduction on swap device and,
-	  in the case where decompressing from RAM is faster that swap device
-	  reads, can also improve workload performance.
-
-	  This is marked experimental because it is a new feature (as of
-	  v3.11) that interacts heavily with memory reclaim.  While these
-	  interactions don't cause any known issues on simple memory setups,
-	  they have not be fully explored on the large set of potential
-	  configurations and workloads that exist.
-
-choice
-	prompt "Compressed cache for swap pages default compressor"
-	depends on ZSWAP
-	default ZSWAP_COMPRESSOR_DEFAULT_LZO
-	help
-	  Selects the default compression algorithm for the compressed cache
-	  for swap pages.
-
-	  For an overview what kind of performance can be expected from
-	  a particular compression algorithm please refer to the benchmarks
-	  available at the following LWN page:
-	  https://lwn.net/Articles/751795/
-
-	  If in doubt, select 'LZO'.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.compressor=' option.
-
-config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
-	bool "Deflate"
-	select CRYPTO_DEFLATE
-	help
-	  Use the Deflate algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZO
-	bool "LZO"
-	select CRYPTO_LZO
-	help
-	  Use the LZO algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_842
-	bool "842"
-	select CRYPTO_842
-	help
-	  Use the 842 algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4
-	bool "LZ4"
-	select CRYPTO_LZ4
-	help
-	  Use the LZ4 algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
-	bool "LZ4HC"
-	select CRYPTO_LZ4HC
-	help
-	  Use the LZ4HC algorithm as the default compression algorithm.
-
-config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
-	bool "zstd"
-	select CRYPTO_ZSTD
-	help
-	  Use the zstd algorithm as the default compression algorithm.
-endchoice
-
-config ZSWAP_COMPRESSOR_DEFAULT
-       string
-       depends on ZSWAP
-       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
-       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
-       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
-       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
-       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
-       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
-       default ""
-
-choice
-	prompt "Compressed cache for swap pages default allocator"
-	depends on ZSWAP
-	default ZSWAP_ZPOOL_DEFAULT_ZBUD
-	help
-	  Selects the default allocator for the compressed cache for
-	  swap pages.
-	  The default is 'zbud' for compatibility, however please do
-	  read the description of each of the allocators below before
-	  making a right choice.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.zpool=' option.
-
-config ZSWAP_ZPOOL_DEFAULT_ZBUD
-	bool "zbud"
-	select ZBUD
-	help
-	  Use the zbud allocator as the default allocator.
-
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
-	help
-	  Use the z3fold allocator as the default allocator.
-
-config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
-	bool "zsmalloc"
-	select ZSMALLOC
-	help
-	  Use the zsmalloc allocator as the default allocator.
-endchoice
-
-config ZSWAP_ZPOOL_DEFAULT
-       string
-       depends on ZSWAP
-       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
-       default ""
-
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
-	help
-	  Compressed memory storage API.  This allows using either zbud or
-	  zsmalloc.
-
-config ZBUD
-	tristate "Low (Up to 2x) density storage for compressed pages"
-	depends on ZPOOL
-	help
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to two compressed pages per physical
-	  page.  While this design limits storage density, it has simple and
-	  deterministic reclaim properties that make it preferable to a higher
-	  density approach when reclaim will be used.
-
-config Z3FOLD
-	tristate "Up to 3x density storage for compressed pages"
-	depends on ZPOOL
-	help
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to three compressed pages per physical
-	  page. It is a ZBUD derivative so the simplicity and determinism are
-	  still there.
-
-config ZSMALLOC
-	tristate "Memory allocator for compressed pages"
-	depends on MMU
-	help
-	  zsmalloc is a slab-based memory allocator designed to store
-	  compressed RAM pages.  zsmalloc uses virtual memory mapping
-	  in order to reduce fragmentation.  However, this results in a
-	  non-standard allocator interface where a handle, not a pointer, is
-	  returned by an alloc().  This handle must be mapped in order to
-	  access the allocated space.
-
-config ZSMALLOC_STAT
-	bool "Export zsmalloc statistics"
-	depends on ZSMALLOC
-	select DEBUG_FS
-	help
-	  This option enables code in the zsmalloc to collect various
-	  statistics about what's happening in zsmalloc and exports that
-	  information to userspace via debugfs.
-	  If unsure, say N.
-
 config GENERIC_EARLY_IOREMAP
 	bool
 
@@ -978,17 +1002,6 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
 config GUP_GET_PTE_LOW_HIGH
 	bool
 
-config READ_ONLY_THP_FOR_FS
-	bool "Read-only THP for filesystems (EXPERIMENTAL)"
-	depends on TRANSPARENT_HUGEPAGE && SHMEM
-
-	help
-	  Allow khugepaged to put read-only file-backed pages in THP.
-
-	  This is marked experimental because it is a new feature. Write
-	  support of file THPs will be developed in the next few release
-	  cycles.
-
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
-- 
2.35.3

