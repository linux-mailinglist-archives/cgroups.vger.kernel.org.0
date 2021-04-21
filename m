Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15255366D62
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhDUN6b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbhDUN6a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 09:58:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985CC06138A
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 06:57:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l22so40470943ljc.9
        for <cgroups@vger.kernel.org>; Wed, 21 Apr 2021 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzUt8X/WzmqyiQTQOb09ZoIGFmeYojo8TKKWXg5zRNc=;
        b=mjoh/M3C5zXaRixBaiMGh8FW3jbxldonTsAzJ77oVizAjeOQHKGQiC3i75Wu1umZhX
         RchEyUx3ji5vKetnRRp26j8o1NQ2RDmlT0MDgmHTFqrnIHTNRA2hOPGLJSlBZ96jGVKf
         571gU2R/TArQpNfCLUqywHzxY8P+cvMHYJLT1l3UwzGQBXFPMDEgJCSCblnavYn8A5bO
         JXVBkSCY3RsQl8DJcCt2LB/rX6BfDfUMqitdJacy+e9UK6xr1L491vhp2P7k43GWQnVa
         XgkwX1mnEErizRWbJD2VriTjvK5e1upblqP8QOGLtZ4cRNo9253JqHD+ovek+QYElz8G
         tJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzUt8X/WzmqyiQTQOb09ZoIGFmeYojo8TKKWXg5zRNc=;
        b=AUAxBfb3c1PZbNvjlbn64cBjWOrsd84/Ye8UW1zxVbN/0nsOBJ3QuqMUvP4FFiQFe5
         iceRjQIKkuRZSMiCaVXZjRjhXHFMF1ET/mDs5S5OULbRGk6QppaJCmePWLb3fAvT81vi
         XxsuBrsYSR4hXubGhIm/SV837jn/xv35jCtorTzyYzCRzMyNLKRzVjnVFnJ+V5VEpUdn
         KShqimwMPMXhy7c7hyPePBMO2+RvioJpNbIDRXS5bf01b3JhHoeELQOlp32ak2E/zvui
         DWt78PtKUuBNTRiU6FeaOhDGuisNDNR0veonrnP5U/j6iwSDeo49xU5VpPoduMrEyby+
         Wb6A==
X-Gm-Message-State: AOAM532QrO653KQT+v/q7/aqn8DYkFxlfpe0e7+l4y85F2ErCyDm8Rpf
        WMoG1EYryToxXUCYS8V+hqPORCVUvRosxcQVYLyTFA==
X-Google-Smtp-Source: ABdhPJx1Lm56U6Iaz2d/ewarjkjUGkr/8pRTih0VFjqY53M8ShQv8y5HDqr7v1iWjgb9Db+DYtrST3iPQEA9mNdFn3o=
X-Received: by 2002:a2e:8118:: with SMTP id d24mr18609060ljg.122.1619013475253;
 Wed, 21 Apr 2021 06:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz> <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz>
In-Reply-To: <YH/RPydqhwXdyG80@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 06:57:43 -0700
Message-ID: <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 21, 2021 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > To decide when to kill, the oom-killer has to read a lot of metrics.
> > It has to open a lot of files to read them and there will definitely
> > be new allocations involved in those operations. For example reading
> > memory.stat does a page size allocation. Similarly, to perform action
> > the oom-killer may have to read cgroup.procs file which again has
> > allocation inside it.
>
> True but many of those can be avoided by opening the file early. At
> least seq_file based ones will not allocate later if the output size
> doesn't increase. Which should be the case for many. I think it is a
> general improvement to push those who allocate during read to an open
> time allocation.
>

I agree that this would be a general improvement but it is not always
possible (see below).

> > Regarding sophisticated oom policy, I can give one example of our
> > cluster level policy. For robustness, many user facing jobs run a lot
> > of instances in a cluster to handle failures. Such jobs are tolerant
> > to some amount of failures but they still have requirements to not let
> > the number of running instances below some threshold. Normally killing
> > such jobs is fine but we do want to make sure that we do not violate
> > their cluster level agreement. So, the userspace oom-killer may
> > dynamically need to confirm if such a job can be killed.
>
> What kind of data do you need to examine to make those decisions?
>

Most of the time the cluster level scheduler pushes the information to
the node controller which transfers that information to the
oom-killer. However based on the freshness of the information the
oom-killer might request to pull the latest information (IPC and RPC).

[...]
> >
> > I was thinking of simply prctl(SET_MEMPOOL, bytes) to assign mempool
> > to a thread (not shared between threads) and prctl(RESET_MEMPOOL) to
> > free the mempool.
>
> I am not a great fan of prctl. It has become a dumping ground for all
> mix of unrelated functionality. But let's say this is a minor detail at
> this stage.

I agree this does not have to be prctl().

> So you are proposing to have a per mm mem pool that would be

I was thinking of per-task_struct instead of per-mm_struct just for simplicity.

> used as a fallback for an allocation which cannot make a forward
> progress, right?

Correct

> Would that pool be preallocated and sitting idle?

Correct

> What kind of allocations would be allowed to use the pool?

I was thinking of any type of allocation from the oom-killer (or
specific threads). Please note that the mempool is the backup and only
used in the slowpath.

> What if the pool is depleted?

This would mean that either the estimate of mempool size is bad or
oom-killer is buggy and leaking memory.

I am open to any design directions for mempool or some other way where
we can provide a notion of memory guarantee to oom-killer.

thanks,
Shakeel
