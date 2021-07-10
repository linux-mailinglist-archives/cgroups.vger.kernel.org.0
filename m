Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C473C3450
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhGJLWX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Jul 2021 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGJLWX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Jul 2021 07:22:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB6C0613DD
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 04:19:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q10so11245562pfj.12
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Fxzax5cpRXuDAgNVxBd/5Ht8jrK3NBiBX9Z3Z3en2A=;
        b=Nd2YCVkKoDLy3hEtStCKbIcb6+F7OwCpW5WNUXe41pujO9UWnItUfazYVV0AUIWnx0
         V5Qqf8UukAsVyB2gF/oVZghm6cWIM7/NTpp6BdhzmerA1z1YSmFRUoACKPA01k6wkc8K
         ZzDsu5CNXZIfn5YNrREUIcuet1/Eh3NMpstMmVR/vb5ckoeb0n91CRhjIZRUNl82jK8o
         z8fXtNc4rn/I2DI5plmBilqgX7EOxK5exQQw/Qyw7jNkKHwRVwm/AzTC54Gq1FHjYihW
         QJ7SE5HzfbbFCdjB44ohBfXhQAyPRakHcorVvbATqCZvWebbY3zOPwgqS8GJQHOzePx7
         7YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Fxzax5cpRXuDAgNVxBd/5Ht8jrK3NBiBX9Z3Z3en2A=;
        b=Q3pwyIAS7o3luI3Wv7jib3pgNPPygTXcPfRcCFHIwcEAguXEGVDYL3tlgycvkLe5gj
         C2C2A+C3GRRO9CFWGxZIkiEDKVRy0vk2xRYBkMoL9ZFZ2fkPoU26EwXHeIEIbyIz/Zm+
         FUhWclhbIHdM3lLCnD6+6ggk3vhwT85pcLJEtHHAUKrCAMGjAzXXsQ+pHDFsETB1kU3y
         SELdlNwj5UC7Ju9o1vDXOWH9KFGjKRdecPr9yyINhM7vD17SvW+nQ6eTwEHZ2yIPf2Bd
         +OcssDJsGtD7sVOQ8JdvXw4NOsJJmvtSShsnUSAjhE+S3NqjZK/5noKy9KmOBcgWgUmN
         mASw==
X-Gm-Message-State: AOAM531U0YydhAbOePVDM1Y+uneJd8/grWAJoFuGyVMtuVfRO+n5xi2z
        ZtDh3N+K/jRC395pV8oGh/KpGE8bCNKVIlCZIMdCjg==
X-Google-Smtp-Source: ABdhPJxBKM/bMTrpxWLVfJMl8Ma7Ym0dkHhsHvo5jn8cO7rhfOTIBhgL4kuypJe0wyhc8mEHOfV5RaTljowAneyuwHI=
X-Received: by 2002:a05:6a00:23c7:b029:323:3d55:68c0 with SMTP id
 g7-20020a056a0023c7b02903233d5568c0mr26127249pfc.2.1625915977569; Sat, 10 Jul
 2021 04:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-3-surenb@google.com>
In-Reply-To: <20210710003626.3549282-3-surenb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 10 Jul 2021 19:19:01 +0800
Message-ID: <CAMZfGtWCHm4is0Z16tc1WQN+jwJc6PNqyasNxVMRp_dQsFjrkg@mail.gmail.com>
Subject: Re: [External] [PATCH v3 3/3] mm, memcg: inline swap-related
 functions to improve disabled memcg config
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 10, 2021 at 8:36 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
> key check inline before calling the main body of the function. This
> minimizes the memcg overhead in the pagefault and exit_mmap paths when
> memcgs are disabled using cgroup_disable=memory command-line option.
> This change results in ~1% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configuration on an 8-core ARM64 Android device.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
