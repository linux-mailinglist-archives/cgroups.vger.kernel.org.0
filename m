Return-Path: <cgroups+bounces-3873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9F93AB32
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82381C227D7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DDBA4D;
	Wed, 24 Jul 2024 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dZbpGEIK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA617547
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788027; cv=none; b=FIUFCrvaDgP/pxEaCFV4DnonghFZVrMd6ajlDjbqlng6t/uZBeiBi4tG00e9fIsTjmQVvJk6wyTe8+kc38xyXwGzGOgbHaAeAj4T6hH13Le+Ej6zIWhMzKWHl0EPeNTi3kY584GScncWDeSQA60Id2k1kCEx67F80pYerKzZlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788027; c=relaxed/simple;
	bh=jMFMy1WXtcgdTiL4I8974BQuPiDR6/KpkaDwtpYs1Yo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kM6FCYQalt3qs9NFYBHTTO7fDs9KRF4+b1UzBx773PgNNUZyH6Eeicq8wQbt9J3Fl3Fjqma94OD2C1vRyfObxIAp7Ac4KB9rZtL6bDX8O/1juSC/HtUfkLFSYucr+QIyATW04+RUdK7WwL2W/esF7msrJSCjFOw/CUy26aD+Z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dZbpGEIK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721788022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ztY/NjuWc2cvxxgU7UmDaQhXR61iJRMZ7mSotHEdLw=;
	b=dZbpGEIKEtFZRMBHTGtRUvROYyhut7ZWQf549kr3MFoZWi+0i3oo9jKJzkN6j6WWm+JcBV
	WX50K2ATLfKOazJQf4c7o+wRvvGNxaKrH/73NAGZRfSPp1zITmHn4smgHBmI1DT4IICeLN
	tkeJTrG7MuNAAqT7PoKZyXQN+hQgWAc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm: kmem: add lockdep assertion to obj_cgroup_memcg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <i2oflmxuymmqrn37l5uxadibfrfapr3rf5vwzbvrsfenc6fdjy@xqk2ttcxtswi>
Date: Wed, 24 Jul 2024 10:26:24 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E1AFB404-3305-47D6-AABE-EBAD83E5DFF4@linux.dev>
References: <20240722070810.46016-1-songmuchun@bytedance.com>
 <i2oflmxuymmqrn37l5uxadibfrfapr3rf5vwzbvrsfenc6fdjy@xqk2ttcxtswi>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jul 24, 2024, at 02:39, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> On Mon, Jul 22, 2024 at 03:08:10PM GMT, Muchun Song wrote:
>> The obj_cgroup_memcg() is supposed to safe to prevent the returned
>> memory cgroup from being freed only when the caller is holding the
>> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
>> ignore thoes conditions when users call some upper APIs which call
>> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
>> the link below). So it is better to add lockdep assertion to
>> obj_cgroup_memcg() to find those issues ASAP.
>> 
>> Because there is no user of obj_cgroup_memcg() holding objcg_lock
>> to make the returned memory cgroup safe, do not add objcg_lock
>> assertion (We should export objcg_lock if we really want to do)
>> and leave a comment to indicate it is intentional.
>> 
> 
> Do we expect non-memcg code to access objcg_lock? To me this is some
> internal implementation detail of memcg and should not be accessible
> outside memcg code. So, I would recommend to not mention objcg_lock at
> all.

Also make sense. Will update next version.

