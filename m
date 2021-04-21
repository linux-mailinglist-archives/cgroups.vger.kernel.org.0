Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DB366F15
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhDUP0w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhDUP0w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 11:26:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64EC06174A
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 08:26:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b38so7029666ljf.5
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z18WoidDm0JluN7aBAMWpypFOPNnTWNb0n1ktiu16SU=;
        b=Wdz+FXrfCqGktd+1nj/jpu3srZLhF0GwgoTLtEzdp1BU9CyOYHSQNgEC+z6kBfrZZ0
         GssiKNqPpsy88OtEyhiITxnaRR3n7by3JhQITIQZr2VzU9o8w/QywmCkhEls13YHYDLN
         MCjZVy5Nc0iWl0JgWNu7/bFN2Q0fNNpTtTk6mNnuYua3NwDZjO1h726O4dCYaBdyUCs2
         pdxBPGgXA+4B4ka+LQkdSwnru3/rWDXrxN33sBQaDembvySo0aV4OllTRUZmuoyziGsZ
         ZxVHnxpeGW/lpEaswdZNL8LsXYfkgaPLCMRaeh6zX6PYo22Qa3zSifLhzGCsu/N0/4a6
         weIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z18WoidDm0JluN7aBAMWpypFOPNnTWNb0n1ktiu16SU=;
        b=rAwAPs/5DeAedqvb/ayzRG455GVpvXYoanGhCfsF6Ds9CyTjYfSFVul6fDoKy1Qn2y
         979dcGKcb2nv1+gXzuJodSYzgNawE5x3nl+KqN7FpEPcGaO6B66IMTBdcJ9Ail+QelPv
         Kp+UiD/39Uh/6V/VSefSJoIVS4MncNMSkRwuJfhdkPnIVBOLHD4Owu2KPTkde/RAD40r
         X0yXIW763/FwIsbbhzer9pq5R6FC2vPUaRjJlq5L9irGA61dSlxS9IGcj/eoMwTdZO8I
         N9xioF1VyX1xBNoMZerAEJOeUq+Q1RYcQGbOGRNVlga4k4tGPOhuwFSRF2j5cnAWVCDl
         /R+g==
X-Gm-Message-State: AOAM5307Sn4u/I2GBJsLBP++5iRZaBiy0+JgoWG7YuyMNmEm5znDR0wR
        fKM7udvnq5qrVnnF/aQ9bnTmVz7oObgOCyPvPRxfyA==
X-Google-Smtp-Source: ABdhPJwn7B3VP7SjAu+8sdR+y4D+nCCibV6Lfjt+AsyNWhcE7dh9APcE0EoFqzCQlZZ526RQ6gYzLYRbc9PC8Hbu254=
X-Received: by 2002:a2e:8118:: with SMTP id d24mr18901064ljg.122.1619018776293;
 Wed, 21 Apr 2021 08:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210420192907.30880-1-longman@redhat.com> <20210420192907.30880-2-longman@redhat.com>
In-Reply-To: <20210420192907.30880-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 08:26:05 -0700
Message-ID: <CALvZod7tYG+UEYdQav6N68JbSim+r-uTQjbVKcpcuBa3gzp1NA@mail.gmail.com>
Subject: Re: [PATCH-next v5 1/4] mm/memcg: Move mod_objcg_state() to memcontrol.c
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

On Tue, Apr 20, 2021 at 12:30 PM Waiman Long <longman@redhat.com> wrote:
>
> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
> so that further optimization can be done to it in later patches without
> exposing unnecessary details to other mm components.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
