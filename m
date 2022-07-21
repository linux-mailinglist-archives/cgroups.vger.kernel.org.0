Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7657D06C
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGUP6r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiGUP6q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 11:58:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5877E020
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 08:58:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a5so2883912wrx.12
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swGACW5Jh2L0fPaTYT636BPQVQeKVon43dJ9BYyWHwk=;
        b=r+w+mxLV3pDF7H2PvRP1rSgfVNzPHjXRHDyW0bx0FSpYp1xxdfqRoM2olAqDztXFE2
         PrymskSXxb/ztAY1MquHjtG0OPZHvYVoOyAxVVJizv2kBU3Q4X1K7qkH/BbNu30JXFtU
         jhWBX1Jy7Ww9lAN0MpXsAQhFSo5xgPmW7AAMUve3/2zmUkNLIZbDLkbOVMwQ42/Zvgxm
         Ti1H7+z6K/40JPEy9H0KmJ3GQHMbwo2S5TK+RhZh2SpFcwkIZHoA/HDnKg2724iqIleF
         GGmYpUbMNf8YGpByjFYxAiFmsiC7KoY1DCuYjnD3rpRD2ICk4RJIeYEkxerGu8ODGLx2
         Oc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swGACW5Jh2L0fPaTYT636BPQVQeKVon43dJ9BYyWHwk=;
        b=5d1VztTrgt9xRDufjGqQveykPF2OlVAXzbNSiGVlVpTSQqtTOZA6Emxy4tA+nxz8c/
         ixAt1lggGoMnvgBXQ7/MjzPnmOAiHbcuAHu1Wd1OQa9OvMGsGsKwrH/4HnY9SQCKi4SX
         9aE5jSXDP8e57PsGIPH4LgwTEGrZgE0GapYXi99J7sRyiNf6qAW3oQQi/KMqS/tFPvCh
         5cC0u3ZtVw4S1xkilYs4le4jvVseZq8pNPz719DMyzHRu1xiu3HMmxjOhYJmLbtScXsx
         ieA/M9GbbXODCbSylyd7ceI8IFGlC0sG73g83gBUYvuo9wGil6/bLvxtssM7/z+r1++K
         9Zww==
X-Gm-Message-State: AJIora8hJmg1AW0vakPWJUJgFLKbIQzVlTIpaPm6mw+AZkf2L/yev6CC
        LuvsghlCXO09M2KZ6K2qJeZ4+JO/TsbOHG6u9s4kbA==
X-Google-Smtp-Source: AGRyM1ui36nmmM0kwT+BBL9kt+7hL3D05kc007Hh2x/g9jXftjz2Ge7Zcom7SuTAQth49VFnYPf/LsmoF3sLqsIZlEs=
X-Received: by 2002:a5d:588b:0:b0:21d:a918:65a5 with SMTP id
 n11-20020a5d588b000000b0021da91865a5mr35915956wrf.210.1658419122519; Thu, 21
 Jul 2022 08:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz> <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
 <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com> <Ytk8EBBEi4EubvPn@dhcp22.suse.cz>
In-Reply-To: <Ytk8EBBEi4EubvPn@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 21 Jul 2022 08:58:06 -0700
Message-ID: <CAJD7tkZVcQ6xzdnGPS0kQAP=+Q=yZwVT_ZrLaEsAgkLi_DAMtQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 21, 2022 at 4:44 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 20-07-22 11:02:56, Yosry Ahmed wrote:
> > On Wed, Jul 20, 2022 at 10:50 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > [...]
> > > >
> > > > I think what we are missing here is
> > > > - explain that this doesn't have any effect on existing users of
> > > >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> > > >   is v2 feature. This is a trivial statement but quite useful for future
> > > >   readers of this commit
> > > > - explain the effect on the networking layer and typical usecases
> > > >   memory.reclaim is used for currently and ideally document that.
> > >
> > > I agree with the above two points (Yosry, please address those) but
> > > the following third point is orthogonal and we don't really need to
> > > have an answer for this patch to be accepted.
> > >
> >
> > That's great feedback, thanks Michal and Shakeel!
> >
> > How do you feel about the following commit message instead? Does it
> > address your concerns?:
> >
> > memory.reclaim is a cgroup v2 interface that allows users to
> > proactively reclaim memory from a memcg, without real memory pressure.
> > Reclaim operations invoke vmpressure, which is used in cgroup v1 to
> > notify userspace of reclaim efficiency, and used in both v1 and v2 as
> > a signal for a memcg being under memory pressure for networking (see
> > mem_cgroup_under_socket_pressure()). For the former, vmpressure
> > notifications in v1 are not affected by this change since
> > memory.reclaim is a v2 feature.
> >
> > For the latter, the effects of the vmpressure signal (according to
> > Shakeel [1]) are as follows:
> > 1. Reducing send and receive buffers of the current socket.
> > 2. May drop packets on the rx path.
> > 3. May throttle current thread on the tx path.
> >
> > Since proactive reclaim is invoked directly by userspace, not by
> > memory pressure, it makes sense not to throttle networking. Hence,
> > this change makes sure that proactive reclaim caused by memory.reclaim
> > does not trigger vmpressure.
>
> OK, looks much better. Please also add a note to the documentation about
> this side effect.

I don't want to add something to the documentation about throttling
networking because it seems like these are implementation details that
we may change in the future. I don't know if we can document this
behavior today and then change it later.

How about we document a more generic statement in memory.reclaim
documentation, like:

"With reactive reclaim operations triggered by the kernel, the kernel
may take further actions to alleviate memory pressure (such as
throttling networking memory consumption). For proactive reclaim
operations triggered by this interface, the kernel may choose to skip
such actions as reclaim is not an indication of memory pressure."

Does this make sense to you?

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
