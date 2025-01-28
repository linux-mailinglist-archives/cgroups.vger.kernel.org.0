Return-Path: <cgroups+bounces-6364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C5A2139F
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E29E167A59
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B71E3DE3;
	Tue, 28 Jan 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SKnnFbhU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAC1CAB3
	for <cgroups@vger.kernel.org>; Tue, 28 Jan 2025 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738099588; cv=none; b=u0NNZQg2b0HGrj4Nci6bM4c+FmoCtcQzjTdclJoiWDl9YOAVz+j2CdOeaeZ76oHd6tLNAXmjI43be4RdYp80oUjHHBrS4mLk7dcd5uj7AnfI/noV9MD9iMhYfSSdbksmRo4I/8EyGBpulprkiXfC00qDmc0h/vVkJ3YJldMWhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738099588; c=relaxed/simple;
	bh=cLn8ZvFMX2YvjaqPMkIuqDdVh789CJgxQzpBNJastWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYIhfmKxtmDoXUjouYkx2qzVoORWK5YfmiYLxMNhmTxD2a6wWm+3RSY7z0WMaWGLSdJq2T1ccSLU6RV2LlFpvwyeKhzFHIKDRFyqt1IsLby+cdt8zi+K4mbalyfjJ2kHuO55T4yhqrOV5WgaUWJgmMBdHE+M8AIGNFDVuGILLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SKnnFbhU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 13:26:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738099572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlHV52F30QHVkdWYa4eugcaaqIUsvC0Md1ngDkcWEHk=;
	b=SKnnFbhUFpCGmySdqAnvvsaxUTOJ0TH01DbgmOuqZb4BuQuIEOVYoKjfIHq8EFWB0lT9XE
	vXCaRPNZL948DCjKcynq493ljpTigPOSqBeUtNQ0FKBFGbAomZdLgLMyDCZHKKeDW1fGhd
	aqyJMZ6a+6pM4TXFv6BuvyKxn/O3oHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Message-ID: <v4arpzfmojijq4absfn6zom3jm7eo3bqbgnievehaifmhgrrch@slqd53mdhvlj>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 12:41:32AM -0500, Johannes Weiner wrote:
> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

