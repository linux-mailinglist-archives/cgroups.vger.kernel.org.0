Return-Path: <cgroups+bounces-8107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13634AB1B92
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE681525DA5
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331522CBF6;
	Fri,  9 May 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJnUsD7n"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A314685;
	Fri,  9 May 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811852; cv=none; b=SN2RKNfhqmImEPN+e4fP7mNSeIXxnG/VW0vM4Dd8FcwhriXP9WoIfM5ZHTb+pUaCCQ/pOGaLOw165dKHZEDFM3EmAcVo/hX4/D0rV45iGR9E9nNPeTbbn6TMMzqYzSN0vlpbRhj6uoQZZjFpVsPxVITn+dZUga6sJvSgNh3fZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811852; c=relaxed/simple;
	bh=Fhgn8bV+mXLSIupaCfWBqIukLoMw0l54J1jMVK0fZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVyS24xSepUZie/Y6PoKJf4N2zYiBP06grJhl5S0yn3JdK6AMkkT4otIxARFtBvVRf3RI4W/4PgpYzsTr25ksV1l8FmuLXPdpTHSkhomRK168D5lJkjefbrq3Gem+lQBmO1gMythuMq64x6/i2AEIloouU+O9qw4wDggrLFdZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJnUsD7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A5C4CEE4;
	Fri,  9 May 2025 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746811852;
	bh=Fhgn8bV+mXLSIupaCfWBqIukLoMw0l54J1jMVK0fZUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJnUsD7nqQr6LQPkMQdSHIe5+Aog7deA7WrAUwnNf5PNnRSvcsvdaVVe+xRJxazWU
	 xFNn1BVp9/vEt8dPVBlFrqASfqs7jxOP/u1n2EGlHbBPeeOtc3WFk5163mMmfioKNx
	 va8jtkMJx+oryemckVYzPDUVxBc3oQe8DykkhvI1V/hbLWeP1QEP4X+gECIvkrtaHA
	 Oyu86oUcAwKjjZBuZ0Gh2Iu+YDURIHYTcuzJF3V+FyP8Q2knbMModB+EGaXhu6IiOJ
	 hPrArPUrxgcOUaBFtjym9ZJDYSlpbdp/B6EEIrf+CyHomL/UDWCm2D2KaGI4kRKEaT
	 d5ALFhpNXm4Yg==
Date: Fri, 9 May 2025 07:30:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to
 all PF_NO_SETAFFINITY tasks
Message-ID: <aB47y64qlbsnql07@slm.duckdns.org>
References: <20250508192413.615512-1-longman@redhat.com>
 <aB4AmUtEM-qQ1Xoa@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB4AmUtEM-qQ1Xoa@localhost.localdomain>

Hello,

On Fri, May 09, 2025 at 03:18:17PM +0200, Frederic Weisbecker wrote:
...
> But this makes me realize I overlooked that when I introduced the unbound kthreads
> centralized affinity.
> 
> cpuset_update_tasks_cpumask() seem to blindly affine to subpartitions_cpus
> while unbound kthreads might have their preferences (per-nodes or random cpumasks).
> 
> So I need to make that pass through kthread API.

I wonder whether it'd be cleaner if all kthread affinity restrictions go
through housekeeping instead of cpuset modifying the cpumasks directly so
that housekeeping keeps track of where different classes of kthreads can run
and tell e.g. workqueue what to do.

Thanks.

-- 
tejun

