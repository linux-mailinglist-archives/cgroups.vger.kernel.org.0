Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B534D95E
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhC2VAD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhC2U7w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Mar 2021 16:59:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754CC061574
        for <cgroups@vger.kernel.org>; Mon, 29 Mar 2021 13:59:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b14so20480012lfv.8
        for <cgroups@vger.kernel.org>; Mon, 29 Mar 2021 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MofHa7TTek6RL65+2DpRLXuv6k37Riyeap6vLBZF2qY=;
        b=nQqoXFYpUc3Z1lEJ0V3ny2PJfnJV7IXvNf8Xadd4vjUpMOQKE0qrM446dKVDb9tLnO
         P4yimsDSrO+PpYO8NisjNVnaige/4fZW9IMZqFEaoCxIFJhJZM7vs/PyF8CMJbOACtdQ
         z67qd5sQJZ6ht9Yiy9J1UkYnmQeXuZLF1uHSEfzpUFCMZ0ZeCwT1i/DGXi0ZGr0xNgww
         doO0lFecfRDzw1Oox5ZhH/sUZWSuUbhZClFdl3quTAuqzLqEokqiNxoF2ZZsqoU52g7A
         30nkZsZkdOmUQmSn8B7BHiZSCdyBEFiXp1aeqCqv37lg+mtFcO0CpHBDTep3XtdxBpiW
         I8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MofHa7TTek6RL65+2DpRLXuv6k37Riyeap6vLBZF2qY=;
        b=MoG53J90WHO4nbB//CkgOCWJaN46SLoenaPsJuP9l3HHsGp+Z726EhAngPXE3ehN+1
         Jr1oqH3qdTQpH+bAnQL3iNRH84eTnnjo32s44861xRzdfsaHOTWdczse8LWz5OS8nhfJ
         6t9ezbVaN5cC+ZmRj5kxMqyUH52R4x1GY4JXlbmQBO2PO2vb05gNBv5PCHe55zMz3JUx
         ncBgOibBK4qfkbg8J3+h+CbJE/xd7otYcaj67UnCnmJe5JEBQ/RW+ZUh1gzN3eouOiXx
         UsZ7qu+HKHXhQxEtnDeEp8gUO5nJwaV6QAYTPsxPOG7zdEHAP2BHJKvystUgh4CkYNHz
         Pcqw==
X-Gm-Message-State: AOAM531MYtdfwC5SKfGScv90LqHI3kIvJMjfgP3ho70XwehwD77dbZqn
        n0e8MXxIHu1kjeOcS8aTdYQewJz4d6tnbLPh1Fws1Q==
X-Google-Smtp-Source: ABdhPJwWLV0TBmzUsdPOhowJNoC+X1UQiSou1bknXKSvsi1ROvKpcvpLXdoCMiRR7aQq1v+MNICbTORQdkB8fzAgh/k=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr17210910lfu.347.1617051590687;
 Mon, 29 Mar 2021 13:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210329144829.1834347-1-schatzberg.dan@gmail.com>
 <20210329144829.1834347-3-schatzberg.dan@gmail.com> <CAMZfGtVT85+1_Bu9LBaG6DUsr1kYsepQ-1-K7BDD0Wn3L+BQgg@mail.gmail.com>
In-Reply-To: <CAMZfGtVT85+1_Bu9LBaG6DUsr1kYsepQ-1-K7BDD0Wn3L+BQgg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Mar 2021 13:59:39 -0700
Message-ID: <CALvZod4TdgwWvBTRSYaXdBfYP=UZgVnDM_eK7o9PutOSgWdHXg@mail.gmail.com>
Subject: Re: [External] [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 29, 2021 at 9:13 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Mar 29, 2021 at 10:49 PM Dan Schatzberg
> <schatzberg.dan@gmail.com> wrote:
[...]
>
> Since remote memcg must hold a reference, we do not
> need to do something like get_active_memcg() does.
> Just use css_get to obtain a ref, it is simpler. Just
> Like below.
>
> +       if (unlikely(!mm)) {
> +               memcg = active_memcg();
> +               if (unlikely(memcg)) {
> +                       /* remote memcg must hold a ref. */
> +                       css_get(memcg);
> +                       return memcg;
> +               }
>

I second Muchun's suggestion.
