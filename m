Return-Path: <cgroups+bounces-6832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E133A4ECBF
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E93C9027AA
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287227BF6E;
	Tue,  4 Mar 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWTKfTsI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907D261586;
	Tue,  4 Mar 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111447; cv=none; b=f9zcgB1I4iBqrzA3/omG/yggMPbY7zUwzmlKgWQhQn7YwPaQO3C7Qt0Co/0yDIcNipqY6qROo7MG0MB1+x4dJiXDNJKXLPvb22GNaC2jY3yYS+rH7c/WJazYKYXzHx55R+XjJdENNGLu58qDLdDTToyRQoGz2DPNGC4wQUV8Prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111447; c=relaxed/simple;
	bh=pynaldebDCauDd1sSlUu8oZBedGI0SQnMCvTPl0kQPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAP7hPrQ0LizSGGepsgtN8n+mxwatES2YGFD6nDHBDst6c7zeF/o+3NLM5EqRp6L/v14yaESJCgI65K4Kcxn5PTSQs/YADixW1C6LCor4ZyFy0Uey1s20x/myjvAmhgzYA7dDPvwYB6SM6duuLCdYXKeb1PMRt7QTB8YIoRv/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWTKfTsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10755C4CEE7;
	Tue,  4 Mar 2025 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111447;
	bh=pynaldebDCauDd1sSlUu8oZBedGI0SQnMCvTPl0kQPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWTKfTsIfBZNgBBTuT12ln79TaLQA4bjpIZO/y2hlYxg1yo+MPGhvCu5sRpiFiZXm
	 K0oKeQSWORrHLz6HvA6GcPyLtDccDaek2Grbte+uxb7LgFZAlg2ZTvvNKHgQf5102Q
	 GCLLbxAJgQxXPM5nfT5gYfd5Cd/0CbgcC4I7ooa4AowwPUMC9LagVCPU3RhqLRaOy7
	 nAy+KyJbas9MOczGGQbHJw9Z87geJjORF5z6DYst9XhU8azlStNNd3hDMLpH/UTcI8
	 epEFetZUhtx9PZWEGOzSiB3kpqLkw5aSQsOLkh7lqFLO9iBZD2y7cmFLykgu0HHwtV
	 rt53XsifTgYRQ==
Date: Tue, 4 Mar 2025 08:04:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
Message-ID: <Z8dAlvRnE28WyOGP@slm.duckdns.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
 <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <123839ed-f607-4374-800a-4411e87ef845@redhat.com>

On Tue, Mar 04, 2025 at 12:33:32PM -0500, Waiman Long wrote:
> 
> On 3/4/25 12:10 PM, Michal Koutný wrote:
> > On Tue, Mar 04, 2025 at 06:52:41AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
> > > ...
> > > > I do have some concern with the use of pr_warn*() because some users may
> > > > attempt to use the panic_on_warn command line option.
> > > Yeah, let's print these as info.
> > The intention is _not_ to cause panic by any of this this.
> > Note the difference between WARN() and pr_warn() (only the former
> > panics).
> > Warn level has precedent in mm/memcontrol-v1.c already.
> 
> I think you are right. The pr_warn() function should not cause a panic. I
> have the misconception that pr_warn() will be affected by panic_on_warn
> before. In that case, I have no objection to use pr_warn().

I'm apprehensive about adding warning messages which may be triggered
consistently without anything end users can do about them. I think that
deprecation messages, unless such deprecation is immediate and would have
direct consequences on how the system can be used, should be informational.

Thanks.

-- 
tejun

