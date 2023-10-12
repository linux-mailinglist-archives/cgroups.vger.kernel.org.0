Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34997C7A68
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 01:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443112AbjJLX3d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 19:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443113AbjJLX3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 19:29:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CDE9
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 16:29:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso243844666b.1
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697153367; x=1697758167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TkuD/z8Ea8WYF7ftnX8CODZoRzj/hmgN33zzZIDYSA=;
        b=UFmt1M5v/IcLUQCK/67fxs2EUXoYS4NqBzMjn1qm45QtLvAESJD2vJl2ZQV4/FSzxz
         vxwqR+S3NBCbO6K8nbljZOWpJafC7WnYiG/G/DmCnNPIzM5ke/BKbprAncvWfjM+Hsq8
         oaA/KAdPYeHbiw9e/pspQc/UrC5dhYwYxYgUU9OwevJqENrOjPOUGyKXYoSUMHPiPyND
         WO1rBOu3e0nq6Ilbco7ujpCcIrsfW8R1rzs/9L3H9seX8ope8ocIiEi3PtHtrtPcPuq+
         7ay3fRVQ60+hggYZhP2f/ONW4XMxzTjqge8ykXlU5VKefpP9wqa+oK09rX5aJYmKz5Lt
         cnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153367; x=1697758167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TkuD/z8Ea8WYF7ftnX8CODZoRzj/hmgN33zzZIDYSA=;
        b=TabbUIaan3KGm/Sl4vBjpZPdlG67tNnONuAt/7oBUlkTinEYLzGwcrGRSXoTZfmY9+
         8t9B+Uhw0KhtOVkcbZhDGdJAJz0uyNZCPDxYN19vUvyBuijKdEczE242C/5MPujBdVNC
         WUXIsBa7FtB6L8UjFWDhIEQHxji+muEjhUSpS2Ia8XLKH2fj1XRR2EU+uEVI5mSACd+m
         Wgw+edVcQTUXXaYdIaiebCVscFOPVvdzTyKaEkMr1jPHq2w1h3PUgEtCwr4lJMFOtVlQ
         NDC/ghSwL+WaB7ArhjtKmC6HTrfoe7mXbIIctevPzgPrR1MCDNZW8ayEIUMY8ci6xUWw
         XfnQ==
X-Gm-Message-State: AOJu0Yzve6bEzyU+GBMf8nBRpd3P2q2Kj/u+1y7PY/evkSHb2vyvPhXI
        7fDLh/A9MvaWPzOr1VIUEWBAh8nyfLBdDn+jMU7WOA==
X-Google-Smtp-Source: AGHT+IFdXPfo4ovXRKwRkiVmXcpZd2iaEltEYEe0yNpT/QQXXaHOlP6gWF9jdH/t5/DhLfHs4srOZv3wku2b10WydYc=
X-Received: by 2002:a17:906:31c5:b0:9ae:6a51:87c3 with SMTP id
 f5-20020a17090631c500b009ae6a5187c3mr23549400ejf.9.1697153366955; Thu, 12 Oct
 2023 16:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com> <20231012132946.GA470544@cmpxchg.org>
In-Reply-To: <20231012132946.GA470544@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 12 Oct 2023 16:28:49 -0700
Message-ID: <CAJD7tkbrR=6SmVxo4pVKHVu4eGBYN+xXuu5+zFPh6LSqt8vGcw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

[..]
> > >
> > > Using next-20231009 and a similar 44 core machine with hyperthreading
> > > disabled, I ran 22 instances of netperf in parallel and got the
> > > following numbers from averaging 20 runs:
> > >
> > > Base: 33076.5 mbps
> > > Patched: 31410.1 mbps
> > >
> > > That's about 5% diff. I guess the number of iterations helps reduce
> > > the noise? I am not sure.
> > >
> > > Please also keep in mind that in this case all netperf instances are
> > > in the same cgroup and at a 4-level depth. I imagine in a practical
> > > setup processes would be a little more spread out, which means less
> > > common ancestors, so less contended atomic operations.
> >
> >
> > (Resending the reply as I messed up the last one, was not in plain text)
> >
> > I was curious, so I ran the same testing in a cgroup 2 levels deep
> > (i.e /sys/fs/cgroup/a/b), which is a much more common setup in my
> > experience. Here are the numbers:
> >
> > Base: 40198.0 mbps
> > Patched: 38629.7 mbps
> >
> > The regression is reduced to ~3.9%.
> >
> > What's more interesting is that going from a level 2 cgroup to a level
> > 4 cgroup is already a big hit with or without this patch:
> >
> > Base: 40198.0 -> 33076.5 mbps (~17.7% regression)
> > Patched: 38629.7 -> 31410.1 (~18.7% regression)
> >
> > So going from level 2 to 4 is already a significant regression for
> > other reasons (e.g. hierarchical charging). This patch only makes it
> > marginally worse. This puts the numbers more into perspective imo than
> > comparing values at level 4. What do you think?
>
> I think it's reasonable.
>
> Especially comparing to how many cachelines we used to touch on the
> write side when all flushing happened there. This looks like a good
> trade-off to me.

Thanks.

Still wanting to figure out if this patch is what you suggested in our
previous discussion [1], to add a
Suggested-by if appropriate :)

[1]https://lore.kernel.org/lkml/20230913153758.GB45543@cmpxchg.org/
