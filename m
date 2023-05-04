Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D096F673C
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjEDIZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEDIZR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 04:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802E4C0B
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683188269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Crz7SVqLScSwCZtKT1O0mIOH4ecEo3dE2+AhPDuZk1M=;
        b=A5OpTG9qfRRJBZbEvQE9vw//p98yQcMROL0UDDloQzVeE30peqIumY63Ui7CcLhaSE8bw4
        ChevWVwALne7n9w/V4/lhmLtlp4hZDxZAZOYP0bA8qC1wW1SuSy9pQKIM4k0IaIP46Z92E
        93t39G4asQLHmhiR51Zmg9wTMgyX+ZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-1-6CZsbGNpGDZjSuP0-jDg-1; Thu, 04 May 2023 04:17:48 -0400
X-MC-Unique: 1-6CZsbGNpGDZjSuP0-jDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f348182ffcso1081995e9.3
        for <cgroups@vger.kernel.org>; Thu, 04 May 2023 01:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188266; x=1685780266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crz7SVqLScSwCZtKT1O0mIOH4ecEo3dE2+AhPDuZk1M=;
        b=VGsHCGaBVTXwkKADdazM8DWXOEsC9bxs8YjEyPs0ywoOuEG5qI/dFtAyFWSseMcTs4
         cW7smTvxubGwgvKZxoYTwDP79GDVofbQlKpbTphcqmUKqKxdWNHfg9TFWapkfAh7O3wl
         mrIVjGbnFrby3nXot1h2QOqnn65S2vmzEy0PS+9izGFxnGguhZXXG9xPRrPv62ujzgqy
         A1qvMfMxI0N3y6N+4eEmawzCO4QfopBmxSNUO5AutiW1Aurq+zFveBKNpIZCg9bMfDEa
         i6RcLvXBXeyISqTU0AkDTSDZ0e1kFrqoEDQFDiAUwU99jflZQnEM4AZl97nh61m8CGds
         sgjQ==
X-Gm-Message-State: AC+VfDxtXb71kZlj6Lgi4yP+Yjx15jqLJkLAgIgM3CXXe8xWD+63CKIB
        tCnf4wWr93ZrQtv2a2UaoufTsupxDf4x2ni+prqRDjPK5jL24ia1X4cTGJYzhPdrZ2mlC2cxoUi
        LcoUz6+VhIZkPPnJ5RA==
X-Received: by 2002:a1c:f706:0:b0:3f2:5028:a54d with SMTP id v6-20020a1cf706000000b003f25028a54dmr16070654wmh.0.1683188266676;
        Thu, 04 May 2023 01:17:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ygZA0+8BWMej52snss9QosIIaPxtfMMgRoAO9qgdZm3GDEZS/f3ULO0hISpI8k0QQ8dyENg==
X-Received: by 2002:a1c:f706:0:b0:3f2:5028:a54d with SMTP id v6-20020a1cf706000000b003f25028a54dmr16070625wmh.0.1683188266284;
        Thu, 04 May 2023 01:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:b121:8011:79a:2d6b:5410:3927:2f38])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4bc7000000b002fefe2edb72sm35979993wrt.17.2023.05.04.01.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:17:45 -0700 (PDT)
Date:   Thu, 4 May 2023 10:17:41 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <ZFNqJf+BQ0GMdr+y@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230504062525.GF1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504062525.GF1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/05/23 08:25, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 09:22:22AM +0200, Juri Lelli wrote:
> 
> > Dietmar Eggemann (2):
> >   sched/deadline: Create DL BW alloc, free & check overflow interface
> >   cgroup/cpuset: Free DL BW in case can_attach() fails
> > 
> > Juri Lelli (4):
> >   cgroup/cpuset: Rename functions dealing with DEADLINE accounting
> >   sched/cpuset: Bring back cpuset_mutex
> >   sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
> >   cgroup/cpuset: Iterate only if DEADLINE tasks are present
> > 
> >  include/linux/cpuset.h  |  12 +-
> >  include/linux/sched.h   |   4 +-
> >  kernel/cgroup/cgroup.c  |   4 +
> >  kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
> >  kernel/sched/core.c     |  41 +++----
> >  kernel/sched/deadline.c |  67 ++++++++---
> >  kernel/sched/sched.h    |   2 +-
> >  7 files changed, 244 insertions(+), 128 deletions(-)
> 
> Aside from a few niggles, these look fine to me. Who were you expecting
> to merge these, tj or me?

Thanks for reviewing!

Not entirely sure, it's kind of split, but maybe the cgroup changes are
predominant (cpuset_mutex is probably contributing the most). So, maybe
tj? Assuming this looks good to him as well of course. :)

Thanks!

