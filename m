Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDAA270996
	for <lists+cgroups@lfdr.de>; Sat, 19 Sep 2020 03:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISBBG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 21:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISBBF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 21:01:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900CC0613CF
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 18:01:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so7113423otr.1
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=F6ouCx+UY7bERxjJEJ9jTlceFo1ID5VL0p2qsqPX3Zw=;
        b=vN5DPpuOlfSmPtaWZL6zx0O0pSA1oZN5byB79oi3/Th0jtNeFe7HSFJOIuomhGEumP
         felmSPjtAcWtAx7oslOukWMQ5OAt08kmWgH3G9zlp3ZJpfDBjLIk34FHbzHdRqVqGXI6
         8Z6vgC+MVonaor5EgrrvcSOEAhuJxXwjbzWLYKbL0zR+ay3mRPkcXHXI0z+oYPa3YI53
         4JG47WLX9aoOE3ehU8nyaDZ9do6Z+XFkOBGxy+XLIRe0V6laakkrOZ6VrwuNOhvtbfw/
         m+r182uC9V8S8WyfmfrZutgACk47/MzEmv16N2pwbLw9GtrSHqk/ubRXxbyYXf7uBZto
         xC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=F6ouCx+UY7bERxjJEJ9jTlceFo1ID5VL0p2qsqPX3Zw=;
        b=ADL3GsA7vFz38Ra987EOIbijAPh+otBSWUMlbBVI6yDm+qih2fHZUoT0Q9bdAfJSq4
         A+UqZtzJt/5Gv8XYSdTDY4dgeBQVvPuByy/C8kau04w+DCF6QvC+FwjK/I8Aril5R9Mm
         1TCg+OFOapUbI5l3J+IZIJ/4e/8b8dgKunccief6zXNpwVgi5Q1qA2mcOzgAcgBMNylw
         a7qcY/Que31LEhPjWKkpv9R3DadFftZ7C8Alx+P32U8NuZ0u4tWEDtPJTJEthpb/c6tO
         oBS9XXZp4wiKZZohYTGUvRid4/4UmmhLtjeqP+/UDa9eD1S6UKa4qH+vWhrNaIV+jMVt
         g7GQ==
X-Gm-Message-State: AOAM530V/swEOKxQYs+zHfTUgYuQnUS1RYaLkuq0ZRvwWnCGoDikI5+H
        hvyQGkQdfvKAA1F2CcJ8tgE3ww==
X-Google-Smtp-Source: ABdhPJzFlk5JTrdl+x67ufK9+jAuKWlWsSBauNAzwhaTiEvAoguJbs4gFvsFmASPwENigQ3XRbtyCQ==
X-Received: by 2002:a9d:5a92:: with SMTP id w18mr24191524oth.145.1600477262388;
        Fri, 18 Sep 2020 18:01:02 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j1sm3975584oii.5.2020.09.18.18.00.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2020 18:01:01 -0700 (PDT)
Date:   Fri, 18 Sep 2020 18:00:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v18 06/32] mm/thp: narrow lru locking
In-Reply-To: <20200913152703.GI6583@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2009181723090.12148@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-7-git-send-email-alex.shi@linux.alibaba.com> <20200910134923.GR6583@casper.infradead.org> <514f6afa-dbf7-11c5-5431-1d558d2c20c9@linux.alibaba.com>
 <20200913152703.GI6583@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2009094773-1600477261=:12148"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2009094773-1600477261=:12148
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 13 Sep 2020, Matthew Wilcox wrote:
> On Fri, Sep 11, 2020 at 11:37:50AM +0800, Alex Shi wrote:
> > =E5=9C=A8 2020/9/10 =E4=B8=8B=E5=8D=889:49, Matthew Wilcox =E5=86=99=E9=
=81=93:
> > > On Mon, Aug 24, 2020 at 08:54:39PM +0800, Alex Shi wrote:
> > >> lru_lock and page cache xa_lock have no reason with current sequence=
,
> > >> put them together isn't necessary. let's narrow the lru locking, but
> > >> left the local_irq_disable to block interrupt re-entry and statistic=
 update.
> > >=20
> > > What stats are you talking about here?
> >=20
> > Hi Matthew,
> >=20
> > Thanks for comments!
> >=20
> > like __dec_node_page_state(head, NR_SHMEM_THPS); will have preemptive w=
arning...
>=20
> OK, but those stats are guarded by 'if (mapping)', so this patch doesn't
> produce that warning because we'll have taken the xarray lock and disable=
d
> interrupts.
>=20
> > > How about this patch instead?  It occurred to me we already have
> > > perfectly good infrastructure to track whether or not interrupts are
> > > already disabled, and so we should use that instead of ensuring that
> > > interrupts are disabled, or tracking that ourselves.
> >=20
> > So your proposal looks like;
> > 1, xa_lock_irq(&mapping->i_pages); (optional)
> > 2, spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > 3, spin_lock_irqsave(&pgdat->lru_lock, flags);
> >=20
> > Is there meaningful for the 2nd and 3rd flags?
>=20
> Yes.  We want to avoid doing:
>=20
> =09if (mapping)
> =09=09spin_lock(&ds_queue->split_queue_lock);
> =09else
> =09=09spin_lock_irq(&ds_queue->split_queue_lock);
> ...
> =09if (mapping)
> =09=09spin_unlock(&ds_queue->split_queue_lock);
> =09else
> =09=09spin_unlock_irq(&ds_queue->split_queue_lock);
>=20
> Just using _irqsave has the same effect and is easier to reason about.
>=20
> > IIRC, I had a similar proposal as your, the flags used in xa_lock_irqsa=
ve(),
> > but objected by Hugh.
>=20
> I imagine Hugh's objection was that we know it's safe to disable/enable
> interrupts here because we're in a sleepable context.  But for the
> other two locks, we'd rather not track whether we've already disabled
> interrupts or not.
>=20
> Maybe you could dig up the email from Hugh?  I can't find it.

I did not find exactly the objection Alex seems to be remembering, but
I have certainly expressed frustration with the lack of a reason for
the THP split lock reordering, and in private mail in June while I was
testing and sending back fixes: "I'd prefer that you never got into this:
it looks like an unrelated and debatable cleanup, and I can see more
such cleanup to make there, that we'd better not get into right now."

I've several times toyed with just leaving this patch out of the series:
but each time ended up, for better or worse, deciding we'd better keep
it in - partly because we've never tested without it, and it cannot be
dropped without making some other change (to stabilize the memcg in
the !list case) - easily doable, but already done by this patch.

Alex asked me to improve his commit message to satisfy my objections,
here's what I sent him last night:

=3D=3D=3D
lru_lock and page cache xa_lock have no obvious reason to be taken
one way round or the other: until now, lru_lock has been taken before
page cache xa_lock, when splitting a THP; but nothing else takes them
together.  Reverse that ordering: let's narrow the lru locking - but
leave local_irq_disable to block interrupts throughout, like before.

Hugh Dickins point: split_huge_page_to_list() was already silly, to be
using the _irqsave variant: it's just been taking sleeping locks, so
would already be broken if entered with interrupts enabled.  So we
can save passing flags argument down to __split_huge_page().

Why change the lock ordering here? That was hard to decide. One reason:
when this series reaches per-memcg lru locking, it relies on the THP's
memcg to be stable when taking the lru_lock: that is now done after the
THP's refcount has been frozen, which ensures page memcg cannot change.

Another reason: previously, lock_page_memcg()'s move_lock was presumed
to nest inside lru_lock; but now lru_lock must nest inside (page cache
lock inside) move_lock, so it becomes possible to use lock_page_memcg()
to stabilize page memcg before taking its lru_lock.  That is not the
mechanism used in this series, but it is an option we want to keep open.
=3D=3D=3D

It's still the case that I want to avoid further cleanups and
bikeshedding here for now.  I took an open-minded look at Alex's
patch versus Matthew's patch, and do prefer Alex's: largely because
it's simple and explicit about where the irq disabling and enabling
is done (exactly where it was done before), and doesn't need irqsave
clutter in between.  If this were to be the only local_irq_disable()
in mm I'd NAK it, but that's not so - and as I said before, I don't
take the RT THP case very seriously anyway.

One slight worry in Matthew's version:

=09spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
=09count =3D page_count(head);
=09mapcount =3D total_mapcount(head);
=09if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
=09=09if (!list_empty(page_deferred_list(head))) {
=09=09=09ds_queue->split_queue_len--;
=09=09=09list_del(page_deferred_list(head));
=09=09}
=09=09spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
=09=09if (mapping) {
=09=09=09if (PageSwapBacked(head))
=09=09=09=09__dec_node_page_state(head, NR_SHMEM_THPS);
=09=09=09else
=09=09=09=09__dec_node_page_state(head, NR_FILE_THPS);
=09=09}
=09=09__split_huge_page(page, list, end);

In the Anon case, interrupts are enabled when calling __split_huge_page()
there, but head's refcount is frozen: I'm uneasy about preemption when a
refcount is frozen.  But I'd worry much more if it were the mapping case:
no, that has interrupts safely disabled at that point (as does Anon in
the current kernel, and with Alex's patch).

Hugh
--0-2009094773-1600477261=:12148--
