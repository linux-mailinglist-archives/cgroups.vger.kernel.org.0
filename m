Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B613DB9A0
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhG3Nva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 09:51:30 -0400
Received: from m34-101.88.com ([104.250.34.101]:55654 "HELO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S231137AbhG3Nva (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 30 Jul 2021 09:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=U6j4xCRQTNphDoWVkEQmuY0zFpuU+auTGrnhA
        Ph8wKQ=; b=dtZT1Gmy+Ib7qRWeBixQDKdLla0H32l6JEY0+iqJQEHptPw360i+f
        /dXr5YX1sKbqCWRMS80fTOOnZJY7kjuOLoffNhV6YthSfvQblA5a4ZLJbE7MlerN
        dgIx3DskzpZ2jk2R8wKomy/iaSf4qmxBczkekdYSagdVNotY2vrYw8=
Received: from [0.0.0.0] (unknown [113.251.12.143])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCHBqcxAgRh1yQRAA--.51894S3;
        Fri, 30 Jul 2021 21:44:18 +0800 (CST)
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
To:     Cai Huoqing <caihuoqing@baidu.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210730051605.2626-1-caihuoqing@baidu.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <0516372e-0120-ff52-bf9a-cf1cda9a633f@email.cn>
Date:   Fri, 30 Jul 2021 21:44:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730051605.2626-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgCHBqcxAgRh1yQRAA--.51894S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF43uF45Aw1UAr48ZF4DXFb_yoW7KFyUpa
        yDCa4IkwsxKF1UKF1Ut3s2gr1Sgw4kW3y3KFykAr1rAFsxJ3WqvFnFv3W5tF1rZFyfCa4U
        Zrs0vFy09w4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr2
        1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUSXo2UUUUU
X-Originating-IP: [113.251.12.143]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2021/7/30 ÏÂÎç1:16, Cai Huoqing Ð´µÀ:
> Fix typo: iff  ==> if
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>


Reviewed-by: Hu Haowen <src.res@email.cn>


> ---
>  Documentation/admin-guide/cgroup-v1/cgroups.rst           | 2 +-
>  Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst | 4 ++--
>  kernel/cgroup/cgroup-v1.c                                 | 4 ++--
>  kernel/cgroup/cgroup.c                                    | 6 +++---
>  kernel/cgroup/cpuset.c                                    | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
> index b0688011ed06..fa747466e304 100644
> --- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
> @@ -573,7 +573,7 @@ cgroup_for_each_descendant_pre() for details.
>  ``void css_offline(struct cgroup *cgrp);``
>  (cgroup_mutex held by caller)
>  
> -This is the counterpart of css_online() and called iff css_online()
> +This is the counterpart of css_online() and called if css_online()
>  has succeeded on @cgrp. This signifies the beginning of the end of
>  @cgrp. @cgrp is being removed and the subsystem should start dropping
>  all references it's holding on @cgrp. When all references are dropped,
> diff --git a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
> index 582d3427de3f..a908c5226bde 100644
> --- a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
> +++ b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
> @@ -56,7 +56,7 @@ expected.
>  The cgroup freezer is hierarchical. Freezing a cgroup freezes all
>  tasks belonging to the cgroup and all its descendant cgroups. Each
>  cgroup has its own state (self-state) and the state inherited from the
> -parent (parent-state). Iff both states are THAWED, the cgroup is
> +parent (parent-state). If both states are THAWED, the cgroup is
>  THAWED.
>  
>  The following cgroupfs files are created by cgroup freezer.
> @@ -87,7 +87,7 @@ The following cgroupfs files are created by cgroup freezer.
>  * freezer.self_freezing: Read only.
>  
>    Shows the self-state. 0 if the self-state is THAWED; otherwise, 1.
> -  This value is 1 iff the last write to freezer.state was "FROZEN".
> +  This value is 1 if the last write to freezer.state was "FROZEN".
>  
>  * freezer.parent_freezing: Read only.
>  
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index de2c432dee20..71d2b46d1968 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -120,7 +120,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>  		goto out_err;
>  
>  	/*
> -	 * Migrate tasks one-by-one until @from is empty.  This fails iff
> +	 * Migrate tasks one-by-one until @from is empty.  This fails if
>  	 * ->can_attach() fails.
>  	 */
>  	do {
> @@ -215,7 +215,7 @@ static void cgroup_pidlist_destroy_work_fn(struct work_struct *work)
>  	mutex_lock(&l->owner->pidlist_mutex);
>  
>  	/*
> -	 * Destroy iff we didn't get queued again.  The state won't change
> +	 * Destroy if we didn't get queued again.  The state won't change
>  	 * as destroy_dwork can only be queued while locked.
>  	 */
>  	if (!delayed_work_pending(dwork)) {
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 3a0161c21b6b..b831554372a2 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -793,7 +793,7 @@ static bool css_set_populated(struct css_set *cset)
>   * One of the css_sets associated with @cgrp is either getting its first
>   * task or losing the last.  Update @cgrp->nr_populated_* accordingly.  The
>   * count is propagated towards root so that a given cgroup's
> - * nr_populated_children is zero iff none of its descendants contain any
> + * nr_populated_children is zero if none of its descendants contain any
>   * tasks.
>   *
>   * @cgrp's interface file "cgroup.populated" is zero if both
> @@ -2410,7 +2410,7 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
>   * @mgctx: migration context
>   *
>   * Migrate tasks in @mgctx as setup by migration preparation functions.
> - * This function fails iff one of the ->can_attach callbacks fails and
> + * This function fails if one of the ->can_attach callbacks fails and
>   * guarantees that either all or none of the tasks in @mgctx are migrated.
>   * @mgctx is consumed regardless of success.
>   */
> @@ -4264,7 +4264,7 @@ struct cgroup_subsys_state *css_next_child(struct cgroup_subsys_state *pos,
>  	 * increasing unique serial number and always appended to the
>  	 * sibling list, the next one can be found by walking the parent's
>  	 * children until the first css with higher serial number than
> -	 * @pos's.  While this path can be slower, it happens iff iteration
> +	 * @pos's.  While this path can be slower, it happens if iteration
>  	 * races against release and the race window is very small.
>  	 */
>  	if (!pos) {
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index adb5190c4429..f09fc0347550 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -782,7 +782,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		if (cp == &top_cpuset)
>  			continue;
>  		/*
> -		 * Continue traversing beyond @cp iff @cp has some CPUs and
> +		 * Continue traversing beyond @cp if @cp has some CPUs and
>  		 * isn't load balancing.  The former is obvious.  The
>  		 * latter: All child cpusets contain a subset of the
>  		 * parent's cpus, so just skip them, and then we call
> @@ -1801,7 +1801,7 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>  	}
>  
>  	/*
> -	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
> +	 * An empty mems_allowed is ok if there are no tasks in the cpuset.
>  	 * Since nodelist_parse() fails on an empty mask, we special case
>  	 * that parsing.  The validate_change() call ensures that cpusets
>  	 * with tasks have memory.

