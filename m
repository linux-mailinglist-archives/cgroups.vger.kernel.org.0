Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E96332F2C
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCITk0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 14:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCITjz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 14:39:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C0C06174A
        for <cgroups@vger.kernel.org>; Tue,  9 Mar 2021 11:39:54 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r3so20993383lfc.13
        for <cgroups@vger.kernel.org>; Tue, 09 Mar 2021 11:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O46M3IIWV4RV88W2VUWchBj7kwlQmirz9u+5Alym8yc=;
        b=m2G4dpRKCKk4jAg5sje4s8QPtz+nuPv9/ny7IjNDQ40seewDXWUrpQnBW2ZtvbFkdX
         sLuivAlg3hdtXWVYzKghMWNIet57gAxVg5Jyd4Chjk0Ss54nblyCP3DKQdjk+q8ip9uw
         dQaw4fDbgJqwnukPuBBi/X6uptSI19BeLBryTRWseEiZ7kDnorSJsrWLexiAEGQ/5l9Y
         ut0CwZo2K9aDnRu9OpC6gyYJPbdZCkq2DDo2UJzxL20MOhLH65tBairR93pWREEo5cZ0
         M7ciABLzghZJ8mmp3ZdaBBnplgO7juWHIaJEDMMB5VcQR08TBNYL+JcR/VymX7c4FI57
         oCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O46M3IIWV4RV88W2VUWchBj7kwlQmirz9u+5Alym8yc=;
        b=BpglLN/ut6VK79VrUpc2w/jTXq7oJWsIwL2ZtTMYnFbiNU82gArBAXinF07uXoqSCf
         K4vqhCYa5s5g+/k/5QGxMdGqaPIVhrk1JdsTAtIYlaC3Z71nsgKqnw9M7lfGTnLTq9b2
         SrpvyBd7ZOuWEG9wOtXVh/WKINvtRQfSCm+mnUkg8vnY8d+0yhWQ+xncSN6FFcAvgF/I
         kTYdMHqWqqoEfwsAwWMHlseb5DE36l4OreazcTGNbA/xRoc4gs6eM2fYPRAIUx4W1JSh
         MmpcTJIoxQG2Vp1W6Lt4WfRby7ypSOhprZX0RCwl2FfvBjFgD6hKrIXG3eIF3FwLBFq6
         GRaA==
X-Gm-Message-State: AOAM532KEp8GXn+8XZXDquC20XrgWvdLAouscAMNlVacGM3DAdc5kDn3
        FwIUEQanHvhuEUgqvh2BYPVsX0FMeksiFJo/hv1de6gO2Pk=
X-Google-Smtp-Source: ABdhPJwZ/ZgQyM4Yah2VVD5YuOSsVe+6+Bkx02Hn3jyr7xsc0JAq6msUO432fuBOvP2pKGGrmU7IKychmWghvMBJ4rk=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr3559391lfo.549.1615318792567;
 Tue, 09 Mar 2021 11:39:52 -0800 (PST)
MIME-Version: 1.0
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
In-Reply-To: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Mar 2021 11:39:41 -0800
Message-ID: <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> in_interrupt() check in memcg_kmem_bypass() is incorrect because
> it does not allow to account memory allocation called from task context
> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

In that file in_interrupt() is used at other places too. Should we
change those too?

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec0..568f2cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>                 return false;
>
>         /* Memcg to charge can't be determined. */
> -       if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +       if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
>                 return true;
>
>         return false;
> --
> 1.8.3.1
>
