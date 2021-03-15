Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244C33C09F
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCOP5W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhCOP5E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:57:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B28C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:57:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r3so49477706lfc.13
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QW3CaHPgPmHox0WmReW9hgPm5r4PklZYtPsrifaA0GA=;
        b=GjZCh6DFUHNU5yqp7BNiRmI5nNX7N06Cc8wlYDtW8nKcoLEQzliJpSJ0DNTWm7s5UQ
         OzI2H8rAP9fv6MJpkYit3y/f0XFYxBLyIXnpKCebIFhfyktgK8dZPqGym6ea4aVDL6Kt
         DxtRQD1wI/o0Oomu+p7cLF4egVxRsePMBgwr9wBG84sD8Lhxumbb0mx0zn9qSiH/qsmX
         V2Zb7Jn3ycpIGJLBNPdmAJDPohqgDpY1STomDkQzSSaVarcjO9KKT/Ol98VlrRn3U5fE
         Y1eNX+Q6GCCFYj3qC4KWyfVnypYssQIpMgwsMMSyLLsTEdtpPQxZxp7QLTHARscwqB+x
         4lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW3CaHPgPmHox0WmReW9hgPm5r4PklZYtPsrifaA0GA=;
        b=FcocSVwPBPqejH2OkpAo1hsE0199US926IhN1vzWoVcSUe7eEjjwYlr7uZzzXycDVO
         Ry7tLJs5PUCa7cQ1NQet66yamLImvX+7q+SBY+yqdn8q2+a7lYMw19obB8YZYiw5gnGn
         /4kQaDaSBGYQUs1HHub2gKWpBA1RaV3ACrQ9VIfnd9SzKh4ShUfb43Db2ce9RZtdo1VL
         ZrynWbxk6TpvfN4o3t7gPyimhNxQS24YTywu9xp+rWikHHFjL2PCTDyKWp3qZyN792UV
         jpCpNo8Tzs1zydLRrgBjkaxvWdodnYflSYOgfJ4/kOrwqYtGO6RhO0nv8vcrwaOcQRQ6
         LGag==
X-Gm-Message-State: AOAM5314/60Ew1zAK9AZiIasGVlh5gmVzYGd1kzk0p+VlyjtzymCAUH+
        khQNSXyDGxI1nRjMdT3dFauDrTnNgT3PU32mBYmclA==
X-Google-Smtp-Source: ABdhPJy0jNIfa3zLOBc0wUD7xD0zn5VCZOlhbzQrXApUIgPNIRQDwI4XWU1HTffe3ikaoAArI+GDjuW2XtpF+EarLPs=
X-Received: by 2002:a19:c14a:: with SMTP id r71mr8196489lff.358.1615823821848;
 Mon, 15 Mar 2021 08:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <YEnWUrYOArju66ym@dhcp22.suse.cz> <4eb97c88-b87c-6f6e-3960-b1a61b46d380@virtuozzo.com>
In-Reply-To: <4eb97c88-b87c-6f6e-3960-b1a61b46d380@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 08:56:50 -0700
Message-ID: <CALvZod5GXkxUQyxzD-eL4QUhnoayVGTrBQPUC1iv+0LGnYJFzg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] memcg: accounting for fasync_cache
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 5:23 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> unprivileged user inside memcg-limited container can trigger
> creation of huge number of non-accounted fasync_struct objects

You need to make each patch of this series self-contained by including
the motivation behind the series (just one or two sentences). For
example, for this patch include what's the potential impact of these
huge numbers of unaccounted fasync_struct objects?

> ---
>  fs/fcntl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index dfc72f1..7941559 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1049,7 +1049,8 @@ static int __init fcntl_init(void)
>                         __FMODE_EXEC | __FMODE_NONOTIFY));
>
>         fasync_cache = kmem_cache_create("fasync_cache",
> -               sizeof(struct fasync_struct), 0, SLAB_PANIC, NULL);
> +                                        sizeof(struct fasync_struct), 0,
> +                                        SLAB_PANIC | SLAB_ACCOUNT, NULL);
>         return 0;
>  }
>
> --
> 1.8.3.1
>
