Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353261D128A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgEMMW2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgEMMW1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 08:22:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86013C061A0C
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 05:22:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so13435726lfb.8
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4WVF9KPrx80M2FEl5rcn7EVSYU4t2bvsS4X5mKVR70=;
        b=TibQPMRLGxR/UEGYf/uFO/xAeZsv+91v7ZJOOVnjVs2cosCRf8uOioq3qh0ur1V4La
         1fK6QMjhpmQdwIPDMsCDRH5WV3DO2lKFnntzgNopufNe8gCTrVOioUHqzfGsxJS8MG3V
         Tvee5Ni+saMMCCjEu7sMr/N/e5OA3iCLTq/k63XGROTwmFwu960Je6JaAhw8883Zu4Qb
         hBgX9CJgSd4aYUcNKVCOVzqCY8zMGIgu4UXWrjxkt8h3/JcAUKUn2oy0wN+TdIVC27qE
         PMDDLVSKbdD/uEKND56/OKBgrawT/iLgTJNg7md7s4/aAbpEbNJ1wFNa/PQop3myu8AE
         SLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4WVF9KPrx80M2FEl5rcn7EVSYU4t2bvsS4X5mKVR70=;
        b=nhBmGWopWO4mMAlWtOe49L3JHDiSsWb/6D5zE0kmHuhexlGXGZD14xiw+2inR5e93g
         QJzUN7Jm0YQCDW0L0HV9DO9r7i0b4JRNAUMiHts5zMe99+sWpnAEyjnn0upGTBjueRVQ
         nNIQbb659mWzPnUjX26gptKdQNFukpv4b1S012XYggnPKuSaE3Qpl5qDK7Vp9Beqdb02
         bZlZp+bVLZ8/w2mGfDfU+V8yDC0114o2SFJrfE9p642KX+cA9tGi7FTR/F7FletPGtmj
         vVXKMgx/KhhG+5MtzRqBClDZwcTO/4mJMBc3B4ONUJOcG440JOXjuwTY30rprjUwLB7b
         CkiQ==
X-Gm-Message-State: AOAM531eiN7AzaCPkzyDtAxsiOOlFqeXvnzxTtB1aJDB7eQYjfYYiqGV
        TqQgtnalHZ8fNaEkU7IIh98jrQ/Vr8G6l2gM1I0unTersRs=
X-Google-Smtp-Source: ABdhPJy2ka/pkrFkL93LaByhoRWRPSE1z7iHrsV9R7Lct77U+aDdMzdiRdZ/p2NMNrUgSo3fqQvz2UaWNXUQhHFx6DA=
X-Received: by 2002:a19:f512:: with SMTP id j18mr17455652lfb.33.1589372545582;
 Wed, 13 May 2020 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz> <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz> <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
In-Reply-To: <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 May 2020 05:22:13 -0700
Message-ID: <CALvZod5EzSAdFJh-wjN9TfdUwsjL5Zfn6xao5S9nWvhiL+oL+w@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Zefan Li <lizefan@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 13, 2020 at 4:47 AM Zefan Li <lizefan@huawei.com> wrote:
>
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
>
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, it's better we fix it now.
>
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> ---
>
> v2: add a comment as sugguested by Michal. and add changelog to explain why
> upstream kernel needs this fix.
>
> ---
>
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3b97f1..43a12ed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>
>  static inline bool memcg_kmem_bypass(void)
>  {
> +       /* Allow remote memcg charging in kthread contexts. */
> +       if (unlikely(current->active_memcg))
> +               return false;

What about __GFP_ACCOUNT allocations in the interrupt context?

e.g.

memalloc_use_memcg(memcg);
--->interrupt
--->alloc_page(GFP_KERNEL_ACCOUNT) in interrupt context.
alloc_page(GFP_KERNEL_ACCOUNT);
memalloc_unuse_memcg();


>         if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>                 return true;
>         return false;
> --
> 2.7.4
>
