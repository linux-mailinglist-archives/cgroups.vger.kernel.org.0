Return-Path: <cgroups+bounces-3588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA1392C66B
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 01:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6591F2109A
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18787187841;
	Tue,  9 Jul 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BSRMP6E6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F61420A8
	for <cgroups@vger.kernel.org>; Tue,  9 Jul 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566537; cv=none; b=p1YX9aYSEQUwncprsWGl3DZlZlTXrZnvr1w9vebEuk4pL2xFvxIRY7oYnl3hYhCJOAX4j+va8jlw+3rXjB8N1er6DSSX9DjKQdOlgdEAXr7pYkByTQrcvIQDuQM7/NJ5Y8lakEo91hkNyyW+FZA6WxUu4STnz0CniFXEptBTTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566537; c=relaxed/simple;
	bh=JAx13Yx4FuH8zaqppvgqU36j7ddAll0MFvqrs8dQRcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSMi1MeGXZueCrnZa2/AET0xXtrCZy8EzulReqZF9rdi2TAGesBnF3i9co6YuiBjlLFK+P2fiU2SLTyw+2nSCwx4fFLokHWzTid5tvBg+ipfokA+s7kbcPVwSpvxXebvu9TDfUdEWpWf/LeYoJOd9U2mTyhXG4UUzq2tXGwFNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BSRMP6E6; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: longman@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720566532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD0XyRXyrCI5R7Aouw/gjTkcZ0SkfaGKil28sfjN/f0=;
	b=BSRMP6E6hqPofTxCwm+B9hyM/zQz6AJuXzGSqTl7eP4q+m0o+4Zt97H1/tsF20iWFmUKQd
	u4Qemv4iLh21yJBrPnNKrpL68KIsyP3TWoLzwFA8aFFUAMs8GDWsyBupxlA59TA/Y653GH
	V2PahlBzTYNwO1KBxVhuQ/NxT8pnozQ=
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: corbet@lwn.net
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 9 Jul 2024 23:08:43 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
Message-ID: <Zo3C-77TnViiOi6d@google.com>
References: <20240709132814.2198740-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709132814.2198740-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 09, 2024 at 09:28:14AM -0400, Waiman Long wrote:
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups. That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
> responsible.  This patch adds CSS counts in the cgroup_subsys structure
> to keep track of the number of CSSes for each of the cgroup subsystems.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the root
> cgroup.stat file is extended to show the number of outstanding CSSes
> associated with all the non-inhibited cgroup subsystems that have been
> bound to cgroup v2.  This will help us pinpoint which subsystems may be
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 53
> 	nr_dying_descendants 34
> 	nr_cpuset 1
> 	nr_cpu 40
> 	nr_io 40
> 	nr_memory 87
> 	nr_perf_event 54
> 	nr_hugetlb 1
> 	nr_pids 53
> 	nr_rdma 1
> 	nr_misc 1
> 
> In this particular case, it can be seen that memory cgroup is the most
> likely culprit for causing the 34 dying cgroups.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
>  include/linux/cgroup-defs.h             |  3 +++
>  kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 52763d6b2919..65af2f30196f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
>  		A dying cgroup can consume system resources not exceeding
>  		limits, which were active at the moment of cgroup deletion.
>  
> +	  nr_<cgroup_subsys>
> +		Total number of cgroups associated with that cgroup
> +		subsystem, e.g. cpuset or memory.  These cgroup counts
> +		will only be shown in the root cgroup and for subsystems
> +		bound to cgroup v2.
> +
>    cgroup.freeze
>  	A read-write single value file which exists on non-root cgroups.
>  	Allowed values are "0" and "1". The default is "0".
> @@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
>  
>  - "cgroup.clone_children" is removed.
>  
> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
> -  at the root instead.
> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
> +  "cgroup.stat" files at the root instead.
>  
>  
>  Issues with v1 and Rationales for v2
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..522ab77f0406 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -776,6 +776,9 @@ struct cgroup_subsys {
>  	 * specifies the mask of subsystems that this one depends on.
>  	 */
>  	unsigned int depends_on;
> +
> +	/* Number of CSSes, used only for /proc/cgroups */
> +	atomic_t nr_csses;

I believe it should be doable without atomics because most of css
operations are already synchronized using the cgroup mutex.

Other than that, I believe that this information is useful. Maybe
it can be retrieved using drgn/bpf iterator, but adding this functionality
to the kernel makes it easier to retrieve and the overhead is modest.

Also, if you add it to the cgroupfs, why not make it fully hierarchical
as existing entries in cgroup.stat. And if not, I'd agree with Johannes
that it looks like the debugfs material.

Thanks!

