Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3937533560
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 04:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiEYCge (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 22:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiEYCgd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 22:36:33 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C4824BDE;
        Tue, 24 May 2022 19:36:31 -0700 (PDT)
Date:   Tue, 24 May 2022 19:36:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653446190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRF08RH4HX5TQP4tbU3gSrFe2wB3jShQ6zYuVNhxUJU=;
        b=ntsNkB6oeDaC8TeGD3HFnHBaXzVLiB2xci0QqSb2C0OlLRhzva+sR2pjIT6OPSsThN7HOr
        MiOyL2HnQrfgd4lMxuibr70BYnBscKnDMctXZsvZMYH19TYHqygnrBMNXyg2msf+K96lNV
        y46KnLiUruSy+HlYu+u7YesUEiWUAUk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo2WKADtPy2rekRh@carbon>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-2-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> Pagecache pages are charged at the allocation time and holding a
> reference to the original memory cgroup until being reclaimed.
> Depending on the memory pressure, specific patterns of the page
> sharing between different cgroups and the cgroup creation and
> destruction rates, a large number of dying memory cgroups can be
> pinned by pagecache pages. It makes the page reclaim less efficient
> and wastes memory.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.
> 
> We know that the LRU pages are not accounted at the root level. But
> the page->memcg_data points to the root_mem_cgroup. So the
> page->memcg_data of the LRU pages always points to a valid pointer.
> But the root_mem_cgroup dose not have an object cgroup. If we use
> obj_cgroup APIs to charge the LRU pages, we should set the
> page->memcg_data to a root object cgroup. So we also allocate an
> object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h |  5 ++--
>  mm/memcontrol.c            | 60 +++++++++++++++++++++++++---------------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 89b14729d59f..ff1c1dd7e762 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -315,10 +315,10 @@ struct mem_cgroup {
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  	int kmemcg_id;
> +#endif
>  	struct obj_cgroup __rcu *objcg;
>  	/* list of inherited objcgs, protected by objcg_lock */
>  	struct list_head objcg_list;
> -#endif
>  
>  	MEMCG_PADDING(_pad2_);
>  
> @@ -851,8 +851,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
>   * parent_mem_cgroup - find the accounting parent of a memcg
>   * @memcg: memcg whose parent to find
>   *
> - * Returns the parent memcg, or NULL if this is the root or the memory
> - * controller is in legacy no-hierarchy mode.
> + * Returns the parent memcg, or NULL if this is the root.
>   */
>  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 598fece89e2b..6de0d3e53eb1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -254,9 +254,9 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
>  	return container_of(vmpr, struct mem_cgroup, vmpressure);
>  }
>  
> -#ifdef CONFIG_MEMCG_KMEM
>  static DEFINE_SPINLOCK(objcg_lock);
>  
> +#ifdef CONFIG_MEMCG_KMEM
>  bool mem_cgroup_kmem_disabled(void)
>  {
>  	return cgroup_memory_nokmem;
> @@ -265,12 +265,10 @@ bool mem_cgroup_kmem_disabled(void)
>  static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  				      unsigned int nr_pages);
>  
> -static void obj_cgroup_release(struct percpu_ref *ref)
> +static void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
>  {
> -	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
>  	unsigned int nr_bytes;
>  	unsigned int nr_pages;
> -	unsigned long flags;
>  
>  	/*
>  	 * At this point all allocated objects are freed, and
> @@ -284,9 +282,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	 * 3) CPU1: a process from another memcg is allocating something,
>  	 *          the stock if flushed,
>  	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> -	 * 5) CPU0: we do release this object,
> +	 * 4) CPU0: we do release this object,
>  	 *          92 bytes are added to stock->nr_bytes
> -	 * 6) CPU0: stock is flushed,
> +	 * 5) CPU0: stock is flushed,
>  	 *          92 bytes are added to objcg->nr_charged_bytes
>  	 *
>  	 * In the result, nr_charged_bytes == PAGE_SIZE.
> @@ -298,6 +296,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> +}
> +#else
> +static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
> +{
> +}
> +#endif
> +
> +static void obj_cgroup_release(struct percpu_ref *ref)
> +{
> +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> +	unsigned long flags;
> +
> +	obj_cgroup_release_bytes(objcg);
>  
>  	spin_lock_irqsave(&objcg_lock, flags);
>  	list_del(&objcg->list);
> @@ -326,10 +337,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>  	return objcg;
>  }
>  
> -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> -				  struct mem_cgroup *parent)
> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg, *iter;
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>  
>  	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
>  
> @@ -348,6 +359,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
>  	percpu_ref_kill(&objcg->refcnt);
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
>  /*
>   * A lot of the calls to the cache allocation functions are expected to be
>   * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
> @@ -3589,21 +3601,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> -	struct obj_cgroup *objcg;
> -
>  	if (cgroup_memory_nokmem)
>  		return 0;
>  
>  	if (unlikely(mem_cgroup_is_root(memcg)))
>  		return 0;
>  
> -	objcg = obj_cgroup_alloc();
> -	if (!objcg)
> -		return -ENOMEM;
> -
> -	objcg->memcg = memcg;
> -	rcu_assign_pointer(memcg->objcg, objcg);
> -
>  	static_branch_enable(&memcg_kmem_enabled_key);
>  
>  	memcg->kmemcg_id = memcg->id.id;
> @@ -3613,27 +3616,19 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  {
> -	struct mem_cgroup *parent;
> -
>  	if (cgroup_memory_nokmem)
>  		return;
>  
>  	if (unlikely(mem_cgroup_is_root(memcg)))
>  		return;
>  
> -	parent = parent_mem_cgroup(memcg);
> -	if (!parent)
> -		parent = root_mem_cgroup;
> -
> -	memcg_reparent_objcgs(memcg, parent);
> -
>  	/*
>  	 * After we have finished memcg_reparent_objcgs(), all list_lrus
>  	 * corresponding to this cgroup are guaranteed to remain empty.
>  	 * The ordering is imposed by list_lru_node->lock taken by
>  	 * memcg_reparent_list_lrus().
>  	 */

This comment doesn't look to be correct after these changes. Should it
be fixed? Or the ordering should be fixed too?

> -	memcg_reparent_list_lrus(memcg, parent);
> +	memcg_reparent_list_lrus(memcg, parent_mem_cgroup(memcg));
We effectively dropped this:
	if (!parent)
		parent = root_mem_cgroup;
Is it safe? (assuming v1 non-hierarchical mode, it's usually when all
is getting complicated)

The rest of the patch looks good to me.

Thanks!
