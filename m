Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D076BC44A
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 04:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCPDRh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCPDRd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 23:17:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92678DCC1
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 20:17:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so2313655edb.6
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678936650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXNzovKLJVYy7gSWnrkduiiESPL+tnprAmERLJ9c4NY=;
        b=NRQD09/EkrkQfR7xQtFTEI9QJBiVxyflHtJW6z/y+NzHFWpQ8JaVK7xtttKCq7oNhY
         EhHdshdjxrDhdmDM32NOVhSuY5bTEeIo8qvtE6jUhidqSflnT32TvtkRVaXr4Uk6MnIi
         rx2KxeyAviXttBTLasD9xRHAKqCf1ZwnCTBg6yyDGtdlgO/qtgJfXLBVkOCgodk/4aTB
         L1L2+RRrS39zqUklhKnr7rxuTgnpdd+PW/l0td+cnb01CSRMWANJiC8flZDrXr1df7GZ
         AQnv7g6xchDTwjjZrZ7iX6E7rq0Xhi6Ac3KFGNgH2yXFoJPVX+mfcEl7E/7kqpCUBqp0
         e//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXNzovKLJVYy7gSWnrkduiiESPL+tnprAmERLJ9c4NY=;
        b=a+BIR1DPafhMcH7W5BHy61PTaRVqQVHHdNRMOVFpgjb/AD5WU/5M2pLH5j7rrbqXYr
         JeppOtqrt3NXRiVKa1Gd6QBZH2dnghz5m02To+R82nLbILdm2Rp5FzzeRqwSsWbUkQYo
         1Km6vCMBZhaJ4yrTpBpkcvtJK6AzyrBZQUA55J7vD5haUJbs1GsIhi+eZN8HEyT2rjw5
         U+3+mldIwp48IHvXcFCwzVN5FbU4ASG0q43EUEVReDrj4DktDOUIEg9KhDcC0uuHdJgw
         ely3H6T2WbAiRwh/V7XNteI+a+mdw53jXDc+8bvpdqQIrqv9GYNlZbWPp/1O+BmsRQVL
         kOIw==
X-Gm-Message-State: AO0yUKUqYw5ymrMD3oRUJ8OCqTba6SC8guher2e+doqBe45yQUZDZRGk
        3KT+kp2yjQgVDS3oQ1V7sJZOHOlws6xHezFfXbqUVA==
X-Google-Smtp-Source: AK7set/h2/dgQJJuWVarM/ber+1Pe8UMuGZwhHp+NyLXjg8sR9O2WcSdO3vG3IioT48FKIjJDrYBmNYgBrlyOTaC04g=
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr4529176ejb.15.1678936650086; Wed, 15
 Mar 2023 20:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <ZBFPh6j+4Khl1Je8@casper.infradead.org> <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
 <ZBG3xzGd6j+uByyN@casper.infradead.org> <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
 <8d4e1b74-6ae8-4243-d5c2-e63e8046d355@redhat.com> <CAJD7tkbNtJHse5BH=FzgRGUW=oLLoORb7yb8xqUFhF097zDLyg@mail.gmail.com>
 <ZBKH3xT3FesWeX2c@casper.infradead.org>
In-Reply-To: <ZBKH3xT3FesWeX2c@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Mar 2023 20:16:53 -0700
Message-ID: <CAJD7tkZ_RuZFpJd2raK_y6CxwGMa7uo1QXxO7Od5iORZH8ixpw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Mar 15, 2023 at 8:07=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 15, 2023 at 05:25:49PM -0700, Yosry Ahmed wrote:
> [snipped 80 lines.  please learn to trim]
> > I think instead of explicitly checking page->memcg_data, we can check
> > PageTail() and return explicitly for tail pages tails, check
> > PageSlab() to print the message for slab pages, then get the page's
> > memcg through folio_memcg_check(page_folio(page)).
> >
> > Something like:
> >
> > static inline int print_page_owner_memcg(char *kbuf, size_t count, int =
ret,
> > struct page *page)
> > {
> >     ...
> >     rcu_read_lock();
> >
> >     /* Only head pages hold refs to a memcg */
> >     if (PageTail(page))
> >         goto out_unlock;
> >
> >     if (PageSlab(page))
> >         ret +=3D scnprintf(kbuf + ret, count - ret, "Slab cache page\n"=
);
> >
> >     memcg =3D folio_memcg_check(page_folio(page));
> >     if (!memcg)
> >         goto out_unlock;
> >     ...
> > }
> >
> > Matthew, What do you think?
>
> Brrr, this is hard.  read_page_owner() holds no locks or references,
> so pages can transform between being head/tail/order-0 while we're
> running.
>
> It _tries_ to skip over tail pages in the most inefficient way possible:
>
>                 if (!IS_ALIGNED(pfn, 1 << page_owner->order))
>                         goto ext_put_continue;
>
> But any attempt to use folio APIs is going to risk tripping the
> assertions in the folio code that it's not a tail.  This requires
> more thought.

Ugh yeah. I thought the worst that could happen is that if a page
becomes a tail page after the PageTail() check, then we will not skip
it and we will read the memcg from the head instead, which shouldn't
be the end of the world. I missed the fact that the folio returned by
page_folio() can change before folio_memcg_check() gets to read its
memcg_data.

I guess this race exists with the current implementation as well.
page_memcg_check() will check for tail pages then cast the page to a
folio. If the page becomes a tail page after the PageTail() check
inside page_memcg_check() we risk running into the same situation.

(FWIW folio_memcg_check() doesn't seem to have assertions for tail pages to=
day)
