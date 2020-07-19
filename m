Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F3225265
	for <lists+cgroups@lfdr.de>; Sun, 19 Jul 2020 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgGSPPE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jul 2020 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSPPD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jul 2020 11:15:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C498C0619D2;
        Sun, 19 Jul 2020 08:15:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so15073840iob.4;
        Sun, 19 Jul 2020 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KD0HIaFZq56OVyDZqxH1qgBh9ALce1H+dJs/b8P0iG0=;
        b=D6e1D4mOo+HLSCzvFU92E3OgGKo/Y61GaP1Wsc1D9JDCraHobxyAqr7b2k5RHTNtA8
         SuHImDHowt8DtGQZWdkWX8rZ/2f7WbVDBw7XOomMwhDYKNGBJSankHuY2+RSUJcO0rbe
         F5c7K0OS5FY/DCtJYYKNlzoTY6b3Ud+RIgyArS/8CSzNbN47Sg+JLniSPFJHt8RkFBAC
         Js8uZkZBezaWHjXQ9GPf+Fv/77op2/GgPox6RZBCykSZrYEYPf2mdPcOr0WIuE5euVBT
         BhNObptsociXZSrF6MVSnoMUNWMSBw22lnBh+77SWx7h+dC0ckBsrH3jwnYm8sFf9sGu
         dSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KD0HIaFZq56OVyDZqxH1qgBh9ALce1H+dJs/b8P0iG0=;
        b=q1RXMVGgop9iZcGJIiStUD1J6LjAXHa0zIGERSw4YogfqL5voXpFSMxBR2gXOLzc5s
         dzrEVsgc7B+yELYQDYnAo+GSS2ecSiN6S8DWw9U6xp+b6V2gLxACC2hKbNFcDJYx05Sy
         SQdn9zMA9P0H4JHiGki7IP/NVt+VDaQTRHE1CtdERFKUopv7OvY73o+Q4Etl6MkxLHYs
         hpr3Ct5aNdX5vnByO18mFB/4ghAuj8LujxHzUheNY1ph9G/YfPsOISwYU4h6Emookv67
         XAshakmoI+nMx/p9BeDltmzMylxsS8O9eqWZqj5j7a+m9Rt8xK9KX1wPnw0s96l1nY1J
         IQIA==
X-Gm-Message-State: AOAM533LKwbuvEb2krnHyha7qwEBDqH9qi3yexjLjluAizFusJ6ZVF3W
        OnmCUCSgzhyCYAfwldkIh32gJjUtbxGQfDJ+rZA=
X-Google-Smtp-Source: ABdhPJymgyDPyMdeD8uxZwZ1LaX+vaX916vvWmJJ2i8kjwFluQvTlmR/w8nldof2PRq0yYUzpIyN0OEnA/iSW31GTpE=
X-Received: by 2002:a05:6638:771:: with SMTP id y17mr21105986jad.96.1595171701844;
 Sun, 19 Jul 2020 08:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-19-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ud+Dj-Q8Sxv8eDQhjM3fFHwnU_ZFEVG54debBennUmxAg@mail.gmail.com>
 <62dfd262-a7ac-d18e-216a-2988c690b256@linux.alibaba.com> <c339f46e-ae04-4e65-2713-a5c8be56051a@linux.alibaba.com>
In-Reply-To: <c339f46e-ae04-4e65-2713-a5c8be56051a@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 19 Jul 2020 08:14:50 -0700
Message-ID: <CAKgT0UestD7cU+3aqg3a9JT4bTXVYQpjGbwoC2-bOBHPY5xn6A@mail.gmail.com>
Subject: Re: [PATCH v16 18/22] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 19, 2020 at 2:12 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/7/18 =E4=B8=8B=E5=8D=8810:15, Alex Shi =E5=86=99=E9=81=93:
> >>>
> >>>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
> >>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>> index 14c668b7e793..36c1680efd90 100644
> >>> --- a/include/linux/mmzone.h
> >>> +++ b/include/linux/mmzone.h
> >>> @@ -261,6 +261,8 @@ struct lruvec {
> >>>         atomic_long_t                   nonresident_age;
> >>>         /* Refaults at the time of last reclaim cycle */
> >>>         unsigned long                   refaults;
> >>> +       /* per lruvec lru_lock for memcg */
> >>> +       spinlock_t                      lru_lock;
> >>>         /* Various lruvec state flags (enum lruvec_flags) */
> >>>         unsigned long                   flags;
> >> Any reason for placing this here instead of at the end of the
> >> structure? From what I can tell it looks like lruvec is already 128B
> >> long so placing the lock on the end would put it into the next
> >> cacheline which may provide some performance benefit since it is
> >> likely to be bounced quite a bit.
> > Rong Chen(Cced) once reported a performance regression when the lock at
> > the end of struct, and move here could remove it.
> > Although I can't not reproduce. But I trust his report.
> >
> Oops, Rong's report is on another member which is different with current
> struct.
>
> Compare to move to tail, how about to move it to head of struct, which is
> close to lru list? Did you have some data of the place change?

I don't have specific data, just anecdotal evidence from the past that
usually you want to keep locks away from read-mostly items since they
cause obvious cache thrash. My concern was more with the other fields
in the structure such as pgdat since it should be a static value and
having it evicted would likely be more expensive than just leaving the
cacheline as it is.

> > ...
> >
> >>>  putback:
> >>> -               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
> >>>                 pagevec_add(&pvec_putback, pvec->pages[i]);
> >>>                 pvec->pages[i] =3D NULL;
> >>>         }
> >>> -       /* tempary disable irq, will remove later */
> >>> -       local_irq_disable();
> >>>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> >>> -       local_irq_enable();
> >>> +       if (lruvec)
> >>> +               unlock_page_lruvec_irq(lruvec);
> >> So I am not a fan of this change. You went to all the trouble of
> >> reducing the lock scope just to bring it back out here again. In
> >> addition it implies there is a path where you might try to update the
> >> page state without disabling interrupts.
> > Right. but any idea to avoid this except a extra local_irq_disable?
> >
>
> The following changes would resolve the problem. Is this ok?
> @@ -324,7 +322,8 @@ static void __munlock_pagevec(struct pagevec *pvec, s=
truct zone *zone)
>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>                 pvec->pages[i] =3D NULL;
>         }
> -       __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> +       if (delta_munlocked)
> +               __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>         if (lruvec)
>                 unlock_page_lruvec_irq(lruvec);

Why not just wrap the entire thing in a check for "lruvec"? Yes you
could theoretically be modding with a value of 0, but it avoids a
secondary unnecessary check and branching.
