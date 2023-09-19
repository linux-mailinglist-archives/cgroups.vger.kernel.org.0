Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945EB7A5956
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjISFa2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 01:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISFaZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 01:30:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F1114
        for <cgroups@vger.kernel.org>; Mon, 18 Sep 2023 22:30:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a65f9147ccso691125666b.1
        for <cgroups@vger.kernel.org>; Mon, 18 Sep 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695101418; x=1695706218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fneQXzvskbWAJ/u8RbohNhmDqQxy1hEL61UT0wNAZho=;
        b=n+hkRywlkXvqXRXYkd6GjF6nP8DsNC6F0mvMGKVBzHflUYLPfg3aiDk99QYMyzn78H
         o3gRGBX95B8NQJQdGbWpcJH1pIiePnxIYcl24auvrKEFUmLcUhDDQvJOlyOon1ycRYTZ
         L/TyPvCBzCZVhi+t7hFBL3JZ4pmfUkPpsFEhImM+pR0tSwLOFNEWlSxzyiwMXM7C4wCT
         gk5X72MVmV6vMMkjfhCJ3CK7rvbuT4NfEnav5uN4N1D9HGNk9kS6F29PyYihqeBTj67j
         ciOm2YcHFdQ7jMtzDQj2MT6u9P56suWMikwj91N7BRCk9XTHLm8ZDyqsiC+Zq1Sh40d8
         AT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695101418; x=1695706218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fneQXzvskbWAJ/u8RbohNhmDqQxy1hEL61UT0wNAZho=;
        b=mYBA4S1gAysV6ZT4gbP/pwU1eyLq1ArYhsGWiXhtlH7LbPBygkSmU0BMoqe56n+IvG
         VTONh7iVy6CnEEjaytqaiJH4BPv9uL8W/fX159dkakoap4tsDjRWvIVNnfz7H/OvUf+T
         0YNGsimQ/G52/rci2zb2AjU5M1TxkVI61QHB1NYT/iBmW3ofClwaMfkPoKiS+BEkeJKg
         PKdQgbn2WJwas1CK0DM15BLAdevQX4a6n9B9EbOtdTru4gmBvE4STBTJwiSRveCAWvUK
         4NprvGwMxq9oxflWOkMyJl/ZJbOUegKquveCTFrnJEbOXUHSq2yDIqhDo0wpYz7Qof2l
         vJzQ==
X-Gm-Message-State: AOJu0YyjargUNAWtbuXOUF9uCpbAZCEPF36sD7FnjAGzzL0iUwsxpp6s
        Gv/d80PYAAXMwiL6kjhzAFoDn9zMrQSCvR615GsvIw==
X-Google-Smtp-Source: AGHT+IFh3eaDnagGr449OpW6h5lWcLN4qCWCJI29FyabrvA5jV7YdqmIzWIOkN+ZlW9n5bkwgIP12w4Gr4EbgrEVCiA=
X-Received: by 2002:a17:907:2c6b:b0:9ae:1872:d0ab with SMTP id
 ib11-20020a1709072c6b00b009ae1872d0abmr2757113ejc.0.1695101417573; Mon, 18
 Sep 2023 22:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <CALvZod6j5E2MXFz463LRcrP6XY8FedzLUKW88c=ZY39B6mYyMA@mail.gmail.com>
 <CAJD7tkbb5zxEPSW6vvijDpQKCZiDcUJqe8SPvLHfo0RX7iHXAw@mail.gmail.com>
 <20230914225844.woz7mke6vnmwijh7@google.com> <CAJD7tkb_pDxqqhB25aZpbfur=YodBRb1nmdpNZt1DB_1ozDpPQ@mail.gmail.com>
 <20230915010138.knjli6ovpozxbpss@google.com>
In-Reply-To: <20230915010138.knjli6ovpozxbpss@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Sep 2023 22:29:38 -0700
Message-ID: <CAJD7tka-Rzn77J4cDwVb1jqiMF0XFsTHpJLAVsMbVTTyxZZVew@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 6:01=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Sep 14, 2023 at 04:30:56PM -0700, Yosry Ahmed wrote:
> [...]
> > >
> > > I think first you need to show if this (2 sec stale stats) is really =
a
> > > problem.
> >
> > That's the thing, my main concern is that if this causes a problem, we
> > probably won't be able to tell it was because of stale stats. It's
> > very hard to make that connection.
> >
>
> Please articulate what the problem would look like which you did in the
> use-cases description below, let's discuss there.
>
> > Pre-rstat, reading stats would always yield fresh stats (as much as
> > possible). Now the stats can be up to 2s stale, and we don't really
> > know how this will affect our existing workloads.
> >
>
> Pre-rstat the stat read would traverse the memcg tree. With rstat
> the tradeoff was made between expensive read and staleness.
> Yeah there
> might still be memcg update tree traversal which I would like to remove
> completely. However you are saying to

I think this sentence is truncated.

>
> [...]
> > >
> > > I don't see why userspace OOM killing and proactive reclaim need
> > > subsecond accuracy. Please explain.
> >
> > For proactive reclaim it is not about sub-second accuracy. It is about
> > doing the reclaim then reading the stats immediately to see the
> > effect. Naturally one would expect that a stat read after reclaim
> > would show the system state after reclaim.
> >
> > For userspace OOM killing I am not really sure. It depends on how
> > dynamic the workload is. If a task recently had a spike in memory
> > usage causing a threshold to be hit, userspace can kill a different
> > task if the stats are stale.
> >
>
> Please add above reasoning in your commit message (though I am not
> convinced but let's leave it at that).

Will do in the next version, thanks.

>
> > I think the whole point is *not* about the amount of staleness. It is
> > more about that you expect a stats read after an event to reflect the
> > system state after the event.
>
> The whole point is to understand the tradeoff between accuracy and cost
> of accuracy. I don't think you want to pay the cost of strong
> consistency/ordering between stats reading and an event. My worry is
> that you are enforcing a tradeoff which *might* be just applicable to
> your use-cases. Anyways this is not something that can not be changed
> later.

Given the numbers I got with the patch, it doesn't seem like we are
paying a significant cost for the accuracy. Anyway, as you say, it's
not something that can not be changed. In fact, I have another
proposal that I am currently testing, please see my next response to
Johannes.

>
> >
> > > Same for system overhead but I can
> > > see the complication of two different sources for stats. Can you prov=
ide
> > > the formula of system overhead? I am wondering why do you need to rea=
d
> > > stats from memory.stat files. Why not the memory.current of top level
> > > cgroups and /proc/meminfo be enough. Something like:
> > >
> > > Overhead =3D MemTotal - MemFree - SumOfTopCgroups(memory.current)
> >
> > We use the amount of compressed memory in zswap from memory.stat,
> > which is not accounted as memory usage in cgroup v1.
> >
>
> There are zswap stats in /proc/meminfo. Will those work for you?

Yeah this should work for this specific use case, thanks.

>
> [...]
> > > Fix the in-kernel flushers separately.
> >
> > The in-kernel flushers are basically facing the same problem. For
> > instance, reclaim would expect a stats read after a reclaim iteration
> > to reflect the system state after the reclaim iteration.
> >
>
> I have not seen any complains on memory reclaim recently. Maybe
> reclaim does not really need that such accuracy :P

Perhaps, it's full of heuristics anyway :)

>
> > > Also the problem Cloudflare is facing does not need to be tied with t=
his.
> >
> > When we try to wait for flushing to complete we run into the same
> > latency problem of the root flush.
>
> Not sure what wait for flushing has to do with Cloudflare's report. They
> are ok with no sync flushing at all stat read.

Oh I am not saying the wait benefits their use case. I am saying when
the wait is implemented, we face the same problem (expensive flush of
the entire hierarchy), so we need to mitigate it anyway -- hence the
relevance to Cloudflare's use case.

Anyway, I have an alternative that I will propose shortly in response
to Johannes's reply.
