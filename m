Return-Path: <cgroups+bounces-5166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC39A48F7
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAEF284231
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54618DF7D;
	Fri, 18 Oct 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ivEc+vnm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AD18C332
	for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287303; cv=none; b=bx61VqNMIpp3+SC6QdIAglbx9DfrT3+k8Cn7tvZj4NkfqJEfyn6ZMC8Mr+goJfG2d27WjV4CiIF7fxnEOvsQCjV9NAITl5pqVppOR8eIGUomYm2oJQgK0RyayREQ30SJBhbj3GOF8c9tl0Ch+G+2nX2iFR2rSBnBBrcuD2IXcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287303; c=relaxed/simple;
	bh=PMlZHNkq7GZjGVzz/mABrmdB4k8PswYcMuFOfNJ0bjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOqmlpKNJJHhuARijrXqyXTOk3htSzMJjsQQThPaw6gxlSPcDVIR+Vy4iSMyZAIt1/dhaShTWE/zbwq3flvpOjb5n0dKX66GWkKLqnYfI727/dtHVr5Iob7jESkLX/gFdwkoh3HvPrx1Yfm2ZAiHtJb1H6hCwHqKcRgh2HJ3rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ivEc+vnm; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 14:34:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729287298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvC423U1n9cjJ+Cz4Y5WpHvfXoLa7fjRoh3nCRJpriI=;
	b=ivEc+vnmwNehe0JbqPgNJYuRggaGBJEIIBOklEXpayICxA8OyCOQNyyB7J0ElZXF+/T2qp
	LoNk3JDfMclh5gZNLwuv0axXm4nM1/Dlq57pYOhLARqZKLNfIUl95biehsYRfQNNOLcujL
	ArBydMUIyMDV+bOzNC2vupV5RzO2eio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 1/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <bhcxyl2xir27ds7jlcsncajathj6fbpzo5hoymdvb7h6a44gfu@lxdsu5up344n>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 09:04:38AM GMT, Joshua Hahn wrote:
> HugeTLB is added as a metric in memcg_stat_item, and is updated in the
> alloc and free methods for hugeTLB, after (un)charging has already been
> committed. Changes are batched and updated / flushed like the rest of
> the memcg stats, which makes additional overhead by the infrequent
> hugetlb allocs / frees minimal.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

I have an orthogonal cleanup request (i.e. after you are done with this
work). Hugetlb is the last user of try-charge + commit protocol for
memcg charging. I think we should just remove that and use a simple
charge interface. You will need to reorder couple of things like
allocating the folio first and then charge and you will need to do right
cleanup on charge failing but I think it will cleanup the error path of
alloc_hugetlb_folio() a lot.

