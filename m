Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD650C56B
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 02:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiDVX7T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 19:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiDVX7R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 19:59:17 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0251AFF52;
        Fri, 22 Apr 2022 16:56:21 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650671780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EaQSEVslaLuejAKqVFqZ9iCKFR405OvDd1jGIm3QWY=;
        b=v5MGwbB6eilouV9kuZMZyAE6+dLSBhKbVeaZ8F/6IViG8ajAxiF9ycz9BrGwqr4PehJJzi
        P+XdDJ6vFBGpWd2jzo2fNy6RCUvTT1QUJMmHjzWoSmvKLW/AeewWt+FwV95+eCQgCI98lY
        xW6F8hjtauFm0NCmWFgLIOXxX0xLQBM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 5/5] cgroup: Fix racy check in alloc_pagecache_max_30M()
 helper function
Message-ID: <YmNAni3YH2fWFrSZ@carbon>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-6-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422155728.3055914-6-void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 08:57:29AM -0700, David Vernet wrote:
> alloc_pagecache_max_30M() in the cgroup memcg tests performs a 50MB
> pagecache allocation, which it expects to be capped at 30MB due to the
> calling process having a memory.high setting of 30MB. After the allocation,
> the function contains a check that verifies that MB(29) < memory.current <=
> MB(30). This check can actually fail non-deterministically.
> 
> The testcases that use this function are test_memcg_high() and
> test_memcg_max(), which set memory.min and memory.max to 30MB respectively
> for the cgroup under test. The allocation can slightly exceed this number
> in both cases, and for memory.max, the process performing the allocation
> will not have the OOM killer invoked as it's performing a pagecache
> allocation.  This patchset therefore updates the above check to instead use
> the verify_close() helper function.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, David!
