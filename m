Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9082B6B83BC
	for <lists+cgroups@lfdr.de>; Mon, 13 Mar 2023 22:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCMVKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Mar 2023 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMVKN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Mar 2023 17:10:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2024487
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 14:09:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so54021491edb.12
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678741770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlBkJK/x7/8YyJiF20jdzTRn8hgNL0nBlwjb2kxzy2s=;
        b=L4JWVhvyZWCF4cgwpgIXArKcdLYPq0qd5QJjDzWuDe23O+CD4GTBk6scii3kW10Yt8
         6Ws9/hqGin1e/JljVTjGAaWBsZxk4MKzMxc+9OsHYOg3Iqpl7L9l7/th2+71fabvxtyi
         wJjHNVwEQiVzqxQlKqhk1FFubtpxnhsg7HgInTzGDXHABpYRmkf5NSmu7EAaGMt7fD3o
         PE0s1zWoezTpC79MyfRjjkec/fBpG1Bv0meCD1hVkI1BEnmJC0vmGMdr3k13NY7SWPpf
         /qJ0B+jUpyx6EG0BUMy04FA3G/LMMq7UuDD5+QZH9klqx5U5pnafS0FlHOw/hl6Q5N9m
         4bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlBkJK/x7/8YyJiF20jdzTRn8hgNL0nBlwjb2kxzy2s=;
        b=fieQlhwpmxuqc5rrQOZTTsHUNbImsnxeMFCDebeoTxDYbOe3TMZOPF3dcOghB03WUn
         Q8OIL/LcoQpW4fPqgJ6x+tGlwQj3gF1uaKWUpahcsAekfRxYsT4elCEUkJlsvoyeqpJk
         HgfjQW/bUyZ9UNL8NDuuwgh9jhK3vMtn61dZ7Oyb57ef1EGuy7Z5Lvzck3YupR3GqILL
         T1nUjwtczL39VMuHyhE6DNnw5nqkzRGOH+4ccB5YGbsQBgojs4jgvwUZkvpW9ViW50Pw
         61Qco3XTkgvKZzWYu3WrmtLDN9u4E5MfnwqF5z0evNQo6cMAS+D5+btHHZLoWTxpQZXq
         yGIA==
X-Gm-Message-State: AO0yUKWoHitAuBbLBB/Zj/anVDkFYiQLwqocCtFNK4MDIEmI2w5Zhlmq
        Q/Vbyl+7Im0CN647hcqW5aanpPC8UfAMEfbKkYfBMQ==
X-Google-Smtp-Source: AK7set9qdhE1ELX/zNMnE9ZNJ/4swjw0LO1jBJyI6eHbNF/FPCUNIrfA0E4eAG5+Endk8rgyq+2Bz4I8b/3jCAAysS0=
X-Received: by 2002:a50:d5dd:0:b0:4fc:473d:3308 with SMTP id
 g29-20020a50d5dd000000b004fc473d3308mr2576351edj.8.1678741770203; Mon, 13 Mar
 2023 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com> <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
In-Reply-To: <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 13 Mar 2023 14:08:53 -0700
Message-ID: <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
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

On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > From: Hugh Dickins <hughd@google.com>
> >
> > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> > observed a warning from page_cgroup_ino() when reading
> > /proc/kpagecgroup.
>
> If this is the only known situation in which page_memcg_check() is
> passed a tail page, why does page_memcg_check() have
>
>         if (PageTail(page))
>                 return NULL;
>
> ?  Can we remove this to simplify, streamline and clarify?

I guess it's a safety check so that we don't end up trying to cast a
tail page to a folio. My opinion is to go one step further and change
page_memcg_check() to do return the memcg of the head page, i.e:

static inline struct mem_cgroup *page_memcg_check(struct page *page)
{
    return folio_memcg_check(page_folio(page));
}

This makes it consistent with page_memcg(), and makes sure future
users are getting the "correct" memcg for whatever page they pass in.
I am interested to hear other folks' opinions here.

The only other user today is print_page_owner_memcg(). I am not sure
if it's doing the right thing by explicitly reading page->memcg_data,
but it is already excluding pages that have page->memcg_data =3D=3D 0,
which should be the case for tail pages.

>
>
