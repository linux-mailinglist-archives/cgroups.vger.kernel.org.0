Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5778F1DECA5
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgEVP7r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbgEVP7q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 11:59:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5AC061A0E;
        Fri, 22 May 2020 08:59:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so11836826iow.8;
        Fri, 22 May 2020 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtPsqd22g3xbib6xneI+Ag2OgkbCbIH9D8ABYL46yvQ=;
        b=iX98S1WGX0zPid+2GXhESW1748JtgtC//+o9Z1F8m/xa5JKbz+Xyp5/HEm3s+HscxF
         PgYK8FIamFK3CI58sGojA9grfQvJZFnP9ya0ZoF5K4tTa6/xzRJMIdxyTCENI3GdOoDh
         5zW/tbDQNIHSibqa3CRDg6aEZXrK2m+DmkHRGip9WLbfKWWeEuesPxQup+wQDdzGHCtX
         FX5w21SF6Ba8f/5juYPYHOwSoy7ijAt1xiGYhc1ZavjgL8/W2sP8mvOHKjwEMav5S+D+
         WHwQ5eKEygwvlcO26ca3Ir7ykZ1XlL1DRq2jZ/p6dmIyE2Cy7ofcSXkZvqFLg3hwYr77
         nDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtPsqd22g3xbib6xneI+Ag2OgkbCbIH9D8ABYL46yvQ=;
        b=IQ5Z/PadTVSGtkA9whMgjLLZpQI+Zje2FfMa7ORqcSY4oJHnDw8TTHU+gweps6Sl7/
         OCt8hGqB7ORYRAQdtHmEW3lh4oamGbXd/CFSH12CY6jpfSIhQ/95iZYWlAcAOPg2jEkI
         OJEODy5aNg5z8wTB2PmViQfzAzDRt+jg2+RRafH0J9eGEzOiFfjtzM3MUmL1iyxITcOZ
         oduK/1iPkeeP5OCxfJsmHj0mk2ARBHtQD6YmUZvgRT1xvq2tmuU+RA+4M4bPKHN4oJfs
         GfgEmNfS//zGmIWVRgKZmh4SDzjKOzXcsy/qgIn5Ug0M/s/EJrPR7AE5CbEsRtCz2PIU
         fGIQ==
X-Gm-Message-State: AOAM530eMg6yXLnbLv/W8ItzZmfiVBEkDPQ5ol4hE5yYA0gRS2Cppqix
        1PTWMSSkrc2DFNu1a9dacXBBphOcbuXmKfGg9c4=
X-Google-Smtp-Source: ABdhPJwEADjPyPpOhtgfkIVLI9+BWB8R/8zf8Ln6JidFocTsi9UCdU026PUhwWp0FEIDIdvlr24GL48qnx64PVlZdiY=
X-Received: by 2002:a02:212c:: with SMTP id e44mr8556443jaa.109.1590163185281;
 Fri, 22 May 2020 08:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
 <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com> <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 22 May 2020 23:59:09 +0800
Message-ID: <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
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

On Fri, May 22, 2020 at 11:52 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 17:49, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 7:01 PM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 5 May 2020 at 14:12, Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > From: Chris Down <chris@chrisdown.name>
> > > >
> > > > mem_cgroup_protected currently is both used to set effective low and min
> > > > and return a mem_cgroup_protection based on the result.  As a user, this
> > > > can be a little unexpected: it appears to be a simple predicate function,
> > > > if not for the big warning in the comment above about the order in which
> > > > it must be executed.
> > > >
> > > > This change makes it so that we separate the state mutations from the
> > > > actual protection checks, which makes it more obvious where we need to be
> > > > careful mutating internal state, and where we are simply checking and
> > > > don't need to worry about that.
> > >
> > > This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
> > > running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.
> > >
> >
> > Hi Narash,
> >
> > Thanks for your report.
> > My suggestion to the issue found by you is reverting this bad commit.
>
> Thanks for giving details on this problem.
> I am not sure who will propose reverting this patch on the linux-next tree.
> Please add Reported-by if it is sane.
>

I will do it.
If no one has objection to my proposal, I will send it tomorrow.

> >
> > As I have explained earlier in another mail thread [1] that the usage
> > around memcg->{emin, elow} is very buggy.
> > We shouldn't use memcg->{emin, elow} in the reclaim context directly,
> > because  these two values can be modified by many reclaimers, so the
> > good usage of it is storing the protection value into the
> > scan_control. IOW, different reclaimers have different protection.
> > But unfortunately my suggestion is ignored.
> >
> > We can set them to 0 before using them to workaround the issue found
> > by you, but the fact is that we will introduce a new issue once we fix
> > an old issue.
> >
> > [1]. https://lore.kernel.org/linux-mm/20200425152418.28388-1-laoar.shao@gmail.com/
>
>
> - Naresh



-- 
Thanks
Yafang
