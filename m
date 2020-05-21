Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECCB1DD7F7
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgEUUGe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgEUUGe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 16:06:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B5C08C5C1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 13:06:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r25so7313746oij.4
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Q6rxcBNQ1zsmubc3wyT3H/0+GkcW6r2VdtQUO7eVpuM=;
        b=Fome3a6tpm2IBqz3WvlZB/B1A/bMjQGR4Zj3VuvRR2fGI5zsqnypeM4EFXp7Zf/dkf
         +TfItzJkD9hawgb5bm56vbw/g3jnHiB3MwuunQxVQjjZPIBQa+DE+UeLxTQdkjyeyK9E
         x9CwJpKLbls0MHOlo3DaVuOy9Q7wDf57b/LcBKb7miliwlmT1d2yLr9Al0TiVh3Cz84s
         WtKQPSMPPIYL4P/iG+aJez3B20kIsGbSVnjHdAVcDONHn6cMfLgdb1vknLDIxjVEPS/R
         9Kd1gWxXLudP3tpFVm0rQ1Rfv/WcdUi26P5BKq6QVYrtI8P/sdU9Laq+iPU2tKeNmFe+
         S5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Q6rxcBNQ1zsmubc3wyT3H/0+GkcW6r2VdtQUO7eVpuM=;
        b=dqX+TUikn+7k2c83hgHGXar2UgkXTAFDPRnTJjdEZbqhNdxGQswIIh395wDWtiTt/D
         8J6mpIybGjA6qfFFfLYnLmIyKgp6DPzwkCpGpCWKe2B4+eoHaB2LURXZdysz92iMZgrg
         fg7T5w4RKZZKbOOx1AUunoDH4NN2FErCyVhSx3Km/CJVDuWsoTLsoQ4JDm6TO9DYNnuU
         RzgdiY7Cp0DzgxLY/1kkUJeiacTrS4dWgxZsLpl+SqRsLcwCx1Ide7D2ACHslKdoQPTv
         SFQ6cJnyCTJgqjSHJC37+WxnDXnV4MhZKMbF9ifBAJMQop8B7eXSIorXO0UqkowNMt4a
         mWEg==
X-Gm-Message-State: AOAM531pgaUwuU88JLGAblFImnvyFjelGmDtkpTdSf91/vXkZqUuJHLT
        L3ff4OrLS6OfEtbyesxEM4QmgQ==
X-Google-Smtp-Source: ABdhPJyurkLvqoLB0FS3u7uDnzUJ3zFnGkEHZFMCyOcuHt/P1JS+m1iswp90fepgyFfu89MnmgrFtQ==
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr193576oia.122.1590091592807;
        Thu, 21 May 2020 13:06:32 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y23sm1861280otk.10.2020.05.21.13.06.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 21 May 2020 13:06:31 -0700 (PDT)
Date:   Thu, 21 May 2020 13:06:28 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
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
In-Reply-To: <20200521191746.GB815980@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005211250130.1158@eggly.anvils>
References: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com> <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com> <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz> <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com> <20200521105801.GL6462@dhcp22.suse.cz> <alpine.LSU.2.11.2005210504110.1185@eggly.anvils>
 <20200521124444.GP6462@dhcp22.suse.cz> <20200521191746.GB815980@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 21 May 2020, Johannes Weiner wrote:
> 
> Very much appreciate you guys tracking it down so quickly. Sorry about
> the breakage.
> 
> I think mem_cgroup_disabled() checks are pretty good markers of public
> entry points to the memcg API, so I'd prefer that even if a bit more
> verbose. What do you think?

An explicit mem_cgroup_disabled() check would be fine, but I must admit,
the patch below is rather too verbose for my own taste.  Your call.

> 
> ---
> From cd373ec232942a9bc43ee5e7d2171352019a58fb Mon Sep 17 00:00:00 2001
> From: Hugh Dickins <hughd@google.com>
> Date: Thu, 21 May 2020 14:58:36 -0400
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
> do_memsw_account() used to be automatically false when the cgroup
> controller was disabled. Now that it's replaced by
> cgroup_memory_noswap, for which this isn't true, make the
> mem_cgroup_disabled() checks explicit in the swap control API.
> 
> [hannes@cmpxchg.org: use mem_cgroup_disabled() in all API functions]
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Debugged-by: Hugh Dickins <hughd@google.com>
> Debugged-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)

I'm certainly not against a mem_cgroup_disabled() check in the only
place that's been observed to need it, as a fixup to merge into your
original patch; but this seems rather an over-reaction - and I'm a
little surprised that setting mem_cgroup_disabled() doesn't just
force cgroup_memory_noswap, saving repetitious checks elsewhere
(perhaps there's a difficulty in that, I haven't looked).

Historically, I think we've added mem_cgroup_disabled() checks
(accessing a cacheline we'd rather avoid) where they're necessary,
rather than at every "interface".

And you seem to be in a very "goto out" mood today - we all have
our "goto out" days, alternating with our "return 0" days :)

Hugh

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3e000a316b59..850bca380562 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6811,6 +6811,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return;
>  
> @@ -6876,6 +6879,10 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  	struct mem_cgroup *memcg;
>  	unsigned short oldid;
>  
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	/* Only cgroup2 has swap.max */
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return 0;
>  
> @@ -6920,6 +6927,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	id = swap_cgroup_record(entry, 0, nr_pages);
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
> @@ -6940,12 +6950,25 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  {
>  	long nr_swap_pages = get_nr_swap_pages();
>  
> -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -		return nr_swap_pages;
> +	if (mem_cgroup_disabled())
> +		goto out;
> +
> +	/* Swap control disabled */
> +	if (cgroup_memory_noswap)
> +		goto out;
> +
> +	/*
> +	 * Only cgroup2 has swap.max, cgroup1 does mem+sw accounting,
> +	 * which does not place restrictions specifically on swap.
> +	 */
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		goto out;
> +
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
>  		nr_swap_pages = min_t(long, nr_swap_pages,
>  				      READ_ONCE(memcg->swap.max) -
>  				      page_counter_read(&memcg->swap));
> +out:
>  	return nr_swap_pages;
>  }
>  
> @@ -6957,18 +6980,30 @@ bool mem_cgroup_swap_full(struct page *page)
>  
>  	if (vm_swap_full())
>  		return true;
> -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -		return false;
> +
> +	if (mem_cgroup_disabled())
> +		goto out;
> +
> +	/* Swap control disabled */
> +	if (cgroup_memory_noswap)
> +		goto out;
> +
> +	/*
> +	 * Only cgroup2 has swap.max, cgroup1 does mem+sw accounting,
> +	 * which does not place restrictions specifically on swap.
> +	 */
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		goto out;
>  
>  	memcg = page->mem_cgroup;
>  	if (!memcg)
> -		return false;
> +		goto out;
>  
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
>  		if (page_counter_read(&memcg->swap) * 2 >=
>  		    READ_ONCE(memcg->swap.max))
>  			return true;
> -
> +out:
>  	return false;
>  }
>  
> -- 
> 2.26.2
