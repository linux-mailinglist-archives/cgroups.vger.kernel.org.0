Return-Path: <cgroups+bounces-357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F947EA37D
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C517280EE0
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA723752;
	Mon, 13 Nov 2023 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTbJBIIj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2liS3K9/"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D023749
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407110DA;
	Mon, 13 Nov 2023 11:14:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A677921904;
	Mon, 13 Nov 2023 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw22R2OI/p+Rv0u9/1hTmEaVhxoSehReW5KEOinDjTY=;
	b=fTbJBIIjJBNq3tw9IKU6IGbA/TamjC6kxodMkDwTVmxweeQgrEJXd8bqp2ilrMKFNmK8fp
	IdNFdf1BqCZQsBc8/U5K5U5Jqm6HVtL/XPyzIvWYC02+7G36WXE/iYqTbZ4oxEP7yDAQTc
	zaaGnTYy/ue/YQm8Ku5ek/zTsnezt2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw22R2OI/p+Rv0u9/1hTmEaVhxoSehReW5KEOinDjTY=;
	b=2liS3K9/OxRG7jqKvzxKzKrcD/ZjmQfQVNjeHi4lZ61Sa1hjW8sX2H4W8gd0OXNWOpVCQ/
	86s2Zl/pbMX1RxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B3A13907;
	Mon, 13 Nov 2023 19:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aLOEFIF1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 01/20] mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
Date: Mon, 13 Nov 2023 20:13:42 +0100
Message-ID: <20231113191340.17482-23-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_SLAB_DEPRECATED and
everything in Kconfig files and mm/Makefile that depends on those. Since
SLUB is the only remaining allocator, remove the allocator choice, make
CONFIG_SLUB a "def_bool y" for now and remove all explicit dependencies
on SLUB as it's now always enabled.

Everything under #ifdef CONFIG_SLAB, and mm/slab.c is now dead code, all
code under #ifdef CONFIG_SLUB is now always compiled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arm64/Kconfig |  2 +-
 arch/s390/Kconfig  |  2 +-
 arch/x86/Kconfig   |  2 +-
 lib/Kconfig.debug  |  1 -
 lib/Kconfig.kasan  | 11 +++-------
 lib/Kconfig.kfence |  2 +-
 lib/Kconfig.kmsan  |  2 +-
 mm/Kconfig         | 50 +++++++---------------------------------------
 mm/Kconfig.debug   | 16 ++++-----------
 mm/Makefile        |  6 +-----
 10 files changed, 20 insertions(+), 74 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..325b7140b576 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,7 +154,7 @@ config ARM64
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
-	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3bec98d20283..afa42a6f2e09 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -146,7 +146,7 @@ config S390
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
-	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..3f460f334d4e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -169,7 +169,7 @@ config X86
 	select HAS_IOPORT
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
-	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_HUGE_VMALLOC		if X86_64
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..e1765face106 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1985,7 +1985,6 @@ config FAULT_INJECTION
 config FAILSLAB
 	bool "Fault-injection capability for kmalloc"
 	depends on FAULT_INJECTION
-	depends on SLAB || SLUB
 	help
 	  Provide fault-injection capability for kmalloc.
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..97e1fdbb5910 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -37,7 +37,7 @@ menuconfig KASAN
 		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
 		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
 		   HAVE_ARCH_KASAN_HW_TAGS
-	depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
+	depends on SYSFS && !SLUB_TINY
 	select STACKDEPOT_ALWAYS_INIT
 	help
 	  Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
@@ -78,7 +78,7 @@ config KASAN_GENERIC
 	bool "Generic KASAN"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	select SLUB_DEBUG if SLUB
+	select SLUB_DEBUG
 	select CONSTRUCTORS
 	help
 	  Enables Generic KASAN.
@@ -89,13 +89,11 @@ config KASAN_GENERIC
 	  overhead of ~50% for dynamic allocations.
 	  The performance slowdown is ~x3.
 
-	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
-
 config KASAN_SW_TAGS
 	bool "Software Tag-Based KASAN"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	select SLUB_DEBUG if SLUB
+	select SLUB_DEBUG
 	select CONSTRUCTORS
 	help
 	  Enables Software Tag-Based KASAN.
@@ -110,12 +108,9 @@ config KASAN_SW_TAGS
 	  May potentially introduce problems related to pointer casting and
 	  comparison, as it embeds a tag into the top byte of each pointer.
 
-	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
-
 config KASAN_HW_TAGS
 	bool "Hardware Tag-Based KASAN"
 	depends on HAVE_ARCH_KASAN_HW_TAGS
-	depends on SLUB
 	help
 	  Enables Hardware Tag-Based KASAN.
 
diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 459dda9ef619..6fbbebec683a 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -5,7 +5,7 @@ config HAVE_ARCH_KFENCE
 
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
-	depends on HAVE_ARCH_KFENCE && (SLAB || SLUB)
+	depends on HAVE_ARCH_KFENCE
 	select STACKTRACE
 	select IRQ_WORK
 	help
diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index ef2c8f256c57..0541d7b079cc 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -11,7 +11,7 @@ config HAVE_KMSAN_COMPILER
 config KMSAN
 	bool "KMSAN: detector of uninitialized values use"
 	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
-	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
+	depends on DEBUG_KERNEL && !KASAN && !KCSAN
 	depends on !PREEMPT_RT
 	select STACKDEPOT
 	select STACKDEPOT_ALWAYS_INIT
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..766aa8f8e553 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -228,47 +228,12 @@ config ZSMALLOC_CHAIN_SIZE
 
 menu "SLAB allocator options"
 
-choice
-	prompt "Choose SLAB allocator"
-	default SLUB
-	help
-	   This option allows to select a slab allocator.
-
-config SLAB_DEPRECATED
-	bool "SLAB (DEPRECATED)"
-	depends on !PREEMPT_RT
-	help
-	  Deprecated and scheduled for removal in a few cycles. Replaced by
-	  SLUB.
-
-	  If you cannot migrate to SLUB, please contact linux-mm@kvack.org
-	  and the people listed in the SLAB ALLOCATOR section of MAINTAINERS
-	  file, explaining why.
-
-	  The regular slab allocator that is established and known to work
-	  well in all environments. It organizes cache hot objects in
-	  per cpu and per node queues.
-
 config SLUB
-	bool "SLUB (Unqueued Allocator)"
-	help
-	   SLUB is a slab allocator that minimizes cache line usage
-	   instead of managing queues of cached objects (SLAB approach).
-	   Per cpu caching is realized using slabs of objects instead
-	   of queues of objects. SLUB can use memory efficiently
-	   and has enhanced diagnostics. SLUB is the default choice for
-	   a slab allocator.
-
-endchoice
-
-config SLAB
-	bool
-	default y
-	depends on SLAB_DEPRECATED
+	def_bool y
 
 config SLUB_TINY
 	bool "Configure SLUB for minimal memory footprint"
-	depends on SLUB && EXPERT
+	depends on EXPERT
 	select SLAB_MERGE_DEFAULT
 	help
 	   Configures the SLUB allocator in a way to achieve minimal memory
@@ -282,7 +247,6 @@ config SLUB_TINY
 config SLAB_MERGE_DEFAULT
 	bool "Allow slab caches to be merged"
 	default y
-	depends on SLAB || SLUB
 	help
 	  For reduced kernel memory fragmentation, slab caches can be
 	  merged when they share the same size and other characteristics.
@@ -296,7 +260,7 @@ config SLAB_MERGE_DEFAULT
 
 config SLAB_FREELIST_RANDOM
 	bool "Randomize slab freelist"
-	depends on SLAB || (SLUB && !SLUB_TINY)
+	depends on !SLUB_TINY
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
@@ -304,7 +268,7 @@ config SLAB_FREELIST_RANDOM
 
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
-	depends on SLAB || (SLUB && !SLUB_TINY)
+	depends on !SLUB_TINY
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
@@ -316,7 +280,7 @@ config SLAB_FREELIST_HARDENED
 config SLUB_STATS
 	default n
 	bool "Enable SLUB performance statistics"
-	depends on SLUB && SYSFS && !SLUB_TINY
+	depends on SYSFS && !SLUB_TINY
 	help
 	  SLUB statistics are useful to debug SLUBs allocation behavior in
 	  order find ways to optimize the allocator. This should never be
@@ -328,7 +292,7 @@ config SLUB_STATS
 
 config SLUB_CPU_PARTIAL
 	default y
-	depends on SLUB && SMP && !SLUB_TINY
+	depends on SMP && !SLUB_TINY
 	bool "SLUB per cpu partial cache"
 	help
 	  Per cpu partial caches accelerate objects allocation and freeing
@@ -339,7 +303,7 @@ config SLUB_CPU_PARTIAL
 
 config RANDOM_KMALLOC_CACHES
 	default n
-	depends on SLUB && !SLUB_TINY
+	depends on !SLUB_TINY
 	bool "Randomize slab caches for normal kmalloc"
 	help
 	  A hardening feature that creates multiple copies of slab caches for
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 018a5bd2f576..321ab379994f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -45,18 +45,10 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
 	  Enable debug page memory allocations by default? This value
 	  can be overridden by debug_pagealloc=off|on.
 
-config DEBUG_SLAB
-	bool "Debug slab memory allocations"
-	depends on DEBUG_KERNEL && SLAB
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory. This can make kmalloc/kfree-intensive workloads much slower.
-
 config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
-	depends on SLUB && SYSFS && !SLUB_TINY
+	depends on SYSFS && !SLUB_TINY
 	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
@@ -66,7 +58,7 @@ config SLUB_DEBUG
 
 config SLUB_DEBUG_ON
 	bool "SLUB debugging on by default"
-	depends on SLUB && SLUB_DEBUG
+	depends on SLUB_DEBUG
 	select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
 	default n
 	help
@@ -231,8 +223,8 @@ config DEBUG_KMEMLEAK
 	  allocations. See Documentation/dev-tools/kmemleak.rst for more
 	  details.
 
-	  Enabling DEBUG_SLAB or SLUB_DEBUG may increase the chances
-	  of finding leaks due to the slab objects poisoning.
+	  Enabling SLUB_DEBUG may increase the chances of finding leaks
+	  due to the slab objects poisoning.
 
 	  In order to access the kmemleak file, debugfs needs to be
 	  mounted (usually at /sys/kernel/debug).
diff --git a/mm/Makefile b/mm/Makefile
index 33873c8aedb3..e4b5b75aaec9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -4,7 +4,6 @@
 #
 
 KASAN_SANITIZE_slab_common.o := n
-KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_kmemleak.o := n
 
@@ -12,7 +11,6 @@ KCSAN_SANITIZE_kmemleak.o := n
 # the same word but accesses to different bits of that word. Re-enable KCSAN
 # for these when we have more consensus on what to do about them.
 KCSAN_SANITIZE_slab_common.o := n
-KCSAN_SANITIZE_slab.o := n
 KCSAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_page_alloc.o := n
 # But enable explicit instrumentation for memory barriers.
@@ -22,7 +20,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
 KCOV_INSTRUMENT_slab_common.o := n
-KCOV_INSTRUMENT_slab.o := n
 KCOV_INSTRUMENT_slub.o := n
 KCOV_INSTRUMENT_page_alloc.o := n
 KCOV_INSTRUMENT_debug-pagealloc.o := n
@@ -66,6 +63,7 @@ obj-y += page-alloc.o
 obj-y += init-mm.o
 obj-y += memblock.o
 obj-y += $(memory-hotplug-y)
+obj-y += slub.o
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
@@ -82,8 +80,6 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
-obj-$(CONFIG_SLAB) += slab.o
-obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
-- 
2.42.1


