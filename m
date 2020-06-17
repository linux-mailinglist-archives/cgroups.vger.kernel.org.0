Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F01FD154
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFQPxV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQPxU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 11:53:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FDC0613ED
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 08:53:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so3484705ljh.7
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=;
        b=zhIwFYvqS5d/Wg1MMLhDRV3GH6WnWZlkpKF5Gvf2n+o3mBbraSv6/+gF1/wVQ7Kcyp
         adAODQsWOEjXxtmaTAY8OOgeomh977J+Ip2X4RUs+QJLXP8fCHiBMryYWwGWY4gfVz+j
         OiEw3dpJmeQ9Ih8zjHeprM4Gt9tFC88PRlY3V32JvNQHp+cM065+LxGIkdQfR1HdKSbO
         xKOJtEAbSIP0jDNqHyXlIFM3pvnyIAdrXeT9Vjt+d3kXsBP5VgSVyDytRxe/UXnnLsyA
         sJ7nJiD9AsZ7Gc1Ka2IK/tLWXp9TnAK5clcp93WHPbbonXUq5u2axMTwgQjbamGfwQSH
         D6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=;
        b=UdOql17d7jXm+ntdGFGvr/kvVDtv0tZ6ob6leB5hjFF5LArAIaiTOOUQLVBdN6n37j
         UoV6kOvzGk6kYgZZmj9RD5w5faiL50FIaWvRgmhBEBbt7I0YbKiOflnyhYxG+LSIYLhb
         4Fr/hcc7p9ZeEfBiiusr2WMivfCLMbzD7nNHDHykUtoLhJaYo2DGm3310wEbRwhr2iAG
         n7xN9Fq0KAfs3M1JM3a0Wexjau1m0LCaFElBQ5iWy/nZpe0XSRNb+jvVw3fuOkYqnV1K
         vypiZ1wCL21ifyoprZpzfYwTiKBuJ77KCfTCEOBzP52eKcJJcsD5lkdEdphMyuHOp+hR
         A7HA==
X-Gm-Message-State: AOAM531TwhmpKXxfGgyVTToIlrJKHt60dSWWqMmHhNL75Rf8wiy6hgOO
        97fhb5Kcekys93TO9uFRgOc4EXY5E0BQPm63Ik0iqA==
X-Google-Smtp-Source: ABdhPJwm+SOMxQr6ZmVaQG7EF/eaCNB4joE8BGqCN9p7milYkBjvhRKAPIHCQedzXSIf3foSUUfPOKBfz2Igul1hd1Q=
X-Received: by 2002:a2e:911:: with SMTP id 17mr4655723ljj.411.1592409197458;
 Wed, 17 Jun 2020 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz> <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name> <20200617141155.GQ9499@dhcp22.suse.cz>
In-Reply-To: <20200617141155.GQ9499@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Jun 2020 21:23:05 +0530
Message-ID: <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Chris Down <chris@chrisdown.name>, Michal Hocko <mhocko@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
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

On Wed, 17 Jun 2020 at 19:41, Michal Hocko <mhocko@kernel.org> wrote:
>
> [Our emails have crossed]
>
> On Wed 17-06-20 14:57:58, Chris Down wrote:
> > Naresh Kamboju writes:
> > > mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> > > mke2fs 1.43.8 (1-Jan-2018)
> > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> > > Superblock backups stored on blocks:
> > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > 102400000, 214990848
> > > Allocating group tables:    0/7453 done
> > > Writing inode tables:    0/7453 done
> > > Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> > > [   51.845304] under min:0 emin:0
> > > [   51.848738] under min:0 emin:0
> > > [   51.858147] under min:0 emin:0
> > > [   51.861333] under min:0 emin:0
> > > [   51.862034] under min:0 emin:0
> > > [   51.862442] under min:0 emin:0
> > > [   51.862763] under min:0 emin:0
> >
> > Thanks, this helps a lot. Somehow we're entering mem_cgroup_below_min even
> > when min/emin is 0 (which should indeed be the case if you haven't set them
> > in the hierarchy).
> >
> > My guess is that page_counter_read(&memcg->memory) is 0, which means
> > mem_cgroup_below_min will return 1.
>
> Yes this is the case because this is likely the root memcg which skips
> all charges.
>
> > However, I don't know for sure why that should then result in the OOM killer
> > coming along. My guess is that since this memcg has 0 pages to scan anyway,
> > we enter premature OOM under some conditions. I don't know why we wouldn't
> > have hit that with the old version of mem_cgroup_protected that returned
> > MEMCG_PROT_* members, though.
>
> Not really. There is likely no other memcg to reclaim from and assuming
> min limit protection will result in no reclaimable memory and thus the
> OOM killer.
>
> > Can you please try the patch with the `>=` checks in mem_cgroup_below_min
> > and mem_cgroup_below_low changed to `>`? If that fixes it, then that gives a
> > strong hint about what's going on here.
>
> This would work but I believe an explicit check for the root memcg would
> be easier to spot the reasoning.

May I request you to send debugging or proposed fix patches here.
I am happy to do more testing.

FYI,
Here is my repository for testing.
git: https://github.com/nareshkamboju/linux/tree/printk
branch: printk

- Naresh
