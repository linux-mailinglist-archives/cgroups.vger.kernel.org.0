Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA426BA5B1
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCODl1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCODl0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 23:41:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EC5CC01
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:41:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so40177263edb.0
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678851683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqjNzfEl6/soQ303j8VicjxqLu+8Pdbe2K2IwqybTZ4=;
        b=iSEoWq8zG/XKNq2+fbe3RXpE91OOk3YVSEIyPM9ABQM4pahRYJI1NL5J/hoZgboRLw
         hGhGQ3Y/QRowLilPx+6Fi+usDRlxoH51Be9IiwN8Dkjk3xJTZ0VQ6zYyGff/FbyWRiYd
         9FoM7TjRgazH8K2U7SloDG4bIphe+Cx6Z1Y1rPZz3DQL0b0U79QAwbOkP1T4Vx9+7H0e
         PHrx2lp5Ks7Hv3AVICtUx/K1/gE6hfODeDrCe2+Dyn+mG4Y07GO0AeuQ4oW8ptay+pXK
         DPSjPdAWw40PkNKCdbyojegoUrV2sZJ6Ezuvgi4CDvEVfsMncfzHDbxCJQ0Y7LJwdUhm
         TW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678851683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqjNzfEl6/soQ303j8VicjxqLu+8Pdbe2K2IwqybTZ4=;
        b=dSW2IhwA5OIXM3Jj/9T77dEzX3Rc9qDJ2kZxtPlm9L76kbLLIIrHiqH905q/m00Zu8
         D4Rlc3ejNtos0YuVmQTmPWnxsHn7w95bi7qPiisp8jBA3GjQ7x3vAa8dv6TtwyNqiHkv
         xyHAswObUeZ88nVk0opLWv4ZbEUybL9NGBix7dqRe+lHHG5xrvwHoJFfm02VEi4Q/x5S
         7LIjc6JsUgEdZhNS9gQkf6t1wnTIH9eQZ4ENoCV/zsc6Jcnj7tTCOuddNwBokWaHorTz
         AUfXpwWNhsIGSt8V5OXT86QiI+HhBzraq72gJhrfO9jCQtBjVbK1kWeW25HWwLkx5ChL
         AjuQ==
X-Gm-Message-State: AO0yUKXjNnWhGTWsK/oJBx3LcaIHVlz7PVfLfKeaPcM0RWvPA4Fo5CI6
        OlDCm6CvA8bZEGMkjp8oqsHvziiIkcIPwSJf6uYQew==
X-Google-Smtp-Source: AK7set+9l7zC23IDId6r5OFXoHMsftuP51Uxgih67PxLxlFV0R0nTazODh0I27/MWJEDeS4jnrSpmSkmVBAO+koIwAE=
X-Received: by 2002:a17:906:57cd:b0:926:b9dd:38f8 with SMTP id
 u13-20020a17090657cd00b00926b9dd38f8mr2457635ejr.15.1678851683321; Tue, 14
 Mar 2023 20:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <61e8e6d3-697e-f9a5-a1fb-45a3448ee5db@redhat.com> <CAJD7tkYm25ohS_P1Q6mzZMHJp4Hjwr3LqLaiPA3NFpa1gfOdJw@mail.gmail.com>
 <84d8fd38-f05c-73f5-ef50-fcac524097f3@redhat.com>
In-Reply-To: <84d8fd38-f05c-73f5-ef50-fcac524097f3@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 20:40:46 -0700
Message-ID: <CAJD7tkaFdi4gb9Y-SZGxmwCM1ev2JZ_A2h_b_asnpDH4jYPYPQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Waiman Long <longman@redhat.com>
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

On Tue, Mar 14, 2023 at 8:33=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/14/23 23:10, Yosry Ahmed wrote:
> >>> The only other user today is print_page_owner_memcg(). I am not sure
> >>> if it's doing the right thing by explicitly reading page->memcg_data,
> >>> but it is already excluding pages that have page->memcg_data =3D=3D 0=
,
> >>> which should be the case for tail pages.
> >> It is reading memcg_data directly to see if it is slab cache page. It =
is
> >> currently skipping page that does not have memcg_data set.
> > IIUC this skips tail pages, because they should always have
> > page->memcg_data =3D=3D 0, even if they are charged to a memcg. To
> > correctly get their memcg we should read it from the
> > compound_head()/page_folio().
> The purpose of that function is mainly to report pages that have a
> reference to a memcg, especially the dead one. So by counting the
> occurrence of a particular cgroup name, we can have a rough idea of
> that. So only head page has relevance here and we can skip the tail pages=
.

I see. If you update the code to not check memcg_data directly, and we
update page_memcg_check() to return memcg of the head page, this will
stop skipping tail pages. Is this okay?

If not, we can explicitly skip tail pages in print_page_owner_memcg()
if we decide to check the head's memcg in page_memcg_check().

> >
> > My 2c, we can check PageSlab() to print the extra message for slab
> > pages, instead of reading memcg_data directly, which kinda breaks the
> > abstraction created by the various helpers for reading a page memcg.
> > Someone can easily change something in how memcg_data is interpreted
> > in those helpers without realizing that page_owner is also reading it.
>
> You are right. We should be using a helper if available. I will send a
> patch to fix that.

Great, thanks!

>
> Thanks,
> Longman
>
