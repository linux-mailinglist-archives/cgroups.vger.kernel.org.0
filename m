Return-Path: <cgroups+bounces-11643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DADC38AEB
	for <lists+cgroups@lfdr.de>; Thu, 06 Nov 2025 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1CAE4E34BC
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 01:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479A1E51E0;
	Thu,  6 Nov 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOnry2p1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FE4A32;
	Thu,  6 Nov 2025 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391956; cv=none; b=o+RtGTVFyAXFI0sYonRZBLiOowBgzwa6i4NumRSg4tnzlJy2QlA9276R/TaS4iauQgpLMEoOgvDj6DRMSy9cvtCsDslOcTPtPZVHaDRX1MM1fYK7DgvlxLa8qaOZl/CbbBmq9ZZ6RiYbe+YslqySq94MQFEDsctBc/eQEh5poF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391956; c=relaxed/simple;
	bh=ZnRMpnL4bAiOhL8yWk+I3kysj/17LsVDm4UhPGPGtv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF6YtOMmz3aiJ6wxftPoJohOeg+M+6h8hj+1gUl7ASxg5f2mGgCu6tfZy//NW8OrACD6uMX8f0yM6azrfbcwfMY/geIAsmjQ99ijNXg7P9hRQvwSdniqCTX6jmG0GJ+sDsYp8wwrPzhQ2TBC5TdnzjSSz4T+GzaTYu7u2gqwQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOnry2p1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 17:19:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762391948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnRMpnL4bAiOhL8yWk+I3kysj/17LsVDm4UhPGPGtv4=;
	b=mOnry2p1ie0P8EBhhaXgljXMfwXpy1/R1n++WgQqr/oRrX8xIdtOgG+Rn2FiLGsyJ8IA8F
	P2ks1VfHs3p02mGfR7JXr0Ao2CqckyibWVEGNErlgbG58dWih3TlDoX+ACjKF8Zpb4WxUV
	Mu8cruvPgnOeIq6EYAphgyAQCjW9kbc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com, mclapinski@google.com, 
	kyle.meyer@hpe.com, corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Message-ID: <6kh6hle2xp75hrtikasequ7qvfyginz7pyttltx6pkli26iir5@oqjmglatjg22>
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074917.94531-1-leon.huangfu@shopee.com>
X-Migadu-Flow: FLOW_OUT

+Yosry, JP

On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
> On high-core count systems, memory cgroup statistics can become stale
> due to per-CPU caching and deferred aggregation. Monitoring tools and
> management applications sometimes need guaranteed up-to-date statistics
> at specific points in time to make accurate decisions.

Can you explain a bit more on your environment where you are seeing
stale stats? More specifically, how often the management applications
are reading the memcg stats and if these applications are reading memcg
stats for each nodes of the cgroup tree.

We force flush all the memcg stats at root level every 2 seconds but it
seems like that is not enough for your case. I am fine with an explicit
way for users to flush the memcg stats. In that way only users who want
to has to pay for the flush cost.


