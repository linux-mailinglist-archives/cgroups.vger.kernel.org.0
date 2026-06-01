Return-Path: <cgroups+bounces-16519-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGSwBKGnHWpbcwkAu9opvQ
	(envelope-from <cgroups+bounces-16519-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 17:39:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1706621E2C
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 081D73017083
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B863D9DCE;
	Mon,  1 Jun 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KHtpwLhT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B23ACF1C
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328334; cv=none; b=CxnnfbP3ZJzdimqvCIUvX+64F2XEfVDo4f0B/rW5pEyFpLWDrJZzM3PGCZdLVjHiu3jTmkhh/Atp/neJkS+CkP/MNJxUkpLgV33mXSKacnKp27gXppAm8ao/r/kDtmRgZV70Vku/iQtTfzbo+NDiXxLt7uV4KpjhBZ/BHgguoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328334; c=relaxed/simple;
	bh=iBbS5lja0sbeETMOaKlsd7M5FVxb318IBkWtQFKQoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtb561pRtO8Xhaf1NxuF9P7uFP2UsOKOmcpaL8mcyVQdS8eFZlUtQ64OJTNqkUhoWQ6MT89o5QqaGf7Aq1scWIus0IFXgfHUBZkvaHi+ZmRw+af7cFfIVwYEdNr1ooU8Ywg9ATAqJdxwMP3Hg8BZRzf6ZchimidvMyyRR4D3P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KHtpwLhT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Jun 2026 08:38:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780328317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z6l1eP+ZdCcfkpO0TKMaBFbF5X2F+vxzdUXR8PskAc=;
	b=KHtpwLhTvVrqtHqDyiaV9jYA6yFgTEe8LfzAu3vB+kBo3qWS47wIzxAITvaeLCYDxh18aZ
	vUX4AMePlF0+sHW5KZYD41NSW3FAnYcGJkL/OOj2zn3tW5vHVa9vH+TRqUFzpj+ZnE7KSz
	4WrRn2cKiwrT3Ajkn8/cUzIFn5QU/xE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Dave Chinner <david@fromorbit.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] mm/list_lru: drain before clearing xarray entry on
 reparent
Message-ID: <ah2VXGfGZOOdjhs3@linux.dev>
References: <20260601063408.2879011-1-shakeel.butt@linux.dev>
 <79CD986A-2130-4FB8-804F-A543AF22342B@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79CD986A-2130-4FB8-804F-A543AF22342B@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16519-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Queue-Id: F1706621E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muchun, thanks for taking a look.

On Mon, Jun 01, 2026 at 05:54:01PM +0800, Muchun Song wrote:
> 
> 
> > On Jun 1, 2026, at 14:34, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
> > xas_store(&xas, NULL) before reparenting its per-node lists into the
> > parent. This opens a window where a concurrent list_lru_del() arriving
> > for the dying memcg sees xa_load() == NULL, walks to the parent in
> > lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
> > list_del_init() on an item still physically linked on the dying
> > memcg's list.
> > 
> > If another in-flight thread holds the dying memcg's per-node lock at
> > the same moment (another list_lru_del, or a list_lru_walk_one running
> > an isolate callback), both threads modify ->next/->prev pointers on the
> > same physical list under different locks. Adjacent items can corrupt
> > each other's links.
> > 
> > Fix it by reversing the order: reparent each per-node list and mark the
> > child's list lru dead and then clear the xarray entry. Any concurrent
> > list_lru op that finds the still-set xarray entry either takes the dying
> > memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
> > and walks to the parent, where the items now live.
> > 
> > Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reported-by: Chris Mason <clm@fb.com>
> > ---
> > mm/list_lru.c | 20 +++++++++-----------
> > 1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index dd29bcf8eb5f..ae55a52307db 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -473,26 +473,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
> > 	mutex_lock(&list_lrus_mutex);
> > 	list_for_each_entry(lru, &memcg_list_lrus, list) {
> > 		struct list_lru_memcg *mlru;
> > - 		XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
> > 
> > - 		/*
> > -		 * Lock the Xarray to ensure no on going list_lru_memcg
> > -		 * allocation and further allocation will see css_is_dying().
> > -		 */
> > - 		xas_lock_irq(&xas);
> > - 		mlru = xas_store(&xas, NULL);
> > - 		xas_unlock_irq(&xas);
> > + 		mlru = xa_load(&lru->xa, memcg->kmemcg_id);
> > 		if (!mlru)
> > 			continue;
> 
> Is it possible that concurrent threads running memcg_list_lru_alloc() could
> allocate a new mlru after this check passes? This could happen because the
> threads haven't noticed css_is_dying() yet. We would consequently miss the
> reparent operation for this list. So xas_lock_irq is necessary to serialize
> CSS_DYING setting here. Right?

Good question and it seems like Sashiko [1] raised a similar concern. However
please note that memcg_list_lru_alloc() uses CSS_DYING when it allocate a new
mlru but memcg_reparent_list_lrus() is called from offlice_css() callback and
the given css should already have CSS_DYING before calling offline_css(). There
is a rcu grace period between setting CSS_DYING and calling offline_css().

[1] https://sashiko.dev/#/patchset/20260601063408.2879011-1-shakeel.butt%40linux.dev

> 
> Thanks.
> Muchun
> 
> > 
> > 		/*
> > -		 * With Xarray value set to NULL, holding the lru lock below
> > -		 * prevents list_lru_{add,del,isolate} from touching the lru,
> > -		 * safe to reparent.
> > +		 * Reparent each per-node list and mark the child dead
> > +		 * (LONG_MIN) before clearing xarray entry otherwisw a
> > +		 * concurrent list_lru_del() may corrupt the list if it arrives
> > +		 * after xarray clear but before reparenting as
> > +		 * lock_list_lru_of_memcg will acquire parent's lock while the
> > +		 * item is still on child's list.
> > 		 */
> > 		for_each_node(i)
> > 			memcg_reparent_list_lru_one(lru, i, &mlru->node[i], parent);
> > 
> > + 		xa_erase(&lru->xa, memcg->kmemcg_id);

This one is more tricky. Sashiko said:

" Is it safe to use xa_erase() here instead of xa_erase_irq()?

The list_lru xarray is initialized with XA_FLAGS_LOCK_IRQ, and elements are
added holding the lock via xas_lock_irqsave(), which establishes an IRQ-safe
lock class.

Since xa_erase() internally calls spin_lock() without disabling local
interrupts, an interrupt firing while the lock is held could attempt to
re-acquire the same lock in __memcg_list_lru_alloc(), leading to a deadlock.

This could also trigger a lockdep warning for an inconsistent lock state. "

Initially I though this is a false positive as I couldn't find irq callers for
kmem_cache_alloc_lru() but then claude came up with more concrete scenario which
is below:

"""
For the shadow_nodes lru this lock is also acquired nested under the page
cache i_pages lock, which is irq-safe.  Adding a folio holds i_pages and
then allocates an xarray node through the shadow_nodes lru:

__filemap_add_folio()
  mapping_set_update(&xas, mapping)     // xas->xa_lru = &shadow_nodes
  xas_lock_irq(&xas)                    // holds mapping->i_pages
  xas_store() -> xas_alloc()
    kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp)
      memcg_list_lru_alloc(memcg, &shadow_nodes, gfp)
        xas_lock_irqsave(&shadow_nodes->xa)   // shadow_nodes->xa under i_pages

and i_pages is taken from writeback completion in irq context:

__folio_end_writeback()
        xa_lock_irqsave(&mapping->i_pages, flags);

So with xa_erase() taking shadow_nodes->xa with irqs enabled:

CPU0 memcg_reparent_list_lrus()    CPU1 __filemap_add_folio()
  xa_erase(&shadow_nodes->xa)
    xa_lock(&shadow_nodes->xa)
                                   xas_lock_irq(&i_pages)  // holds i_pages
                                   ... memcg_list_lru_alloc()
                                     xas_lock_irqsave(&shadow_nodes->xa) // waits
  <io completion irq on CPU0>
  __folio_end_writeback()
    xa_lock_irqsave(&i_pages)  // waits

Can this deadlock, and should this be xa_erase_irq() to keep the irq-safe
acquisition that the removed xas_lock_irq() had?
"""

This seems more plausible and I think simply using xa_erase_irq() is more safe.

I will send a v2 with this change.

