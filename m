Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6125A0823
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 06:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiHYEl4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 00:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiHYElz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 00:41:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D23B6051D
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 21:41:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so134441pji.1
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 21:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=INrevp61jvgo3SuTdlwO6+Vd1zseXzdZ0ssScT78usc=;
        b=kAHRzLJrcnUVbYLKrg/c7FYPqutwG9JKgj8uA6KK3PV+CyzNUEY6/mtraAJVl9Ty5E
         zfi9COFC1b5FEzcFfHSUPx2evppPqH2TIgm5fh0j1Gf9PfpoXw6zUcDMmjRAjbNEpjmo
         UWWJEkMK3ebPfk5TIcE5PqztVYrSkkAKjsKEMEiHVKHfIPpYeNRabgnvsrRrs0z+DE45
         TE08FVwAYgW6arUGrYUuDTWTdjQy8k/78moOETYNMTUHIvR7e3542FJmr+s5Yvtszs9T
         hgG+bNxFT3c/GJT05S/xY/IOvz4k+c8rXLJrJHiiVMt9QzfvL38envLwAT5cvVYbsmLR
         2uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=INrevp61jvgo3SuTdlwO6+Vd1zseXzdZ0ssScT78usc=;
        b=6hpZepgaLQWGPUQOqUO+JPsekJuVUIP8ofCjfcnA2Sjz04bYtrICvNqzBqCmvF3Ujq
         o3HwL/1liMU/NxokIo+aOOneXgU5vcmE4bsvMq/MRhuSyfBs7rKQV+F3Ik3j+FXZ+fyJ
         uJuOa0mBzgbkWsNccyW/1n9o791Pt2fV8OUbD8rGvVvgIs/SqmPo1Dha3McS0yg5FMVm
         5JqqG6Pb5TGaVVkogBpEqFyMniHZevnOfAxh4u7TF6fbQ68v+5gI/GEjxPDy1xJxz2LX
         +Msw4/XMDRwA2BvsIYT64zjG9L5xIeOninS4BOdjGmiyAdYJGHFZ/deFL42LTgRiAL0S
         lQaA==
X-Gm-Message-State: ACgBeo28Q8v7YCKhCnnBE4mTkZX+wn7AsspjrqMvrZFLoJKlJubzYwdN
        J1kr4DPWzWSkWlfqL0i9qde3NrUqu8OgVFI3LRUeBQ==
X-Google-Smtp-Source: AA6agR6hGN7BmkhP+Mw6B4QHFjCHWsgU7DDwEvi0UkEo46L6L55OpTIH8uF2pm+kufP7PumEiqap+MCob1VMq/R3zgE=
X-Received: by 2002:a17:902:b410:b0:172:c9d1:7501 with SMTP id
 x16-20020a170902b41000b00172c9d17501mr2099534plr.106.1661402513848; Wed, 24
 Aug 2022 21:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220825000506.239406-1-shakeelb@google.com> <20220825000506.239406-3-shakeelb@google.com>
 <20220824173330.2a15bcda24d2c3c248bc43c7@linux-foundation.org>
In-Reply-To: <20220824173330.2a15bcda24d2c3c248bc43c7@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Aug 2022 21:41:42 -0700
Message-ID: <CALvZod6+Y1yvp8evMLTeEwKnQyoXJmzjO7xLN9w=EPcOUH6BHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: page_counter: rearrange struct page_counter fields
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 24, 2022 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 25 Aug 2022 00:05:05 +0000 Shakeel Butt <shakeelb@google.com> wrote:
>
> > With memcg v2 enabled, memcg->memory.usage is a very hot member for
> > the workloads doing memcg charging on multiple CPUs concurrently.
> > Particularly the network intensive workloads. In addition, there is a
> > false cache sharing between memory.usage and memory.high on the charge
> > path. This patch moves the usage into a separate cacheline and move all
> > the read most fields into separate cacheline.
> >
> > To evaluate the impact of this optimization, on a 72 CPUs machine, we
> > ran the following workload in a three level of cgroup hierarchy.
> >
> >  $ netserver -6
> >  # 36 instances of netperf with following params
> >  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> >
> > Results (average throughput of netperf):
> > Without (6.0-rc1)     10482.7 Mbps
> > With patch            12413.7 Mbps (18.4% improvement)
> >
> > With the patch, the throughput improved by 18.4%.
> >
> > One side-effect of this patch is the increase in the size of struct
> > mem_cgroup. For example with this patch on 64 bit build, the size of
> > struct mem_cgroup increased from 4032 bytes to 4416 bytes. However for
> > the performance improvement, this additional size is worth it. In
> > addition there are opportunities to reduce the size of struct
> > mem_cgroup like deprecation of kmem and tcpmem page counters and
> > better packing.
>
> Did you evaluate the effects of using a per-cpu counter of some form?

Do you mean per-cpu counter for usage or something else? The usage
needs to be compared against the limits and accumulating per-cpu is
costly particularly on larger machines, so, no easy way to make usage
a per-cpu counter. Or maybe I misunderstood you and you meant
something else.
