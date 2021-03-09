Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C443330BC
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 22:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCIVQx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 16:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhCIVQ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 16:16:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86BC06174A
        for <cgroups@vger.kernel.org>; Tue,  9 Mar 2021 13:16:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 18so29679562lff.6
        for <cgroups@vger.kernel.org>; Tue, 09 Mar 2021 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PsluCVuRlwvVpNmgjT1JznCkDbja9NK57IpaWk5p74=;
        b=s9lSAd8/iLOVzNXJ7+zZuVfjKgIHufi60spr/JHD99zdcQQdCEksF2j31Dx6t/wwuP
         1wrCwtpVz1KdKPmmrFOO1CKrycTKe56F/duuPJGBV/Vp2CC8N9rrrYTEgB/CHKP9zYCh
         vDo0AEVMlM/0FzE6O3FCardeV9kZo+0kCYcBsBywe4XgaB4L7ooh+MumK5xlMyFG1BrF
         HNMLfOtoqAx6uzYa3aJu6VMtoQZp8qmkXTSFA2y2bjngSrrUZw3gBANXnNbsrBBL1pb5
         MHEZbKMnKFF1HArMQmutIp1QsEC6mFU7A0Wo5hSkFpky5oPudWVAvLqxTmRLbZ2GwnAx
         e5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PsluCVuRlwvVpNmgjT1JznCkDbja9NK57IpaWk5p74=;
        b=gdPLFTAhiFenRCJIAbj06qvGC0UERThfFu5rbNiOybn9GjgHgHyDbqlQfmIEYQyWVf
         YD6NnfIrsdBLSoyM9r2ENH0aHiJPmmBOu10vDWG2M8ZUAAmd5gn8rrXCwQ2YXPncBL9K
         Ab52Dt+sg0YB4D0SOqRvZcD1xNHcZvZ2/5z/Zo5wk6n6uOMgUWBOeHG8Rf/9qve6J0M5
         n98KZd5BGJojqXN1W4mMXAOF0iItG9VFHp4uMQtpsdjx5u34QS7gNGenlGBPWA0jxdXr
         svsmqOEM3bFtGZQ2O2uCsZPx8U5iKkgVYNoaJtclJLaNGffRtt0RUZRzT24Xw6N7pN+G
         RZiQ==
X-Gm-Message-State: AOAM533hDJyH/F6HW6xEh6flmUMWPvqGYNAtVknROWWGd/dFd+0BdsB2
        9nv8FOXSVCFBbZ60VlOHl5ybqAWZpSa4bDE+dZ4b4A==
X-Google-Smtp-Source: ABdhPJwfdlXSlduZFjgFKGttJiSWF9iGYdLHN3WPCGkZM9CjZYvnf8hd9rHsiDNOZSL65l+JAzSlmNr/+Wa3/sB5CUk=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr18074769lfb.83.1615324585083;
 Tue, 09 Mar 2021 13:16:25 -0800 (PST)
MIME-Version: 1.0
References: <f105248d-bd21-8e6f-bdac-4f2c4792fc4b@virtuozzo.com>
In-Reply-To: <f105248d-bd21-8e6f-bdac-4f2c4792fc4b@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Mar 2021 13:16:13 -0800
Message-ID: <CALvZod5QnzwpKwGqCYDKMUpHgPcvtS99go+u34NYGKaWsr0UAA@mail.gmail.com>
Subject: Re: [PATCH 2/9] memcg: accounting for fib6_nodes cache
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
> Objects can be created from memcg-limited tasks
> but its misuse may lead to host OOM.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  net/ipv6/ip6_fib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index ef9d022..fa92ed1 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -2445,7 +2445,7 @@ int __init fib6_init(void)
>
>         fib6_node_kmem = kmem_cache_create("fib6_nodes",

Can you talk a bit more about the lifetime of the object created from
this kmem cache? Also who and what operation can trigger allocation?

Similarly can you add this information to the remaining patches of
your series as well?

>                                            sizeof(struct fib6_node),
> -                                          0, SLAB_HWCACHE_ALIGN,
> +                                          0, SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT,
>                                            NULL);
>         if (!fib6_node_kmem)
>                 goto out;
> --
> 1.8.3.1
>
