Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8D39063C
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEYQLK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEYQLJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 May 2021 12:11:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB55BC061574;
        Tue, 25 May 2021 09:09:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h16so36865167edr.6;
        Tue, 25 May 2021 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6s3ZtPWtmcbcuCeFGZbGrPYTepr+v29FJOymW4C+CY=;
        b=TI96WuRxMj8Pb/NY0nygtA/+Bl5w6M+BxwVGoRPlVAqEaxjSm8XSyTA6izGFX12/Ul
         cswyq/6GOFnWHlaXm4bu6LPk+ZzqOPk5SiHTvUcpQuoxIAwlqwh1WddtcFBrJOe0RfyK
         /HLD3j1Ll/Zxl6eplQ+KPIWGpaeF9WD5jXehoNlTNCB40w5+BKhNYiih8iFIdIKtrtKv
         CTJIdfSIqH972mbqjwxz1Oeq4ZN3cQef5wSyjbxhHryWuwexoCXy1NUJ7qpkrTckbo6p
         xYy7uy2ul+TARuzDwtX+4jJLB+V/Wz/jZEuoSCcq714rDsQfvcQFU1miuWz7Wl+KuGfO
         1Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6s3ZtPWtmcbcuCeFGZbGrPYTepr+v29FJOymW4C+CY=;
        b=MrqdkXNvQ8j/vURUgQenZ26183FnN88upzqeSJN21jchUb6s2e+/OCR7hXofMCnut8
         lF1xZM/T4HaELqaYMiSTOargtWaqPaERjMbXjzdGgEnW7R+Mm/OnCr2D8RiqEn1F8918
         YOaoI4KKFPF8G0PDHYNOINgKTmbWI7QLzxtDDsCy29MsdoGViC2whWtGnHPNFUqRPFG8
         mT9jfvaH/ZXAa6RFLLKJKM8z12jzUqRB9mG9XqJBz68gMORfFZKYLU/NpbY/Cayt+u6w
         E0s19bgSMkaM7atRGW5zWUg5drBoicI8lyvPcCNwS95Fnik+matuPry9AwupeqJLTGxV
         usOg==
X-Gm-Message-State: AOAM531cUr8A+6m/DaKydmaD5b91xXC1IC1Z4/hjBgKcUfaxDRyQfEJ1
        svEeMeSeuZqdV0jr/3xxAqKWzlpWAUCptlCejoU=
X-Google-Smtp-Source: ABdhPJwL63jd+Bw4iwsElTHxLE0xRt0eK9TsXFTrEfzZ9Mb+cpq5NYWjUWMfGLevpfJq0ciG8uGZDIqu8ilR/pnmr9U=
X-Received: by 2002:a05:6402:3513:: with SMTP id b19mr31060270edd.137.1621958978427;
 Tue, 25 May 2021 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <1621851862-34443-1-git-send-email-yang.lee@linux.alibaba.com> <YKy2o2WGRcD7vht8@dhcp22.suse.cz>
In-Reply-To: <YKy2o2WGRcD7vht8@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 May 2021 09:09:26 -0700
Message-ID: <CAHbLzkr1rUM7M5uv=LgCQtOngpwg-tUGMj9MUp7CkirDLMSwHw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix kernel-doc
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 25, 2021 at 1:34 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 24-05-21 18:24:22, Yang Li wrote:
> > Fix function name in mm/memcontrol.c kernel-doc comment
> > to remove a warning.
> >
> > mm/memcontrol.c:6546: warning: expecting prototype for
> > mem_cgroup_protected(). Prototype was for
> > mem_cgroup_calculate_protection() instead.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

It seems this has been covered by Mel's W=1 warning cleanup series,
see https://lore.kernel.org/linux-mm/20210520084809.8576-7-mgorman@techsingularity.net/.

>
> Thanks!
>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 64ada9e..030c1dc 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6456,7 +6456,7 @@ static unsigned long effective_protection(unsigned long usage,
> >  }
> >
> >  /**
> > - * mem_cgroup_protected - check if memory consumption is in the normal range
> > + * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
> >   * @root: the top ancestor of the sub-tree being checked
> >   * @memcg: the memory cgroup to check
> >   *
> > --
> > 1.8.3.1
>
> --
> Michal Hocko
> SUSE Labs
>
