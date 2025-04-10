Return-Path: <cgroups+bounces-7457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D8A84B89
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCE0188F09E
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A97284B33;
	Thu, 10 Apr 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DZ5wBMh+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC01E9B38
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307132; cv=none; b=oPGk0DYSPPEQPcJpqLaZILPtu5KLFsIR4gTBgc4G0dPSC9+zOAQXYHfPosz263TpH+Tt5UqNQZJl7w1zMFRXgc3J2HdyG+YwJgSb3phQc12LncK5rg4enoyAsBi15EsX+3ttZeBTK5l6TwYguiQEOJhrqi4s9ryzF4tKXcRcJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307132; c=relaxed/simple;
	bh=eCF8k8XdtDWUcErT4HOcePnUIU3uoUqaPb/roHB9fbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGuNgPZ7k2XR4/VvQO/vk1yuvn5K6pJZyN2/WK8dSTSwIuiSKeojHTtCM+2U0bWhv37D7pW6TRg6sW1u3dhEYrl3QQyrYlyFfuSC3YoQhscL1iFi2zpp1+IHD7rhpzqWjbryIc0w+GTvrZwfcyybEQAvCl1D7zOCDr0ANfe1rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DZ5wBMh+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Apr 2025 10:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744307128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvTNL6Tsz/oYgydOCDMb/zQ2Ru8zownM+E92WVITLxA=;
	b=DZ5wBMh+U8fsJHqeilcVKpqGpqvLqKZFPCPQw2wZcs+2Ai5g5FRntchqXLEA7ae6xKtXvi
	WRRMTMvhFoA4j9MVh/kRqIBCULIJIuAOkDRfe+TG9u4KtGASgZa3z+dVEfQfB+HbHuNUpx
	5E4fvU9xQ7dfioWNSlT3Gkmze34T2fM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
Message-ID: <qpua2m4zw273f66rjjdmmulnzok5wzdr4ah2f4p5v63igndhyc@pqtvl3x7nkyf>
References: <20250410081812.10073-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410081812.10073-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 10, 2025 at 04:18:12PM +0800, Muchun Song wrote:
> The commit 73f839b6d2ed addressed an issue regarding the swap
> counter leak that occurred from an offline cgroup. However, the
> commit 89ce924f0bd4 modified the parameter from @swap_memcg to
> @memcg (presumably this alteration was introduced while resolving
> conflicts). Fix this problem by reverting this minor change.
> 
> Fixes: 89ce924f0bd4 ("mm: memcontrol: move memsw charge callbacks to v1")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

