Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6550C4AD
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiDVX20 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 19:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiDVX1a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 19:27:30 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6A606F6;
        Fri, 22 Apr 2022 16:06:44 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650668803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ri4NEas9lbSjiAnr8PAym/AzE+VftrHE7yoNfH/LAm4=;
        b=LdkihvAFvgmGJkuRJSFvZ0tR5C5W9JQk7UPT7Vi3g9kBw83Agk5s5sugSpdqB2Mot3XgXV
        V38mWZJ/VkZDbrGHj5ydXhO5pexoi/psWeYyFix0qZR515bKTXVFuhtXB8Z/2IBmvmB4tS
        YPD+7R9Yhaa2bMt3H2v5OKLQuxeAQuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Vernet <void@manifault.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <YmM0+/P0ro9pPzMf@carbon>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422155728.3055914-3-void@manifault.com>
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

On Fri, Apr 22, 2022 at 08:57:26AM -0700, David Vernet wrote:
> The test_memcg_low() testcase in test_memcontrol.c verifies the expected
> behavior of groups using the memory.low knob. Part of the testcase verifies
> that a group with memory.low that experiences reclaim due to memory
> pressure elsewhere in the system, observes memory.events.low events as a
> result of that reclaim.
> 
> In commit 8a931f801340 ("mm: memcontrol: recursive memory.low protection"),
> the memory controller was updated to propagate memory.low and memory.min
> protection from a parent group to its children via a configurable
> memory_recursiveprot mount option. This unfortunately broke the memcg
> tests, which asserts that a sibling that experienced reclaim but had a
> memory.low value of 0, would not observe any memory.low events. This patch
> updates test_memcg_low() to account for the new behavior introduced by
> memory_recursiveprot.
> 
> So as to make the test resilient to multiple configurations, the patch also
> adds a new proc_mount_contains() helper that checks for a string in
> /proc/mounts, and is used to toggle behavior based on whether the default
> memory_recursiveprot was present.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c     | 12 ++++++++++++
>  tools/testing/selftests/cgroup/cgroup_util.h     |  1 +
>  tools/testing/selftests/cgroup/test_memcontrol.c | 16 +++++++++++++---
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index dbaa7aabbb4a..e5d8d727bdcf 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -535,6 +535,18 @@ int set_oom_adj_score(int pid, int score)
>  	return 0;
>  }
>  
> +int proc_mount_contains(const char *option)
> +{
> +	char buf[4 * PAGE_SIZE];
> +	ssize_t read;
> +
> +	read = read_text("/proc/mounts", buf, sizeof(buf));
> +	if (read < 0)
> +		return read;
> +
> +	return strstr(buf, option) != NULL;
> +}
> +
>  ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>  {
>  	char path[PATH_MAX];
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index 628738532ac9..756f76052b44 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -48,6 +48,7 @@ extern int is_swap_enabled(void);
>  extern int set_oom_adj_score(int pid, int score);
>  extern int cg_wait_for_proc_count(const char *cgroup, int count);
>  extern int cg_killall(const char *cgroup);
> +int proc_mount_contains(const char *option);
>  extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
>  extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
>  extern pid_t clone_into_cgroup(int cgroup_fd);
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index aa50eaa8b157..ea2fd27e52df 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -21,6 +21,8 @@
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
>  
> +static bool has_recursiveprot;
> +
>  /*
>   * This test creates two nested cgroups with and without enabling
>   * the memory controller.
> @@ -521,15 +523,18 @@ static int test_memcg_low(const char *root)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(children); i++) {
> +		int no_low_events_index = has_recursiveprot ? 2 : 1;
> +
>  		oom = cg_read_key_long(children[i], "memory.events", "oom ");
>  		low = cg_read_key_long(children[i], "memory.events", "low ");
>  
>  		if (oom)
>  			goto cleanup;
> -		if (i < 2 && low <= 0)
> +		if (i <= no_low_events_index && low <= 0)
>  			goto cleanup;
> -		if (i >= 2 && low)
> +		if (i > no_low_events_index && low)
>  			goto cleanup;
> +
>  	}
>  
>  	ret = KSFT_PASS;
> @@ -1272,7 +1277,7 @@ struct memcg_test {
>  int main(int argc, char **argv)
>  {
>  	char root[PATH_MAX];
> -	int i, ret = EXIT_SUCCESS;
> +	int i, proc_status, ret = EXIT_SUCCESS;
>  
>  	if (cg_find_unified_root(root, sizeof(root)))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
> @@ -1288,6 +1293,11 @@ int main(int argc, char **argv)
>  		if (cg_write(root, "cgroup.subtree_control", "+memory"))
>  			ksft_exit_skip("Failed to set memory controller\n");
>  
> +	proc_status = proc_mount_contains("memory_recursiveprot");
> +	if (proc_status < 0)
> +		ksft_exit_skip("Failed to query cgroup mount option\n");

Hopefully no one has a mountpoint with the memory_recursiveprot name :)

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
