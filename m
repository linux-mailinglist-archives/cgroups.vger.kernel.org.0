Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D51CCFB9
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgEKC1l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 10 May 2020 22:27:41 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:50830 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgEKC1l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 10 May 2020 22:27:41 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2020 22:27:40 EDT
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 11 May 2020 10:57:38 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: iamjoonsoo.kim@lge.com
Received: from unknown (HELO localhost) (10.177.220.187)
        by 156.147.1.125 with ESMTP; 11 May 2020 10:57:38 +0900
X-Original-SENDERIP: 10.177.220.187
X-Original-MAILFROM: iamjoonsoo.kim@lge.com
Date:   Mon, 11 May 2020 10:57:32 +0900
From:   Joonsoo Kim <iamjoonsoo.kim@lge.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
Message-ID: <20200511015732.GA7749@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-6-hannes@cmpxchg.org>
 <20200422064041.GE6780@js1304-desktop>
 <20200422120946.GA358439@cmpxchg.org>
 <20200423052450.GA12538@js1304-desktop>
 <20200508160122.GB181181@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508160122.GB181181@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 12:01:22PM -0400, Johannes Weiner wrote:
> On Thu, Apr 23, 2020 at 02:25:06PM +0900, Joonsoo Kim wrote:
> > On Wed, Apr 22, 2020 at 08:09:46AM -0400, Johannes Weiner wrote:
> > > On Wed, Apr 22, 2020 at 03:40:41PM +0900, Joonsoo Kim wrote:
> > > > On Mon, Apr 20, 2020 at 06:11:13PM -0400, Johannes Weiner wrote:
> > > > > @@ -1664,29 +1678,22 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
> > > > >  			goto failed;
> > > > >  	}
> > > > >  
> > > > > -	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
> > > > > -	if (!error) {
> > > > > -		error = shmem_add_to_page_cache(page, mapping, index,
> > > > > -						swp_to_radix_entry(swap), gfp);
> > > > > -		/*
> > > > > -		 * We already confirmed swap under page lock, and make
> > > > > -		 * no memory allocation here, so usually no possibility
> > > > > -		 * of error; but free_swap_and_cache() only trylocks a
> > > > > -		 * page, so it is just possible that the entry has been
> > > > > -		 * truncated or holepunched since swap was confirmed.
> > > > > -		 * shmem_undo_range() will have done some of the
> > > > > -		 * unaccounting, now delete_from_swap_cache() will do
> > > > > -		 * the rest.
> > > > > -		 */
> > > > > -		if (error) {
> > > > > -			mem_cgroup_cancel_charge(page, memcg);
> > > > > -			delete_from_swap_cache(page);
> > > > > -		}
> > > > > -	}
> > > > > -	if (error)
> > > > > +	error = shmem_add_to_page_cache(page, mapping, index,
> > > > > +					swp_to_radix_entry(swap), gfp,
> > > > > +					charge_mm);
> > > > > +	/*
> > > > > +	 * We already confirmed swap under page lock, and make no
> > > > > +	 * memory allocation here, so usually no possibility of error;
> > > > > +	 * but free_swap_and_cache() only trylocks a page, so it is
> > > > > +	 * just possible that the entry has been truncated or
> > > > > +	 * holepunched since swap was confirmed.  shmem_undo_range()
> > > > > +	 * will have done some of the unaccounting, now
> > > > > +	 * delete_from_swap_cache() will do the rest.
> > > > > +	 */
> > > > > +	if (error) {
> > > > > +		delete_from_swap_cache(page);
> > > > >  		goto failed;
> > > > 
> > > > -EEXIST (from swap cache) and -ENOMEM (from memcg) should be handled
> > > > differently. delete_from_swap_cache() is for -EEXIST case.
> > > 
> > > Good catch, I accidentally changed things here.
> > > 
> > > I was just going to change it back, but now I'm trying to understand
> > > how it actually works.
> > > 
> > > Who is removing the page from swap cache if shmem_undo_range() races
> > > but we fail to charge the page?
> > > 
> > > Here is how this race is supposed to be handled: The page is in the
> > > swapcache, we have it locked and confirmed that the entry in i_pages
> > > is indeed a swap entry. We charge the page, then we try to replace the
> > > swap entry in i_pages with the actual page. If we determine, under
> > > tree lock now, that shmem_undo_range has raced with us, unaccounted
> > > the swap space, but must have failed to get the page lock, we remove
> > > the page from swap cache on our side, to free up swap slot and page.
> > > 
> > > But what if shmem_undo_range() raced with us, deleted the swap entry
> > > from i_pages while we had the page locked, but then we simply failed
> > > to charge? We unlock the page and return -EEXIST (shmem_confirm_swap
> > > at the exit). The page with its userdata is now in swapcache, but no
> > > corresponding swap entry in i_pages. shmem_getpage_gfp() sees the
> > > -EEXIST, retries, finds nothing in i_pages and allocates a new, empty
> > > page.
> > > 
> > > Aren't we leaking the swap slot and the page?
> > 
> > Yes, you're right! It seems that it's possible to leak the swap slot
> > and the page. Race could happen for all the places after lock_page()
> > and shmem_confirm_swap() are done. And, I think that it's not possible
> > to fix the problem in shmem_swapin_page() side since we can't know the
> > timing that trylock_page() is called. Maybe, solution would be,
> > instead of using free_swap_and_cache() in shmem_undo_range() that
> > calls trylock_page(), to use another function that calls lock_page().
> 
> I looked at this some more, as well as compared it to non-shmem
> swapping. My conclusion is - and Hugh may correct me on this - that
> the deletion looks mandatory but is actually an optimization. Page
> reclaim will ultimately pick these pages up.
> 
> When non-shmem pages are swapped in by readahead (locked until IO
> completes) and their page tables are simultaneously unmapped, the
> zap_pte_range() code calls free_swap_and_cache() and the locked pages
> are stranded in the swap cache with no page table references. We rely
> on page reclaim to pick them up later on.
> 
> The same appears to be true for shmem. If the references to the swap
> page are zapped while we're trying to swap in, we can strand the page
> in the swap cache. But it's not up to swapin to detect this reliably,
> it just frees the page more quickly than having to wait for reclaim.
> 
> That being said, my patch introduces potentially undesirable behavior
> (although AFAICS no correctness problem): We should only delete the
> page from swapcache when we actually raced with undo_range - which we
> see from the swap entry having been purged from the page cache
> tree. If we delete the page from swapcache just because we failed to
> charge it, the next fault has to read the still-valid page again from
> the swap device.

I got it! Thanks for explanation.

Thanks.

