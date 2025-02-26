Return-Path: <cgroups+bounces-6722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309DA46D32
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 22:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9B716B7C5
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE1241C98;
	Wed, 26 Feb 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6R/KFIV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20225742A
	for <cgroups@vger.kernel.org>; Wed, 26 Feb 2025 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604427; cv=none; b=lEqjReDfBuJ9zQP4etc6ITa/VS8Mx++Ttj5F7IjsBGDyZdyx1tw5xcHEeUV09n3/QKFVIMKqswSeOiya3XYjND5WodPCO22PC8ZywGRhSYz7Rf2Na5TffPZLb3S8tR92+tRwKfXSd+R6hhP2CpyhQAp0jafJjTO13bPmfO5iprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604427; c=relaxed/simple;
	bh=P6EvdgYE3hi3CZqdLjhQ96p5OUzYvR+kAXaMZb08x3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR5AJTRRA2gLXooA0Zu0jeWTUH+Au8gfrHfC4bxuPK+wS82DNi4CnXKwY2aVoowVA3JcA934Bwil36pT7M398MsmMjEaP98Y4Kq/6xf0D70FddGRycB2CKEp8XGJZcbeSRHXvNBGgkzftLZXW1nZbCcnYbMtRRUGy3PZRWM1Q+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6R/KFIV; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 13:13:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740604412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWPw8dfW2CKCuC+NKpHNqPJSNvcldwRNktFZqPfqU2s=;
	b=E6R/KFIV4Rp5HH5CLpsx7TNcbvC7wNUl3YqA/sjctG1VLvuVcfn9qd2ixbFxmEpZPXEaXE
	S0Rx7kEcq1J7/dIxW5JZgGHxQDfHUS1v1z8Y5TAVHbnqUFMBdW5gjFF2R+/9unLJOw6mnV
	gaNEVfOIwZGOlLShLf5Or1J9AvUVdTE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <rpwhn5zwemr63x4tafcheekdmqullcjvvabdgrm3jgtbtfwgki@6sxglgvtgzof>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
 <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
 <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
X-Migadu-Flow: FLOW_OUT

Sorry for the late response.

On Mon, Feb 17, 2025 at 06:57:46PM +0100, Michal Koutný wrote:
> Hello.
> 

[...]

> > The most simple explanation is visibility. Workloads that used to run
> > solo are being moved to a multi-tenant but non-overcommited environment
> > and they need to know their capacity which they used to get from system
> > metrics.
> 
> > Now they have to get from cgroup limit files but usage of
> > cgroup namespace limits those workloads to extract the needed
> > information.
> 
> I remember Shakeel said the limit may be set higher in the hierarchy for
> container + siblings but then it's potentially overcommitted, no?
> 
> I.e. namespace visibility alone is not the problem. The cgns root's
> memory.max is the shared medium between host and guest through which the
> memory allowance can be passed -- that actually sounds to me like
> Johannes' option b).
> 
> (Which leads me to an idea of memory.max.effective that'd only present
> the value iff there's no sibling between tightest ancestor..self. If one
> looks at nr_tasks, it's partial but correct memory available. Not that
> useful due to the partiality.)
> 
> Since I was originally fan of the idea, I'm not a strong opponent of
> plain memory.max.effective, especially when Johannes considers the
> option of kernel stepping back here and it may help some users. But I'd
> like to see the original incarnations [2] somehow linked (and maybe
> start only with memory.max as
> that has some usecases).

Yes, I can link [2] with more info added to the commit message.

Johannes, do you want effective interface for low and min as well or for
now just keep the current targeted interfaces?

> 
> Thanks,
> Michal
> 
> [1] https://lore.kernel.org/all/ZcY7NmjkJMhGz8fP@host1.jankratochvil.net/
> [2] https://lore.kernel.org/all/20240606152232.20253-1-mkoutny@suse.com/



