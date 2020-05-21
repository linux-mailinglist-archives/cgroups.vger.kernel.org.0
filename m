Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17631DD67D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgEUTA2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgEUTA1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 15:00:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF90C061A0E
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 12:00:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so9655412ljj.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXqOJl5SmNS23EUn7DmXTUU6aYLgyfPvo+AUamH08Ps=;
        b=EV5SVn70MuPiXaA+/GpI4b2qrg0jB93InY/vaKKkvXw3rt6V19F3iaEfufdWjb2vSa
         LFgwuEMLZ0kF+u4vLem/Ho+YYOlDTSymGzxy0FWxZiHOsB3Pb3GSFPQ6THq8MehoMw81
         61D12qPxoVMXCVN5YnrMpoSh0ZCOqjVhvK2/icCRVt/PPsd4BcWFGL0kAP/7zDq1hN3x
         a1rzoPThWH5HcKX0GiUC4cxi3kkuCMXpV76kYKiXipe6YgwkiIKVt/YehTDSxdT8FKMQ
         CKv5YcXmrRHEWyhnCcxlLCZV3yGZBNkQfBJxwnNbBjgGPVYWSZIk3apxM0beTrE2kQJt
         vtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXqOJl5SmNS23EUn7DmXTUU6aYLgyfPvo+AUamH08Ps=;
        b=e7wqL36kFyNJ8xPpuw02nsYf4uqAvxCQelREraE6g7BXbGueZWpmyW/4OshkNFhD8w
         5ebHT+6AQf1xjcaMjuBfmqX46BsllLQySqZfQLODvDnK+nk8VmQbgydn30eRp9Tk2kcI
         jCm+uD/hdL701qcW5vzQXXm7mE3twW+F9Xm0c8K+cq7y5ayboUdaJRFUl4XZ+C2TFQqJ
         oHBwTUjfTKnu77HR2aH7vy/SwyTepK6FpxqUxhgKU8l6GPBlu1cJHjETyzJbIz/dt77t
         oYDbRzvTfJKupn+Nd6YRO+QuaknGDYkCW8u2hBuUdVnVHKnJS1ucFA3vZkSvXscMPR51
         9HaQ==
X-Gm-Message-State: AOAM5303bFa642f7Q3+G102Mq+CIv7knhUKtSMs1Su2e42CkxqBriUlN
        1DqGzUhdjN/uCPV4kONwj3yLPeeQTpWbbkz7tabF0w==
X-Google-Smtp-Source: ABdhPJztzAYrR/hpe1uRAGQjKmg0ls00XHM6k9/5+3Vj5L9HrQE3V1E3er3ujQPjsfP8Tn3nR1o1fnGVTi8pnw7kWuo=
X-Received: by 2002:a2e:6c0c:: with SMTP id h12mr5664520ljc.266.1590087625478;
 Thu, 21 May 2020 12:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
In-Reply-To: <20200521163450.GV6462@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 May 2020 00:30:13 +0530
Message-ID: <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 21 May 2020 at 22:04, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 21-05-20 11:55:16, Michal Hocko wrote:
> > On Wed 20-05-20 20:09:06, Chris Down wrote:
> > > Hi Naresh,
> > >
> > > Naresh Kamboju writes:
> > > > As a part of investigation on this issue LKFT teammate Anders Roxell
> > > > git bisected the problem and found bad commit(s) which caused this problem.
> > > >
> > > > The following two patches have been reverted on next-20200519 and retested the
> > > > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > > > ( invoked oom-killer is gone now)
> > > >
> > > > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > > > protection"
> > > >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > > >
> > > > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > > > checks"
> > > >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> > >
> > > Thanks Anders and Naresh for tracking this down and reverting.
> > >
> > > I'll take a look tomorrow. I don't see anything immediately obviously wrong
> > > in either of those commits from a (very) cursory glance, but they should
> > > only be taking effect if protections are set.
> >
> > Agreed. If memory.{low,min} is not used then the patch should be
> > effectively a nop.
>
> I was staring into the code and did not see anything.  Could you give the
> following debugging patch a try and see whether it triggers?

These code paths did not touch it seems. but still see the reported problem.
Please find a detailed test log output [1]

And
One more test log with cgroup_disable=memory [2]

Test log link,
[1] https://pastebin.com/XJU7We1g
[2] https://pastebin.com/BZ0BMUVt
