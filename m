Return-Path: <cgroups+bounces-8476-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3659AD44C0
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853DE17B6D2
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EBF283C9C;
	Tue, 10 Jun 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAPqIRX6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD01282FA;
	Tue, 10 Jun 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590798; cv=none; b=ifVC1CE9ScaPOYk89wIR/fvIx4xVvZ1pJG7vhlYZi+dddYaKOqhdr1H6lwEBl70hsT9YKh/wF7sw7AB/9KpGOcoIJD6Q0GXH5nvm4Fwob1s4Zc9Ojl67VOYOnkyHFwaYeO2ycVvxqmSwXCp3CoIy5DIKKDs6xu4t0jsNJfTm5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590798; c=relaxed/simple;
	bh=V3sF/svjtmJ8AfC4ZuaHUSixySfbbr0zn+GGwL8oMac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5SMHJ5wEJVUj47Y36QrF5wbwh/+GLAiSq/RlUlbGXoyIdJvXvgV+YpRpXSVrj4xrgLDU5zQyXbMzZw6eMciPsViqD+ElDsDUv6EL/iIeJ1SSMXi5ciH+1PTj5fmP4JIOkbOX2OnRCkxsnpU+qPvGItCIt9uvhdSGnSfnUMBplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAPqIRX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA4C4CEED;
	Tue, 10 Jun 2025 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749590797;
	bh=V3sF/svjtmJ8AfC4ZuaHUSixySfbbr0zn+GGwL8oMac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAPqIRX6+Y8GydwV/+d7TU7oitzkde26YFmNB31a4y6RwVNVttHxBF5t+QlMiHK4P
	 aQIYPwS2Fq4pjmIiQ1V2I8a6+p9gVND0W05Z1xJUw8NS2Vubh1qkfCA2mxb7I0tx+u
	 4Woi0l1kDODHVxwpwtlikCknFyISa2Itb1UjiNi0l72S2lndZ2GAexlvKWQbqbcshz
	 qBYmaABJ8Fvb4xqnizMnNnbqOEYPPveAV08Q+UkSwK1ClzIqkoU5Ik+ebf5/eXnjK3
	 Ul0mRIT5EXLRPxa6K8R/WjWEpmeQURMyZwjH+v4AgNBKh63yuKzNkVFmsdPfyoUspB
	 hQ3Ucof/sHayw==
Date: Tue, 10 Jun 2025 11:26:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <aEijC1iHehAxdsfi@slm.duckdns.org>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609225611.3967338-3-shakeel.butt@linux.dev>

Hello,

On Mon, Jun 09, 2025 at 03:56:10PM -0700, Shakeel Butt wrote:
...
> +	self = &rstatc->lnode;
> +	if (!try_cmpxchg(&(rstatc->lnode.next), &self, NULL))
>  		return;
>  
> +	llist_add(&rstatc->lnode, lhead);

I may be missing something but when you say multiple inserters, you mean the
function being re-entered from stacked contexts - ie. process context, BH,
irq, nmi? If so, would it make sense to make the nmi and non-nmi paths use
separate lnode? In non-nmi path, we can just disable irq and test whether
lnode is empty and add it. nmi path can just test whether its lnode is empty
and add it. I suppose nmi's don't nest, right? If they do, we can do
try_cmpxchg() there I suppose.

While the actual addition to the list would be relatively low frequency,
css_rstat_updated() itself can be called pretty frequently. Before, the hot
path was early exit after data_race(css_rstat_cpu(css, cpu)->updated_next).
After, the hot path is now !try_cmpxchg() which doesn't seem great.

Thanks.

-- 
tejun

