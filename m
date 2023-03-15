Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BC6BA661
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 05:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCOEzC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 00:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCOEzB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 00:55:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744732DE69
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+5eAySqKu8quKYezY1WSwvPjQogNyS4CVabFURW422s=; b=UWGc5iC75MwzhUe32/obZHoEYG
        9HjdVRVyOT+5NNcsHuT4FIPSntudhDB+Hgm6nvg3LhHaV6+X/rY0guINYcagEHA+zoOv3XH2qHZz9
        LbyQhGU+JajvQR9XMZcIpjljLyVBelZ9bFku4mgr0ZuPjIrTQ9yWFJBFp7sJ5aM5DjqfU//miQHgN
        4ocintfUcutJkUpO4tA/63ctHJK09HPIxI8yc1uClbZx6j9x5L1Tn+7bS9w8NIW5u8MYMU0bMNeeH
        vpLBwN4QDES2yrycumMTX+yG7sWHV1ffrOAsXryr1kYMDPKEom0KAGk845XZhgiliAum9WYD/DM9R
        cfNTeG5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJ9j-00DXS8-Fq; Wed, 15 Mar 2023 04:54:31 +0000
Date:   Wed, 15 Mar 2023 04:54:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-ID: <ZBFPh6j+4Khl1Je8@casper.infradead.org>
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

If you look at my commit becacb04fdd4, I was preserving the existing
behaviour of page_memcg_check() when passed a tail page.  It would
previously, rightly or wrongly, read the memcg_data from the tail page
and get back NULL.

I suspect that was not the intended behaviour, but I do not think this
patch is the right fix; it simply papers over the problem and maybe
creates a new one.  Callers of page_memcg_check() should be eliminated,
precisely because of this ambiguity.  It's up to the people who understand
each of the callers who need to make the decision to always convert the
page that they have to a folio and ask about its memcg, or whether they
want to preserve the existing behaviour of returning NULL for tail pages.

So, I say NACK to this patch as it does not preserve existing behaviour,
and does not advance our understanding of what we have wrought.
