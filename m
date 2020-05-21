Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C556D1DCB85
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgEUK6J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 06:58:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34812 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgEUK6J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 06:58:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id i16so6389779edv.1;
        Thu, 21 May 2020 03:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNawhknjOIKR4nsDknlNKTgt07zaj8UbYNFvZIbzSoA=;
        b=nLH/1UKPfjM5wmeRSPRzdlGEgBs2SwReCu94cD6uBhGZx6SQduh0ieIdN7rYnFXLnn
         pvV38YZm7gEeZBJHhEdgEKx15yDh+5rSfe69F1ZBalZqm291m5Kw5dt1Zt63WC9mY83w
         pYqPJmd2yo02sWeZFEo8GxXFRFzELM7y7zCbKt5NKoMokYn7qkLHVdxS+nf1PYdyYsqc
         DT4BIpx18tZPXCtPVzmaiSEEQjDRunEA1bW6O6S6gBBH4+8vDnJWWiQquVJkGLnpCgr4
         KduWIBmUELWtSauo6mxJwW4DhQMoPGgbSk2TR2AliRDVLJ0kruQQvVILrXQ8dzQM1GoR
         vqIA==
X-Gm-Message-State: AOAM533gGGvDPYm07IaOpNxdY0/7KayvcC9w80FzT1o41IkPmMOMJUF1
        5ym7JqgIw133J5us9K6rIgs=
X-Google-Smtp-Source: ABdhPJz5cmzkqGt/VjxJ/B57BbRDLsfEshniDGeSG3hqEi0TKwBN20Zmnf3zg4J2qyGDodX/TUsadw==
X-Received: by 2002:a50:ee15:: with SMTP id g21mr7048744eds.170.1590058685348;
        Thu, 21 May 2020 03:58:05 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id dc13sm4285623edb.97.2020.05.21.03.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:58:04 -0700 (PDT)
Date:   Thu, 21 May 2020 12:58:01 +0200
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
Message-ID: <20200521105801.GL6462@dhcp22.suse.cz>
References: <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 16:11:11, Naresh Kamboju wrote:
> On Thu, 21 May 2020 at 15:25, Michal Hocko <mhocko@kernel.org> wrote:
> >
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
> > effectively a nop. Btw. do you see the problem when booting with
> > cgroup_disable=memory kernel command line parameter?
> 
> With extra kernel command line parameters, cgroup_disable=memory
> I have noticed a differ problem now.
> 
> + mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8NRK0BPF6XF
> mke2fs 1.43.8 (1-Jan-2018)
> Creating filesystem with 244190646 4k blocks and 61054976 inodes
> Filesystem UUID: 3bb1a285-2cb4-44b4-b6e8-62548f3ac620
> Superblock backups stored on blocks:
> 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> 102400000, 214990848
> Allocating group tables:    0/7453                           done
> Writing inode tables:    0/7453                           done
> Creating journal (262144 blocks): [   35.502102] BUG: kernel NULL
> pointer dereference, address: 000000c8
> [   35.508372] #PF: supervisor read access in kernel mode
> [   35.513506] #PF: error_code(0x0000) - not-present page
> [   35.518638] *pde = 00000000
> [   35.521514] Oops: 0000 [#1] SMP
> [   35.524652] CPU: 0 PID: 145 Comm: kswapd0 Not tainted
> 5.7.0-rc6-next-20200519+ #1
> [   35.532121] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   35.539507] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60

Could you get faddr2line for this offset?

-- 
Michal Hocko
SUSE Labs
