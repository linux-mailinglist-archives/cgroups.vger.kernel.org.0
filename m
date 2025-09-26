Return-Path: <cgroups+bounces-10471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B9BA4ABB
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32447170DAA
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A392FC86B;
	Fri, 26 Sep 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PzA/G7q1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E62FBE13
	for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904632; cv=none; b=XKJFkQxDH8u0iXvxa2C37k/gzGOn/xndCUVK0qsbZR2jC0cZomqlov/xXUD/xWyydb4KRknB7opUGnI2JjXlUzfF7SNdA6E5tJMHcMGv01kdFtvFpokx5YQc6l3j5dyXxFNpOg7kDu1jFeAdxd8oPqF89NT/uA32DWKoO+2eUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904632; c=relaxed/simple;
	bh=ptSlmjcBR9Vw/79YgXLD+5rbUgRgUsfCRbnSkIPuTh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5AJQhPSaqJ4J1LYgGx+vHN4qy8TipWATx1L1H4pMO6wmUHsNubPDMAL5SDbywo5Dlwo4cshd3IMBk/neihUBw0O/zKeKUWhhAduARs7rvMa9gNBLdjq/utF2HwUCJ4VnQ5ccxlXf/CxBIrHJjwHWhQcLxZ2Ul+wEGOJmRWm7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PzA/G7q1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Sep 2025 09:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758904627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBmaD1iUgrP9LAykZKE5mdL2TUB2y38Dq6j4bJYe8es=;
	b=PzA/G7q14iI5lyvL2jQs/Q4WwjzEmT9PZkSBDZhX3shplXsvXRByZWlJ/0uho5YjTKjbiE
	EzpO/2mS4VDnypzH+8oS4xP5OPQ1BXcbaXPCVVtAUI/s8Bd7/ksCRYj5v67k5fcF5ojTmu
	t/8zXuDXrLsK68IGAPLi/qfiJTQfZmQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, 
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <v4ihmnzafzwfgdbk6gcnl76bjqko2t4wdz3vy32vjuzffzzt6i@uxecpmupkqh3>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
 <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
 <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
 <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
 <fc91a0ab-e343-4f7c-8fc3-508ab0644e42@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc91a0ab-e343-4f7c-8fc3-508ab0644e42@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 26, 2025 at 02:57:39PM +0800, Qi Zheng wrote:
> 
> 
> On 9/26/25 6:35 AM, Shakeel Butt wrote:
[...]
> > > 
> > > Yes, css_is_dying() can be used but please note that there is a rcu
> > > grace period between setting CSS_DYING and clearing CSS_ONLINE (i.e.
> > > reparenting deferred split queue) and during that period the deferred
> > > split THPs of the dying memcg will be hidden from shrinkers (which
> > > might be fine).
> 
> My mistake, now I think using css_is_dying() is safe.
> 
> > 
> > BTW if this period is not acceptable and we don't want to add is_dying
> > to struct deferred_split, we can use something similar to what list_lru
> > does in the similar situation i.e. set a special value (LONG_MIN) in its
> > nr_items variable. That is make split_queue_len a long and set it to
> > LONG_MIN during memcg offlining/reparenting.
> 
> I've considered this option, but I am concerned about the risk of
> overflow.

If you modify it only within a lock then why would it over or underflow?

> 
> So I will try to use css_is_dying() in the next version.

No objection from me but add a comment on the potential window where the
deferred thps will be hidden from the shrinkers.


