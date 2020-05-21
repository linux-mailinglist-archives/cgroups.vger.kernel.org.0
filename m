Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832D21DCA83
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgEUJzU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 05:55:20 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37644 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgEUJzU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 05:55:20 -0400
Received: by mail-ej1-f66.google.com with SMTP id l21so8068704eji.4;
        Thu, 21 May 2020 02:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bYIDtSe0AYOWKep27yvyR4GhELIyYbRcGxHnYqpsNk=;
        b=PRKR26Lz0e+qdIbEKH2d4X5454Hjintqj25qzGCUiD/kEfLjr9IXRWPQRWoHeqGY4u
         p35iqCdZlU9fz+6AiiCAH49ZFayzQkE7o1cIUvo2Z6V1tcg3kCX80SeTB1ACmSliGte/
         NDt1ZwiXQO7XqdXGS/4SAH27Y+s1LLrB+hSLWyLqz9J5IyTS7SQ1m8OW+tcfwR3wHeCt
         1QahWIEuUunpBK8u4m6Z8rWVZ2qMUtZ5YElgF3HEH31I27S6mdFBz6M2JelQ3kpiAwBP
         ZWmGo8hBxp3UXKykO0j5f1LZh0Fn8mShQJfHTHM0TpYir61E3TH3qqouhmDYHmC9NBls
         UKEg==
X-Gm-Message-State: AOAM532tUFI12dY9zTjGxaP6ss43+zPWTJ0Jx3dINb+OPcSaD1N8WaIu
        fM3j7EMeA8BCevq3siyuroE=
X-Google-Smtp-Source: ABdhPJwkPKl947oxLKA7srqAfs9xs94g1gTJJERLoHvA+HQQuyirxmJpvQaMulbG/+j+XCDL1aFAmA==
X-Received: by 2002:a17:906:3a11:: with SMTP id z17mr2778167eje.460.1590054916702;
        Thu, 21 May 2020 02:55:16 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id z12sm4507462edk.78.2020.05.21.02.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 02:55:15 -0700 (PDT)
Date:   Thu, 21 May 2020 11:55:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Chris Down <chris@chrisdown.name>
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200521095515.GK6462@dhcp22.suse.cz>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520190906.GA558281@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-05-20 20:09:06, Chris Down wrote:
> Hi Naresh,
> 
> Naresh Kamboju writes:
> > As a part of investigation on this issue LKFT teammate Anders Roxell
> > git bisected the problem and found bad commit(s) which caused this problem.
> > 
> > The following two patches have been reverted on next-20200519 and retested the
> > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > ( invoked oom-killer is gone now)
> > 
> > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > protection"
> >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > 
> > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > checks"
> >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> 
> Thanks Anders and Naresh for tracking this down and reverting.
> 
> I'll take a look tomorrow. I don't see anything immediately obviously wrong
> in either of those commits from a (very) cursory glance, but they should
> only be taking effect if protections are set.

Agreed. If memory.{low,min} is not used then the patch should be
effectively a nop. Btw. do you see the problem when booting with
cgroup_disable=memory kernel command line parameter?

I suspect that something might be initialized for memcg incorrectly and
the patch just makes it more visible for some reason.
-- 
Michal Hocko
SUSE Labs
