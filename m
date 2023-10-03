Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9559E7B6DB0
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbjJCP7u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjJCP7s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 11:59:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F7E0
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 08:59:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-668ebbcc0b6so7036366d6.0
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696348772; x=1696953572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9u6M/qg0tY6l2Kd5bsxAtI2pU7AK646ndJLozYLDOY=;
        b=RxnqM2rctBvIne417JHVEVWEdV+SP+0ZxG55fpPTPq04SuETvDMDeyxh3G/ZRjnsiR
         Su7gWpdiglr2NABUjLSFpjzE0AdkcMdczdF677s9VPPpGevxJCwTQBaqQb4TwE4uzdK1
         4mSXYsqHW6tqQrcn9h5hd19/ZXspEZb+l167cO8mnG9OB5w3vmGFfQueH9TLL0kGNT7R
         emLbnKqqhQiuaLEQD7iSRUhfkWA6TlRU4oA58yeJjoPSRczkMLUFUaFIeWSwJdqhIrc4
         PDvHowfNnx1XmJ5U9sVedKABNQ+KkIMdG6jtdc5BevnHv6dJM2qZXtWIuN22XFxXborV
         9Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348772; x=1696953572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9u6M/qg0tY6l2Kd5bsxAtI2pU7AK646ndJLozYLDOY=;
        b=HBFSGkEzF+Sn/Hb3dNckJOCrU1QhvtRID7o9kD6ZjlgiwelAEM0tG9KA+vbvcrwm3o
         JUPldLD5KFrNC8uk83BC7MFbKKsfNdGvawnzVNkQulezOwP2FUVB79ccCaF3mVELky1z
         hKjNeVWpo6dp/FodhkTLZwRa1gzO0/e7IrF9zULH9UJzhkmHcP/vs5elrZusCUQCaElT
         KYY40yIwEgWi0e99riwnQ8Mrqm3QNrM/zqJlPJrq5OxuT7socDRV9Sox9YH3w+XzBQuw
         HX9FJmK/1i/HCU1+BGqhsrrRcWPo3P1npo0x5DBPSMVYc1siXE5+NzOEd2D1fAEWclNm
         qLCA==
X-Gm-Message-State: AOJu0YyPTQ3myFcRUY/Md9TEeJTR2ryhZMoAe7tNiMj268tdQ2KbHvNM
        8ngVOO3gtRST2KM+vIZGQQQ8b+ATlriWFAEStfs=
X-Google-Smtp-Source: AGHT+IHqGr4J+qukUaSisJrYlEvvxoW/auCoCxrT+jkY3iF56XKG6U4RM8wS4bSzjDtmCxHmSD3aRw==
X-Received: by 2002:a0c:a9db:0:b0:655:71df:4c7d with SMTP id c27-20020a0ca9db000000b0065571df4c7dmr14977510qvb.56.1696348772174;
        Tue, 03 Oct 2023 08:59:32 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0065862497fd2sm591100qvm.22.2023.10.03.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:59:31 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:59:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231003155931.GF17012@cmpxchg.org>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
 <ZRwQEv62Ex4+H2CZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwQEv62Ex4+H2CZ@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 03, 2023 at 02:58:58PM +0200, Michal Hocko wrote:
> On Mon 02-10-23 17:18:27, Nhat Pham wrote:
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> > 
> > For instance, here is one of our usecases: suppose there are two 32G
> > containers. The machine is booted with hugetlb_cma=6G, and each
> > container may or may not use up to 3 gigantic page, depending on the
> > workload within it. The rest is anon, cache, slab, etc. We can set the
> > hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness.
> > But it is very difficult to configure memory.max to keep overall
> > consumption, including anon, cache, slab etc. fair.
> > 
> > What we have had to resort to is to constantly poll hugetlb usage and
> > readjust memory.max. Similar procedure is done to other memory limits
> > (memory.low for e.g). However, this is rather cumbersome and buggy.
> 
> Could you expand some more on how this _helps_ memory.low? The
> hugetlb memory is not reclaimable so whatever portion of its memcg
> consumption will be "protected from the reclaim". Consider this
> 	      parent
> 	/		\
>        A		 B
>        low=50%		 low=0
>        current=40%	 current=60%
> 
> We have an external memory pressure and the reclaim should prefer B as A
> is under its low limit, correct? But now consider that the predominant
> consumption of B is hugetlb which would mean the memory reclaim cannot
> do much for B and so the A's protection might be breached.
> 
> As an admin (or a tool) you need to know about hugetlb as a potential
> contributor to this behavior (sure mlocked memory would behave the same
> but mlock rarely consumes huge amount of memory in my experience).
> Without the accounting there might not be any external pressure in the
> first place.
> 
> All that being said, I do not see how adding hugetlb into accounting
> makes low, min limits management any easier.

It's important to differentiate the cgroup usecases. One is of course
the cloud/virtual server scenario, where you set the hard limits to
whatever the customer paid for, and don't know and don't care about
the workload running inside. In that case, memory.low and overcommit
aren't really safe to begin with due to unknown unreclaimable mem.

The other common usecase is the datacenter where you run your own
applications. You understand their workingset and requirements, and
configure and overcommit the containers in a way where jobs always
meet their SLAs. E.g. if multiple containers spike, memory.low is set
such that interactive workloads are prioritized over batch jobs, and
both have priority over routine system management tasks.

This is arguably the only case where it's safe to use memory.low. You
have to know what's reclaimable and what isn't, otherwise you cannot
know that memory.low will even do anything, and isolation breaks down.
So we already have that knowledge: mlocked sections, how much anon is
without swap space, and how much memory must not be reclaimed (even if
it is reclaimable) for the workload to meet its SLAs. Hugetlb doesn't
really complicate this equation - we already have to consider it
unreclaimable workingset from an overcommit POV on those hosts.

The reason this patch helps in this scenario is that the service teams
are usually different from the containers/infra team. The service
understands their workload and declares its workingset. But it's the
infra team running the containers that currently has to go and find
out if they're using hugetlb and tweak the cgroups. Bugs and
untimeliness in the tweaking have caused multiple production incidents
already. And both teams are regularly confused when there are large
parts of the workload that don't show up in memory.current which both
sides monitor. Keep in mind that these systems are already pretty
complex, with multiple overcommitted containers and system-level
activity. The current hugetlb quirk can heavily distort what a given
container is doing on the host.

With this patch, the service can declare its workingset, the container
team can configure the container, and memory.current makes sense to
everybody. The workload parameters are pretty reliable, but if the
service team gets it wrong and we underprotect the workload, and/or
its unreclaimable memory exceeds what was declared, the infra team
gets alarms on elevated LOW breaching events and investigates if its
an infra problem or a service spec problem that needs escalation.

So the case you describe above only happens when mistakes are made,
and we detect and rectify them. In the common case, hugetlb is part of
the recognized workingset, and we configure memory.low to cut off only
known optional and reclaimable memory under pressure.
