Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCF1F6FBC
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFKWKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKWKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 18:10:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB43C03E96F
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:10:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b8so6932864oic.1
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hdWx5Cu6bWbxxBQKAjjUN4KQBR6YX2nwSKKCynMw0Zg=;
        b=d71isUZntaFlqiviJ3bl3w2PUe3el5FT6du/Tp9hRAWOsjOXNO5eqOpwaRP+f7uuVL
         D70K/rCY+RKeEaRcqugoEG0g23QQBYyMu9EZKv3jTYwa7a6QVrx0qruNl+DuUvKfV6wd
         /GZk6h4Fp+PyVuct/6ruL6yuXLDrHaoZ3CbEDC/r9DfxCYDsY4vAKi6Ll4Z3aWs8P+oi
         25oUCNFcAhKPIXG/fuWoKPbyGlLVmcr2KSTWsXZAw0vwe3wy8YoEx3wJo9pWCeuVCc6n
         EA9xkUUSmBX0aIl9oe3bPTXTpiVongm57gFz0voU21hGewfV0ekIb7x67ArUEf3NBZM6
         Ssig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hdWx5Cu6bWbxxBQKAjjUN4KQBR6YX2nwSKKCynMw0Zg=;
        b=MUn+KFIddHQG3c9yiox7G18shpKN+mbqKNpKWmMx5wrs/hoL6liVgICQjVC3SGyzuz
         PK/inwWsgz4NrDaERuh6wHLnUjWs0tY0Z7pbgoUR4kwKfCxWmibM36PXUGkiztcJV+FJ
         7K6alSmT9f/agjgeQuB3siHAkbgFpNTLmoyi3AnHr9hehkhpmf8xn5quOZ8TLQGQYk7A
         PcrZycalzA+NofGvFuB32YXR77nIKv5FKXy+XpduTR85jgB4o5frW0zjW0ao/AfE1QE0
         pGsCRAnlxby85suLbrfwViA8iN5HN6Q3Q0UKbKePxynH3Ks5MD26Lg1YszJBA8m+0eHx
         3vmw==
X-Gm-Message-State: AOAM533NwDj2qVI3w/NLwaMcejmc86OV3LFU78GUXgKAOXdE3C0ndf6n
        SauUE9JHXsQ8joYp33DKqiM4tg==
X-Google-Smtp-Source: ABdhPJxUNccJxGdSrNzsPKGgRLmlJN57bhrx5L71Gft8c4I9s7EbV0K/pE//CJEhdJQwKnUDfvI+mw==
X-Received: by 2002:a05:6808:45:: with SMTP id v5mr108731oic.140.1591913412762;
        Thu, 11 Jun 2020 15:10:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p5sm960997oof.7.2020.06.11.15.10.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:10:11 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:09:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v11 00/16] per memcg lru lock
In-Reply-To: <730c595b-f4bf-b16a-562e-de25b9b7eb97@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2006111409280.10801@eggly.anvils>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com> <alpine.LSU.2.11.2006072100390.2001@eggly.anvils> <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com> <alpine.LSU.2.11.2006091904530.2779@eggly.anvils>
 <730c595b-f4bf-b16a-562e-de25b9b7eb97@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2125215133-1591913411=:10801"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2125215133-1591913411=:10801
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jun 2020, Alex Shi wrote:
> =E5=9C=A8 2020/6/10 =E4=B8=8A=E5=8D=8811:22, Hugh Dickins =E5=86=99=E9=81=
=93:
> > On Mon, 8 Jun 2020, Alex Shi wrote:
> >> =E5=9C=A8 2020/6/8 =E4=B8=8B=E5=8D=8812:15, Hugh Dickins =E5=86=99=E9=
=81=93:
> >>>>  24 files changed, 487 insertions(+), 312 deletions(-)
> >>> Hi Alex,
> >>>
> >>> I didn't get to try v10 at all, waited until Johannes's preparatory
> >>> memcg swap cleanup was in mmotm; but I have spent a while thrashing
> >>> this v11, and can happily report that it is much better than v9 etc:
> >>> I believe this memcg lru_lock work will soon be ready for v5.9.
> >>>
> >>> I've not yet found any flaw at the swapping end, but fixes are needed
> >>> for isolate_migratepages_block() and mem_cgroup_move_account(): I've
> >>> got a series of 4 fix patches to send you (I guess two to fold into
> >>> existing patches of yours, and two to keep as separate from me).
> >>>
> >>> I haven't yet written the patch descriptions, will return to that
> >>> tomorrow.  I expect you will be preparing a v12 rebased on v5.8-rc1
> >>> or v5.8-rc2, and will be able to include these fixes in that.
> >>
> >> I am very glad to get your help on this feature!=20
> >>
> >> and looking forward for your fixes tomorrow. :)
> >>
> >> Thanks a lot!
> >> Alex
> >=20
> > Sorry, Alex, the news is not so good today.
> >=20
> > You'll have noticed I sent nothing yesterday. That's because I got
> > stuck on my second patch: could not quite convince myself that it
> > was safe.
>=20
> Hi Hugh,
>=20
> Thanks a lot for your help and effort! I very appreciate for this.
>=20
> >=20
> > I keep hinting at these patches, and I can't complete their writeups
> > until I'm convinced; but to give you a better idea of what they do:
> >=20
> > 1. Fixes isolate_fail and isolate_abort in isolate_migratepages_block()=
=2E
>=20
> I guess I know this after mm-compaction-avoid-vm_bug_onpageslab-in-page_m=
apcount.patch
> was removed.

No, I already assumed you had backed that out: these are fixes beyond that.

>=20
> > 2. Fixes unsafe use of trylock_page() in __isolate_lru_page_prepare().
> > 3. Reverts 07/16 inversion of lock ordering in split_huge_page_to_list(=
).
> > 4. Adds lruvec lock protection in mem_cgroup_move_account().
>=20
> Sorry for can't follow you for above issues.

Indeed, more explanation needed: coming.

> Anyway, I will send out new patchset
> with the first issue fixed. and then let's discussion base on it.

Sigh. I wish you had waited for me to send you fixes, or waited for an
identifiable tag like 5.8-rc1.  Andrew has been very hard at work with
mm patches to Linus, but it looks like there are still "data_race" mods
to come before -rc1, which may stop your v12 from applying cleanly.

>=20
> >=20
> > In the second, I was using rcu_read_lock() instead of trylock_page()
> > (like in my own patchset), but could not quite be sure of the case when
> > PageSwapCache gets set at the wrong moment. Gave up for the night, and
> > in the morning abandoned that, instead just shifting the call to
> > __isolate_lru_page_prepare() after the get_page_unless_zero(),
> > where that trylock_page() becomes safe (no danger of stomping on page
> > flags while page is being freed or newly allocated to another owner).
>=20
> Sorry, I don't know the problem of trylock_page here? Could you like to
> describe it as a race?

Races, yes. Look, I'll send you now patches 1 and 2: at least with those
in it should be safe for you and others to test compaction (if 5.8-rc1
turns out well: I think so much has gone in that it might have unrelated
problems, and often the -rc2 is much more stable).

But no point in sending 3 and 4 at this point, since ...

>=20
> >=20
> > I thought that a very safe change, but best to do some test runs with
> > it in before finalizing. And was then unpleasantly surprised to hit a
> > VM_BUG_ON_PAGE(lruvec_memcg(lruvec) !=3D page->mem_cgroup) from
> > lock_page_lruvec_irqsave < relock_page_lruvec < pagevec_lru_move_fn <
> > pagevec_move_tail < lru_add_drain_cpu after 6 hours on one machine.
> > Then similar but < rotate_reclaimable_page after 8 hours on another.
> >=20
> > Only seen once before: that's what drove me to add patch 4 (with 3 to
> > revert the locking before it): somehow, when adding the lruvec locking
> > there, I just took it for granted that your patchset would have the
> > appropriate locking (or TestClearPageLRU magic) at the other end.
> >=20
> > But apparently not. And I'm beginning to think that TestClearPageLRU
> > was just to distract the audience from the lack of proper locking.
> >=20
> > I have certainly not concluded that yet, but I'm having to think about
> > an area of the code which I'd imagined you had under control (and I'm
> > puzzled why my testing has found it so very hard to hit). If we're
> > lucky, I'll find that pagevec_move_tail is a special case, and
> > nothing much else needs changing; but I doubt that will be so.

=2E.. shows that your locking primitives are not yet good enough
to handle the case when tasks are moved between memcgs with
move_charge_at_immigrate set.  "bin/cg m" in the tests I sent,
but today I'm changing its "seconds=3D60" to "seconds=3D1" in hope
of speeding up the reproduction.

Ah, good, two machines crashed in 1.5 hours: but I don't need to
examine the crashes, now that it's obvious there's no protection -
please, think about rotate_reclaimable_page() (there will be more
cases, but in practice that seems easiest to hit, so focus on that)
and how it is not protected from mem_cgroup_move_account().

I'm thinking too. Maybe judicious use of lock_page_memcg() can fix it
(8 years ago it was unsuitable, but a lot has changed for the better
since then); otherwise it's back to what I've been doing all along,
taking the likely lruvec lock, and checking under that lock whether
we have the right lock (as your lruvec_memcg_debug() does), retrying
if not. Which may be more efficient than involving lock_page_memcg().

But I guess still worth sending my first two patches, since most of us
use move_charge_at_immigrate only for... testing move_charge_at_immigrate.
Whereas compaction bugs can hit any of us at any time.

> >=20
> > There's one other unexplained and unfixed bug I've seen several times
> > while exercising mem_cgroup_move_account(): refcount_warn_saturate()
> > from where __mem_cgroup_clear_mc() calls mem_cgroup_id_get_many().
> > I'll be glad if that goes away when the lruvec locking is fixed,
> > but don't understand the connection. And it's quite possible that
> > this refcounting bug has nothing to do with your changes: I have
> > not succeeded in reproducing it on 5.7 nor on 5.7-rc7-mm1,
> > but I didn't really try long enough to be sure.

I got one of those quite quickly too after setting "cg m"'s seconds=3D1.
I think the best thing I can do while thinking and researching, is
give 5.7-rc7-mm1 a run on that machine with the speeded up moving,
to see whether or not that refcount bug reproduces.

> >=20
> > (I should also warn, that I'm surprised by the amount of change
> > 11/16 makes to mm/mlock.c: I've not been exercising mlock at all.)
>=20
> yes, that is a bit complex. I have tried the mlock cases in selftest with
> your swap&build case. They are all fine with 300 times run.

Good, thanks.

Hugh
--0-2125215133-1591913411=:10801--
