Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0745847C4
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiG1Vj3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 17:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiG1Vj2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 17:39:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D372152470;
        Thu, 28 Jul 2022 14:39:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3452529pjd.3;
        Thu, 28 Jul 2022 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0lIhra6yGQrlkyIbM2bnb9XhkYHXW96sQs23+tnYMHU=;
        b=bMTdPhbS4m1DiyFWNkkBtZa1qNMP0zCUSede5bxmA3r7760mQ3YV3FcYK0DUHenJXn
         1wA0avWFIn0aX1lTswRj4MICETJAiKoPkD7IIneoaJ9Cr6a+pERInxXKcjPByREiIom7
         nJKbTeYpyMRnBzxz2TmUMuotGG7kViVgVm9vTC3n7TaalPpopl+QoL2njeOUfEkPIiEP
         iov33KDjYhfXS+Qb+rXWVtJnPldHSKC1iLQrMuMbJWbMOcAxTf1cDl35Rnotadymwqp9
         TylyVen9uEcpdDbAqQHCOxFPFze21b0ZJ8us7LrmsVP1+4NzXD5hAQE8ZLJdmROwzBgY
         m6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0lIhra6yGQrlkyIbM2bnb9XhkYHXW96sQs23+tnYMHU=;
        b=3aUqsWGvxffLhIrnG3xnywQipcG2nkcALOCI3Jd/vTnEeX3BIC042UdGbKt5l8DiK3
         OjNajz/0RJ/4Rz3mQOFCN2+aU1r4mASucMu9iv8+qitHORmrkahBHT3bcP3zVeaE5o3q
         ufCAhU7Qoit4/Le2w8VTOciHS0AaS8HBcAak/NYtzU12IEw2dYvge9/zm7f9/Kocz0Cq
         7qt+ngZrq/iLlNoY5coMDASAR6rWXg6IsdHITVuPLjd6MFoJFKQbC7byGkRqWgs0UJO4
         WDECo6mXcAo2Skwy3XyWy84Qs0BSbNPCutdPk9A+ydZkuZ3j/qztfLw0oDWCSnIHoe74
         Ti9w==
X-Gm-Message-State: ACgBeo2HfiS2tI47uGONR2d1Mus8mSuoHCIT8m15CV4z1vdgeS2xrERK
        ANqApFbt/34pN+wxpxEKqE0=
X-Google-Smtp-Source: AA6agR6u8Bs2jW49F0zQoOItivEp2vBozLP3IGVbiVo/babj9yhgglOKF8cvwGGoIrbf9D+/O2dvtw==
X-Received: by 2002:a17:902:ab0f:b0:16d:b340:bf8f with SMTP id ik15-20020a170902ab0f00b0016db340bf8fmr844650plb.140.1659044364093;
        Thu, 28 Jul 2022 14:39:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:23b6])
        by smtp.gmail.com with ESMTPSA id w71-20020a62824a000000b005252defb016sm1230951pfd.122.2022.07.28.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:39:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 11:39:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Message-ID: <YuMCB86fH2K3NcqM@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
 <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
 <YuL1NijxSEv2xadk@slm.duckdns.org>
 <c470d3f7-f0f8-b8e6-4a95-7b334f0a824b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c470d3f7-f0f8-b8e6-4a95-7b334f0a824b@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Waiman.

On Thu, Jul 28, 2022 at 05:04:19PM -0400, Waiman Long wrote:
> > So, the patch you proposed is making the code remember one special aspect of
> > user requested configuration - whether it configured it or not, and trying
> > to preserve that particular state as cpuset state changes. It addresses the
> > immediate problem but it is a very partial approach. Let's say a task wanna
> > be affined to one logical thread of each core and set its mask to 0x5555.
> > Now, let's say cpuset got enabled and enforced 0xff and affined the task to
> > 0xff. After a while, the cgroup got more cpus allocated and its cpuset now
> > has 0xfff. Ideally, what should happen is the task now having the effective
> > mask of 0x555. In practice, tho, it either would get 0xf55 or 0x55 depending
> > on which way we decide to misbehave.
> 
> OK, I see what you want to accomplish. To fully address this issue, we will
> need to have a new cpumask variable in the the task structure which will be
> allocated if sched_setaffinity() is ever called. I can rework my patch to
> use this approach.

Yeah, we'd need to track what user requested separately from the currently
effective cpumask. Let's make sure that the scheduler folks are on board
before committing to the idea tho. Peter, Ingo, what do you guys think?

Thanks.

-- 
tejun
