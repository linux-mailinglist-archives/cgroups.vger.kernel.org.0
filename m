Return-Path: <cgroups+bounces-5450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0CC9BDA13
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 01:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604A2284753
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1136C;
	Wed,  6 Nov 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mUzz7W4L"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A5EEA8
	for <cgroups@vger.kernel.org>; Wed,  6 Nov 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851771; cv=none; b=S4E3UCCEMIMSWjq6Oo2ZwxXwCRSNXcMmejctUYX3qQp+wdrNG5cNp1NY2NVKykWSXQEQ69DZjDjz9oP1lW9B4A3XLRZKF+84uyTwDMu9tfLpyQiQmdT5CRUaDU/eqR9QxkEHN9moJxtYBSPg2S67CGcHCF/4RtRvvySc/qDTImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851771; c=relaxed/simple;
	bh=4x4dbB5xBnztGpUfm9GVitYhLA818tvcvCZ8d0Ht6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umi8WWk3IF0NEw90aTJqhsjjssMHZkJOGWJwqWJ1/8czCtCRLTFlQybneRcqqorP97d8rKb+lfoO5AW59s/zqSGYaOOoqVpfdhQ1P2X5V80o4iEhlU6XIscjfEgpuYkfv4y6qJ1Fnsl5eNHtpafK2RFLwnPxJfpq7hDWvIQ3sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mUzz7W4L; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 00:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730851765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p43JMorGZwxO3G3AwweIH/hxNsCPTiwkqmZv7WGPuZQ=;
	b=mUzz7W4LkFRUTP6NoaXPaBhm+AUJUmRmz+BBGRv6P/QxfW+UFW/8+Nk6ckU+ZQmgLLEf7y
	q5ihcCy8WGwkOLarbdjE5gOJqswQ3khRSbdx8qgn5L8z40+KAtGcB6mi4KOm84eC1+mJPg
	udMq5lt+i7/153/M6qJQuJIXFgh+I98=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Introduce acctmem
Message-ID: <ZyqzrPpFiV7me5Ca@google.com>
References: <20241104210602.374975-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104210602.374975-1-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 09:05:57PM +0000, Matthew Wilcox wrote:
> As a step towards shrinking struct page, we need to remove all references
> to page->memcg_data.  The model I'm working towards is described at
> https://kernelnewbies.org/MatthewWilcox/Memdescs
> 
> In working on this series, I'm dissatisfied with how much I've assumed
> that every page belongs to a folio.  There will need to be more changes
> in order to split struct acctmem from struct folio in the future.
> The first two patches take some steps in that direction, but I'm not
> going to do any more than that in this series.

Is this series supposed to be merged in the current form or it's an rfc?

The code looks good to me and the approach makes sense, but the series
needs a bit more formal commit logs and series description.

Also, it would be great to have at least a short description of
the high-level design in place, without a link to an external site.

Thanks!

