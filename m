Return-Path: <cgroups+bounces-7113-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4284A664A9
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 02:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922F7189C243
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4A126C02;
	Tue, 18 Mar 2025 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BAxalUnB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3F13AA53
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260059; cv=none; b=IgSVUboAS2gbiD0hHrDLRo3E1Vll6hNFJr5mvknCabXZiFPYAoYpFfirtSpFXS57BuQaEiKdFmUnPOwl6hP1Z7wOJHgxq90L9BvlFCf0Iq0b1tjlaokA3hmnayBF+O3SrISkQJzpBFLkILeacsFy0f9/Koj60yAwZOQp4PuHW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260059; c=relaxed/simple;
	bh=o3ntH+VyxBbQxuXAIdQdU6Z4EDjFyFPzkvUVQn5XsYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyOTqo3MZlcxEfIz3NFpRjBUCfcgDJfMoXNYC1tNuVsUJBvD/7A0N0y7It67BR5jLFEXFPHadVv6QRdajhD9bUjBkpDMyxNeRTCT/yYiijowJLN4Khlc94IMzob7+MarIhhBa5fci0AHL4Zx9T0HajolHqZuq5McHN+EOHhUu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BAxalUnB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9mPeLIacidUCCPqGAAEH/lqRKjMQTyR3oZRrUoAsBGw=;
	b=BAxalUnByRD9ldhNz0FH+D2OiWjrXYA+0FmMAzx1K8mp1ZMvRk2BimXfnmVvfghjfnlRfO
	yFMkgKFnWXYFg7rF3TzWlScC79a7uk3NOcz9RRlvmi2XcT7w3G74o4/e/lNigrxoK5COcX
	iz9PX83xKCCNSrblZ9Ny/rcQiKiwVzs=
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
Subject: Re: [PATCH 6/9] memcg: do obj_cgroup_put inside drain_obj_stock
Message-ID: <Z9jHRnXnAnL0Mcjn@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-7-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-7-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:27AM -0700, Shakeel Butt wrote:
> Previously we could not call obj_cgroup_put() inside the local lock
> because on the put on the last reference, the release function
> obj_cgroup_release() may try to re-acquire the local lock. However that
> chain has been broken. Now simply do obj_cgroup_put() inside
> drain_obj_stock() instead of returning the old objcg.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice one too!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

