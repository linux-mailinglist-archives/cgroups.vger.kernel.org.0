Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76206F8988
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjEETbj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjEETbL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 15:31:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D55FE2;
        Fri,  5 May 2023 12:31:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64389a44895so1888967b3a.1;
        Fri, 05 May 2023 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683315064; x=1685907064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVSEn0zAZchU0XRfzSqIlgEVmcktBBmYwcVkhQoE8m0=;
        b=NYCDjIhbaqBiOSrZ/jgxJYM++MvXfz+PziXmSOtlKBWR+5G4THFS2J6lKMYUL1ZtQp
         /+n4GUaL/F1C/Hv7nTbtNqmpV5z7VXvQWx9UHrXUzwrHiw35fgnlVMsX4I0PBAgfwjUG
         2ooHt7ZJh9wgSGvg/SHA6DtoJe/kiJ3Goxylyyfi6fMcMRmKbUeOvYZthBVzGkBWoj9k
         uJVgHOEUm/rNXBynMU5Y//6lgXN9sg3cgtVtBR10M3kAWppabMcp+hGVLYpdWeVHjVxM
         ZN1GgSLgrsNe6E6j4l34bTX+odwC3ez7lEInB6MbvS/FpUYjCDfl5Hx8sxVirIb5x3N4
         kDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315064; x=1685907064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVSEn0zAZchU0XRfzSqIlgEVmcktBBmYwcVkhQoE8m0=;
        b=BSV+aYjbMY+aZSPnYP/WXfNr7KMqVR6eIvx7PdnfpUVxG5MSBB8+yud2qzcIR3x0m1
         uyqUZRurayZHB7MPQMflUTte6dpqihtui5kETLiuzbLQw/8QuMqXxWxTzJyc9SJCI4yq
         sQwGq9xgOTFimc/3w/0JvYbvs5huQTHvJQEk9aRVqItT/VsWeul4Y4yhxIzMqqStbF+/
         CWY43WFb2aISHhoQhKyDUGudtNAlcYb1XMUCdpFJ6AAIDAHY4bUdpD+5igDUIHTKIotI
         XWlqb8U1gIqtPlLkcaACJd5QiTyKZhMjDWkZghU1tzsA/4gqn3WOGX/UTJK/cNw+77Tz
         egqQ==
X-Gm-Message-State: AC+VfDzxlxPTzIcNg4Kw4nQh/uRrnRdVwcP36gXOAd24L/T0s0cj4Lck
        fYHIZIE8HQ2s8mIV2igfgEw=
X-Google-Smtp-Source: ACHHUZ5Ox2/rwuw44nA8yVDCYWqWPSKjPRPFOf73NgI1WWFm1SFU3RHfe3Zukjpsitt3RMd6eal9YA==
X-Received: by 2002:a05:6a20:6a22:b0:f2:bb3f:3b3e with SMTP id p34-20020a056a206a2200b000f2bb3f3b3emr3501654pzk.38.1683315063529;
        Fri, 05 May 2023 12:31:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n1-20020a63ee41000000b0050f7208b4bcsm1976619pgk.89.2023.05.05.12.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:31:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 09:31:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Message-ID: <ZFVZdbdZTLGhqYp4@slm.duckdns.org>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230504062525.GF1734100@hirez.programming.kicks-ass.net>
 <ZFNqJf+BQ0GMdr+y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFNqJf+BQ0GMdr+y@localhost.localdomain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 04, 2023 at 10:17:41AM +0200, Juri Lelli wrote:
> On 04/05/23 08:25, Peter Zijlstra wrote:
> > On Wed, May 03, 2023 at 09:22:22AM +0200, Juri Lelli wrote:
> > 
> > > Dietmar Eggemann (2):
> > >   sched/deadline: Create DL BW alloc, free & check overflow interface
> > >   cgroup/cpuset: Free DL BW in case can_attach() fails
> > > 
> > > Juri Lelli (4):
> > >   cgroup/cpuset: Rename functions dealing with DEADLINE accounting
> > >   sched/cpuset: Bring back cpuset_mutex
> > >   sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
> > >   cgroup/cpuset: Iterate only if DEADLINE tasks are present
> > > 
> > >  include/linux/cpuset.h  |  12 +-
> > >  include/linux/sched.h   |   4 +-
> > >  kernel/cgroup/cgroup.c  |   4 +
> > >  kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
> > >  kernel/sched/core.c     |  41 +++----
> > >  kernel/sched/deadline.c |  67 ++++++++---
> > >  kernel/sched/sched.h    |   2 +-
> > >  7 files changed, 244 insertions(+), 128 deletions(-)
> > 
> > Aside from a few niggles, these look fine to me. Who were you expecting
> > to merge these, tj or me?
> 
> Thanks for reviewing!
> 
> Not entirely sure, it's kind of split, but maybe the cgroup changes are
> predominant (cpuset_mutex is probably contributing the most). So, maybe
> tj? Assuming this looks good to him as well of course. :)

Yeah, they all look sane to me and both Waiman and Peter seem okay with
them. If you post an updated version with the minor suggestions applied,
I'll route the series through the cgroup tree.

Thanks.

-- 
tejun
