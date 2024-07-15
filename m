Return-Path: <cgroups+bounces-3682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFF931956
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F0282DC3
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFC4E1C8;
	Mon, 15 Jul 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvvXtNFy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBB3BB2E
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064656; cv=none; b=fHYSKx3XfIqlD/7Kz/xJUgWIk6WyBazyY+lmr0amZQoxet+3WyJR9EXBYpURIW07Nrz+u5kYIlNsa0sSAP+VvPcHHpj8zp9Ld0zcYVprDz5OuwqH6EAY7J7nC3WkvsfZXVfTk330Ru18xhfidfBaLHxNJQNqszbCTuhZxWh7GvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064656; c=relaxed/simple;
	bh=fuFomPvJjEWyq0rlb0WrUHt+YwwZeluRKdzkdP8nJAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5pGVN0+Z6sC4YkJsDEzLbCSTgRF9UkPYOL559L0PsF8XBUCmHVwI1q89PnMF7nbhefERvk1LsZSEy7X3IdJIuvygoKxDqflLzB/hFHIKySuauQTFzUTQcHQ+SWPKgSnZg7dS2G6t4mIAUaee4Nt38gcgOBCLIOLMOqywEzowtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvvXtNFy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: longman@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721064652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48LNjXEtpZ7HdIqiCDkMz54KvHv8Y9hqJYhmD6bl1e4=;
	b=uvvXtNFyX8YfglFp7KW0c7WheJq834hIGYDnFgi1aHq9ZXcRN1DSMfwUrMXcDWueTS1HXR
	rZEKQ01xtPmjcWDbCakRM9cSMfoPpDPbV21vxY49WDm1HgkHjDvLq8Ygg/VGgXqKs6E3jQ
	sXpMIPGyv6RPrne82akxBSPw7Sa7p4I=
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mkoutny@suse.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kamalesh.babulal@oracle.com
Date: Mon, 15 Jul 2024 17:30:46 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <ZpVcxlx1VR3FaoYI@google.com>
References: <20240715150034.2583772-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715150034.2583772-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 15, 2024 at 11:00:34AM -0400, Waiman Long wrote:
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
> dying CSSes associated with all the non-inhibited cgroup subsystems that
> have been bound to cgroup v2. The number includes CSSes in the current
> cgroup as well as in all the descendants underneath it.  This will help
> us pinpoint which subsystems are responsible for the increasing number
> of dying (nr_dying_descendants) cgroups.
> 
> The CSSes dying counts are stored in the cgroup structure itself
> instead of inside the CSS as suggested by Johannes. This will allow
> us to accurately track dying counts of cgroup subsystems that have
> recently been disabled in a cgroup. It is now possible that a zero
> subsystem number is coupled with a non-zero dying subsystem number.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 56
> 	nr_subsys_cpuset 1
> 	nr_subsys_cpu 43
> 	nr_subsys_io 43
> 	nr_subsys_memory 56
> 	nr_subsys_perf_event 57
> 	nr_subsys_hugetlb 1
> 	nr_subsys_pids 56
> 	nr_subsys_rdma 1
> 	nr_subsys_misc 1
> 	nr_dying_descendants 30
> 	nr_dying_subsys_cpuset 0
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 30
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_hugetlb 0
> 	nr_dying_subsys_pids 0
> 	nr_dying_subsys_rdma 0
> 	nr_dying_subsys_misc 0
> 
> Another sample output from system.slice/cgroup.stat was:
> 
> 	nr_descendants 34
> 	nr_subsys_cpuset 0
> 	nr_subsys_cpu 32
> 	nr_subsys_io 32
> 	nr_subsys_memory 34
> 	nr_subsys_perf_event 35
> 	nr_subsys_hugetlb 0
> 	nr_subsys_pids 34
> 	nr_subsys_rdma 0
> 	nr_subsys_misc 0
> 	nr_dying_descendants 30
> 	nr_dying_subsys_cpuset 0
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 30
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_hugetlb 0
> 	nr_dying_subsys_pids 0
> 	nr_dying_subsys_rdma 0
> 	nr_dying_subsys_misc 0
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

