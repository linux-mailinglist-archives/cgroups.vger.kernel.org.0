Return-Path: <cgroups+bounces-8110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35BAB1BA7
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00E91B616B7
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AC238172;
	Fri,  9 May 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poq5+IbE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5244685;
	Fri,  9 May 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746812145; cv=none; b=CdV53qeTz5NSYtBXjRVe+IWecFYkuHOo4R+UJhnskxaEgNi76tZ9UB/vS9Dn/HCcTdjCQVLt/GYBdKzEYm7lBmtW87v5Nu8DZ0eUy08izhA9Bqjs7fj8porho4i9ZFiJ/tCrL7YMe7ouYp71Iur2kzRpNVVoLZcYUtY4BLWf7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746812145; c=relaxed/simple;
	bh=KOGnAPNxmbJl+Yq12pfhB/aGkUT+Eq8b/xBVNk1a0hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFgSKRm2QDDyBTfM0nADDHV2wLoKk+rN7E/entZZlzvCLiYwNRizzDvZ58dtxm/t4PeXvwErzgheVNA3XD5Kr6yUxTnqc4dBmk3KCNtxGYAx0CTKcj9OnWMZ3ajVqhwEEnepbU0tNvo0AR8VzUZL3Jqi8fJZEqvOpyYzB8x3Tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poq5+IbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B401C4CEF0;
	Fri,  9 May 2025 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746812145;
	bh=KOGnAPNxmbJl+Yq12pfhB/aGkUT+Eq8b/xBVNk1a0hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poq5+IbEVy42knqm1tr1ZO+QxOeCey7dAqxOZCclJqyszXb88t7Ipv/5NXFpj28nH
	 GFX1UVdDxBt294sNYKXEpJgXzuNekflTAXg65QY16MPOl2RLF3KoOZHzCUd4UJRuHI
	 sG7XzMr88U0KkfOwnGjGVL0WiuD036y/SoRXk1oam/I5dYdm2Sslvl5scXKiUMXgKQ
	 GgHLLHA89K6Waca68YTB0K7sZRhUVHHD392eQOKbyNqusAaGKrpWarT4eRAO3W55ey
	 EhYGaHa+L7GsHX63H2BnQfd9XQvDsAPihmjFFzUOCLpyJkgrNRd89PTIVrOy3r5fA6
	 5Xjr+eHp7Y39Q==
Date: Fri, 9 May 2025 07:35:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to
 all PF_NO_SETAFFINITY tasks
Message-ID: <aB488PJUSYng6ZDQ@slm.duckdns.org>
References: <20250508192413.615512-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508192413.615512-1-longman@redhat.com>

On Thu, May 08, 2025 at 03:24:13PM -0400, Waiman Long wrote:
> Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
> on top_cpuset") enabled us to pull CPUs dedicated to child partitions
> from tasks in top_cpuset by ignoring per cpu kthreads. However, there
> can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
> flag set to indicate that we shouldn't mess with their CPU affinity.
> For other kthreads, their affinity will be changed to skip CPUs dedicated
> to child partitions whether it is an isolating or a scheduling one.
> 
> As all the per cpu kthreads have PF_NO_SETAFFINITY set, the
> PF_NO_SETAFFINITY tasks are essentially a superset of per cpu kthreads.
> Fix this issue by dropping the kthread_is_per_cpu() check and checking
> the PF_NO_SETAFFINITY flag instead.
> 
> Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

