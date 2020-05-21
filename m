Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F91DCD2F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgEUMou (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:44:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41032 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgEUMou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:44:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id g9so6553206edr.8;
        Thu, 21 May 2020 05:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7B+zSNVUKDMX+EtrLfhKx/b5Dlg1GLXsdTK5UK1C/wA=;
        b=LBqqAvMYl75xgaIVDJECJkKkNuhp+yAPLz3GbT3cvKtdR9yxaOWFx7+NwQ1V7lIu89
         IhoQ5Qqx3afyoOV2S6tJVVXJz2R/hb9YPGWNAsVO79/r4E+5KUbj01GfU2ztwZ2UCoRU
         3Sxq6Z+gzllNB1O6eACV25UiyqiKLLEi69xBJQuOpTo6Q8Ji/NzT/YWV183rP3bI0vvm
         tCd8FfYdn6oo0hWmVpiHnVJnKuqrf0yu9H5t/6keNS0wpXSMiuxrbpIE+NhUrzyvr9+D
         krL+f62PI9u6T17I6MTw08G3ow587zerfVgtAZ5Z0NH8ldkugTDU2x4AbkyOyioSJqYF
         wYaA==
X-Gm-Message-State: AOAM530aGm4cCbKdujFEm/18iwXiee6fDQrYZmAOpmDHKIg+3K9J1Kh4
        cPD5ZY83nvJQgTEs2P/Nfno=
X-Google-Smtp-Source: ABdhPJyFmwAVPZkzShA2BCWpmRd1w2Y3qvQQ3fG96wsb/P2EJuekC35u1D4g78CqUn7CegdanQGqrg==
X-Received: by 2002:a05:6402:203a:: with SMTP id ay26mr7259622edb.205.1590065086406;
        Thu, 21 May 2020 05:44:46 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id rn17sm4757851ejb.115.2020.05.21.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:44:45 -0700 (PDT)
Date:   Thu, 21 May 2020 14:44:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Chris Down <chris@chrisdown.name>,
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
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200521124444.GP6462@dhcp22.suse.cz>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
 <20200521105801.GL6462@dhcp22.suse.cz>
 <alpine.LSU.2.11.2005210504110.1185@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005210504110.1185@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 05:24:27, Hugh Dickins wrote:
> On Thu, 21 May 2020, Michal Hocko wrote:
> > On Thu 21-05-20 16:11:11, Naresh Kamboju wrote:
> > > On Thu, 21 May 2020 at 15:25, Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Wed 20-05-20 20:09:06, Chris Down wrote:
> > > > > Hi Naresh,
> > > > >
> > > > > Naresh Kamboju writes:
> > > > > > As a part of investigation on this issue LKFT teammate Anders Roxell
> > > > > > git bisected the problem and found bad commit(s) which caused this problem.
> > > > > >
> > > > > > The following two patches have been reverted on next-20200519 and retested the
> > > > > > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > > > > > ( invoked oom-killer is gone now)
> > > > > >
> > > > > > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > > > > > protection"
> > > > > >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > > > > >
> > > > > > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > > > > > checks"
> > > > > >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> > > > >
> > > > > Thanks Anders and Naresh for tracking this down and reverting.
> > > > >
> > > > > I'll take a look tomorrow. I don't see anything immediately obviously wrong
> > > > > in either of those commits from a (very) cursory glance, but they should
> > > > > only be taking effect if protections are set.
> > > >
> > > > Agreed. If memory.{low,min} is not used then the patch should be
> > > > effectively a nop. Btw. do you see the problem when booting with
> > > > cgroup_disable=memory kernel command line parameter?
> > > 
> > > With extra kernel command line parameters, cgroup_disable=memory
> > > I have noticed a differ problem now.
> > > 
> > > + mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8NRK0BPF6XF
> > > mke2fs 1.43.8 (1-Jan-2018)
> > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > Filesystem UUID: 3bb1a285-2cb4-44b4-b6e8-62548f3ac620
> > > Superblock backups stored on blocks:
> > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > 102400000, 214990848
> > > Allocating group tables:    0/7453                           done
> > > Writing inode tables:    0/7453                           done
> > > Creating journal (262144 blocks): [   35.502102] BUG: kernel NULL
> > > pointer dereference, address: 000000c8
> > > [   35.508372] #PF: supervisor read access in kernel mode
> > > [   35.513506] #PF: error_code(0x0000) - not-present page
> > > [   35.518638] *pde = 00000000
> > > [   35.521514] Oops: 0000 [#1] SMP
> > > [   35.524652] CPU: 0 PID: 145 Comm: kswapd0 Not tainted
> > > 5.7.0-rc6-next-20200519+ #1
> > > [   35.532121] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > 2.2 05/23/2018
> > > [   35.539507] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
> > 
> > Could you get faddr2line for this offset?
> 
> No need for that, I can help with the "cgroup_disabled=memory" crash:
> I've been happily running with the fixup below, but haven't got to
> send it in yet (and wouldn't normally be reading mail at this time!)
> because of busy chasing a couple of other bugs (not necessarily mm);
> and maybe the fix would be better with explicit mem_cgroup_disabled()
> test, or maybe that should be where cgroup_memory_noswap is decided -
> up to Johannes.

Thanks Hugh. I can see what is the problem now. I was looking at the
Linus' tree and we have a different code there

	long nr_swap_pages = get_nr_swap_pages();

        if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
                return nr_swap_pages;

which would be impossible to crash so I was really wondering what is
going on here. But there are other changes in the mmotm which I haven't
reviewed yet. Looking at the next tree now it is a fallout from "mm:
memcontrol: prepare swap controller setup for integration".

!memcg check slightly more cryptic than an explicit mem_cgroup_disabled
but I would just leave it to Johannes as well.

> 
> ---
> 
>  mm/memcontrol.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 5.7-rc6-mm1/mm/memcontrol.c	2020-05-20 12:21:56.109693740 -0700
> +++ linux/mm/memcontrol.c	2020-05-20 12:26:15.500478753 -0700
> @@ -6954,7 +6954,8 @@ long mem_cgroup_get_nr_swap_pages(struct
>  {
>  	long nr_swap_pages = get_nr_swap_pages();
>  
> -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	if (!memcg || cgroup_memory_noswap ||
> +            !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return nr_swap_pages;
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
>  		nr_swap_pages = min_t(long, nr_swap_pages,

-- 
Michal Hocko
SUSE Labs
