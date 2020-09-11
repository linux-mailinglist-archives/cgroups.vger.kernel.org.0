Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F542662AD
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIKP4t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIKPzu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 11:55:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B687C0613ED
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 08:55:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x69so6361855lff.3
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8h3iMEyFX6QewzjKstBqsXqbnz4eLSjULf7zqd77Io=;
        b=K5fRpESJbY0J2ZllnGRok9NGNm70giUMtrP8Frc6f8UWBaz4M8hpQ/5a2wWgh8XyzZ
         6rLN/sG5qBPy+9e03ECdD4AzRCmP9RaPn1m1/OsHh/hsH7AgbzvhgV1S2hZcBASCM/le
         CpwlEYVGVmnzFVsTdBULF39HA/kbL1x8w7NNyHi0kGf+XJx6MW5Jm04vrvFqqMUxCemV
         hFyNb8QBWvIKmfyFkNeKLNNuyot42p+XGAoJnXVd44yKZ2Ku2NIJa7Ai6NYhLY4SMCde
         4uaBKTDBABwPBRJ0n0BcZQa/xeDeqhxEWyZmhtGKA6pmxus2DRUtIIZRVqetwgndH0fV
         eOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8h3iMEyFX6QewzjKstBqsXqbnz4eLSjULf7zqd77Io=;
        b=oqSJpTFlxwTGu1bHi0lLqI8xFy1QJ0NV+lZRMQ6qOtFbygREId/qZSUzPG/IOu/R2l
         CB71quTnXz0MMBsY5LQ+9LO8i2pSJoalpnTQWM/MOxP3WSGbFZQXWcLUO9XRByq2OKy/
         GaEN59Eb3qgM2LbjWCUX0DES2MQHqmthQ3JbqJqI6qmIUt1sFFJdmSLDzdyqro5gz7PE
         Nc0qD+PRS9tMfyk8xlAYuZ1tf+paHco+gZVP1Afrpvo1rGXGX5/zB1aZrd4XvJvwOICp
         lurRifDE0Fv+G5i1FirXuRsS3Cllt1HsxUOODR2njYBfgC7lY8tdcyGNOjp9l7O+hkPW
         7x1A==
X-Gm-Message-State: AOAM532nyGkMMNDcUEGFKxGK/8bjuruUqM/QVAlek2LY6la4qYYQp5+c
        LMEfdJC1zIf1Rcc6cHJH4trl+WrCUPsqJykc7lL7awOW5t8=
X-Google-Smtp-Source: ABdhPJyclL4RnPGvosl5BRR+2mfGotvjWG9Mhr6L3INTzBqTvtjxRCbnlpPGfo6VVDf8sgmAC5lLL5d1173/oMO2qek=
X-Received: by 2002:a19:2346:: with SMTP id j67mr453183lfj.449.1599839745555;
 Fri, 11 Sep 2020 08:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084258.22293-1-songmuchun@bytedance.com>
 <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
 <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
 <CALvZod5_1nGJ2-QfSnYm4rCB+qvMEKAuVJrCeCyv_vQs7EoYfw@mail.gmail.com> <CAMZfGtX7UF7VSNbcutibLu7ZO-cn6jFYHURHG9ycEmkmnjB08Q@mail.gmail.com>
In-Reply-To: <CAMZfGtX7UF7VSNbcutibLu7ZO-cn6jFYHURHG9ycEmkmnjB08Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 08:55:34 -0700
Message-ID: <CALvZod75aWLSFK5DnbbL+aX5bT=w_BgU_wWACqP2KONHbp0_3g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Add the missing numa stat
 of anon and file for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 11, 2020 at 8:48 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
[snip]
>
> I got it, thanks. Because the "state" interface exposes the anon and
> file information. So I think that we also should expose the anon and
> file for "numa_stat" per node instead of the lru statistics. Maybe it is
> better that we expose both of all the information.
>

Sure, go ahead and please do update the doc file as well in the next version.
