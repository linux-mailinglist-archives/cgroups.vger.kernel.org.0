Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7111C1CFC7
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 21:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENTWU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 15:22:20 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39612 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENTWU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 15:22:20 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5so14895ybn.6
        for <cgroups@vger.kernel.org>; Tue, 14 May 2019 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfOaL1oTnK5xA4uooC11ryURNw9L/10wivCSX2gcjCo=;
        b=GAaDgk7n/tpFRiZ3MVfd/nTZvVS8gOy9QgwY0WSf+e6tOSWEVi0YrWAMv5RFGbDprW
         AjTBdJhyEJCjt5jOANifS7VPXwOs1izpQ8BJUlZI9YWzJXVBYvd/JcdbIcJBIH0/qsJ1
         c4PWmrJK0W5UxolQRTIAsskkAi4l2CLZZFPhxLpq7OePR8qRs4NhOZbAzQJfY5LoJXdd
         7wWIKB/86sHuEiWNzyWBGD2BwCh+MX18mViRjbaLzDupK9+NmsOZ2YhjXGjy5CQV3Ivw
         HwxFWXerI5hfYo9iqcWrLsrzxwQdbaVmFuOVKt1BHFvq7LErJFjomK170O3fUcF8HlJf
         C6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfOaL1oTnK5xA4uooC11ryURNw9L/10wivCSX2gcjCo=;
        b=Qp6kq5Eu1wOb9qv8W1eafMq2vljnhel/TWFINP9d8K7xRUuuY2U35HGUobnWuUkYzE
         DnSSgAvBzeDvJ2MksBxwa19BDgl49viQgxSBgfxitweUknnhnWYdGBM6Unw4NTxyeRJt
         xJ/Djqg6oOXeNoepBsyQiF/H+d7UfE+cYAf27kdmTMT6k9/4RiErwZM7DmGS5ku4Ti1E
         7higqnRXDOfpxvO1++TKxFEoA93loU8ivPRvpYxQA81eqHffa+vmitfRdpuhdPAJiPGB
         PZhheoTTFn+6dJSackTguZY+z/5tq84Lyk5X0qNLqy6PsYhMArc0PXWoRv+vys6tV79C
         Tfrg==
X-Gm-Message-State: APjAAAVS3Lka8Ge9So0rghjTyHDlUH5NYyHWWYmdYZDWYsnWhhhjQwfo
        B35lXbA5aiZyu5yXDG12gOGcyQLAAbPoQXE3wUy/3A==
X-Google-Smtp-Source: APXvYqwNKjYJPo2uyzeWK/NA8XlEn0uNWXXg6sEiEhbNoRPCR4NlWDGedEUVbzLNS0/MZ+0HUs31yTEYQIGcedAV4Fc=
X-Received: by 2002:a25:dcd0:: with SMTP id y199mr17267698ybe.464.1557861739144;
 Tue, 14 May 2019 12:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190508202458.550808-1-guro@fb.com> <CALvZod4WGVVq+UY_TZdKP_PHdifDrkYqPGgKYTeUB6DsxGAdVw@mail.gmail.com>
 <20190513202146.GA18451@tower.DHCP.thefacebook.com>
In-Reply-To: <20190513202146.GA18451@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 May 2019 12:22:08 -0700
Message-ID: <CALvZod4GscZjob8bfCcfhsMh0sco16r4yfOaRU69WnNO7MRrpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] mm: reparent slab memory on cgroup removal
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Roman Gushchin <guro@fb.com>
Date: Mon, May 13, 2019 at 1:22 PM
To: Shakeel Butt
Cc: Andrew Morton, Linux MM, LKML, Kernel Team, Johannes Weiner,
Michal Hocko, Rik van Riel, Christoph Lameter, Vladimir Davydov,
Cgroups

> On Fri, May 10, 2019 at 05:32:15PM -0700, Shakeel Butt wrote:
> > From: Roman Gushchin <guro@fb.com>
> > Date: Wed, May 8, 2019 at 1:30 PM
> > To: Andrew Morton, Shakeel Butt
> > Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
> > <kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
> > Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
> > Gushchin
> >
> > > # Why do we need this?
> > >
> > > We've noticed that the number of dying cgroups is steadily growing on most
> > > of our hosts in production. The following investigation revealed an issue
> > > in userspace memory reclaim code [1], accounting of kernel stacks [2],
> > > and also the mainreason: slab objects.
> > >
> > > The underlying problem is quite simple: any page charged
> > > to a cgroup holds a reference to it, so the cgroup can't be reclaimed unless
> > > all charged pages are gone. If a slab object is actively used by other cgroups,
> > > it won't be reclaimed, and will prevent the origin cgroup from being reclaimed.
> > >
> > > Slab objects, and first of all vfs cache, is shared between cgroups, which are
> > > using the same underlying fs, and what's even more important, it's shared
> > > between multiple generations of the same workload. So if something is running
> > > periodically every time in a new cgroup (like how systemd works), we do
> > > accumulate multiple dying cgroups.
> > >
> > > Strictly speaking pagecache isn't different here, but there is a key difference:
> > > we disable protection and apply some extra pressure on LRUs of dying cgroups,
> >
> > How do you apply extra pressure on dying cgroups? cgroup-v2 does not
> > have memory.force_empty.
>
> I mean the following part of get_scan_count():
>         /*
>          * If the cgroup's already been deleted, make sure to
>          * scrape out the remaining cache.
>          */
>         if (!scan && !mem_cgroup_online(memcg))
>                 scan = min(lruvec_size, SWAP_CLUSTER_MAX);
>
> It seems to work well, so that pagecache alone doesn't pin too many
> dying cgroups. The price we're paying is some excessive IO here,

Thanks for the explanation. However for this to work, something still
needs to trigger the memory pressure until then we will keep the
zombies around. BTW the get_scan_count() is getting really creepy. It
needs a refactor soon.

> which can be avoided had we be able to recharge the pagecache.
>

Are you looking into this? Do you envision a mount option which will
tell the filesystem is shared and do recharging on the offlining of
the origin memcg?

> Btw, thank you very much for looking into the patchset. I'll address
> all comments and send v4 soon.
>

You are most welcome.

thanks,
Shakeel
