Return-Path: <cgroups+bounces-4826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34809743D2
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F35B1C2564C
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D6192D6C;
	Tue, 10 Sep 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbOSDYcf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD4176252;
	Tue, 10 Sep 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998638; cv=none; b=pdB4InW7W26gw2mwoq6B5iUrX4SZ/Sx/SSIaHt93V+/jyYh6VK1dMJuEEU2/OtHUqfKvBiqALcjtOy06YZAu86wGKZ4o5S1xpTZAWV4EjyI7ezSnvFKcYfPTy0JqkCs5n2h8PDpbrM3qxZ43m2IqjuI9iBSvKLk8Y7ctn9wGtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998638; c=relaxed/simple;
	bh=rA7a3lcUg350+c2co4v/s/uUSnMAyYuo/DyHMaSivDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvEPs1tsPj5pZQZ9nN3MAHKD/DBg2unXft/1bc+VDr3yHSpI5WH1qfutZ4y+eDotGTyAnvcstrssI8D0SdEyBmDjh2jdr8zUasLkJOsGXu3lgN+V0vh38pISGkSuFuAZKulVZp3ZbbEGcEgCgeCzemq3p7LMNAa+j1xAvD4f7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbOSDYcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A830C4CEC3;
	Tue, 10 Sep 2024 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725998638;
	bh=rA7a3lcUg350+c2co4v/s/uUSnMAyYuo/DyHMaSivDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbOSDYcfhXay69roObJpzt+I7PcTvh+KovcxvKHzXuOpHtqVKbSQpJ8hetx5BMms7
	 z0cBkb+Jcif9VjgJGGGyMDhq2GSM3WNg6iV04ChqpDdFPPfYXAfK4UASDoWDW0F8FL
	 epNA0gA1RXSmnN1BgAnXYXhtjr/CQobI/EzrkDZHwVYLNjalaoclThJnsR/K+uakdf
	 zg3wLPNJhz82WJSEsKzjozLzeK0dUJqAAtsQ6LqddvP403YXkRkjY4tuCecDH4hTNg
	 Og71JycRfBk4d7ZEw/mI+BE2r/n780DqbAsc6563aXS9ZOwP9kB7U80wmkO1+GluK/
	 sLh+x+3YGR5fg==
Date: Tue, 10 Sep 2024 10:03:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 3/4] cgroup: Disallow mounting v1 hierarchies without
 controller implementation
Message-ID: <ZuCmLXMLQd7xMs06@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-4-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-4-mkoutny@suse.com>

On Mon, Sep 09, 2024 at 06:32:22PM +0200, Michal Koutný wrote:
> The configs that disable some v1 controllers would still allow mounting
> them but with no controller-specific files. (Making such hierarchies
> equivalent to named v1 hierarchies.) To achieve behavior consistent with
> actual out-compilation of a whole controller, the mounts should treat
> respective controllers as non-existent.
> 
> Wrap implementation into a helper function, leverage legacy_files to
> detect compiled out controllers. The effect is that mounts on v1 would
> fail and produce a message like:
>   [ 1543.999081] cgroup: Unknown subsys name 'memory'
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

