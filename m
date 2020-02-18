Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E160D16352E
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2020 22:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBRVgw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Feb 2020 16:36:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45125 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBRVgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Feb 2020 16:36:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so21050762otp.12
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2020 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoArTrJylMnWlkqCFi8ZRwkMiw0N4sNay65yTiKUcw8=;
        b=CmAOW91XtqP4UUdWMtfykPWQ26luE5zu7mFfOZxd4Ds6vR66zhEAMV5frCjn5UgU0v
         JpPDq3+wp0VVZ03uRe+iI+f1VNP0koZHN1egietzjXTsXUX0/NS/5jantDolGjfRdW0E
         uYLefhkR0kQSKAd2/ACPTYX9SyswNyoRCJpQvp7/qHRKkAy2O6BBEkFZXguoT98teQEI
         L+ipnJfLXgOk/TRGLea0g+BM6gCwKRQf9EB5FH6mQ/B+o2jkRlwWY5xjWlr2cTNP2HNl
         2xBoqTmAzlSF2o0p/nJHoJMVT/OE7CwXczBCr9JZ4KjqQ2OJqWoFMMjBGFx+HyiY8oGN
         xhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoArTrJylMnWlkqCFi8ZRwkMiw0N4sNay65yTiKUcw8=;
        b=uRMffmUwU5sS+VuUaCjH2lSg6DR5AYcO2SeDoo2nT2FN3VxrI5tpqfV55jM5n0tZMe
         4TslakeC1q+DdyyJkbCzP7J7rAQmXJG+J721asHhs9wnEnkh1e2dM6uY4nCOUn5BVENj
         URkPV750v9fiETxMRXT9NuItZwOiYiMNgzZjHPZiCHftP074SydUneThD16PSxzWiKJx
         Nl9cL6sujN7gZXhxaM0YAQnzlsHnEc7w9FVvhGWCM8Z9wjsPjCtw/3awogpI53PaI514
         VAYNVbbGA+UnfeMXuwIDq7B0Im3/L3b/7H2JkS2QEyo1Wr5aUvbmFLe2ZtJBhEhxewqH
         Y0wg==
X-Gm-Message-State: APjAAAWvB3S9miXo9lLzN1FYxd1T+XvzCsOfB3janTQho5Iv0OzC0ihM
        BsQwG40WYd5bMmJLaAwpQJxV+DN80NoZBc9x67NOSA==
X-Google-Smtp-Source: APXvYqzLjYFmXv8z2hR60F3INRqj1Zd+4SOlEkiOGiPnShqVS/POOXRWyVy0dvfvD7ksUqf8gQ/4gQPxNLthT7DGhNg=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr16379822otg.349.1582061808428;
 Tue, 18 Feb 2020 13:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <1582035660.7365.90.camel@lca.pw> <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
 <d498012a-ec87-ca48-ed78-5fcdaf372888@oracle.com> <CAHS8izPbMizJMNB-y9y2OViXYLStA6VT-HkWRd2hCS-5JSMwSA@mail.gmail.com>
In-Reply-To: <CAHS8izPbMizJMNB-y9y2OViXYLStA6VT-HkWRd2hCS-5JSMwSA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 18 Feb 2020 13:36:37 -0800
Message-ID: <CAHS8izODfKaLqWAehhR_XuN=FRgmWBE7+eCJMD2HGig8s+zvwg@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 18, 2020 at 11:25 AM Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, Feb 18, 2020 at 11:14 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 2/18/20 10:35 AM, Mina Almasry wrote:
> > > On Tue, Feb 18, 2020 at 6:21 AM Qian Cai <cai@lca.pw> wrote:
> > >>
> > >> On Tue, 2020-02-11 at 15:19 -0800, Andrew Morton wrote:
> > >>> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > >>>
> > >> [ 7933.806377][T14355] ------------[ cut here ]------------
> > >> [ 7933.806541][T14355] kernel BUG at mm/hugetlb.c:490!
> > >> VM_BUG_ON(t - f <= 1);
> > >> [ 7933.806562][T14355] Oops: Exception in kernel mode, sig: 5 [#1]
> > <snip>
> > > Hi Qian,
> > >
> > > Yes this VM_BUG_ON was added by a patch in the series ("hugetlb:
> > > disable region_add file_region coalescing") so it's definitely related
> > > to the series. I'm taking a look at why this VM_BUG_ON fires. Can you
> > > confirm you reproduce this by running hugemmap06 from the ltp on a
> > > powerpc machine? Can I maybe have your config?
> > >
> > > Thanks!
> >
> > Hi Mina,
> >
> > Looking at the region_chg code again, we do a
> >
> >         resv->adds_in_progress += *out_regions_needed;
> >
> > and then potentially drop the lock to allocate the needed entries.  Could
> > anopther thread (only adding reservation for a single page) then come in
> > and notice that there are not enough entries in the cache and hit the
> > VM_BUG_ON()?
>
> Maybe. Also I'm thinking the code thinks actual_regions_needed >=
> in_regions_needed, but that doesn't seem like a guarantee. I think
> this call sequence with the same t->f range would violate that:
>
> region_chg (regions_needed=1)
> region_chg (regions_needed=1)
> region_add (fills in the range)
> region_add (in_regions_needed = 1, actual_regions_needed = 0, so
> assumptions in the code break).
>
> Luckily it seems the ltp readily reproduces this, so I'm working on
> reproducing it. I should have a fix soon, at least if I can reproduce
> it as well.

I had a bit of trouble reproducing this but I got it just now.

Makes sense I've never run into this even though others can readily
reproduce it. I happen to run my kernels on a pretty beefy 36 core
machine and in that setup things seem to execute fast and there is
never a queue of pending file_region inserts into the resv_map. Once I
limited qemu to only use 2 cores I ran into the issue right away.
Looking into a fix now.
