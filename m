Return-Path: <cgroups+bounces-6436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5EA2992A
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC2F3A3304
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBC1DB363;
	Wed,  5 Feb 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FrG3Tz5j"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932881FDA7C
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780290; cv=none; b=QPJtwt1FXxKi/q2ug1KMRODh7NIvSWhrcBEv/NoDBFayf6yqPnQoHG6dmu6+UzQMGMRJ2wRUb+DHelLHX+NKBdk66ukanJ1RGBhbHOOCemZrfjsNVSUUH7ji/idfPFWzt2R4g7ANABtLB+yTIKQBE1ZlTwWuHnps/2LCEueVypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780290; c=relaxed/simple;
	bh=7/5ms4838rUKEwFG5CPvHDuW/r1yn4Xr3avElGtvSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh+f/bzYihzk2o+HkoXcHewAASHTOfBVTeHfPSTBkpCLk9azIHtLReRVmxpFWMoEdF7bxw6I/e8Bdtkleg8nurXqJ+3WvmfnF54QlJ2AYAgxgA4HdsxYcrS4817yRlZTQHNU4zb72GWxYWWYd6Sy4/jVkpcX/ipnRGzlkazSJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FrG3Tz5j; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Feb 2025 18:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738780283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRpIxuobdJIlfnoT0aXnXGySqVxhsDeVlxOEkWcMenE=;
	b=FrG3Tz5jxfPplMSdfJDAqliNDT/rwj5qayn6aNty0yLNFl10eggjkOv4QxjOkWLTxP8ndU
	ZNUjrodYYvr5GEGNSvIkR4PIbZLg9CEAo+hQtPfS1FQeXv6IH1ExVqBh/7qdnxwa/TU9wc
	Qv2acHWk9FkVXpSw8fjOl/6HRm2Imn8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-mm@kvack.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Allen Pais <apais@linux.microsoft.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: A path forward to cleaning up dying cgroups?
Message-ID: <Z6OucWdMtuuVLizY@google.com>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
 <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
 <20250205180842.GC1183495@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205180842.GC1183495@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 05, 2025 at 01:08:42PM -0500, Johannes Weiner wrote:
> On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > On 2/5/25 12:48, Hamza Mahfooz wrote:
> > > I was just curious as to what the status of the issue described in [1]
> > > is. It appears that the last time someone took a stab at it was in [2].
> 
> If memory serves, the sticking point was whether pages should indeed
> be reparented on cgroup death, or whether they could be moved
> arbitrarily to other cgroups that are still using them.
> 
> It's a bit unfortunate, because the reparenting patches were tested
> and reviewed, and the arbitrary recharging was just an idea that
> ttbomk nobody seriously followed up on afterwards.
> 
> We also recently removed the charge moving code from cgroup1, along
> with the subtle page access/locking/accounting rules it imposed on the
> rest of the MM. I'm doubtful there is much appetite in either camp for
> bringing this back.
> 
> So I would still love to see Muchun's patches merged. They fix a
> seemingly universally experienced operational issue in memcg, and we
> shouldn't hold it up unless somebody actually posts alternative code.
> 
> Thoughts?

I don't have a strong opinion here. Reparenting is clearly not perfect,
but I agree that we don't have any better solutions, only vague ideas.
I believe Muchun's code would require some refresh, but generally is fine
to merge.

This all comes up to the handling of memory shared between cgroups.
Sharing can be spatial (2 or more simultaneously existing cgroups) or
temporal (a cgroup is being deleted and recreated, the workload tries to
reuse old pages). The reparenting turns temporal sharing into the spacial.
It helps with dying cgroups, but comes at the cost of permanently wrong
accounting and issues with the memory protection.

Thanks!

