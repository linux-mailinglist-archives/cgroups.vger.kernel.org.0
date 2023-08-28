Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E165378B606
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjH1RJk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjH1RJd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 13:09:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E470CE4
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 10:08:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so4650078a12.1
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693242505; x=1693847305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgmSxEVlzi5fMkwnrM8LhIHtQEbm/jAUKGlrVKGkYss=;
        b=iFiaXdvNyP/PGupmYZQ4VDhihu4roD+VOTAYUOk648A8zr/NnetU0xeTBrkoG+AsPR
         2wxI9+4xAQyl3Xxl94EeAyF+UIHsPMJF7wGK0pCn3gzC4W2F4540PibPlUl5Zn6MTaR2
         o9vymucc9ynm4RNh82v145GN+bLsUwc0gP3U/tWXkGAjscoX/fm2tFx7pnKGjTA5r+bw
         1SR9g8zkzT/uibLlIedBK0SvUKoCFVbB3i1kaLcB1K4BYwKWqBKKzLSRxsgdcTYodIoi
         FusqkfeL0/iUTIn/J+n7J3p1yNB/tRDgBAeMhHmPuu5uQZq3RL4xZ0uTD5pWqvRs5dNW
         PSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242505; x=1693847305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgmSxEVlzi5fMkwnrM8LhIHtQEbm/jAUKGlrVKGkYss=;
        b=QN4dMpHDCk189yHd33/OCaYGbuRAQ2R0A/vG5sBxembeJRZjoZeUutpUHtR93OlHdH
         HSZhg0wHjJSaO6jASoe/ReJjU+erikNJbDMMmAz/i98oXMJW6tzd5rHtxd1SiIw+8uan
         3Bp2I9+wGwcNWN1zhWOS74tT7/GntUIf6oLkt7fGZZNZmZxyPVK4QyS+2YtxWnTEBw5K
         CJhg9BVsSOKzs1LyDe8KtsmzkIqljTy56KZ/WpAngYpol+qxHG1Y33GHd/aHgd/1o1jN
         /YEm8Ctor8C9zHQm8iXxiyksf7ukVkVJc+hcwg+lgkgBMyJd/XkSBcZYdM65AZJ/ajKE
         965A==
X-Gm-Message-State: AOJu0YwH6SRVSpuB895r7lqu1HRZ8KZsTHBdNnySQbb9KYpEvbJFeiNB
        e4FE8C6RCUsHuyHd3+pXeiMDFi4qcqLDWQOUrOAsnQ==
X-Google-Smtp-Source: AGHT+IEebaOPHNuzP7D5Utx3nzTPX+fvnhl+LnF5mzhFALZEervRMpT4j2HBe8/3OWEpuNkUYvYhIzytsgarWkOfJOw=
X-Received: by 2002:a17:906:2092:b0:9a5:852f:10ac with SMTP id
 18-20020a170906209200b009a5852f10acmr5947834ejq.53.1693242505112; Mon, 28 Aug
 2023 10:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz> <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz> <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
In-Reply-To: <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 28 Aug 2023 10:07:48 -0700
Message-ID: <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 28, 2023 at 10:00=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Mon, Aug 28, 2023 at 9:15=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > >
> > > Well, I really have to say that I do not like the notion that reading
> > > stats is unpredictable. This just makes it really hard to use. If
> > > the precision is to be sarificed then this should be preferable over
> > > potentially high global lock contention. We already have that model i=
n
> > > place of /proc/vmstat (configurable timeout for flusher and a way to
> > > flush explicitly). I appreciate you would like to have a better
> > > precision but as you have explored the locking is really hard to get =
rid
> > > of here.
> >
> > Reading the stats *is* unpredictable today. In terms of
> > accuracy/staleness and cost. Avoiding the flush entirely on the read
> > path will surely make the cost very stable and cheap, but will make
> > accuracy even less predictable.
> >
>
> On average you would get the stats at most 2 second old, so I would
> not say it is less predictable.
>
> > >
> > > So from my POV I would prefer to avoid flushing from the stats readin=
g
> > > path and implement force flushing by writing to stat file. If the 2s
> > > flushing interval is considered to coarse I would be OK to allow sett=
ing
> > > it from userspace. This way this would be more in line with /proc/vms=
tat
> > > which seems to be working quite well.
> > >
> > > If this is not accaptable or deemed a wrong approach long term then i=
t
> > > would be good to reonsider the current cgroup_rstat_lock at least.
> > > Either by turning it into mutex or by dropping the yielding code whic=
h
> > > can severly affect the worst case latency AFAIU.
> >
> > Honestly I think it's better if we do it the other way around. We make
> > flushing on the stats reading path non-unified and deterministic. That
> > model also exists and is used for cpu.stat. If we find a problem with
> > the locking being held from userspace, we can then remove flushing
> > from the read path and add interface(s) to configure the periodic
> > flusher and do a force flush.
> >
>
> Here I agree with you. Let's go with the approach which is easy to
> undo for now. Though I prefer the new explicit interface for flushing,
> that step would be very hard to undo. Let's reevaluate if the proposed
> approach shows negative impact on production traffic and I think
> Cloudflare folks can give us the results soon.

Do you prefer we also switch to using a mutex (with preemption
disabled) to avoid the scenario Michal described where flushers give
up the lock and sleep resulting in an unbounded wait time in the worst
case?
