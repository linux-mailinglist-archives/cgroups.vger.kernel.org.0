Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8196B9FEC
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 20:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCNTqJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNTqI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 15:46:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066F265A8
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 12:46:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so35500669edb.6
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678823160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+daTM6MAyn6TGH4bluRXORo6ZRCtPzEVsAVbOVoNzA8=;
        b=iqwXKiXBy/QmLohV8HdYfz7gN2eG08oii+mneuEAyxsmZrR1k3jmF+kUW+T6HVqf/t
         bsN0+OnhObLIyRQq59ne3Q84xTZcsUOKfu5bRL9L9FD2y/g0qFB2Upm8ivyj+VEnX80x
         3uCifVPKxb6hLEhq1Xg9/pc3awcooXRyJyI8UQAS9sNvaNXB6BBcJvLk1YgEBgyutUo9
         XDtCFlh8sjPUnCJCdgie4OqkORdNfqth0Qet3qysMs2GmtT2XdjUu5sLdVhJjJZP1y2n
         9wR90TB+QxK3kC08InHtuwnES6bZI0AhCoIB6dWzCrx65fXI8OvbYSaS+Vq4cePFBaAR
         VpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+daTM6MAyn6TGH4bluRXORo6ZRCtPzEVsAVbOVoNzA8=;
        b=wHuF0yRW6G5xYBiRhMj0vCFd14GmVxNdo8eugCnhcbK/c2Z026cDXd01CxTfvYfv8i
         nBrGL21IQmK/+ymysgVGsTP63VT+L9qvr/P6s4+pzTADajIAbjIq8UK4ox7V+AINfC9D
         koq86UPeV11Kiy4dDfY1iRusBcmINP5UBOK/VVGww2NkXIPslunP/UYvQu8feFhJSgxa
         gY7TIebeTPPrDJ6be39VU3fugB/L1x8vE/44vFJcvyw+b/XVwGEAhd76h+bYs5zI6Va9
         iBjz1NBAZSAOfST2w5u3NyUR8jUoHy39lCxRBY0bmYQHevUkBMGxIA0yrdc5fVqNiFbe
         KZcw==
X-Gm-Message-State: AO0yUKVvrmGHBOT42l0Yxrqsnif/z4GA6K7xg5+HOABOFVsByggBNgt/
        fcGWXW/RZpn7CSgvS8I/M1QIhqLRXm5DdjUshM7+GQ==
X-Google-Smtp-Source: AK7set9eKtUKZrbuZlTP3HmSYb0MYuYPJdfb4R6d32acFEFc8+4gwQw2tQR/lMPUBgTOvd5yoGN2WTwCxwGjvxZZcMI=
X-Received: by 2002:a50:aadd:0:b0:4fb:3dd5:e822 with SMTP id
 r29-20020a50aadd000000b004fb3dd5e822mr133832edc.8.1678823160105; Tue, 14 Mar
 2023 12:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com> <ZBBGGFi0U8r67S5E@dhcp22.suse.cz>
In-Reply-To: <ZBBGGFi0U8r67S5E@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 12:45:23 -0700
Message-ID: <CAJD7tkbaDeRP6-WuRGuRdhnOSV26=G_jhqMnejHQFGiT8VZ0bw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 14, 2023 at 3:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 13-03-23 14:08:53, Yosry Ahmed wrote:
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
> I would just stick with the existing code and put a comment that this
> function shouldn't be used in any new code and the folio counterpart
> should be used instead.

Would you mind explaining the rationale?

If existing users are not passing in tail pages and we are telling new
users not to use it, what's the point of leaving the PageTail() check?

Is page owner doing the right thing by discounting pages with
page->memcg_data =3D 0 in print_page_owner_memcg() ? Wouldn't this not
show the memcg of tail pages?

If page owner also needs a compound_head()/ page_folio() call before
checking the page memcg, perhaps we should convert both call sites to
page_memcg_check() to folio_memcg_check() and remove it now?

>
> --
> Michal Hocko
> SUSE Labs
