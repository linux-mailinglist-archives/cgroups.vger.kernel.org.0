Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE93C343E
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhGJK5m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Jul 2021 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhGJK5m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Jul 2021 06:57:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA36C0613DD
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 03:54:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m83so3574225pfd.0
        for <cgroups@vger.kernel.org>; Sat, 10 Jul 2021 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s5ME4E9PBHhxefrSgaXyV85rhPOWx7hl7SzszoI7Lk=;
        b=0pfcb1vI948P1gvNDslUqtWbRUsXRvKRNuV9F3pPgrHR2s3UsDCIghddiHvbvrXVxV
         5llF4dEfFB8WySwiUhgB1D9rax7Z6wq+CfuzeCJzojghsDKmWmk8VVvoYKqJeebd6FPZ
         j0oRnz9DHrONGKG24D69LgXXR/9BGJALPat15lJT2ji1Js4UFXcF4Psk1Kxa1fDKYpeb
         6gH3XrKRZJvmT7Kmk5Uv5C80kZs4HevyiN9M4xPFFlfDfaGja4bicSe4vODy0xSA9PVd
         2FqNRaQZbvCjkZjDv00R77bCcUofQYePGaoUBUrrNtVjip23PhH+wgJTnHgbl4REDCbY
         p+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s5ME4E9PBHhxefrSgaXyV85rhPOWx7hl7SzszoI7Lk=;
        b=Mxk/pZKH66Vr9vcHBKxgiKCdO/FVb9CicdbXfZpOBuhjromcbe0+KAYTCyYPQTzcyG
         mXsUe5CeDLXTtKKs5quMgQ3z8q5lrNSgzx95sph+q0+RukQqWWKKoRzYosGHjDZmAbAk
         Gk1LerapUomksMSojG1c/b0c+I+4Xg2j4aMr5+dJedzGPub4sSHfI0kwiOCX2BXfqUmZ
         yKLl+v6r6uNJe+i+I5dgAG4Bm3IxxXNxGO9kUlrTcslJ9L+D1B3fH+rWECiO58zK1+O5
         CDOUz/LvoKIuSC70RtEHpuc8DdfcxQIEHUmSMTj0lshSSj7hlp/0vQlI/SEzNXuMirPI
         NdVg==
X-Gm-Message-State: AOAM533UHveCa8rAgzIlD/9/NIaMROOb98w3TFrZaPqTBVyVYYmIdf5l
        /apG9IMo3rZaNLsImUOo81Xpih3dwotflGLFtbgr4g==
X-Google-Smtp-Source: ABdhPJzGRthVGOeQIECGTwyd5iXzQhueDVBM1VF4NX2jE2OaOyjhu7phJwqsk0jpVuX0p3wUvJmAwu+RvTbgBd+ZSKM=
X-Received: by 2002:a05:6a00:23c7:b029:323:3d55:68c0 with SMTP id
 g7-20020a056a0023c7b02903233d5568c0mr26028371pfc.2.1625914496827; Sat, 10 Jul
 2021 03:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com>
In-Reply-To: <20210710003626.3549282-1-surenb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 10 Jul 2021 18:54:20 +0800
Message-ID: <CAMZfGtWXKJ6_UxqA6su=1ZVc8geqEYoLzxP7xtoHDm_Qp5pQzA@mail.gmail.com>
Subject: Re: [External] [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled
 checks in vmpressure and swap-related functions
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
> Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
> the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~2.1% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
> CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
> ARM64 Android device.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

The changes are straightforward. LGTM.
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
