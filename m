Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73E557FA8
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiFWQXP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiFWQXP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 12:23:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033282CE00
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 09:23:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so28668172wrg.7
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Prnv934r/fiLrvMDb9R4Q9UAwnFSkafyVnLRJO0ekrY=;
        b=LcoScsX3IhV4fd9f8iupQ0Dlh9F4jxJt+pgI6sQwesfY1uulJbPFxxz3e47Y2gN5vK
         YwtUZOQhD+OdIkZq5h5316VrCYA3zkWya3oWSYp4ktmB127kUkw7jZv3YcpAhKXNZzWo
         1CP4PSfO9KCvKOxJTo+viKnOKsiH2EnZ9nV1sMg+EMAMtWPKjMLsiI6Uoq3ZeBAMuudO
         eTY+3/kHyPgm68smgmjFRHiyd9g+n46HURNhMJpQIzk1BuWIibHuWzfBoKlJCRreeDvr
         8DcMZuSyY9c//NpF//WcukCphUzRbNnFTdq7wpzcjzX96KvWRWrKZXgHpYsIq/UCMrL5
         mNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Prnv934r/fiLrvMDb9R4Q9UAwnFSkafyVnLRJO0ekrY=;
        b=jSwYiUP887nlino1qWOnO7ewMlQIec2uS/+f3SzTnSkMeF5kEj1vRRKPbV4jDhHEfb
         8M2DGVfu5bMU3aTz2KKXcGMZBM/jj6ap8zS7wP3SL3qbkoUeK0T77BZH/y8sXBJBcgzU
         xeCCdRLRisSQ8eCZNWmxdhlYAm3btloudnwjiCCJiPy5+Wo/jpy8WZnI/CKAjxhKexTB
         KnfmqIEhoCqnHALASR+47pez/xIn0Gwdo92nNWLBZaac/N2YJViRjLuIUhjKNXdakkpM
         SxrBImdpz/urTsw0LDLE22Ddcg0OMKyhpIDeple8itD+vJMiC9HRlumbvgQUNbe51PKH
         XHIg==
X-Gm-Message-State: AJIora9iJQ2P5RLrIAD3EtuY+yAjgHqlCG9CW+LptYGm3r8Ohc7KjDyF
        b47mc9ewypB+PL6IISn706ZBEXDj9syj6gQN2x6IIA==
X-Google-Smtp-Source: AGRyM1vTy6IWQuv86qCMMmSYWNfQztKY8n3VeFmwOS7QomTeUz0+bWJzjNiyKFatZ6wC44IktxYiKmcznPAqBBvH7jU=
X-Received: by 2002:adf:f146:0:b0:21b:8c7d:7294 with SMTP id
 y6-20020adff146000000b0021b8c7d7294mr9243960wro.582.1656001391355; Thu, 23
 Jun 2022 09:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
In-Reply-To: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Jun 2022 09:22:35 -0700
Message-ID: <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
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

On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > On Thu, Jun 23, 2022 at 1:05 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 00:05:30, Yosry Ahmed wrote:
> > > > Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > > > as memory pressure") made sure that memory reclaim that is induced by
> > > > userspace (limit-setting, proactive reclaim, ..) is not counted as
> > > > memory pressure for the purposes of psi.
> > > >
> > > > Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> > > > from try_charge() and reclaim_high() wrap the call to
> > > > try_to_free_mem_cgroup_pages() with psi handlers.
> > > >
> > > > However, vmpressure is still counted in these cases where reclaim is
> > > > directly induced by userspace. This patch makes sure vmpressure is not
> > > > counted in those operations, in the same way as psi. Since vmpressure
> > > > calls need to happen deeper within the reclaim path, the same approach
> > > > could not be followed. Hence, a new "controlled" flag is added to struct
> > > > scan_control to flag a reclaim operation that is controlled by
> > > > userspace. This flag is set by limit-setting and proactive reclaim
> > > > operations, and is used to count vmpressure correctly.
> > > >
> > > > To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> > > > ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> > > > is effectively reverted and the same flag is used to control psi as
> > > > well.
> > >
> > > Why do we need to add this is a legacy interface now? Are there any
> > > pre-existing users who realized this is bugging them? Please be more
> > > specific about the usecase.
> >
> > Sorry if I wasn't clear enough. Unfortunately we still have userspace
> > workloads at Google that use vmpressure notifications.
> >
> > In our internal version of memory.reclaim that we recently upstreamed,
> > we do not account vmpressure during proactive reclaim (similar to how
> > psi is handled upstream). We want to make sure this behavior also
> > exists in the upstream version so that consolidating them does not
> > break our users who rely on vmpressure and will start seeing increased
> > pressure due to proactive reclaim.
>
> These are good reasons to have this patch in your tree. But why is this
> patch benefitial for the upstream kernel? It clearly adds some code and
> some special casing which will add a maintenance overhead.

It is not just Google, any existing vmpressure users will start seeing
false pressure notifications with memory.reclaim. The main goal of the
patch is to make sure memory.reclaim does not break pre-existing users
of vmpressure, and doing it in a way that is consistent with psi makes
sense.

> --
> Michal Hocko
> SUSE Labs
