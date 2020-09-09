Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D369263392
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgIIRGV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 13:06:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46562 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729692AbgIIPle (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 11:41:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0U8QWZfN_1599664177;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8QWZfN_1599664177)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Sep 2020 23:09:38 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
Date:   Wed, 9 Sep 2020 23:08:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hugh,

Thanks a lot for so rich review and comments!

ÔÚ 2020/9/9 ÉÏÎç7:41, Hugh Dickins Ð´µÀ:
> Miscellaneous Acks and NAKs and other comments on the beginning and
> the end of the series, but not much yet on the all-important middle.
> I'm hoping to be spared sending ~20 email replies to ~20 patches.
> 
> [PATCH v18 01/32] mm/memcg: warning on !memcg after readahead page charged
> Acked-by: Hugh Dickins <hughd@google.com>
> if you make these changes:
> 
> Please add "Add VM_WARN_ON_ONCE_PAGE() macro." or something like that to
> the commit message: that's a good addition that we shall find useful in
> other places, so please advertise it.

Accepted!

> 
> Delete the four comment lines
> /* Readahead page is charged too, to see if other page uncharged */
> which make no sense on their own.
> 

Accepted!
> [PATCH v18 02/32] mm/memcg: bail out early from swap accounting when memcg is disabled
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> [PATCH v18 03/32] mm/thp: move lru_add_page_tail func to huge_memory.c
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> [PATCH v18 04/32] mm/thp: clean up lru_add_page_tail
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Though I'd prefer "mm/thp: use head for head page in lru_add_page_tail"
> to the unnecessarily vague "clean up".  But you're right to keep this
> renaming separate from the code movement in the previous commit, and
> perhaps right to keep it from the more interesting cleanup next.
> 
> [PATCH v18 05/32] mm/thp: remove code path which never got into
> This is a good simplification, but I see no sign that you understand
> why it's valid: it relies on lru_add_page_tail() being called while
> head refcount is frozen to 0: we would not get this far if someone
> else holds a reference to the THP - which they must hold if they have
> isolated the page from its lru (and that's true before or after your
> per-memcg changes - but even truer after those changes, since PageLRU
> can then be flipped without lru_lock at any instant): please explain
> something of this in the commit message.

Is the following commit log better?

    split_huge_page() will never call on a page which isn't on lru list, so
    this code never got a chance to run, and should not be run, to add tail
    pages on a lru list which head page isn't there.

    Hugh Dickins' mentioned:
    The path should never be called since lru_add_page_tail() being called
    while head refcount is frozen to 0: we would not get this far if someone
    else holds a reference to the THP - which they must hold if they have
    isolated the page from its lru.

    Although the bug was never triggered, it'better be removed for code
    correctness, and add a warn for unexpected calling.

> 
> You revisit this same code in 18/32, and I much prefer the way it looks
> after that (if (list) {} else {}) - this 05/32 is a bit weird, it would
> be easier to understand if it just did VM_WARN_ON(1).  Please pull the
> 18/32 mods back into this one, maybe adding a VM_WARN_ON(PageLRU) into
> the "if (list)" block too.

Accepted.
> 
> [PATCH v18 18/32] mm/thp: add tail pages into lru anyway in split_huge_page()
> Please merge into 05/32.
> But what do "Split_huge_page() must start with
> PageLRU(head)" and "Split start from PageLRU(head)" mean? Perhaps you mean
> that if list is NULL, then if the head was not on the LRU, then it cannot
> have got through page_ref_freeze(), because isolator would hold page ref?

No, what I mean is only PageLRU(head) could be called and get here. Would you
like to give a suggestion to replace old one?


> That is subtle, and deserves mention in the commit comment, but is not
> what you have said at all.  s/unexpected/unexpectedly/.

Thanks!
> 
> [PATCH v18 06/32] mm/thp: narrow lru locking
> Why? What part does this play in the series? "narrow lru locking" can
> also be described as "widen page cache locking": 

Uh, the page cache locking isn't widen, it's still on the old place.

> you are changing the
> lock ordering, and not giving any reason to do so. This may be an
> excellent change, or it may be a terrible change: I find that usually
> lock ordering is forced upon us, and it's rare to meet an instance like
> this that could go either way, and I don't know myself how to judge it.
> 
> I do want this commit to go in, partly because it has been present in
> all the testing we have done, and partly because I *can at last* see a
> logical advantage to it - it also nests lru_lock inside memcg->move_lock,

I must overlook sth on the lock nest. Would you like to reveal it for me?
Thanks!

> allowing lock_page_memcg() to be used to stabilize page->mem_cgroup when
> getting per-memcg lru_lock - though only in one place, starting in v17,
> do you actually use that (and, warning: it's not used correctly there).
> 
> I'm not very bothered by how the local_irq_disable() looks to RT: THP
> seems a very bad idea in an RT kernel.  Earlier I asked you to run this
> past Kirill and Matthew and Johannes: you did so, thank you, and Kirill
> has blessed it, and no one has nacked it, and I have not noticed any
> disadvantage from this change in lock ordering (documented in 23/32),
> so I'm now going to say
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> But I wish you could give some reason for it in the commit message!

It's a head scratch task. Would you like to tell me what's detailed info 
should be there? Thanks!
 
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Is that correct? Or Wei Yang suggested some part of it perhaps?

Yes, we talked a lot to confirm the locking change is safe.

> 
> [PATCH v18 07/32] mm/swap.c: stop deactivate_file_page if page not on lru
> Perhaps; or perhaps by the time the pagevec is full, the page has been
> drained to the lru, and it should be deactivated? I'm indifferent.
> Is this important for per-memcg lru_lock?

It's no much related with theme, so I'm fine to remove it.

> 
> [PATCH v18 08/32] mm/vmscan: remove unnecessary lruvec adding
> You are optimizing for a case which you then mark unlikely(), and I
> don't agree that it makes the flow clearer; but you've added a useful
> comment on the race there, so please s/intergrity/integrity/ in commit

thanks for fixing.
> message and in code comment, then
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> [PATCH v18 09/32] mm/page_idle: no unlikely double check for idle page counting
> I strongly approve of removing the abuse of lru_lock here, but the
> patch is wrong: you are mistaken in thinking the PageLRU check after
> get_page_unless_zero() is an unnecessary duplicaton of the one before.
> No, the one before is an optimization, and the one after is essential,
> for telling whether this page (arrived at via pfn, like in compaction)
> is the kind of page we understand (address_space or anon_vma or KSM
> stable_node pointer in page->mapping), so can use rmap_walk() on.
> 
> Please replace this patch by mine from the tarball I posted a year ago,
> which keeps both checks, and justifies it against why the lru_lock was
> put there in the first place - thanks to Vladimir for pointing me to
> that mail thread when I tried to submit this patch a few years ago.
> Appended at the end of this mail.

You are right. thanks!
>        
> [PATCH v18 10/32] mm/compaction: rename compact_deferred as compact_should_defer
> I'm indifferent: I see your point about the name, but it hasn't caused
> confusion in ten years, whereas changing name and tracepoint might cause
> confusion.  And how does changing the name help per-memcg lru_lock?  It
> just seems to be a random patch from your private tree.  If it's Acked
> by Mel who coined the name, or someone who has done a lot of work there
> (Vlastimil? Joonsoo?), fine, I have no problem with it; but I don't
> see what it's doing in this series - better left out.

I will drop this patch.
> 
> [PATCH v18 11/32] mm/memcg: add debug checking in lock_page_memcg
> This is a very useful change for helping lockdep:
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> [PATCH v18 12/32] mm/memcg: optimize mem_cgroup_page_lruvec
> Hah, I see this is in my name.  Well, I did once suggest folding this
> into one of your patches, but it's not an optimization, and that was
> before you added VM_WARN_ON_ONCE_PAGE() here.  It looks strange now,
> a VM_BUG_ON_PAGE() next to a VM_WARN_ON_ONCE_PAGE(); and the latter
> will catch that PageTail case anyway (once).  And although I feel
> slightly safer with READ_ONCE(page->mem_cgroup), I'm finding it hard
> to justify, doing so here but not in other places: particularly since
> just above it says "This function relies on page->mem_cgroup being
> stable".  Let's just drop this patch.

Accepted. Thanks!
> 
> [PATCH v18 13/32] mm/swap.c: fold vm event PGROTATED into pagevec_move_tail_fn
> Yes, nice cleanup, I don't see why it should be different and force an
> unused arg on the others.  But I have one reservation: you added comment
> + *
> + * pagevec_move_tail_fn() must be called with IRQ disabled.
> + * Otherwise this may cause nasty races.
> above rotate_reclaimable_page(), having deleted pagevec_move_tail() which
> had such a comment. It doesn't make sense, because pagevec_move_tail_fn()
> is called with IRQ disabled anyway. That comment had better say
> + *
> + * rotate_reclaimable_page() must disable IRQs, to prevent nasty races.
> I dimly remember hitting those nasty races many years ago, but forget
> the details. Oh, one other thing, you like to use "func" as abbreviation
> for "function", okay: but then at the end of the commit message you say
> "no func change" - please change that to "No functional change".
> Acked-by: Hugh Dickins <hughd@google.com>
> 
Accepted. Thanks!

> [PATCH v18 14/32] mm/lru: move lru_lock holding in func lru_note_cost_page
> "w/o functional changes" instead of "w/o function changes".  But please
> just merge this into the next, 15/32: there is no point in separating them.
> 
> [PATCH v18 15/32] mm/lru: move lock into lru_note_cost
> [PATCH v18 16/32] mm/lru: introduce TestClearPageLRU
> [PATCH v18 17/32] mm/compaction: do page isolation first in compaction
> [PATCH v18 19/32] mm/swap.c: serialize memcg changes in pagevec_lru_move_fn
> [PATCH v18 20/32] mm/lru: replace pgdat lru_lock with lruvec lock
> [PATCH v18 21/32] mm/lru: introduce the relock_page_lruvec function
> [PATCH v18 22/32] mm/vmscan: use relock for move_pages_to_lru
> [PATCH v18 23/32] mm/lru: revise the comments of lru_lock
> [PATCH v18 24/32] mm/pgdat: remove pgdat lru_lock
> [PATCH v18 25/32] mm/mlock: remove lru_lock on TestClearPageMlocked in munlock_vma_page
> [PATCH v18 26/32] mm/mlock: remove __munlock_isolate_lru_page
> 
> I have tested, but not yet studied these, and it's a good point to break
> off and send my comments so far, because 15/32 is where the cleanups end
> and per-memcg lru_lock kind-of begins - lru_note_cost() being potentially
> more costly, because it needs to use a different lock at each level.
> (When I tried rebasing my own series a couple of months ago, I stopped
> here at lru_note_cost() too, wondering if there was a better way.)
> 
> Two things I do know about from testing, that need to be corrected:
> 
> check_move_unevictable_pages() needs protection from page->memcg
> being changed while doing the relock_page_lruvec_irq(): could use
> TestClearPageLRU there (!PageLRU pages are safely skipped), but
> that doubles the number of atomic ops involved. I intended to use
> lock_page_memcg() instead, but that's harder than you'd expect: so
> probably TestClearPageLRU will be the best to use there for now.

Accepted. Thanks!

> 
> The use of lock_page_memcg() in __munlock_pagevec() in 20/32,
> introduced in patchset v17, looks good but it isn't: I was lucky that
> systemd at reboot did some munlocking that exposed the problem to lockdep.
> The first time into the loop, lock_page_memcg() is done before lru_lock
> (as 06/32 has allowed); but the second time around the loop, it is done
> while still holding lru_lock.

I don't know the details of lockdep show. Just wondering could it possible 
to solid the move_lock/lru_lock sequence?
or try other blocking way which mentioned in commit_charge()?

> 
> lock_page_memcg() really needs to be absorbed into (a variant of)
> relock_page_lruvec(), and I do have that (it's awkward because of
> the different ways in which the IRQ flags are handled).  And out of
> curiosity, I've also tried using that in mm/swap.c too, instead of the
> TestClearPageLRU technique: lockdep is happy, but an update_lru_size()
> warning showed that it cannot safely be mixed with the TestClearPageLRU
> technique (that I'd left in isolate_lru_page()).  So I'll stash away
> that relock_page_lruvec(), and consider what's best for mm/mlock.c:
> now that I've posted these comments so far, that's my priority, then
> to get the result under testing again, before resuming these comments.

No idea of your solution, but looking forward for your good news! :)

> 
> Jumping over 15-26, and resuming comments on recent additions:
> 
> [PATCH v18 27/32] mm/swap.c: optimizing __pagevec_lru_add lru_lock
> Could we please drop this one for the moment? And come back to it later
> when the basic series is safely in.  It's a good idea to try sorting
> together those pages which come under the same lock (though my guess is
> that they naturally gather themselves together quite well already); but
> I'm not happy adding 360 bytes to the kernel stack here (and that in
> addition to 192 bytes of horrid pseudo-vma in the shmem swapin case),
> though that could be avoided by making it per-cpu. But I hope there's
> a simpler way of doing it, as efficient, but also useful for the other
> pagevec operations here: perhaps scanning the pagevec for same page->
> mem_cgroup (and flags node bits), NULLing entries as they are done.
> Another, easily fixed, minor defect in this patch: if I'm reading it
> right, it reverses the order in which the pages are put on the lru?

this patch could give about 10+% performance gain on my multiple memcg
readtwice testing. fairness locking cost the performance much.

I also tried per cpu solution but that cause much trouble of per cpu func
things, and looks no benefit except a bit struct size of stack, so if 
stack size still fine. May we could use the solution and improve it better.
like, functionlize, fix the reverse issue etc.
> 
> [PATCH v18 28/32] mm/compaction: Drop locked from isolate_migratepages_block
> Most of this consists of replacing "locked" by "lruvec", which is good:
> but please fold those changes back into 20/32 (or would it be 17/32?
> I've not yet looked into the relationship between those two), so we
> can then see more clearly what change this 28/32 (will need renaming!)
> actually makes, to use lruvec_holds_page_lru_lock(). That may be a
> good change, but it's mixed up with the "locked"->"lruvec" at present,
> and I think you could have just used lruvec for locked all along
> (but of course there's a place where you'll need new_lruvec too).

Uh, let me rethink about this. anyway the patch is logically different from
patch 20 since it's need a new function lruvec_holds_page_lru_lock.

> 
> [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
> NAK. I agree that isolate_migratepages_block() looks nicer this way, but
> take a look at prep_new_page() in mm/page_alloc.c: post_alloc_hook() is
> where set_page_refcounted() changes page->_refcount from 0 to 1, allowing
> a racing get_page_unless_zero() to succeed; then later prep_compound_page()
> is where PageHead and PageTails get set. So there's a small race window in
> which this patch could deliver a compound page when it should not.

will drop this patch.
> 
> [PATCH v18 30/32] mm: Drop use of test_and_set_skip in favor of just setting skip
> I haven't looked at this yet (but recall that per-memcg lru_lock can
> change the point at which compaction should skip a contended lock: IIRC
> the current kernel needs nothing extra, whereas some earlier kernels did
> need extra; but when I look at 30/32, may find these remarks irrelevant).

will wait for your further comments. :)
> 
> [PATCH v18 31/32] mm: Add explicit page decrement in exception path for isolate_lru_pages
> The title of this patch is definitely wrong: there was an explicit page
> decrement there before (put_page), now it's wrapping it up inside a
> WARN_ON().  We usually prefer to avoid doing functional operations
> inside WARN/BUGs, but I think I'll overlook that - anyone else worried?
> The comment is certainly better than what was there before: yes, this
> warning reflects the difficulty we have in thinking about the
> TestClearPageLRU protocol: which I'm still not sold on, but
> agree we should proceed with.  With a change in title, perhaps
> "mm: add warning where TestClearPageLRU failed on freeable page"?
> Acked-by: Hugh Dickins <hughd@google.com>
> 

Accepted, thanks

> [PATCH v18 32/32] mm: Split release_pages work into 3 passes
> I haven't looked at this yet (but seen no problem with it in testing).
> 
> And finally, here's my replacement (rediffed against 5.9-rc) for 
> [PATCH v18 09/32] mm/page_idle: no unlikely double check for idle page counting
> 
> From: Hugh Dickins <hughd@google.com>
> Date: Mon, 13 Jun 2016 19:43:34 -0700
> Subject: [PATCH] mm: page_idle_get_page() does not need lru_lock

accepted, thanks!

> 
> It is necessary for page_idle_get_page() to recheck PageLRU() after
> get_page_unless_zero(), but holding lru_lock around that serves no
> useful purpose, and adds to lru_lock contention: delete it.
> 
> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> discussion that led to lru_lock there; but __page_set_anon_rmap() now uses
> WRITE_ONCE(), and I see no other risk in page_idle_clear_pte_refs() using
> rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but not
> entirely prevented by page_count() check in ksm.c's write_protect_page():
> that risk being shared with page_referenced() and not helped by lru_lock).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> ---
>  mm/page_idle.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -32,19 +32,15 @@
>  static struct page *page_idle_get_page(unsigned long pfn)
>  {
>  	struct page *page = pfn_to_online_page(pfn);
> -	pg_data_t *pgdat;
>  
>  	if (!page || !PageLRU(page) ||
>  	    !get_page_unless_zero(page))
>  		return NULL;
>  
> -	pgdat = page_pgdat(page);
> -	spin_lock_irq(&pgdat->lru_lock);
>  	if (unlikely(!PageLRU(page))) {
>  		put_page(page);
>  		page = NULL;
>  	}
> -	spin_unlock_irq(&pgdat->lru_lock);
>  	return page;
>  }
>  
> 
