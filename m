Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6756F1DEC78
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgEVPw2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgEVPw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 11:52:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70686C05BD43
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 08:52:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so13171293ljm.10
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzV3LzaWpLqEQz7xrfeZadAQqncDoc1EoDALXRQg684=;
        b=ecrd2p+Z0xMZv/rR6DTAk5eHxnu75cCVZpIkVUiOxAmcn/uGpQ76fe/RdYBKnDGcNn
         usKsFYHUfc8IJCeFK9TCnwsZJ4fFoXwPZi38YsnLumjKeWClT6zb2dBkvWdrh8TjMOI9
         8TtgdhQPEeNYdC3iQygERG3JLD9kJoFmJI7kU+y+UnuA8f/PWrbFeKevQIHrjaYjxt4U
         MmfN3Pife0Kp4EFyVi4c5qQrGPrdhfTRwHqE6Oj/xmUdmr8EnwGhaaScT9eN7b9A2E5R
         Zh3t5sJfRGMtIsUynAxujcjs1et1BKPZDN3OKbUGTRtl+OxOximszArRCkFy9E5vnuGQ
         FETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzV3LzaWpLqEQz7xrfeZadAQqncDoc1EoDALXRQg684=;
        b=iIXhOTZbMsP3Hbk9xz3y3eTlDtfBjSTDqZ0djSvqQX1doDE4SJWJWkmWuw5ggtA9iu
         CKPsPnqfS8otdfRREoOSgIFVr0MeqeEmgH7BnpcSSS434TZPxe/DAb3karAGGMH3tMR3
         tPwFpm9IR+JES07ku82YRLO0Y3NPx327yWCxaLX4odUrB135WD35+ttNIEhW+Zh2YXuw
         TiRX0nbSm+q0JwoYRUXwBMN2vfkbK485c0Q8Nhw4+IaBg79qk1h5+wu1P5O0SpcknIUP
         WT8RBn844EJL4OyUx8TKxWCKCvWnu9PCpbNLXFS/MrkOZ6E5CFA3T/3FXNWp9RbtL6EB
         zVlg==
X-Gm-Message-State: AOAM532TXDrrfc2rEDkXS3lE1jkV2jrKWfrq//Slk7u5Dt/iH+IjcOXW
        +GQgTFmj1sL1bvVG5NZnfq44OCHKCfl2gMUBUbzN2g==
X-Google-Smtp-Source: ABdhPJyoOnv1UJQoinATeYtCls35JqiM0/st8sfeEGPkx4jFpRm7nah+R85ozQ/WMeV5DKPIZJHQuWiAHxtmBBAWgFc=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr5424550ljj.358.1590162744672;
 Fri, 22 May 2020 08:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com> <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
In-Reply-To: <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 May 2020 21:22:13 +0530
Message-ID: <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 22 May 2020 at 17:49, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 7:01 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 5 May 2020 at 14:12, Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > From: Chris Down <chris@chrisdown.name>
> > >
> > > mem_cgroup_protected currently is both used to set effective low and min
> > > and return a mem_cgroup_protection based on the result.  As a user, this
> > > can be a little unexpected: it appears to be a simple predicate function,
> > > if not for the big warning in the comment above about the order in which
> > > it must be executed.
> > >
> > > This change makes it so that we separate the state mutations from the
> > > actual protection checks, which makes it more obvious where we need to be
> > > careful mutating internal state, and where we are simply checking and
> > > don't need to worry about that.
> >
> > This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
> > running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.
> >
>
> Hi Narash,
>
> Thanks for your report.
> My suggestion to the issue found by you is reverting this bad commit.

Thanks for giving details on this problem.
I am not sure who will propose reverting this patch on the linux-next tree.
Please add Reported-by if it is sane.

>
> As I have explained earlier in another mail thread [1] that the usage
> around memcg->{emin, elow} is very buggy.
> We shouldn't use memcg->{emin, elow} in the reclaim context directly,
> because  these two values can be modified by many reclaimers, so the
> good usage of it is storing the protection value into the
> scan_control. IOW, different reclaimers have different protection.
> But unfortunately my suggestion is ignored.
>
> We can set them to 0 before using them to workaround the issue found
> by you, but the fact is that we will introduce a new issue once we fix
> an old issue.
>
> [1]. https://lore.kernel.org/linux-mm/20200425152418.28388-1-laoar.shao@gmail.com/


- Naresh
