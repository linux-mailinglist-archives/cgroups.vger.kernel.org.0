Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1E6BA54B
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCOCjl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 22:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCOCjk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 22:39:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D232E64
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 19:39:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so26193622ede.8
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678847977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljOVhU1fVs1xN3h4tM9mfHkMvJnrbFNvzgF16LNR3Vo=;
        b=PLcLfvxHZdYNgL8JlzYiaOCIP1jymITB2rVN9pw3Y87SePfPyZiOPkONKSLoMmo3S+
         FrxXNV+tT07Oo4sdulau0vk37m2vyy0mRe8ZdcS95goR63oHkQcTxPMxJQwR/2eCGLD6
         rHA5FbhPuzmSZxu0qsrV7Iw6F1UnY66DTLz3Ghjie1XGN5LiIRFSmuThuKIAnT7UhQfi
         nxapEjnpcx5XXl57JR6jDAImN1T51fj62Lfya4UhbTY9C8tW7/7XXgSQwbi5bAE6QTXK
         0Xtm0CtiMdKMAOAzyAqhy4VYPDXpOT8DbeYjVlfJslD3C2vJXFEY+VFREghp2oB8VtrN
         kZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678847977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljOVhU1fVs1xN3h4tM9mfHkMvJnrbFNvzgF16LNR3Vo=;
        b=iLiTbuLquQ8ly4iGmjZf470Cey4J76hBNnOIAaeSMFcYf98w2oKgwsekpL7KcAcB1o
         zvQKKUc6ZbWf8mW3zfKoUe1F0u//swe2sI5ej9brY2lnZAemiVNOptcPUp84SHSVuFcL
         FT1J1YCWP5gOz9T/Sv7Zn5yC4upX/0BC/x9BAjrW+H4LxlC1mza7i/nMz7w0VMLaleZj
         ZdfoktZ7lyoozAGuTItZtR5ch5B0pDX046SNqrc6vtPoReVu2uGN9xvXKpIz5hSiYgW7
         3e8KsIwl/VXwoM65Kvt9oP9F7+xQ/o6iPabyOdA8kzMFEsgP9QSs8AtVgl5yY16i2byk
         TbLw==
X-Gm-Message-State: AO0yUKUvPHcd9dNdLErUEv1qOh2v1LkrWNYZhFyDUD6sLE4uQU60L6zA
        /O63sWFLINnd/pX7E8ltgZFD5PTuEm9Jg++eMGs3DA==
X-Google-Smtp-Source: AK7set+vd/h84AZ/4qOgFnI6UOyEAKXhYQ1zVvqO5lp8UcSSZ/Y1NOCYvHVwdYuPx2Zxyyf/LstgpFZrBPo7KK1jzEU=
X-Received: by 2002:a17:907:a40e:b0:8b0:7e1d:f6fa with SMTP id
 sg14-20020a170907a40e00b008b07e1df6famr2308873ejc.15.1678847977493; Tue, 14
 Mar 2023 19:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com> <ZBEusOt3onLa30Hm@P9FQF9L96D>
In-Reply-To: <ZBEusOt3onLa30Hm@P9FQF9L96D>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 19:39:01 -0700
Message-ID: <CAJD7tkbs8p3rNgmGWFgBB4GCapKQP97Zc3chCsNZ43dAj4s0Qg@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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

On Tue, Mar 14, 2023 at 7:34=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
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
> >
> > This makes it consistent with page_memcg(), and makes sure future
> > users are getting the "correct" memcg for whatever page they pass in.
> > I am interested to hear other folks' opinions here.
> >
> > The only other user today is print_page_owner_memcg(). I am not sure
> > if it's doing the right thing by explicitly reading page->memcg_data,
> > but it is already excluding pages that have page->memcg_data =3D=3D 0,
> > which should be the case for tail pages.
>
> Yeah, I think it's a good idea. I'd do this.
> If you'll master a patch like this, please, apply my
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

Thanks, Roman. So far there have been different opinions (specifically
Michal's), so I'll wait until the discussion settles before sending
another patch.

>
> I'm ok with the current approach too (the one you posted),
> but the one above is preferable.
>
> Overall it would be nice to clarify & document our expectations
> from /proc/kpagecgroup (and /proc/kpageflags & /proc/kpagecount)
> in the new folio "epoch".

Agreed, though I don't think I am the right person for this.


>
> Thanks!
