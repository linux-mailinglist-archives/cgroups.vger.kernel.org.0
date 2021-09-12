Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8277E407E67
	for <lists+cgroups@lfdr.de>; Sun, 12 Sep 2021 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhILQHL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Sep 2021 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhILQHK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Sep 2021 12:07:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D6C061757
        for <cgroups@vger.kernel.org>; Sun, 12 Sep 2021 09:05:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id i28so12549063ljm.7
        for <cgroups@vger.kernel.org>; Sun, 12 Sep 2021 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=08mAPjyxBKrJAINcSHI5DwIe03TZTttNNN61qA9Q5BI=;
        b=WGHGy2wTwEa24xnd0LxtlPuE1NdaZtAac70TQ59rf4FCpLXG4snXCOzj26Eq9wc+ZH
         UMZSXdGP4oVIKywhZS0qlnqoWJBgiq3kFoRaOnLu6yCW1OjYKGSYnKbq8CF6T09LUNzG
         bG5Qlt8g/l/0FRrCFdRHREY54BGmwMQhd+BDMp1cIDM+GZ32/dQsjKGpcpio31T6PtPl
         Mhdu/isuIxrUBMg3L5hMWxUo1lhPHjDP0xpe50er80KHRN5LL84pMoNlommMKYVl5N4/
         mFPnJSR3HVCa8OgAe1tpUVSQ/hMCufYdKoMUNoopOXSCLZPaujn8u78vA5lM1tX7xh5e
         OkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08mAPjyxBKrJAINcSHI5DwIe03TZTttNNN61qA9Q5BI=;
        b=zpZvomZdWLYaCB5LLMP4SzizlTGEQh0RKv90SFEmLPAEL9lBGt6az9FkGjmY4i981g
         SWi/SAlMzLux7Jym9Sb6+wkrZQ6KDf0svo8toMcNp2e8cCo3dQcwCDjtEW8U8it/JwJd
         t78ZzdDwVXnND8MSOLmkt6FpKvInyvC5r9JhODwRUExVqt++H4eryKKMkuosGdtq6yjL
         Sxcs0aoFN7OmLUNDdacfKui3jHVVd/caPYUgucykTAFxjqvw9WRFOijrfU2U3o+p56ar
         Au9AG1l/NGxD74k3zk4I8rwEfdn9pRUxESH8t/Lz0W7ozSFVg+qQnFKS0BuOkgMIi9mt
         MQhQ==
X-Gm-Message-State: AOAM531VyD3yV0LjPnlsB/6OOPs88NpyxM9Foad2GbapOJBfaZn+7ZN0
        /HGuOA/n7CIlUzQB03PtxlUYrDc3KjIluRtsRKwMRg==
X-Google-Smtp-Source: ABdhPJxvhpwJG6MZq1Om4/zWjIcDhz3EmGkbn5UXz3sCnHFftIBd5W2WMMXVlu3GmhLJQ+mCrpUB1mJmVs3xf28f6G0=
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr6436000ljp.35.1631462753264;
 Sun, 12 Sep 2021 09:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
In-Reply-To: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 12 Sep 2021 09:05:41 -0700
Message-ID: <CALvZod5vBkoJ5PpXTW7CCMD9UjMkqK2sQuxK_LXn+W8ddDP5Nw@mail.gmail.com>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in do_semtimedop()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 11, 2021 at 12:40 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Linus proposes to revert an accounting for sops objects in
> do_semtimedop() because it's really just a temporary buffer
> for a single semtimedop() system call.
>
> This object can consume up to 2 pages, syscall is sleeping one,
> size and duration can be controlled by user, and this allocation
> can be repeated by many thread at the same time.
>
> However Shakeel Butt pointed that there are much more popular objects
> with the same life time and similar memory consumption, the accounting
> of which was decided to be rejected for performance reasons.
>
> In addition, any usual task consumes much more accounted memory,
> so 2 pages of this temporal buffer can be safely ignored.
>
> Link: https://patchwork.kernel.org/project/linux-fsdevel/patch/20171005222144.123797-1-shakeelb@google.com/
>
> Fixes: 18319498fdd4 ("memcg: enable accounting of ipc resources")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks Vasily.

Acked-by: Shakeel Butt <shakeelb@google.com>
