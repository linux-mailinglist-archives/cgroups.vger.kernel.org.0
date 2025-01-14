Return-Path: <cgroups+bounces-6150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A3A11049
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35AA3A8C0E
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F721FA24C;
	Tue, 14 Jan 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hq7CGt64"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE801CDA2E
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879831; cv=none; b=jcd9sLbRXRNuzRBdf9j75xWMriSwTJ7Shmh6SCqSPC+rqEVpsfhNlV0gZocVcX+miM8rVbT9hR0rEwxlz39aQY3ZGkfgwhwQceSkXj35pSPlaLlbExWw8k4x5mhEWbCwKq00+si8tlk7ZTQvPc1nWE/WDnshLBvGu4FaH1l/jeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879831; c=relaxed/simple;
	bh=89xXIJqIemGMjRBWn5Eue11hzOW5MITJqqjVlG3Rq9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2wCD5xgIpfo6gQcvyVxeb+IqolYmYPbzlCDabXLXStprPgP3o8SuLFyY9H8hwXr84q2bSNhsIMFKSB41cQRfxvd7pdWHOXetr1WJPV/0Hy3zO8zz5AEQ5z5haqamtLLVoffFkQkt+Y62qGDV46zs85dDcb0Kj7MqG4PypTi8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hq7CGt64; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 18:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736879821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uci2CxDdUTcor4Mocplroy6VPU/3I3PJ+VGlYKC6Dl8=;
	b=Hq7CGt64ZlG4Zrwq3yMhjDi/VU/rIvX+OxVuxjc0cFOU/SHhb3nDqLzoA2d2IpWy/HP6UP
	U0dBGsFY4I0IJSRQAmvojnWjTjqxK5qi71/kgLNnB7hJPbTYcvS2hKQ6DyJL7nKk4gfDIM
	0dQDP+4yS6fk4MC31yJfkaIKWVj6qrs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 2/4] memcg: call the free function when
 allocation of pn fails
Message-ID: <Z4auyCo_V4e-2GU3@google.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114122519.1404275-3-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 12:25:17PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'free_mem_cgroup_per_node_info' function is used to free
> the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
> free_mem_cgroup_per_node_info function will be much clearer.
> Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
> fails, to free 'pn' as a whole, which makes the code more cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

