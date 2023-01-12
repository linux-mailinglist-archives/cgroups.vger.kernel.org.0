Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC0666890
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 02:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjALBuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 20:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjALBuP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 20:50:15 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFE41020
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 17:50:14 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 203so17061716yby.10
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 17:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UI4K5mRi88yph1Y15SVIzngc8V0hAChiN1WwnseNjSo=;
        b=iX6gRZV8sICaehqfIKKCsTSZN1Qto1VW/o+R0dPGvkB24JZnDkCpMXaGC1UFCMCDAc
         65kuNToXIj4iXR4wXhLwWIDCeYuJgxjaQ/q+do9MI07FludH6aZA3vLr/9IkjsITho1/
         ZgBV3Si+v22hTmbdtckw6PN7PpNig1Dew2+7PUya3A5kMFGyHhvVHfD+DbOlVm71omPW
         1SwwzDe4Gs6f0NzLBZ+IIXwOGRD9kSi2XJe8Qd8ijsWWpakPWge0tVjudFgQAW3GGS2R
         cIJHdBLnBJ4GCsGFjMH/J/n5H+PMYqXtd3GCNGPPiJ91I14Hcy8XzkCIj2evn8CIcQit
         LY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI4K5mRi88yph1Y15SVIzngc8V0hAChiN1WwnseNjSo=;
        b=l5X9sIxgIIExpSstuYD/14ACkHK933MftUT7bHtTZHGt/Zq+vAI5tzgAcCw3oFI2Kl
         QAKmrrv0WpGP7dGJeCdEV7KA2zSHRQGRvg9C3PGxwzlic6vqfa2U8lOiSd3QARv/ZGB+
         u57heLGZplkjmOYryb3s+TEJtJ0SzRmDT3WQt140p1Cmkp64z55iAAmy8hTKtypfQTaD
         ykfDDLxkdtTHQQFMjAxr535NpmSRkXn3cqotfXzjz7GFtd+HOSP+V7Z1XLN28IncwpSq
         6f3xf317Xd9TxAmkjbu49df1vLaLze2vT/kiv9uf3C/boDrvRknKRaP5UybT/nom0bAK
         e3sw==
X-Gm-Message-State: AFqh2koBjr5vr+LAu1JzHRofnMfd8Y9mHDNijdgt49s617DeDj6UjHvi
        i3C0XnQydoEp42b43m+n+4xG4PdVgvmBYJu0OFenivTV2BddAw==
X-Google-Smtp-Source: AMrXdXu/Y0MEDSF578Eq5uQrp+u9YsYRd5gi/5tB92Rl2gsQ8XI50SHWRT2nN4aSvKOmApC1fGnZGXoNSW+oWAaF+AM=
X-Received: by 2002:a05:6902:1029:b0:77d:eb9f:1381 with SMTP id
 x9-20020a056902102900b0077deb9f1381mr7180187ybt.475.1673488213106; Wed, 11
 Jan 2023 17:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20221214225123.2770216-1-yuanchu@google.com> <87k01ulxdd.fsf@linux.ibm.com>
In-Reply-To: <87k01ulxdd.fsf@linux.ibm.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 11 Jan 2023 17:50:02 -0800
Message-ID: <CAJj2-QFg_7msfB+k2hv2jx13HCJ_-EBhqbuHwLjOVUhZvTN38w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 9, 2023 at 10:25 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Yuanchu Xie <yuanchu@google.com> writes:
>
> > Introduce a way of monitoring the working set of a workload, per page
> > type and per NUMA node, with granularity in minutes. It has page-level
> > granularity and minimal memory overhead by building on the
> > Multi-generational LRU framework, which already has most of the
> > infrastructure and is just missing a useful interface.
> >
> > MGLRU organizes pages in generations, where an older generation contains
> > colder pages, and aging promotes the recently used pages into the young
> > generation and creates a new one. The working set size is how much
> > memory an application needs to keep working, the amount of "hot" memory
> > that's frequently used. The only missing pieces between MGLRU
> > generations and working set estimation are a consistent aging cadence
> > and an interface; we introduce the two additions.
>
> So with kold kthread do we need aging in reclaim ? Should we switch reciam
> to wakeup up kold kthread to do aging instead of doing try_to_inc_max_seq?
> This would also help us to try different aging mechanism which can run
> better in a kthread.
If I understand correctly, MGLRU tries to put off aging as much as
possible for reclaim, and prefers aging uniformly in kswapd, so that
already sort of happens. With periodic aging on, reclaim only triggers
aging when it reclaims memory less than (MIN_NR_GENS * aging_interval)
cold.
