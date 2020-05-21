Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802661DD9C4
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgEUV7W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgEUV7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 17:59:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252EC08C5C1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 14:59:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d7so6768970qtn.11
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5B1+HMIDvT7snVXiXmhhirfPbIUt2RcF6P9jK7VVgzk=;
        b=tfzseeFRapr6mzYIpyevbB2Jr0bnMxnhrggEPvTJwKT1cNJUmOyzhNEEPC7YfmFN10
         Leq8bJtwR9By5lcHPu1Udo3g0bnQUdDLbiLyiUxWzyBaErEnqpb7zOsiDxNzuM2DY5m3
         9i2yn71sn05AqTGZbUV3FNlQ7ZJDjxLEs00cKA6PCnWfel6WSALIg9RBtqLJgEXELCof
         VnDtHFb0fobUgITmj7IgRam7lmriUKw5hSI013/Y1R8qjEoh55ee/UDqIrEF3v9Q5HYU
         QhDt6u4wHbqDq6tuAnx5yRdXaCqWqT71EZvmB6MnGSWGJ8dz1OAmtQO3ti3WC/Sg3XO+
         PZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5B1+HMIDvT7snVXiXmhhirfPbIUt2RcF6P9jK7VVgzk=;
        b=Mout8Q1iWKXVY+xyDT30QVcDsYIQLueEZLGgSwDwaHC8C6Ds9OwuWbPlJQFTMYhXz/
         LdYjT1+GCWQi9guKVEUotuTHDsT3GrYRai1UiEurhcB/BcHte8IAgYD3sgJaO+347P8q
         hpANFZtBLIHR8MewtBMQx8RbrwC1PYE8ZVdXlkSzZmAWVXTP0fyCb8NNTsHBIUPF8icE
         tPEeCoYhc305KAWagLW6BBg2hb/tvJiKktoQOi8R9Ssk8bKNGJdYotnyybJrXA7iep3N
         IZIAUPuI0ecAt8YhCmXZxtX48DChMyq4JYdmPmPngA80smv6DuYZTqT66v4v/SiBKuqZ
         BMZw==
X-Gm-Message-State: AOAM532qVGC3uBB21vlPKSmFAQsgrHQw/WClM9MlMgwWv7vrWKCKz3NK
        q6+dd7GV5GT5BptB6dBV1ho1jA==
X-Google-Smtp-Source: ABdhPJynOwwPxmTuGwW6Ugcajsa54FPAHyhnkQZPzhAlPWSvWI/s5UNhYFanefxUXztWg+08MxKYyg==
X-Received: by 2002:aed:37e7:: with SMTP id j94mr12705571qtb.57.1590098359373;
        Thu, 21 May 2020 14:59:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id m13sm6939518qtm.12.2020.05.21.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:59:18 -0700 (PDT)
Date:   Thu, 21 May 2020 17:58:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20200521215855.GB815153@cmpxchg.org>
References: <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
 <20200521105801.GL6462@dhcp22.suse.cz>
 <alpine.LSU.2.11.2005210504110.1185@eggly.anvils>
 <20200521124444.GP6462@dhcp22.suse.cz>
 <20200521191746.GB815980@cmpxchg.org>
 <alpine.LSU.2.11.2005211250130.1158@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005211250130.1158@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 21, 2020 at 01:06:28PM -0700, Hugh Dickins wrote:
> On Thu, 21 May 2020, Johannes Weiner wrote:
> > do_memsw_account() used to be automatically false when the cgroup
> > controller was disabled. Now that it's replaced by
> > cgroup_memory_noswap, for which this isn't true, make the
> > mem_cgroup_disabled() checks explicit in the swap control API.
> > 
> > [hannes@cmpxchg.org: use mem_cgroup_disabled() in all API functions]
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Debugged-by: Hugh Dickins <hughd@google.com>
> > Debugged-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/memcontrol.c | 47 +++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> I'm certainly not against a mem_cgroup_disabled() check in the only
> place that's been observed to need it, as a fixup to merge into your
> original patch; but this seems rather an over-reaction - and I'm a
> little surprised that setting mem_cgroup_disabled() doesn't just
> force cgroup_memory_noswap, saving repetitious checks elsewhere
> (perhaps there's a difficulty in that, I haven't looked).

Fair enough, I changed it to set the flag at initialization time if
mem_cgroup_disabled(). I was never a fan of the old flags, where it
was never clear what was commandline, and what was internal runtime
state - do_swap_account? really_do_swap_account? But I think it's
straight-forward in this case now.

> Historically, I think we've added mem_cgroup_disabled() checks
> (accessing a cacheline we'd rather avoid) where they're necessary,
> rather than at every "interface".

To me that always seemed like bugs waiting to happen. Like this one!

It's a jump label nowadays, so I've been liberal with these to avoid
subtle bugs.

> And you seem to be in a very "goto out" mood today - we all have
> our "goto out" days, alternating with our "return 0" days :)

:-)

But I agree, best to keep this fixup self-contained and defer anything
else to separate cleanup patches.

How about the below? It survives a swaptest with cgroup_disable=memory
for me.

Hugh, I started with your patch, which is why I kept you as the
author, but as the patch now (and arguably the previous one) is
sufficiently different, I dropped that now. I hope that's okay.

---
From d9e7ed15d1c9248a3fd99e35e82437549154dac7 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 21 May 2020 17:44:25 -0400
Subject: [PATCH] mm: memcontrol: prepare swap controller setup for integration
 fix

Fix crash with cgroup_disable=memory:

> > > > + mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8NRK0BPF6XF
> > > > mke2fs 1.43.8 (1-Jan-2018)
> > > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > > Filesystem UUID: 3bb1a285-2cb4-44b4-b6e8-62548f3ac620
> > > > Superblock backups stored on blocks:
> > > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > > 102400000, 214990848
> > > > Allocating group tables:    0/7453                           done
> > > > Writing inode tables:    0/7453                           done
> > > > Creating journal (262144 blocks): [   35.502102] BUG: kernel NULL
> > > > pointer dereference, address: 000000c8
> > > > [   35.508372] #PF: supervisor read access in kernel mode
> > > > [   35.513506] #PF: error_code(0x0000) - not-present page
> > > > [   35.518638] *pde = 00000000
> > > > [   35.521514] Oops: 0000 [#1] SMP
> > > > [   35.524652] CPU: 0 PID: 145 Comm: kswapd0 Not tainted
> > > > 5.7.0-rc6-next-20200519+ #1
> > > > [   35.532121] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > > 2.2 05/23/2018
> > > > [   35.539507] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60

Swap accounting used to be implied-disabled when the cgroup controller
was disabled. Restore that for the new cgroup_memory_noswap, so that
we bail out of this function instead of dereferencing a NULL memcg.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Debugged-by: Hugh Dickins <hughd@google.com>
Debugged-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e000a316b59..e3b785d6e771 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7075,7 +7075,11 @@ static struct cftype memsw_files[] = {
 
 static int __init mem_cgroup_swap_init(void)
 {
-	if (mem_cgroup_disabled() || cgroup_memory_noswap)
+	/* No memory control -> no swap control */
+	if (mem_cgroup_disabled())
+		cgroup_memory_noswap = true;
+
+	if (cgroup_memory_noswap)
 		return 0;
 
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
-- 
2.26.2

