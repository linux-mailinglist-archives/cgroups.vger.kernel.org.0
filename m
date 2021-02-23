Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE7322D56
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 16:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhBWPUL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 10:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhBWPT5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 10:19:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E8C061793
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:18:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c17so63548214ljn.0
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQTPFz0KpYE2dWkk3abN3T0OszgB57hAvGOE8ZYtgAA=;
        b=o+//MZFFfHtdHG0DGPb2hEKrGlrSgOgpcvlv8EkAotugJY4tPbXDcnXMc/VzRl1B3v
         8Se2eEU44z6Q2HXZys/VPsHf2iTTAXagOhaMxbzKf/kYTJgl/71uLPYbBHMQVhMIiqf6
         lXh+kxA8+09dEncWcHnEJKWScOXu2/9+AcCwK4jrjBqPzowQtoohRQyVHx7jfl3vv4Fs
         Fijdk/U3Vezsc6EkpisJM7UVqdp7xiKs5x6ThOTcy4dnDSq/zFQA67Frm2NFaB8YAD1Q
         Mclf3NnaduBtsQcwblXZrVEVZ3XJAYcht0XC3zb/ADdnOxPytBSC2EUz+zidmXWF86UY
         bhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQTPFz0KpYE2dWkk3abN3T0OszgB57hAvGOE8ZYtgAA=;
        b=kR9ezAIsjsK5J63BhrCZT/8x7DmFDqb1AtoPjmoS1Hnus+JhpOkQPR1Kkuwtyq86aJ
         FuLgjJUxKnHxrUWz+se9gsHGSeOyHcd0h+jaziO2L+wkY+EMZ1dJ+b1svgSDNe80cS81
         BYK8gqyN+k2js9ZZs31NvzUa3a12HHlfRwnmqSzVGfgyK7GOHORuSzyGEx3fK9F2Z2aO
         BpuSNhuPMNixYSRj86siWr4Kh1fJYgOXewiahuhq/+kYChwas/Y6V1rS3vNHQ7oSpRWm
         aytovLwWUdss/KMfrlvdCcxhuE7c49goSq5lEz4LtnRCqii8+PJtFllp9zvgT2aG44ff
         WQtg==
X-Gm-Message-State: AOAM5327xRPyOIAd7dt9CBVCafYt9saBxi1qWZVsyXFLO0Dy6DWjanmu
        yPkPyrv/KP3JiEd7z8y+H7sQrMjlk8tRK0YrQtO+gg==
X-Google-Smtp-Source: ABdhPJytWIbvd5HdX9yo4bjjPo/hvJHu1yFtuH+7/DLHUFKLmC0yaai2hO26aAUsmhtGLUPJJv5KQJLr6A7968Nlm1M=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr15091026ljb.81.1614093537053;
 Tue, 23 Feb 2021 07:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20210223091101.42150-1-songmuchun@bytedance.com>
In-Reply-To: <20210223091101.42150-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Feb 2021 07:18:46 -0800
Message-ID: <CALvZod6=TYHPC3g3RzX84KeR8p74RH5PdbT+aNy+m5n2Yboskw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix get_active_memcg return value
To:     Muchun Song <songmuchun@bytedance.com>, stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 23, 2021 at 1:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We use a global percpu int_active_memcg variable to store the remote
> memcg when we are in the interrupt context. But get_active_memcg always
> return the current->active_memcg or root_mem_cgroup. The remote memcg
> (set in the interrupt context) is ignored. This is not what we want.
> So fix it.
>
> Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch.
Cc: stable@vger.kernel.org

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/memcontrol.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be6bc5044150..bbe25655f7eb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1061,13 +1061,9 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
>
>         rcu_read_lock();
>         memcg = active_memcg();
> -       if (memcg) {
> -               /* current->active_memcg must hold a ref. */
> -               if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -                       memcg = root_mem_cgroup;
> -               else
> -                       memcg = current->active_memcg;
> -       }
> +       /* remote memcg must hold a ref. */
> +       if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
> +               memcg = root_mem_cgroup;
>         rcu_read_unlock();
>
>         return memcg;
> --
> 2.11.0
>
