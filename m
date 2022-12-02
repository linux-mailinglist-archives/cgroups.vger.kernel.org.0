Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB276641081
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiLBWVJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiLBWVI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:21:08 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C55E8E26;
        Fri,  2 Dec 2022 14:21:06 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:20:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670019664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nb8k+DXeBU/J0+0BiQ1cnwf8hXfYeMnAmujWdPmsnKU=;
        b=UxM8kjrT9Ea2zn2bW1xVTLb0ig9zVs+Un8YBzcLzK7pOIf97+C/ov/djzFl3e7QSaXWeda
        FP0gGaYLRkXM8B1mFBNJc0IsIcbnK3fQgl0fMEbesY65k0hd48x2jgSiiNubIX1gTlc9SL
        8p/21LJMfIiYG6LzYyf1NcABb1nKOqw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] selftests: cgroup: refactor proactive reclaim
 code to reclaim_until()
Message-ID: <Y4p6SlewnfvOFs7d@P9FQF9L96D.corp.robot.car>
References: <20221202031512.1365483-1-yosryahmed@google.com>
 <20221202031512.1365483-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202031512.1365483-3-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 03:15:11AM +0000, Yosry Ahmed wrote:
> Refactor the code that drives writing to memory.reclaim (retrying, error
> handling, etc) from test_memcg_reclaim() to a helper called
> reclaim_until(), which proactively reclaims from a memcg until its
> usage reaches a certain value.
> 
> While we are at it, refactor and simplify the reclaim loop.
> 
> This will be used in a following patch in another test.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
