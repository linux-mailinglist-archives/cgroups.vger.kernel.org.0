Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034397A12AC
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 03:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjIOBBq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIOBBp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 21:01:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780FD1FE8
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 18:01:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59224c40275so21113777b3.3
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694739700; x=1695344500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJTS4bFwxQYCp+W2QwuD6ymPLJmZK+oQFYtEHbQSJpI=;
        b=CQzisWFX8Q5XtrDFza1+V28zemiMBfXMSKzjy4iODIdwnQTPmhtQu4gUb6PNavwYPV
         JCJAvwD2Q/DOb2AqTUlGReIWajG4L/XC3sF+wRcA54s4/IKCfkXH+GSqdmtQ8krAOSnT
         7UWk8cBh7HrybfJi3w0z52fP07NduP28rzI8Lz9Q+jQhZ+S15F2z+VPNjsSNaUzDYz7b
         ThXogwlGaTXLncK39Fvoxe2wi5WmCDvUMt27Uyc9IqxMzu0/SnuHAizARCJ66a5pZ5s2
         8/ZoWofVKskT7Rq/ico6cjaXn2e1+o+C6C4/nEVVfOizbl9f/RiKIkKp3ConkNu2QmsG
         g9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694739700; x=1695344500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJTS4bFwxQYCp+W2QwuD6ymPLJmZK+oQFYtEHbQSJpI=;
        b=DIu+U7BHwtX5d7K6/HQNki3jFXYyAraDg5dlYn/SGSENLYYqrvQ75OxcgpOdui8kWD
         0cOBGWAYq6mGuL5dF+rkXJi7vS5/wUuS3Aiw/fIOeA3dhldDeFvK0azDLJOCTAM0mIZM
         rnomhkfVT2apyZPtm7FFNmTSHq0tfqdMlcco5GpsszWE66EhHh3O7zcHlZLz6UwLUKLE
         5tVjUssEVMxvcGCg5gJuOPRhk4MamYTNHqUSsiJp7mrSXxLUAha8QdtCAVR8h3QGasf/
         b44EjdZxuro0wTG2AA1dATIrLzF5fpgrihJ4Psdt0LKh44itSMddaxbnahcTzxTOJTp0
         8eNw==
X-Gm-Message-State: AOJu0YyZHTQxLEFlup6jw2bpPKuW/sis0PqVeG2UIUcbUDtPzsuUbyC2
        QMOe4ECV1EGrl4vBiye5cmWLxTm04pw2Vg==
X-Google-Smtp-Source: AGHT+IEOzNRqkRYibXlHELNPk8FpKvyyeMfe2dmvHS4Me7k5V6CAZqzDONlvIYAGQvm00TP+p53hfu2Ftv+D0g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:b21b:0:b0:d81:908f:6f99 with SMTP id
 i27-20020a25b21b000000b00d81908f6f99mr3035ybj.5.1694739700642; Thu, 14 Sep
 2023 18:01:40 -0700 (PDT)
Date:   Fri, 15 Sep 2023 01:01:38 +0000
In-Reply-To: <CAJD7tkb_pDxqqhB25aZpbfur=YodBRb1nmdpNZt1DB_1ozDpPQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <CALvZod6j5E2MXFz463LRcrP6XY8FedzLUKW88c=ZY39B6mYyMA@mail.gmail.com>
 <CAJD7tkbb5zxEPSW6vvijDpQKCZiDcUJqe8SPvLHfo0RX7iHXAw@mail.gmail.com>
 <20230914225844.woz7mke6vnmwijh7@google.com> <CAJD7tkb_pDxqqhB25aZpbfur=YodBRb1nmdpNZt1DB_1ozDpPQ@mail.gmail.com>
Message-ID: <20230915010138.knjli6ovpozxbpss@google.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 04:30:56PM -0700, Yosry Ahmed wrote:
[...]
> >
> > I think first you need to show if this (2 sec stale stats) is really a
> > problem.
> 
> That's the thing, my main concern is that if this causes a problem, we
> probably won't be able to tell it was because of stale stats. It's
> very hard to make that connection.
> 

Please articulate what the problem would look like which you did in the
use-cases description below, let's discuss there.

> Pre-rstat, reading stats would always yield fresh stats (as much as
> possible). Now the stats can be up to 2s stale, and we don't really
> know how this will affect our existing workloads.
> 

Pre-rstat the stat read would traverse the memcg tree. With rstat
the tradeoff was made between expensive read and staleness.
Yeah there
might still be memcg update tree traversal which I would like to remove
completely. However you are saying to 

[...]
> >
> > I don't see why userspace OOM killing and proactive reclaim need
> > subsecond accuracy. Please explain.
> 
> For proactive reclaim it is not about sub-second accuracy. It is about
> doing the reclaim then reading the stats immediately to see the
> effect. Naturally one would expect that a stat read after reclaim
> would show the system state after reclaim.
> 
> For userspace OOM killing I am not really sure. It depends on how
> dynamic the workload is. If a task recently had a spike in memory
> usage causing a threshold to be hit, userspace can kill a different
> task if the stats are stale.
> 

Please add above reasoning in your commit message (though I am not
convinced but let's leave it at that).

> I think the whole point is *not* about the amount of staleness. It is
> more about that you expect a stats read after an event to reflect the
> system state after the event.

The whole point is to understand the tradeoff between accuracy and cost
of accuracy. I don't think you want to pay the cost of strong
consistency/ordering between stats reading and an event. My worry is
that you are enforcing a tradeoff which *might* be just applicable to
your use-cases. Anyways this is not something that can not be changed
later.

> 
> > Same for system overhead but I can
> > see the complication of two different sources for stats. Can you provide
> > the formula of system overhead? I am wondering why do you need to read
> > stats from memory.stat files. Why not the memory.current of top level
> > cgroups and /proc/meminfo be enough. Something like:
> >
> > Overhead = MemTotal - MemFree - SumOfTopCgroups(memory.current)
> 
> We use the amount of compressed memory in zswap from memory.stat,
> which is not accounted as memory usage in cgroup v1.
> 

There are zswap stats in /proc/meminfo. Will those work for you?

[...]
> > Fix the in-kernel flushers separately.
> 
> The in-kernel flushers are basically facing the same problem. For
> instance, reclaim would expect a stats read after a reclaim iteration
> to reflect the system state after the reclaim iteration.
> 

I have not seen any complains on memory reclaim recently. Maybe
reclaim does not really need that such accuracy :P

> > Also the problem Cloudflare is facing does not need to be tied with this.
> 
> When we try to wait for flushing to complete we run into the same
> latency problem of the root flush.

Not sure what wait for flushing has to do with Cloudflare's report. They
are ok with no sync flushing at all stat read.
