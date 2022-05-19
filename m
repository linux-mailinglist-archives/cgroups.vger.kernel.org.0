Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F252CDBE
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiESH7w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiESH7w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 03:59:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393F3983C
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 00:59:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fef32314f7so39806867b3.18
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5ASte9vGYV8NmyufWXTtDt+wnTToG5G7bVCsDgy4Kpg=;
        b=gwTVGnSBCH1OItkK8408hxAE3H+3MOivih34m7SBHEGT0+6hAZOMLNPptS8SIvLmuk
         dn2y46gEkcFMT6rDddZ+v7a37E4u+yB8m9HWh7XNQNIo8o+qpgOH/q9QPz/KwdaFOIVV
         Nq6tzQ02jiflJjryDeixn4W/tNmMMnumKiTZ36ZxRroI3RPCmJHaY4M7pNq/lV3jccpO
         rZPjU/9DuAsZ2bqhz0zyrw8D0P4kaiQK7kHNRTbeHzkIcduFAaVBVEqNoXOd8BJqnfd4
         NYrOoQgzKjbdFMCsMqLS1DyP1f9llOtIzlwbiTSrOq7EO3K9qk7QpbKFIsyOkuDu1TuB
         Mt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ASte9vGYV8NmyufWXTtDt+wnTToG5G7bVCsDgy4Kpg=;
        b=x/QEx7/cP/EhXeSlaVLpDKRZiyqrgMMDwT1tqYLpckS1iLtV5VB6xxOi/GGJobrvfC
         6xuHMSYROvQtsWIZOx76tyO3gt6g78wyYjYtCDwGXts1yZGigLhCvr521Qjr2W8aOlKB
         2o58Xxpqo4HEO84qvUnVSe2JJnFC2UymxelQUiuD5Q3M13EP08N0CyqiyuCdlbJl5AIt
         6vZmgFeiUUOLMwaS/MKFe37VPDb1YoZ3NVYhPRGoHKLYsqq+CRXfsiukYOzxekNkVJNm
         48nkdXimUh+rQnsBGZtdL4dK8psuTxr1egt4WDVCdBa12VLa3fFfb0ZZSNpGaKc9pb4O
         TRoA==
X-Gm-Message-State: AOAM5316Ny+ddfSU07vz2YKQsCWux4RqJehtM+QBf0zSJoQIv2cGzcVw
        cKk+GSDDlzSqf6bT2WNCnW5wtNlXiDEF
X-Google-Smtp-Source: ABdhPJyhbw5GxCRJe6VzVh23QB1TgeiIWMOLDn0KJ5/UuVta6ydkueOGGL6ATX6pdbrz+U5Okt1rkGQXziIr
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:d3bc:20ba:fd8e:8208])
 (user=gthelen job=sendgmr) by 2002:a25:4bc6:0:b0:64d:efe1:a7d1 with SMTP id
 y189-20020a254bc6000000b0064defe1a7d1mr3156185yba.70.1652947189788; Thu, 19
 May 2022 00:59:49 -0700 (PDT)
Date:   Thu, 19 May 2022 00:59:47 -0700
In-Reply-To: <20220518223815.809858-1-vaibhav@linux.ibm.com>
Message-Id: <xr937d6ic5qk.fsf@gthelen2.svl.corp.google.com>
Mime-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
From:   Greg Thelen <gthelen@google.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> of pages scanned and reclaimed is still not directly available to the
> user-space.
>
> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> readable which returns the number of pages scanned / reclaimed during the
> reclaim process from 'struct vmpressure' associated with each memcg. This should
> let user-space asses how successful proactive reclaim triggered from memcg
> 'memory.reclaim' was ?
>
> With the patch following command flow is expected:
>
>  # echo "1M" > memory.reclaim
>
>  # cat memory.reclaim
>    scanned 76
>    reclaimed 32

I certainly appreciate the ability for shell scripts to demonstrate
cgroup operations with textual interfaces, but such interface seem like
they are optimized for ease of use by developers.

I wonder if for runtime production use an ioctl or netlink interface has
been considered for cgroup? I don't think there are any yet, but such
approaches seem like a more straightforward ways to get nontrivial
input/outputs from a single call (e.g. like this proposal). And they
have the benefit of not requiring ascii serialization/parsing overhead.

> [1]:  https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com
>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++++---
>  mm/memcontrol.c                         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 27ebef2485a3..44610165261d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1209,18 +1209,27 @@ PAGE_SIZE multiple when read back.
>  	utility is limited to providing the final safety net.
>  
>    memory.reclaim
> -	A write-only nested-keyed file which exists for all cgroups.
> +	A nested-keyed file which exists for all cgroups.
>  
> -	This is a simple interface to trigger memory reclaim in the
> -	target cgroup.
> +	This is a simple interface to trigger memory reclaim and retrieve
> +	reclaim stats in the target cgroup.
>  
>  	This file accepts a single key, the number of bytes to reclaim.
>  	No nested keys are currently supported.
>  
> +	Reading the file returns number of pages scanned and number of
> +	pages reclaimed from the memcg. This information fetched from
> +	vmpressure info associated with each cgroup.
> +
>  	Example::
>  
>  	  echo "1G" > memory.reclaim
>  
> +	  cat memory.reclaim
> +
> +	  scanned 78
> +	  reclaimed 30
> +
>  	The interface can be later extended with nested keys to
>  	configure the reclaim behavior. For example, specify the
>  	type of memory to reclaim from (anon, file, ..).
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2e2bfbed4717..9e43580a8726 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6423,6 +6423,19 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static int memory_reclaim_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
> +
> +	spin_lock(&vmpr->sr_lock);
> +	seq_printf(m, "scanned %lu\nreclaimed %lu\n",
> +		   vmpr->scanned, vmpr->reclaimed);
> +	spin_unlock(&vmpr->sr_lock);
> +
> +	return 0;
> +}
> +
>  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			      size_t nbytes, loff_t off)
>  {
> @@ -6525,6 +6538,7 @@ static struct cftype memory_files[] = {
>  		.name = "reclaim",
>  		.flags = CFTYPE_NS_DELEGATABLE,
>  		.write = memory_reclaim,
> +		.seq_show  = memory_reclaim_show,
>  	},
>  	{ }	/* terminate */
>  };
