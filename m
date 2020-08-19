Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D824024A1FB
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSOsa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSOs0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 10:48:26 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5330C061757;
        Wed, 19 Aug 2020 07:48:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so20870525iln.1;
        Wed, 19 Aug 2020 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ApYOFSEYaJPt7kKwt38Kbe/M+l0V8+5a0AJxr5VRnc=;
        b=YYBHKawxqJQGH1DRcGNuNEl8HkABjzipt0mrQB7bCYB3X3HNFEjzrPeNzEydAioj/M
         DwVxkFmLmp6FYn7jLmVK819EibJcsnNXjaOcxdInSWq5tAKv62k7M0o5y4ysoqaF9BbV
         qphZCSByCz4tOwQ4m2IseIey1XrnftJYJn2p69QJBLHQc90jrKFj64a/XXMvuhpfRyGN
         XnKEk/0OPRCvmjVHuYH4zNer7uEKRmiXBGN9njK4kUWx3qyz6boBD4UioL22mwzjEwjt
         Oc5zDVyYkwMsJcnXux9zkSu9cM4OZg8KGChwRNkRqzHHlIxPITRBvJwd6qI/aGIExjjG
         jqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ApYOFSEYaJPt7kKwt38Kbe/M+l0V8+5a0AJxr5VRnc=;
        b=bFyWn4V9J9q6ymkUsc5rdSN3qZO3xWAEWKScp1/3NQ8lxMyD56G86p9bgkY//jBLpa
         5Km+NIZgSEti0BnTHKtvMW2h+OLzDIWVxzVl6Fi/uKf/7dNX+aHSch7++TCgB0mWsEx1
         pIBLIBDstOD0llXsXuIfkVFx982t1mQxOlfE+vHK8LX37/aNou/dpz1qwb4PaaCnDquS
         mSpLAnqbPgcPKWfW3dcWHOqoREjkCVv2/C0KlyjYki9Qfu96UGg85KsVBzV2oMovmjeV
         6kkbKBvgcGxeLOq4/asybxLQx9kArgrxU1pLTJBMbvvgQBpAuMnj3VYNec/s3+pyHNtz
         ikTw==
X-Gm-Message-State: AOAM530/3zxrku/Z+j+ITjsAR55KirUruJHlEXzNXPoNjXNFr2m+K3+j
        wNr++OH/kcm098lCQcQP6c97BHTdgaq8JgVxpJf0q+uArbI=
X-Google-Smtp-Source: ABdhPJzmEU0mpAvFX3yBtvh1+ob71cBaFPK3Zp+QxW5r94JaD4ZkLNuqIBncSh6+TTlYFpt1mGrwR4sv+irPX8Uoajs=
X-Received: by 2002:a92:ae06:: with SMTP id s6mr21501169ilh.64.1597848501986;
 Wed, 19 Aug 2020 07:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042705.23414.84098.stgit@localhost.localdomain> <20200819114309.GB17456@casper.infradead.org>
In-Reply-To: <20200819114309.GB17456@casper.infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 19 Aug 2020 07:48:11 -0700
Message-ID: <CAKgT0UfVdaMfg=TiiqOK1axUdmViEeaU+R8sisf5WpOKqa-65w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] mm: Identify compound pages sooner in isolate_migratepages_block
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 4:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Aug 18, 2020 at 09:27:05PM -0700, Alexander Duyck wrote:
> > +             /*
> > +              * Page is compound. We know the order before we know if it is
> > +              * on the LRU so we cannot assume it is THP. However since the
> > +              * page will have the LRU validated shortly we can use the value
> > +              * to skip over this page for now or validate the LRU is set and
> > +              * then isolate the entire compound page if we are isolating to
> > +              * generate a CMA page.
> > +              */
> > +             if (PageCompound(page)) {
> > +                     const unsigned int order = compound_order(page);
> > +
> > +                     if (likely(order < MAX_ORDER))
> > +                             low_pfn += (1UL << order) - 1;
>
> Hmm.  You're checking for PageCompound but then skipping 1UL << order.
> That only works if PageHead.  If instead this is PageCompound because
> it's PageTail, you need to do something like:
>
>                                 low_pfn |= (1UL << order) - 1;
>
> which will move you to the end of the page you're in the middle of.

Can you successfully call get_page_unless_zero in a tail page? I
thought their reference count was 0? There is a get_page_unless_zero
call before the PageCompound check, so I don't think we can get a tail
page.

> If PageTail can't actually happen here, then it's better to check for
> PageHead explicitly and WARN_ON if you get a PageTail (eg a page was
> combined into a compound page after you processed the earlier head page).
>
> Is it possible the page you've found is hugetlbfs?  Those can have orders
> larger than MAX_ORDER.

So in theory we only need to jump pageblock_order. However there are
some architectures where that is not a fixed constant and so it would
have some additional overhead if I am not mistaken. In addition we
should have been only provided a pageblock if i am not mistaken so the
check further down that prevents low_pfn from passing end_pfn should
reset to the correct value.
