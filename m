Return-Path: <cgroups+bounces-5359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B959B869B
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 00:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D6B1F218B1
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB11E0DE5;
	Thu, 31 Oct 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dBMu/PYg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B621CDFB4;
	Thu, 31 Oct 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415966; cv=none; b=WJW9lIQcHRvOVD9QSQgBPvjl97T77N6rrCw+7oVH2fdpNk8hZWozK8RHjyAYSn5eSfjIAqh1KhKc4RIGBIYCpF7YdzlZ7xFTA3LIXcD/t4+WXrmHDgpCyvOC2oH2/AS2TR1UW1dFzdficLe5pOKJPO04W0XFc/U+oQTfgwlv5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415966; c=relaxed/simple;
	bh=eiOA2ir69JdE0DAQx5hUj8uF0lZxuN/074mQOsVdbMY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iBgy8DHpANVEfBllrM0Nej8xc1nsRnoq3yqwzXEF7LK9c8QitLcm2A/sqkRIvBz13M+ZscNYdpm4ctxgX9JmwXbqCh+3Pvq77aSMunPi5fD2GonxyROXQcaBnnUHW3Pbt720fdLzbroySivwAHlSt9BY12e7+8wxSEeYv1yDN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dBMu/PYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC8EC4CEC3;
	Thu, 31 Oct 2024 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730415965;
	bh=eiOA2ir69JdE0DAQx5hUj8uF0lZxuN/074mQOsVdbMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBMu/PYg97a2NKvVHbrjBWh2mNwSXmrIiiuWc7RkO7KcIjMUlkrCOvUdL1tbtpl6P
	 U/WI/rrgKK3NpKFPkwLG95EgA9//Em21Sb6D6CpSWT8JPPepjf60rcSdyiuCTu5A54
	 9dFL7m1gAeuYyjSGGUaOGwjOG9CqnH5G+xf9wXC0=
Date: Thu, 31 Oct 2024 16:06:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kinsey Ho <kinseyho@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>,
 willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand
 <david@redhat.com>, Joel Granados <joel.granados@kernel.org>, Kaiyang Zhao
 <kaiyang2@cs.cmu.edu>, Sourav Panda <souravpanda@google.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
Message-Id: <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
In-Reply-To: <20241031224551.1736113-1-kinseyho@google.com>
References: <20241031224551.1736113-1-kinseyho@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

hm.

On Thu, 31 Oct 2024 22:45:49 +0000 Kinsey Ho <kinseyho@google.com> wrote:

> We noticed high overhead for pages allocated for struct swap_cgroup in
> our fleet.

This is scanty.  Please describe the problem further.

> This patchset adds the number of pages allocated for struct
> swap_cgroup to vmstat. This can be a useful metric for identifying
> unneeded overhead on systems which configure swap.

Possibly dumb question: can we switch swap_cgroup_prepare to kmalloc()
(or kmem-cache_alloc()) and use slab's accounting to satisfy this
requirement?

> Before adding the new stat, Patch 1 introduces a generic system-wide
> counting interface. 

I don't really understand this one and would like to hear much more
about the motivation.

And: "the existing use case" is OK with a global counter, but what about
future use cases?

And: what are the future use cases?

Thanks.

