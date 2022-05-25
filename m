Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4546533A8F
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiEYKUf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbiEYKUd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 06:20:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A2972BC
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 03:20:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f4so3257951pgf.4
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRkETpW546D+K5h5O8XLnAJjv7rtEZY29yzDIP3tmOw=;
        b=j79qceaO3IIf0K1tf0l4+0+CmNpeG0hSKDwY/pP0I2qBVzxbKz7dW77SXPVqoxUm7k
         YWTsHtJJt1EWCVVFDsuqeOk8cjKwOMaFpTRdQv7JYgarlKT1mc5y6cRJliYnKaF1I5+1
         KThc3Vq/KJz8hUvstWTI4mMdoPz8vMyRX0sEtGrx47BWv48vIoShXtAaVoaZGPqD/u5I
         5hHBqaXRw7PvpMuyYXmzNC39NQ2sBNR34K8k2POk+EUPbQ+FckglpFSekhwuy7bqcCZZ
         oJmdSX4vW1yLISd+FCZHwQNG1y92CVkma+Q7iI9N1evtkrh6x/OsPSjBaMoAhxlVb3hl
         T4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gRkETpW546D+K5h5O8XLnAJjv7rtEZY29yzDIP3tmOw=;
        b=rS7//27AGFcFguFWdoJs29fU0Zbopuj6lcH3aYeuddbGuwMyZcq2qKjiJhm6cPC2lZ
         p04WTktJaKfXlR+NvIy53GhI34Zv1l1ZSXfC3VIB+7GI3Zut5221VRa+EXlht51NxHxZ
         /y9qKO0IPf706XjcRQwXyyegs3wVx/tlpkEXbwbWAps4rGvJ3+RiThHtk3X/6BF7gk/7
         xeDNnZLLAc7TfHVgYPBATSErrY1WYgl2A1Mzq7ubsS94fsuzD4xNHbvKBsbdXOa57pRr
         1wkwgQce8hN/KaS/+nlpk+jwE34P9Sam/R4Bac5ZpJE/urpCNZPAVt4IP00osTrIlL51
         VxDg==
X-Gm-Message-State: AOAM531fM3ZuRxwYtwjALXgcGpamyL7A3STzzKQkn/i1pc5ZS5LcOSoy
        qm4NRWakLp/81y4d6Ws7f7hFXQ==
X-Google-Smtp-Source: ABdhPJwnGqbqw5HTXdnRyp0tJNPYdgRKMkDFpI2l4o88whVchkaDAkKpR9q7Sqzs55hMcECCzNneLw==
X-Received: by 2002:a63:8941:0:b0:3f7:4ce0:855c with SMTP id v62-20020a638941000000b003f74ce0855cmr22231906pgd.440.1653474031441;
        Wed, 25 May 2022 03:20:31 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b0015e8d4eb29csm9041589plg.230.2022.05.25.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:20:30 -0700 (PDT)
Date:   Wed, 25 May 2022 18:20:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo4C6T56O7EBADbX@FVFYT0MHHV2J.googleapis.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <f55976e6-d209-32c2-504d-f73a9b504511@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55976e6-d209-32c2-504d-f73a9b504511@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:23:11PM -0400, Waiman Long wrote:
> On 5/24/22 02:05, Muchun Song wrote:
> > The diagram below shows how to make the folio lruvec lock safe when LRU
> > pages are reparented.
> > 
> > folio_lruvec_lock(folio)
> >      retry:
> > 	lruvec = folio_lruvec(folio);
> > 
> >          // The folio is reparented at this time.
> >          spin_lock(&lruvec->lru_lock);
> > 
> >          if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> >              // Acquired the wrong lruvec lock and need to retry.
> >              // Because this folio is on the parent memcg lruvec list.
> >              goto retry;
> > 
> >          // If we reach here, it means that folio_memcg(folio) is stable.
> > 
> > memcg_reparent_objcgs(memcg)
> >      // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >      spin_lock(&lruvec->lru_lock);
> >      spin_lock(&lruvec_parent->lru_lock);
> > 
> >      // Move all the pages from the lruvec list to the parent lruvec list.
> > 
> >      spin_unlock(&lruvec_parent->lru_lock);
> >      spin_unlock(&lruvec->lru_lock);
> > 
> > After we acquire the lruvec lock, we need to check whether the folio is
> > reparented. If so, we need to reacquire the new lruvec lock. On the
> > routine of the LRU pages reparenting, we will also acquire the lruvec
> > lock (will be implemented in the later patch). So folio_memcg() cannot
> > be changed when we hold the lruvec lock.
> > 
> > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > remove it.
> > 
> > This is a preparation for reparenting the LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >   include/linux/memcontrol.h | 18 +++-----------
> >   mm/compaction.c            | 10 +++++++-
> >   mm/memcontrol.c            | 62 +++++++++++++++++++++++++++++-----------------
> >   mm/swap.c                  |  4 +++
> >   4 files changed, 55 insertions(+), 39 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index ff1c1dd7e762..4042e4d21fe2 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -752,7 +752,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> >    * folio_lruvec - return lruvec for isolating/putting an LRU folio
> >    * @folio: Pointer to the folio.
> >    *
> > - * This function relies on folio->mem_cgroup being stable.
> > + * The lruvec can be changed to its parent lruvec when the page reparented.
> > + * The caller need to recheck if it cares about this changes (just like
> > + * folio_lruvec_lock() does).
> >    */
> >   static inline struct lruvec *folio_lruvec(struct folio *folio)
> >   {
> > @@ -771,15 +773,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
> >   struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
> >   						unsigned long *flags);
> > -#ifdef CONFIG_DEBUG_VM
> > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
> > -#else
> > -static inline
> > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > -{
> > -}
> > -#endif
> > -
> >   static inline
> >   struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
> >   	return css ? container_of(css, struct mem_cgroup, css) : NULL;
> > @@ -1240,11 +1233,6 @@ static inline struct lruvec *folio_lruvec(struct folio *folio)
> >   	return &pgdat->__lruvec;
> >   }
> > -static inline
> > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > -{
> > -}
> > -
> >   static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
> >   {
> >   	return NULL;
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 817098817302..1692b17db781 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -515,6 +515,8 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
> >   {
> >   	struct lruvec *lruvec;
> > +	rcu_read_lock();
> > +retry:
> >   	lruvec = folio_lruvec(folio);
> >   	/* Track if the lock is contended in async mode */
> > @@ -527,7 +529,13 @@ compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
> >   	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> >   out:
> > -	lruvec_memcg_debug(lruvec, folio);
> > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > +		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
> > +		goto retry;
> > +	}
> > +
> > +	/* See the comments in folio_lruvec_lock(). */
> > +	rcu_read_unlock();
> >   	return lruvec;
> >   }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6de0d3e53eb1..b38a77f6696f 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1199,23 +1199,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >   	return ret;
> >   }
> > -#ifdef CONFIG_DEBUG_VM
> > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > -{
> > -	struct mem_cgroup *memcg;
> > -
> > -	if (mem_cgroup_disabled())
> > -		return;
> > -
> > -	memcg = folio_memcg(folio);
> > -
> > -	if (!memcg)
> > -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != root_mem_cgroup, folio);
> > -	else
> > -		VM_BUG_ON_FOLIO(lruvec_memcg(lruvec) != memcg, folio);
> > -}
> > -#endif
> > -
> >   /**
> >    * folio_lruvec_lock - Lock the lruvec for a folio.
> >    * @folio: Pointer to the folio.
> > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> >    */
> >   struct lruvec *folio_lruvec_lock(struct folio *folio)
> >   {
> > -	struct lruvec *lruvec = folio_lruvec(folio);
> > +	struct lruvec *lruvec;
> > +	rcu_read_lock();
> > +retry:
> > +	lruvec = folio_lruvec(folio);
> >   	spin_lock(&lruvec->lru_lock);
> > -	lruvec_memcg_debug(lruvec, folio);
> > +
> > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > +		spin_unlock(&lruvec->lru_lock);
> > +		goto retry;
> > +	}
> > +
> > +	/*
> > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > +	 * as RCU read-side critical sections.
> > +	 */
> What is the point of this comment as preemption is not disabled for
> PREEMPT_RT kernel?
>

I'm not familar with PREEMPT_RT kernel. At least you are right,
preemption is not disabled in this case, I think I should drop
this assumption.

> > +	rcu_read_unlock();
> >   	return lruvec;
> >   }
> > @@ -1253,10 +1249,20 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
> >    */
> >   struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
> >   {
> > -	struct lruvec *lruvec = folio_lruvec(folio);
> > +	struct lruvec *lruvec;
> > +	rcu_read_lock();
> > +retry:
> > +	lruvec = folio_lruvec(folio);
> >   	spin_lock_irq(&lruvec->lru_lock);
> > -	lruvec_memcg_debug(lruvec, folio);
> > +
> > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > +		spin_unlock_irq(&lruvec->lru_lock);
> > +		goto retry;
> > +	}
> > +
> > +	/* See the comments in folio_lruvec_lock(). */
> > +	rcu_read_unlock();
> >   	return lruvec;
> >   }
> > @@ -1278,10 +1284,20 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
> >   struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
> >   		unsigned long *flags)
> >   {
> > -	struct lruvec *lruvec = folio_lruvec(folio);
> > +	struct lruvec *lruvec;
> > +	rcu_read_lock();
> > +retry:
> > +	lruvec = folio_lruvec(folio);
> >   	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> > -	lruvec_memcg_debug(lruvec, folio);
> > +
> > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > +		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
> > +		goto retry;
> > +	}
> > +
> > +	/* See the comments in folio_lruvec_lock(). */
> > +	rcu_read_unlock();
> >   	return lruvec;
> >   }
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 7e320ec08c6a..9680f2fc48b1 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -303,6 +303,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
> >   void lru_note_cost_folio(struct folio *folio)
> >   {
> > +	/*
> > +	 * The rcu read lock is held by the caller, so we do not need to
> > +	 * care about the lruvec returned by folio_lruvec() being released.
> > +	 */
> Maybe we can add "WARN_ON_ONCE(!rcu_read_lock_held())" to be sure.
>

Good point. I'll add it.

Thanks.
 
> >   	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
> >   			folio_nr_pages(folio));
> >   }
> 
> Cheers,
> Longman
> 
> 
