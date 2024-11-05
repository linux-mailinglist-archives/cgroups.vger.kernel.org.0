Return-Path: <cgroups+bounces-5446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD09BD25F
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0593286CD9
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986A1DACB6;
	Tue,  5 Nov 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmtdViMw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D01D9A6F
	for <cgroups@vger.kernel.org>; Tue,  5 Nov 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824284; cv=none; b=FO73ueoiBJZ6zVruxWFpGtGP54kG/fXPzOm66hxRuirYT8F4+1VwkYailTckb8jij+w8b4YswyG2L1ElhY2qFT853OWA3Tky9yWnkNZFVprBy5YfEk+FV4k9UpYhZ8ufU9+sub760bWvvn8+Nq1uTCs0nOjzl0jeD80Y/zdUPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824284; c=relaxed/simple;
	bh=3Aq81BGjAKM0O6d0Gyd5MyzSSWRAUVtjkZubHS8NG64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqY34jpv79PHDEPIDQMFb11sw8WkqCPkRiyJCjNCXloPlF9YYRd7u4qvakG1fBCkx3bBbBeJmI0oru/6H0rPis9efCN/FZWLZ7Zp1zvI1cfNN5/ioxK1SBnSuLF73pJ+Yjdj2ZCYMFM4G+lkwsd1hnQTIZF58F/Ae86MABjyI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmtdViMw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Nov 2024 08:31:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730824280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT4Vkhd4MYFNflyQXSSGKBC52D3M45mNRvZMziNf1mk=;
	b=DmtdViMwYVIFfbOEACooJvk0lnqSbOhw0HMQrBslTOTE96+71fyDU/1hsdrOpJwkdF1QaR
	0wrZEZborVz8w32bz/Fjy4ExkSrFwtyidSxDE9fLGFk7pFQuu/uhXBmHIQcvq6ymr/nEoX
	X0+lpk3jEA4zOuJlA3A0m9+A1uRavig=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: Prefer 'unsigned int' to bare use of 'unsigned'
Message-ID: <pxt5robvbb5vf2b5xbvqmjkzzlzybtw7d5lcs4bhcmauqfzlhi@wgmbdy4bknvj>
References: <20241104222737.298130-1-kerensun@google.com>
 <20241104222737.298130-4-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-4-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 02:27:36PM -0800, Keren Sun wrote:
> Change the param 'mode' from type 'unsigned' to 'unsigned int' in
> memcg_event_wake() and memcg_oom_wake_function(), and for the param
> 'nid' in VM_BUG_ON().
> 
> Signed-off-by: Keren Sun <kerensun@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

