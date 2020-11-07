Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35EA2AA3DC
	for <lists+cgroups@lfdr.de>; Sat,  7 Nov 2020 09:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgKGI3A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Nov 2020 03:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgKGI27 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Nov 2020 03:28:59 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EEC0613CF
        for <cgroups@vger.kernel.org>; Sat,  7 Nov 2020 00:28:59 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id v16so1172171uat.9
        for <cgroups@vger.kernel.org>; Sat, 07 Nov 2020 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Vd93WrgVvvPOFnm9XWhutuIS0jTqt2s/2KmuTAC+LQ=;
        b=A+VYWsiKxRJhotjCN437Jq9UVFfSxHy1z8zL4GFSmFJkbyG4P9QCLVXLXa/q7YXPGg
         pln9mI3nJ4oWPbMTR2Sd+hTcybayJu3ipyZ5hrtbjHfKzE8Ki3FqWnEmeFeV717fy4Ii
         Nc5Gg9vY5gIWDQZtBjLr46tbdu+ssiG3+CWnZxZWLHJxyHpU6PwTnD2ELwjLNBBUyjHj
         wlB16etOYEhoertjV9HJwhsIHLUeL8e1frqowc2JFdVlX39PvMLN7IYa+g3yhCGK9Ip6
         7psSMg3QkyzsGk0Mtl9sfRt33+/zWUVMroh/K53lz+DTh/EYxXP4MrM/PKfzLvnAuz2v
         Ic8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Vd93WrgVvvPOFnm9XWhutuIS0jTqt2s/2KmuTAC+LQ=;
        b=P7S1cw87xXCsQH7Rx9QPqzJNOrCWr+0imexfXPl0/nXWOb1KBUEEVXgf/ILa+wvJyw
         JGXI6qRFfD1WndLKPoDQ6bT2UMF8mDz/41tzIVHde+3HYGF/dGzngdgIoMBI2+0sWS6O
         Yidenw2kPjkKpzQhxcpoxrG4wbwWWEmoW3LVfop51sGqfJzFTWL40DDdUjIeTZn4TASk
         S/ew4TylksHM95fmCGk0BqnrERSTUga8X1o39pFUNRKsYNH1gFP7BnuyzaOyov7Tj1pu
         RU0FCQlyvBIwYnYgh3+EIex3DPCKUSHRwp7x2S+RQN8qk5FRVmifT2qGeNJEXgvFFykL
         guwQ==
X-Gm-Message-State: AOAM532Lh49uDnDgF+KMZn+l6QsI43j7YlwQaXFEKZp+Gng4j1c8TMuu
        bdQELntkGh1QF7WGbv0iLY5s2cqP3YrYLk1U+CDUK1mt5BM=
X-Google-Smtp-Source: ABdhPJzn8++rcz5VCx9VgSy+XShiJSgKKj9OSQlke9zVteeARYeo0EiCPVj3mpI6SQeOvVB/vF7U45tUU3KBAH6hf4Q=
X-Received: by 2002:ab0:2986:: with SMTP id u6mr3077204uap.118.1604737738865;
 Sat, 07 Nov 2020 00:28:58 -0800 (PST)
MIME-Version: 1.0
References: <1604737495-6418-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1604737495-6418-1-git-send-email-kaixuxia@tencent.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 7 Nov 2020 13:58:47 +0530
Message-ID: <CAFqt6zZXEiS7dY+Y2OPXQ=DX=9gXMGpXGrvKCMrSq5qRwpvu5g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: Assign boolean values to a bool variable
To:     xiakaixu1987@gmail.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 7, 2020 at 1:55 PM <xiakaixu1987@gmail.com> wrote:
>
> From: Kaixu Xia <kaixuxia@tencent.com>
>
> Fix the following coccinelle warnings:
>
> ./mm/memcontrol.c:7341:2-22: WARNING: Assignment of 0/1 to bool variable
> ./mm/memcontrol.c:7343:2-22: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3dcbf24d2227..60147cf9f0c0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7349,9 +7349,9 @@ bool mem_cgroup_swap_full(struct page *page)
>  static int __init setup_swap_account(char *s)
>  {
>         if (!strcmp(s, "1"))
> -               cgroup_memory_noswap = 0;
> +               cgroup_memory_noswap = false;
>         else if (!strcmp(s, "0"))
> -               cgroup_memory_noswap = 1;
> +               cgroup_memory_noswap = true;
>         return 1;
>  }
>  __setup("swapaccount=", setup_swap_account);
> --
> 2.20.0
>
>
