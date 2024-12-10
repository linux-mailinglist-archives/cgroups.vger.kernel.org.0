Return-Path: <cgroups+bounces-5791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574119EBA97
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2024 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D4D1885474
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9669F226869;
	Tue, 10 Dec 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qg0FdrnN"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9628633A;
	Tue, 10 Dec 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861111; cv=none; b=NzN36N03VE9wmJGdhJXSiKRa1MKLA1bYL5Bx8h90UZaV1ail41UV3IqIDGDtaFosinFPIuIIEuEa7tElO7OH7Y5nPpxPq9A2/oVcSPgO9KRlOFlT8VO8V8RraYfdF0EUHd6BIYLdd54d03dyxB30IgJs9Jeb++XzCJAlcwrQHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861111; c=relaxed/simple;
	bh=y2BeAu55g/qhGBfDeCg2R9ttUTfkALvQq393lN8DJ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIX/DhbBqeLCn3RgkXVczwTu/1npu1s2eifVaZ0fiJm5VIa9KQ/vP4CAHxVX7mGnuDE9NebOBV5SjCyPrFC5LPP1eSeSyqjC+BJh1a8pD/ziVK74zed4bRDMidXHZfm7t5PaqTCdRx8KfaVAIOB4HQo/wKY2XjogVKm/3j2DkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qg0FdrnN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cemat2AdWy3KaYa3RsHJa2mNjcJ6gdRV/CPXzuwbXkI=; b=qg0FdrnNSTDmKUE2fa/sIHAkTf
	2v4sRxzvKZA/OGD2LwVfKc7JmRN+ToSX2qoSIhsAL4QG6M7rXyS9Ae07tV0EcvO7C1Ze44bTmrRl2
	u99X15p/g05cYqIGUCEMcmm6i+AJdHzlGdfsWk7okYiKBsm0pdZqyIOV7J7XOspa+g+0NjidEDcVc
	6nFa8tyPEx9ESWurHxWNQhSbXXf4LHl8FN6sx7m4EJRmEcKLI0xGbjIVcQhhGpaardfcaRM7KNnKq
	bc+w55i15OwGoOvvGuHG6w/Fxvsb/eZIJu5EYjvMk2wBpb4wA5qGDc+CSlDZFN80LF/SliKmr0f0V
	FAPeKqbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6Tg-0000000BLjk-1zKJ;
	Tue, 10 Dec 2024 20:05:04 +0000
Date: Tue, 10 Dec 2024 20:05:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmalloc: Move memcg logic into memcg code
Message-ID: <Z1ie8JTX3tRsZyK1@casper.infradead.org>
References: <20241210193035.2667005-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210193035.2667005-1-willy@infradead.org>

On Tue, Dec 10, 2024 at 07:30:33PM +0000, Matthew Wilcox (Oracle) wrote:
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)

Hm, no, this is necessary, but not enough as nr_vmalloc_pages has the
same problem.  Will fix that and resend.


