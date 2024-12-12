Return-Path: <cgroups+bounces-5870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0B9EFAF7
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992F4289468
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE183223E6C;
	Thu, 12 Dec 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IKYd0eID"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177420E03E
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028330; cv=none; b=W2qQOjit33Ubi7dd7KSMVGgzElZ4ns5Kj7ax5VB6ykA8xyZ29ojMH1RCclLdx0yoxw8Y0qzcuy9TQxtl2zNjjWV+8KV7YsbhKbPsXfT4O61heDBWshnVcejGwK1nfLiTICLa9imjJ5hFqnarVU5spJYYKWe/0/2ekOEBfn+IRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028330; c=relaxed/simple;
	bh=/2P4JQ4o9LfjnGL6PW60gglUYd3I1qYkGnXHZm/hGbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgIY5R0fI3138+H93d+ooPx8QgXqKq79+DBC4//5jZ20/0IwSMc8vENO6g4Lk2GN0ujWu2zcui/GiOHzhV+P2VIgdcdKDqKU3JJ0NnJWu330Yz5z8MorfGDPGmYcAZaEg6C4bDRN26IDVXuD6C7SlPS2Okwf4xqQ2y0+G3EOhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IKYd0eID; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 12 Dec 2024 18:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734028324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2P4JQ4o9LfjnGL6PW60gglUYd3I1qYkGnXHZm/hGbw=;
	b=IKYd0eIDaH9mMFkZYywkjVap8ervWeRg7YFbQ7HotZzDWTpz5sA24oDoET4Ep68gz6K3wS
	NGZ7f8kcED+ALMtEPtd4VLrgxFHyNDXpSuk78sjxNRXWXEA90cwpFIvwusWhQYppTZ+1GC
	KjmWJumG/UmkO2oXEh0VQtcCgclVC04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z1ssHQYI-Wyc1adP@google.com>
References: <20241212115754.38f798b3@fangorn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212115754.38f798b3@fangorn>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 11:57:54AM -0500, Rik van Riel wrote:
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.

Is it about a single task or groups of tasks or the entire cgroup?
If former, why it's a problem? A tight memcg limit can slow things down
in general and I don't see why we should treat the exit() path differently.

If it's about the entire cgroup and we have essentially a deadlock,
I feel like we need to look into the oom reaper side.

Alternatively we can allow to go over the limit in this case, but only
assuming all tasks in the cgroup are going to die and no new task can
enter it.

Thanks!

