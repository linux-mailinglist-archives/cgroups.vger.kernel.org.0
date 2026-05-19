Return-Path: <cgroups+bounces-16098-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFqnHarEDGpOlwUAu9opvQ
	(envelope-from <cgroups+bounces-16098-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 22:14:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B805848FD
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 22:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B36C300B07F
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66A3B95EB;
	Tue, 19 May 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYuDwzpS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A13ACA7E
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221489; cv=none; b=Xg+CmpeWEi1XGqNh0OnIIiQ3ipI93g8jQqWnLRkuBIM0thX/71no2Ab35Q7edM7IHFVjWS88vRrLliJCPNKQXwMvTjdIBD2hBtb/0ilEdt5hGoYj4vw0AbESM3uLGBXVTZVOtoSXUHX5ym2GI3pB0BshyXthuBkbfH0zUxc96mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221489; c=relaxed/simple;
	bh=vjTqi2oUdlBXEwZ68rA08ByBf/yv5RCFyRR5LsH7Q/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvH4Fo33IT1qmBDvRLHD9PpzDnSHREfoshswJuAePv9aStdjteV7XG+m9RhTXtcwn91CbkpKcSlNRejGq8X1tMPTV7GxR7QH34hzuGJ3SI6WOs4xsjiwJMCSaBbC4/9ouQag3hYnq71g5MYa01+fAvIsp5bS8X3YgYF1S9gsoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYuDwzpS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 13:11:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779221486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJMO1B/wUheToiDYWGSoEg/sxiAds2iQg3Hn7Ds6K+k=;
	b=KYuDwzpSkEYfETezMt32EYxbA2JTy87z0DUyz+R+kSus5d0zTzU0bVqZhwtWU58dFApu2N
	bW3HqDPkx3r9pO4t8OJ/VjsAHHjf/lRGkT3eOKY2cY4Sabm+DDBvC9+ceMHul2yeKYgHWL
	dDyda6ZhpNc3f5yuJi2e9LKBP5rw/48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
Message-ID: <agynzVVBb4CYJTYG@linux.dev>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
 <aguiSnY3ie1y4nEl@linux.dev>
 <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
 <agxszIIN6FtK0fEb@linux.dev>
 <ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16098-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2B805848FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:00:16AM +0900, Harry Yoo wrote:
> 
> 
[...]
> > 
> > The full clean solution might take one more cycle and I think we can not just
> > ignore 67% regression on 7.1.
> 
> That is valid point, unfortunately.
> 
> One more thing I have to ask... for v7.1, wouldn't it be a safer option to
> revert the per-node object change and re-introduce it once we have a cleaner
> solution?

The issue with that revert is that we reintroduce all node lru locking in the
objcg reparenting path.

> 
> This change was introduced in v5, but the implementation before v4 had been
> exposed in -next for a while, and I think we don't have enough justification
> to keep the per-node objcgs change, at least for v7.1, given that we have an
> unexpected last-minute regression and
> correctness concerns (albeit slight).

I am waiting for Oliver to test the multi-objcg patch I sent. If that also
resolves the regression then we have one more option i.e. backport that to 7.1
to fix the regression.

So to summarize, for future kernels we will be having multi-objcg in some form.
For 7.1, we have to decide between (1) do nothing (2) this patch or (3) backport
the multi-objcg path to 7.1.

Andrew, please don't send this patch to Linus until we decide on the option.

