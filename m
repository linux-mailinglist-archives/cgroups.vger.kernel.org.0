Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558E86BA8A9
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 08:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCOHFP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCOHEv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 03:04:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFF11153
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 00:04:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so42125141edo.2
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678863888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByTkjvP85l0HIVb9EAEVi9c7ngFNS0G/NftKOOEY9V0=;
        b=tmOmoMo5SXJRy2GbAyCO/7pDf4tsNZHjiNk4mq8ny24PEy55JBsMaiiVOuk6duqUCV
         0EZBRHTMNIvHMtPfVe8QxTuNJds0srJzHdW8HzAwf/1pnNuCyXLXOkJ9vEyYCEfmVOGn
         d6frD03KpktEzpd8oAj61qo3WN7CihVoWMW5+ftcgVQ+6OG4C2MMzwbwJsQckFMTxZLm
         e5XQ+h4Xt5JTsH21uV0QbSYd8ns9pqRT4pHiyYN1Ic//wX7O+cfb7Ao1f5wTg5ssRrs7
         5gmizMOJ9G1btbiLwPPWznDGgBvBFKnY1+bV9x6cqTefZs8ncUAx8HKI80eKQh4NLvhT
         9+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678863888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByTkjvP85l0HIVb9EAEVi9c7ngFNS0G/NftKOOEY9V0=;
        b=LiGTs72pC11f2fL3KrUtDCEyh/3JkecD/40wY7iz8EeWwZKHF9rQSXDk4R2x8pxHw1
         WrdAFqmS3DvcICzXH3oyXz0FCThT9lyWFqM0NWfLSEBqMwCe+Elds+kc/RLXBwWD7IV/
         zDKpP1MvBzaURWTzMrSNnA6LOjPfiWyAllnjRIdsE0kjOEyGQLwt+KISGuS4BowsLR4D
         9J346gWsTm7ERNm4+D2BjsP+BTxCv/TqWkLW5bDWKl/qL0sq9tLpbniEy+NLjUpwALQb
         /lF3haRKiMCAQ/RGzk4iEz1nT5aEAk+dPlm5k92upmNyV+oo5Jtls4D3C8DAEI4TWL2y
         gyog==
X-Gm-Message-State: AO0yUKXzac9fo8o7juLqh/AgzqXCuUchs+aNtP50GrHtDDZIC6w+r7Sf
        TdWKPHrh6tV+I/CzsKHmnwYKeZm4aifEIKyMFLE4Sw==
X-Google-Smtp-Source: AK7set+xTWvXGEK35WOuZE4h3qPA478af/USZfgD8M3WEO7/5P9BPf6EQk8IN4jjVk2U8XHusXWtqDfIrVV5aEIPWGQ=
X-Received: by 2002:a50:8a93:0:b0:4fc:e5c:902 with SMTP id j19-20020a508a93000000b004fc0e5c0902mr839303edj.8.1678863887534;
 Wed, 15 Mar 2023 00:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com> <ZBFPh6j+4Khl1Je8@casper.infradead.org>
In-Reply-To: <ZBFPh6j+4Khl1Je8@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Mar 2023 00:04:10 -0700
Message-ID: <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 14, 2023 at 9:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Mar 13, 2023 at 02:08:53PM -0700, Yosry Ahmed wrote:
> > On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > >
> > > > From: Hugh Dickins <hughd@google.com>
> > > >
> > > > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check()=
, we
> > > > observed a warning from page_cgroup_ino() when reading
> > > > /proc/kpagecgroup.
> > >
> > > If this is the only known situation in which page_memcg_check() is
> > > passed a tail page, why does page_memcg_check() have
> > >
> > >         if (PageTail(page))
> > >                 return NULL;
> > >
> > > ?  Can we remove this to simplify, streamline and clarify?
> >
> > I guess it's a safety check so that we don't end up trying to cast a
> > tail page to a folio. My opinion is to go one step further and change
> > page_memcg_check() to do return the memcg of the head page, i.e:
> >
> > static inline struct mem_cgroup *page_memcg_check(struct page *page)
> > {
> >     return folio_memcg_check(page_folio(page));
> > }
>
> If you look at my commit becacb04fdd4, I was preserving the existing
> behaviour of page_memcg_check() when passed a tail page.  It would
> previously, rightly or wrongly, read the memcg_data from the tail page
> and get back NULL.

Right, I looked at that. I also looked at 1b7e4464d43a which added
folio_memcg() and changed page_memcg()'s behavior to use page_folio()
to retrieve the memcg from the head, which made me wonder why
different decisions were made for these 2 helpers.

Were the users of page_memcg() already passing in head pages only?

>
> I suspect that was not the intended behaviour, but I do not think this
> patch is the right fix; it simply papers over the problem and maybe
> creates a new one.  Callers of page_memcg_check() should be eliminated,
> precisely because of this ambiguity.  It's up to the people who understan=
d
> each of the callers who need to make the decision to always convert the
> page that they have to a folio and ask about its memcg, or whether they
> want to preserve the existing behaviour of returning NULL for tail pages.
>
> So, I say NACK to this patch as it does not preserve existing behaviour,
> and does not advance our understanding of what we have wrought.

I am not sure which patch you are NACKing, the original patch from
Hugh (adding compound_head() to page_cgroup_ino()) or the suggested
alternative patch which changes page_memcg_check() to use
page_folio().

I am assuming the latter (based on where this reply was placed). If
that's the case, are you okay with the original patch? If yes, then
changing page_memcg_check() to use page_folio() should be a NOP as the
only 2 callers today are page_cgroup_ino() and
print_page_owner_memcg(). The latter already implicitly excludes tail
pages by checking if memcg_data =3D=3D 0, and we can add an explicit
PageTail() check there instead.

Or is it the former (original patch)?
