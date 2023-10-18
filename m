Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B67CEB66
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 00:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJRWiU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRWiU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 18:38:20 -0400
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ce])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFF113;
        Wed, 18 Oct 2023 15:38:18 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697668696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEVaOgq1eU8OxlCLPQtF3jeqYSkHfjK3nHIbnwXFIa4=;
        b=lqg1ppuUL9JHPJn2km6Utx7zXuLjPLIj0EvhOjZI/UU+fZtGpcbszi9T1qPtP8pLQrDifw
        +PV+7J38k9f2JBNX7SAfVV1fyk5KxhF5GKTMJOs/0Lg+FwxQgTbV3MH2G8T7oZI118nTtH
        HPLhF+EZ0OW5r03Vt0dSGVOYGW8gJoM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <ZTBeRu3iDu7nnPV8@P9FQF9L96D.corp.robot.car>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev>
 <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
 <ZTAUTWO2UfI0VoPL@P9FQF9L96D.corp.robot.car>
 <CALvZod6mb91o9pW57suovtW1UQ8G8j=2S3Tjoqzjh6L+jqz-EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod6mb91o9pW57suovtW1UQ8G8j=2S3Tjoqzjh6L+jqz-EQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 18, 2023 at 11:26:59AM -0700, Shakeel Butt wrote:
> On Wed, Oct 18, 2023 at 10:22 AM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> [...]
> > > >     struct mem_cgroup *memcg;
> > > > @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > > >
> > > >     if (in_task()) {
> > > >             memcg = current->active_memcg;
> > > > +           if (unlikely(memcg))
> > > > +                   goto from_memcg;
> > > >
> > > > -           /* Memcg to charge can't be determined. */
> > > > -           if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
> > >
> > > The checks for current->mm and PF_KTHREAD seem to be gone completely after
> > > the patch, was that intended and why?
> >
> > There is no need for those anymore because it's as cheap or cheaper
> > to check task->objcg for being NULL. Those were primarily used to rule out
> > kernel threads allocations early.
> >
> 
> I have the same understanding but please correct my suspicions here.
> We can echo the kernel thread's pid to cgroup.procs which have
> PF_NO_SETAFFINITY and thus this will cause the lower bit of the kernel
> thread's task->objcg to be set. Please correct me if I am missing
> something.

Yes, you seem to be right. It's a gray zone because moving kernel threads out of
the root cgroup doesn't sound like a good idea, but I agree it's better to keep
the old behavior in place.

Does this fixlet look good to you?

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1a2835448028..0b0d2dc7a7d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3021,6 +3021,10 @@ static struct obj_cgroup *current_objcg_update(void)
                        old = NULL;
                }

+               /* If new objcg is NULL, no reason for the second atomic update. */
+               if (!current->mm || (current->flags & PF_KTHREAD))
+                       return NULL;
+
                /*
                 * Release the objcg pointer from the previous iteration,
                 * if try_cmpxcg() below fails.
