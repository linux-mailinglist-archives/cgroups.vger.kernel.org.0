Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050023808BA
	for <lists+cgroups@lfdr.de>; Fri, 14 May 2021 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhENLnf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 May 2021 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhENLnf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 May 2021 07:43:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D7C061574;
        Fri, 14 May 2021 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MdMngczTJp2eNddFPzOfewyFvaPceCIk8FSUZMqbx7M=; b=WN+214LIDtc7IWUZgPQNZg3gUP
        RY4WgyT2H0dzxNMPtxc4w8KBdHZfYXR47ILnkCX/saycrkY9wM5X9dkOc9L72VwTJ9COZ8DV9XzXq
        39ZMwGyAxW1fwscIu/6IoNIIbDO6T6BArFj/+rY7i3w4hWF5wnAfz/7hym5GbV2zEIzJcBq45ZXvv
        8KFnZkcldbr+cJ7P3sfNJ71Qm/Gr7QfLIVRqeRcFkuKrb6J0G2T8dWp6/NSmgavSHY3H6KYzLKXTe
        PaeBZdBQr6ZgdkiCy+qfgRc4Wwjg7ZZI/GR+XJTApBu0DnqosdTpnTLVjSM9vhoHiwhxccaCdzSjS
        Kck9YCrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWCa-007wf5-44; Fri, 14 May 2021 11:41:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7EAC2300233;
        Fri, 14 May 2021 13:41:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64AFC2BB7C83F; Fri, 14 May 2021 13:41:54 +0200 (CEST)
Date:   Fri, 14 May 2021 13:41:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
References: <20210513175349.959661-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513175349.959661-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 13, 2021 at 10:53:49AM -0700, Suren Baghdasaryan wrote:

> +bool cgroup_psi_enabled(void)
> +{
> +	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
> +}

> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3cff41f..c73efd7d4fba 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -747,9 +747,12 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>  #ifdef CONFIG_CGROUPS
>  	struct cgroup *cgroup = NULL;
>  
> -	if (!*iter)
> +	if (!*iter) {
> +		/* Skip to psi_system if per-cgroup accounting is disabled */
> +		if (!cgroup_psi_enabled())
> +			goto update_sys;
>  		cgroup = task->cgroups->dfl_cgrp;
> -	else if (*iter == &psi_system)
> +	} else if (*iter == &psi_system)
>  		return NULL;
>  	else
>  		cgroup = cgroup_parent(*iter);
> @@ -758,6 +761,7 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>  		*iter = cgroup;
>  		return cgroup_psi(cgroup);
>  	}
> +update_sys:
>  #else
>  	if (*iter)
>  		return NULL;

I'm confused; shouldn't that do the same as that #else branch? Also, can
you pretty please make cgroup_psi_enabled() a static_key ?
