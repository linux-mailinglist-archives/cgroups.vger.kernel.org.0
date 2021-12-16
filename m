Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC7477537
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhLPPAx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 10:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbhLPPAw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 10:00:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B8C061574
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 07:00:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so14445131pgg.3
        for <cgroups@vger.kernel.org>; Thu, 16 Dec 2021 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aFEGyGgxYBEzyXnobj/2Sxx3wLs42RPScuyGczznaE=;
        b=T999Vkevoa38oqZPTLBrpmgtSuLYoBQnQBfPvX+c4CwuqseREd0cAznoHlU74KLg+B
         bo8Emwxa35xed6ntMp5QB0jIVplxeZ9cuSolAUXsw/TU+rfPz30xajq1ZMOnnJ5+vlTa
         t0pfCmOEX70NUxYYOP0sbf/mHsbLoTbdYCn01tO43pQt4TaxZR5BT0z5IZ2wt2BuLzxx
         5qaLwKIy2AEwb+22mPHih0AJ5jJRgx2LpJBNjwQePqqFYMCnz83HYzrSWWXYARXrDKml
         1VX77VGZjpjv722QUJc8ppPgFXnXmeDwB18B2Dp0NYjEHV6aI10lyXWgSyAV9LLBW73+
         Mf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aFEGyGgxYBEzyXnobj/2Sxx3wLs42RPScuyGczznaE=;
        b=qWwTtwmiYP24ykJq8D8WEaHtR/sZ/q62x9zneNDmtxtrPVQHnRydK3PcS89Jnhw5ny
         0caGugB7NFIcyHKdfqvOfW2kgf9fhvygNLpwIIizHz6O0FqSIFb4tKz/qp2mh9vo4lOI
         0M/ezBppYsW+0xSTVTFXAl3caHe/iwNqFPjSG4VWAiGug5ZKjWx2d0MF/uZcC+ShVLGE
         mJv6JqlUl2ggLJ0lvNP3RbmkDcZpxjWxbTPOcw84zmXU4pmlxtuCqKW7HWS2R5MrK/o1
         hjPxbA2tT24rMyHYK2FPvR33sURSr0TBh3Nz/EuHkH2nsjhnx60JrLGhlDXKRM1HM72V
         LUIA==
X-Gm-Message-State: AOAM533RCB1HavGM7oQAXSG/F+WwfhRi9tm7UWjzzK5NRNDgliREP35I
        R0F31x5o8RBpaQjz3ppHzfw=
X-Google-Smtp-Source: ABdhPJyNUGmqP8h/Vh2hTTSHFLuow295xI+DxruWgyp7bydcuwiFrRFILkqZ39eUuRt0lI4jjJ2rtA==
X-Received: by 2002:a05:6a00:2408:b0:4a8:45ef:c960 with SMTP id z8-20020a056a00240800b004a845efc960mr14027027pfh.53.1639666851848;
        Thu, 16 Dec 2021 07:00:51 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id x37sm6586180pfh.116.2021.12.16.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:00:51 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:00:42 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, cgroups@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        kasan-dev@googlegroups.com, Lu Baolu <baolu.lu@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> On 12/1/21 19:14, Vlastimil Babka wrote:
> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> > this cover letter.
> > 
> > Series also available in git, based on 5.16-rc3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> 
> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:

Reviewing the whole patch series takes longer than I thought.
I'll try to review and test rest of patches when I have time.

I added Tested-by if kernel builds okay and kselftests
does not break the kernel on my machine.
(with CONFIG_SLAB/SLUB/SLOB depending on the patch),
Let me know me if you know better way to test a patch.

# mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Comment:
Works on both SLUB_CPU_PARTIAL and !SLUB_CPU_PARTIAL.
btw, do we need slabs_cpu_partial attribute when we don't use
cpu partials? (!SLUB_CPU_PARTIAL)

# mm/slub: Simplify struct slab slabs field definition
Comment:

This is how struct page looks on the top of v3r3 branch:
struct page {
[...]
                struct {        /* slab, slob and slub */
                        union {
                                struct list_head slab_list;
                                struct {        /* Partial pages */
                                        struct page *next;
#ifdef CONFIG_64BIT
                                        int pages;      /* Nr of pages left */
#else
                                        short int pages;
#endif
                                };
                        };
[...]

It's not consistent with struct slab.
I think this is because "mm: Remove slab from struct page" was dropped.
Would you update some of patches?

# mm/sl*b: Differentiate struct slab fields by sl*b implementations
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Works SL[AUO]B on my machine and makes code much better.

# mm/slob: Convert SLOB to use struct slab and struct folio
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
It still works fine on SLOB.

# mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

# mm/slub: Convert __free_slab() to use struct slab
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks,
Hyeonggon.

> 
>  1:  10b656f9eb1e =  1:  10b656f9eb1e mm: add virt_to_folio() and folio_address()
>  2:  5e6ad846acf1 =  2:  5e6ad846acf1 mm/slab: Dissolve slab_map_pages() in its caller
>  3:  48d4e9407aa0 =  3:  48d4e9407aa0 mm/slub: Make object_err() static
>  4:  fe1e19081321 =  4:  fe1e19081321 mm: Split slab into its own type
>  5:  af7fd46fbb9b =  5:  af7fd46fbb9b mm: Add account_slab() and unaccount_slab()
>  6:  7ed088d601d9 =  6:  7ed088d601d9 mm: Convert virt_to_cache() to use struct slab
>  7:  1d41188b9401 =  7:  1d41188b9401 mm: Convert __ksize() to struct slab
>  8:  5d9d1231461f !  8:  8fd22e0b086e mm: Use struct slab in kmem_obj_info()
>     @@ Commit message
>          slab type instead of the page type, we make it obvious that this can
>          only be called for slabs.
>      
>     +    [ vbabka@suse.cz: also convert the related kmem_valid_obj() to folios ]
>     +
>          Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>      
>     @@ mm/slab.h: struct kmem_obj_info {
>       #endif /* MM_SLAB_H */
>      
>       ## mm/slab_common.c ##
>     +@@ mm/slab_common.c: bool slab_is_available(void)
>     +  */
>     + bool kmem_valid_obj(void *object)
>     + {
>     +-	struct page *page;
>     ++	struct folio *folio;
>     + 
>     + 	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
>     + 	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
>     + 		return false;
>     +-	page = virt_to_head_page(object);
>     +-	return PageSlab(page);
>     ++	folio = virt_to_folio(object);
>     ++	return folio_test_slab(folio);
>     + }
>     + EXPORT_SYMBOL_GPL(kmem_valid_obj);
>     + 
>      @@ mm/slab_common.c: void kmem_dump_obj(void *object)
>       {
>       	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
>     @@ mm/slub.c: int __kmem_cache_shutdown(struct kmem_cache *s)
>       	objp = base + s->size * objnr;
>       	kpp->kp_objp = objp;
>      -	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
>     -+	if (WARN_ON_ONCE(objp < base || objp >= base + slab->objects * s->size || (objp - base) % s->size) ||
>     ++	if (WARN_ON_ONCE(objp < base || objp >= base + slab->objects * s->size
>     ++			 || (objp - base) % s->size) ||
>       	    !(s->flags & SLAB_STORE_USER))
>       		return;
>       #ifdef CONFIG_SLUB_DEBUG
>  9:  3aef771be335 !  9:  c97e73c3b6c2 mm: Convert check_heap_object() to use struct slab
>     @@ mm/slab.h: struct kmem_obj_info {
>      +#else
>      +static inline
>      +void __check_heap_object(const void *ptr, unsigned long n,
>     -+			 const struct slab *slab, bool to_user) { }
>     ++			 const struct slab *slab, bool to_user)
>     ++{
>     ++}
>      +#endif
>      +
>       #endif /* MM_SLAB_H */
> 10:  2253e45e6bef = 10:  da05e0f7179c mm/slub: Convert detached_freelist to use a struct slab
> 11:  f28202bc27ba = 11:  383887e77104 mm/slub: Convert kfree() to use a struct slab
> 12:  31b58b1e914f = 12:  c46be093c637 mm/slub: Convert __slab_lock() and __slab_unlock() to struct slab
> 13:  636406a3ad59 = 13:  49dbbf917052 mm/slub: Convert print_page_info() to print_slab_info()
> 14:  3b49efda3b6f = 14:  4bb0c932156a mm/slub: Convert alloc_slab_page() to return a struct slab
> 15:  61a195526d3b ! 15:  4b9761b5cfab mm/slub: Convert __free_slab() to use struct slab
>     @@ mm/slub.c: static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int n
>       
>      -	__ClearPageSlabPfmemalloc(page);
>      -	__ClearPageSlab(page);
>     +-	/* In union with page->mapping where page allocator expects NULL */
>     +-	page->slab_cache = NULL;
>      +	__slab_clear_pfmemalloc(slab);
>      +	__folio_clear_slab(folio);
>     - 	/* In union with page->mapping where page allocator expects NULL */
>     --	page->slab_cache = NULL;
>     -+	slab->slab_cache = NULL;
>     ++	folio->mapping = NULL;
>       	if (current->reclaim_state)
>       		current->reclaim_state->reclaimed_slab += pages;
>      -	unaccount_slab(page_slab(page), order, s);
> 16:  987c7ed31580 = 16:  f384ec918065 mm/slub: Convert pfmemalloc_match() to take a struct slab
> 17:  cc742564237e ! 17:  06738ade4e17 mm/slub: Convert most struct page to struct slab by spatch
>     @@ Commit message
>      
>          // Options: --include-headers --no-includes --smpl-spacing include/linux/slub_def.h mm/slub.c
>          // Note: needs coccinelle 1.1.1 to avoid breaking whitespace, and ocaml for the
>     -    // embedded script script
>     +    // embedded script
>      
>          // build list of functions to exclude from applying the next rule
>          @initialize:ocaml@
> 18:  b45acac9aace = 18:  1a4f69a4cced mm/slub: Finish struct page to struct slab conversion
> 19:  76c3eeb39684 ! 19:  1d62d706e884 mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
>     @@ mm/slab.c: slab_out_of_memory(struct kmem_cache *cachep, gfp_t gfpflags, int nod
>      -	__ClearPageSlabPfmemalloc(page);
>      -	__ClearPageSlab(page);
>      -	page_mapcount_reset(page);
>     +-	/* In union with page->mapping where page allocator expects NULL */
>     +-	page->slab_cache = NULL;
>      +	BUG_ON(!folio_test_slab(folio));
>      +	__slab_clear_pfmemalloc(slab);
>      +	__folio_clear_slab(folio);
>      +	page_mapcount_reset(folio_page(folio, 0));
>     - 	/* In union with page->mapping where page allocator expects NULL */
>     --	page->slab_cache = NULL;
>     -+	slab->slab_cache = NULL;
>     ++	folio->mapping = NULL;
>       
>       	if (current->reclaim_state)
>       		current->reclaim_state->reclaimed_slab += 1 << order;
> 20:  ed6144dbebce ! 20:  fd4c3aabacd3 mm/slab: Convert most struct page to struct slab by spatch
>     @@ Commit message
>      
>          // Options: --include-headers --no-includes --smpl-spacing mm/slab.c
>          // Note: needs coccinelle 1.1.1 to avoid breaking whitespace, and ocaml for the
>     -    // embedded script script
>     +    // embedded script
>      
>          // build list of functions for applying the next rule
>          @initialize:ocaml@
> 21:  17fb81e601e6 = 21:  b59720b2edba mm/slab: Finish struct page to struct slab conversion
> 22:  4e8d1faebc24 ! 22:  65ced071c3e7 mm: Convert struct page to struct slab in functions used by other subsystems
>     @@ Commit message
>            ,...)
>      
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>     +    Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>          Cc: Julia Lawall <julia.lawall@inria.fr>
>          Cc: Luis Chamberlain <mcgrof@kernel.org>
>          Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> 23:  eefa12e18a92 = 23:  c9c8dee01e5d mm/memcg: Convert slab objcgs from struct page to struct slab
> 24:  fa5ba4107ce2 ! 24:  def731137335 mm/slob: Convert SLOB to use struct slab
>     @@ Metadata
>      Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>      
>       ## Commit message ##
>     -    mm/slob: Convert SLOB to use struct slab
>     +    mm/slob: Convert SLOB to use struct slab and struct folio
>      
>     -    Use struct slab throughout the slob allocator.
>     +    Use struct slab throughout the slob allocator. Where non-slab page can appear
>     +    use struct folio instead of struct page.
>      
>          [ vbabka@suse.cz: don't introduce wrappers for PageSlobFree in mm/slab.h just
>            for the single callers being wrappers in mm/slob.c ]
>      
>     +    [ Hyeonggon Yoo <42.hyeyoo@gmail.com>: fix NULL pointer deference ]
>     +
>          Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>      
>       ## mm/slob.c ##
>     +@@
>     +  * If kmalloc is asked for objects of PAGE_SIZE or larger, it calls
>     +  * alloc_pages() directly, allocating compound pages so the page order
>     +  * does not have to be separately tracked.
>     +- * These objects are detected in kfree() because PageSlab()
>     ++ * These objects are detected in kfree() because folio_test_slab()
>     +  * is false for them.
>     +  *
>     +  * SLAB is emulated on top of SLOB by simply calling constructors and
>      @@ mm/slob.c: static LIST_HEAD(free_slob_large);
>       /*
>        * slob_page_free: true for pages on free_slob_pages list.
>     @@ mm/slob.c: static void *slob_page_alloc(struct page *sp, size_t size, int align,
>       							int align_offset)
>       {
>      -	struct page *sp;
>     ++	struct folio *folio;
>      +	struct slab *sp;
>       	struct list_head *slob_list;
>       	slob_t *b = NULL;
>     @@ mm/slob.c: static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
>       			return NULL;
>      -		sp = virt_to_page(b);
>      -		__SetPageSlab(sp);
>     -+		sp = virt_to_slab(b);
>     -+		__SetPageSlab(slab_page(sp));
>     ++		folio = virt_to_folio(b);
>     ++		__folio_set_slab(folio);
>     ++		sp = folio_slab(folio);
>       
>       		spin_lock_irqsave(&slob_lock, flags);
>       		sp->units = SLOB_UNITS(PAGE_SIZE);
>     @@ mm/slob.c: static void slob_free(void *block, int size)
>       		spin_unlock_irqrestore(&slob_lock, flags);
>      -		__ClearPageSlab(sp);
>      -		page_mapcount_reset(sp);
>     -+		__ClearPageSlab(slab_page(sp));
>     ++		__folio_clear_slab(slab_folio(sp));
>      +		page_mapcount_reset(slab_page(sp));
>       		slob_free_pages(b, 0);
>       		return;
>       	}
>     +@@ mm/slob.c: EXPORT_SYMBOL(__kmalloc_node_track_caller);
>     + 
>     + void kfree(const void *block)
>     + {
>     +-	struct page *sp;
>     ++	struct folio *sp;
>     + 
>     + 	trace_kfree(_RET_IP_, block);
>     + 
>     +@@ mm/slob.c: void kfree(const void *block)
>     + 		return;
>     + 	kmemleak_free(block);
>     + 
>     +-	sp = virt_to_page(block);
>     +-	if (PageSlab(sp)) {
>     ++	sp = virt_to_folio(block);
>     ++	if (folio_test_slab(sp)) {
>     + 		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
>     + 		unsigned int *m = (unsigned int *)(block - align);
>     + 		slob_free(m, *m + align);
>     + 	} else {
>     +-		unsigned int order = compound_order(sp);
>     +-		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
>     ++		unsigned int order = folio_order(sp);
>     ++
>     ++		mod_node_page_state(folio_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
>     + 				    -(PAGE_SIZE << order));
>     +-		__free_pages(sp, order);
>     ++		__free_pages(folio_page(sp, 0), order);
>     + 
>     + 	}
>     + }
> 25:  aa4f573a4c96 ! 25:  466b9fb1f6e5 mm/kasan: Convert to struct folio and struct slab
>     @@ Commit message
>      
>          Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>     +    Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>          Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>          Cc: Alexander Potapenko <glider@google.com>
>          Cc: Andrey Konovalov <andreyknvl@gmail.com>
> 26:  67b7966d2fb6 = 26:  b8159ae8e5cd mm/kfence: Convert kfence_guarded_alloc() to struct slab
> 31:  d64dfe49c1e7 ! 27:  4525180926f9 mm/sl*b: Differentiate struct slab fields by sl*b implementations
>     @@ Commit message
>          possible.
>      
>          This should also prevent accidental use of fields that don't exist in given
>     -    implementation. Before this patch virt_to_cache() and and cache_from_obj() was
>     -    visible for SLOB (albeit not used), although it relies on the slab_cache field
>     +    implementation. Before this patch virt_to_cache() and cache_from_obj() were
>     +    visible for SLOB (albeit not used), although they rely on the slab_cache field
>          that isn't set by SLOB. With this patch it's now a compile error, so these
>          functions are now hidden behind #ifndef CONFIG_SLOB.
>      
>     @@ mm/kfence/core.c: static void *kfence_guarded_alloc(struct kmem_cache *cache, si
>      -		slab->s_mem = addr;
>      +#if defined(CONFIG_SLUB)
>      +	slab->objects = 1;
>     -+#elif defined (CONFIG_SLAB)
>     ++#elif defined(CONFIG_SLAB)
>      +	slab->s_mem = addr;
>      +#endif
>       
>     @@ mm/slab.h
>      +
>      +#if defined(CONFIG_SLAB)
>      +
>     -+	union {
>     -+		struct list_head slab_list;
>     + 	union {
>     + 		struct list_head slab_list;
>     +-		struct {	/* Partial pages */
>      +		struct rcu_head rcu_head;
>      +	};
>      +	struct kmem_cache *slab_cache;
>      +	void *freelist;	/* array of free object indexes */
>     -+	void * s_mem;	/* first object */
>     ++	void *s_mem;	/* first object */
>      +	unsigned int active;
>      +
>      +#elif defined(CONFIG_SLUB)
>      +
>     - 	union {
>     - 		struct list_head slab_list;
>     --		struct {	/* Partial pages */
>     ++	union {
>     ++		struct list_head slab_list;
>      +		struct rcu_head rcu_head;
>      +		struct {
>       			struct slab *next;
>     @@ mm/slab.h: struct slab {
>      +#elif defined(CONFIG_SLOB)
>      +
>      +	struct list_head slab_list;
>     -+	void * __unused_1;
>     ++	void *__unused_1;
>      +	void *freelist;		/* first free block */
>     -+	void * __unused_2;
>     ++	void *__unused_2;
>      +	int units;
>      +
>      +#else
>     @@ mm/slab.h: struct slab {
>       #ifdef CONFIG_MEMCG
>       	unsigned long memcg_data;
>      @@ mm/slab.h: struct slab {
>     - 	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>       SLAB_MATCH(flags, __page_flags);
>       SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>     + SLAB_MATCH(slab_list, slab_list);
>      +#ifndef CONFIG_SLOB
>       SLAB_MATCH(rcu_head, rcu_head);
>     + SLAB_MATCH(slab_cache, slab_cache);
>     ++#endif
>     ++#ifdef CONFIG_SLAB
>     + SLAB_MATCH(s_mem, s_mem);
>     + SLAB_MATCH(active, active);
>      +#endif
>       SLAB_MATCH(_refcount, __page_refcount);
>       #ifdef CONFIG_MEMCG
> 32:  0abf87bae67e = 28:  94b78948d53f mm/slub: Simplify struct slab slabs field definition
> 33:  813c304f18e4 = 29:  f5261e6375f0 mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
> 27:  ebce4b5b5ced ! 30:  1414e8c87de6 zsmalloc: Stop using slab fields in struct page
>     @@ Commit message
>      
>          Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>     -    Cc: Minchan Kim <minchan@kernel.org>
>     +    Acked-by: Minchan Kim <minchan@kernel.org>
>          Cc: Nitin Gupta <ngupta@vflare.org>
>          Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>      
> 28:  f124425ae7de = 31:  8a3cda6b38eb bootmem: Use page->index instead of page->freelist
> 29:  82da48c73b2e <  -:  ------------ iommu: Use put_pages_list
> 30:  181e16dfefbb <  -:  ------------ mm: Remove slab from struct page
>  -:  ------------ > 32:  91e069ba116b mm/slob: Remove unnecessary page_mapcount_reset() function call
