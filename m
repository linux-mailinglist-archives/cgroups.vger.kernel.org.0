Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251252CFDDA
	for <lists+cgroups@lfdr.de>; Sat,  5 Dec 2020 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgLESpU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Dec 2020 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgLEQtb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Dec 2020 11:49:31 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60752C09425D
        for <cgroups@vger.kernel.org>; Sat,  5 Dec 2020 07:40:01 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id s21so5912740pfu.13
        for <cgroups@vger.kernel.org>; Sat, 05 Dec 2020 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IX944X6oZl2Mzi0wZiZDHD4FwyqaIDsig5F+iiEk9k=;
        b=opakRlC7cQn4ZWwCZOV7BpaskunmVBhmP/y6bDVxwQnEDw1HsXsTmG7UqEkeEanTg7
         4yFQRNbstV/rae16oZ8vMyaC/8FhDJVXsSrhYShQimL2K7yAKNUxfy/V5FTqN4k8WFDC
         HKSOX5OcgbHSM/Vy8sTi8tPSzCzCURVaS1dkTfItKp5ZblNX6yRd3ajWqemrx/OUiPww
         jWOgbzl8EX/PJP/RUCYMYZQkuKqdQLRPeO49D6iT6kmEEVhHDm8XFwA9PhfZfQqZ+eQT
         nylPadt5IjBaQkx5n0qHVvuB5FfBdP/8dyJOMeY84V9ekjWUn02WrC0cCQ3aXLas8gvC
         DItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IX944X6oZl2Mzi0wZiZDHD4FwyqaIDsig5F+iiEk9k=;
        b=dHLWTNMnOK288gi+/cOkjT3r0aXC1rho/r0DJHK95Le2AxbEUYkohCXh0bvQ1944lx
         EXSm+wMbB4ZANBedPxUCtQVon20IeAi76W9jVKSJ73vTGByK9j5930Zievr0Cr5bZCix
         cloVAxtt85e3AKPLOt49PoE9TSMxTjIXi1SfM3XT6TWyltVGYV2GEPBBlRp7qMIYHZem
         QRZIE7AYHBFvDkJ9sraQqRc2/6uTqYj1gNAt0JIkWSIGtNxANlM7ucFJAWdopJC52kcx
         kqVN8mzwpQoGguvQm7gatx+0qCd9C1IeUOwYFblJ0OlL4Z+vB6ey+R3LIvhuqx7n0dzV
         Ob4w==
X-Gm-Message-State: AOAM5336nhiFEqgiu0809PX7aLIY9csNUWF/ABMqfLOGyx/o+Ij2C0mv
        Khh2RF5M+WGnFzunCm36ke54DY8ZhMyyu0rkD21iQQ==
X-Google-Smtp-Source: ABdhPJxMajBcqLFmL9fRt9cb50qxiMQn7k0izPFnayPR+eOm8xMxHvwAqxpRKw2wMjyEt2Q40p/KwQd88huMo0W4kJA=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr8740020pfi.49.1607182800915; Sat, 05 Dec
 2020 07:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com> <X8uU6ODzteuBY9pf@kroah.com>
 <CAMZfGtWjumNV4hu-Qv8Z+WoS-EmyhvQd1qsaoS1quvQCyczT=g@mail.gmail.com> <X8uoITGcfvZ/EA74@kroah.com>
In-Reply-To: <X8uoITGcfvZ/EA74@kroah.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Dec 2020 23:39:24 +0800
Message-ID: <CAMZfGtWmoPjuxfwYFUACRBCBgk3q77Sfv0kE2ysoX-9LJ8s2Zw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS
 account to pages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 5, 2020 at 11:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 05, 2020 at 11:29:26PM +0800, Muchun Song wrote:
> > On Sat, Dec 5, 2020 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> > > > Converrt NR_FILE_THPS account to pages.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  drivers/base/node.c | 3 +--
> > > >  fs/proc/meminfo.c   | 2 +-
> > > >  mm/filemap.c        | 2 +-
> > > >  mm/huge_memory.c    | 3 ++-
> > > >  mm/khugepaged.c     | 2 +-
> > > >  mm/memcontrol.c     | 5 ++---
> > > >  6 files changed, 8 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > index 05c369e93e16..f6a9521bbcf8 100644
> > > > --- a/drivers/base/node.c
> > > > +++ b/drivers/base/node.c
> > > > @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> > > >                                   HPAGE_PMD_NR),
> > > >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> > > >                                   HPAGE_PMD_NR),
> > > > -                          nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> > > > -                                 HPAGE_PMD_NR),
> > > > +                          nid, K(node_page_state(pgdat, NR_FILE_THPS)),
> > >
> > > Again, is this changing a user-visable value?
> > >
> >
> > Of course not.
> >
> > In the previous, the NR_FILE_THPS account is like below:
> >
> >     __mod_lruvec_page_state(page, NR_FILE_THPS, 1);
> >
> > With this patch, it is:
> >
> >     __mod_lruvec_page_state(page, NR_FILE_THPS, HPAGE_PMD_NR);
> >
> > So the result is not changed from the view of user space.
>
> So you "broke" it on the previous patch and "fixed" it on this one?  Why
> not just do it all in one patch?

Sorry for the confusion. I mean that the "previous" is without all of this patch
series. So this series is aimed to convert the unit of all different THP vmstat
counters from HPAGE_PMD_NR to pages. Thanks.

>
> Confused,
>
> greg k-h



-- 
Yours,
Muchun
