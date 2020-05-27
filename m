Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252501E4AF8
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgE0QuX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgE0QuX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 May 2020 12:50:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD894C05BD1E
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 09:50:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so29830777ljo.0
        for <cgroups@vger.kernel.org>; Wed, 27 May 2020 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zPnuLTvgprdTVM4lyX4wiBkB+XwPNWKNu3f5Lxz02s=;
        b=eN/xrHM4bcrmGppt3VwmPF48oii8uREomXNXGJofLy/UiMHveURMD8R31PSOHxW+fx
         VCzf2zlhdE422jlGR2fETv7FS+o67Bl3zmIbl175bgQsf1+bvkaO8Fh4qEKsDHeHedyA
         AT3mvMzj3zZdlmYGhFd7kcZ34AZq1oMxcHAGYl22G8aWeicey18DykQEze99QWaVzttx
         4VH8vFuYd1U1Okb5SdQXc+EoZytk9eGTvgRumvb6QSjRouqOgzmsouN1X69gjYwftTBZ
         BkpDC3DchvTHnJvHkbVChjblgiUXDjqEt8LgGWsvzEKtHTW6wnQlsVer6XxRBzfqXcgO
         +rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zPnuLTvgprdTVM4lyX4wiBkB+XwPNWKNu3f5Lxz02s=;
        b=sFo/VqxLR1foOw2NLYs68c5xDMhFigAsmNFVMrtBwBoxEbVc2BjbRPXmzX/SpgIHDi
         x5dl8ajh9J6+Es3coIYc8Tf/AAxPenVC8aKRvBGbVmcUfQOlgyuNccIWIlQMzIMVojjC
         +d0WX6tBXW0oRaTcClQj2nGxN3APCVn6JlSwSzodEbVG1uzsQnJ1k5wmYBPqz5fd8WDU
         5BA/jS6UzsOpCGr+PtBYY+EuNgWKmA1ij6QEUCcxMWuyWYr6/o6wqTr7wQSgoWb1iUL7
         ovT6t17nbq0hpoYWWpc0Kg20Wnwzh2WVWQLeFV45fbZFDGGK9jeBtsNgHcwe0PBFcodJ
         PPIA==
X-Gm-Message-State: AOAM531fRHIZRzB1PPmL4MVijVVHSbc8+EE4WLhl7f17iir5zdKilzFJ
        5P47f5a5nnjqZ+src36UxkF8dcyApoaaennNLYkjllwv
X-Google-Smtp-Source: ABdhPJxd4n5gepYQ3iTBd03RHtrAoA8GfOgL4pSvv2448ISIpzVRCCn1ztoXBlb3uTPyhPTcBQw2H6IqoO/uSjBX9H4=
X-Received: by 2002:a2e:8e79:: with SMTP id t25mr3730099ljk.446.1590598221022;
 Wed, 27 May 2020 09:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz> <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz> <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
In-Reply-To: <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 May 2020 09:50:07 -0700
Message-ID: <CALvZod6hqkhECNX1gW9=bOwDhHQCV02p6zuu-qNFuiVEF1jjBg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Zefan Li <lizefan@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 25, 2020 at 6:25 PM Zefan Li <lizefan@huawei.com> wrote:
>
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
>
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, and it's nothing wrong for this usage, it's
> better we fix it now.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Zefan Li <lizefan@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
