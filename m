Return-Path: <cgroups+bounces-12340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B68CB7760
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 01:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA6EA30194E7
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639ED2264DC;
	Fri, 12 Dec 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNGSlChf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623F21CC5B
	for <cgroups@vger.kernel.org>; Fri, 12 Dec 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499913; cv=none; b=eCzJEvg8wNzwebMbpCR5pEAp+wNllF88vL88sv9DgEyGG515YpclehUG8B3/StuirOi5+aaQp7Io/lC4mf0XpEfWPZfdLfFXS6RlJY71M9jfGp1AZ7xBbSEVo5YLfkaxQLlGu1HfiEuu+ML9CK4vuQqWvm+vUpOmQq/SCBcI/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499913; c=relaxed/simple;
	bh=nFQjVRhk0UB29Uv5YAS0/RLP29y22Tyw8r2yeJov6nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V80+eVfR/1JzXpYLh0RogNbTewfzQu9sCXE+NsCDnGPGH5hWi5ED5cTv/GK9/oWTi8x89R3yjWXsUWwchFmRtVHRMlmpWeil9yb4D68BXvU/Wuza1G087ZwK5hQvbm1z/hInH9Kl3IWteCHpjZA8MQvhsvWKutg+FvAskfZE9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UNGSlChf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Dec 2025 16:38:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765499909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YZ0qmDtGhajRkqHtaliRPUZ/qSpTKdV4P+LwDIEFjU=;
	b=UNGSlChfG2aKxIANpnTQ+6ru3hxpXwV0OlXRuFgq3n5tWFouyd5yp8wBT6o7bYIWTGxe2m
	NG+YRj8D9Ozfiy0EVWbxfpv8REyQSrb+WojRv0duMuMqXP5RJLG2ENLsvIEO7mnyGKcvMs
	3zJnOk9FWjqOD3/Vh+nGACnvSqREiZI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: rename mem_cgroup_from_slab_obj()
Message-ID: <lrocj3x7mybrkkl3wbngzqfontqegiwmmkoidpr5by4yjodx2b@alsgfvurtvog>
References: <20251210154301.720133-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210154301.720133-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 10, 2025 at 10:43:01AM -0500, Johannes Weiner wrote:
> In addition to slab objects, this function is used for resolving
> non-slab kernel pointers. This has caused confusion in recent
> refactoring work. Rename it to mem_cgroup_from_virt(), sticking with
> terminology established by the virt_to_<foo>() converters.
> 
> Link: https://lore.kernel.org/linux-mm/20251113161424.GB3465062@cmpxchg.org/
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

