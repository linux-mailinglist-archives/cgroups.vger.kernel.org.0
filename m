Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAE521EC6
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiEJPfR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbiEJPeh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 11:34:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF91A810F
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c1so13435612qkf.13
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsj16Ee0guBN0gpdXp2AuLzbDIq1BETjMO2kD2xZlKg=;
        b=YP3zZgh2jWYcOfyu5clL/3s4FWFRSZGWm5A0/IMVIbhy3w2aHSPb8w+Ov37scDmv/N
         DKe2+oSFuWsht5QEVzewPrDIB6yaJv3UN5829aCHgAHCX+bdpmf/pdIxyKvfvc+D9jCF
         zQf5VBMyeVQsBrSa7wblypzmav/PO6vpyyDVupwuFYOXhkJsq98Tf16UZDN/aHCRc/sE
         KIcGid4tEhAqBCEsCulsucaRH8E9EpMFIAcjDMYc5GSyxvD4wXnLVrkenXLS9TkwgI8O
         rZ19YwGKw64aKpCJo/jFAmXOU+DnI6Z2Ncsg1Sm23gK1/EbXojPdnYb4oBscTjxpVYxB
         kXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsj16Ee0guBN0gpdXp2AuLzbDIq1BETjMO2kD2xZlKg=;
        b=V2Mmy7U74YAXwX0kQzrP9xFZXNZpi2Y4pCtJCfN7sGn8JMpEmCRNDj0WBqY3C48QA9
         GPCdVVU/e6p8va1EGn59+cchmgOzzUdjjjhw/MyAzQl8baAfn268fFJ+4beVVhFbk3QG
         XXanmMmgjgQDT7kyAAJHE6Ttpnuw2Ix+qhkEtaupyZSCGENT8CkxyZunBIeoCC4YcZR1
         voiunMkCkVWMfgJaqiuk94ZRHFXMKkvQtp+MLnaKgzje8Obn0SQQA/0RXi29Dq1KQ4Mm
         H3R+oSFThMa4ekc9EJTa+9P83SqFXf196/Y9KlZxJUbDJmPZugjae9KKUA5bRCX9OsWA
         7sKw==
X-Gm-Message-State: AOAM533AGukf0Ih5ObIix4MdARD0lUkQNC2s0xQ3TAM6jGPYcMjseF6M
        fEhiaC0QCzjIKJPK2S+VKqx0oQ==
X-Google-Smtp-Source: ABdhPJwa6HsqpZwkprM4H/p7TsbCmthAmqSBcBSJaBx2biQaeRbD+H9oZKucHvfk5N3OvH7ZjRI+4A==
X-Received: by 2002:a05:620a:c43:b0:67d:f048:f5e9 with SMTP id u3-20020a05620a0c4300b0067df048f5e9mr15748885qki.281.1652196590503;
        Tue, 10 May 2022 08:29:50 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8480a000000b002f39b99f6aesm9287927qtq.72.2022.05.10.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:29:50 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 2/6] mm: Kconfig: move swap and slab config options to the MM section
Date:   Tue, 10 May 2022 11:28:43 -0400
Message-Id: <20220510152847.230957-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220510152847.230957-1-hannes@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These are currently under General Setup. MM seems like a better fit.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 init/Kconfig | 123 ---------------------------------------------------
 mm/Kconfig   | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 123 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4489416f1e5c..468fe27cec0b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -375,23 +375,6 @@ config DEFAULT_HOSTNAME
 	  but you may wish to use a different default here to make a minimal
 	  system more usable with less configuration.
 
-#
-# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
-# add proper SWAP support to them, in which case this can be remove.
-#
-config ARCH_NO_SWAP
-	bool
-
-config SWAP
-	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU && BLOCK && !ARCH_NO_SWAP
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for so called swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unsure say Y.
-
 config SYSVIPC
 	bool "System V IPC"
 	help
@@ -1909,112 +1892,6 @@ config COMPAT_BRK
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
-choice
-	prompt "Choose SLAB allocator"
-	default SLUB
-	help
-	   This option allows to select a slab allocator.
-
-config SLAB
-	bool "SLAB"
-	depends on !PREEMPT_RT
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
-	help
-	  The regular slab allocator that is established and known to work
-	  well in all environments. It organizes cache hot objects in
-	  per cpu and per node queues.
-
-config SLUB
-	bool "SLUB (Unqueued Allocator)"
-	select HAVE_HARDENED_USERCOPY_ALLOCATOR
-	help
-	   SLUB is a slab allocator that minimizes cache line usage
-	   instead of managing queues of cached objects (SLAB approach).
-	   Per cpu caching is realized using slabs of objects instead
-	   of queues of objects. SLUB can use memory efficiently
-	   and has enhanced diagnostics. SLUB is the default choice for
-	   a slab allocator.
-
-config SLOB
-	depends on EXPERT
-	bool "SLOB (Simple Allocator)"
-	depends on !PREEMPT_RT
-	help
-	   SLOB replaces the stock allocator with a drastically simpler
-	   allocator. SLOB is generally more space efficient but
-	   does not perform as well on large systems.
-
-endchoice
-
-config SLAB_MERGE_DEFAULT
-	bool "Allow slab caches to be merged"
-	default y
-	depends on SLAB || SLUB
-	help
-	  For reduced kernel memory fragmentation, slab caches can be
-	  merged when they share the same size and other characteristics.
-	  This carries a risk of kernel heap overflows being able to
-	  overwrite objects from merged caches (and more easily control
-	  cache layout), which makes such heap attacks easier to exploit
-	  by attackers. By keeping caches unmerged, these kinds of exploits
-	  can usually only damage objects in the same cache. To disable
-	  merging at runtime, "slab_nomerge" can be passed on the kernel
-	  command line.
-
-config SLAB_FREELIST_RANDOM
-	bool "Randomize slab freelist"
-	depends on SLAB || SLUB
-	help
-	  Randomizes the freelist order used on creating new pages. This
-	  security feature reduces the predictability of the kernel slab
-	  allocator against heap overflows.
-
-config SLAB_FREELIST_HARDENED
-	bool "Harden slab freelist metadata"
-	depends on SLAB || SLUB
-	help
-	  Many kernel heap attacks try to target slab cache metadata and
-	  other infrastructure. This options makes minor performance
-	  sacrifices to harden the kernel slab allocator against common
-	  freelist exploit methods. Some slab implementations have more
-	  sanity-checking than others. This option is most effective with
-	  CONFIG_SLUB.
-
-config SHUFFLE_PAGE_ALLOCATOR
-	bool "Page allocator randomization"
-	default SLAB_FREELIST_RANDOM && ACPI_NUMA
-	help
-	  Randomization of the page allocator improves the average
-	  utilization of a direct-mapped memory-side-cache. See section
-	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
-	  6.2a specification for an example of how a platform advertises
-	  the presence of a memory-side-cache. There are also incidental
-	  security benefits as it reduces the predictability of page
-	  allocations to compliment SLAB_FREELIST_RANDOM, but the
-	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
-	  10th order of pages is selected based on cache utilization
-	  benefits on x86.
-
-	  While the randomization improves cache utilization it may
-	  negatively impact workloads on platforms without a cache. For
-	  this reason, by default, the randomization is enabled only
-	  after runtime detection of a direct-mapped memory-side-cache.
-	  Otherwise, the randomization may be force enabled with the
-	  'page_alloc.shuffle' kernel command line parameter.
-
-	  Say Y if unsure.
-
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
 config MMAP_ALLOW_UNINITIALIZED
 	bool "Allow mmapped anonymous memory to be uninitialized"
 	depends on EXPERT && !MMU
diff --git a/mm/Kconfig b/mm/Kconfig
index c2141dd639e3..675a6be43739 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -2,6 +2,129 @@
 
 menu "Memory Management options"
 
+#
+# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
+# add proper SWAP support to them, in which case this can be remove.
+#
+config ARCH_NO_SWAP
+	bool
+
+config SWAP
+	bool "Support for paging of anonymous memory (swap)"
+	depends on MMU && BLOCK && !ARCH_NO_SWAP
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for so called swap devices or swap files in your kernel that are
+	  used to provide more virtual memory than the actual RAM present
+	  in your computer.  If unsure say Y.
+
+choice
+	prompt "Choose SLAB allocator"
+	default SLUB
+	help
+	   This option allows to select a slab allocator.
+
+config SLAB
+	bool "SLAB"
+	depends on !PREEMPT_RT
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
+	help
+	  The regular slab allocator that is established and known to work
+	  well in all environments. It organizes cache hot objects in
+	  per cpu and per node queues.
+
+config SLUB
+	bool "SLUB (Unqueued Allocator)"
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
+	help
+	   SLUB is a slab allocator that minimizes cache line usage
+	   instead of managing queues of cached objects (SLAB approach).
+	   Per cpu caching is realized using slabs of objects instead
+	   of queues of objects. SLUB can use memory efficiently
+	   and has enhanced diagnostics. SLUB is the default choice for
+	   a slab allocator.
+
+config SLOB
+	depends on EXPERT
+	bool "SLOB (Simple Allocator)"
+	depends on !PREEMPT_RT
+	help
+	   SLOB replaces the stock allocator with a drastically simpler
+	   allocator. SLOB is generally more space efficient but
+	   does not perform as well on large systems.
+
+endchoice
+
+config SLAB_MERGE_DEFAULT
+	bool "Allow slab caches to be merged"
+	default y
+	depends on SLAB || SLUB
+	help
+	  For reduced kernel memory fragmentation, slab caches can be
+	  merged when they share the same size and other characteristics.
+	  This carries a risk of kernel heap overflows being able to
+	  overwrite objects from merged caches (and more easily control
+	  cache layout), which makes such heap attacks easier to exploit
+	  by attackers. By keeping caches unmerged, these kinds of exploits
+	  can usually only damage objects in the same cache. To disable
+	  merging at runtime, "slab_nomerge" can be passed on the kernel
+	  command line.
+
+config SLAB_FREELIST_RANDOM
+	bool "Randomize slab freelist"
+	depends on SLAB || SLUB
+	help
+	  Randomizes the freelist order used on creating new pages. This
+	  security feature reduces the predictability of the kernel slab
+	  allocator against heap overflows.
+
+config SLAB_FREELIST_HARDENED
+	bool "Harden slab freelist metadata"
+	depends on SLAB || SLUB
+	help
+	  Many kernel heap attacks try to target slab cache metadata and
+	  other infrastructure. This options makes minor performance
+	  sacrifices to harden the kernel slab allocator against common
+	  freelist exploit methods. Some slab implementations have more
+	  sanity-checking than others. This option is most effective with
+	  CONFIG_SLUB.
+
+config SHUFFLE_PAGE_ALLOCATOR
+	bool "Page allocator randomization"
+	default SLAB_FREELIST_RANDOM && ACPI_NUMA
+	help
+	  Randomization of the page allocator improves the average
+	  utilization of a direct-mapped memory-side-cache. See section
+	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
+	  6.2a specification for an example of how a platform advertises
+	  the presence of a memory-side-cache. There are also incidental
+	  security benefits as it reduces the predictability of page
+	  allocations to compliment SLAB_FREELIST_RANDOM, but the
+	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
+	  10th order of pages is selected based on cache utilization
+	  benefits on x86.
+
+	  While the randomization improves cache utilization it may
+	  negatively impact workloads on platforms without a cache. For
+	  this reason, by default, the randomization is enabled only
+	  after runtime detection of a direct-mapped memory-side-cache.
+	  Otherwise, the randomization may be force enabled with the
+	  'page_alloc.shuffle' kernel command line parameter.
+
+	  Say Y if unsure.
+
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
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
-- 
2.35.3

