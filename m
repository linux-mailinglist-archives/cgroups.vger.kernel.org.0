Return-Path: <cgroups+bounces-2826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813718BE85D
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEA11C24077
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F31649D3;
	Tue,  7 May 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYgFcoZF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989415FD19
	for <cgroups@vger.kernel.org>; Tue,  7 May 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098192; cv=none; b=CInD9CYgf27V21RNUHiStBCvkUS3QtSEGHH6NEsT7E2Vek0O4d3HbNOOlQmzfygNDe525nbZQK5mEwsRjmdtb7MCPchvQMrdMkaf0gq6CXi2f0Mkaj+JfUylHC+jqjnpbv3+BTQhF8ESj8xk9UM+c+y3YYNFFXpCinT6+dTy3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098192; c=relaxed/simple;
	bh=gz4Jf3ondj4y4dpkh3Y5gyLp2dfD3A5nAdCohPabPh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ+NqeyOx+8m2WgBMYEs4eqSrsyk2Tzzds9KO9QVesRqlQH9WCjCNUKG7C10W2svAYH93i4MxGCt6JWOO7ocmuPNaxChETGD4tqsUr/OWq6O+9tVr1P1avIBsesaCF1Bk75+u/HHGModU96KRPnrqq3am68RI8FdgNPIXTYOZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYgFcoZF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 09:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715098187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgzIR0YD+S9uWGtbeF9+1URxHxfb+Er2kUk5GWowswQ=;
	b=GYgFcoZFHdDT9O8zbQNUuBjwrw3TYPWDPuV7kfu2wxM2XY5R/zlVAaa7+/VEnmVBOaXaOb
	Bd0uwhVVj08huf6sHJBxSAABdmpRTNwO1UiflcVyljF+6UECf8ZIY5GV0zvOtF8p1wxO/L
	WOxNDSZLD9HnbXit5a7NqNimo/JxiqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <ZjpSPRn5kVErC6s2@P9FQF9L96D.corp.robot.car>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507110832.1128370-1-xiujianfeng@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 11:08:32AM +0000, Xiu Jianfeng wrote:
> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
> make it return bool, false for failure and true for success.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I actually liked the previous (ENOMEM) version slightly more,
but this one works too.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

