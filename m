Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717541CE24F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgEKSLQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKSLQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 14:11:16 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104DC061A0C
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:11:15 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so4583833qvw.5
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MI5GKMcoK4TviI3WF6z6u2HB9Cfoz7+kubiJIKPYUWE=;
        b=AEN8KkiYPYwfVSoQVqseYwpocY1TfVhiJYojiwk9th6YQc7qtPSkgavtSovEINxz+R
         0ECszgowJK/0/emZehvREB809fbDq2GbZI2obor9CmziGW7xJyuK/u8Oy6SI9NHsqLez
         Y8Gv5epSujXxBkLACxGUJOvgqGByBKB7fC0YdMOPR8+rcxcYRDrm8+FMAHJtwgS/3Y72
         pHR6CbIk9t8T52OraTDDW2Kz5xQVwpLpLNebFASCtJk1e0EitOX/Ttvg/gYW2AM7zuc3
         SjdsmY4O6mRhUFIHy6vZ9P46vi/szWL1zQkIM9zqmjnzdwCDCFFw6RuCsNGQw7DE2ZUo
         Am/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MI5GKMcoK4TviI3WF6z6u2HB9Cfoz7+kubiJIKPYUWE=;
        b=EWREH58iX0BCg7e1pRtXaTiZjLTE+ohmqiMUk1FQag+nHDxPbB4aJT3k1I4zee6TX+
         CWzdhJ0xBG1NbOlwJBiOYgGoAm0Q5g137WfM05Gh108kAlLorML8VZ3k+Uc1UBG2AwJq
         oIP6TsLg6XhXFq71oFMxEYPIR2N7zlx2vuysz2SrWsIePwwwJpmJCDmGOp/MObaeThsx
         YhPWZOWEEaGuom0Z/9e90NOLNWfmfkL3qdnNB/nL1yCr21nKDJOpPSJREKRZKw37zvqT
         UpCPo0JPhplPvKpxaKySoH4x97Z/j6qysR5pTy79Um4K+H4tYqZ62vIKoMQYhZp8Rt04
         UsSw==
X-Gm-Message-State: AGi0PuYyVwSfV9YdOJsNxKAqh85y5y+wN0gYpKmidCb/YQjhTAvcwlFn
        7mQwlVf5BYjD4HYlsPlxLBHbsjTFqYI=
X-Google-Smtp-Source: APiQypIiL+Uvt0D6OURk+1kUi0AqM95GOEbO8F+YGtSNongxrVNfdbTl+JkelH9PusUh3Sl6lWtpMg==
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr17187495qvl.34.1589220675020;
        Mon, 11 May 2020 11:11:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id d7sm8878948qkk.26.2020.05.11.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:11:14 -0700 (PDT)
Date:   Mon, 11 May 2020 14:10:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
Message-ID: <20200511181056.GA339505@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-6-hannes@cmpxchg.org>
 <20200422064041.GE6780@js1304-desktop>
 <20200422120946.GA358439@cmpxchg.org>
 <20200423052450.GA12538@js1304-desktop>
 <20200508160122.GB181181@cmpxchg.org>
 <alpine.LSU.2.11.2005102350360.2769@eggly.anvils>
 <20200511150648.GA306292@cmpxchg.org>
 <alpine.LSU.2.11.2005110912180.3431@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005110912180.3431@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 11, 2020 at 09:32:16AM -0700, Hugh Dickins wrote:
> On Mon, 11 May 2020, Johannes Weiner wrote:
> > On Mon, May 11, 2020 at 12:38:04AM -0700, Hugh Dickins wrote:
> > > On Fri, 8 May 2020, Johannes Weiner wrote:
> > > > 
> > > > I looked at this some more, as well as compared it to non-shmem
> > > > swapping. My conclusion is - and Hugh may correct me on this - that
> > > > the deletion looks mandatory but is actually an optimization. Page
> > > > reclaim will ultimately pick these pages up.
> > > > 
> > > > When non-shmem pages are swapped in by readahead (locked until IO
> > > > completes) and their page tables are simultaneously unmapped, the
> > > > zap_pte_range() code calls free_swap_and_cache() and the locked pages
> > > > are stranded in the swap cache with no page table references. We rely
> > > > on page reclaim to pick them up later on.
> > > > 
> > > > The same appears to be true for shmem. If the references to the swap
> > > > page are zapped while we're trying to swap in, we can strand the page
> > > > in the swap cache. But it's not up to swapin to detect this reliably,
> > > > it just frees the page more quickly than having to wait for reclaim.
> > > 
> > > I think you've got all that exactly right, thanks for working it out.
> > > It originates from v3.7's 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp()
> > > VM_BUG_ON") - in which I also had to thank you.
> > 
> > I should have looked where it actually came from - I had forgotten
> > about that patch!
> > 
> > > I think I chose to do the delete_from_swap_cache() right there, partly
> > > because of following shmem_unuse_inode() code which already did that,
> > > partly on the basis that while we have to observe the case then it's
> > > better to clean it up, and partly out of guilt that our page lock here
> > > is what had prevented shmem_undo_range() from completing its job; but
> > > I believe you're right that unused swapcache reclaim would sort it out
> > > eventually.
> > 
> > That makes sense to me.
> > 
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index e80167927dce..236642775f89 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -640,7 +640,7 @@ static int shmem_add_to_page_cache(struct page *page,
> > > >  		xas_lock_irq(&xas);
> > > >  		entry = xas_find_conflict(&xas);
> > > >  		if (entry != expected)
> > > > -			xas_set_err(&xas, -EEXIST);
> > > > +			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
> > > 
> > > Two things on this.
> > > 
> > > Minor matter of taste, I'd prefer that as
> > > 			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
> > > which would be more general and more understandable -
> > > but what you have written should be fine for the actual callers.
> > 
> > Yes, checking `expected' was to differentiate the behavior depending
> > on the callsite. But testing `entry' is more obvious in that location.
> > 
> > > Except... I think returning -ENOENT there will not work correctly,
> > > in the case of a punched hole.  Because (unless you've reworked it
> > > and I just haven't looked) shmem_getpage_gfp() knows to retry in
> > > the case of -EEXIST, but -ENOENT will percolate up to shmem_fault()
> > > and result in a SIGBUS, or a read/write error, when the hole should
> > > just get refilled instead.
> > 
> > Good catch, I had indeed missed that. I'm going to make it retry on
> > -ENOENT as well.
> > 
> > We could have it go directly to allocating a new page, but it seems
> > unnecessarily complicated: we've already been retrying in this
> > situation until now, so I would stick to "there was a race, retry."
> > 
> > > Not something that needs fixing in a hurry (it took trinity to
> > > generate this racy case in the first place), I'll take another look
> > > once I've pulled it into a tree (or collected next mmotm) - unless
> > > you've already have changed it around by then.
> > 
> > Attaching a delta fix based on your observations.
> > 
> > Andrew, barring any objections to this, could you please fold it into
> > the version you have in your tree already?
> 
> Not so strong as an objection, and I won't get to see whether your
> retry on -ENOENT is good (can -ENOENT arrive at that point from any
> other case, that might endlessly retry?) until I've got the full
> context; but I had arrived at the opposite conclusion overnight.
> 
> Given that this case only appeared with a fuzzer, and stale swapcache
> reclaim is anyway relied upon to clean up after plenty of other such
> races, I think we should agree that I over-complicated the VM_BUG_ON
> removal originally, and it's best to kill that delete_from_swap_cache(),
> and the comment having to explain it, and your EEXIST/ENOENT distinction.
> 
> (I haven't checked, but I suspect that the shmem_unuse_inode() case
> that I copied from, actually really needed to delete_from_swap_cache(),
> in order to swapoff the page without full retry of the big swapoff loop.)

Since commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity"),
shmem_unuse_inode() doesn't have its own copy anymore - it uses
shmem_swapin_page().

However, that commit appears to have made shmem's private call to
delete_from_swap_cache() obsolete as well. Whereas before this change
we fully relied on shmem_unuse() to find and clear a shmem swap entry
and its swapcache page, we now only need it to clean out shmem's
private state in the inode, as it's followed by a loop over all
remaining swap slots, calling try_to_free_swap() on stragglers.

Unless I missed something, it's still merely an optimization, and we
can delete it for simplicity:

---

From fc9dcaf68c8b54baf365cd670fb5780c7f0d243f Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 11 May 2020 12:59:08 -0400
Subject: [PATCH] mm: shmem: remove rare optimization when swapin races with
 hole punching

Commit 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp() VM_BUG_ON")
recognized that hole punching can race with swapin and removed the
BUG_ON() for a truncated entry from the swapin path.

The patch also added a swapcache deletion to optimize this rare case:
Since swapin has the page locked, and free_swap_and_cache() merely
trylocks, this situation can leave the page stranded in
swapcache. Usually, page reclaim picks up stale swapcache pages, and
the race can happen at any other time when the page is locked. (The
same happens for non-shmem swapin racing with page table zapping.) The
thinking here was: we already observed the race and we have the page
locked, we may as well do the cleanup instead of waiting for reclaim.

However, this optimization complicates the next patch which moves the
cgroup charging code around. As this is just a minor speedup for a
race condition that is so rare that it required a fuzzer to trigger
the original BUG_ON(), it's no longer worth the complications.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/shmem.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d505b6cce4ab..729bbb3513cd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1665,27 +1665,16 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	}
 
 	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
-	if (!error) {
-		error = shmem_add_to_page_cache(page, mapping, index,
-						swp_to_radix_entry(swap), gfp);
-		/*
-		 * We already confirmed swap under page lock, and make
-		 * no memory allocation here, so usually no possibility
-		 * of error; but free_swap_and_cache() only trylocks a
-		 * page, so it is just possible that the entry has been
-		 * truncated or holepunched since swap was confirmed.
-		 * shmem_undo_range() will have done some of the
-		 * unaccounting, now delete_from_swap_cache() will do
-		 * the rest.
-		 */
-		if (error) {
-			mem_cgroup_cancel_charge(page, memcg);
-			delete_from_swap_cache(page);
-		}
-	}
 	if (error)
 		goto failed;
 
+	error = shmem_add_to_page_cache(page, mapping, index,
+					swp_to_radix_entry(swap), gfp);
+	if (error) {
+		mem_cgroup_cancel_charge(page, memcg);
+		goto failed;
+	}
+
 	mem_cgroup_commit_charge(page, memcg, true);
 
 	spin_lock_irq(&info->lock);
-- 
2.26.2

