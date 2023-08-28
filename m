Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437CA78B5CE
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjH1RBD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjH1RAh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 13:00:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA98AC
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 10:00:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so415011cf.1
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693242034; x=1693846834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvhYL8hBy4EhCScbuINCvu74ArNIyYfg31Et1gNQXGg=;
        b=vvTz0ai8HUIA+vLkOnfvPV4GJ+rvtQg66soouQp/qVbyTNcEWLGOOatIH9UcVq9TOP
         BE4gT/LLv9MGa/TGbqN3HewTBeffDFuZBmENMkrrtFhTk1nfNKw9BFtslefvHxEUodld
         ZMEx81BVZOrp1cqk8cRjTM3uKlNcX/Xofy4o/3dIMDCkRMfSEmMzckYofGd6rK7Yu18G
         ge/axaAZGem1x4F1Mx7NlrvpVNYbJhK6FWbrQrSsGP4oFkzd6MjUGRHYpXyaz9vhkPwU
         kJr5ioWc09dzPgJWoHVpeu6BRnMe0UDndMDsDDNBnWKlmfU7p2J8lRCkAsD3vvfJ/9uC
         WrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242034; x=1693846834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvhYL8hBy4EhCScbuINCvu74ArNIyYfg31Et1gNQXGg=;
        b=D9hE9WuYPA0Q+0IuPfAySX/UZTz3dmH7LtMuIL4tusnP5/xArGqazi3gfRYp+21P77
         QYurbk/SHlUiUwbjddNZv32EGxCbmtoy1Dzg/fpqX7+HrGuz5OJHmTQ1/z+3NOBEnKfD
         R3fd3eS8MFpEZaAW4QeQ5vVNzLJVFTHFKuDAoQf8AihbAshe/ReH69Zk9LsJWrJcbZWC
         7+XnZNtvFkb15ifmG4Au7Rnhh9sSQH6DIP7CiyFE0YPUGE1kMMuZKfVJCZJkFIoN9D2D
         x6SZTh7Fu59eSl5OCSxyFE5RnssJy4dg9obAg9B5swFLHOT50SFZkI6v6p/qnbi0asPP
         i9Nw==
X-Gm-Message-State: AOJu0YyQEBjYHyM965fisIZejk85SmsEWCfXFjHCVhs66nQLGqGkby/F
        ivc40EWM8giFOz2Jk4h0IJwPRg5xzy5nAlLJW1+Jow==
X-Google-Smtp-Source: AGHT+IGzOF19YiuEmu+BVGUHysDsySqw7TznjUlMxzpcl63xmqqetr6P7uw061H2B3BhIYP/cdS6CgKuG18Z/j3ZOrM=
X-Received: by 2002:a05:622a:148b:b0:3f2:2c89:f1ef with SMTP id
 t11-20020a05622a148b00b003f22c89f1efmr1750qtx.5.1693242033626; Mon, 28 Aug
 2023 10:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz> <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz> <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
In-Reply-To: <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 28 Aug 2023 10:00:21 -0700
Message-ID: <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 28, 2023 at 9:15=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> >
> > Well, I really have to say that I do not like the notion that reading
> > stats is unpredictable. This just makes it really hard to use. If
> > the precision is to be sarificed then this should be preferable over
> > potentially high global lock contention. We already have that model in
> > place of /proc/vmstat (configurable timeout for flusher and a way to
> > flush explicitly). I appreciate you would like to have a better
> > precision but as you have explored the locking is really hard to get ri=
d
> > of here.
>
> Reading the stats *is* unpredictable today. In terms of
> accuracy/staleness and cost. Avoiding the flush entirely on the read
> path will surely make the cost very stable and cheap, but will make
> accuracy even less predictable.
>

On average you would get the stats at most 2 second old, so I would
not say it is less predictable.

> >
> > So from my POV I would prefer to avoid flushing from the stats reading
> > path and implement force flushing by writing to stat file. If the 2s
> > flushing interval is considered to coarse I would be OK to allow settin=
g
> > it from userspace. This way this would be more in line with /proc/vmsta=
t
> > which seems to be working quite well.
> >
> > If this is not accaptable or deemed a wrong approach long term then it
> > would be good to reonsider the current cgroup_rstat_lock at least.
> > Either by turning it into mutex or by dropping the yielding code which
> > can severly affect the worst case latency AFAIU.
>
> Honestly I think it's better if we do it the other way around. We make
> flushing on the stats reading path non-unified and deterministic. That
> model also exists and is used for cpu.stat. If we find a problem with
> the locking being held from userspace, we can then remove flushing
> from the read path and add interface(s) to configure the periodic
> flusher and do a force flush.
>

Here I agree with you. Let's go with the approach which is easy to
undo for now. Though I prefer the new explicit interface for flushing,
that step would be very hard to undo. Let's reevaluate if the proposed
approach shows negative impact on production traffic and I think
Cloudflare folks can give us the results soon.
