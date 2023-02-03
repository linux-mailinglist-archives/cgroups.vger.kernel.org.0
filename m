Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4568981A
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBCLu6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCLu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 06:50:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFC1E9DD;
        Fri,  3 Feb 2023 03:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51936CE2FC3;
        Fri,  3 Feb 2023 11:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04159C433D2;
        Fri,  3 Feb 2023 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675425051;
        bh=PXEna3R+6kpChu3+xAiwe71pF38XzueJzaRSerG6yiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZvioM8ZgWnnY66Z2DxMSsyhYUl/s3h+wcmd7rfp9w0kdvLVjMdMQ1NI7jnq4kLLJ
         c5kqwvtnYs1pqSVdIOKD9Q0Xp2Z+egXzOccUafPGmYN72SVtst66VY3ZDHQvBxFw2x
         G9gQCtwU3YnypoqHRiaGoc5JjgpLrxN2FQe/h/URS6pPswcuQWt1knPxEO/o3i6aoP
         xOOLpay/TmYln4bOLiNbZEYdUIPabWrvh5r3w6yZ1Hth8OLZ/mTWtpQG6ac5qkdfZB
         Ue8yrGnisrDu6AHN8HEn4dKGsndV3xVYEcwAqIQw9OB/AQa+/9ynnSYsFEyBfPn5pm
         zTXLzADbTPxXQ==
Date:   Fri, 3 Feb 2023 11:50:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <20230203115045.GB5927@willie-the-truck>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
 <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 10:34:00PM -0500, Waiman Long wrote:
> On 2/1/23 16:10, Peter Zijlstra wrote:
> > On Wed, Feb 01, 2023 at 01:46:11PM -0500, Waiman Long wrote:
> > 
> > > Note that using cpus_allowed directly in cgroup v2 may not be right because
> > > cpus_allowed may have no relationship to effective_cpus at all in some
> > > cases, e.g.
> > > 
> > >     root
> > >      |
> > >      V
> > >      A (cpus_allowed = 1-4, effective_cpus = 1-4)
> > >      |
> > >      V
> > >      B (cpus_allowed = 5-8, effective_cpus = 1-4)
> > > 
> > > In the case of cpuset B, passing back cpus 5-8 as the allowed_cpus is wrong.
> > I think my patch as written does the right thing here. Since the
> > intersection of (1-4) and (5-8) is empty it will move up the hierarchy
> > and we'll end up with (1-4) from the cgroup side of things.
> > 
> > So the purpose of __cs_cpus_allowed() is to override the cpus_allowed of
> > the root set and force it to cpu_possible_mask.
> > 
> > Then cs_cpus_allowed() computes the intersection of cs->cpus_allowed and
> > all it's parents. This will, in the case of B above, result in the empty
> > mask.
> > 
> > Then cpuset_cpus_allowed() has a loop that starts with
> > task_cpu_possible_mask(), intersects that with cs_cpus_allowed() and if
> > the intersection of that and cpu_online_mask is empty, moves up the
> > hierarchy. Given cs_cpus_allowed(B) is the empty mask, we'll move to A.
> > 
> > Note that since we force the mask of root to cpu_possible_mask,
> > cs_cpus_allowed(root) will be a no-op and if we guarantee (in arch code)
> > that cpu_online_mask always has a non-empty intersection with
> > task_cpu_possible_mask(), this loop is guaranteed to terminate with a
> > viable mask.
> 
> I will take a closer look at that tomorrow. I will be more comfortable
> ack'ing that if this is specific to v1 cpuset instead of applying this in
> both v1 and v2 since it is only v1 that is problematic.

fwiw, the regression I'm seeing is with cgroup2. I haven't tried v1.

WIll
