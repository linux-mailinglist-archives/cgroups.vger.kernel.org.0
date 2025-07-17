Return-Path: <cgroups+bounces-8755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE3B092C7
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 19:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0124E4227
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068472FD5BF;
	Thu, 17 Jul 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+wK3GFJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA32FD5AD;
	Thu, 17 Jul 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771971; cv=none; b=FoRzRGsPyrIby6ACqDeQkczE3sMhbTxeFtoZLbtNzbrwShUPJj3Cp3bZiw0kV7vPITh0xAYUUTMlgpwCDvuyyf05+1D8OTangv720Gxh/fjmbwiLpScg2I9+1P64rLvao8zhQQiUnLeN6ePDLoO4raBCDSZY8NtEw2tFt2sQDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771971; c=relaxed/simple;
	bh=t1DK4l7l6P0SZg/OzJJPzKirYKNAZ7sCpI7tcRykSY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJz4I4rxaS15iSIwiXuoXjRVnoGRgeKE7RQ7v/7qJh0hGN2K0m5UTFFPPmT8G2TA0Q0rEhawtt3JSMlaesOf94n15eSEpPi6UgT38EnwnB9SxNAVoF06sTk7oY57S5HckP257hrWhRnmKCYayaoaVzXsbol/fAd7EYQzwUAUtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+wK3GFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6105EC4CEE3;
	Thu, 17 Jul 2025 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752771971;
	bh=t1DK4l7l6P0SZg/OzJJPzKirYKNAZ7sCpI7tcRykSY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+wK3GFJ0pCHEPfr34xe47yY7BwT73tdLh5GE1jgQpi7eFsTemXN5U55sSEDvXpXM
	 zH4HDARWBwYsR0XKugQ5FxAS/w5Rp6Uhy0dLLT08MT1bW1HWLZ/3U00bkadvLZ4RYS
	 uZNeg4hlbagzoMaTwy9fMe0JZ94dsoypFytluYqlZZmCW5RFpmdyoVquOEuGn43DBQ
	 COT8DewFLpKsm1/vDvLPdT1PouztO7+keoggnHUzCoA+PyErVArsSxODLs1dULszLl
	 9lIQRKmfNCZHxIXAdFEGzTWPvLDSBWAGi4wHaSdW69DVNQHuqKxdOYoPe+ocqoDBT9
	 SjaS1BOIK79OA==
Date: Thu, 17 Jul 2025 07:06:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
Message-ID: <aHktgqO3BUg8exXH@slm.duckdns.org>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com>

On Thu, Jul 17, 2025 at 09:52:38PM +0800, Chen Ridong wrote:
> > With the given implementation (and use scenario), this'd better exposed
> > in
> >   cgroup.freeze.stat.local
> > 
> 
> Would it be possible to add this field to either cgroup.event or cgroup.stat?
> Since the frozen status is already tracked in cgroup.event, this placement would maintain better
> cohesion with existing metrics.
> 
> This is just a suggestion.

Yeah, given that the freezer is an integral part of cgroup core, using
cgroup.stat[.local] probably makes more sense.

Thanks.

-- 
tejun

