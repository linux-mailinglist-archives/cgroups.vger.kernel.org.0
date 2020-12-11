Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA082D779A
	for <lists+cgroups@lfdr.de>; Fri, 11 Dec 2020 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395257AbgLKOQJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Dec 2020 09:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405550AbgLKOPj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Dec 2020 09:15:39 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92CC0613D3
        for <cgroups@vger.kernel.org>; Fri, 11 Dec 2020 06:14:59 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id p21so1871526pjv.0
        for <cgroups@vger.kernel.org>; Fri, 11 Dec 2020 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f1oHmcol2mHx6bC5gFH8ezh95GR9pifCliLgoZXiHI=;
        b=Bzgx3oPWqgw2n1k0AK1q+w30PZWgSi1dqKV5jw4NTUlxXSt/Em/bVVrqnzOIlv2DBr
         fjVuO3tsgvvmQZXK8pbVfZGMi5nU1uZGf1M1er6k2a0orAK6Q5bUSNTN7OkFM7LX8abp
         qcAPpTeDQaBnKIIg7RisfNNKMSBGR05hlFYUQeX4Lrrzo7olSSxraRJiRhPjAlTwwle6
         GkPMDER0cf/tv5691W+YJs5CjQVWbTBgYzNJTYFqgH0KFlQro1pPQAw1eB47CptCcgsn
         5zvRtWb/qbSs9IZWA4zUdMkPOK9ReXwzcO6X9zb51a0t10AV6YQYrW+R5nCR/WVstc2O
         ixuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f1oHmcol2mHx6bC5gFH8ezh95GR9pifCliLgoZXiHI=;
        b=nB5SGc6taNA0t+Z4ooOq2V42hYubwV7gVvF9DB00XKF14PiJDqZvqPftPNb9jPriH0
         9b6fTFmqcqJukQIoseJA7GIOHROV0MfgcjdWnZkUD9Kk1Lewd9Y5zZTMyo6X0nMBS9hy
         KJ22HueykF2C4kb6LlhbzD3/7htfYbfXzIGatFCRSjFv0ReCInx2anewhiGaJLK+Qm7H
         OOwXtlOe3poyttDL5HKg97JBh820vlYLZu9ELnIHs5WaSCducPd9h8fF0SE1DU6axwYc
         2AA8y9pqUZtkFXxWLz4W+lKaNu+VNkJ6Y1N//y66t43eGthB1P9KH20znmEmafdLdNEH
         aW0A==
X-Gm-Message-State: AOAM532PyMuYnU+QcMNhjeZbd0gG5GLsjHdjMEsFxaYnKycqDId+pSO3
        zLJf4RZS9gpYv+mhHQ1YoeiuyWfRmMt3AM5BWJStgQ==
X-Google-Smtp-Source: ABdhPJzFtHnSD7yguh0R/UPqyIWabyj8rwu4adQbmM5SUJFG7UlQpVcwg63WOndZqN2uDqjudVC4YaWLzSNwdIGIi84=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr11319858pls.24.1607696099031; Fri, 11
 Dec 2020 06:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20201211041954.79543-1-songmuchun@bytedance.com>
 <20201211041954.79543-4-songmuchun@bytedance.com> <20201211135737.GA2443@casper.infradead.org>
In-Reply-To: <20201211135737.GA2443@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 22:14:22 +0800
Message-ID: <CAMZfGtVYkkoQc+VsMPj-_FWAZmQOhme4QD0vJ9cDZNMsTg2jPw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 3/7] mm: memcontrol: convert
 NR_FILE_THPS account to pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 11, 2020 at 9:57 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 11, 2020 at 12:19:50PM +0800, Muchun Song wrote:
> > +++ b/mm/filemap.c
> > @@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
> >               if (PageTransHuge(page))
> >                       __dec_lruvec_page_state(page, NR_SHMEM_THPS);
> >       } else if (PageTransHuge(page)) {
> > -             __dec_lruvec_page_state(page, NR_FILE_THPS);
> > +             __mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
>
> +               __mod_lruvec_page_state(page, NR_FILE_THPS, -nr);

Thank you.

>
> > +++ b/mm/huge_memory.c
> > @@ -2748,7 +2748,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >                       if (PageSwapBacked(head))
> >                               __dec_lruvec_page_state(head, NR_SHMEM_THPS);
> >                       else
> > -                             __dec_lruvec_page_state(head, NR_FILE_THPS);
> > +                             __mod_lruvec_page_state(head, NR_FILE_THPS,
> > +                                                     -HPAGE_PMD_NR);
>
> +                               __mod_lruvec_page_state(head, NR_FILE_THPS,
> +                                               -thp_nr_pages(head));
>

Thanks.

-- 
Yours,
Muchun
