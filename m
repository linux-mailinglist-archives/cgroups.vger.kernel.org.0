Return-Path: <cgroups+bounces-5831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8439ED76A
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 21:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7396283AFB
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4A1D14EC;
	Wed, 11 Dec 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZShGqhjR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD061BC085
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949926; cv=none; b=FoCHu9eO8sA0NUMBfot50iQE4bU8ajAvZBYBRfTP7qLBauyHgn6l/GoIVm430XSxo9G4sie7byOFIDqo3sA16WagVA/2SSMpZYB/w8Ujlb2qJ1O+KVcJxVT9TAPlc99Fzsu3+WHnF4k33CyzX5/agw5559r2J7pulkMLCd2JDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949926; c=relaxed/simple;
	bh=FRML3w5HTZhYPZN17cyzuQ7Q763sSZfK4yHPaykRUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXbEJon2A7HP6sZzWFRDPiXpYIWgwHd32PSIPcyND544RwwyziUu1DS7OpYLjPIBEA6jRFUyC8mp1uM/MjoM0SXFrIagL5NW4sajqqwBopwU5W20YKTFfsAGLmKs4onegjwBOxZf118TpMf+lSv5HLOoOaWDzPj0+Q2UegW7q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZShGqhjR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 12:45:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733949920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7t+KorEtSawtI5MSpoIQmlEIOdqN2q2ix3mEzFEVRs=;
	b=ZShGqhjRRetiCdBj+MmiL6GOD9OmmWicXoCHHVHgDfHNAoy8aJrCIFonrEKRftLNLOweHL
	JRfUHvz2WMEDQ7T4GukNikeovUnXjs+N+QHoP1uebhRgtuCKhm9NMHCd7odz4ZW+Zbm5kE
	SHXSoU8qSsIsNocyhw30ygtWTQxq7cI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] vmalloc: Fix accounting of VmallocUsed with i915
Message-ID: <ocj6ojwevnbdp6y52z7yv3jf2xyt7l3kiccurg27utpcem33oa@j3b4cjcbow5v>
References: <20241211043252.3295947-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-1-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 04:32:49AM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages in vfree() without ever
> incrementing it.  Check the flag before decrementing the counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

