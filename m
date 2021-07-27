Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652DC3D8316
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 00:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhG0WhK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhG0WhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 18:37:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9FDC061760
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:37:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d18so204782lfb.6
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9riWywpJIN08LA7hQqUxqDxz6rPo4nB08ihydLn/AQ=;
        b=gsi7ICxX3ii2PVLmoIZtbBP0sGaJTU2D5/yA3Ue2ciJeEvL1IJrMuRT/R4K+SEAU83
         dflfu+Kv3TLZT5zypULzNgkU0BxQVsaYvBuZCiiacoY7mOBwZWlhz86OhP+QozXBliwD
         PM88Om9Hc4nuKpfSc1WXAx3wU1tvWkkF7e8POK0mPB6S/TYEKZt/qsCWV7KLuWjm+MmN
         jTnKKr0ZoV54o/SxlyKF0bRskE2KKw4AKUYMzGjmbhz/ZFBBBRoe7LyRCAhqF7+ZcHmg
         DJnoniScr++Z7XjGjrgJIxV2pshZQsHb8o57jYwclc/FgRIiKZA45kPQr3r8ajnRDcdx
         ytUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9riWywpJIN08LA7hQqUxqDxz6rPo4nB08ihydLn/AQ=;
        b=AS23SktTdoLrUSBACe6Ibhd4MCmvg0U/3LgTOBUKZtA0zVs41Hgb3cpBbueNbJziFN
         YH0DgOYBvLi3Z9U/S68+2+4twTesFnwblFuLe/LCi4TimDwo+GhULgqzluZVi0FGHHf7
         73cZin0AC0JIHnY+0+DYvIFgp4e13GUk4Y9wf53cIN1a1JuCR+hjXQvf3HmgBmx8ULCB
         bORUxTqCxmw0AGXoHVC+cw19CqADzsYXP8I1/IElcEE9b93BOUyAThH/4BbwEinyXQOz
         CEeXiug+nEOvMgpkG35/04AC08sKfbSmZocpEsnY7NQ7+CqLXFK5fLVMjZLWP8Av6XjV
         ovqA==
X-Gm-Message-State: AOAM533gqoVGKSLQ1jpnW3FGQyOReE0Xa9DnBWX/NM1GGhCkvn2BDZXQ
        eNWGoTM8FXwN1Ns9xj8KkA1omdVOs2rHLyHeK5NMoQ==
X-Google-Smtp-Source: ABdhPJxUmYNfrHrhlC1TWMGZ/YhIFjINWSi+Sb4kc7CNsyJGjSAqPTGe2bB3FhSVlyVun0zMiuqClzgHz5QZqK1kQEs=
X-Received: by 2002:a19:dc50:: with SMTP id f16mr17876997lfj.347.1627425425864;
 Tue, 27 Jul 2021 15:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <38010594-50fe-c06d-7cb0-d1f77ca422f3@virtuozzo.com>
In-Reply-To: <38010594-50fe-c06d-7cb0-d1f77ca422f3@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 15:36:54 -0700
Message-ID: <CALvZod4OjK75uh2nHA8QOfefUSXD7ZSxm3qaQY+aA9zDuKmNnw@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] memcg: enable accounting for ldt_struct objects
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:34 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Each task can request own LDT and force the kernel to allocate up to
> 64Kb memory per-mm.
>
> There are legitimate workloads with hundreds of processes and there
> can be hundreds of workloads running on large machines.
> The unaccounted memory can cause isolation issues between the workloads
> particularly on highly utilized machines.
>
> It makes sense to account for this objects to restrict the host's memory
> consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Acked-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
