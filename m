Return-Path: <cgroups+bounces-5713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801789DBDDA
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 00:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAD1B216EE
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A61C1F31;
	Thu, 28 Nov 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ahFLNVwV"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD814D6ED;
	Thu, 28 Nov 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732835139; cv=none; b=Ro44oCAhlrWsp2N5Q97XcwJmZqLcG4XVuAF4EE3iQj2XQMM4yk0aRaOYvMP3CMmu4Eqmhmki+7KsU3qE8CXdeJc+gL53iO1dOzyYdDgZVD+otVCghFCeMzZlb+e0zcSjHjLQilZTlX6v9HRUmU1jxeSDqSa2gk/+Em9ueZsIuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732835139; c=relaxed/simple;
	bh=rp2dWGxHIYBlvWueBfhZeR1AWN3Uay9Ls113x/kd06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL+sNfRezmSLNXcrxEpVIdXEvwGQ8CSin9MM0wA8s6eOsPg6nS5ro3Z7eEAHPzUPHDLJ3sJe+2Oqx/zLxiLu+AHdA+sUKnweeCI39s1Iy5EWHkwcRNRuGo4ct0InGYVT4PgS9xmvvG0S2g+01OUMCeSciJ1q++ACGCyyHp6XIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ahFLNVwV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=foSCVk1TQJuLvaObUzL8Fw57glUVJKIM/G0QyVdbyWk=; b=ahFLNVwVI/TAr8FRWzHJ9hLnNE
	Ue87llVqpnTgoEvpgzudUjUpLAfr7gcOhzDUsuYj+pZcl0EQIPs4BlZtO+lxgX3IGtsg3cedEXSRq
	ZspmoQ+xvaBjzp14q2YU1XKaKOX1sKQkfmTVIBZOCovlCYwuYCp520oQN8Bm2sBQBGSrT4jat1IZx
	ZAAaa1VpCrmEw9TUvXZ5SMmK+oX7EHZp8yvlLxzcIr0K7ZC8ykNZEwxj/ztRk64Y6zS9JSq32kbVc
	jD6F+V5dRsDRMSf5e/VDYXJJarf5xODkKblw1mTr80u2CQwDr2cd2qjt0qVCxhxF/uR7+q+S/s6AQ
	0H5nJdbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGnZe-00000003DIW-00TL;
	Thu, 28 Nov 2024 23:05:26 +0000
Date: Thu, 28 Nov 2024 23:05:25 +0000
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
Message-ID: <Z0j3Nfm_EXiGPObq@casper.infradead.org>
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>

On Thu, Nov 28, 2024 at 12:12:11PM +0000, Alice Ryhl wrote:
> - * Return: true if the list was updated, false otherwise
> + * Return value: true if the item was added, false otherwise

This is an incorrect change.  The section is always called 'Return', not
'Return value'; see Documentation/doc-guide/kernel-doc.rst.  And I
think it was fine to say "list was updated" rather than "item was
added".  They're basically synonyms.

> - * Return value: true if the list was updated, false otherwise
> + * Return value: true if the item was added, false otherwise

Ditto (and other similar changes)


