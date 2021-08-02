Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80D03DDB3D
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHBOkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHBOkD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 10:40:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442DAC06175F
        for <cgroups@vger.kernel.org>; Mon,  2 Aug 2021 07:39:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so34046906lfr.11
        for <cgroups@vger.kernel.org>; Mon, 02 Aug 2021 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1m6pfpC9rsy4GSyHGxYSdhbpeh3oHqT/0d9aZ8K278=;
        b=fdtPnMBtsMGDTdvX2QBuR6NOVYxQwCHecY1QbSOcjAf9TiIs9eCkCzVwMMO+3YRlEY
         GvRyLN1BM+Wj0CjkHDuV3TS7ZKAv19LReq4O5Ou7P4B0mdbRU1EzTTm1C4y1wgZ7yNtr
         +a46F67dQVEAFtzb8DFx420SXHHckE63pTNxmo0Jb/sqX8aRt7aQShh59oLaFTf8v7ZA
         x5wUBgStITrUg/h47Gg3mo5tlbUFVVzXMkeKeEMSQDumsJcSrKx/HO0rE5ADto6FW+KP
         2Mirl0FPCWyv9eytyN5VvtI0xyPxR9GbsZr7pxM+HmkERO+QO3uNUx8VN70c7/i8lXzW
         z0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1m6pfpC9rsy4GSyHGxYSdhbpeh3oHqT/0d9aZ8K278=;
        b=hSMLxbq4bPYaiZwiuDRwNCeLvFkHiWniupdlunlP+WYTSahaPj8B4a3FchBeWGmRPt
         7AvFURRsPrGJqhd29eiWcnL9fDIiD8xBy4FFCwxRbilNPagMPaRmnLT2+skPJpsOZgvb
         9Hb8m7UtxuAMShqI8WbbsOOjIp5WiuR0Iv1jS+TtMUy8j2CLwG8GuYaxy8leUNox10NJ
         ZCtPMzJUZPqE4e962OJzBMuoymuqUYO1cC9CNzrVLu8VDh0DRSindPuUZ1HXzvPJn+HC
         wDrpc73b/x/ejfrSpvidGo7kd2+ndscfriNSG8lGBJ4NOB7JVjjmKgHY4EWguKUxyNWi
         kRRw==
X-Gm-Message-State: AOAM530576pdlGBj+BwvP7oD3QWBhafZr5TmTYPy+B3+GKxfZlCQWMu2
        aqcWfMCwNjNXF/xwcVh/8R9bo1p5rVNngy7BHuQ0aQ==
X-Google-Smtp-Source: ABdhPJz8cjD2bkn7AkufetYcve2CByZsWJqgUhktcF6TijRPH3PCVJRD1o5AMgo6fF6IvpQeTHreBiIOhdBkHPiZugQ=
X-Received: by 2002:a05:6512:39c6:: with SMTP id k6mr2732067lfu.549.1627915192420;
 Mon, 02 Aug 2021 07:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210802143834.30578-1-longman@redhat.com>
In-Reply-To: <20210802143834.30578-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Aug 2021 07:39:41 -0700
Message-ID: <CALvZod51JYXv0Vzo-JhsFF1K9SsSXqJCGtEedXtfQAYQAN_5jQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcg: Fix incorrect flushing of lruvec data in obj_stock
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 2, 2021 at 7:38 AM Waiman Long <longman@redhat.com> wrote:
>
> When mod_objcg_state() is called with a pgdat that is different from
> that in the obj_stock, the old lruvec data cached in obj_stock are
> flushed out. Unfortunately, they were flushed to the new pgdat and
> so the data go to the wrong node. This will screw up the slab data
> reported in /sys/devices/system/node/node*/meminfo.
>
> Fix that by flushing the data to the cached pgdat instead.
>
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
