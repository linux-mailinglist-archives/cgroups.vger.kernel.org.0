Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3A1CDE1F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgEKPHI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKPHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 11:07:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F17C061A0C
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 08:07:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so10017582qke.13
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ANAit2WX+K9wu4n6he8ngZbFdqawZzoQDVcmzxgA7go=;
        b=vFO25KpXwg/4vtW8tD+XIfm9LH46+fQ6vvusO0tJeYwSNeBknXcUE5831e2qvIbxNB
         +vEmtna2uZpKf+W/kuG3dxSgsESJKBqc4IhSu+vI0v1ulFrcCqAfkILo2N91JoiKJ1VS
         IeKrygvNCP9TwKSM4nZZV+6aUOr9YP4M9uU2NnO214vrmh+gcV3XI6IYat+zBLyslXuz
         qBTXHi14HEys8m8tByH7DOimgJvM9+KyoJhvhLRU6cUdxDSd9pfqwDB/NC1bpgSTNoHb
         q4xx6h6LAXEjkdPchQEnaYQXvlQK/oG/0FN9w9FLsVDpbYuXFot5iHbtHU6WrxwDv07O
         REGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ANAit2WX+K9wu4n6he8ngZbFdqawZzoQDVcmzxgA7go=;
        b=mkDbFzlT0n6jDTvqPE6oOkwxKU+ADWkKEy7Eo6t/3B89hUgJMQEqaIZ+4wkPol+pBv
         WtNzYP6z3Z9VC7pH7C7eFW8mCj6VV94B4/RBcBMFRj5dKLERY9S7URvqEhJz7MLmcon1
         ciafWuOE3mzSSvUPsMCS02kg2D3y5xOq5SiEnMF71dThVlJQWOlIucXpUSsfG92Lb8Ht
         xv4IehySPZw2CafilGBpkUYn6n1j5fbBqp7gn3etAJ4JSJKPzwCM6hXLpgEWT2HLTGf6
         pMwShL5peAzY1wWP3bfKO5YZcMbfFxj1rWiTTfXtldm2fGlXMv+T4EiKX2uWxGjtcDUJ
         +IhA==
X-Gm-Message-State: AGi0PubkxYNKZ1aN4nkWuQplpp7nndSCCfxH6uImdMEY3IZs+WzJeXtH
        PNMYnz6VKZr5Q9t6vxBl3cCVvw==
X-Google-Smtp-Source: APiQypI3zax9mzs3ycZgpcHPMyHsq5/Hz/R3+ZSCs3htkIuCuIQ6i4eEs5zbW+/YH57wPpBL6Xadpg==
X-Received: by 2002:a37:9344:: with SMTP id v65mr14585673qkd.366.1589209627242;
        Mon, 11 May 2020 08:07:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id l22sm8360550qki.45.2020.05.11.08.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:07:06 -0700 (PDT)
Date:   Mon, 11 May 2020 11:06:48 -0400
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
Message-ID: <20200511150648.GA306292@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-6-hannes@cmpxchg.org>
 <20200422064041.GE6780@js1304-desktop>
 <20200422120946.GA358439@cmpxchg.org>
 <20200423052450.GA12538@js1304-desktop>
 <20200508160122.GB181181@cmpxchg.org>
 <alpine.LSU.2.11.2005102350360.2769@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005102350360.2769@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 11, 2020 at 12:38:04AM -0700, Hugh Dickins wrote:
> On Fri, 8 May 2020, Johannes Weiner wrote:
> > 
> > I looked at this some more, as well as compared it to non-shmem
> > swapping. My conclusion is - and Hugh may correct me on this - that
> > the deletion looks mandatory but is actually an optimization. Page
> > reclaim will ultimately pick these pages up.
> > 
> > When non-shmem pages are swapped in by readahead (locked until IO
> > completes) and their page tables are simultaneously unmapped, the
> > zap_pte_range() code calls free_swap_and_cache() and the locked pages
> > are stranded in the swap cache with no page table references. We rely
> > on page reclaim to pick them up later on.
> > 
> > The same appears to be true for shmem. If the references to the swap
> > page are zapped while we're trying to swap in, we can strand the page
> > in the swap cache. But it's not up to swapin to detect this reliably,
> > it just frees the page more quickly than having to wait for reclaim.
> 
> I think you've got all that exactly right, thanks for working it out.
> It originates from v3.7's 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp()
> VM_BUG_ON") - in which I also had to thank you.

I should have looked where it actually came from - I had forgotten
about that patch!

> I think I chose to do the delete_from_swap_cache() right there, partly
> because of following shmem_unuse_inode() code which already did that,
> partly on the basis that while we have to observe the case then it's
> better to clean it up, and partly out of guilt that our page lock here
> is what had prevented shmem_undo_range() from completing its job; but
> I believe you're right that unused swapcache reclaim would sort it out
> eventually.

That makes sense to me.

> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index e80167927dce..236642775f89 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -640,7 +640,7 @@ static int shmem_add_to_page_cache(struct page *page,
> >  		xas_lock_irq(&xas);
> >  		entry = xas_find_conflict(&xas);
> >  		if (entry != expected)
> > -			xas_set_err(&xas, -EEXIST);
> > +			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
> 
> Two things on this.
> 
> Minor matter of taste, I'd prefer that as
> 			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
> which would be more general and more understandable -
> but what you have written should be fine for the actual callers.

Yes, checking `expected' was to differentiate the behavior depending
on the callsite. But testing `entry' is more obvious in that location.

> Except... I think returning -ENOENT there will not work correctly,
> in the case of a punched hole.  Because (unless you've reworked it
> and I just haven't looked) shmem_getpage_gfp() knows to retry in
> the case of -EEXIST, but -ENOENT will percolate up to shmem_fault()
> and result in a SIGBUS, or a read/write error, when the hole should
> just get refilled instead.

Good catch, I had indeed missed that. I'm going to make it retry on
-ENOENT as well.

We could have it go directly to allocating a new page, but it seems
unnecessarily complicated: we've already been retrying in this
situation until now, so I would stick to "there was a race, retry."

> Not something that needs fixing in a hurry (it took trinity to
> generate this racy case in the first place), I'll take another look
> once I've pulled it into a tree (or collected next mmotm) - unless
> you've already have changed it around by then.

Attaching a delta fix based on your observations.

Andrew, barring any objections to this, could you please fold it into
the version you have in your tree already?

---

From 33d03ceebce0a6261d472ddc9c5a07940f44714c Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 11 May 2020 10:45:14 -0400
Subject: [PATCH] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API fix

Incorporate Hugh's feedback:

- shmem_getpage_gfp() needs to handle the new -ENOENT that was
  previously implied in the -EEXIST when a swap entry changed under us
  in any way. Otherwise hole punching could cause a racing fault to
  SIGBUS instead of allocating a new page.

- It is indeed page reclaim that picks up any swapcache we leave
  stranded when free_swap_and_cache() runs on a page locked by
  somebody else. Document that our delete_from_swap_cache() is an
  optimization, not something we rely on for correctness.

- Style cleanup: testing `expected' to decide on -EEXIST vs -ENOENT
  differentiates the callsites, but is a bit awkward to read. Test
  `entry' instead.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/shmem.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index afd5a057ebb7..00fb001e8f3e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -638,7 +638,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		xas_lock_irq(&xas);
 		entry = xas_find_conflict(&xas);
 		if (entry != expected)
-			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
+			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
@@ -1686,10 +1686,13 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 		 * We already confirmed swap under page lock, but
 		 * free_swap_and_cache() only trylocks a page, so it
 		 * is just possible that the entry has been truncated
-		 * or holepunched since swap was confirmed.
-		 * shmem_undo_range() will have done some of the
-		 * unaccounting, now delete_from_swap_cache() will do
-		 * the rest.
+		 * or holepunched since swap was confirmed. This could
+		 * occur at any time while the page is locked, and
+		 * usually page reclaim will take care of the stranded
+		 * swapcache page. But when we catch it, we may as
+		 * well clean up after ourselves: shmem_undo_range()
+		 * will have done some of the unaccounting, now
+		 * delete_from_swap_cache() will do the rest.
 		 */
 		if (error == -ENOENT)
 			delete_from_swap_cache(page);
@@ -1765,7 +1768,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	if (xa_is_value(page)) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
-		if (error == -EEXIST)
+		if (error == -EEXIST || error == -ENOENT)
 			goto repeat;
 
 		*pagep = page;
-- 
2.26.2
