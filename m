Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6150CB2E
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiDWObG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiDWObG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 10:31:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC226AF3
        for <cgroups@vger.kernel.org>; Sat, 23 Apr 2022 07:28:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so94264757b3.12
        for <cgroups@vger.kernel.org>; Sat, 23 Apr 2022 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DXAXkVZYPHcetFXE1oISHIeSMz1Xot5LLxB15W3LMjk=;
        b=tQibwGA8uz8Ue+E3pvs+c8ZLtax4gGb4dFOV3dy8bzYAyRQotxBRYtX3oExAAr/e5W
         lcJykMgKZDqXuCRcUTWrpgdKqNqa7SDK7R5LQ1iWkeMFOMj4/GvkIliYrru0Fcz3ot5h
         cvD+hIJBFRnHqnE3eBGsznogk3ef/KiPrus6ZbeRLGrGf+/GlLHeLPEohW773ai5NpM2
         pXrvOgHb8VQuBDo7BbJ8vcpHd3CLD6msHLW5xjWZJUln3dl7h6R0dYjUMivzqyXucYGI
         E+67TMHQeiyQW5PXgSo8AKsLGTtBzdyQAAlPZ+C99mPyDJfjZvDTgswF9XlojwtZrxoc
         qXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DXAXkVZYPHcetFXE1oISHIeSMz1Xot5LLxB15W3LMjk=;
        b=csMwFVvTgk/4A9CSttw68LiWmVlbGkV/dr5/l5XFDfYihOYZCOYPiCYRUZI1/GRwYr
         CbajFewNQXXpv5b3MCDlkNJRB+A96YYjZ8RkIfve1Q+S5XrJqGHpI3ltLQjX7XTzqLyx
         wH10cHPJnANw7sYmPbYFweDEF01O/bymGg+ulERHAh3XEcSb9S6rMXXIYOfd5teEeQ6f
         x7uq0Lx7mHlvCM6WvzNNbEYI2yX8ErtVD50nYwczDSJwYtdlQgiRHdYdqeQU/JiGhHT+
         nOmBMMOyHJCyQRInT7LkapLPEsYOLMYh83YPx8NX6XcvrFeYyq9X/DWPpIbl0ronz8Rl
         jvrA==
X-Gm-Message-State: AOAM532kV6iD3QMDdTLivKF+cvtlMwP3vXfzX+Dc49Kaegq6ugwFQYyH
        U3Bh5UNLJ1LrXv7VxdPsUn1QGFMHhKlvmQ==
X-Google-Smtp-Source: ABdhPJymwLMUEIWwXLSUSEFl1hrUHDozuSw0iJLPBiMCTcvECf3BdD1JzQSLUMCkewcVDkKmZFBQ5OvW5vc+iw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:124b:b0:644:c3bf:fa2d with SMTP
 id t11-20020a056902124b00b00644c3bffa2dmr9159316ybu.462.1650724084357; Sat,
 23 Apr 2022 07:28:04 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:28:01 +0000
In-Reply-To: <20220421234426.3494842-5-yosryahmed@google.com>
Message-Id: <20220423142801.gnvd42cdcsz4hpon@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-5-yosryahmed@google.com>
Subject: Re: [PATCH v4 4/4] selftests: cgroup: add a selftest for memory.reclaim
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:26PM +0000, Yosry Ahmed wrote:
> Add a new test for memory.reclaim that verifies that the interface
> correctly reclaims memory as intended, from both anon and file pages.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index f2ffb3a30194..5f7c20de2426 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -760,6 +760,91 @@ static int test_memcg_max(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * This test checks that memory.reclaim reclaims the given
> + * amount of memory (from both anon and file).
> + */
> +static int test_memcg_reclaim(const char *root)
> +{
> +	int ret = KSFT_FAIL, fd, retries;
> +	char *memcg;
> +	long current, to_reclaim;
> +	char buf[64];
> +
> +	memcg = cg_name(root, "memcg_test");
> +	if (!memcg)
> +		goto cleanup;
> +
> +	if (cg_create(memcg))
> +		goto cleanup;
> +
> +	current = cg_read_long(memcg, "memory.current");
> +	if (current != 0)
> +		goto cleanup;
> +
> +	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(50));

Don't you need is_swap_enabled() check before deciding to do the anon
allocations?

> +	sleep(1);
> +
> +	fd = get_temp_fd();
> +	if (fd < 0)
> +		goto cleanup;
> +
> +	cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
> +	sleep(1);

These sleep(1)s do not seem robust. Since kernel keeps the page cache
around, you can convert anon to use tmpfs and use simple cg_run to
trigger the allocations of anon (tmpfs) and file which will remain in
memory even after return from cg_run.
