Return-Path: <cgroups+bounces-801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39C804879
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 05:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982652813C7
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 04:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C01CA5F;
	Tue,  5 Dec 2023 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsD07beV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285449C;
	Mon,  4 Dec 2023 20:15:53 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3067638a12.3;
        Mon, 04 Dec 2023 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701749752; x=1702354552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nezVQBT1yQ9zvp+x3Q4cJHMG0UzgLInrLLV8pipEpYA=;
        b=PsD07beVGTEN9hL2IBRFVKkrexKX5WRtsJ7fmaZ6PaRoDt4YxSrHJlwcie1+XoEoBm
         exCAB1cUBYrK/sGZ3zL08Bz5I7exS+VjA9DQ8DbaueDcNEnKo9g/KJIeqktCD1QsxHN5
         38X/ZBe6x5wa6XhO4gT1LeSYJmonc4mAEOPC+ytf1EhBpjMF9AqQgUcEkqA/lPxGU9Wa
         mtt1xNAr57/h3Uq4zF9Ip3xZwDnpfEBq7YO/C/Mp+51TU1Xqui1qZLfqRKC0DqMvqjYh
         eph7Q0LzE8rktpUIhBEWacHEjjHO/Tv0RSGOUfIJzZMG0HLsVX47sgU8+2ZWa9agCTmL
         Ndtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701749752; x=1702354552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nezVQBT1yQ9zvp+x3Q4cJHMG0UzgLInrLLV8pipEpYA=;
        b=PQLnKryXA4x+ptEh0/DqJ3QBmpufnUwWLgAfWUSG8O3deN7+yvJkbaLEl+qrHSVE2G
         4fYR5/wwoCWWBBDI7ni5ccoac75Kvcu8FikznHT41v95dra5cAhWmlOGsWaCfgO3xmj1
         T+tA5n0A0mN+BUXoJixivzcxGn8bsyeb4jCBrhyqXsayQY8wJaiUxdzThqOVAPBmuz4C
         xd4CTtEzHHtt1eEl5905ydEnPbHnARE5Y3buxLbQM9B4qDoiG0xrfFXV1ZksrPrfnP5w
         UzugIAvYf0clpicHTMum/aeU4GN673DVgvhXxRzKjU8dA7nhnmjQMBx4yWMXkftcOByK
         ZEFQ==
X-Gm-Message-State: AOJu0YzOm8JlkQuR5Hj7Q0QwMA3xn7m+/QLSDGbNmSm73x2/mHC7TaPW
	3hJLtusnIOkp46jSm5IG8So=
X-Google-Smtp-Source: AGHT+IFJOpeOn83oTxXlzMwkHi0p68pzFjJa/nGpuyM2t4kS5QVaffXaLUvEJSo6M2IZCE6soI2gVA==
X-Received: by 2002:a17:90a:e654:b0:285:b78a:dbce with SMTP id ep20-20020a17090ae65400b00285b78adbcemr616157pjb.37.1701749752278;
        Mon, 04 Dec 2023 20:15:52 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001d071d58e85sm5371227plr.98.2023.12.04.20.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 20:15:51 -0800 (PST)
Date: Tue, 5 Dec 2023 13:15:37 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
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
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/21] mm/slab: remove CONFIG_SLAB from all Kconfig
 and Makefile
Message-ID: <ZW6j6aTpuJF0keS7@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-2-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120-slab-remove-slab-v2-2-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:13PM +0100, Vlastimil Babka wrote:
> Remove CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_SLAB_DEPRECATED and
> everything in Kconfig files and mm/Makefile that depends on those. Since
> SLUB is the only remaining allocator, remove the allocator choice, make
> CONFIG_SLUB a "def_bool y" for now and remove all explicit dependencies
> on SLUB or SLAB as it's now always enabled. Make every option's verbose
> name and description refer to "the slab allocator" without refering to
> the specific implementation. Do not rename the CONFIG_ option names yet.
> 
> Everything under #ifdef CONFIG_SLAB, and mm/slab.c is now dead code, all
> code under #ifdef CONFIG_SLUB is now always compiled.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  arch/arm64/Kconfig |  2 +-
>  arch/s390/Kconfig  |  2 +-
>  arch/x86/Kconfig   |  2 +-
>  lib/Kconfig.debug  |  1 -
>  lib/Kconfig.kasan  | 11 +++------
>  lib/Kconfig.kfence |  2 +-
>  lib/Kconfig.kmsan  |  2 +-
>  mm/Kconfig         | 68 ++++++++++++------------------------------------------
>  mm/Kconfig.debug   | 16 ++++---------
>  mm/Makefile        |  6 +----
>  10 files changed, 28 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..325b7140b576 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -154,7 +154,7 @@ config ARM64
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
>  	select HAVE_ACPI_APEI if (ACPI && EFI)
> -	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> +	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_BITREVERSE
>  	select HAVE_ARCH_COMPILER_H
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3bec98d20283..afa42a6f2e09 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -146,7 +146,7 @@ config S390
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_VDSO_TIME_NS
>  	select GENERIC_IOREMAP if PCI
> -	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> +	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..3f460f334d4e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -169,7 +169,7 @@ config X86
>  	select HAS_IOPORT
>  	select HAVE_ACPI_APEI			if ACPI
>  	select HAVE_ACPI_APEI_NMI		if ACPI
> -	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
> +	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
>  	select HAVE_ARCH_HUGE_VMALLOC		if X86_64
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cc7d53d9dc01..e1765face106 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1985,7 +1985,6 @@ config FAULT_INJECTION
>  config FAILSLAB
>  	bool "Fault-injection capability for kmalloc"
>  	depends on FAULT_INJECTION
> -	depends on SLAB || SLUB
>  	help
>  	  Provide fault-injection capability for kmalloc.
>  
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdca89c05745..97e1fdbb5910 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -37,7 +37,7 @@ menuconfig KASAN
>  		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
>  		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
>  		   HAVE_ARCH_KASAN_HW_TAGS
> -	depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
> +	depends on SYSFS && !SLUB_TINY
>  	select STACKDEPOT_ALWAYS_INIT
>  	help
>  	  Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
> @@ -78,7 +78,7 @@ config KASAN_GENERIC
>  	bool "Generic KASAN"
>  	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
>  	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> -	select SLUB_DEBUG if SLUB
> +	select SLUB_DEBUG
>  	select CONSTRUCTORS
>  	help
>  	  Enables Generic KASAN.
> @@ -89,13 +89,11 @@ config KASAN_GENERIC
>  	  overhead of ~50% for dynamic allocations.
>  	  The performance slowdown is ~x3.
>  
> -	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
> -
>  config KASAN_SW_TAGS
>  	bool "Software Tag-Based KASAN"
>  	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
>  	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> -	select SLUB_DEBUG if SLUB
> +	select SLUB_DEBUG
>  	select CONSTRUCTORS
>  	help
>  	  Enables Software Tag-Based KASAN.
> @@ -110,12 +108,9 @@ config KASAN_SW_TAGS
>  	  May potentially introduce problems related to pointer casting and
>  	  comparison, as it embeds a tag into the top byte of each pointer.
>  
> -	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
> -
>  config KASAN_HW_TAGS
>  	bool "Hardware Tag-Based KASAN"
>  	depends on HAVE_ARCH_KASAN_HW_TAGS
> -	depends on SLUB
>  	help
>  	  Enables Hardware Tag-Based KASAN.
>  
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> index 459dda9ef619..6fbbebec683a 100644
> --- a/lib/Kconfig.kfence
> +++ b/lib/Kconfig.kfence
> @@ -5,7 +5,7 @@ config HAVE_ARCH_KFENCE
>  
>  menuconfig KFENCE
>  	bool "KFENCE: low-overhead sampling-based memory safety error detector"
> -	depends on HAVE_ARCH_KFENCE && (SLAB || SLUB)
> +	depends on HAVE_ARCH_KFENCE
>  	select STACKTRACE
>  	select IRQ_WORK
>  	help
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index ef2c8f256c57..0541d7b079cc 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -11,7 +11,7 @@ config HAVE_KMSAN_COMPILER
>  config KMSAN
>  	bool "KMSAN: detector of uninitialized values use"
>  	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> -	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +	depends on DEBUG_KERNEL && !KASAN && !KCSAN
>  	depends on !PREEMPT_RT
>  	select STACKDEPOT
>  	select STACKDEPOT_ALWAYS_INIT
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..4636870499bb 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -226,52 +226,17 @@ config ZSMALLOC_CHAIN_SIZE
>  
>  	  For more information, see zsmalloc documentation.
>  
> -menu "SLAB allocator options"
> -
> -choice
> -	prompt "Choose SLAB allocator"
> -	default SLUB
> -	help
> -	   This option allows to select a slab allocator.
> -
> -config SLAB_DEPRECATED
> -	bool "SLAB (DEPRECATED)"
> -	depends on !PREEMPT_RT
> -	help
> -	  Deprecated and scheduled for removal in a few cycles. Replaced by
> -	  SLUB.
> -
> -	  If you cannot migrate to SLUB, please contact linux-mm@kvack.org
> -	  and the people listed in the SLAB ALLOCATOR section of MAINTAINERS
> -	  file, explaining why.
> -
> -	  The regular slab allocator that is established and known to work
> -	  well in all environments. It organizes cache hot objects in
> -	  per cpu and per node queues.
> +menu "Slab allocator options"
>  
>  config SLUB
> -	bool "SLUB (Unqueued Allocator)"
> -	help
> -	   SLUB is a slab allocator that minimizes cache line usage
> -	   instead of managing queues of cached objects (SLAB approach).
> -	   Per cpu caching is realized using slabs of objects instead
> -	   of queues of objects. SLUB can use memory efficiently
> -	   and has enhanced diagnostics. SLUB is the default choice for
> -	   a slab allocator.
> -
> -endchoice
> -
> -config SLAB
> -	bool
> -	default y
> -	depends on SLAB_DEPRECATED
> +	def_bool y
>  
>  config SLUB_TINY
> -	bool "Configure SLUB for minimal memory footprint"
> -	depends on SLUB && EXPERT
> +	bool "Configure for minimal memory footprint"
> +	depends on EXPERT
>  	select SLAB_MERGE_DEFAULT
>  	help
> -	   Configures the SLUB allocator in a way to achieve minimal memory
> +	   Configures the slab allocator in a way to achieve minimal memory
>  	   footprint, sacrificing scalability, debugging and other features.
>  	   This is intended only for the smallest system that had used the
>  	   SLOB allocator and is not recommended for systems with more than
> @@ -282,7 +247,6 @@ config SLUB_TINY
>  config SLAB_MERGE_DEFAULT
>  	bool "Allow slab caches to be merged"
>  	default y
> -	depends on SLAB || SLUB
>  	help
>  	  For reduced kernel memory fragmentation, slab caches can be
>  	  merged when they share the same size and other characteristics.
> @@ -296,7 +260,7 @@ config SLAB_MERGE_DEFAULT
>  
>  config SLAB_FREELIST_RANDOM
>  	bool "Randomize slab freelist"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> +	depends on !SLUB_TINY
>  	help
>  	  Randomizes the freelist order used on creating new pages. This
>  	  security feature reduces the predictability of the kernel slab
> @@ -304,21 +268,19 @@ config SLAB_FREELIST_RANDOM
>  
>  config SLAB_FREELIST_HARDENED
>  	bool "Harden slab freelist metadata"
> -	depends on SLAB || (SLUB && !SLUB_TINY)
> +	depends on !SLUB_TINY
>  	help
>  	  Many kernel heap attacks try to target slab cache metadata and
>  	  other infrastructure. This options makes minor performance
>  	  sacrifices to harden the kernel slab allocator against common
> -	  freelist exploit methods. Some slab implementations have more
> -	  sanity-checking than others. This option is most effective with
> -	  CONFIG_SLUB.
> +	  freelist exploit methods.
>  
>  config SLUB_STATS
>  	default n
> -	bool "Enable SLUB performance statistics"
> -	depends on SLUB && SYSFS && !SLUB_TINY
> +	bool "Enable performance statistics"
> +	depends on SYSFS && !SLUB_TINY
>  	help
> -	  SLUB statistics are useful to debug SLUBs allocation behavior in
> +	  The statistics are useful to debug slab allocation behavior in
>  	  order find ways to optimize the allocator. This should never be
>  	  enabled for production use since keeping statistics slows down
>  	  the allocator by a few percentage points. The slabinfo command
> @@ -328,8 +290,8 @@ config SLUB_STATS
>  
>  config SLUB_CPU_PARTIAL
>  	default y
> -	depends on SLUB && SMP && !SLUB_TINY
> -	bool "SLUB per cpu partial cache"
> +	depends on SMP && !SLUB_TINY
> +	bool "Enable per cpu partial caches"
>  	help
>  	  Per cpu partial caches accelerate objects allocation and freeing
>  	  that is local to a processor at the price of more indeterminism
> @@ -339,7 +301,7 @@ config SLUB_CPU_PARTIAL
>  
>  config RANDOM_KMALLOC_CACHES
>  	default n
> -	depends on SLUB && !SLUB_TINY
> +	depends on !SLUB_TINY
>  	bool "Randomize slab caches for normal kmalloc"
>  	help
>  	  A hardening feature that creates multiple copies of slab caches for
> @@ -354,7 +316,7 @@ config RANDOM_KMALLOC_CACHES
>  	  limited degree of memory and CPU overhead that relates to hardware and
>  	  system workload.
>  
> -endmenu # SLAB allocator options
> +endmenu # Slab allocator options
>  
>  config SHUFFLE_PAGE_ALLOCATOR
>  	bool "Page allocator randomization"
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 018a5bd2f576..321ab379994f 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -45,18 +45,10 @@ config DEBUG_PAGEALLOC_ENABLE_DEFAULT
>  	  Enable debug page memory allocations by default? This value
>  	  can be overridden by debug_pagealloc=off|on.
>  
> -config DEBUG_SLAB
> -	bool "Debug slab memory allocations"
> -	depends on DEBUG_KERNEL && SLAB
> -	help
> -	  Say Y here to have the kernel do limited verification on memory
> -	  allocation as well as poisoning memory on free to catch use of freed
> -	  memory. This can make kmalloc/kfree-intensive workloads much slower.
> -
>  config SLUB_DEBUG
>  	default y
>  	bool "Enable SLUB debugging support" if EXPERT
> -	depends on SLUB && SYSFS && !SLUB_TINY
> +	depends on SYSFS && !SLUB_TINY
>  	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
> @@ -66,7 +58,7 @@ config SLUB_DEBUG
>  
>  config SLUB_DEBUG_ON
>  	bool "SLUB debugging on by default"
> -	depends on SLUB && SLUB_DEBUG
> +	depends on SLUB_DEBUG
>  	select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
>  	default n
>  	help
> @@ -231,8 +223,8 @@ config DEBUG_KMEMLEAK
>  	  allocations. See Documentation/dev-tools/kmemleak.rst for more
>  	  details.
>  
> -	  Enabling DEBUG_SLAB or SLUB_DEBUG may increase the chances
> -	  of finding leaks due to the slab objects poisoning.
> +	  Enabling SLUB_DEBUG may increase the chances of finding leaks
> +	  due to the slab objects poisoning.
>  
>  	  In order to access the kmemleak file, debugfs needs to be
>  	  mounted (usually at /sys/kernel/debug).
> diff --git a/mm/Makefile b/mm/Makefile
> index 33873c8aedb3..e4b5b75aaec9 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -4,7 +4,6 @@
>  #
>  
>  KASAN_SANITIZE_slab_common.o := n
> -KASAN_SANITIZE_slab.o := n
>  KASAN_SANITIZE_slub.o := n
>  KCSAN_SANITIZE_kmemleak.o := n
>  
> @@ -12,7 +11,6 @@ KCSAN_SANITIZE_kmemleak.o := n
>  # the same word but accesses to different bits of that word. Re-enable KCSAN
>  # for these when we have more consensus on what to do about them.
>  KCSAN_SANITIZE_slab_common.o := n
> -KCSAN_SANITIZE_slab.o := n
>  KCSAN_SANITIZE_slub.o := n
>  KCSAN_SANITIZE_page_alloc.o := n
>  # But enable explicit instrumentation for memory barriers.
> @@ -22,7 +20,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
>  # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
>  # free pages, or a task is migrated between nodes.
>  KCOV_INSTRUMENT_slab_common.o := n
> -KCOV_INSTRUMENT_slab.o := n
>  KCOV_INSTRUMENT_slub.o := n
>  KCOV_INSTRUMENT_page_alloc.o := n
>  KCOV_INSTRUMENT_debug-pagealloc.o := n
> @@ -66,6 +63,7 @@ obj-y += page-alloc.o
>  obj-y += init-mm.o
>  obj-y += memblock.o
>  obj-y += $(memory-hotplug-y)
> +obj-y += slub.o
>  
>  ifdef CONFIG_MMU
>  	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
> @@ -82,8 +80,6 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
>  obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>  obj-$(CONFIG_KSM) += ksm.o
>  obj-$(CONFIG_PAGE_POISONING) += page_poison.o
> -obj-$(CONFIG_SLAB) += slab.o
> -obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)	+= kasan/
>  obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_KMSAN)	+= kmsan/

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Nit:

- Some arch configs enables DEBUG_SLAB
- Some documentations refers to {DEBUG_,}SLAB config (i.e. "enable
DEBUG_SLAB for debugging", or "use SLUB instead of SLAB for reducing OS
jitter", ... etc)
- fs/orangefs/orangefs-kernel.h uses #if (defined CONFIG_DEBUG_SLAB)

$ git grep DEBUG_SLAB arch/
arch/arm/configs/ep93xx_defconfig:CONFIG_DEBUG_SLAB=y
arch/arm/configs/tegra_defconfig:CONFIG_DEBUG_SLAB=y
arch/microblaze/configs/mmu_defconfig:CONFIG_DEBUG_SLAB=y

$ git grep SLAB Documentation/

[... some unrelated lines removed ...]

Documentation/admin-guide/cgroup-v1/cpusets.rst:PFA_SPREAD_SLAB, and appropriately marked slab caches will allocate
Documentation/admin-guide/cgroup-v1/memory.rst:  pages allocated by the SLAB or SLUB allocator are tracked. A copy
Documentation/admin-guide/kernel-per-CPU-kthreads.rst:          CONFIG_SLAB=y, thus avoiding the slab allocator's periodic
Documentation/admin-guide/mm/pagemap.rst:   The page is managed by the SLAB/SLUB kernel memory allocator.
Documentation/dev-tools/kasan.rst:For slab, both software KASAN modes support SLUB and SLAB allocators, while
Documentation/dev-tools/kfence.rst:of the sample interval, the next allocation through the main allocator (SLAB or
Documentation/mm/slub.rst:The basic philosophy of SLUB is very different from SLAB. SLAB
Documentation/mm/slub.rst:                      Sorry SLAB legacy issues)
Documentation/process/4.Coding.rst: - DEBUG_SLAB can find a variety of memory allocation and use errors; it
Documentation/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
Documentation/scsi/ChangeLog.lpfc:        CONFIG_DEBUG_SLAB set).
Documentation/translations/it_IT/process/4.Coding.rst: - DEBUG_SLAB può trovare svariati errori di uso e di allocazione di memoria;
Documentation/translations/it_IT/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
Documentation/translations/ja_JP/SubmitChecklist:12: CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_SLAB,
Documentation/translations/zh_CN/dev-tools/kasan.rst:对于slab，两种软件KASAN模式都支持SLUB和SLAB分配器，而基于硬件标签的
Documentation/translations/zh_CN/process/4.Coding.rst: - DEBUG_SLAB 可以发现各种内存分配和使用错误；它应该用于大多数开发内核。
Documentation/translations/zh_CN/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
Documentation/translations/zh_TW/dev-tools/kasan.rst:對於slab，兩種軟件KASAN模式都支持SLUB和SLAB分配器，而基於硬件標籤的
Documentation/translations/zh_TW/process/4.Coding.rst: - DEBUG_SLAB 可以發現各種內存分配和使用錯誤；它應該用於大多數開發內核。
Documentation/translations/zh_TW/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,

--
Hyeonggon

