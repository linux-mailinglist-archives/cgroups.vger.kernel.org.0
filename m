Return-Path: <cgroups+bounces-1129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6582B949
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 02:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9331B219F0
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110ED110D;
	Fri, 12 Jan 2024 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dYnXItj9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC510FE
	for <cgroups@vger.kernel.org>; Fri, 12 Jan 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 17:57:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705024669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAXou/95F+iCHlaLJAAQKo8Mt5FoImxgZVDvm0OY6ts=;
	b=dYnXItj9CigOIh9RHGT8Dp3DZLAf0FIA1o1bFEeBQ/uiPJ6HhdCS2EqtvlDckGZ5CRwCBc
	OVMIKZYDg+n7FTzwib1u8glt/GQ3oI3HtwkqhNaWUr2jFeungBr+/BcoeAdG5iO6tFAmFb
	2bkztCwHwAuxriV5c+SS6Fp/U6FIrOk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/4] memcg: Use a folio in get_mctgt_type_thp
Message-ID: <ZaCcmBaEhRvCtkK4@P9FQF9L96D>
References: <20240111181219.3462852-1-willy@infradead.org>
 <20240111181219.3462852-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111181219.3462852-5-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 06:12:19PM +0000, Matthew Wilcox (Oracle) wrote:
> Replace five calls to compound_head() with one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Looks good, thanks!

