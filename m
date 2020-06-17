Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DD1FCEFD
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFQN75 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 09:59:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFQN75 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 09:59:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id t21so1979448edr.12;
        Wed, 17 Jun 2020 06:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpItOWqOCv2p+qOj41TNq3/UacSSYUf9Nq97mewWfpw=;
        b=moLnpMHHBK1OCJarjUt/ls8NLkgzp3b5h26wiYLrt2NgznrglJfeEbDOHtogWM5pEn
         d3hamDOtQkU4hZSGowU9dTuVRtiOm4oEYORZopsIDvJ8vuIXjOCIsF6GKofbsnpLtyHR
         RJRpd7Nv4TP2WpBChNiKaOmGSL+0txQebds1uDN+PMZeUL00I6GWCJy0ueUjSV2tDn5w
         sRSjbDgoymw6pPYYDaepLwA9OgAVJEecgXywv8ixkDOttb5CMMkK4Q7aA/n5hbMD1uZg
         NHqN3FNtu1RhVItBnfYjd1OtywrBFCgl57GZYv/xJRvFr4LQeQvWPGXoYIfpGRDtFyIu
         KeKA==
X-Gm-Message-State: AOAM533eAmfvJLE0U8LiTLHb4skabX0XguP0i4u02ty+oyXGK/Plu1nX
        9VBhF/X44mRpBAVa1PXNdHvUnvzBDL8=
X-Google-Smtp-Source: ABdhPJwoxdVikISMAUb7wioR733/T+n1aieGFGWSsheowKtsKPI7XosyomEKuGtzw9AQuGmNgWVhWQ==
X-Received: by 2002:aa7:d054:: with SMTP id n20mr7264496edo.344.1592402393986;
        Wed, 17 Jun 2020 06:59:53 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id m30sm12372931eda.16.2020.06.17.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 06:59:52 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:59:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200617135951.GP9499@dhcp22.suse.cz>
References: <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 17-06-20 19:07:20, Naresh Kamboju wrote:
> On Thu, 21 May 2020 at 22:04, Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 21-05-20 11:55:16, Michal Hocko wrote:
> > > On Wed 20-05-20 20:09:06, Chris Down wrote:
> > > > Hi Naresh,
> > > >
> > > > Naresh Kamboju writes:
> > > > > As a part of investigation on this issue LKFT teammate Anders Roxell
> > > > > git bisected the problem and found bad commit(s) which caused this problem.
> > > > >
> > > > > The following two patches have been reverted on next-20200519 and retested the
> > > > > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > > > > ( invoked oom-killer is gone now)
> > > > >
> > > > > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > > > > protection"
> > > > >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > > > >
> > > > > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > > > > checks"
> > > > >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> > > >
> > > > Thanks Anders and Naresh for tracking this down and reverting.
> > > >
> > > > I'll take a look tomorrow. I don't see anything immediately obviously wrong
> > > > in either of those commits from a (very) cursory glance, but they should
> > > > only be taking effect if protections are set.
> > >
> > > Agreed. If memory.{low,min} is not used then the patch should be
> > > effectively a nop.
> >
> > I was staring into the code and do not see anything.  Could you give the
> > following debugging patch a try and see whether it triggers?
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cc555903a332..df2e8df0eb71 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2404,6 +2404,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >                          * sc->priority further than desirable.
> >                          */
> >                         scan = max(scan, SWAP_CLUSTER_MAX);
> > +
> > +                       trace_printk("scan:%lu protection:%lu\n", scan, protection);
> >                 } else {
> >                         scan = lruvec_size;
> >                 }
> > @@ -2648,6 +2650,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >                 mem_cgroup_calculate_protection(target_memcg, memcg);
> >
> >                 if (mem_cgroup_below_min(memcg)) {
> > +                       trace_printk("under min:%lu emin:%lu\n", memcg->memory.min, memcg->memory.emin);
> >                         /*
> >                          * Hard protection.
> >                          * If there is no reclaimable memory, OOM.
> > @@ -2660,6 +2663,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >                          * there is an unprotected supply
> >                          * of reclaimable memory from other cgroups.
> >                          */
> > +                       trace_printk("under low:%lu elow:%lu\n", memcg->memory.low, memcg->memory.elow);
> >                         if (!sc->memcg_low_reclaim) {
> >                                 sc->memcg_low_skipped = 1;
> >                                 continue;
> 
> As per your suggestions on debugging this problem,
> trace_printk is replaced with printk and applied to your patch on top of the
> problematic kernel and here is the test output and link.
> 
> mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> mke2fs 1.43.8 (1-Jan-2018)
> Creating filesystem with 244190646 4k blocks and 61054976 inodes
> Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> Superblock backups stored on blocks:
> 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> 102400000, 214990848
> Allocating group tables:    0/7453 done
> Writing inode tables:    0/7453 done
> Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> [   51.845304] under min:0 emin:0
> [   51.848738] under min:0 emin:0
> [   51.858147] under min:0 emin:0
> [   51.861333] under min:0 emin:0
> [   51.862034] under min:0 emin:0
> [   51.862442] under min:0 emin:0
> [   51.862763] under min:0 emin:0
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1497412#L1451

Thanks a lot. So it is clear that mem_cgroup_below_min got confused and
reported protected cgroup. Both effective and real limits are 0 so there
is no garbage in them. The problem is in mem_cgroup_below_* and it is
quite obvious.

We are doing the following
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+       if (mem_cgroup_disabled())
+               return false;
+
+       return READ_ONCE(memcg->memory.emin) >=
+               page_counter_read(&memcg->memory);
+}

and it makes some sense. Except for the root memcg where we do not
account any memory. Adding if (mem_cgroup_is_root(memcg)) return false;
should do the trick. The same is the case for mem_cgroup_below_low.
Could you give it a try please just to confirm?
-- 
Michal Hocko
SUSE Labs
