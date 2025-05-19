Return-Path: <cgroups+bounces-8263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73209ABC852
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9599A1B63E65
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877C212FAD;
	Mon, 19 May 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHo/aTj1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8E1A3142
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686051; cv=none; b=bOF5g3W3Ngo+r+E4j2cbSwUsrAF7f6+aPkSQUflzA1JpvAtQzrk8PeBFolalVfSx1GlUdtPu0U19/fn7PhcXIOvJub4oGLL/KlFFz0TWvDRHKf2SGcIZX3wC34xltgxjZ8+dZVFiS2Q6k1KnZT9PzZilnGrK5we3KG+nEpG5bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686051; c=relaxed/simple;
	bh=WL5FzNf1Az/Ya8//sQ6NFIjPyS7N43R3QxawkzN6FX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leXSaCz5/i4T7AO8J4FtO9I7DrE4FyAZVAbPyPiu9WAxbS95ROLnEZGQiYRCNn9y1gKCqrMBUgYNIyZagsCU4XeCOF7P3oUmYN1/Tchqt1RB9PvhayUcKKdR/LIByzZgUA4fVDr/QfVsGqxsABEqM5TLaDsiiMcT7DNafulny1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHo/aTj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68652C4CEE4;
	Mon, 19 May 2025 20:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747686050;
	bh=WL5FzNf1Az/Ya8//sQ6NFIjPyS7N43R3QxawkzN6FX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHo/aTj1NJlsWyjBDxdwI+WmfIiwrEFgBB8Ol85PBnNriBfsaVt0ev88ihjLwh8Iv
	 IAlWWBBPuAWgbcCybPlfefxk1RIZQbm6SvlG0AgC+JzzoTC1hrf+z5dDWqSijhPpSc
	 t+lqMMjNUZMhBIW1COmmzxTKQnOQs8O8cw+M4y4/WlRsA7ks7DxO4D0pz/0C8dcWm8
	 d+iFqV91F42IeA9OGU7QHIYmCk6KlqHbKlSlosJjckRfSVZu36WJYp0H8kBWLRI3SS
	 b8Ba71OV21T65SlRtQDYuY/PBqLQ8DyX2YichdTNhsLKWRjDQfbB9zPobYiQmLucOx
	 6/lCmgqQgwzhw==
Date: Mon, 19 May 2025 10:20:49 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 1/6] cgroup: warn on rstat usage by early init
 subsystems
Message-ID: <aCuSodoyCVHpkfAj@slm.duckdns.org>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
 <20250515001937.219505-2-inwardvessel@gmail.com>
 <aCuR-1wHin4gMa-V@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCuR-1wHin4gMa-V@slm.duckdns.org>

On Mon, May 19, 2025 at 10:18:03AM -1000, Tejun Heo wrote:
> On Wed, May 14, 2025 at 05:19:32PM -0700, JP Kobryn wrote:
...
> > Since we are in the early init phase, the rstat fields cannot be
> > initialized because they require per-cpu allocations. So it's not possible
> > to have css_rstat_init() called early enough (before online_css()). This
> > patch treats the combination of early init and rstat the same as as other
> > invalid conditions.
...
> Applied to cgroup/for-6.16.

Applied this but we might want to WARN on actual flushing and skip flushing
rather than disallowing early_init + rstat wholesale if any subsys wants to
limp along between early_init and percpu allocator being up.

Thanks.

-- 
tejun

