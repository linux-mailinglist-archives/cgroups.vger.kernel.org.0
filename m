Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E52511FD7
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbiD0QF4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiD0QEi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 12:04:38 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42A36F8F7
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id e17so1339907qvj.11
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsj16Ee0guBN0gpdXp2AuLzbDIq1BETjMO2kD2xZlKg=;
        b=xi8WITLcAxwkSdTOuZL5LSJbzMRqu28W9ukS7yVDQ8SJy5Neabs9pQJOQ3iK1+e8FY
         NdIdJ9ggDKHPS/HSOBpDp6kjIYsmL+fLdAQICPOJJFmnlnh92CvZK5RZkvDYlmD05Xh9
         vEixjTl/uHsygAbohQm+HoKc9nk7cGrcyWoVSNrEfNYiZZtMrlbqAW+uTczPRJGSCDTm
         ClTVAFYUMgRydj0oOKOPLkCleCYl8J5At648Erjc496dnGgfHg9YCJyt4kCFPGRAbuJu
         16KbgJrA5NqyF4ktmStgevvE9dOM0RoW0wkWCXt3XSKUXovHFI2N+v4JoIBrVHv3n6Zd
         uxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsj16Ee0guBN0gpdXp2AuLzbDIq1BETjMO2kD2xZlKg=;
        b=O32/m5KBQ00MU6MsVJQnKk5WK9vZnwh7+GhAnxn152CzxTMBguJKtkcsybmRncgGIU
         kZbjfxQRwEB5OPCr3tTE6Fh0azgNnaA7QepNgaN6HtROdLfBs0ylow8yAaWIWOxqtiU5
         BLlZLQyUQULJFqA3YzgFde/MY+qCryQG68Ma00WT1I85O+JplGpUmwLWog8TWQXPCbXl
         3BwUd5yiPkCr42NaPvgJpoftvmNxBGlkqIJTN/LHY59n7+0eqq8Z89LgnRSHXnDjFUzY
         9WAwqIBCSR5em3u6ny6VcO4YhG9MGNPCneGgyfrm+/qSoh3avWOXAWWRXgXiJX+BCIxl
         NpDg==
X-Gm-Message-State: AOAM531AnpEq+I0+zJkgT4iBGAvqpVitCjdv7TTSUzo4MN93a3FMmnBo
        kQWZu0JyvgDTgCwVddsmC8EWAQ==
X-Google-Smtp-Source: ABdhPJyjurGv9Lq7dXVCqefkV3eZHt7gPYatEbi29JWj+LdhbdS7AAmtti+5rWfR4063T8UB7XIL/A==
X-Received: by 2002:ad4:5d48:0:b0:456:446e:4595 with SMTP id jk8-20020ad45d48000000b00456446e4595mr6623480qvb.62.1651075257824;
        Wed, 27 Apr 2022 09:00:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a040b00b0069f95b27869sm605867qkp.125.2022.04.27.09.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:00:57 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/5] mm: Kconfig: move swap and slab config options to the MM section
Date:   Wed, 27 Apr 2022 12:00:12 -0400
Message-Id: <20220427160016.144237-2-hannes@cmpxchg.org>
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

