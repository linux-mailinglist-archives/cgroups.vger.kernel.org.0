Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833941DC9E6
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgEUJWY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgEUJWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 05:22:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524AC061A0F
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 02:22:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so4083015lfh.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIbEyFSF9lKlh/sPieDWc1oRqrvi4vGBjOrvNTlDQgI=;
        b=Cr+vYd5dIpgIP1m+dtPF8wLQuyM7qoaALMgtSirDDMRRIgqxpytD0hrSF2zko/x5mk
         l/G2FXraKn8PMsmRDq4Un6jQXt2HJ4hL78VRPU+qdLES1+ToQVDFdGiGtpaOGLK7F2zM
         6MKEL1a7yiV4ickufkf1ggX7LbmfPLokTuBN2TG1x20EISryRLnvWvNBgcl/y8m7/sVI
         MO9cnUWS6iHrtzbq50+WiROYQCTdiEG/ExnjIv1i160UasocMEWgmgikQ3pbvdWCeIhi
         xdBAwAYfUkhH3wWYCwg1eVm4WzkttSXEgcgDwM0Fh/LeRJSCjz+QgsRbYOOK7ojMzFLX
         xICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIbEyFSF9lKlh/sPieDWc1oRqrvi4vGBjOrvNTlDQgI=;
        b=lqB+wWzTAr6vm/ltZtiU1tFuMCig3k4mvE3LDuM6GSgke0ifRMW1FREx9oSYdH82LF
         MM8GHVEQV0K8rsfC9Rw2jQSfSGyag4bTKflOzTmI9m8lfhr8pBC0DXPhvDwkqBqsVNJQ
         s3KTY1wsaefuTO6BvyofrgJLhZ8RQZQm7J0ms+9JVVkxTUz+QL+YipjUe/cNeO+XMhzb
         lM7jOmXiPyar1cK++8OChznmxABRg4xzbsDLWEGP1eSTxmQ9meuYzNZUL+M1j4aBCRTA
         GxBRxiIG94KiQn2V5Ta4nQ9Eg/Ke78qu1cbJH/rN7PpduULjCUv6U85PW389sY8w63c1
         Hfvg==
X-Gm-Message-State: AOAM530tOxKuGs5dKaqBgtPN3mL1a4bLHEM/N6CMAzrcd6AEWcEg1N49
        Mf/vZ7TEYmc6E995mvjdj/qsyNrZgnpWLYAX2KvN3A==
X-Google-Smtp-Source: ABdhPJxo0iMvxRymbhbSSmZbSlzo/jmqeHEAf6W0prqay+f+/zEUegDczxDDUgR2FE8lvoDDugzyWov/NH6f84fYzgY=
X-Received: by 2002:a19:641b:: with SMTP id y27mr372964lfb.74.1590052942272;
 Thu, 21 May 2020 02:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz> <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com> <20200520190906.GA558281@chrisdown.name>
In-Reply-To: <20200520190906.GA558281@chrisdown.name>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 May 2020 14:52:08 +0530
Message-ID: <CA+G9fYt1qvGQTAdUZ4WgitY18cydgnNzqu_fyoTtSm3W8JhF3w@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
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

On Thu, 21 May 2020 at 00:39, Chris Down <chris@chrisdown.name> wrote:
>
> Hi Naresh,
>
> Naresh Kamboju writes:
> >As a part of investigation on this issue LKFT teammate Anders Roxell
> >git bisected the problem and found bad commit(s) which caused this problem.
> >
> >The following two patches have been reverted on next-20200519 and retested the
> >reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> >( invoked oom-killer is gone now)
> >
> >Revert "mm, memcg: avoid stale protection values when cgroup is above
> >protection"
> >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> >
> >Revert "mm, memcg: decouple e{low,min} state mutations from protection
> >checks"
> >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
>
> Thanks Anders and Naresh for tracking this down and reverting.
>
> I'll take a look tomorrow. I don't see anything immediately obviously wrong in
> either of those commits from a (very) cursory glance, but they should only be
> taking effect if protections are set.
>
> Since you have i386 hardware available, and I don't, could you please apply
> only "avoid stale protection" again and check if it only happens with that
> commit, or requires both? That would help narrow down the suspects.

Not both.
The bad commit is
"mm, memcg: decouple e{low,min} state mutations from protection checks"

>
> Do you use any memcg protections in these tests?
I see three MEMCG configs and please find the kernel config link
for more details.

CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y

kernel config link,
https://builds.tuxbuild.com/8lg6WQibcwtQRRtIa0bcFA/kernel.config

- Naresh
