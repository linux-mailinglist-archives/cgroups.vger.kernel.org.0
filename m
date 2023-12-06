Return-Path: <cgroups+bounces-856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B17806AA0
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FC51C20998
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B111A71F;
	Wed,  6 Dec 2023 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ztODoN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E8D6F;
	Wed,  6 Dec 2023 01:06:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so12177675ad.1;
        Wed, 06 Dec 2023 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701853560; x=1702458360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2GGM7bFYDaqOGYAduet1T5T8Hq7xfXB9hdrnTRRI+g=;
        b=D1ztODoNlmQ8z2SKbAcMumGRYqolHYwt6rkwD/Hzj+kSPAKXdnTCMtNLzhQEGVUoFU
         Jjt4kB8+DF6NHo3s95AXysLSqm3txd2wBdtnai81XaCORotTE9CFRXYyBJ593HD6jGqv
         Rln58z4Cg21bXIOJZlTvH52ZAa/KEuZ7yOdY8IgS/TYLkXxOkfii+o4ki735d4WhdAFa
         sVMmB0msQ8blv0hvDxChcUPU1zy+Z/nMrPv6Vu20bxZmlh6AySL8RABTeG9eXS8Xqhr7
         nxz/gwmk6izvLkbDtlx9mw8IyU/sRL2f1n0fnPwgblPCwQg5Tj2MGyBRZ5Q73z59+8yh
         KJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853560; x=1702458360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2GGM7bFYDaqOGYAduet1T5T8Hq7xfXB9hdrnTRRI+g=;
        b=SQGx5OBr4Nb3NV/w+bp3FsceN8wmfoMCvuEPlwKN1/ttsRL6WLG4vA4SjICIU297RV
         aydGRIKauj75+eVqtRltd839GmWIozkF8JMgv1xvjl3g4jcjQhkgC1Cu2W6aJlk6iM3/
         97n5TP+rgMdMtJkytFzL83UQG7vZPziLo5tzt+oOs+NHeVSIrpngpCmB3Kf5sEf1qakG
         0R09y+9QDTVi1gwyCqYg7Ur7AzRHqVPGPKIm175pfZWEaMuIJrjrzI5E/vxLOCaOiBlH
         beHrNVlKDU0B36Y7RLJNt2uQC9ey3nVKE5c5eS1zTwH32ytmmTyjEScv7iAFAVd+BjsX
         iWIw==
X-Gm-Message-State: AOJu0YwERtPg5gO2t1Rx51ytQu41bkYxvZVfAtLdvGrrTaZW15R8WIiy
	uL3Z8CbxE16mqtaqfFgjAdo=
X-Google-Smtp-Source: AGHT+IGlm0cH3TcZXGOz3igm65NbMoGXdSSMbu1dGUW4XgsvgeSILUX2r8JpcMUhu/z4L0agyq4hfw==
X-Received: by 2002:a17:902:c411:b0:1d0:6ffd:f1f8 with SMTP id k17-20020a170902c41100b001d06ffdf1f8mr465248plk.78.1701853559768;
        Wed, 06 Dec 2023 01:05:59 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b001c74df14e6fsm11559003pll.284.2023.12.06.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:05:58 -0800 (PST)
Date: Wed, 6 Dec 2023 18:05:38 +0900
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
Subject: Re: [PATCH v2 07/21] mm/slab: remove CONFIG_SLAB code from slab
 common code
Message-ID: <ZXA5YqZGAfNUQiIC@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-7-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-7-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:18PM +0100, Vlastimil Babka wrote:
> In slab_common.c and slab.h headers, we can now remove all code behind
> CONFIG_SLAB and CONFIG_DEBUG_SLAB ifdefs, and remove all CONFIG_SLUB
> ifdefs.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 14 ++---------
>  mm/slab.h            | 69 ++++------------------------------------------------
>  mm/slab_common.c     | 22 ++---------------
>  3 files changed, 9 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 34e43cddc520..b2015d0e01ad 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -24,7 +24,7 @@
>  
>  /*
>   * Flags to pass to kmem_cache_create().
> - * The ones marked DEBUG are only valid if CONFIG_DEBUG_SLAB is set.
> + * The ones marked DEBUG need CONFIG_SLUB_DEBUG enabled, otherwise are no-op
>   */
>  /* DEBUG: Perform (expensive) checks on alloc/free */
>  #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
> @@ -302,25 +302,15 @@ static inline unsigned int arch_slab_minalign(void)
>   * Kmalloc array related definitions
>   */
>  
> -#ifdef CONFIG_SLAB
>  /*
> - * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> + * SLUB directly allocates requests fitting in to an order-1 page
>   * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
>   */
>  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
>  #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
>  #ifndef KMALLOC_SHIFT_LOW
> -#define KMALLOC_SHIFT_LOW	5
> -#endif
> -#endif
> -
> -#ifdef CONFIG_SLUB
> -#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
> -#ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	3
>  #endif
> -#endif
>  
>  /* Maximum allocatable size */
>  #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)
> diff --git a/mm/slab.h b/mm/slab.h
> index 3d07fb428393..014c36ea51fa 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -42,21 +42,6 @@ typedef union {
>  struct slab {
>  	unsigned long __page_flags;
>  
> -#if defined(CONFIG_SLAB)
> -
> -	struct kmem_cache *slab_cache;
> -	union {
> -		struct {
> -			struct list_head slab_list;
> -			void *freelist;	/* array of free object indexes */
> -			void *s_mem;	/* first object */
> -		};
> -		struct rcu_head rcu_head;
> -	};
> -	unsigned int active;
> -
> -#elif defined(CONFIG_SLUB)
> -
>  	struct kmem_cache *slab_cache;
>  	union {
>  		struct {
> @@ -91,10 +76,6 @@ struct slab {
>  	};
>  	unsigned int __unused;
>  
> -#else
> -#error "Unexpected slab allocator configured"
> -#endif
> -
>  	atomic_t __page_refcount;
>  #ifdef CONFIG_MEMCG
>  	unsigned long memcg_data;
> @@ -111,7 +92,7 @@ SLAB_MATCH(memcg_data, memcg_data);
>  #endif
>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));
> -#if defined(system_has_freelist_aba) && defined(CONFIG_SLUB)
> +#if defined(system_has_freelist_aba)
>  static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)));
>  #endif
>  
> @@ -228,13 +209,7 @@ static inline size_t slab_size(const struct slab *slab)
>  	return PAGE_SIZE << slab_order(slab);
>  }
>  
> -#ifdef CONFIG_SLAB
> -#include <linux/slab_def.h>
> -#endif
> -
> -#ifdef CONFIG_SLUB
>  #include <linux/slub_def.h>
> -#endif
>  
>  #include <linux/memcontrol.h>
>  #include <linux/fault-inject.h>
> @@ -320,26 +295,16 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
>  
> -#if defined(CONFIG_DEBUG_SLAB)
> -#define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> -#elif defined(CONFIG_SLUB_DEBUG)
> +#ifdef CONFIG_SLUB_DEBUG
>  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
>  #else
>  #define SLAB_DEBUG_FLAGS (0)
>  #endif
>  
> -#if defined(CONFIG_SLAB)
> -#define SLAB_CACHE_FLAGS (SLAB_MEM_SPREAD | SLAB_NOLEAKTRACE | \
> -			  SLAB_RECLAIM_ACCOUNT | SLAB_TEMPORARY | \
> -			  SLAB_ACCOUNT | SLAB_NO_MERGE)
> -#elif defined(CONFIG_SLUB)
>  #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
>  			  SLAB_TEMPORARY | SLAB_ACCOUNT | \
>  			  SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
> -#else
> -#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
> -#endif
>  
>  /* Common flags available with current configuration */
>  #define CACHE_CREATE_MASK (SLAB_CORE_FLAGS | SLAB_DEBUG_FLAGS | SLAB_CACHE_FLAGS)
> @@ -672,18 +637,14 @@ size_t __ksize(const void *objp);
>  
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
> -#ifndef CONFIG_SLUB
> -	return s->object_size;
> -
> -#else /* CONFIG_SLUB */
> -# ifdef CONFIG_SLUB_DEBUG
> +#ifdef CONFIG_SLUB_DEBUG
>  	/*
>  	 * Debugging requires use of the padding between object
>  	 * and whatever may come after it.
>  	 */
>  	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
>  		return s->object_size;
> -# endif
> +#endif
>  	if (s->flags & SLAB_KASAN)
>  		return s->object_size;
>  	/*
> @@ -697,7 +658,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
>  	 * Else we can use all the padding etc for the allocation
>  	 */
>  	return s->size;
> -#endif
>  }
>  
>  static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> @@ -775,23 +735,6 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>   * The slab lists for all objects.
>   */
>  struct kmem_cache_node {
> -#ifdef CONFIG_SLAB
> -	raw_spinlock_t list_lock;
> -	struct list_head slabs_partial;	/* partial list first, better asm code */
> -	struct list_head slabs_full;
> -	struct list_head slabs_free;
> -	unsigned long total_slabs;	/* length of all slab lists */
> -	unsigned long free_slabs;	/* length of free slab list only */
> -	unsigned long free_objects;
> -	unsigned int free_limit;
> -	unsigned int colour_next;	/* Per-node cache coloring */
> -	struct array_cache *shared;	/* shared per node */
> -	struct alien_cache **alien;	/* on other nodes */
> -	unsigned long next_reap;	/* updated without locking */
> -	int free_touched;		/* updated without locking */
> -#endif
> -
> -#ifdef CONFIG_SLUB
>  	spinlock_t list_lock;
>  	unsigned long nr_partial;
>  	struct list_head partial;
> @@ -800,8 +743,6 @@ struct kmem_cache_node {
>  	atomic_long_t total_objects;
>  	struct list_head full;
>  #endif
> -#endif
> -
>  };
>  
>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> @@ -818,7 +759,7 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>  		 if ((__n = get_node(__s, __node)))
>  
>  
> -#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
> +#ifdef CONFIG_SLUB_DEBUG
>  void dump_unreclaimable_slab(void);
>  #else
>  static inline void dump_unreclaimable_slab(void)
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8d431193c273..63b8411db7ce 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -71,10 +71,8 @@ static int __init setup_slab_merge(char *str)
>  	return 1;
>  }
>  
> -#ifdef CONFIG_SLUB
>  __setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
>  __setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
> -#endif
>  
>  __setup("slab_nomerge", setup_slab_nomerge);
>  __setup("slab_merge", setup_slab_merge);
> @@ -197,10 +195,6 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  		if (s->size - size >= sizeof(void *))
>  			continue;
>  
> -		if (IS_ENABLED(CONFIG_SLAB) && align &&
> -			(align > s->align || s->align % align))
> -			continue;
> -
>  		return s;
>  	}
>  	return NULL;
> @@ -1222,12 +1216,8 @@ void cache_random_seq_destroy(struct kmem_cache *cachep)
>  }
>  #endif /* CONFIG_SLAB_FREELIST_RANDOM */
>  
> -#if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
> -#ifdef CONFIG_SLAB
> -#define SLABINFO_RIGHTS (0600)
> -#else
> +#ifdef CONFIG_SLUB_DEBUG
>  #define SLABINFO_RIGHTS (0400)
> -#endif
>  
>  static void print_slabinfo_header(struct seq_file *m)
>  {
> @@ -1235,18 +1225,10 @@ static void print_slabinfo_header(struct seq_file *m)
>  	 * Output format version, so at least we can change it
>  	 * without _too_ many complaints.
>  	 */
> -#ifdef CONFIG_DEBUG_SLAB
> -	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
> -#else
>  	seq_puts(m, "slabinfo - version: 2.1\n");
> -#endif
>  	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
>  	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
> -#ifdef CONFIG_DEBUG_SLAB
> -	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
> -	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
> -#endif
>  	seq_putc(m, '\n');
>  }
>  
> @@ -1370,7 +1352,7 @@ static int __init slab_proc_init(void)
>  }
>  module_init(slab_proc_init);
>  
> -#endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
> +#endif /* CONFIG_SLUB_DEBUG */
>  
>  static __always_inline __realloc_size(2) void *
>  __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> 
> -- 

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.42.1
> 
> 

