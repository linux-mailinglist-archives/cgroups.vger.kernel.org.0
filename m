Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C85392C4C
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhE0LGd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbhE0LGc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 07:06:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DFC061574
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 04:04:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h24so3106978qtm.12
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKuENeFAgLIoL5+XgHz8hQNxrwiJoPEw10HrNs/Gaaw=;
        b=tU4ZEb/yV70ErzupnLLI8qX0LRJtuEl5gH/tESbYnyYx1pkyGt2KvOBney1Tt7Squn
         fQs2goEXPg8AwytKWVqyh9iAMVUSNLRZFcdGAQ74TZ58Kjiv3OzKkUSXPpw4v7TY8ODP
         4tUUgSYsfYnZVoXM6fIVvtxhsllB7nE6Dg+SI+6pzkt8n3MUfXaJlV9Uxv5dnPceHKwW
         52AkymOG9Zl4d6OHJ9tIpZuxM4KF8efcj8YxuuoWYKSaAVL4i+CMKq6okkHejryw4uVH
         rgDbs5IICAp1yWk0uG7Ssdo6PkqfaAL+lqFPv82poBEsvU9UCDk/hOvrKVEMJ5pRsTEP
         bU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKuENeFAgLIoL5+XgHz8hQNxrwiJoPEw10HrNs/Gaaw=;
        b=AgIuzeUOE2oZXy5XHzqNd+k6dxXHh/BllCOP5k+jZM2SLsOq/WWOSJBttG5JeY33LV
         t535KRv/cErUqEWgglhoxjO39w72IaaCAVqmOyddwynyeBKAexH7YYcFSQIZ09mXhYBx
         J4MSrQ3dFYNW5uQgo2D1BBBPLv04nPT4QqFj70/MADJWm3awTDLyRRDgSS1Wrag4QV/6
         PcJ2cSM3Gxri33NwxdTszYD0zRHMmevrwC1BtoekgOhoJ9AC39AxVFU8bXhq+M47QPgi
         /xLTxIlZ32LP0A+arJ48UyNKjMti0TBJyOK3ZkTinPXtIz1i8+CC1Pv0quMbJYcWXPTV
         Dmaw==
X-Gm-Message-State: AOAM531taOXJ9kDDhwx7LqxVtoGQMv7/GF916swQL57mw7Lad0jI5cpq
        tw0T03KQwDblFMur4Gy2VS/KDJQpL0Zwg7CGfRzAcw==
X-Google-Smtp-Source: ABdhPJxG3Yh4FKpRHmIl7UWCdfFwkmIHsOAH3tfVOJdhnE1lTOzKuVWZNLOoodJuRQtg5f5FyQzEQK2rkPFr09zcBXs=
X-Received: by 2002:ac8:5a0f:: with SMTP id n15mr2513244qta.313.1622113497672;
 Thu, 27 May 2021 04:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
 <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com> <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
In-Reply-To: <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 13:04:18 +0200
Message-ID: <CAFpoUr0PTYs+CSiWt3WOXnxq=wN3uEyC=h+_3kDc9wLoqaRC_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> 1st : ensure that cfs_rq->load_sum is not null if cfs_rq-> load_isn't too
> 2nd : call update_tg_load_avg() during child update so we will be sure
> to update tg_load_avg_contrib before removing the cfs from the list

Ahh, yeah, with "1st" that would work. Yeah, that was my initial
implementation of the change, but I thought that it was better to keep
the logic away from the "hot path". We can verify this in
update_tg_cfs_load(), and then force update_tg_load_avg() inside
__update_blocked_fair() when avg.load_avg is 0. (Given that this is
the only place where we can end up in this situation. I can update
this patch to do that instead.

Another solution is to update avg.load_avg
inside__update_blocked_fair() when load_sum is 0, and then propagate
that with update_tg_load_avg(). This removes the logic from the hot
path all together.

Not sure what the preferred way is. I have not found any other places
where this situation _should_ occur, but who knows..

Odin
