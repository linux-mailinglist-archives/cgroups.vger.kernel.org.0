Return-Path: <cgroups+bounces-3305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A391521F
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B617285F21
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7519B586;
	Mon, 24 Jun 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BOxl82ld"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610513DDD3
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242502; cv=none; b=Js2CwwAQPluoLSzY3czT+YsgROtKozxYKehp/FNnIARqK46S/9U3h+JZslmYwpW1DrAoDzjek3bPIgecCylZtA2nPWWmxg/9C/rcOS+GMWJgtOQpJiNlZCvwjytepJNEQGPuPLIqt8sjg9SS36vlcV2zifjWStOfzom3DJnxy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242502; c=relaxed/simple;
	bh=S8s+yX1kDXLOn8wBss/z5XFgwphs6CKYipXZlWpknUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkWUghbp6jsLFEYBQDL2gPrY0abnw25To2HfU9Ng+V5vPHEKm8+oF/NLsXiaXUb1NNXRdsiJNXyTmEI/L/mP7VeDEYjr18laqvVigppMA+N+lMUVYNo+WSP8K7lHc9r2u4mMPpOSl90vlPY+3iaYisi5JQc9nKstMXUWe0sMfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BOxl82ld; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: longman@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719242497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mlbe76eIK+t44kk/XWRZhfvBA54CwR57wx+DLukPvU=;
	b=BOxl82ldM/sEeuyRdG8oshCF6F9eOz/ZaPVCp9WOZRn5XKX2sSPGKZVal/U+0GNteeVT/L
	/kvORp6v/YdGVZrAu4/KgDBwWXhRnWnXZVA3bZBjwdL3BxLwDT+uyl2y/NOR2kwFHjgBOX
	XKwGLTr2YvVPwp2qWDmGrhD2Y4eBYO8=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: corbet@lwn.net
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akalenyu@redhat.com
X-Envelope-To: pehunt@redhat.com
X-Envelope-To: linux-doc@vger.kernel.org
Date: Mon, 24 Jun 2024 08:21:22 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Alex Kalenyuk <akalenyu@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
Message-ID: <ZnmO8izZPwYfiaRz@castle.lan>
References: <20240623204514.1032662-1-longman@redhat.com>
 <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 23, 2024 at 04:52:00PM -0400, Waiman Long wrote:
> Correct some email addresses.
> 
> On 6/23/24 16:45, Waiman Long wrote:
> > With memory cgroup v1, there is only a single "memory.limit_in_bytes"
> > to be set to specify the maximum amount of memory that is allowed to
> > be used. So a lot of memory cgroup using tools and applications allow
> > users to specify a single memory limit. When they migrate to cgroup
> > v2, they use the given memory limit to set memory.max and disregard
> > memory.high for the time being.
> > 
> > Without properly setting memory.high, these user space applications
> > cannot make use of the memory cgroup v2 ability to further reduce the
> > chance of OOM kills by throttling and early memory reclaim.
> > 
> > This patch adds a new sysctl parameter "vm/memory_high_autoset_ratio"
> > to enable setting "memory.high" automatically whenever "memory.max" is
> > set as long as "memory.high" hasn't been explicitly set before. This
> > will allow a system administrator or a middleware layer to greatly
> > reduce the chance of memory cgroup OOM kills without worrying about
> > how to properly set memory.high.
> > 
> > The new sysctl parameter will allow a range of 0-100. The default value
> > of 0 will disable memory.high auto setting. For any non-zero value "n",
> > the actual ratio used will be "n/(n+1)". A user cannot set a fraction
> > less than 1/2.

Hi Waiman,

I'm not sure that setting memory.high is always a good idea (it comes
with a certain cost, e.g. can increase latency), but even if it is,
why systemd or similar userspace tools can't do this?

I wonder what's special about your case if you do see a lot of OOMs
which can be avoided by setting memory.high? Do you have a bursty workload?

Thanks!

