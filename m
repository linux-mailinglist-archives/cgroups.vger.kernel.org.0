Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5422B36B6B2
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhDZQYZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhDZQYV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 12:24:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44151C061756
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 09:23:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so89300899lfa.3
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPEBwOmjBEydXEY6alqbD5j0u/fm5bOySKZNXJROtWY=;
        b=CBzfFfpbQdGiZGklxymOeIysY8Y6hqvvafywuFnyZm6XCRiozmcpptpmxATr6B3N0Y
         2vwiwSapsbNuusSQtu58mBVhgW2QufIP9TM7J5pSkb6mERUc7qS7rFqBzMSa7TMMT0Ou
         bvy/yy4qDXOWefutGUTPkcbmAWaGWd2I7Bf8VRdRNzYB5RiXDnllKR8T6O/snx2YxBgz
         gOjFmCC5Oowjjx0oMclL3mq4z8LkEUcHSNaDxKmuBjoBgGa9Rie1o9m6vWmlh38T/4uB
         31FPfSi2QMEmYeOxCHwkimIbpn2jrkbI2cLUrJbzyKLI91rhSgM28PmMv2Zd9zVHP2C6
         Fjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPEBwOmjBEydXEY6alqbD5j0u/fm5bOySKZNXJROtWY=;
        b=a2gucc5hQGejsMJ3rDTN0jJmInm+/xKJzJ7EnytxpRjYEUjD8oezx1aCx76tJMnIY8
         5CQWEvy2naGLLr2en/hOR2ayogMwt3HBa1JegDN8jFPVD3AYy9aClXV4+7h/G0QH16sE
         WNqRaQJHn0kBza47SMaFiFaFUZnvXZKoG3OJbF9FLyRBzfArW/OY/DXpS5xFHMB1iJKB
         ZxzO9S1rp6EIwcYarpIc5W7WcEzbhDRwI5WPMVV6WxBcPZswZwDRKXe4ULO4C/CX4eT2
         fNOj6Dis/0HJPhlYtph2BiZSeJtI4njp9tNrcH2PRarrr7UM2nVb4AKL21Jp2XSBi0+N
         3k7w==
X-Gm-Message-State: AOAM533rii1fve2GWQOPNa2aNtYbeizXSrrYxe5OFei9Zjd8HgXLe/Nd
        YGlf8lq7qkXumR1D83aOAKxt9yYJsRiOW7BcN2ni8A==
X-Google-Smtp-Source: ABdhPJya8xVyd676M4Jx0SWibFM2/Ks3Pfe0GPzY45vMpHIL+53rwKQh/+GUF4kYAN02VM48ON7tewsrQwEmnqzP/pA=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr735854lfy.117.1619454217468;
 Mon, 26 Apr 2021 09:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com> <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
In-Reply-To: <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Apr 2021 09:23:26 -0700
Message-ID: <CALvZod4oW1jPJtR938zSAMBaeKdJ82NAa1Ht858XLrmWWSiCTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipc: use kmalloc for msg_queue and shmid_kernel
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 3:18 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> msg_queue and shmid_kernel are quite small objects, no need to use
> kvmalloc for them.
> Previously these objects was allocated via ipc_alloc/ipc_rcu_alloc(),
> common function for several ipc objects. It had kvmalloc call inside().
> Later, this function went away and was finally replaced by direct
> kvmalloc call, and now we can use more suitable kmalloc/kfree for them.
>
> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
