Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AC244F7C
	for <lists+cgroups@lfdr.de>; Fri, 14 Aug 2020 23:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHNVPV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Aug 2020 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgHNVPU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Aug 2020 17:15:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E10C061385;
        Fri, 14 Aug 2020 14:15:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so9627747ilh.3;
        Fri, 14 Aug 2020 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tJMVJBnaXmXqh981RH/h7+Q4BiQVvI3wCXGlTjz6EWg=;
        b=bYyuaTEqbGMUDbMQT1N3adh8ZXqau382QojThewnW//4qEz3eZ/zrAaDMQ2DyZdy5S
         zy3hUU8M7NHVx+aHkrthzP7rx9gfHneJI0nSdRH9Ckd5lxNps3aL683LKaDWNsKgnYZM
         Lt+XpG2yMuTdQt8MznPtkrXzYmYBSamAHiQN0gr/ZKTOQNhfnS7FBtOsdNBgsXegXw43
         TAgtcMLOko7OxUnCkBxGuIogU9IzzqRw3UAHDFpS3HbUFvqlslWZEjTR+rnWF0tc8VNO
         9PavoPblmc7OTQ7XIa/bqusD5Dw8UajLsvr3Pqjx3usFzgELflUYZN+4bZqMnmJRkg7f
         yYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tJMVJBnaXmXqh981RH/h7+Q4BiQVvI3wCXGlTjz6EWg=;
        b=opm6RX5H9nI0rguz6NcbkMk7fDJHH1BZBKC0gYzgWqYmN5BoA9GfiErCuca3rHzbt2
         AUuJ7Ijx6lUZ5/4jj4FKhaeWEGku+AMZz0Yq+eQN6a8Y9WPC1Z9/IeYkFpQVUVYPgGeY
         /Pl1mYOBaZIpLyql62oSv8f2iz1yZk0yjU8oy38tCmnGFhn0KHvwYj0ZaYZC7aa6jnKc
         OXCl8MgFXX86M1+9sndJdJtIhyetQNoYBFpxe37Uazo5dJOGCTT/m8oAx6uw9A8dT9qc
         yeFtdfcp7P40U13erKX15Ei41Rwwu5a8mHh8gKwi4GU3hLWKhPFGSn6JTL6YiZEVqvWd
         KV2g==
X-Gm-Message-State: AOAM532RP3naOoENAHAU0xj4CQlq8+ptA+dzYHu/cnNyUvJpZSUCiuy7
        H8wIrzmCQ73CjoTi2Y1yhfDKTMrx/1el/zWJjs8=
X-Google-Smtp-Source: ABdhPJwpZ1nVKkZq07Dopl2XjbctppDLsyq/CUWPrYJGlfkx7y1ewbsXQzHhTu2pyEZDnsMGq5XWLhh+TTzjZ6JEaKE=
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr3694759ilr.97.1597439719638;
 Fri, 14 Aug 2020 14:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040232.13054.82417.stgit@localhost.localdomain> <6c072332-ff16-757d-99dd-b8fbae131a0c@linux.alibaba.com>
 <CAKgT0Uf0TbRBVsuGZ1bgh5rdFp+vARkP=+GgD4-DP3Gy6cj+pA@mail.gmail.com>
In-Reply-To: <CAKgT0Uf0TbRBVsuGZ1bgh5rdFp+vARkP=+GgD4-DP3Gy6cj+pA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 14 Aug 2020 14:15:08 -0700
Message-ID: <CAKgT0Ue=DwVAr+dG8Ff04mUY5ZCG6cpvHCG=bP1w=HujiCp0BQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: Drop use of test_and_set_skip in favor of
 just setting skip
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 14, 2020 at 7:24 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Fri, Aug 14, 2020 at 12:19 AM Alex Shi <alex.shi@linux.alibaba.com> wr=
ote:
> >
> >
> >
> > =E5=9C=A8 2020/8/13 =E4=B8=8B=E5=8D=8812:02, Alexander Duyck =E5=86=99=
=E9=81=93:
> > >
> > > Since we have dropped the late abort case we can drop the code that w=
as
> > > clearing the LRU flag and calling page_put since the abort case will =
now
> > > not be holding a reference to a page.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > seems the case-lru-file-mmap-read case drop about 3% on this patch in a=
 rough testing.
> > on my 80 core machine.
>
> I'm not sure how it could have that much impact on the performance
> since the total effect would just be dropping what should be a
> redundant test since we tested the skip bit before we took the LRU
> bit, so we shouldn't need to test it again after.
>
> I finally got my test setup working last night. I'll have to do some
> testing in my environment and I can start trying to see what is going
> on.

So I ran the case-lru-file-mmap-read a few times and I don't see how
it is supposed to be testing the compaction code. It doesn't seem like
compaction is running at least on my system as a result of the test
script. I wonder if testing this code wouldn't be better done using
something like thpscale from the
mmtests(https://github.com/gormanm/mmtests)? It seems past changes to
the compaction code were tested using that, and the config script for
the test explains that it is designed specifically to stress the
compaction code. I have the test up and running now and hope to
collect results over the weekend.

There is one change I will probably make to this patch and that is to
place the new code that is setting skip_updated where the old code was
calling test_and_set_skip_bit. By doing that we can avoid extra checks
and it should help to reduce possible collisions when setting the skip
bit in the pageblock flags.

Thanks.

- Alex
