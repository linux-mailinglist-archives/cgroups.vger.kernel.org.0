Return-Path: <cgroups+bounces-8479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCBAD4616
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 00:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6789B17225D
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB328A41B;
	Tue, 10 Jun 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA45rXjf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40C281357;
	Tue, 10 Jun 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749595161; cv=none; b=fvsNqmjcTeHb/+7NTIzjxJz7lBdscUywgFN7zokNEI4LRd2KrW95n7gALRVYL/iXmO+79UXyP2Y7ZaykCwEGXFovnus3cVVFbGwyteJPrrr8am+SSUptE3u/X7ZxFOxmOZpkas+m4ellhJSHCLScYcYhjOi93dQ/Q8TWkFKCIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749595161; c=relaxed/simple;
	bh=+IqBi5TvZDiOz6C2BvPBxPsgAN4p4qlLrgsfuFspjGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxajI8yUzgODQY3FOekFsiPd1QTBEegu/qbLdK3ZOeIk0RPRqwZrL+Bjyvn73PAioA1SSmiV516leAQZCmU+LOlnxxFx1k+7GXpi4fdz6vGeXvanb7WU5rV1UbQTHcRmnFbL04TCA7zjxblrqy8LVsXCSWibmOv34lMKI9O0X24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA45rXjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9FBC4CEED;
	Tue, 10 Jun 2025 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749595159;
	bh=+IqBi5TvZDiOz6C2BvPBxPsgAN4p4qlLrgsfuFspjGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iA45rXjfts3BL4hUeIUxxe+byrtKWMod75y24CPGNN9SvmqJ6rqAd+CqWKZW3yG6w
	 kaDyCJ4wjLA+FqXK7EkN76If5n4Hj0k4ILNtarEO1jq/st6cUjbPwTKFtKsoajE9H2
	 HecPOJr4de83Yml+8tI9KJuPPpw+eCcGSKt615dRrpaiE77SGPxk608iLyZdDCfRGT
	 q+VmnC2mbqeyj6GZGUQT/iG1PVQrFDvNNQsteEeadKnFyDy9EEVYYoOI94hbkRiys5
	 +PgqlvtSk9XDM/zk8Qd/9GQu1+WeLghEI4ZH3sUSslOZTwEhaM87BBg6QfjElWcET7
	 QZm5qvYbr0JtA==
Date: Tue, 10 Jun 2025 12:39:18 -1000
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
Message-ID: <aEi0FplA6eZUHF01@slm.duckdns.org>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <aEijC1iHehAxdsfi@slm.duckdns.org>
 <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>

Hello,

On Tue, Jun 10, 2025 at 03:31:03PM -0700, Shakeel Butt wrote:
...
> Couple of lines above I have llist_on_list(&rstatc->lnode) check which
> should be as cheap as data_race(css_rstat_cpu(css, cpu)->updated_next). 

Ah, I missed that.

> So, I can add lnode for nmi and non-nmi contexts (with irqs disabled)
> but I think that is not needed. Actually I ran the netperf benchmark (36
> parallel instances) and I see no significant differences with and
> without the patch.

Yeah, as long as the hot path doesn't hit the extra cmpxchg, I think it
should be fine. Can you fortify the comments a bit that the synchronization
is against the stacking contexts on the same CPU. The use of cmpxchg for
something like this is a bit unusual and it'd be nice to have explanation on
why it's done this way and why the overhead doesn't matter.

Thanks.

-- 
tejun

