Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8E1E6521
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbgE1O7y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 10:59:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403956AbgE1O7r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 10:59:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id h4so3474221wmb.4;
        Thu, 28 May 2020 07:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvdKpHF042iTNApEGGudMnbcuPPZ+JOhqsO7H3d0iMc=;
        b=sBhEmuSUd/GFOy3np6mV8rstzGSKw+c/3N7A5idKPh6bSBRzSjT8zi2hGTXx0IQ058
         3vgOx1IIU/u5a1ArZyovHhM/CuTwqOBUcZURZfyXkNl4unIuv3y65nUSuXutlRnQHKhy
         hQXzBCA9ZY0vsz9gnD2qPuPnFcnIZKILRhMntigT8Wr+Rp6oytstrmuYreQsBqdfthN7
         uy0pTvGAt+a61/QhVOjGQUG9KwdaVD6/6aZ0frMa0VjBvrskGW6Z04tq12L5JUIWUeYw
         tZTuwIwJu5uUcK3n0uw+DyJPgjqa2scQxwXvmGabrp8CHjr6+mPQsCCyZSWEzbD7DPcb
         QkwA==
X-Gm-Message-State: AOAM5312Xv+4y5d8EKInL1tAq3ohf4MDrhdGv0td1MspagaaNnXDPlD1
        JIVE+9LSrJlwkWcdjCpmmks=
X-Google-Smtp-Source: ABdhPJwLdJXj9IDbExOvEPWylXBWigVlYHMkRhO6O5dzYmOl704Ju6Ewl0cUi5F1r49EwVynvlA5Tw==
X-Received: by 2002:a1c:230a:: with SMTP id j10mr3748329wmj.124.1590677985101;
        Thu, 28 May 2020 07:59:45 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id t129sm2060873wmf.41.2020.05.28.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:59:44 -0700 (PDT)
Date:   Thu, 28 May 2020 16:59:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200528145942.GF27484@dhcp22.suse.cz>
References: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
 <20200521105801.GL6462@dhcp22.suse.cz>
 <alpine.LSU.2.11.2005210504110.1185@eggly.anvils>
 <20200521124444.GP6462@dhcp22.suse.cz>
 <20200521191746.GB815980@cmpxchg.org>
 <alpine.LSU.2.11.2005211250130.1158@eggly.anvils>
 <20200521215855.GB815153@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521215855.GB815153@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Sorry for a late reply - was offline for few days]

On Thu 21-05-20 17:58:55, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 01:06:28PM -0700, Hugh Dickins wrote:
[...]
> >From d9e7ed15d1c9248a3fd99e35e82437549154dac7 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 21 May 2020 17:44:25 -0400
> Subject: [PATCH] mm: memcontrol: prepare swap controller setup for integration
>  fix
> 
> Fix crash with cgroup_disable=memory:
> 
> > > > > + mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8NRK0BPF6XF
> > > > > mke2fs 1.43.8 (1-Jan-2018)
> > > > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > > > Filesystem UUID: 3bb1a285-2cb4-44b4-b6e8-62548f3ac620
> > > > > Superblock backups stored on blocks:
> > > > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > > > 102400000, 214990848
> > > > > Allocating group tables:    0/7453                           done
> > > > > Writing inode tables:    0/7453                           done
> > > > > Creating journal (262144 blocks): [   35.502102] BUG: kernel NULL
> > > > > pointer dereference, address: 000000c8
> > > > > [   35.508372] #PF: supervisor read access in kernel mode
> > > > > [   35.513506] #PF: error_code(0x0000) - not-present page
> > > > > [   35.518638] *pde = 00000000
> > > > > [   35.521514] Oops: 0000 [#1] SMP
> > > > > [   35.524652] CPU: 0 PID: 145 Comm: kswapd0 Not tainted
> > > > > 5.7.0-rc6-next-20200519+ #1
> > > > > [   35.532121] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > > > 2.2 05/23/2018
> > > > > [   35.539507] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
> 
> Swap accounting used to be implied-disabled when the cgroup controller
> was disabled. Restore that for the new cgroup_memory_noswap, so that
> we bail out of this function instead of dereferencing a NULL memcg.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Debugged-by: Hugh Dickins <hughd@google.com>
> Debugged-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Yes this looks better. I hope to get to your series soon to have the
full picture finally.

> ---
>  mm/memcontrol.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3e000a316b59..e3b785d6e771 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7075,7 +7075,11 @@ static struct cftype memsw_files[] = {
>  
>  static int __init mem_cgroup_swap_init(void)
>  {
> -	if (mem_cgroup_disabled() || cgroup_memory_noswap)
> +	/* No memory control -> no swap control */
> +	if (mem_cgroup_disabled())
> +		cgroup_memory_noswap = true;
> +
> +	if (cgroup_memory_noswap)
>  		return 0;
>  
>  	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
