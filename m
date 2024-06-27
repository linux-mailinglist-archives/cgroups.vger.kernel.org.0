Return-Path: <cgroups+bounces-3418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF391AF48
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7642C1C224C0
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966EF38F87;
	Thu, 27 Jun 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRRBpB3g"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463532139D6
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514089; cv=none; b=afqY49PpqSqbZMPuK+IzyMSoyQM2byHNdaayYWW6nVvMRCuZbBu6Kz8jtvG/Afb5bTNFm4rm18ZJlPo7vqMHT5+TAYsK79x2M6N3PwybvgBIQnVtWF67LtVHQ5CDNfwvAdSvT8Uzxc1dehymg161wecuLH5kQ4HGIrU/Sys6fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514089; c=relaxed/simple;
	bh=rDtHCeGVR3/oKtE6l4osywuLpwQFbDTZkaJdSWW5wO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH9Td/TO3t2usWkmPdcFuP/ne7XHvTs3c0fcz104FrKLhQbCsv+VVJB1NEj24LwkmgQUv2+hob/EYlv3HJ8t+gyNikX8HPRxK+bQJqR/8bUgpCcBLz2E2uz/VoG1mbGMo4CGJWab6epK2C506nz6eRyqXexGm1nSGb4kSEOy5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRRBpB3g; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: maarten.lankhorst@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719514085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Av9FqovsUOP0h53igKSF4jPKQsdgFn0YopTV64fIgIY=;
	b=CRRBpB3ggXRq1QDcE297/5Kp/kIrT/zzm8p3YYiuwvOqmGDASLFeXhdjLiAN5/Hh3pHQOC
	xtKS4G7SWzx40mmGVlXQxxrzPDwEvOt41vPEcMHd3qqjtp8vidle4isCt1pYW7KNmYE0ap
	dyzwQIqS6gKYG4IDHQ6NlMnjLZKnIPs=
X-Envelope-To: intel-xe@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: friedrich.vock@gmx.de
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Thu, 27 Jun 2024 11:48:00 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/6] mm/page_counter: Move calculating protection
 values to page_counter
Message-ID: <xedzkn5fs2adz4ea3njugasxlt46637mgz6dbzho7ywzykfbxn@l3dc7c2nbzrq>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-2-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627154754.74828-2-maarten.lankhorst@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27, 2024 at 05:47:20PM GMT, Maarten Lankhorst wrote:
> It's a lot of math, and there is nothing memcontrol specific about it.
> This makes it easier to use inside of the drm cgroup controller.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

You can send this patch independent to the series.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

