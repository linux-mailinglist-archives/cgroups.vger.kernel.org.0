Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EE5269C7
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383519AbiEMTAI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350124AbiEMTAH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 15:00:07 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9C51325;
        Fri, 13 May 2022 12:00:05 -0700 (PDT)
Date:   Fri, 13 May 2022 11:59:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652468403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqpZhH7J5youYlvqQPYfh1hCiMgjjWNCBTzk0n4ZxXA=;
        b=F4EModIONc1PztPbxj08bNBaO8jF2TB7U0Ez9Ira/aYAAwz8eA72ptgiF1I1ULNyM7IVp7
        kK/WhwqWPOQDCfP4/od29ylwXnmAvg/gbAFgyfaveVhFF2KhbZVSGYIv5hflnA15e+qzPh
        YDxYaYxWoVB4FC51eWTTQkRgBUVJyjU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     void@manifault.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 4/4] selftests: memcg: Remove protection from top level
 memcg
Message-ID: <Yn6qrHHS935ppX98@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-5-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513171811.730-5-mkoutny@suse.com>
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

On Fri, May 13, 2022 at 07:18:11PM +0200, Michal Koutny wrote:
> The reclaim is triggered by memory limit in a subtree, therefore the
> testcase does not need configured protection against external reclaim.
> 
> Also, correct/deduplicate respective comments
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 9ffacf024bbd..9d370aafd799 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
>  
>  /*
>   * First, this test creates the following hierarchy:
> - * A       memory.min = 50M,  memory.max = 200M
> + * A       memory.min = 0,    memory.max = 200M
>   * A/B     memory.min = 50M,  memory.current = 50M
>   * A/B/C   memory.min = 75M,  memory.current = 50M
>   * A/B/D   memory.min = 25M,  memory.current = 50M
> @@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
>   * Usages are pagecache, but the test keeps a running
>   * process in every leaf cgroup.
>   * Then it creates A/G and creates a significant
> - * memory pressure in it.
> + * memory pressure in A.
>   *
>   * A/B    memory.current ~= 50M
>   * A/B/C  memory.current ~= 29M
> @@ -335,8 +335,6 @@ static int test_memcg_min(const char *root)
>  			      (void *)(long)fd);
>  	}
>  
> -	if (cg_write(parent[0], "memory.min", "50M"))
> -		goto cleanup;
>  	if (cg_write(parent[1], "memory.min", "50M"))
>  		goto cleanup;
>  	if (cg_write(children[0], "memory.min", "75M"))
> @@ -404,8 +402,8 @@ static int test_memcg_min(const char *root)
>  
>  /*
>   * First, this test creates the following hierarchy:
> - * A       memory.low = 50M,  memory.max = 200M
> - * A/B     memory.low = 50M,  memory.current = 50M
> + * A       memory.low = 0,    memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = ...

Can you, please, just remove "memory.current = ...", it's not
because obvious what "..." means here.

Other than that: Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
