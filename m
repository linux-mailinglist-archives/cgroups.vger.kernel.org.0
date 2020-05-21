Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E901DCB2D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEUKl1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgEUKl0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 06:41:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D08C08C5C1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 03:41:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so4146939lfe.11
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruwgMoIqZViJ7XFLWrNLkduySn7HcvCwaQ9YCs6FUkY=;
        b=bGDPJthY9IjNSXytG1FCAQtOMNeqIdhU8EckZXFXW4g+V2/iIOeOxMwNo0zUL9JE6q
         gj8lfuLVfIPe3mz+lKeMXk/edvTPxf9iUz0fUYVkttosREReCZnnfkhld1/Rq3rEF1s1
         OZ1tOvxUuAZ0l2oY5p3GUpPAdmuQGO31PdpheNuvZfL9ogmiMygtOu2KPg8YAP758P0n
         IueIjwuLrDv64zhOxXmScaBYeMhNNpMfT3y9QS+ckhfCl3Qzi90XcHH+vbYKfwhN26tn
         YhTCOrvn5l6/2Mygb5ZUlDQVg4S3we5B2kROAiKL9CabriONVa8RUC5lNchjM/5Ybkep
         eZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruwgMoIqZViJ7XFLWrNLkduySn7HcvCwaQ9YCs6FUkY=;
        b=PRJcOxzqCTNXf7e9Ani6aFkm3XoFTgfGD57RG79788zXFGGe+1VAVFp41U3qg/glf6
         vfPVze1ttoz3C/Ag/69B740Tb4CjBTQHvejT8mC825oXqCChKrqqFNoTLgZfqDmeRXjq
         95XFRS23mdYMch28lB5H7FcQTIqwWEM2CDLiiAmGC2zef4mR0gpVKpp2Jj+C+X9JhvcI
         N9IHKWOYamlAF5KS5HmO5aPhTzIV29O/Fpb9RHbIKTNt15HxqMkzAxzouNy5jPdXL6ev
         JY6vgY+9zzdn3tAn8AeTCQ6nozYW9h+FfuKv4YxFdiUDO9+tMcsJ+VkhxYpEHvSlRna3
         NM2Q==
X-Gm-Message-State: AOAM532hFIohoUe4v8XOnv4dbPZt4OkVTQUfdUc9N0HPDEQa18O2S55R
        Em98nqpQVpXNg6SGwZXmYYOkFHFXJrn11n/NRAdXSw==
X-Google-Smtp-Source: ABdhPJxdHvO9ZrtciNDuSgpZrTF+4CswiuQ1sCpk4HH5doPD48+XHfKavaqzhS8LCeJOWlsMpZ6zR3RKATueb8oaVUQ=
X-Received: by 2002:a05:6512:533:: with SMTP id o19mr736537lfc.6.1590057683666;
 Thu, 21 May 2020 03:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
In-Reply-To: <20200521095515.GK6462@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 May 2020 16:11:11 +0530
Message-ID: <CA+G9fYvAB9F+Xo0vUsSveKnExkv3cV9-oOG9gBqGEcXsO95m0w@mail.gmail.com>
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

On Thu, 21 May 2020 at 15:25, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 20-05-20 20:09:06, Chris Down wrote:
> > Hi Naresh,
> >
> > Naresh Kamboju writes:
> > > As a part of investigation on this issue LKFT teammate Anders Roxell
> > > git bisected the problem and found bad commit(s) which caused this problem.
> > >
> > > The following two patches have been reverted on next-20200519 and retested the
> > > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > > ( invoked oom-killer is gone now)
> > >
> > > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > > protection"
> > >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > >
> > > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > > checks"
> > >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> >
> > Thanks Anders and Naresh for tracking this down and reverting.
> >
> > I'll take a look tomorrow. I don't see anything immediately obviously wrong
> > in either of those commits from a (very) cursory glance, but they should
> > only be taking effect if protections are set.
>
> Agreed. If memory.{low,min} is not used then the patch should be
> effectively a nop. Btw. do you see the problem when booting with
> cgroup_disable=memory kernel command line parameter?

With extra kernel command line parameters, cgroup_disable=memory
I have noticed a differ problem now.

+ mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8NRK0BPF6XF
mke2fs 1.43.8 (1-Jan-2018)
Creating filesystem with 244190646 4k blocks and 61054976 inodes
Filesystem UUID: 3bb1a285-2cb4-44b4-b6e8-62548f3ac620
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
102400000, 214990848
Allocating group tables:    0/7453                           done
Writing inode tables:    0/7453                           done
Creating journal (262144 blocks): [   35.502102] BUG: kernel NULL
pointer dereference, address: 000000c8
[   35.508372] #PF: supervisor read access in kernel mode
[   35.513506] #PF: error_code(0x0000) - not-present page
[   35.518638] *pde = 00000000
[   35.521514] Oops: 0000 [#1] SMP
[   35.524652] CPU: 0 PID: 145 Comm: kswapd0 Not tainted
5.7.0-rc6-next-20200519+ #1
[   35.532121] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   35.539507] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
[   35.544724] Code: 00 00 80 3d 84 b5 e1 cb 00 89 c2 a1 9c a5 f5 cb
75 48 55 89 e5 57 56 53 3e 8d 74 26 00 8b 1d 88 b5 e1 cb 31 f6 eb 27
8d 76 00 <8b> 8a c8 00 00 00 8b ba bc 00 00 00 29 f9 39 c8 0f 4f c1 8b
8a 98
[   35.563461] EAX: 00000000 EBX: f5411000 ECX: 00000000 EDX: 00000000
[   35.569718] ESI: 00000000 EDI: f4e13ea8 EBP: f4e13e10 ESP: f4e13e04
[   35.575976] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010207
[   35.582751] CR0: 80050033 CR2: 000000c8 CR3: 0bef4000 CR4: 003406d0
[   35.589010] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   35.595266] DR6: fffe0ff0 DR7: 00000400
[   35.599096] Call Trace:
[   35.601544]  shrink_lruvec+0x447/0x630
[   35.605294]  ? newidle_balance.isra.100+0x8e/0x3f0
[   35.610080]  ? pick_next_task_fair+0x3a/0x320
[   35.614437]  ? deactivate_task+0xcf/0x100
[   35.618442]  ? put_prev_entity+0x1a/0xd0
[   35.622359]  ? deactivate_task+0xcf/0x100
[   35.626363]  shrink_node+0x1be/0x640
[   35.629932]  ? shrink_node+0x1be/0x640
[   35.633676]  kswapd+0x32c/0x890
[   35.636815]  ? deactivate_task+0xcf/0x100
[   35.640820]  kthread+0xf1/0x110
[   35.643963]  ? do_try_to_free_pages+0x3b0/0x3b0
[   35.648489]  ? kthread_park+0xa0/0xa0
[   35.652147]  ret_from_fork+0x1c/0x28
[   35.655726] Modules linked in: x86_pkg_temp_thermal
[   35.660605] CR2: 00000000000000c8
[   35.663916] ---[ end trace d85b8564ea55fb0d ]---
[   35.663917] BUG: kernel NULL pointer dereference, address: 000000c8
[   35.663918] #PF: supervisor read access in kernel mode
[   35.668534] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
[   35.674792] #PF: error_code(0x0000) - not-present page
[   35.674792] *pde = 00000000
[   35.679921] Code: 00 00 80 3d 84 b5 e1 cb 00 89 c2 a1 9c a5 f5 cb
75 48 55 89 e5 57 56 53 3e 8d 74 26 00 8b 1d 88 b5 e1 cb 31 f6 eb 27
8d 76 00 <8b> 8a c8 00 00 00 8b ba bc 00 00 00 29 f9 39 c8 0f 4f c1 8b
8a 98
[   35.685140] Oops: 0000 [#2] SMP
[   35.685142] CPU: 2 PID: 391 Comm: mkfs.ext4 Tainted: G      D
    5.7.0-rc6-next-20200519+ #1
[   35.690278] EAX: 00000000 EBX: f5411000 ECX: 00000000 EDX: 00000000
[   35.690279] ESI: 00000000 EDI: f4e13ea8 EBP: f4e13e10 ESP: f4e13e04
[   35.693155] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   35.693158] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
[   35.711893] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010207
[   35.711894] CR0: 80050033 CR2: 000000c8 CR3: 0bef4000 CR4: 003406d0
[   35.715031] Code: 00 00 80 3d 84 b5 e1 cb 00 89 c2 a1 9c a5 f5 cb
75 48 55 89 e5 57 56 53 3e 8d 74 26 00 8b 1d 88 b5 e1 cb 31 f6 eb 27
8d 76 00 <8b> 8a c8 00 00 00 8b ba bc 00 00 00 29 f9 39 c8 0f 4f c1 8b
8a 98
[   35.724061] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   35.730317] EAX: 00000000 EBX: f5411000 ECX: 00000000 EDX: 00000000
[   35.730318] ESI: 00000000 EDI: f2d73c14 EBP: f2d73b78 ESP: f2d73b6c
[   35.736576] DR6: fffe0ff0 DR7: 00000400
[   35.803603] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010207
[   35.810380] CR0: 80050033 CR2: 000000c8 CR3: 33241000 CR4: 003406d0
[   35.816636] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   35.822893] DR6: fffe0ff0 DR7: 00000400
[   35.826725] Call Trace:
[   35.829171]  shrink_lruvec+0x447/0x630
[   35.832921]  ? check_preempt_curr+0x75/0x80
[   35.837100]  shrink_node+0x1be/0x640
[   35.840670]  ? shrink_node+0x1be/0x640
[   35.844412]  do_try_to_free_pages+0xc1/0x3b0
[   35.848677]  try_to_free_pages+0xba/0x1d0
[   35.852683]  __alloc_pages_nodemask+0x573/0xe90
[   35.857232]  ? set_bh_page+0x33/0x50
[   35.860829]  ? xas_load+0xf/0x70
[   35.864050]  ? __xa_set_mark+0x4d/0x70
[   35.867795]  ? find_get_entry+0x47/0x110
[   35.871714]  pagecache_get_page+0xbe/0x250
[   35.875805]  grab_cache_page_write_begin+0x1a/0x30
[   35.880588]  block_write_begin+0x25/0x90
[   35.884504]  blkdev_write_begin+0x1e/0x20
[   35.888507]  ? bdev_evict_inode+0xc0/0xc0
[   35.892513]  generic_perform_write+0x95/0x190
[   35.896863]  __generic_file_write_iter+0xe0/0x1a0
[   35.901562]  blkdev_write_iter+0xbf/0x1c0
[   35.905564]  __vfs_write+0x122/0x1e0
[   35.909136]  vfs_write+0x8f/0x1b0
[   35.912454]  ksys_pwrite64+0x60/0x80
[   35.916024]  __ia32_sys_ia32_pwrite64+0x16/0x20
[   35.920549]  do_fast_syscall_32+0x66/0x240
[   35.924641]  entry_SYSENTER_32+0xa5/0xf8
[   35.928567] EIP: 0xb7f72549
[   35.931357] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[   35.950093] EAX: ffffffda EBX: 00000003 ECX: b7866010 EDX: 00400000
[   35.956351] ESI: 39000000 EDI: 00000074 EBP: 07439000 ESP: bf973700
[   35.962607] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   35.969384] Modules linked in: x86_pkg_temp_thermal
[   35.974269] CR2: 00000000000000c8
[   35.977582] ---[ end trace d85b8564ea55fb0e ]---
[   35.977583] BUG: kernel NULL pointer dereference, address: 000000c8
[   35.977584] #PF: supervisor read access in kernel mode
[   35.982193] EIP: mem_cgroup_get_nr_swap_pages+0x28/0x60
[   35.982195] Code: 00 00 80 3d 84 b5 e1 cb 00 89 c2 a1 9c a5 f5 cb
75 48 55 89 e5 57 56 53 3e 8d 74 26 00 8b 1d 88 b5 e1 cb 31 f6 eb 27
8d 76 00 <8b> 8a c8 00 00 00 8b ba bc 00 00 00 29 f9 39 c8 0f 4f c1 8b
8a 98
[   35.988450] #PF: error_code(0x0000) - not-present page
[   35.988451] *pde = 00000000

full test log link,
https://lkft.validation.linaro.org/scheduler/job/1443939#L1170

- Naresh
