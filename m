Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8640B3DDB19
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhHBOcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhHBOcY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 10:32:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796BC061760
        for <cgroups@vger.kernel.org>; Mon,  2 Aug 2021 07:32:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq29so8487052lfb.5
        for <cgroups@vger.kernel.org>; Mon, 02 Aug 2021 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19nfVkDw1JHrHyLVrxQ7C3iIv4HJUAVawRYI+zVDKis=;
        b=g2rXIt6PCcJyTa2L7O6qIeZjWDnqOSfddyk6MrYcfEsfL7ZHrImFAKiYu/6qeNFXml
         uFaNVZeiebZF2qSRn4MPkT99U8W2aI+dIRtgDQCtGeKJguajzSd2fILGxt3hoaOrg5Al
         jNhOcCLyG2pjA96otAuaSej7Cs/zqm5fq7ZGMOXetpdUIAfuG7QYlshPWqrprPyvnP/b
         eWM3QaOgo34fZF71q7x5gABjzMONsiYCOtCG0wrB3MMQG3KaQk5Cflt++3Ea2NnFguBI
         Vvm4lTfSqGY7YleaXqoyw66XVOUYcxVgtMYqifv6gkKvQu33r8bafyCu1ggNmNAPF1uk
         2QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19nfVkDw1JHrHyLVrxQ7C3iIv4HJUAVawRYI+zVDKis=;
        b=m+2JcwCq2hfCoGMxmQBCVx+U/DpzjypxH0NRdnx4jgNxFS+AduaSNlr6KUkJF+7lQP
         l5ABsVw9+0Ak7jX5aSoRrBJROwraeIUUsHG+ptqYx2Igg130pOGTxm/u6CSiFF2iCFeJ
         cLhzHXTODCEQ6TISgqj7EOO3j1tr6C4OBpJIMDCuVmgNiZqCefsHHLvkHH2Qj7940t/a
         xFv+lqgApLmVXUPRS3kyy+SY/gYDF8SrJfxTdYMcO6rU9iQPd5ov64E6MpohtPgY5nmL
         w5CQI7uzuxr66lq5n9ft5OILGLy9SdA4uysCRtJFArckR7GUUAKT6QrFtqMrHQr+srN1
         HgQw==
X-Gm-Message-State: AOAM530ivfTeqwU2zD6LghHh2ZN3oYBy4VeEc5xh7K2GjljoZjJt0CFR
        dkVR2Igom4m2spKuh6yNQZo8jWk1ZUUbGZfloor+ng==
X-Google-Smtp-Source: ABdhPJw3boDKwPQvVaGncMOJTyPUymUUTg6mvCS3v3pvSwz7jcn5lVWSJhrMrzCzEd8llnaJ0PB/fY5esLDv7jWE+o8=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr12931254lfc.117.1627914732988;
 Mon, 02 Aug 2021 07:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210802022827.10192-1-longman@redhat.com>
In-Reply-To: <20210802022827.10192-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Aug 2021 07:32:01 -0700
Message-ID: <CALvZod7-x4ezYcUh+ycTzWypL9bLpL-fdRsZrw1iM+__H2_s_g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Fix incorrect flushing of lruvec data in obj_stock
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

On Sun, Aug 1, 2021 at 7:28 PM Waiman Long <longman@redhat.com> wrote:
>
> When mod_objcg_state() is called with a pgdat that is different from
> that in the obj_stock, the old lruvec data cached in obj_stock are
> flushed out. Unfortunately, they were flushed to the new pgdat and
> hence the wrong node, not the one cached in obj_stock.
>
> Fix that by flushing the data to the cached pgdat instead.
>
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Signed-off-by: Waiman Long <longman@redhat.com>

After incorporating Michal's comments, you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
