Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710867C5AE3
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjJKSF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjJKSF6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 14:05:58 -0400
Received: from out-208.mta1.migadu.com (out-208.mta1.migadu.com [IPv6:2001:41d0:203:375::d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371359D
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 11:05:56 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697047555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjATHd+PMfSbpzqzLwPd5xrtwunRsm3UnhcKphRYNsM=;
        b=FVSrhZsEnpEzGL5LUXJSsCuoYcWSLHxZ91rxb2HjIW75WtaivZUfJ3G8PuwMEfpEv55i3Q
        l3YKiu1gw9A9dJLekGsmIZJggKjIJbRYNce49GtNxWIVUrdfNhuuM73T5BmVTJr0N++w3h
        SU9mAOIxwVJXyMN7t/kFnefWd8IJoBg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <ZSbj_SGkVj8wMY40@P9FQF9L96D.corp.robot.car>
References: <20231010000929.450702-1-roman.gushchin@linux.dev>
 <20231010000929.450702-3-roman.gushchin@linux.dev>
 <20231011180101.o2ha6awrupojcu6h@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011180101.o2ha6awrupojcu6h@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 11, 2023 at 06:01:01PM +0000, Shakeel Butt wrote:
> On Mon, Oct 09, 2023 at 05:09:26PM -0700, Roman Gushchin wrote:
> [...]
> > +static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
> > +{
> > +	struct task_struct *task;
> > +	struct cgroup_subsys_state *css;
> > +
> > +	cgroup_taskset_for_each(task, css, tset) {
> > +		/* atomically set the update bit */
> > +		set_bit(0, (unsigned long *)&current->objcg);
> 
> task instead of current ??

Oh, right, of course, good catch!

Thanks!
