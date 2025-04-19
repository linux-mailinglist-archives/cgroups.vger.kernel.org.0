Return-Path: <cgroups+bounces-7667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D3A944B5
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D9016FABC
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BF14601C;
	Sat, 19 Apr 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpKvX9rV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344421DFE22
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080636; cv=none; b=HkqrpDTuKrgCh6kewj3NnSDKKldLsgo9y5x3lh3Fh4dRdw/ZGGQpjMlr+StFnq3BOOzupxNn/Ft6sO4hNHlZxmGRmuGlAcLEPeHVxZQSbheZ0bb009Jyhnu8GnwwoO2DQwbCroIXL8O57xWhCbs9IMaLAeK750r4D9D8t3Tq6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080636; c=relaxed/simple;
	bh=RNrAWejdpwpx31ojS2nsE1RAqW/UeizR6207ITFqL2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMImMgYhbYni6BB7RuD9vttzwKA+mVaGt1CDJEFHaUzC91mCLPhL9o5J3tSTRfM9CPiTVzQ9eY6D2IJp5lUvWEikSa/Wcq8zflmxNBvtMGT0OkZqXaTqUIQonrRv6j68mMS7J55IXKrpdOnjxupgnsmpf7tF1i6H1DKMEvk7tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpKvX9rV; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Apr 2025 09:36:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745080621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3gAqc7ZMsVtcf6IciKTKwKTL0on26u+L0x1CBV9xTls=;
	b=JpKvX9rVoPn321DOwtQil6lH+d2atYqiTTUjWcI+jNgRMLMNOmWuVi1nYJ83M3syXsYt3l
	i/kS7Mi095iKRFj0AqYdtVPzHO7KH7DVrOuyyVoRSGJIvyvCnopOnxc7QJdMARZtXV6fOn
	DbpM4l652S0lNHal3Uvcq2QIK6S6738=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
Message-ID: <rgze2xgrslssxoe7k3vcfg6fy2ywe4jowvwlbdsxrcrvhmklzv@jhyomycycs4n>
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
 <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
 <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
 <aALNIVa3zxl9HFK5@google.com>
 <nmdwfhfdboccgtymfhhcavjqe4pcvkxb3b2p2wfxbfqzybfpue@kgvwkjjagqho>
 <aAMVWsFbht3MdMEk@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAMVWsFbht3MdMEk@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 18, 2025 at 05:15:38PM -1000, Tejun Heo wrote:
> On Fri, Apr 18, 2025 at 04:08:42PM -0700, Shakeel Butt wrote:
> > Any reasons to prefer one over the other? To me having separate
> > files/interfaces seem more clean and are more script friendly. Also
> > let's see what others have to say or prefer.
> 
> I kinda like O_NONBLOCK. The subtlety level of the interface seems to match
> that of the implemented behavior.
> 

Ok, it seems like more people prefer O_NONBLOCK, so be it. I will send
v2 soon.

Also I would request to backport to stable kernels. Let me know if
anyone have concerns.

I asked AI how to do the nonblock write in a script and got following:

$ echo 10G | dd of=memory.max oflag=nonblock

Shakeel

