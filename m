Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C07A11D8
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjINXb4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjINXbo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 19:31:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7B2D49
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 16:31:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a9d6b98845so586815666b.0
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694734295; x=1695339095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7Rb24jsu1Obt5C61wSLsWivJKBy0po7p8YAHy1mWV0=;
        b=ec94cJ09zKdzjHAXxU1iRkThGliciKFPhphW1t4eNFS4oSPl3XsbT+Vug8CSQ8qmjs
         0W2BS5XmVYmJobS3Mer6nPsVBXBxNIg+AQtfL2xgcSHJOw0dDMSdJuBQcl3DrcLDL1n3
         VNkQOnjMJaf8laRkx+kHoJ3babjO5UqhUKysdabSfYo++J0b/1QWcA9tMlrwcYR+3w2U
         48f+fQxE5HQCRtHS95YEc30BodxZevyHNYFWSZgw0jqBHjtGa7yoZnPEF9qAYyDF7xuc
         mPgpSbKxKfIOzf7cSDCyEtPTVviPa/u1FhFGZtI8nSLQErVztPSpn+7HlJEpdA6Zf6Ih
         2GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734295; x=1695339095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7Rb24jsu1Obt5C61wSLsWivJKBy0po7p8YAHy1mWV0=;
        b=iukwgY2eJLj6INLEczqnpaIk3Qq18/1LDE3OVwswoEEg/WtmwNnsD1C5UKzKnu9vcR
         Wb/4PQMnK2WQB/U1LIKDanhcT/5IBoN0U4RHp22Ky/ueycUW4pSaGvgfJxEYgW6aFcSk
         9WxmDwtDuRpD/uT74nROzJM6Amtnk24XnPjpNXqQKjYAYiyCo8+9BjphVlORudHbWUtX
         GvUm3eUuF2PYhqZrUdSR+QmEaZM1jIABRS+cv2drgn7oXrLDCRvNjfGWmt3qMSR72dai
         uKY41mPzh5yXAv6F4v2H2eRK0078tOvWaXmiG1CAcKPh1lJ73oea6pI9hpwj/946OdIs
         6GBA==
X-Gm-Message-State: AOJu0YyVGU/9dh8/QZ5T2IHQ+l/frounoQrWXLwtEREtc4UjEIUP+fMR
        QwE7IrG5GFy66jOSmxDYwAJmtSRBGSN3ZdCeyS4TlabtdlR3nSnZye03Ow==
X-Google-Smtp-Source: AGHT+IFLci1Gh1vs2mE7QDtLKQZUE/TQg6gUZQiUYohfckoWuwQf41Nn3O2H4gd3T/hi9Q7bQvnRj2aLWQNjtTHhaXs=
X-Received: by 2002:a17:906:5a5f:b0:9a5:9305:83fb with SMTP id
 my31-20020a1709065a5f00b009a5930583fbmr100497ejc.34.1694734294841; Thu, 14
 Sep 2023 16:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <CALvZod6j5E2MXFz463LRcrP6XY8FedzLUKW88c=ZY39B6mYyMA@mail.gmail.com>
 <CAJD7tkbb5zxEPSW6vvijDpQKCZiDcUJqe8SPvLHfo0RX7iHXAw@mail.gmail.com> <20230914225844.woz7mke6vnmwijh7@google.com>
In-Reply-To: <20230914225844.woz7mke6vnmwijh7@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Sep 2023 16:30:56 -0700
Message-ID: <CAJD7tkb_pDxqqhB25aZpbfur=YodBRb1nmdpNZt1DB_1ozDpPQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 3:58=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Sep 14, 2023 at 10:56:52AM -0700, Yosry Ahmed wrote:
> [...]
> > >
> > > 1. How much delayed/stale stats have you observed on real world workl=
oad?
> >
> > I am not really sure. We don't have a wide deployment of kernels with
> > rstat yet. These are problems observed in testing and/or concerns
> > expressed by our userspace team.
> >
>
> Why sleep(2) not good enough for the tests?

The problem is not making the tests pass. The tests are just a signal.

>
> > I am trying to solve this now because any problems that result from
> > this staleness will be very hard to debug and link back to stale
> > stats.
> >
>
> I think first you need to show if this (2 sec stale stats) is really a
> problem.

That's the thing, my main concern is that if this causes a problem, we
probably won't be able to tell it was because of stale stats. It's
very hard to make that connection.

Pre-rstat, reading stats would always yield fresh stats (as much as
possible). Now the stats can be up to 2s stale, and we don't really
know how this will affect our existing workloads.

>
> > >
> > > 2. What is acceptable staleness in the stats for your use-case?
> >
> > Again, unfortunately I am not sure, but right now it can be O(seconds)
> > which is not acceptable as we have workloads querying the stats every
> > 1s (and sometimes more frequently).
> >
>
> It is 2 seconds in most cases and if it is higher, the system is already
> in bad shape. O(seconds) seems more dramatic. So, why 2 seconds
> staleness is not acceptable? Is 1 second acceptable? or 500 msec? Let's
> look at the use-cases below.
>
> > >
> > > 3. What is your use-case?
> >
> > A few use cases we have that may be affected by this:
> > - System overhead: calculations using memory.usage and some stats from
> > memory.stat. If one of them is fresh and the other one isn't we have
> > an inconsistent view of the system.
> > - Userspace OOM killing: We use some stats in memory.stat to gauge the
> > amount of memory that will be freed by killing a task as sometimes
> > memory.usage includes shared resources that wouldn't be freed anyway.
> > - Proactive reclaim: we read memory.stat in a proactive reclaim
> > feedback loop, stale stats may cause us to mistakenly think reclaim is
> > ineffective and prematurely stop.
> >
>
> I don't see why userspace OOM killing and proactive reclaim need
> subsecond accuracy. Please explain.

For proactive reclaim it is not about sub-second accuracy. It is about
doing the reclaim then reading the stats immediately to see the
effect. Naturally one would expect that a stat read after reclaim
would show the system state after reclaim.

For userspace OOM killing I am not really sure. It depends on how
dynamic the workload is. If a task recently had a spike in memory
usage causing a threshold to be hit, userspace can kill a different
task if the stats are stale.

I think the whole point is *not* about the amount of staleness. It is
more about that you expect a stats read after an event to reflect the
system state after the event. Whether this event is proactive reclaim
or a spike in memory usage or something else.

As Tejun mentioned previously [1]: "The only guarantee you need is
that there has been at least one flush since
the read attempt started".

[1]https://lore.kernel.org/lkml/ZP92xP5rdKdeps7Z@mtj.duckdns.org/

> Same for system overhead but I can
> see the complication of two different sources for stats. Can you provide
> the formula of system overhead? I am wondering why do you need to read
> stats from memory.stat files. Why not the memory.current of top level
> cgroups and /proc/meminfo be enough. Something like:
>
> Overhead =3D MemTotal - MemFree - SumOfTopCgroups(memory.current)

We use the amount of compressed memory in zswap from memory.stat,
which is not accounted as memory usage in cgroup v1.

>
> > >
> > > I know I am going back on some of the previous agreements but this
> > > whole locking back and forth has made in question the original
> > > motivation.
> >
> > That's okay. Taking a step back, having flushing being indeterministic
>
> I would say atmost 2 second stale instead of indeterministic.

Ack.

>
> > in this way is a time bomb in my opinion. Note that this also affects
> > in-kernel flushers like reclaim or dirty isolation
>
> Fix the in-kernel flushers separately.

The in-kernel flushers are basically facing the same problem. For
instance, reclaim would expect a stats read after a reclaim iteration
to reflect the system state after the reclaim iteration.

> Also the problem Cloudflare is facing does not need to be tied with this.

When we try to wait for flushing to complete we run into the same
latency problem of the root flush.
