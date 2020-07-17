Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF122459D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgGQVKJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 17:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQVKI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 17:10:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E729C0619D2;
        Fri, 17 Jul 2020 14:10:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id o3so8461359ilo.12;
        Fri, 17 Jul 2020 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGY2CcpG+3E/GgTnkS2Rd95XUJ3WTaSOrzDRZRkdebk=;
        b=sa1P3Kzy43hPp0azgBtrJI/pXdQyGU3ArG3VZQHof1cfxQQmHBeQQeVpshGq1qtzkK
         aBAQjNpjtj+EQMABp9exhFc8AUo0p2LhtVAG65w6G/tR2S5UGmVPeiKh+hajO6FDYAph
         U1KQA79kGahWeX4cDR3pNJ/b356kPljLVsr4WYt2pln96RFlzDzlY4wpXiUS3jg2Zx6j
         euuEe2heXStT+jZ8yGg5cLKlfGRrr5ecRH+A8kGeECQtWSPILkiLRM1rC0B8cs5TgewF
         zXwoYOXXzQZZf7DGH+xXYwv6Qwo8fh1NzT2bXAGvmyPwVpiw4RyiMBA4s/aKlvy9Mq8P
         COPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGY2CcpG+3E/GgTnkS2Rd95XUJ3WTaSOrzDRZRkdebk=;
        b=M1N21JMEhDGPIqS2qedM62GPTiq8ohAmmwaQvi+41tmzAdlRF2HR5zq9gRR02hzaOY
         DAdHdOn13g4/et3BmVtzQCoCt8fiefrh4cPTMyGci0GrvRg3WCpJxPOx2RHyit7yhdpL
         TBEL9A82xbg3ks7+LAgJhsxq909VCWUK0qWsI4NvCFa3IR103acfHAtQIsnBd9meuV5k
         8WjPhXSRdudV7jDdKC+KVPLXQUNL7ZjxoPekwAX0Ds23UenvL9HRXDwMfy4n/ttv5cRa
         UJ3N25+QZWAabyoFrWZrnqhuOP7YsK4BVzLNnVHgH1iBIqdatQVmNnIoR3xER5bO8OBK
         gpQQ==
X-Gm-Message-State: AOAM532CXecKfz2YfDlhYG6aRPbhWrVu781dY1YF17JPnV7kU7oUxUbw
        Um9N1ZF2Ht1k6zmouWjha5fL3Wt8sIQmwSAXkEc=
X-Google-Smtp-Source: ABdhPJwMgmu3v6Y8FqgTCE4q1t8jHKumfJGC2BOx4YeplWn/vvCzUrve4oyAXW93ROhPUsAkbjKAEtA++hD6PZvR+Co=
X-Received: by 2002:a92:5a05:: with SMTP id o5mr11762146ilb.237.1595020207855;
 Fri, 17 Jul 2020 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <1594429136-20002-22-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1594429136-20002-22-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 17 Jul 2020 14:09:56 -0700
Message-ID: <CAKgT0UeK3c4NjoJ7MQMxU20Bu0AZKZh73Cj4P_g5OSL6KaONhQ@mail.gmail.com>
Subject: Re: [PATCH v16 21/22] mm/pgdat: remove pgdat lru_lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> ---
>  include/linux/mmzone.h | 1 -
>  mm/page_alloc.c        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 36c1680efd90..8d7318ce5f62 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -735,7 +735,6 @@ struct deferred_split {
>
>         /* Write-intensive fields used by page reclaim */
>         ZONE_PADDING(_pad1_)
> -       spinlock_t              lru_lock;
>
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>         /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e028b87ce294..4d7df42b32d6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6721,7 +6721,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>         init_waitqueue_head(&pgdat->pfmemalloc_wait);
>
>         pgdat_page_ext_init(pgdat);
> -       spin_lock_init(&pgdat->lru_lock);
>         lruvec_init(&pgdat->__lruvec);
>  }
>

This patch would probably make more sense as part of patch 18 since
you removed all of the users of this field there.
