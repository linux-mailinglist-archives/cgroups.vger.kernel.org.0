Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A997AF69C
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIZXOK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 19:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIZXMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 19:12:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D998902F
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 15:14:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41814760ae1so37159401cf.1
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695766455; x=1696371255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V6U1BTUAT6DClxkN/2UVfkrSLiqNT4sEy4cS5lEl9ps=;
        b=CSkrKF+cDxyYGpB93kbQ70HndznsODtdMTE//q9fjZsAOPZSCfW8X1MA9uJnSw2L1e
         25lRm+Fus/uakIOH2SBK8TGlUR3rUVjPnpN3ukWroWgKgfBYJf1INVKqLbpApx3ZSMIW
         /cjsO9TB+ba+xUCZm6EtmHN1iCgdW5MS55ehNFS00IqWin8nvXKgMDbxXc4XcOSAfNJz
         or2Z/kmfR/ZDVj+q1bdC3AmcK+W4w35GC6qLzkrEC+lfaj0oNFUWfeeMyaMOXxdA7AyP
         52ofFnogLUTgKnyn3CJ+/8xscXTejSvZe1gqvQOF4oZ4sW0Lei0rKT0cDShrdxD/LFOX
         gRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695766455; x=1696371255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6U1BTUAT6DClxkN/2UVfkrSLiqNT4sEy4cS5lEl9ps=;
        b=g0B/4vCIulKEIXPJvGbIb9+GVrfmqBBUBa2oFNDs74l/7u2was+8DSNN7OPWYkvTaP
         fgyHowz/yHNG3E+EU9ivKjJgdAByOGHOFNvcjTdQz2oM60dYA9Vy2Mbztfycct/n//Ky
         E0cYaCXByJ3KVaxI251Okh1Qf2vEWOyKFtuJBm1F/a3oEDq+Tl6Xry31fyI/AZ6dap8W
         r14OedcUu91hg8N7eczMluTOBwwC1uxEe1wNygHj8JngjLW3+ngHgwSAwmMUd1i0YEFk
         VXN4mzEywRcHWmhfdqDYY9Xa6lsp3JaFbMn318HlTftokn1ydSXeARCAaGl1Ac2oNLET
         aOiw==
X-Gm-Message-State: AOJu0YxORHIY5rTXctwVhFgP32ydB7QUTeqDBnEiI1rgOGrnZfs+YF6R
        FBwPQKsUqubnej1l5hHync0pJg==
X-Google-Smtp-Source: AGHT+IHuFcm42Gy+fzyBeHYAYQ1YUWMoy9PZVM4+bSjc4g9c6JzrZSykDY5b9grfk1BkFubXWT3+Xw==
X-Received: by 2002:ac8:5796:0:b0:412:1e4c:e858 with SMTP id v22-20020ac85796000000b004121e4ce858mr157531qta.36.1695766455534;
        Tue, 26 Sep 2023 15:14:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id br22-20020a05622a1e1600b004108c610d08sm4992236qtb.32.2023.09.26.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 15:14:15 -0700 (PDT)
Date:   Tue, 26 Sep 2023 18:14:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Frank van der Linden <fvdl@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, mike.kravetz@oracle.com,
        yosryahmed@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20230926221414.GD348484@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWY8eDSa1qKx35hTm5ef+e13SDnRHDrevc-1V1v7-pEP3w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Frank,

On Tue, Sep 26, 2023 at 01:50:10PM -0700, Frank van der Linden wrote:
> On Tue, Sep 26, 2023 at 12:49 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> >
> > This patch series rectifies this issue by charging the memcg when the
> > hugetlb folio is allocated, and uncharging when the folio is freed. In
> > addition, a new selftest is added to demonstrate and verify this new
> > behavior.
> >
> > Nhat Pham (2):
> >   hugetlb: memcg: account hugetlb-backed memory in memory controller
> >   selftests: add a selftest to verify hugetlb usage in memcg
> >
> >  MAINTAINERS                                   |   2 +
> >  fs/hugetlbfs/inode.c                          |   2 +-
> >  include/linux/hugetlb.h                       |   6 +-
> >  include/linux/memcontrol.h                    |   8 +
> >  mm/hugetlb.c                                  |  23 +-
> >  mm/memcontrol.c                               |  40 ++++
> >  tools/testing/selftests/cgroup/.gitignore     |   1 +
> >  tools/testing/selftests/cgroup/Makefile       |   2 +
> >  .../selftests/cgroup/test_hugetlb_memcg.c     | 222 ++++++++++++++++++
> >  9 files changed, 297 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> >
> > --
> > 2.34.1
> >
> 
> We've had this behavior at Google for a long time, and we're actually
> getting rid of it. hugetlb pages are a precious resource that should
> be accounted for separately. They are not just any memory, they are
> physically contiguous memory, charging them the same as any other
> region of the same size ended up not making sense, especially not for
> larger hugetlb page sizes.

I agree that on one hand they're a limited resource, and some form of
access control makes sense. There is the hugetlb cgroup controller
that allows for tracking and apportioning them per-cgroups.

But on the other hand they're also still just host memory that a
cgroup can consume, which is the domain of memcg.

Those two aren't mutually exclusive. It makes sense to set a limit on
a cgroup's access to hugetlb. It also makes sense that the huge pages
a cgroup IS using count toward its memory limit, where they displace
file cache and anonymous pages under pressure. Or that they're
considered when determining degree of protection from global pressure.

This isn't unlike e.g. kernel memory being special in that it consumes
lowmem and isn't reclaimable. This shows up in total memory, while it
was also tracked and limited separately. (Separate control disappeared
for lack of a good enforcement mechanism - but hugetlb has that.)

The fact that memory consumed by hugetlb is currently not considered
inside memcg (host memory accounting and control) is inconsistent. It
has been quite confusing to our service owners and complicating things
for our containers team.

For example, jobs need to describe their overall memory size in order
to match them to machines and co-locate them. Based on that parameter
the container limits as well as protection (memory.low) from global
pressure is set. Currently, there are ugly hacks in place to subtract
any hugetlb quota from the container config - otherwise the limits and
protection settings would be way too big if a large part of the host
memory consumption isn't a part of it. This has been quite cumbersome
and error prone.

> Additionally, if this behavior is changed just like that, there will
> be quite a few workloads that will break badly because they'll hit
> their limits immediately - imagine a container that uses 1G hugetlb
> pages to back something large (a database, a VM), and 'plain' memory
> for control processes.

I agree with you there. This could break existing setups. We've added
new consumers to memcg in the past without thinking too hard about it,
but hugetlb often makes up a huge portion of a group's overall memory
footprint. And we *do* have those subtraction hacks in place that
would then fail in the other direction.

A cgroup mountflag makes sense for this to ease the transition.
