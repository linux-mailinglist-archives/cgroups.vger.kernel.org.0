Return-Path: <cgroups+bounces-2721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1598B609E
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 19:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434821F236C1
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E912838D;
	Mon, 29 Apr 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWOvB6Tk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF91272D3;
	Mon, 29 Apr 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413017; cv=none; b=YSGq1GqXWl6tVvwoob04pl89It8luTsBb515vz78iCUt1t16/9DAFctH6O8lADculNbMb75ErBzjOC3/LJSAdyXnJqKn4aBZHshWkLqhcMDr93flOslLsmMtZ8VDB5+Vth4vLpPoFHY8rUihOMKd+WEQ7Zmg7E7XIi7ZdzZEvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413017; c=relaxed/simple;
	bh=lUgtS8c+FCW6wGfLKkpejhCuu9OnmDAw7IJtwTpXqDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tif6o4nGWrgB58//uvyaiJfc4WdasIB6BWwg8qwOdwv0FHwhAd8Z6XGDpxD1CHE0JvVSoyfNr4LKGkUwhPtPc0ey3OkONklra0CjEX80SKy5gypoqOQ9EhwrpIVlX2CxgGgQy864iB+JYsGjlzrol5I2pS1v0BxcvEszTyP4cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWOvB6Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D26C113CD;
	Mon, 29 Apr 2024 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714413017;
	bh=lUgtS8c+FCW6wGfLKkpejhCuu9OnmDAw7IJtwTpXqDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWOvB6TkhRcCMweJ1Ks8b8uPzwsNbM4diq5jX9SZu/0bRm+MFitwLaCLMey0zT6aA
	 fq+IWTvb9Q3NiRtRU5dW3vOJCP1g5bEQ/p9aHwdscYIhzByC3Gn5VubEoY2OxsPPbh
	 xenJ4prcEKVpzOtzNufHptYggOn3KweNOVmARGtoTumqaP6ehE+QTem/fK18Vxdcql
	 SdJxwBNC1Ao/YZLAIz+xULkIyERBb+wW5grcWK2kDHejrCGd7cBR7CBwj9/vnAkGsm
	 LcHRmmLzCk3g3DEi79ZQNJss1WzFmkyi2Hvxh7sjYePNDuoROvQYQ8Cps2u4WvBoQT
	 lZPdIdiiVkshA==
Date: Mon, 29 Apr 2024 18:48:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
	cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
	kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	mhocko@kernel.org
Subject: Re: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
Message-ID: <20240429174842.GF516117@kernel.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328988660.3930751.17537768209042139758.stgit@firesoul>
 <20240423165350.GY42092@kernel.org>
 <21dd3b6e-6e7b-4dcb-9050-4d63fc810749@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21dd3b6e-6e7b-4dcb-9050-4d63fc810749@kernel.org>

On Mon, Apr 29, 2024 at 01:36:20PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 23/04/2024 18.53, Simon Horman wrote:
> > On Tue, Apr 16, 2024 at 07:51:26PM +0200, Jesper Dangaard Brouer wrote:
> > 
> > ...
> > 
> > >   /**
> > >    * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
> > >    */
> > 
> > Hi Jesper,
> > 
> > as a follow-up could you add an entry for cgrp to the kernel doc above?
> > 
> 
> Already fixed in TJ's tree for-6.10
>  - https://lore.kernel.org/cgroups/ZiB97v73Fr-wq14f@slm.duckdns.org/
>  - https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-6.10&id=97a46a66ad7d9126
> 
> But thanks Simon for your vigilance in noticing these things :-)

Thanks Jesper,

I appreciate you letting me know :)

