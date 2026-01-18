Return-Path: <cgroups+bounces-13291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1879D391FC
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 01:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB72300EE61
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439619AD8B;
	Sun, 18 Jan 2026 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CKnyZNNY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D050095D;
	Sun, 18 Jan 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768697062; cv=none; b=NjzMF9TCLyJGw1ar1eUpK+ORdmKcEKQchnkBKFsuYDt5effoNjlxSXq17MgSmxLNp+REKgtKGGgk3RMUI9R2tnc2Pbld4HndDuedSlt1GDr9IVirHNJaZbAGcp7LcWenu6qJgeli4QjOs8JT4R1zakF/lTdP+8H/OPWWOHVhJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768697062; c=relaxed/simple;
	bh=XjaI0fJVQQjVFhoRhmhtk5g/mB6JDGH6MVIOSe1D/Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSZ7+5GutmfgUKlM+whR/vzylRj6V6Wm+Lp+z0yjJghG/DKIW2HHfwIEektHe5YAHM8loxcgGNtjZ7PrSlvypCCzwaON6iUECuHOE7pafuH78rg3pOJhDP6R3kGYjBjZWFAIJ/mzM3gSsL/QFm20W0RFY27M6yLqlGsbJGP8qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKnyZNNY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 16:44:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768697057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whDjQXmdHM3VZOKRc3lRTlarxS+fL0vnszLAxxSW1CU=;
	b=CKnyZNNY5eppfAzVkVuovTh7vEsjr9K/+rcO7VbAKsE0nuooPJo16edeoGWCBjUXZ448/U
	PeXDlEqXCNE5OLGzngEmMum6SnXKkmshNt1SuhH5LIrCmwlI16UUJaRf6mAszrdvBLNGrL
	dDuAehSs9u/Ix+BLjYwM6CrfvMmqEPE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <ncg4ibcrecdutsizzwdu4buw2fvqc57yji4rx3hsdwv4mgobkz@krdjtokzz4xg>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
 <4a1b69d2-df29-4204-91fd-bb00b52350db@linux.dev>
 <e7aa1221-040e-4806-a259-56718844897f@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7aa1221-040e-4806-a259-56718844897f@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 05:50:22PM +0800, Qi Zheng wrote:
> 
> 
> On 1/16/26 5:43 PM, Muchun Song wrote:
> > 
> > 
> > On 2026/1/14 19:32, Qi Zheng wrote:
> > > From: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > The following diagram illustrates how to ensure the safety of the folio
> > > lruvec lock when LRU folios undergo reparenting.
> > > 
> > > In the folio_lruvec_lock(folio) function:
> > > ```
> > >      rcu_read_lock();
> > > retry:
> > >      lruvec = folio_lruvec(folio);
> > >      /* There is a possibility of folio reparenting at this point. */
> > >      spin_lock(&lruvec->lru_lock);
> > >      if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > >          /*
> > >           * The wrong lruvec lock was acquired, and a retry is required.
> > >           * This is because the folio resides on the parent memcg lruvec
> > >           * list.
> > >           */
> > >          spin_unlock(&lruvec->lru_lock);
> > >          goto retry;
> > >      }
> > > 
> > >      /* Reaching here indicates that folio_memcg() is stable. */
> > > ```
> > > 
> > > In the memcg_reparent_objcgs(memcg) function:
> > > ```
> > >      spin_lock(&lruvec->lru_lock);
> > >      spin_lock(&lruvec_parent->lru_lock);
> > >      /* Transfer folios from the lruvec list to the parent's. */
> > >      spin_unlock(&lruvec_parent->lru_lock);
> > >      spin_unlock(&lruvec->lru_lock);
> > > ```
> > > 
> > > After acquiring the lruvec lock, it is necessary to verify whether
> > > the folio has been reparented. If reparenting has occurred, the new
> > > lruvec lock must be reacquired. During the LRU folio reparenting
> > > process, the lruvec lock will also be acquired (this will be
> > > implemented in a subsequent patch). Therefore, folio_memcg() remains
> > > unchanged while the lruvec lock is held.
> > > 
> > > Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
> > > after the lruvec lock is acquired, the lruvec_memcg_debug() check is
> > > redundant. Hence, it is removed.
> > > 
> > > This patch serves as a preparation for the reparenting of LRU folios.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >   include/linux/memcontrol.h | 45 +++++++++++++++++++----------
> > >   include/linux/swap.h       |  1 +
> > >   mm/compaction.c            | 29 +++++++++++++++----
> > >   mm/memcontrol.c            | 59 +++++++++++++++++++++-----------------
> > >   mm/swap.c                  |  4 +++
> > >   5 files changed, 91 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 4b6f20dc694ba..26c3c0e375f58 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -742,7 +742,15 @@ static inline struct lruvec
> > > *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> > >    * folio_lruvec - return lruvec for isolating/putting an LRU folio
> > >    * @folio: Pointer to the folio.
> > >    *
> > > - * This function relies on folio->mem_cgroup being stable.
> > > + * Call with rcu_read_lock() held to ensure the lifetime of the
> > > returned lruvec.
> > > + * Note that this alone will NOT guarantee the stability of the
> > > folio->lruvec
> > > + * association; the folio can be reparented to an ancestor if this
> > > races with
> > > + * cgroup deletion.
> > > + *
> > > + * Use folio_lruvec_lock() to ensure both lifetime and stability of
> > > the binding.
> > > + * Once a lruvec is locked, folio_lruvec() can be called on other
> > > folios, and
> > > + * their binding is stable if the returned lruvec matches the one
> > > the caller has
> > > + * locked. Useful for lock batching.
> > >    */
> > >   static inline struct lruvec *folio_lruvec(struct folio *folio)
> > >   {
> > > @@ -761,18 +769,15 @@ struct mem_cgroup
> > > *get_mem_cgroup_from_current(void);
> > >   struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio);
> > >   struct lruvec *folio_lruvec_lock(struct folio *folio);
> > > +    __acquires(&lruvec->lru_lock)
> > > +    __acquires(rcu)
> > >   struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
> > > +    __acquires(&lruvec->lru_lock)
> > > +    __acquires(rcu)
> > >   struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
> > >                           unsigned long *flags);
> > > -
> > > -#ifdef CONFIG_DEBUG_VM
> > > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio);
> > > -#else
> > > -static inline
> > > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > -{
> > > -}
> > > -#endif
> > > +    __acquires(&lruvec->lru_lock)
> > > +    __acquires(rcu)
> > >   static inline
> > >   struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state
> > > *css){
> > > @@ -1199,11 +1204,6 @@ static inline struct lruvec
> > > *folio_lruvec(struct folio *folio)
> > >       return &pgdat->__lruvec;
> > >   }
> > > -static inline
> > > -void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > -{
> > > -}
> > > -
> > >   static inline struct mem_cgroup *parent_mem_cgroup(struct
> > > mem_cgroup *memcg)
> > >   {
> > >       return NULL;
> > > @@ -1262,6 +1262,7 @@ static inline struct lruvec
> > > *folio_lruvec_lock(struct folio *folio)
> > >   {
> > >       struct pglist_data *pgdat = folio_pgdat(folio);
> > > +    rcu_read_lock();
> > >       spin_lock(&pgdat->__lruvec.lru_lock);
> > >       return &pgdat->__lruvec;
> > >   }
> > > @@ -1270,6 +1271,7 @@ static inline struct lruvec
> > > *folio_lruvec_lock_irq(struct folio *folio)
> > >   {
> > >       struct pglist_data *pgdat = folio_pgdat(folio);
> > > +    rcu_read_lock();
> > >       spin_lock_irq(&pgdat->__lruvec.lru_lock);
> > >       return &pgdat->__lruvec;
> > >   }
> > > @@ -1279,6 +1281,7 @@ static inline struct lruvec
> > > *folio_lruvec_lock_irqsave(struct folio *folio,
> > >   {
> > >       struct pglist_data *pgdat = folio_pgdat(folio);
> > > +    rcu_read_lock();
> > >       spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);
> > >       return &pgdat->__lruvec;
> > >   }
> > > @@ -1500,24 +1503,36 @@ static inline struct lruvec
> > > *parent_lruvec(struct lruvec *lruvec)
> > >   }
> > >   static inline void lruvec_lock_irq(struct lruvec *lruvec)
> > > +    __acquires(&lruvec->lru_lock)
> > > +    __acquires(rcu)
> > 
> > It seems that functions marked as `inline` cannot be decorated with
> > `__acquires`? We’ve had to move these little helpers into `memcontrol.c`
> > and declare them as extern, but they’re so short that it hardly feels
> 
> Right, I received a compilation error reported LKP:
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from crypto/ahash.c:26:
>    In file included from include/net/netlink.h:6:
>    In file included from include/linux/netlink.h:9:
>    In file included from include/net/scm.h:9:
>    In file included from include/linux/security.h:35:
>    In file included from include/linux/bpf.h:32:
> >> include/linux/memcontrol.h:772:14: error: use of undeclared identifier
> 'lruvec'
>      772 |         __acquires(&lruvec->lru_lock)
>          |                     ^~~~~~
>    include/linux/memcontrol.h:773:13: error: use of undeclared identifier
> 'rcu'
>      773 |         __acquires(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:775:14: error: use of undeclared identifier
> 'lruvec'
>      775 |         __acquires(&lruvec->lru_lock)
>          |                     ^~~~~~
>    include/linux/memcontrol.h:776:13: error: use of undeclared identifier
> 'rcu'
>      776 |         __acquires(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:779:14: error: use of undeclared identifier
> 'lruvec'
>      779 |         __acquires(&lruvec->lru_lock)
>          |                     ^~~~~~
>    include/linux/memcontrol.h:780:13: error: use of undeclared identifier
> 'rcu'
>      780 |         __acquires(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:1507:13: error: use of undeclared identifier
> 'rcu'
>     1507 |         __acquires(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:1515:13: error: use of undeclared identifier
> 'rcu'
>     1515 |         __releases(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:1523:13: error: use of undeclared identifier
> 'rcu'
>     1523 |         __releases(rcu)
>          |                    ^~~
>    include/linux/memcontrol.h:1532:13: error: use of undeclared identifier
> 'rcu'
>     1532 |         __releases(rcu)
> 
> And I reproduced this error with the following configuration:
> 
> 1. enable CONFIG_WARN_CONTEXT_ANALYSIS_ALL
> 2. make CC=clang bzImage (clang version >= 22)
> 
> > worth the trouble. My own inclination is to drop the `__acquires`
> > annotations—mainly for performance reasons.
> 
> If no one else objects, I will drop __acquires/__releases in the next
> version.
> 

If you drop these annotations from header file and keep in the C file,
do you still get the compilation error?


