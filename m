Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC46BA543
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 03:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCOCeh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCOCeg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 22:34:36 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [IPv6:2001:41d0:203:375::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D278222E8
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 19:34:34 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:34:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678847672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbW+Qz+GPh9oxvtGy6lpbTi92iahxf+9WiV70Tu5/B0=;
        b=mlqh3Uuo8+My+UJvFW5MVIQ+o4rKsT/5XvjwyVBnNc7AZrlYyFKlYPC4kQkZdHK9ttm8jI
        8rhoyXtVySZHzFZyM+M2mrbe8ntBQyyPqi+a4zAp8xdh1mfrRiOc4KslUEWdv/p9q5O3Um
        8dCno8bYbK4DK7KisNitjXdeCH/L8qU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-ID: <ZBEusOt3onLa30Hm@P9FQF9L96D>
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 13, 2023 at 02:08:53PM -0700, Yosry Ahmed wrote:
> On Mon, Mar 13, 2023 at 12:44 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > From: Hugh Dickins <hughd@google.com>
> > >
> > > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> > > observed a warning from page_cgroup_ino() when reading
> > > /proc/kpagecgroup.
> >
> > If this is the only known situation in which page_memcg_check() is
> > passed a tail page, why does page_memcg_check() have
> >
> >         if (PageTail(page))
> >                 return NULL;
> >
> > ?  Can we remove this to simplify, streamline and clarify?
> 
> I guess it's a safety check so that we don't end up trying to cast a
> tail page to a folio. My opinion is to go one step further and change
> page_memcg_check() to do return the memcg of the head page, i.e:
> 
> static inline struct mem_cgroup *page_memcg_check(struct page *page)
> {
>     return folio_memcg_check(page_folio(page));
> }
> 
> This makes it consistent with page_memcg(), and makes sure future
> users are getting the "correct" memcg for whatever page they pass in.
> I am interested to hear other folks' opinions here.
> 
> The only other user today is print_page_owner_memcg(). I am not sure
> if it's doing the right thing by explicitly reading page->memcg_data,
> but it is already excluding pages that have page->memcg_data == 0,
> which should be the case for tail pages.

Yeah, I think it's a good idea. I'd do this.
If you'll master a patch like this, please, apply my
Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

I'm ok with the current approach too (the one you posted),
but the one above is preferable.

Overall it would be nice to clarify & document our expectations
from /proc/kpagecgroup (and /proc/kpageflags & /proc/kpagecount)
in the new folio "epoch".

Thanks!
