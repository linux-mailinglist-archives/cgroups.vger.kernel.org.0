Return-Path: <cgroups+bounces-7112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419EA664A5
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 02:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6281917F265
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015414D2B7;
	Tue, 18 Mar 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/rNdAR3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535A126C02
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259985; cv=none; b=PzLxMRGJT2JQWHiIRbrwR6zdvIl8/V18q3DwBBDhrk3fqwusYdUZA7FVTlfCIzOLHv+3TXPm6bhRqQUusDjAeAIoomdvVHs1iEaIP+WeI1f1Ys67Rn7mZigocENQ9QExFHRSmyvEYU9PvnAsIQ0k3hGH336ZboTQa0rVngmHYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259985; c=relaxed/simple;
	bh=PmAmr79FdRyJU6b9QmejrxyeIf4LD4aqPQB8bE2vZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROA9sxI/+6OzV1WwnhnH0IcNu85IrdjEpenGMW1P3B5bv45ZT1H4o3i2lcdwAf7FHolaxeKuoJsfZTWsDs0bbD6jLDofyKvmiS0AV8FJmfoqh1AWDnmNWScjpn5tGBJPfP/FFRBSj+tcRw0UkkeMzEnAhbGLeurOgZ9TTmcfHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/rNdAR3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742259982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XWWCmRgpKGwn8kqYz0QsIKLW/nCL2Ko63f6fBFovis=;
	b=m/rNdAR3Os3KCPDVX79nPb2RszuEGShq7cEWP9QO1y4UHZbS2f6gxQ+xIKjDLrhNCkj4M5
	PWB86+t7ZYpG8ebUVTwtglOaXCAFTBi8OZLDJgE29uPqKHzMMJUzBSQ5saD2NIbM5QvVzN
	m0078RnqXPMjdrOD9OgQ5p2gqc+l7Jk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 5/9] memcg: no refilling stock from obj_cgroup_release
Message-ID: <Z9jHCaydxKBnOKEQ@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-6-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:26AM -0700, Shakeel Butt wrote:
> obj_cgroup_release is called when all the references to the objcg have
> been released i.e. no more memory objects are pointing to it. Most
> probably objcg->memcg will be pointing to some ancestor memcg. In
> obj_cgroup_release(), the kernel calls obj_cgroup_uncharge_pages() which
> refills the local stock.
> 
> There is no need to refill the local stock with some ancestor memcg and
> flush the local stock. Let's decouple obj_cgroup_release() from the
> local stock by uncharging instead of refilling. One additional benefit
> of this change is that it removes the requirement to only call
> obj_cgroup_put() outside of local_lock.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


