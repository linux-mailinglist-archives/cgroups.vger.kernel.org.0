Return-Path: <cgroups+bounces-8114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55012AB1EF9
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 23:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8272A02DD5
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899152609E4;
	Fri,  9 May 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEWNpGaV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796A25FA34;
	Fri,  9 May 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825566; cv=none; b=hPwXtSYk65WnSGPhsvNW+eDMiKYoGBmPRG/yKUEnqJLIRxuXwT0L9o+uTG0IYvAZL1PVZXIOpeYXgIhF9FGz7/iGuGTOe/MkVWzlsFL8Z2eL4wWo2o+5sYjpL+vSTQEeg75UhhnLz/C14jb+HgnYcCpxTf+EwPGb+RcKrtz16JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825566; c=relaxed/simple;
	bh=vcg5jKA0QZzNkvVa/o7NUqxLYKijZ1UehBCsGJ6Hd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh3DLXJKUkQDNvUUguwVWQ54nvD2vHJ4qh0EANdpB5dksBjgkeBrWPNAFG4f9aQSdlaXHBeKAhuFTkTuozcJYqakrI/kot+2tqEhe0ORRDiaCIORN/YA8KnorRHplYtREPuK//ErwAksUrg/D/cqKGQabzThDL+LSHkBULvAw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEWNpGaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B0C4CEE4;
	Fri,  9 May 2025 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746825565;
	bh=vcg5jKA0QZzNkvVa/o7NUqxLYKijZ1UehBCsGJ6Hd6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEWNpGaV4/PJPa53z0lW6l0selJErRz2OemA8W0wotl+7x43PbSIFfZ/6Gm60t8be
	 DVrNEQOr0hKAu8yRxXHBt+46zMQ4Oq4f6PWabAbct+y0+4YDfPenciFgInJwle5/Gq
	 r33WnbEs1ryLXjJd8FtiMU663Wp5ozxNA9jtm8l9XfcW3OunYDAmwjdZbxZ4tVIsTS
	 flKDCItNH7d1Qz9Oc2iO+hTaDVIAT+GNVuRlxn1+7DNO7+cD/VDMaJRppUt3BnDMMV
	 PZVzX/OZF6fgkRowLD32qUOMIjSOiYbUF7P6pvwulKH4SKsYJG1BoMHzMVr5a6TJOz
	 NpTqFei3QwcMA==
Date: Fri, 9 May 2025 23:19:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to
 all PF_NO_SETAFFINITY tasks
Message-ID: <aB5xWuHkwh1iGERu@pavilion.home>
References: <20250508192413.615512-1-longman@redhat.com>
 <aB4AmUtEM-qQ1Xoa@localhost.localdomain>
 <aB47y64qlbsnql07@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB47y64qlbsnql07@slm.duckdns.org>

Le Fri, May 09, 2025 at 07:30:51AM -1000, Tejun Heo a écrit :
> Hello,
> 
> On Fri, May 09, 2025 at 03:18:17PM +0200, Frederic Weisbecker wrote:
> ...
> > But this makes me realize I overlooked that when I introduced the unbound kthreads
> > centralized affinity.
> > 
> > cpuset_update_tasks_cpumask() seem to blindly affine to subpartitions_cpus
> > while unbound kthreads might have their preferences (per-nodes or random cpumasks).
> > 
> > So I need to make that pass through kthread API.
> 
> I wonder whether it'd be cleaner if all kthread affinity restrictions go
> through housekeeping instead of cpuset modifying the cpumasks directly so
> that housekeeping keeps track of where different classes of kthreads can run
> and tell e.g. workqueue what to do.

Good suggestion. "isolated_cpus" should indeed be handled by housekeeping
itself. More precisely housekeeping_cpu(HK_TYPE_DOMAIN) should be updated
through some housekeeping_update() function to union the boot 'isolcpus='
and the isolated mask of cpusets partition. Waiman tried that at some point.
This will require some synchronization against the readers of HK_TYPE_DOMAIN.

It's beyond the scope of the kthreads affinity issue but yes that's all
planned within the cpusets integration of nohz_full.

Thanks.


> 
> Thanks.
> 
> -- 
> tejun

-- 
Frederic Weisbecker
SUSE Labs

