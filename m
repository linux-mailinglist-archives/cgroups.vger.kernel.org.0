Return-Path: <cgroups+bounces-6435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D2A2988C
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8AB188A88D
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FC1FC0ED;
	Wed,  5 Feb 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EoA+aCHE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9E1779AE
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779379; cv=none; b=nO/nYUq1f/OO5YxLuL7dE5b8R72V9XtZwttyaRmt5rONl5ItDFh4nbAJGsuTQ5HVY3POlLMAOZSjv6Lq3oTKcuK8trfpJrv8A1CFiUbJB/WwgysgX4PnVUMq2r2A44Tnw+Mw7uTEffsLaTY/iam9ti15XhRZUZqIX436AG3OG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779379; c=relaxed/simple;
	bh=DS6DbwHGbCZpbzDRkFM4wrbs2iBdv+XhTRDUzdwpWXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzlSpI3fGR5UdMTAOfkklVO3LEsxh2FUWQJnyUuUPNZmf7ZNnXNVngbqLcejxFBjwk4sEYcp7y7dKQXaTH2YYRK4YZEWvovtsBwJo2PdYyww/FDH/+4JBF9ylR7JBih/imqw8TSw9UefdXkh/bXtyN2jeWyJTQt5866gszGuQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EoA+aCHE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Feb 2025 18:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738779369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJK0Vy+lQ3QID6M2iQP3pTvhmW1IQBmtWP8DLFUCWt0=;
	b=EoA+aCHEdTaupGOpNDxd0hi1UNSHnRR5xeaEc5uGgR6DQfspXVfA6JoIxEsL4fL4WzuG4L
	AXYUbHFckEwi6yUzdLpXf3kXS9lQ9Zb2GrPT44atPo81oacqpwUAHGVGwauzNKTkYBVhgf
	Q4TxO7b6Cc2Vad1CKbl40YifntgKIR8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Zach O'Keefe <zokeefe@google.com>, Kinsey Ho <kinseyho@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Allen Pais <apais@linux.microsoft.com>
Subject: Re: A path forward to cleaning up dying cgroups?
Message-ID: <Z6Oq47ruBzfQh0do@google.com>
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

There was an RFC series [1] for the recharging, but all memcg
maintainers hated it :P

https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@google.com/

> 
> We also recently removed the charge moving code from cgroup1, along
> with the subtle page access/locking/accounting rules it imposed on the
> rest of the MM. I'm doubtful there is much appetite in either camp for
> bringing this back.

Yeah with the charge moving code gone the case for recharging grows
weaker.

> 
> So I would still love to see Muchun's patches merged. They fix a
> seemingly universally experienced operational issue in memcg, and we
> shouldn't hold it up unless somebody actually posts alternative code.
> 
> Thoughts?

Adding Zach and Kinsey who were recently looking into this from the
Google side.

