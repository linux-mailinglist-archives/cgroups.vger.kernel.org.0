Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2650C4B5
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 01:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiDVXdR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiDVXdA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 19:33:00 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA500210C3A;
        Fri, 22 Apr 2022 16:14:56 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650669295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qj54Vyot11RQURjSDei20EVpyRPh4pQqH20/VoPb/oY=;
        b=WWhuDxynQAO8T0s74G33tChZVeFVDym7JxNZ5avEQ2CPZNMh9wqOtfLPt/wrG1+5WwfSTu
        7yjlJ2fQ+56QPdJsoOiM/ZahjDyqpieegEXLu4PcOhG+OOBZx8RlLBwzKpDN9ekV7CSFx2
        fXn8qs8BVdRh/bFx1bRkHLItH8xTB6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 3/5] cgroup: Account for memory_localevents in
 test_memcg_oom_group_leaf_events()
Message-ID: <YmM26XBZxWy4Widc@carbon>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422155728.3055914-4-void@manifault.com>
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

On Fri, Apr 22, 2022 at 08:57:27AM -0700, David Vernet wrote:
> The test_memcg_oom_group_leaf_events() testcase in the cgroup memcg tests
> validates that processes in a group that perform allocations exceeding
> memory.oom.group are killed. It also validates that the
> memory.events.oom_kill events are properly propagated in this case.  Commit
> 06e11c907ea4 ("kselftests: memcg: update the oom group leaf events test")
> fixed test_memcg_oom_group_leaf_events() to account for the fact that the
> memory.events.oom_kill events in a child cgroup is propagated up to its
> parent. This behavior can actually be configured by the memory_localevents
> mount option, so this patch updates the testcase to properly account for
> the possible presence of this mount option.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  .../testing/selftests/cgroup/test_memcontrol.c  | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index ea2fd27e52df..d88e0ca3f3d1 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -21,6 +21,7 @@
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
>  
> +static bool has_localevents;
>  static bool has_recursiveprot;
>  
>  /*
> @@ -1091,6 +1092,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
>  {
>  	int ret = KSFT_FAIL;
>  	char *parent, *child;
> +	long parent_oom_events;
>  
>  	parent = cg_name(root, "memcg_test_0");
>  	child = cg_name(root, "memcg_test_0/memcg_test_1");
> @@ -1128,7 +1130,15 @@ static int test_memcg_oom_group_leaf_events(const char *root)
>  	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
>  		goto cleanup;
>  
> -	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
> +	parent_oom_events = cg_read_key_long(
> +			parent, "memory.events", "oom_kill ");
> +	// If memory_localevents is not enabled (the default), the parent should
> +	// count OOM events in its children groups. Otherwise, it should not
> +	// have observed any events.

Please, use /* */ style comments, it's a generic kernel style.

> +	if (has_localevents) {
> +		if (parent_oom_events != 0)
> +			goto cleanup;
> +	} else if (parent_oom_events <= 0)
>  		goto cleanup;

How about something like this? IMO a bit more clear what's going on.
	if ((has_local_events && parent_oom_events == 0) ||
	    parent_oom_events > 0)
		ret = KSFT_PASS;

Anyway, looks good to me.
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

>  
>  	ret = KSFT_PASS;
> @@ -1298,6 +1308,11 @@ int main(int argc, char **argv)
>  		ksft_exit_skip("Failed to query cgroup mount option\n");
>  	has_recursiveprot = proc_status;
>  
> +	proc_status = proc_mount_contains("memory_localevents");
> +	if (proc_status < 0)
> +		ksft_exit_skip("Failed to query cgroup mount option\n");
> +	has_localevents = proc_status;
> +
>  	for (i = 0; i < ARRAY_SIZE(tests); i++) {
>  		switch (tests[i].fn(root)) {
>  		case KSFT_PASS:
> -- 
> 2.30.2
> 
