Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C82678E7
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgILIjJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Sep 2020 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgILIjE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Sep 2020 04:39:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FC5C061757
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 01:39:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so6429441qvi.7
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t+vGWEoJxp91SsNDolPTSq+7zjC/jYdCePf+SxUM8GU=;
        b=DGtRL6Tbceqb0N+n02ZUW5GRPqfqmNmUDurGwj8oZMmd4F5Lhsl0tIGQjWUxvMSNQN
         yhi92u1IZOFzeBw7bslzjFppRiKI/kQ6DUTv+OfbT9814NinYRuckT9C32fdbn1pDTan
         AEFBUKu5KM/gk/EVPmSUo0F4aGg/rRIvIrINtKxaQw8YkL3UfiZi1PuxGCwYRZD9Qizp
         GEawDzYMcm09lgvcqR22jxvUTZ2i7w0n/mJbeta+hGleLeTgsDEJgDFiB+DRYJ3SGnM5
         Ke1QWlZ2LQAf9tSSijK8ZBr2m0Eg6OKZeB0uVCaKJr4PvsICy9mBOIjf/oGVqHOeRnfU
         m2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t+vGWEoJxp91SsNDolPTSq+7zjC/jYdCePf+SxUM8GU=;
        b=lPt1Sfvm5wW1xoQPzoQA+djPceBqzWsAKfJ0OKf2faDDQ5Nc/LgQf64HVi+xem0cVk
         Y+vDf8LnO9fXNBKtJmrveqOOZnul6QhmyUCotFIhxAbBYIU6GFU8iTWXybzCzSZNmtTt
         WcHUFgkc7D4q5JmlAOrh4tsHj7OX4sFiqLXU8NCd2reZnHqWijvd9b4fJx6RbrAnIY58
         nQ+vKAAe8gy5ItFJ6I/p6GAg2xbUU1Hd2g7QrSsi6uHTgVb2hLfIoV16KXwUM2m403WK
         sOmNHZ13LxhY6M7WHvkj7Eoo8ovJnQ3Cb3h8ng0I7gnu5lDJnZbe0Oszo275SFbAo0Kp
         1sHw==
X-Gm-Message-State: AOAM530IjnEZT12YwOP+vJMgOJK2v+uw3dCwTU9+A4yk0nOSIbQkBkW8
        fANVFMUwcWes4O7wPSXWE0sB/Q==
X-Google-Smtp-Source: ABdhPJwriv/y6+ub3Fs5ZDgAvBfXcMmxXW+goduf+GXSgFcnz8NQ7PLMVYLvBAlnr9np4WOgMtRfnQ==
X-Received: by 2002:ad4:4523:: with SMTP id l3mr5389790qvu.109.1599899942234;
        Sat, 12 Sep 2020 01:39:02 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 205sm6565315qki.118.2020.09.12.01.38.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 12 Sep 2020 01:38:59 -0700 (PDT)
Date:   Sat, 12 Sep 2020 01:38:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
In-Reply-To: <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009112216260.23961@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org> <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-916415362-1599899939=:23961"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-916415362-1599899939=:23961
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Sep 2020, Alex Shi wrote:
> =E5=9C=A8 2020/9/9 =E4=B8=8A=E5=8D=887:41, Hugh Dickins =E5=86=99=E9=81=
=93:
> >=20
> > The use of lock_page_memcg() in __munlock_pagevec() in 20/32,
> > introduced in patchset v17, looks good but it isn't: I was lucky that
> > systemd at reboot did some munlocking that exposed the problem to lockd=
ep.
> > The first time into the loop, lock_page_memcg() is done before lru_lock
> > (as 06/32 has allowed); but the second time around the loop, it is done
> > while still holding lru_lock.
>=20
> I don't know the details of lockdep show. Just wondering could it possibl=
e=20
> to solid the move_lock/lru_lock sequence?
> or try other blocking way which mentioned in commit_charge()?
>=20
> >=20
> > lock_page_memcg() really needs to be absorbed into (a variant of)
> > relock_page_lruvec(), and I do have that (it's awkward because of
> > the different ways in which the IRQ flags are handled).  And out of
> > curiosity, I've also tried using that in mm/swap.c too, instead of the
> > TestClearPageLRU technique: lockdep is happy, but an update_lru_size()
> > warning showed that it cannot safely be mixed with the TestClearPageLRU
> > technique (that I'd left in isolate_lru_page()).  So I'll stash away
> > that relock_page_lruvec(), and consider what's best for mm/mlock.c:
> > now that I've posted these comments so far, that's my priority, then
> > to get the result under testing again, before resuming these comments.
>=20
> No idea of your solution, but looking forward for your good news! :)

Yes, it is good news, and simpler than anything suggested above.

The main difficulties will probably be to look good in the 80 columns
(I know that limit has been lifted recently, but some of us use xterms
side by side), and to explain it.

mm/mlock.c has not been kept up-to-date very well: and in particular,
you have taken too seriously that "Serialize with any parallel
__split_huge_page_refcount()..." comment that you updated to two
comments "Serialize split tail pages in __split_huge_page_tail()...".

Delete them! The original comment was by Vlastimil for v3.14 in 2014.
But Kirill redesigned THP refcounting for v4.5 in 2016: that's when
__split_huge_page_refcount() went away.  And with the new refcounting,
the THP splitting races that lru_lock protected munlock_vma_page()
and __munlock_pagevec() from: those races have become impossible.

Or maybe there never was such a race in __munlock_pagevec(): you
have added the comment there, assuming lru_lock was for that purpose,
but that was probably just the convenient place to take it,
to cover all the del_page_from_lru()s.

Observe how split_huge_page_to_list() uses unmap_page() to remove
all pmds and all ptes for the huge page being split, and remap_page()
only replaces the migration entries (used for anon but not for shmem
or file) after doing all of the __split_huge_page_tail()s, before
unlocking any of the pages.  Recall that munlock_vma_page() and
__munlock_pagevec() are being applied to pages found mapped
into userspace, by ptes or pmd: there are none of those while
__split_huge_page_tail() is being used, so no race to protect from.

(Could a newly detached tail be freshly faulted into userspace just
before __split_huge_page() has reached the head?  Not quite, the
fault has to wait to get the tail's page lock. But even if it
could, how would that be a problem for __munlock_pagevec()?)

There's lots more that could be said: for example, PageMlocked will
always be clear on the THP head during __split_huge_page_tail(),
because the last unmap of a PageMlocked page does clear_page_mlock().
But that's not required to prove the case, it's just another argument
against the "Serialize" comment you have in __munlock_pagevec().

So, no need for the problematic lock_page_memcg(page) there in
__munlock_pagevec(), nor to lock (or relock) lruvec just below it.
__munlock_pagevec() still needs lru_lock to del_page_from_lru_list(),
of course, but that must be done after your TestClearPageMlocked has
stabilized page->memcg.  Use relock_page_lruvec_irq() here?  I suppose
that will be easiest, but notice how __munlock_pagevec_fill() has
already made sure that all the pages in the pagevec are from the same
zone (and it cannot do the same for memcg without locking page memcg);
so some of relock's work will be redundant.

Otherwise, I'm much happier with your mm/mlock.c since looking at it
in more detail: a couple of nits though - drop the clear_page_mlock()
hunk from 25/32 - kernel style says do it the way you are undoing by
-=09if (!isolate_lru_page(page)) {
+=09if (!isolate_lru_page(page))
 =09=09putback_lru_page(page);
-=09} else {
+=09else {
I don't always follow that over-braced style when making changes,
but you should not touch otherwise untouched code just to make it
go against the approved style.  And in munlock_vma_page(),
-=09if (!TestClearPageMlocked(page)) {
+=09if (!TestClearPageMlocked(page))
 =09=09/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
-=09=09nr_pages =3D 1;
-=09=09goto unlock_out;
-=09}
+=09=09return 0;
please restore the braces: with that comment line in there,
the compiler does not need the braces, but the human eye does.

Hugh
--0-916415362-1599899939=:23961--
