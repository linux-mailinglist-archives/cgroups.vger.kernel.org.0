Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B935D267FC3
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMOYC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 10:24:02 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10013 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgIMOYB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 10:24:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0U8mvg-c_1600007034;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8mvg-c_1600007034)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Sep 2020 22:23:55 +0800
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
 <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009112216260.23961@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2fed13c0-1d78-fa92-b607-e997b1bc5fb2@linux.alibaba.com>
Date:   Sun, 13 Sep 2020 22:22:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009112216260.23961@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/9/12 下午4:38, Hugh Dickins 写道:
> On Wed, 9 Sep 2020, Alex Shi wrote:
>> 在 2020/9/9 上午7:41, Hugh Dickins 写道:
>>>
>>> The use of lock_page_memcg() in __munlock_pagevec() in 20/32,
>>> introduced in patchset v17, looks good but it isn't: I was lucky that
>>> systemd at reboot did some munlocking that exposed the problem to lockdep.
>>> The first time into the loop, lock_page_memcg() is done before lru_lock
>>> (as 06/32 has allowed); but the second time around the loop, it is done
>>> while still holding lru_lock.
>>
>> I don't know the details of lockdep show. Just wondering could it possible 
>> to solid the move_lock/lru_lock sequence?
>> or try other blocking way which mentioned in commit_charge()?
>>
>>>
>>> lock_page_memcg() really needs to be absorbed into (a variant of)
>>> relock_page_lruvec(), and I do have that (it's awkward because of
>>> the different ways in which the IRQ flags are handled).  And out of
>>> curiosity, I've also tried using that in mm/swap.c too, instead of the
>>> TestClearPageLRU technique: lockdep is happy, but an update_lru_size()
>>> warning showed that it cannot safely be mixed with the TestClearPageLRU
>>> technique (that I'd left in isolate_lru_page()).  So I'll stash away
>>> that relock_page_lruvec(), and consider what's best for mm/mlock.c:
>>> now that I've posted these comments so far, that's my priority, then
>>> to get the result under testing again, before resuming these comments.
>>
>> No idea of your solution, but looking forward for your good news! :)
> 
> Yes, it is good news, and simpler than anything suggested above.

Awesome!
> 
> The main difficulties will probably be to look good in the 80 columns
> (I know that limit has been lifted recently, but some of us use xterms
> side by side), and to explain it.
> 
> mm/mlock.c has not been kept up-to-date very well: and in particular,
> you have taken too seriously that "Serialize with any parallel
> __split_huge_page_refcount()..." comment that you updated to two
> comments "Serialize split tail pages in __split_huge_page_tail()...".
> 
> Delete them! The original comment was by Vlastimil for v3.14 in 2014.
> But Kirill redesigned THP refcounting for v4.5 in 2016: that's when
> __split_huge_page_refcount() went away.  And with the new refcounting,
> the THP splitting races that lru_lock protected munlock_vma_page()
> and __munlock_pagevec() from: those races have become impossible.
> 
> Or maybe there never was such a race in __munlock_pagevec(): you
> have added the comment there, assuming lru_lock was for that purpose,
> but that was probably just the convenient place to take it,
> to cover all the del_page_from_lru()s.
> 
> Observe how split_huge_page_to_list() uses unmap_page() to remove
> all pmds and all ptes for the huge page being split, and remap_page()
> only replaces the migration entries (used for anon but not for shmem
> or file) after doing all of the __split_huge_page_tail()s, before
> unlocking any of the pages.  Recall that munlock_vma_page() and
> __munlock_pagevec() are being applied to pages found mapped
> into userspace, by ptes or pmd: there are none of those while
> __split_huge_page_tail() is being used, so no race to protect from.
> 
> (Could a newly detached tail be freshly faulted into userspace just
> before __split_huge_page() has reached the head?  Not quite, the
> fault has to wait to get the tail's page lock. But even if it
> could, how would that be a problem for __munlock_pagevec()?)
> 
> There's lots more that could be said: for example, PageMlocked will
> always be clear on the THP head during __split_huge_page_tail(),
> because the last unmap of a PageMlocked page does clear_page_mlock().
> But that's not required to prove the case, it's just another argument
> against the "Serialize" comment you have in __munlock_pagevec().
> 
> So, no need for the problematic lock_page_memcg(page) there in
> __munlock_pagevec(), nor to lock (or relock) lruvec just below it.
> __munlock_pagevec() still needs lru_lock to del_page_from_lru_list(),
> of course, but that must be done after your TestClearPageMlocked has
> stabilized page->memcg.  Use relock_page_lruvec_irq() here?  I suppose
> that will be easiest, but notice how __munlock_pagevec_fill() has
> already made sure that all the pages in the pagevec are from the same
> zone (and it cannot do the same for memcg without locking page memcg);
> so some of relock's work will be redundant.

It sounds reasonable for me.

> 
> Otherwise, I'm much happier with your mm/mlock.c since looking at it
> in more detail: a couple of nits though - drop the clear_page_mlock()
> hunk from 25/32 - kernel style says do it the way you are undoing by
> -	if (!isolate_lru_page(page)) {
> +	if (!isolate_lru_page(page))
>  		putback_lru_page(page);
> -	} else {
> +	else {
> I don't always follow that over-braced style when making changes,
> but you should not touch otherwise untouched code just to make it
> go against the approved style.  And in munlock_vma_page(),
> -	if (!TestClearPageMlocked(page)) {
> +	if (!TestClearPageMlocked(page))
>  		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> -		nr_pages = 1;
> -		goto unlock_out;
> -	}
> +		return 0;
> please restore the braces: with that comment line in there,
> the compiler does not need the braces, but the human eye does.

Yes, That's better to keep the brace there.

Thanks
Alex
