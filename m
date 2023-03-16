Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052346BC438
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 04:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCPDIr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCPDIZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 23:08:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BAD18B14
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GaBSB/q5RZZv1uL/3Gq3Md5Uoooa7QyxjRaawK+7oNc=; b=W5oNDduDSzHnSn/lHr3XclBBJs
        ZPwReYpP5TY0WawtqJ8+3M0EJlPasIOJQegxsnYSkfDL1mQalzoPS437vUWx0UptRdGYEzzETqQXW
        1agZd7h7fAJWQeMKqlJGAo0q7NKtDOe+2tFErdTQMPlmS7hWIy8aV3OrZiVfoluTY74Sfl8wIxPJ7
        BGcCxUJnSKrzodiaIL5vNpzajhQOjG/YhGUpIY5TUk+0SQLu6n+ryw2HbCK+zVely58ba+rYjdEvl
        egKlXwNA1WRqkm2+pvtvzLHm/wty6mlE8f5UobHyTwcLExFjqmuEWPL+V5B/Dipi0651gmPshUgzf
        YE8v/lRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcdxP-00EQIS-Vc; Thu, 16 Mar 2023 03:07:12 +0000
Date:   Thu, 16 Mar 2023 03:07:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-ID: <ZBKH3xT3FesWeX2c@casper.infradead.org>
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <ZBFPh6j+4Khl1Je8@casper.infradead.org>
 <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
 <ZBG3xzGd6j+uByyN@casper.infradead.org>
 <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
 <8d4e1b74-6ae8-4243-d5c2-e63e8046d355@redhat.com>
 <CAJD7tkbNtJHse5BH=FzgRGUW=oLLoORb7yb8xqUFhF097zDLyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbNtJHse5BH=FzgRGUW=oLLoORb7yb8xqUFhF097zDLyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 15, 2023 at 05:25:49PM -0700, Yosry Ahmed wrote:
[snipped 80 lines.  please learn to trim]
> I think instead of explicitly checking page->memcg_data, we can check
> PageTail() and return explicitly for tail pages tails, check
> PageSlab() to print the message for slab pages, then get the page's
> memcg through folio_memcg_check(page_folio(page)).
> 
> Something like:
> 
> static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
> struct page *page)
> {
>     ...
>     rcu_read_lock();
> 
>     /* Only head pages hold refs to a memcg */
>     if (PageTail(page))
>         goto out_unlock;
> 
>     if (PageSlab(page))
>         ret += scnprintf(kbuf + ret, count - ret, "Slab cache page\n");
> 
>     memcg = folio_memcg_check(page_folio(page));
>     if (!memcg)
>         goto out_unlock;
>     ...
> }
> 
> Matthew, What do you think?

Brrr, this is hard.  read_page_owner() holds no locks or references,
so pages can transform between being head/tail/order-0 while we're
running.

It _tries_ to skip over tail pages in the most inefficient way possible:

                if (!IS_ALIGNED(pfn, 1 << page_owner->order))
                        goto ext_put_continue;

But any attempt to use folio APIs is going to risk tripping the
assertions in the folio code that it's not a tail.  This requires
more thought.
