Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4A1DEC4A
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVPmJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEVPmH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 11:42:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62889C061A0E
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 08:42:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so13197165ljj.1
        for <cgroups@vger.kernel.org>; Fri, 22 May 2020 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOYVOHpaIS+oIho1dCUDLjlIT96AiPQqcbd2UVpV+2w=;
        b=xc5YNUMinAG4CGXABpBRi7fN1jT3RAq5g34Fsehb7FeGfXYItR+jv9zdzFUbWBZgED
         LmniBIdug9ZVwtsM86rfNB4Ym0c53ixm9EKzBW+98lrn+8iymUA1pl2rPFTIORF5gQ62
         S7DQ9GAYdIyD0+h/PDFxltIl+vny9nvjNZwtDFWooA9AaFqDP1f1M3b8WEMP5ciTcCjp
         W9NaNLJ0XScz6f3UhpDiAU5ZGmdgvxMde4+OxowuByFtU+aSTB2XW+29FZ21ruR/AtlZ
         X2z7XizfkhRaPFBSCM5YrIriiEQ/BuEbJkBwj+XeDUcSN1pBzeruIIxoHJrH2wvAAVgG
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOYVOHpaIS+oIho1dCUDLjlIT96AiPQqcbd2UVpV+2w=;
        b=fEOQQstIzrI4n7jqq1O3PP0aku0/KY2XyOC2T26SnPDLdqmIOpmuqFbvAWDphyHism
         U5Y/Cpd2EPiljZms+OU8jHvjjYPA7Y63Tz0ZpKpFWBeBcobJfd8R/WhHvd9Ssd/MNTTa
         tJptI/gIsb4xyLtqKiSKvT+86q0lz9ZGzFavH2XqknvuqdEo2JOOrzQ3DtY0u2iSrFST
         aBYo/mvhzCMSVbhCAvHkeJQrQyDKU+c7e18sZc1fdLxNTUU4wccB+XUJ7qDMEqMQMtVK
         mVzhy4Q1zWRvqGd9KyXWlDY9M/cEwkSXXIqG/lyOl8bHMi5wxOnP8V7DklabRsq+VBZa
         J7vQ==
X-Gm-Message-State: AOAM531rKDvUf5j5U9u2ypM03Qiw0ONwkrcd0OIDiPduYn9drVIU7CGM
        Zl63zPIEnA+ZH6g+X478r+NFnqtXZyW2NcT6bI8Vjg==
X-Google-Smtp-Source: ABdhPJxRJSZJBv5r7tYd2u0AUqK3zkVLdXL1DZDbhQE8M+i8GAUoeEfr4zqO0vZ1A56dhmdh581qQsP3Tbtb1mlvNY0=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr7582617ljd.102.1590162124742;
 Fri, 22 May 2020 08:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com> <20200522114544.GA1112005@chrisdown.name>
In-Reply-To: <20200522114544.GA1112005@chrisdown.name>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 May 2020 21:11:53 +0530
Message-ID: <CA+G9fYvw+oY-EK1+FYCUAD5-UGD4MhBGJHasjF+L5nLtzL2GLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, 22 May 2020 at 17:15, Chris Down <chris@chrisdown.name> wrote:
>
> Naresh Kamboju writes:
> >This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
> >running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.
>
> I think I see what's wrong here -- if we bail out early, memory.e{min,low}
> might be uninitialised.
>
> Does this patch fix it, by any chance?
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d3b23c57bed4..aa902b9cbb79 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5046,6 +5046,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>                         memory_cgrp_subsys.broken_hierarchy = true;
>         }
>
> +       memcg->memory.emin = 0;
> +       memcg->memory.elow = 0;
> +
>         /* The following stuff does not apply to the root */
>         if (!parent) {
>   #ifdef CONFIG_MEMCG_KMEM

This patch did not fix the problem.
The test log showing oom-killer link,
https://lkft.validation.linaro.org/scheduler/job/1445128#L1194

Build images:
https://builds.tuxbuild.com/YqW37GVsCHf8ndxOT2z1iQ/

- Naresh
