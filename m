Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA033D954
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhCPQZl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhCPQZc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 12:25:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E85C061756
        for <cgroups@vger.kernel.org>; Tue, 16 Mar 2021 09:25:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q25so63362919lfc.8
        for <cgroups@vger.kernel.org>; Tue, 16 Mar 2021 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=GqzIDfmCJYvYrFRGXeic57AzgBH3b1U4AAYEYp2J5pjfw4f/EnP9cLB/T6t1r6TAVg
         tMrVgaaocuUTM4D5JtLmSuQIu2yoT7UwXVom1It5Gr99hKftdLRf8bFHTTW90fpDcSxG
         LAklID4UlfQ5039uo09+40JkCw6EmElu4y5DRj8kxbylRlUp4Q2u5Vdg5DPlB9Pd0Bi2
         T4/d+1t2uvMESJRFgocJF9lvTDwHRjPJUtXR2rDn4rU3r5/Gp0EtxNgynOSacujSpjVU
         vmQw90Z074wG2SsY7t61SI+FYrKEojLMY+5Ts4h8dkCyGw/ZjTFaDaYPYDf/Dcb5Mjhn
         wp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=BpCnvea0Cq/dgCLFekSNj64wIaNP963YN6QJi/W+SkNgTTqJ/VmngOvCb4lDslYUQV
         R6qDl1Dg/EEw+aY+aMKQFWl02vmwYrj76j+wPDfxk6dicsyDqPDF9Fx7XTnJ/mrlwW80
         fdNwosZYvxCbaY1AlNzoS0B5Bt8oDO1YabV0gWnGQ/QJQOh2xKV1h5t3o52+xA60djpl
         O6rZkLCuVXvdLi5s4tagXYzuRwFRQmUh4CnFZcR2jxslapuiI13Ge06zuUXU7Fc7zy7R
         b3nWbnEWJGKIAfJtSwaWZ6YXA8LC5bI3TMeNxpEZRRuDJYjHDusWb9tYKzcUOWIa856T
         +9OQ==
X-Gm-Message-State: AOAM533GXSaJH0ky9jRGip+s54f9wLemD7VqdRQ6oXO3jBGRXRmeWcIx
        OY+3ZhBKAzgsf+uArU//2LU+ZH2KBpah6NhhlxKaqg==
X-Google-Smtp-Source: ABdhPJwQax98b9r+LloLeVzpURQWBJz/Z6VclirjaaFs0GEYtgmAXB7YpLkqvIrfK/L8srjer8T+p/MPbsW3QvkKVXk=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr11828246lfb.299.1615911930635;
 Tue, 16 Mar 2021 09:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <20210316153655.500806-4-schatzberg.dan@gmail.com>
In-Reply-To: <20210316153655.500806-4-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Mar 2021 09:25:18 -0700
Message-ID: <CALvZod7tDf3vvspJmS551GkiNbSdCH9VWNgWMesmUi2Q3NkgKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 16, 2021 at 8:37 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
[...]
>
>  /* Support for loadable transfer modules */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..fd5dd961d01f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1187,6 +1187,17 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> +{
> +       return NULL;
> +}

The above function has been removed.
