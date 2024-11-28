Return-Path: <cgroups+bounces-5712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227D9DBDB1
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7E7163BFA
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872381C460D;
	Thu, 28 Nov 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkZP0iEo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226115250F
	for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834119; cv=none; b=X3FGrx5qfiETx5iC4yc2EgdsYN54RTn3uJSsF6FaUiIPpNp1LCHNCG52Bavlc94H6dj25bu3KQaFsU4NNvlvVZOXAISNESbKAcSwChqBYUEReKWla6pG7pQOBSRUZjrlxxmowzi0QJ4RZPEmOY5/GwVwqt6aWBHvt71ZfuE2VKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834119; c=relaxed/simple;
	bh=pTPfR/zW+kl4Z619+Cl2gt6nLDKBcuupRYquAn9SV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqBVLZXCglq4Ibb2czZPZFwIup/3tYlCGh760+WzNGg5cHtLdakjA1BIobZbgMQGub/TAETKnbceMJo7dOEZEbr2irVweYeoNhYsUdfbDFKidtmiW2zmPPvFJE7Sa1TgoabUYLnwti8SpD3aPQBC2jLHRD/DDMhLq/M7outGSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkZP0iEo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Nov 2024 22:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732834114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLXpKhmby6MhlJ9I7MRFv11XFxLUBQGGDIGpiY97KKY=;
	b=IkZP0iEo81kS3Xn2ZctYcc0GqBjl8YXcDaT0BE8wIsvu7s5jyvcZb3TvYt4W9BGN6+xJN/
	nnmZkXEeSbV7rGV3wgMUsbzzB6G62LhlAGRrryTA6zVHrtkivlWW2TjdeXyL45SwJVCPTc
	anFcjv7qnqrhEv1nKiEejdhgYCpYHmw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Sperbeck <jsperbeck@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: declare do_memsw_account inline
Message-ID: <Z0jzNx1UjIJuclIf@google.com>
References: <20241128203959.726527-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128203959.726527-1-jsperbeck@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 28, 2024 at 12:39:59PM -0800, John Sperbeck wrote:
> In commit 66d60c428b23 ("mm: memcg: move legacy memcg event code
> into memcontrol-v1.c"), the static do_memsw_account() function was
> moved from a .c file to a .h file.  Unfortunately, the traditional
> inline keyword wasn't added.  If a file (e.g., a unit test) includes
> the .h file, but doesn't refer to do_memsw_account(), it will get a
> warning like:
> 
> mm/memcontrol-v1.h:41:13: warning: unused function 'do_memsw_account' [-Wunused-function]
>    41 | static bool do_memsw_account(void)
>       |             ^~~~~~~~~~~~~~~~
> 
> Fixes: 66d60c428b23 ("mm: memcg: move legacy memcg event code into memcontrol-v1.c")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

