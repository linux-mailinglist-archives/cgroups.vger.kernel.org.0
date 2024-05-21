Return-Path: <cgroups+bounces-2975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13948CB0A0
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAAC1C21733
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393714291A;
	Tue, 21 May 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMIxj3Qq"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A4142E60
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302669; cv=none; b=EEtPGEvkdI/APGQNSe1YjBD1l00Fw9FIAOSOL9AkJzpedMYnIF1+qtlwpr2VX07OzgeH108rSM4Ga+zTLzEZJpsgCeHMbjiYJtn8WYDhTOHSAnUXxtpE7MHyKG/fT3ka7eyiYJxzz5y7Q7hvclnTFP9mgcpQjKNYQwLl3N6lVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302669; c=relaxed/simple;
	bh=NYfVdXNp90njM8ZaL0FZMfZiLMDinxun7b/U8BChcH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEQaXhnm0BhfzCc4n0OjtwcVlLC5uBpV7oEklEoFPYTObtQN6fftJ/RqW9XZEqQwBnN5AxMkns1OKlC2GE2Af37KGXjX+cfQQPnhMpuDewDneOi63vCzbktZ5p29XQo6yQX7Ea/wjfPm2L2Mi5MAtSDUWoNzT8UjcHl//72YsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IMIxj3Qq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtcuEyVIsdI4Kek6XZWyT/nyjJfHP32Eu+F1cNxK/iw=; b=IMIxj3QqncsMxlzUU/eup433kW
	yoJ3ZRWKVzvuZ7ebyuYTU57ySbGdKo3QFND+o1JwPZntV7xHMFNkFJhEx8TnH1UVMchsBkNLhpfDU
	pOsBz7nGLJLJO2rgES9JNDA9cpYCVoTNDIZv4QEn2E9vYSG54o37m1bHbX98FtfvmmEIyW1iW2NQR
	UZBO8/mIQo13B4bAIcVH/nygoXP1VOg7ZPWB3BeBwuIOVsMPrqE/gdwoFcgwXv4Y5zobvYzB27HOs
	4lIpz8Je6AjCji66oDnNKr2BqVz5VRZ+Rpga3gwHp8vBySco/49ksazaAHx3N9f8Ivncja/1cEgmc
	sqIDFzww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Qiz-0000000HHMP-2gOT;
	Tue, 21 May 2024 14:44:21 +0000
Date: Tue, 21 May 2024 15:44:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <ZkyzRVe31WLaepSt@casper.infradead.org>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521131556.142176-1-wangkefeng.wang@huawei.com>

On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
> The page_memcg() only called by mod_memcg_page_state(), so squash it to
> cleanup page_memcg().

This isn't wrong, except that the entire usage of memcg is wrong in the
only two callers of mod_memcg_page_state():

$ git grep mod_memcg_page_state
include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
include/linux/memcontrol.h:static inline void mod_memcg_page_state(struct page *page,
mm/vmalloc.c:           mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
mm/vmalloc.c:                   mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);

The memcg should not be attached to the individual pages that make up a
vmalloc allocation.  Rather, it should be managed by the vmalloc
allocation itself.  I don't have the knowledge to poke around inside
vmalloc right now, but maybe somebody else could take that on.

