Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15A526998
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383389AbiEMSxd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383411AbiEMSxc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 14:53:32 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124346B7D8;
        Fri, 13 May 2022 11:53:27 -0700 (PDT)
Date:   Fri, 13 May 2022 11:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652468003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kMiayxXYuFtWhBAPraPd5K78bT/agJnMmMFP0bNDic=;
        b=CwQJQeNU3k0LejTJOCl/7n/azXvbnvy+FX2dBdBnX9ZeMK/bIroZCXFCtuO5mCJkIfnwlr
        HzMzgzT6oxTE2JkW2Q3ybmMOWRMNXH1GYD09da59N2SUqgDMYtl6XM6yRpNRUsivtjub5Q
        JuV9UezgENmJgVt5GrSP7+ilcJEyGqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     void@manifault.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 1/4] selftests: memcg: Fix compilation
Message-ID: <Yn6pHbHh027S5c33@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513171811.730-2-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:08PM +0200, Michal Koutny wrote:
> This fixes mis-applied changes from commit 72b1e03aa725 ("cgroup:
> account for memory_localevents in test_memcg_oom_group_leaf_events()").
> 
> Signed-off-by: Michal Koutn� <mkoutny@suse.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 25 +++++++++++--------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 6ab94317c87b..4958b42201a9 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1241,7 +1241,16 @@ static int test_memcg_oom_group_leaf_events(const char *root)
>  	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
>  		goto cleanup;
>  
> -	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
> +	parent_oom_events = cg_read_key_long(
> +			parent, "memory.events", "oom_kill ");
> +	/*
> +	 * If memory_localevents is not enabled (the default), the parent should
> +	 * count OOM events in its children groups. Otherwise, it should not
> +	 * have observed any events.
> +	 */
> +	if (has_localevents && parent_oom_events != 0)
> +		goto cleanup;
> +	else if (!has_localevents && parent_oom_events <= 0)
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> @@ -1349,20 +1358,14 @@ static int test_memcg_oom_group_score_events(const char *root)
>  	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
>  		goto cleanup;
>  
> -	parent_oom_events = cg_read_key_long(
> -			parent, "memory.events", "oom_kill ");
> -	/*
> -	 * If memory_localevents is not enabled (the default), the parent should
> -	 * count OOM events in its children groups. Otherwise, it should not
> -	 * have observed any events.
> -	 */
> -	if ((has_localevents && parent_oom_events == 0) ||
> -	     parent_oom_events > 0)
> -		ret = KSFT_PASS;
> +	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
> +		FAIL(cleanup);
>  
>  	if (kill(safe_pid, SIGKILL))
>  		goto cleanup;
>  
> +	ret = KSFT_PASS;
> +
>  cleanup:
>  	if (memcg)
>  		cg_destroy(memcg);
> -- 
> 2.35.3
> 

My bad.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
