Return-Path: <cgroups+bounces-3601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8D92DB2D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD371F228FB
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543E143736;
	Wed, 10 Jul 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OWoal2kw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99313C9A4
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647845; cv=none; b=mzVdc9KYax8m3oWauTpmBu5BsfHlQrJd/3dxGPAQ9L8xc94if75HzOosrAUbld0IqeokRyfg3YlV2epTgrrMrMpJWTaENhTkYjqIl1ZWgfHakSvWvKatc8Ja66z976SIkU4/w7IIdlDk6P8zyeiGrET7bpqNo44lla4IUmFV6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647845; c=relaxed/simple;
	bh=JlkXkPNCHAMxS7MA8G46VWrDL1vn//5PG0aHUe4khZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCZoXPG9R7RSZB+1tj42y74jmIX9fzY4P8VbXhMPsGa80+K9MQcgJGEzLKFyjhhV1kT5GHm/LNcEG/MsfrDFSGlavZF8yu7N7z87pTshuZekjWiKBUiXHsiiJDzvteuhnzOlyzpdg16zO2rz0ePpHBz5/za/b+KOYaHM0MBtpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OWoal2kw; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: longman@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720647838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jivA9hjHCAK5sQZqUP1uRcXYWNdTNA3VPhubHQ2uk=;
	b=OWoal2kwFKT01xXbu0bs8ombjc1N9kJwxVLZDphIEd/7TZQ1f0gi16q/3KRFGcNeg8o1x9
	9stCtfyaWDE0xoRZ1UKv4tVkicKkqVHoEG4W2sm44p3TmvHO57LNjl7+Tbju7vj5oBVHMK
	sYF4Nx8TVVRakcLiwDao5kWNlVOZqSs=
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: corbet@lwn.net
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kamalesh.babulal@oracle.com
Date: Wed, 10 Jul 2024 21:43:53 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <Zo8AmTVEdirZdgol@google.com>
References: <20240710182353.2312025-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710182353.2312025-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> help manage different structures in various cgroup subsystems by being
> an embedded element inside a larger structure like cpuset or mem_cgroup.
> 
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups.  That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may
> be responsible.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems
> that have been bound to cgroup v2 as long as it is not zero.  The number
> includes CSSes in the current cgroup as well as in all the descendants
> underneath it.  This will help us pinpoint which subsystems are
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 54
> 	nr_dying_descendants 44
> 	nr_cpuset 1
> 	nr_cpu 40
> 	nr_io 40
> 	nr_memory 54
> 	nr_dying_memory 44
> 	nr_perf_event 55
> 	nr_hugetlb 1
> 	nr_pids 54
> 	nr_rdma 1
> 	nr_misc 1
> 
> Another sample output from system.slice/cgroup.stat was:
> 
> 	nr_descendants 32
> 	nr_dying_descendants 37
> 	nr_cpu 30
> 	nr_io 30
> 	nr_memory 32
> 	nr_dying_memory 37
> 	nr_perf_event 33
> 	nr_pids 32
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

I like it way more than the previous version, thank you for the update.

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 14 ++++++-
>  include/linux/cgroup-defs.h             |  7 ++++
>  kernel/cgroup/cgroup.c                  | 50 ++++++++++++++++++++++++-
>  3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 52763d6b2919..9031419271cd 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -981,6 +981,16 @@ All cgroup core files are prefixed with "cgroup."
>  		A dying cgroup can consume system resources not exceeding
>  		limits, which were active at the moment of cgroup deletion.
>  
> +	  nr_<cgroup_subsys>
> +		Total number of live cgroups associated with that cgroup
> +		subsystem (e.g. memory) at and beneath the current
> +		cgroup.  An entry will only be shown if it is not zero.
> +
> +	  nr_dying_<cgroup_subsys>
> +		Total number of dying cgroups associated with that cgroup
> +		subsystem (e.g. memory) beneath the current cgroup.
> +		An entry will only be shown if it is not zero.
> +
>    cgroup.freeze
>  	A read-write single value file which exists on non-root cgroups.
>  	Allowed values are "0" and "1". The default is "0".
> @@ -2930,8 +2940,8 @@ Deprecated v1 Core Features
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
> index b36690ca0d3f..62de18874508 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -210,6 +210,13 @@ struct cgroup_subsys_state {
>  	 * fields of the containing structure.
>  	 */
>  	struct cgroup_subsys_state *parent;
> +
> +	/*
> +	 * Keep track of total numbers of visible and dying descendant CSSes.
> +	 * Protected by cgroup_mutex.
> +	 */
> +	int nr_descendants;
> +	int nr_dying_descendants;
>  };
>  
>  /*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a..18c982a06446 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3669,12 +3669,34 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int ssid;
>  
> +	/* cgroup_mutex required for for_each_css() */
> +	cgroup_lock();

I *guess* it can be done under a rcu_read_lock(), isn't it?
That would eliminate a need for the second patch as well, which
is questionable (e.g. one unprivileged user can block others?)

Thanks!

