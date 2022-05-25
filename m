Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F65337DB
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiEYH5d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiEYH5c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 03:57:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88082146
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 00:57:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cv10so2332461pjb.4
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BIfu86Es+rpR2jtY5sgnRcqPdHwZHKxlgTNKZfJGq+U=;
        b=5f0De3kv/EV7Qkqjnlim94Tz0nV7/FwJc/QIu/TppaXMj1d969Bpil5+xG5CjXiGfg
         e7MZDoDIRpLmFYbz6CbdDNFaSXZW+WJa4cjDrYbPXPDniOoxpMHIjNyUdOmRHfXAXi2v
         fJOzIvEM2YfxQcmAiePutZS6DELZ3Z4YkNmalXFtRmddXkUTvLgj6TlJ/1sWkGuNZY9P
         qtYG7DjTNdWywcZn/FVDV45pe9gXntybSj6SofvaNmQrUvNZHdxLpPy4Hg5vaQT6zrk5
         F1WhcN5yJa4h1z++PIOQoLNRcj2NZQBtwfuPouAxNSlVzJC05Ltn47B3WQNgvqhDpyu2
         4EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BIfu86Es+rpR2jtY5sgnRcqPdHwZHKxlgTNKZfJGq+U=;
        b=v0U3zRppNce5hPDMjZacNrK3ZAhywz938Dpch4KyBwdmOSqZmLYEYu1r5PC+RlI+Yz
         CwTYVIDUn+Qswl7B3mngOysVvEX9sVYZNAa1HUYYJskXHasyD/MCxTsLdMWbH3WvyuGU
         sg8MirlPforGbcQPDbgtHqBHRQQuOoWoWh9Rlj9RmJ3jGBsgFo1kYP0TXhhIjO8PHVxm
         BNG2YUaqmqjTNdETJMJXCqZV6mJXyliiuAqa6KXbbrOCmq9a7doe9hi0b9EPYs1u4/He
         5VJ1hTZzlV1d9Ai3qODcFrAJvb3gmSmzitcia/zYdT5NRKjoJYdusSSaTWf2RdAQrBSf
         Re7Q==
X-Gm-Message-State: AOAM533weLMxWp+2JeKF04WP2Iv2O9OcyCW37rSGjHmt+8GgxYdeH7ry
        oohdD387KGNUUe95QJG0LH37AQ==
X-Google-Smtp-Source: ABdhPJwgGa+Qz9yZJtVAN21h6SNv277L1tX+EC9ZxJqykQ2pkOLjsbCtRnBUbGHhs9NNY4/KCjFB0g==
X-Received: by 2002:a17:90a:17e8:b0:1df:4e82:a7aa with SMTP id q95-20020a17090a17e800b001df4e82a7aamr9040584pja.4.1653465442516;
        Wed, 25 May 2022 00:57:22 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id u33-20020a056a0009a100b005184fe6cc99sm10698392pfg.29.2022.05.25.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:57:22 -0700 (PDT)
Date:   Wed, 25 May 2022 15:57:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo3hXe8bF3boWx5C@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
 <Yo2WKADtPy2rekRh@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo2WKADtPy2rekRh@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 07:36:24PM -0700, Roman Gushchin wrote:
> On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> > Pagecache pages are charged at the allocation time and holding a
> > reference to the original memory cgroup until being reclaimed.
> > Depending on the memory pressure, specific patterns of the page
> > sharing between different cgroups and the cgroup creation and
> > destruction rates, a large number of dying memory cgroups can be
> > pinned by pagecache pages. It makes the page reclaim less efficient
> > and wastes memory.
> > 
> > We can convert LRU pages and most other raw memcg pins to the objcg
> > direction to fix this problem, and then the page->memcg will always
> > point to an object cgroup pointer.
> > 
> > Therefore, the infrastructure of objcg no longer only serves
> > CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> > objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> > can reuse it to charge pages.
> > 
> > We know that the LRU pages are not accounted at the root level. But
> > the page->memcg_data points to the root_mem_cgroup. So the
> > page->memcg_data of the LRU pages always points to a valid pointer.
> > But the root_mem_cgroup dose not have an object cgroup. If we use
> > obj_cgroup APIs to charge the LRU pages, we should set the
> > page->memcg_data to a root object cgroup. So we also allocate an
> > object cgroup for the root_mem_cgroup.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h |  5 ++--
> >  mm/memcontrol.c            | 60 +++++++++++++++++++++++++---------------------
> >  2 files changed, 35 insertions(+), 30 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 89b14729d59f..ff1c1dd7e762 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -315,10 +315,10 @@ struct mem_cgroup {
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> >  	int kmemcg_id;
> > +#endif
> >  	struct obj_cgroup __rcu *objcg;
> >  	/* list of inherited objcgs, protected by objcg_lock */
> >  	struct list_head objcg_list;
> > -#endif
> >  
> >  	MEMCG_PADDING(_pad2_);
> >  
> > @@ -851,8 +851,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
> >   * parent_mem_cgroup - find the accounting parent of a memcg
> >   * @memcg: memcg whose parent to find
> >   *
> > - * Returns the parent memcg, or NULL if this is the root or the memory
> > - * controller is in legacy no-hierarchy mode.
> > + * Returns the parent memcg, or NULL if this is the root.
> >   */
> >  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
> >  {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 598fece89e2b..6de0d3e53eb1 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -254,9 +254,9 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
> >  	return container_of(vmpr, struct mem_cgroup, vmpressure);
> >  }
> >  
> > -#ifdef CONFIG_MEMCG_KMEM
> >  static DEFINE_SPINLOCK(objcg_lock);
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> >  bool mem_cgroup_kmem_disabled(void)
> >  {
> >  	return cgroup_memory_nokmem;
> > @@ -265,12 +265,10 @@ bool mem_cgroup_kmem_disabled(void)
> >  static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
> >  				      unsigned int nr_pages);
> >  
> > -static void obj_cgroup_release(struct percpu_ref *ref)
> > +static void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
> >  {
> > -	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> >  	unsigned int nr_bytes;
> >  	unsigned int nr_pages;
> > -	unsigned long flags;
> >  
> >  	/*
> >  	 * At this point all allocated objects are freed, and
> > @@ -284,9 +282,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >  	 * 3) CPU1: a process from another memcg is allocating something,
> >  	 *          the stock if flushed,
> >  	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> > -	 * 5) CPU0: we do release this object,
> > +	 * 4) CPU0: we do release this object,
> >  	 *          92 bytes are added to stock->nr_bytes
> > -	 * 6) CPU0: stock is flushed,
> > +	 * 5) CPU0: stock is flushed,
> >  	 *          92 bytes are added to objcg->nr_charged_bytes
> >  	 *
> >  	 * In the result, nr_charged_bytes == PAGE_SIZE.
> > @@ -298,6 +296,19 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >  
> >  	if (nr_pages)
> >  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> > +}
> > +#else
> > +static inline void obj_cgroup_release_bytes(struct obj_cgroup *objcg)
> > +{
> > +}
> > +#endif
> > +
> > +static void obj_cgroup_release(struct percpu_ref *ref)
> > +{
> > +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > +	unsigned long flags;
> > +
> > +	obj_cgroup_release_bytes(objcg);
> >  
> >  	spin_lock_irqsave(&objcg_lock, flags);
> >  	list_del(&objcg->list);
> > @@ -326,10 +337,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
> >  	return objcg;
> >  }
> >  
> > -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> > -				  struct mem_cgroup *parent)
> > +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
> >  {
> >  	struct obj_cgroup *objcg, *iter;
> > +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> >  
> >  	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> >  
> > @@ -348,6 +359,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> >  	percpu_ref_kill(&objcg->refcnt);
> >  }
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> >  /*
> >   * A lot of the calls to the cache allocation functions are expected to be
> >   * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
> > @@ -3589,21 +3601,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static int memcg_online_kmem(struct mem_cgroup *memcg)
> >  {
> > -	struct obj_cgroup *objcg;
> > -
> >  	if (cgroup_memory_nokmem)
> >  		return 0;
> >  
> >  	if (unlikely(mem_cgroup_is_root(memcg)))
> >  		return 0;
> >  
> > -	objcg = obj_cgroup_alloc();
> > -	if (!objcg)
> > -		return -ENOMEM;
> > -
> > -	objcg->memcg = memcg;
> > -	rcu_assign_pointer(memcg->objcg, objcg);
> > -
> >  	static_branch_enable(&memcg_kmem_enabled_key);
> >  
> >  	memcg->kmemcg_id = memcg->id.id;
> > @@ -3613,27 +3616,19 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> >  
> >  static void memcg_offline_kmem(struct mem_cgroup *memcg)
> >  {
> > -	struct mem_cgroup *parent;
> > -
> >  	if (cgroup_memory_nokmem)
> >  		return;
> >  
> >  	if (unlikely(mem_cgroup_is_root(memcg)))
> >  		return;
> >  
> > -	parent = parent_mem_cgroup(memcg);
> > -	if (!parent)
> > -		parent = root_mem_cgroup;
> > -
> > -	memcg_reparent_objcgs(memcg, parent);
> > -
> >  	/*
> >  	 * After we have finished memcg_reparent_objcgs(), all list_lrus
> >  	 * corresponding to this cgroup are guaranteed to remain empty.
> >  	 * The ordering is imposed by list_lru_node->lock taken by
> >  	 * memcg_reparent_list_lrus().
> >  	 */
> 
> This comment doesn't look to be correct after these changes. Should it
> be fixed? Or the ordering should be fixed too?
>

I think I could drop those comments since they are out-of-date, we do not
need this ordering since

  commit 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")

which does the reparenting in memcg_reparent_list_lrus(), right?

> > -	memcg_reparent_list_lrus(memcg, parent);
> > +	memcg_reparent_list_lrus(memcg, parent_mem_cgroup(memcg));
> We effectively dropped this:
> 	if (!parent)
> 		parent = root_mem_cgroup;
> Is it safe? (assuming v1 non-hierarchical mode, it's usually when all
> is getting complicated)

Since no-hierarchy mode is deprecated after commit bef8620cd8e0
("mm: memcg: deprecate the non-hierarchical mode"), so
parent_mem_cgroup() cannot return a NULL except root memcg,
however, root memcg will not be offline, so it is safe. Right?

Thanks.
