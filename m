Return-Path: <cgroups+bounces-6448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06417A2B1FB
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 20:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5B51889483
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B31A23B8;
	Thu,  6 Feb 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KkNqJ9xm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D71A0BFE
	for <cgroups@vger.kernel.org>; Thu,  6 Feb 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868957; cv=none; b=eErAslzCdQfrmagYUlB3UjZU9xFt2nwoz8IZnhV+wMgc1avLeDoVXyvVGqDwvE13rxPRzqgslEPp40N8nrGHjGNhm/Ms4fwksTr7yfJxDY5pDxj5bLr+I3AcyWpHV7b1kvpen3qQY8cozR08GjPw7aRVDZ9CoxFTCvh5Aul+uFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868957; c=relaxed/simple;
	bh=L83AA3VR0AJllVBvZlrGiA30ExiaPsbmWF6PmofTQNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJivEezUp3nQpwaaOeH6BZWjsGlQ6G0LeE9gXGqvffVeBzjqARZr7NUjI9AaXkoLM+hkL0EKzhCqfgNlC/KOm/NVsgcsUbbWKtT7m5Yoys8kIbDgWEv7obVZq9Kpx1Ua/DSbd7zTvypDl4l2Qqg/Wz1Yn3R+wZ1UFVVECpNaDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkNqJ9xm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Feb 2025 11:09:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738868952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDtLyV5ZW85qPe+cCxXuWO18ZWNEpGaNQrn9/hMmsxQ=;
	b=KkNqJ9xmV++MrcFAiUc8EGYB4ZnytHs8ecwkf4YC4ilwwWnsq4NrA63Sx0PoxboEPj1CY3
	Ps73IBskQrVS/oYI5pKoaBpYqUtKzqKzQMCw/nb/Tba1BDDMGNI3DwbjL+l7W5YgOYIx7P
	5ho9jlfXidPjPsFL5ME7uXsSmzVBYi0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 06, 2025 at 04:57:39PM +0100, Michal Koutný wrote:
> Hello Shakeel.
> 
> On Wed, Feb 05, 2025 at 02:20:29PM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Memcg-v1 exposes hierarchical_[memory|memsw]_limit counters in its
> > memory.stat file which applications can use to get their effective limit
> > which is the minimum of limits of itself and all of its ancestors.
> 
> I was fan of equal idea too [1]. The referenced series also tackles
> change notifications (to make this complete for apps that really want to
> scale based on the actual limit). I ceased to like it when I realized
> there can be hierarchies when the effective value cannot be effectively
> :) determined [2].
> 
> > This is pretty useful in environments where cgroup namespace is used
> > and the application does not have access to the full view of the
> > cgroup hierarchy. Let's expose effective limits for memcg v2 as well.
> 
> Also, the case for this exposition was never strongly built.
> Why isn't PSI enough in your case?
> 

Hi Michal,

Oh I totally forgot about your series. In my use-case, it is not about
dynamically knowning how much they can expand and adjust themselves but
rather knowing statically upfront what resources they have been given.
More concretely, these are workloads which used to completely occupy a
single machine, though within containers but without limits. These
workloads used to look at machine level metrics at startup on how much
resources are available.

Now these workloads are being moved to multi-tenant environment but
still the machine is partitioned statically between the workloads. So,
these workloads need to know upfront how much resources are allocated to
them upfront and the way the cgroup hierarchy is setup, that information
is a bit above the tree.

I hope this clarifies the motivation behind this change i.e. the target
is not dynamic load balancing but rather upfront static knowledge.

thanks,
Shakeel

