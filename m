Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02016B9FF1
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCNTr0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCNTrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 15:47:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320F3B0C6
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 12:47:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so22887639ede.8
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678823242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymirTRxwbZQp/WI7tLX5TT7V+4ZKW/bISSqdyL1vwos=;
        b=WXNHJYnIZ6IjKcOY12Om6CpN+58aNbKlcseAeURPC+lFMGOSKQgkeWM9qQh2ztAvRu
         h+v9SV/n5R5NjnMjctqPZa7qc7j+IGbSqwfFSR4K7jJ/hqyt+5LTu2UJV8x0JBj57Z2/
         lVPHmSIbX7x+jmSKP8Wm/pqI/btlFtg73dZT2Kke8veHxT0WGCTcB2WPv1PTvAqOjKo4
         s05wEgmDkcSRosQabYb4FvWHq+duQqJ/JEelQJgfSzgrsCwTEeLSEGPL52/h1LcKWgjA
         alJgO5pqGsK19+LI46gE5sybvp6k0CSoAR7rfkgUzwGWOb7aKuE7xp7Mrf5wXQ16zSEP
         A8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymirTRxwbZQp/WI7tLX5TT7V+4ZKW/bISSqdyL1vwos=;
        b=RgwlCZ2f91N9kDEgL2g503cEhd+UByVYz79ggoi5B2ZOXJN4bKPzWqqKp4hM+gitnF
         izmxzelBkluEFL0Oqz4fIaW0Jm+GdF+VBBRrw5bXLk0KTUF+XuF+SyeMU3kE2+m74ev6
         oCuDCa0Feij8o0+BMt6VsYaRM4TLwYdwPWn92SSssOQttmKbX689674W5OzKwm1RLieU
         FkwytRMyjVaqeHXUnEgutak/1vuGb62yTk1gWcrtx19jUenDfvVFO8wZ6e4WamXqwQV+
         fcYeGkwGyivYVtEibXbq3AWijWJxhiePs6G0+6PfroNMzLUjYxwGN6lgWIWtOCdoZYEU
         j9Ew==
X-Gm-Message-State: AO0yUKVudcRhiW3GdUHyNO/kL0P4M1Mooxdpf2rpv1nr6g0034Dd+2dX
        nuXGFXjoOmEhpcNZmkaR/E37bKQP9NaMnCTn4ek/hA==
X-Google-Smtp-Source: AK7set/Nz594oG/5QQhJezRK/LbUoGxQiWecr2ekIbNWGsmJoMaflKKKbDfMtse+lMYBtHBgGLSln4ppaWMrfTC4u/U=
X-Received: by 2002:a50:baad:0:b0:4f9:ca99:cf56 with SMTP id
 x42-20020a50baad000000b004f9ca99cf56mr146364ede.8.1678823241828; Tue, 14 Mar
 2023 12:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <ZBBGGFi0U8r67S5E@dhcp22.suse.cz> <CAJD7tkbaDeRP6-WuRGuRdhnOSV26=G_jhqMnejHQFGiT8VZ0bw@mail.gmail.com>
In-Reply-To: <CAJD7tkbaDeRP6-WuRGuRdhnOSV26=G_jhqMnejHQFGiT8VZ0bw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 12:46:45 -0700
Message-ID: <CAJD7tkZLLqdf+tFEErFxh5SdANxwtEpf7WyzjAEq7DXr-ZLMUQ@mail.gmail.com>
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

On Tue, Mar 14, 2023 at 12:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 14, 2023 at 3:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Mon 13-03-23 14:08:53, Yosry Ahmed wrote:
> > > On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > > >
> > > > > From: Hugh Dickins <hughd@google.com>
> > > > >
> > > > > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check=
(), we
> > > > > observed a warning from page_cgroup_ino() when reading
> > > > > /proc/kpagecgroup.
> > > >
> > > > If this is the only known situation in which page_memcg_check() is
> > > > passed a tail page, why does page_memcg_check() have
> > > >
> > > >         if (PageTail(page))
> > > >                 return NULL;
> > > >
> > > > ?  Can we remove this to simplify, streamline and clarify?
> > >
> > > I guess it's a safety check so that we don't end up trying to cast a
> > > tail page to a folio. My opinion is to go one step further and change
> > > page_memcg_check() to do return the memcg of the head page, i.e:
> > >
> > > static inline struct mem_cgroup *page_memcg_check(struct page *page)
> > > {
> > >     return folio_memcg_check(page_folio(page));
> > > }
> >
> > I would just stick with the existing code and put a comment that this
> > function shouldn't be used in any new code and the folio counterpart
> > should be used instead.
>
> Would you mind explaining the rationale?
>
> If existing users are not passing in tail pages and we are telling new
> users not to use it, what's the point of leaving the PageTail() check?
>
> Is page owner doing the right thing by discounting pages with
> page->memcg_data =3D 0 in print_page_owner_memcg() ? Wouldn't this not
> show the memcg of tail pages?
>
> If page owner also needs a compound_head()/ page_folio() call before
> checking the page memcg, perhaps we should convert both call sites to
> page_memcg_check() to folio_memcg_check() and remove it now?

.. or add page_folio() inside page_memcg_check() as suggested initially.

>
> >
> > --
> > Michal Hocko
> > SUSE Labs
