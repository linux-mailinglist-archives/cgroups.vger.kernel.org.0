Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302E6D932F
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbjDFJs0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjDFJsC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 05:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDBA5FE;
        Thu,  6 Apr 2023 02:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90721644B7;
        Thu,  6 Apr 2023 09:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC833C433EF;
        Thu,  6 Apr 2023 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680774266;
        bh=mH5FA82ZmBZCk3OyomF15pnwwOXhYUZvWscsCw1LcYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cu2ZM7g4q/pBTzeZyybOsqrI1YACcXxFg+9Ssl85A9DaoaGBcMU3dF85fmPzAli5n
         7t/biEsqtZRFCn9qONpvQzPKoKF02/R/tH8i9Ho4Yo3ePolMpdN67xGvk9Ab4m/krQ
         psOvWpDwYDAQE3hgtEPegn3dq9Axd5XV5jFFP7nju/KQW2coFx9XVxgMG4zZOSZWhn
         GuKGE5XWZX4H7bDetPxbNtQ+pk8iRKcBcodIVnDm5ouDyM+2sIrGPfKCbiC1ryVI1l
         t05wme3n786TnyTs3UzlVsEldRzBFdSkjZ5h4D4D/eoyeeW6K3IZX70Ei4sKbmXirJ
         r5tHKmvmN6Jew==
Date:   Thu, 6 Apr 2023 11:44:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
Subject: Re: [PATCH 3/3] cgroup/cpuset: Allow only one active attach
 operation per cpuset
Message-ID: <20230406-haselnuss-baumhaus-83dc05f869df@brauner>
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331145045.2251683-4-longman@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 31, 2023 at 10:50:45AM -0400, Waiman Long wrote:
> The current cpuset code uses the global cpuset_attach_old_cs variable
> to store the old cpuset value between consecutive cpuset_can_attach()
> and cpuset_attach() calls. Since a caller of cpuset_can_attach() may
> not need to hold the global cgroup_threadgroup_rwsem, parallel cpuset
> attach operations are possible.
> 
> When there are concurrent cpuset attach operations in progress,
> cpuset_attach() may fetch the wrong value from cpuset_attach_old_cs
> causing incorrect result.  To avoid this problem while still allowing
> certain level of parallelism, drop cpuset_attach_old_cs and use a
> per-cpuset attach_old_cs value. Also restrict to at most one active
> attach operation per cpuset to avoid corrupting the value of the
> per-cpuset attach_old_cs value.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2367de611c42..3f925c261513 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -198,6 +198,8 @@ struct cpuset {
>  
>  	/* Handle for cpuset.cpus.partition */
>  	struct cgroup_file partition_file;
> +
> +	struct cpuset *attach_old_cs;
>  };
>  
>  /*
> @@ -2456,22 +2458,27 @@ static int fmeter_getrate(struct fmeter *fmp)
>  	return val;
>  }
>  
> -static struct cpuset *cpuset_attach_old_cs;
> -
>  /* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
>  static int cpuset_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
> +	struct cpuset *cs, *oldcs;
>  	struct task_struct *task;
>  	int ret;
>  
>  	/* used later by cpuset_attach() */
> -	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> +	oldcs = task_cs(cgroup_taskset_first(tset, &css));
>  	cs = css_cs(css);
>  
>  	percpu_down_write(&cpuset_rwsem);
>  
> +	/*
> +	 * Only one cpuset attach operation is allowed for each cpuset.
> +	 */
> +	ret = -EBUSY;
> +	if (cs->attach_in_progress)
> +		goto out_unlock;

That'll mean CLONE_INTO_CGROUP becomes even more interestig because it
isn't subject to this restriction in contrast to fork()+migrate, right?
