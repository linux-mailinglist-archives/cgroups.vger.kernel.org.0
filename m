Return-Path: <cgroups+bounces-5715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588779DE89F
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 15:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0F428217E
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5297602D;
	Fri, 29 Nov 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iA2QxMDH"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFA28EC;
	Fri, 29 Nov 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891011; cv=none; b=DeXRnSgtoR1Pt7Xh2N5UG/TfiCqafXhx7t/yRaaGG10IabNO2YDoKqtGTXg2OpTpI5sohqyetYYui36WVC6wsH62zVlko2Hcl51Wz+FfxXN6oX+frBYSdWtRVzMo/QGF5M0N1o8SzbDhNbZAXhLSGWngfDz5IhQBdGci1ahTguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891011; c=relaxed/simple;
	bh=R+QHYfxQHuMOIF+ETq3lU99sS9LDLmBvDbwLhdfw4kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKUNoKQCAeD0dw6BzOqUiYxz3d3yiP0wpfVLK+zirbl/CR7lvA34Jhd4g65ug9wKrMqbHrwAZnPx+9kclZkDoRi/+efaaTPc814KJ3Ep+2o90OSIoqN1f7Sgnd17VTurIPjJAenq58AOg4eJAuC8Oa6lVCxrENQ6oCFWoahVitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iA2QxMDH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R+QHYfxQHuMOIF+ETq3lU99sS9LDLmBvDbwLhdfw4kY=; b=iA2QxMDH324OTfnkMpK975awwI
	sywYHsNh4toFQhoRSeSfc69GeI0RCwS6u1m/LZalz7r0An6mHrrM8JW3UsWuHzY4YF5Yl71F0ZCQu
	RkVxMtDN08YLDpSN58xFMLoOtoxqXU+oPbFfmLdl/snTLpyqq0UMFB1pvPzznKvzFNSEQgHuVHZRS
	7gcIwFiB/Au+OQwhU9zsAqzmxosnBveudF3/lreRlpW5734t3njen+prig6u72fzq+3bW+3UM1+4k
	ZWV0l273E4BWqLA8I2ctYXn5kO2Q5x7MlNNppKdtnQrsdA7J+ubdo5f3Q1Y3QTIWgzWiMl+V5khBO
	sdBveVrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tH26q-000000047Ta-3U8e;
	Fri, 29 Nov 2024 14:36:41 +0000
Date: Fri, 29 Nov 2024 14:36:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about
 sublists
Message-ID: <Z0nReJHvBJS1IFAz@casper.infradead.org>
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
 <Z0j3Nfm_EXiGPObq@casper.infradead.org>
 <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>

On Fri, Nov 29, 2024 at 09:58:27AM +0100, Alice Ryhl wrote:
> Oh I had not noticed the "Return"/"Return value" change. It must be a
> copy-paste artifact from list_lru_del_obj() which already uses "Return
> value". Would you like me to change that one to 'Return'?

Yes please!

> As for the other rewording, I thought it was slightly more
> unambiguous, but don't feel strongly about it.

I don't feel strongly about it either.

