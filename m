Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF86DFE99
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDLTRd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDLTRb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 15:17:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C556188;
        Wed, 12 Apr 2023 12:17:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so11376360plp.2;
        Wed, 12 Apr 2023 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327047; x=1683919047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjLJTegoBtBUML6y27GTBTrp1rLhDXKko66W4791iCA=;
        b=j0gZBYxWyEXymMs5NkUYqqKa3kXVdR62FTlnXgVOum98NKSobo61ps0XVpgAUbZWKO
         ss3mCtQRP9lLnLZK8UK0NBxSbzY+orD9b9k9H4BVoRkjnuJMHNMLOk6GkxwJUSLQV+o/
         fAXVfMvBzoCGfc0tjyCoBXZcu+SaahlssZ4c+uYCKwivVxzOMwtsXuA53aEAK0vsyHyy
         HmEY8+4/hLS8VvcZjpmWPg1uMJrWAG7pjBHfZvUb0z0nhSsNquS/9Hr+g829OL04AKav
         s3zax5q/aYkeVJxomd6QW0JXgnMR5q06iRrgQH9XqYX5uHzyziIfVKl91kD7wsu4C6de
         wQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327047; x=1683919047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjLJTegoBtBUML6y27GTBTrp1rLhDXKko66W4791iCA=;
        b=EbVufSK0fK2nmcwTdw8hnSY8//fVFwz/cA/cjmVyXm/LpWSVFZzG77HM64qWWVuCR0
         8TdFWVrstdl6bRZWc6TR3GmwvfnnkkdDcy6FVOcxSHUzI+9SQ/aBZ8Am74+hp8/X1hdB
         0RPmLzASuJryXpXsTH8wTKZukhQ8pSDbHz0GCjUY95sfNnkGMxIs+8hIU3chcsU/ar2a
         2FYpOvaKIqqZafnaIOQdd+vAY4NmPrXx+CSvu4oqlsh31NVx6IFvM+/1YjKTAs/YzI8P
         KEZGj5wap7icWx9o4vspce+L9dUhfFgVouqeBYW29X62a4g4aRKybCPsW2qS+9h/WnMQ
         gqMQ==
X-Gm-Message-State: AAQBX9f649+JFzoSbk5X9sxIokyTWHJki8GB5wP3vi1PN+8PjCjdxtwr
        JMNuBU7UwY/9QzBp9BegMnw=
X-Google-Smtp-Source: AKy350YI8ERXLX1I1DQGvXX2ELowShm9JDT4uPbDL3Uv91CL/8ri7ZxX0rkxocYGWAAT7+CVPTaURA==
X-Received: by 2002:a17:902:ef94:b0:1a6:3b88:9ebb with SMTP id iz20-20020a170902ef9400b001a63b889ebbmr3721538plb.33.1681327047157;
        Wed, 12 Apr 2023 12:17:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001a5157d1a9dsm10119567plb.14.2023.04.12.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:17:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 09:17:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v4 5/5] cgroup/cpuset: Optimize out unneeded
 cpuset_can_fork/cpuset_cancel_fork calls
Message-ID: <ZDcDxecF0Y5F0pV6@slm.duckdns.org>
References: <20230411133601.2969636-1-longman@redhat.com>
 <20230411133601.2969636-6-longman@redhat.com>
 <ZDb4G2jgQFK8h8Ys@slm.duckdns.org>
 <90b7bc16-0673-02b7-dad1-f24bc956f1c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b7bc16-0673-02b7-dad1-f24bc956f1c5@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Apr 12, 2023 at 02:40:53PM -0400, Waiman Long wrote:
> On 4/12/23 14:27, Tejun Heo wrote:
> > On Tue, Apr 11, 2023 at 09:36:01AM -0400, Waiman Long wrote:
> > > The newly introduced cpuset_can_fork() and cpuset_cancel_fork() calls
> > > are only needed when the CLONE_INTO_CGROUP flag is set which is not
> > > likely. Adding an extra cpuset_can_fork() call does introduce a bit
> > > of performance overhead in the fork/clone fastpath. To reduce this
> > > performance overhead, introduce a new clone_into_cgroup_can_fork flag
> > > into the cgroup_subsys structure. This flag, when set, will call the
> > > can_fork and cancel_fork methods only if the CLONE_INTO_CGROUP flag
> > > is set.
> > > 
> > > The cpuset code is now modified to set this flag. The same cpuset
> > > checking code in cpuset_can_fork() and cpuset_cancel_fork() will have
> > > to stay as the cgroups can be different, but the cpusets may still be
> > > the same. So the same check must be present in both cpuset_fork() and
> > > cpuset_can_fork() to make sure that attach_in_progress is correctly set.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > Waiman, I'm not necessarily against this optimization but can we at least
> > have some performance numbers to show that this is actually meaningful?
> > Given how heavy our fork path is, I'm not too sure this would show up in any
> > meaningful way.
> 
> That make sense to me. I am OK to leave it for now as it is an optimization
> patch anyway.
> 
> BTW, another question that I have is about the cgroup_threadgroup_rwsem. It
> is currently a percpu rwsem. Is it possible to change it into a regular
> rwsem instead? It is causing quite a bit of latency for workloads that
> require rather frequent changes to cgroups. I know we have a "favordynmods"
> mount option to disable the percpu operation. This will still be less
> performant than a normal rwsem. Of course the downside is that the fork/exit
> fastpaths will be slowed down a bit.

I don't know. Maybe? A rwsem actually has a scalability factor in that the
more CPUs are forking, the more expensive the rwsem becomes, so it is a bit
more of a concern. Another factor is that in majority of use cases we're
almost completely bypassing write-locking percpu_rwsem, so it feel a bit sad
to convert it to a regular rwsem. So, if favordynmods is good enough, I'd
like to keep it that way.

Thanks.

-- 
tejun
