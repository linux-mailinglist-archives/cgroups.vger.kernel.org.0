Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB268705B
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBAVL0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 16:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBAVLZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 16:11:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC02D7F;
        Wed,  1 Feb 2023 13:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eQ62sI2LaH5K93mDteIKKvfXZlAXtr2Rm8TFfldgNso=; b=i5XQu02i0rUZkkaMlzRQPLcq6n
        c15AesJp084H/0wYTlUcdNMnfX6McXTm88rbMrGAIO1WhNY8ud/aPxhaWn2bmBd6Dal/a/8qATMZ9
        60qWxuyRtROY/s6+MWvfT0Y7hSCdyaxN1mCwWG5+KgS61otXliI5GJpPoAN2JM3CeC2IgQpHR5Il3
        65uMjyrak7qWnWZ5I+2ajEJ72rOS/BWQLnM4PmzzccnZokOIjeu5hIXVsUL8sRumyVLPPwhDKxn/h
        6egXjLvlI67XNJIDJc21H787lqbAel0wYy6PzotdyneH9zZA/gIG+zBCPTpWCdK9F+65Q9p7yQyBr
        5MgXYw7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNKMv-004uBg-36;
        Wed, 01 Feb 2023 21:10:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC2E830013F;
        Wed,  1 Feb 2023 22:10:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E8E5200DCC72; Wed,  1 Feb 2023 22:10:46 +0100 (CET)
Date:   Wed, 1 Feb 2023 22:10:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 01:46:11PM -0500, Waiman Long wrote:

> Note that using cpus_allowed directly in cgroup v2 may not be right because
> cpus_allowed may have no relationship to effective_cpus at all in some
> cases, e.g.
> 
>    root
>     |
>     V
>     A (cpus_allowed = 1-4, effective_cpus = 1-4)
>     |
>     V
>     B (cpus_allowed = 5-8, effective_cpus = 1-4)
> 
> In the case of cpuset B, passing back cpus 5-8 as the allowed_cpus is wrong.

I think my patch as written does the right thing here. Since the
intersection of (1-4) and (5-8) is empty it will move up the hierarchy
and we'll end up with (1-4) from the cgroup side of things.

So the purpose of __cs_cpus_allowed() is to override the cpus_allowed of
the root set and force it to cpu_possible_mask.

Then cs_cpus_allowed() computes the intersection of cs->cpus_allowed and
all it's parents. This will, in the case of B above, result in the empty
mask.

Then cpuset_cpus_allowed() has a loop that starts with
task_cpu_possible_mask(), intersects that with cs_cpus_allowed() and if
the intersection of that and cpu_online_mask is empty, moves up the
hierarchy. Given cs_cpus_allowed(B) is the empty mask, we'll move to A.

Note that since we force the mask of root to cpu_possible_mask,
cs_cpus_allowed(root) will be a no-op and if we guarantee (in arch code)
that cpu_online_mask always has a non-empty intersection with
task_cpu_possible_mask(), this loop is guaranteed to terminate with a
viable mask.


