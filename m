Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF0364674
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhDSOwF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhDSOwF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 10:52:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402CC061761
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 07:51:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id m16so25605909qtx.9
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YrZItNxcyVF3pVVkQf+v9BtikCFL0HmoCNCAuzegmSI=;
        b=OeaV6gvLZnnSgBj2hQod5raZF9ZCVqc92fxLKd1/xMoNPJ8BuhLxwWUWh8+peK+69U
         kI1zU+Mkv29pcKw8ycTns/9U9WSYJ5S0lLXBtik78Ge8J89sTvfInSRg7zaz2ionBo4n
         4/ZbXtklCKgJQsGKLDrpcG0VEV2Pn/ruArOnhvry0sjLSYDw6YJ4daItO8OQKpLcHcVF
         Gkx5U9d3BhiKjRxwCBT+XpjpBRWfajJm/aJMQ0cpLWChEy9HUks3monRWvAG7z8qog1B
         K+tc+tUPSqi9pwkYjzaOVkx0g0o0HyoxeFbTLiTANdgI7pnRZ2wdsg0zn1wIUNs5I7Rm
         PPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YrZItNxcyVF3pVVkQf+v9BtikCFL0HmoCNCAuzegmSI=;
        b=n3BDJM5/dnxFAn96cMYv99YAtQjHLWqfD/aWhRc+4GZ0+u4QQ7qNpYb6QauMePE6qV
         BLncoLNmJKVKlM4Hkgs7n/SIqz5tFLpkEwbV9M5OMbNG46UzPBKljHKClNigaXewxTYK
         3tWnfVEbOYP8501iZBgsGufMVS4JUDbAD2AvPyA0juHuz9on0TGoHtaPxuqSUUivLMiG
         fhnoevUCQhS4Xv47WqG27gRJybPvAyU+hz/qXr6sIppxRlpUOygzffbdSAmjlVyzFTM+
         tLqohsrNEOZWRbqYbX3Kq39j76tdqVgwxdL+gUjsLpx2k1vKuudzIaaEi1z00b7fc0qC
         BwZA==
X-Gm-Message-State: AOAM531yK6KSb+B+h+Bl237reEpyvMn4ZPwkrNuaSN1a+d3H9ciiFh/9
        BRxrjun99FUIc6csAuJ9pBdv9t+MxMmfcw==
X-Google-Smtp-Source: ABdhPJwgTtqjUODSsoN7NX5ycISGuptiWvpYG+cMmXmb3M9KNeN2Q10N0BGx/COKRyqsOZNYDEBAGA==
X-Received: by 2002:a05:622a:8c:: with SMTP id o12mr8561257qtw.367.1618843894148;
        Mon, 19 Apr 2021 07:51:34 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y26sm6570901qtf.66.2021.04.19.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 07:51:33 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:51:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Odin Ugedal <odin@uged.al>, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [RFC] docs/admin-guide/cgroup-v2: Add hugetlb rsvd files
Message-ID: <YH2Y9FucBW2GLLLQ@cmpxchg.org>
References: <20210416141146.542786-1-odin@uged.al>
 <YHn3cifQv1FUOqfU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHn3cifQv1FUOqfU@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 16, 2021 at 04:45:38PM -0400, Tejun Heo wrote:
> (cc'ing memcg maintainers)
> 
> On Fri, Apr 16, 2021 at 04:11:46PM +0200, Odin Ugedal wrote:
> > Add missing docs about reservation accounting for hugetlb in cgroup v2.
> > 
> > Signed-off-by: Odin Ugedal <odin@uged.al>
> > ---
> > RFC: This is linking from cgroup-v1 docs, and that is probably not
> > optimal. The information about the difference between reservation
> > accounting and page fault accounting is pretty hard to make short.
> > 
> > I think we have four ways to do it, but I don't know what is
> > most optimal:
> > 
> > - Link from cgroup-v2 to cgroup-v1 (this patch)
> > - Have a separate description for both v1 and v2
> > - Move description from cgroup-v1 to cgroup-v2, and link from v1 to
> >   v2.
> 
> This would be my preference but I don't really mind the other way around
> that much.

v1/hugetlb.rst is quite verbose, and some things are implementation
details. I'm not sure we want all that in the cgroup2 documentation.

My preference would be to first try to write a version of the doc in
cgroup2's briefer style, and then, depending on how that works out,
see whether we can delete (replace with link) the cgroup1 text, or
keep it for archiving purposes.

v1/hugetlb doc items that seem unnecesary to keep in v2:

- how to mount the cgroupfs, create cgroups, and move tasks into it

- the page fault accounting description could be compressed a
  bit. maybe drop the part about it being the admin's job to avoid
  sigbus by being careful with the allocations. that's obvious imo
  when you simply describe the sigbus semantics.

- likewise, reservation accounting can be briefer too. there is quite
  a bit of opinion in there that could probably be cut short. maybe a
  one-liner that says "mmap-time accounting gives userspace easier
  error handling - if in doubt, use reservation accounting" or so.

- caveats with shared memory: not sure this is needed at all, but if
  so, it can be a one liner saying "hugetlb uses the same first-hit
  semantics as the memory controller (see Memory Ownership)"

- Caveats with HugeTLB cgroup offline: this is an implementation
  detail that i don't think is actionable information for users
