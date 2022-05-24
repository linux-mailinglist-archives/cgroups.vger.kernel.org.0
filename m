Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57B5331B8
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiEXTX0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiEXTXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE8D6AA6E
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653420200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adOr6oQYJkDW12JAlh99Rd8CLoNxO1CHyerplRw2azw=;
        b=UU9+D2Ii/kbjW2dxfHbz6p8afyNtDIZNryTAfRBTdzOI6+aZtU5BOzDRb8mt95s5TPbt3p
        CFHACoM5q/fqhSO0IvkXHWtgFp2IxIrSKp+zKrDUL8ZELF0NqDKVBMacBg1k7F3YB3OkmW
        GAFbfpr+3mronVwFp/PTGiIKgCWtkR0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-cQjK_w3CPoGZRb1XebHi3A-1; Tue, 24 May 2022 15:23:13 -0400
X-MC-Unique: cQjK_w3CPoGZRb1XebHi3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98F0D1C03367;
        Tue, 24 May 2022 19:23:12 +0000 (UTC)
Received: from [10.22.8.146] (unknown [10.22.8.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2101410DD5;
        Tue, 24 May 2022 19:23:11 +0000 (UTC)
Message-ID: <f55976e6-d209-32c2-504d-f73a9b504511@redhat.com>
Date:   Tue, 24 May 2022 15:23:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220524060551.80037-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/24/22 02:05, Muchun Song wrote:
> The diagram below shows how to make the folio lruvec lock safe when LRU
> pages are reparented.
>
> folio_lruvec_lock(folio)
>      retry:
> 	lruvec = folio_lruvec(folio);
>
>          // The folio is reparented at this time.
>          spin_lock(&lruvec->lru_lock);
>
>          if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
>              // Acquired the wrong lruvec lock and need to retry.
>              // Because this folio is on the parent memcg lruvec list.
>              goto retry;
>
>          // If we reach here, it means that folio_memcg(folio) is stable.
>
> memcg_reparent_objcgs(memcg)
>      // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>      spin_lock(&lruvec->lru_lock);
>      spin_lock(&lruvec_parent->lru_lock);
>
>      // Move all the pages from the lruvec list to the parent lruvec list.
>
>      spin_unlock(&lruvec_parent->lru_lock);
>      spin_unlock(&lruvec->lru_lock);
>
> After we acquire the lruvec lock, we need to check whether the folio is
> reparented. If so, we need to reacquire the new lruvec lock. On the
> routine of the LRU pages reparenting, we will also acquire the lruvec
> lock (will be implemented in the later patch). So folio_memcg() cannot
> be changed when we hold the lruvec lock.
>
> Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> remove it.
>
> This is a preparation for reparenting the LRU pages.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   include/linux/memcontrol.h | 18 +++-----------
>   mm/compaction.c            | 10 +++++++-
>   mm/memcontrol.c            | 62 +++++++++++++++++++++++++++++-----------------
>   mm/swap.c                  |  4 +++
>   4 files changed, 55 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ff1c1dd7e762..4042e4d21fe2 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -752,7 +752,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>    * folio_lruvec - return lruvec for isolating/putting an LRU folio
>    * @folio: Pointer to the folio.
>    *
> - * This function relies on folio->mem_cgroup being stable.
> + * The lruvec can be changed to its parent lruvec when the page reparented.
> + * The caller need to recheck if it cares about this changes (just like
> + * folio_lruvec_lock() does).
>    */
>   static inline struct lruvec *folio_lruvec(struct folio *folio)
>   {
> @@ -771,15 +773,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
>   struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
>   						unsigned long *flags);
>   
> -#ifdef CONFIG_DEBUG_VM
> -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
> -#else
> -static inline
> -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> -{
> -}
> -#endif
> -
>   static inline
>   struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>   	return css ? container_of(css, struct mem_cgroup, css) : NULL;
> @@ -1240,11 +1233,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
>   	return &pgdat->__lruvec;
>   }
>   
> -static inline
> -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> -{
> -}
> -
>   static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>   {
>   	return NULL;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 817098817302..1692b17db781 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -515,6 +515,8 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
>   {
>   	struct lruvec *lruvec;
>   
> +	rcu_read_lock();
> +retry:
>   	lruvec = folio_lruvec(folio);
>   
>   	/* Track if the lock is contended in async mode */
> @@ -527,7 +529,13 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
>   
>   	spin_lock_irqsave(&lruvec->lru_lock, *flags);
>   out:
> -	lruvec_memcg_debug(lruvec, folio);
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
> +		goto retry;
> +	}
> +
> +	/* See the comments in folio_lruvec_lock(). */
> +	rcu_read_unlock();
>   
>   	return lruvec;
>   }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6de0d3e53eb1..b38a77f6696f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1199,23 +1199,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   	return ret;
>   }
>   
> -#ifdef CONFIG_DEBUG_VM
> -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> -{
> -	struct mem_cgroup *memcg;
> -
> -	if (mem_cgroup_disabled())
> -		return;
> -
> -	memcg = folio_memcg(folio);
> -
> -	if (!memcg)
> -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
> -	else
> -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
> -}
> -#endif
> -
>   /**
>    * folio_lruvec_lock - Lock the lruvec for a folio.
>    * @folio: Pointer to the folio.
> @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>    */
>   struct lruvec *folio_lruvec_lock(struct folio *folio)
>   {
> -	struct lruvec *lruvec = folio_lruvec(folio);
> +	struct lruvec *lruvec;
>   
> +	rcu_read_lock();
> +retry:
> +	lruvec = folio_lruvec(folio);
>   	spin_lock(&lruvec->lru_lock);
> -	lruvec_memcg_debug(lruvec, folio);
> +
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock(&lruvec->lru_lock);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * Preemption is disabled in the internal of spin_lock, which can serve
> +	 * as RCU read-side critical sections.
> +	 */
What is the point of this comment as preemption is not disabled for 
PREEMPT_RT kernel?

> +	rcu_read_unlock();
>   
>   	return lruvec;
>   }
> @@ -1253,10 +1249,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
>    */
>   struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
>   {
> -	struct lruvec *lruvec = folio_lruvec(folio);
> +	struct lruvec *lruvec;
>   
> +	rcu_read_lock();
> +retry:
> +	lruvec = folio_lruvec(folio);
>   	spin_lock_irq(&lruvec->lru_lock);
> -	lruvec_memcg_debug(lruvec, folio);
> +
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock_irq(&lruvec->lru_lock);
> +		goto retry;
> +	}
> +
> +	/* See the comments in folio_lruvec_lock(). */
> +	rcu_read_unlock();
>   
>   	return lruvec;
>   }
> @@ -1278,10 +1284,20 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
>   struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
>   		unsigned long *flags)
>   {
> -	struct lruvec *lruvec = folio_lruvec(folio);
> +	struct lruvec *lruvec;
>   
> +	rcu_read_lock();
> +retry:
> +	lruvec = folio_lruvec(folio);
>   	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> -	lruvec_memcg_debug(lruvec, folio);
> +
> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> +		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
> +		goto retry;
> +	}
> +
> +	/* See the comments in folio_lruvec_lock(). */
> +	rcu_read_unlock();
>   
>   	return lruvec;
>   }
> diff --git a/mm/swap.c b/mm/swap.c
> index 7e320ec08c6a..9680f2fc48b1 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -303,6 +303,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>   
>   void lru_note_cost_folio(struct folio *folio)
>   {
> +	/*
> +	 * The rcu read lock is held by the caller, so we do not need to
> +	 * care about the lruvec returned by folio_lruvec() being released.
> +	 */
Maybe we can add "WARN_ON_ONCE(!rcu_read_lock_held())" to be sure.

>   	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
>   			folio_nr_pages(folio));
>   }

Cheers,
Longman

