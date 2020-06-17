Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4841FCEAB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFQNhg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgFQNhf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 09:37:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9FEC0613EF
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 06:37:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so2891871ljn.6
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqR44w8izx/KE5EkQ1Ws5ETNchnRTHELluIzCKgLjZQ=;
        b=AQDHF9j1wumEdOF8jW/1ZD+wMd/8SpKXUSrLOHAhi0A44X1JaVVNvxPIvK23AWFQl1
         lcfd2qLeHyI1mOR56hQwvpPqFkxdvrqlLEDd85my4N1iUDfAlgcF8AzsgKWBK3zrgNCe
         FfcZd/NGkaf2Mw5/0Wi7/NN8GlYj/dE1H3Y2K/UdByyIhfAVRQSJIdp1UXJN3EirQcCx
         gGhwwgc+eOdRDRZohnKU4obNcVnQwSt7TB0Y31V6blCHXIgexA++Mbo6gO8D5gHDGqpn
         e08UA7hYCS3YGjFr+hICEEExE+bXh2EV+2ZuVFnYmW334FTROJKMWUws6mNfrG1VlVfC
         NXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqR44w8izx/KE5EkQ1Ws5ETNchnRTHELluIzCKgLjZQ=;
        b=Dh/zaM1rS7BRPHFtCePLr6KIEYVu5P/R4dZVD8KAiYdOL/uT3Okg1rXWCYsILKlmLC
         Riknz/HVxGz4GetRqJ6niNl6q7OUu0g13fm2TbLvovlolPQthhNLiuX1NhfP6+jqU3WZ
         qdOuss7Yc2qabcrYgvF7tMVz2Jp1NetcqgtpAp5saXvvMvW3IZ6NuuxD1WjwwQPMGDuL
         1XtVmn3MGp4MhbDACiHvNkFgxrcJChyskHejtOzb273YLyjx4zpiXVPpNA5JScDwt3Yi
         rXY0WXq65mO0CjluEZnCkQZNDIuDBWrIw3v3hg+tJQNhxEyNck1BR90Io5/nAFPC902W
         0V2Q==
X-Gm-Message-State: AOAM5321LyVdQm8gHuDdjXtkPZjLqFy5UFLKOl7yuA4CErLJCsEO7il2
        tWH4eHY6qU3vul6oV5BSxQ9IhWXBNYL4ZRLW7t8giA==
X-Google-Smtp-Source: ABdhPJwA6fF2gcH8wQw09CP/KfWtNPcawF+FUlNNP2wgH6FMgwt35Wa0rYTio1e8v/dCRtNDcHsmii7KXDmm4uILcaA=
X-Received: by 2002:a2e:911:: with SMTP id 17mr4347007ljj.411.1592401052747;
 Wed, 17 Jun 2020 06:37:32 -0700 (PDT)
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
Date:   Wed, 17 Jun 2020 19:07:20 +0530
Message-ID: <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
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
> I was staring into the code and do not see anything.  Could you give the
> following debugging patch a try and see whether it triggers?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cc555903a332..df2e8df0eb71 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2404,6 +2404,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>                          * sc->priority further than desirable.
>                          */
>                         scan = max(scan, SWAP_CLUSTER_MAX);
> +
> +                       trace_printk("scan:%lu protection:%lu\n", scan, protection);
>                 } else {
>                         scan = lruvec_size;
>                 }
> @@ -2648,6 +2650,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>                 mem_cgroup_calculate_protection(target_memcg, memcg);
>
>                 if (mem_cgroup_below_min(memcg)) {
> +                       trace_printk("under min:%lu emin:%lu\n", memcg->memory.min, memcg->memory.emin);
>                         /*
>                          * Hard protection.
>                          * If there is no reclaimable memory, OOM.
> @@ -2660,6 +2663,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>                          * there is an unprotected supply
>                          * of reclaimable memory from other cgroups.
>                          */
> +                       trace_printk("under low:%lu elow:%lu\n", memcg->memory.low, memcg->memory.elow);
>                         if (!sc->memcg_low_reclaim) {
>                                 sc->memcg_low_skipped = 1;
>                                 continue;

As per your suggestions on debugging this problem,
trace_printk is replaced with printk and applied to your patch on top of the
problematic kernel and here is the test output and link.

mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
mke2fs 1.43.8 (1-Jan-2018)
Creating filesystem with 244190646 4k blocks and 61054976 inodes
Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
102400000, 214990848
Allocating group tables:    0/7453 done
Writing inode tables:    0/7453 done
Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
[   51.845304] under min:0 emin:0
[   51.848738] under min:0 emin:0
[   51.858147] under min:0 emin:0
[   51.861333] under min:0 emin:0
[   51.862034] under min:0 emin:0
[   51.862442] under min:0 emin:0
[   51.862763] under min:0 emin:0

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1497412#L1451

- Naresh
