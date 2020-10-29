Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FF29F071
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgJ2Ps7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgJ2Ps6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 11:48:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61420C0613D2
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 08:48:58 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l28so3894225lfp.10
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6hFvPTvw/59UWHjYIOWZNWhefGQ9eQg3cKC2KPGwCM=;
        b=stI5fekXpQhrvKoARPS6AF6qpqpjEK9uc1LX1KLKNec1z0x6yaI9ATroJZ6+pRrtiJ
         FvADZnyT/zRZVVgZVWol+0ltxgd6Y5ix42oFmmPz1B4V3VaTnokEqQhsTYWVICBUWIku
         9Fk5j0+BjuxdxZRChwMI39Yk9ngWlL3BcekHDWpvHzItzJBoi6KSCSEv6qaof6slywA6
         Z9ycEF1H96wb+5jRFrczxm3/mBE78YGj9HFBmUeyT77Ei7G5GWeT7iG/OlQqsUaiNa81
         mZ/65I1f9jDxJXkblfK/CmELlWosZmafXB34IDtR+1D72hSzwMd7skKYuGU3X9dTZ3t0
         F1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6hFvPTvw/59UWHjYIOWZNWhefGQ9eQg3cKC2KPGwCM=;
        b=LvfbrFooEwVFrWWvsqwvja9qzIy15+l57Cy242s6emB79L693bS3fNTJafDYXEqXDm
         E4Fbs0Qzv96gU8MVXOpdtLjZZVQ/cQTq5tHgVomZPSiyxl55ITC4npDa2+S9wXcM76kG
         4EmlwdjLcNfgJ/imE7kuO1RXASvA65ZgJ6zUaVaTQCiVrHDnKLUASxcgufxVsfgd8Kbd
         Ls70ZU8e7qc8icWRYApW1lQgIN6sdxVkSBa5Wh4Y5EZmVuX65+mCd1FJM5H+fVhr6ciI
         JQrjQEqpDd3DsCxxrtncnmVzfZnKWy0CB1UGjV7aVzobqRp4v9GYsiwooB/yjDN/A15b
         ZZbw==
X-Gm-Message-State: AOAM5306WPfAQsOVUyjVF9dLqwAgcf72rE0PeRg6G9efNgY9/GzNUoJh
        gRXsd3C/Ei9xGKgwbQh/TIWH10Hlvn/W8cIFMc3Paw==
X-Google-Smtp-Source: ABdhPJxTeNSGR9ZhUcP7bCxdClKAWwUmdsXRiTkBvntA3ByspyxCe98ZHStsm58VJLsmgWs1OAlSIfc2hUNNsH6YU7A=
X-Received: by 2002:a19:2355:: with SMTP id j82mr1723817lfj.385.1603986536474;
 Thu, 29 Oct 2020 08:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 08:48:45 -0700
Message-ID: <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Consider the following memcg hierarchy.
>
>                     root
>                    /    \
>                   A      B
>
> If we get the objcg of memcg A failed,

Please fix the above statement.

> the get_obj_cgroup_from_current
> can return the wrong objcg for the root memcg.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  changelog in v2:
>  1. Do not use a comparison with the root_mem_cgroup
>
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1337775b04f3..8c8b4c3ed5a0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>                 objcg = rcu_dereference(memcg->objcg);
>                 if (objcg && obj_cgroup_tryget(objcg))
>                         break;
> +               objcg = NULL;

Roman, in your cleanup, are you planning to have objcg for root memcg as well?

>         }
>         rcu_read_unlock();
>
> --
> 2.20.1
>
