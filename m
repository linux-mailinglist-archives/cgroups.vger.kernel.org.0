Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD33C2748
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGIQIX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGIQIW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 12:08:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D770C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 09:05:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x25so11449246lfu.13
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m82zfd87YF9+QrBUW0hwMZ+ldgr97m1MRGrpxVJ55ig=;
        b=H5fHo8SPL71odXGzixPW0kCw6NiwaVT7YekDy7mWtP12kM6qvdkO0rJHFh9Xzg2X+o
         wqTB190SjORxzPvu03czb/qvq+FR044vOHsTqZaX9FiFyaVTMSgBNPOGSlA/y8rfObys
         R2HYTiOrK6UO9LVmWTkQfjUfWoO1MkA6NPH008Z7zZDst5wFZSzGua/8Mq+vra8Qe8aC
         J1MhWoTcHKGt0IkMmUS5wZ2Zs1p4NKQ3ngltBMY/xQQGjSqKyl9zhI7nVPOU/KxpJc85
         ciTN8Du8hEzPC5pmqUNYCC7T1IRgQfuSN6D3zEhMzil1V4u5QvmSQo8UAoz7K+wKl4jg
         d02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m82zfd87YF9+QrBUW0hwMZ+ldgr97m1MRGrpxVJ55ig=;
        b=b9DyupBCe/B1qdWnm/d5fep11N1QIsSFwJTDGQUHZ7xe7HH49k3DopRHNT7cxs+pkI
         SCDBSJmlhYylofdb1XlaybVD6zfQX2eaf7c64O3zd9pEvVkHtIe22kuG2qWIh/cAbgaI
         t7T5K0fX4guvpOOGxSVXXhobVq+F1UK1exVi+eUVbZ0YOoYH6cOnoYbQR0ribZE0WgXO
         duWfZUqf+NyBKoyRsZ/rbguprjR4UulcAO5RSxh+7gLNgHElo2d94DGmal7x6NZfDTul
         W97jJMHFIU9gqNc87SG9pbsMaOoBn/HWyBxHm9joixGJOFWt5uoQZlToVn/uC/ejCYvD
         /ieA==
X-Gm-Message-State: AOAM533U8etfv/H+qKDbo/q1+4AMlfJM2Q/0A+10hyqv8/G6aROFqslD
        4xFL4Gi0LUZho7AHkoW63W7HZVI6PBeM6BekdLH7Vg==
X-Google-Smtp-Source: ABdhPJxnyX6S5tO2WlFgPLsi+dNAp9f8ZYhuS54Td/FdvGB8rNsN/P9JGyEFXWL5ODPoy7CSxjdg935moUJOQKUs1+Q=
X-Received: by 2002:a19:7418:: with SMTP id v24mr29655054lfe.117.1625846735856;
 Fri, 09 Jul 2021 09:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com> <20210709000509.2618345-4-surenb@google.com>
In-Reply-To: <20210709000509.2618345-4-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Jul 2021 09:05:24 -0700
Message-ID: <CALvZod4bpiA-AB_5xLwcicEhRRQmk20b8dEmY_BiDjiGfFR0Nw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, memcg: inline swap-related functions to improve
 disabled memcg config
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 8, 2021 at 5:05 PM Suren Baghdasaryan <surenb@google.com> wrote:
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

Reviewed-by: Shakeel Butt <shakeelb@google.com>
