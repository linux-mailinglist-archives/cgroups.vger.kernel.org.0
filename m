Return-Path: <cgroups+bounces-7803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F2A9B52A
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 19:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6991467C2F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D411284686;
	Thu, 24 Apr 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ii4phgbW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1A2820D6
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515589; cv=none; b=ciuh8mYXhBokuLntl7EVyi5peT1oXUuuk1FAPI4rjcf5lb7YoVqO4Hrb0f2mP/SJddtEnrVbPCqIcKq3MFGZZoBBkRLmpvpulw8op1w3WBoOnJU+GTKBxlnMEPmRZdpwioCC3/XVtj+O74bkBGtAhY/2Iy0jAjil2yWm32OkYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515589; c=relaxed/simple;
	bh=/JSeFc5o5sD5NrYeEm19qOv4THcEzsfgtpbFjxGtg4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ2CJUcE7V1KpWwpGnPeiL/i4drEOLpTr08jj21SG+foyMD8MS8vRD0+rCME9Xcr2hWezAOam9edWBcqvhwOmE+K6xN3SjERw6FAhWL4f0LYq6GL1nz3QVrp/pVYs5t4xrF5bxz9O6Zdzhcv3q49H/XP4/QBBdWWvz/47gmV0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ii4phgbW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 10:25:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745515577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xJ9WUYihmTXo0ZQIFwyCaqG4SKLzPmFojL24n+qwaQ=;
	b=ii4phgbWi9Ka9Bul3Wye5lo9mg+DhFPL1e87BvNHplNKIKvEa1ulVL+SI07IyAfKbzaqmd
	ZVtLRGSZZbpQqlDAqISCIea2BJT8+Oe6lsC7hxcw5mbeu30YyTgEbkfAEHJ58MDru9fEOJ
	XmSt4FkS7im83EG8KOagV5x5ZVmrWIQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, 
	yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <35xkwotuqyfj3xlahh2knxjew7f3mxfugmgtfahy4tx4m2ovlp@4rfb3i46iqy2>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <aAehK23MNX1FsRjF@Asmaa.>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAehK23MNX1FsRjF@Asmaa.>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 22, 2025 at 07:01:15AM -0700, Yosry Ahmed wrote:
> >  	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
> > @@ -793,6 +796,9 @@ struct cgroup_subsys {
> >  	 * specifies the mask of subsystems that this one depends on.
> >  	 */
> >  	unsigned int depends_on;
> > +
> > +	spinlock_t rstat_ss_lock;
> > +	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
> 
> Can we use local_lock_t here instead? I guess it would be annoying
> because we won't be able to have common code for locking/unlocking. It's
> annoying because the local lock is a spinlock under the hood for non-RT
> kernels anyway..
> 

local_lock_t are spinlocks for RT kernels and just preempt_disable() for
non-RT kernels. Orthogonally I am exploring making memcg stats nmi safe
for bpf stuff and may look into making cgroup_rstat_updated() nmi safe
as well (which would require exploring local_trylock_t here).

