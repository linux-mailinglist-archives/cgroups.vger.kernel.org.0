Return-Path: <cgroups+bounces-12769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A0CDF241
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 00:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A3BD30010C6
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355EF28643C;
	Fri, 26 Dec 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESTPbVJJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D922D9F7;
	Fri, 26 Dec 2025 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793412; cv=none; b=WzU8teJVqQ+HA2vcUXostqaOTW6SgL6OvQg4nFG1Ci4XylZYt8rDC2+CL9MhiG60FhQRdA2KMVbBMfEcD/3eaz0k3Eqmn6Q+4n2i62SOdKmfQZ+p2mczUszw4mbuD1J+TRDdyskLRjGpUzbMh8ngCxa6boAE2IBm2qVo4R7jFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793412; c=relaxed/simple;
	bh=TmkQ20OZkTQkt5CoWiGqlvcZyzl19wgFNsEBjFcJyxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLSQoC2cksB2wBcjEa10eSMn4m2Obl+xndIyRRkF4xr7ZkYgkV2llg7lO5VwCzJVC9O2EOZ/Wz6TinpD4nokIrZPrTSDlnhrAxX12b7knKxo/x15/selJMAQNgzWeOzXm8BoGfxhGjV2dPXeSaQaOy0G0acBhMQB3v9X9UizkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESTPbVJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053BEC4CEF7;
	Fri, 26 Dec 2025 23:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766793411;
	bh=TmkQ20OZkTQkt5CoWiGqlvcZyzl19wgFNsEBjFcJyxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESTPbVJJEMD9u9uHankO1Rd8hjsHnae8LYU/sqHgEPolKKBWTxvNiLpqtXw/Afw7I
	 kRI+cWQthmnS7MU0oGsE0IHLNMkKsI/EoJ1Ln4bL0WmRvXJQAjMpS6Hm+aFs0XWtNk
	 kouoAQmT585nRVEqyOuSzCqiEASOJPYciCVqlpyTUVW0BZuTZw7B66wIPPcN83E2QN
	 9+5R/Nfv7VVEeSGyicAkaNhQXEc07s2XAd0ApwBhwayDKn7ZvxLcpUabe/caIjhlFz
	 L8GjFTl8a8wrHjo5nhcXTSIWvhmVGzMxb70RcdWJGqcetaCEi73LRF9AFuGejws8Zf
	 flFJuqv38l56g==
Date: Fri, 26 Dec 2025 13:56:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aU8gwjlVmRkMtPZT@slm.duckdns.org>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224134520.33231-4-frederic@kernel.org>

On Wed, Dec 24, 2025 at 02:44:50PM +0100, Frederic Weisbecker wrote:
> +static void schedule_drain_work(int cpu, struct work_struct *work)
> +{
> +	guard(rcu)();
> +	if (!cpu_is_isolated(cpu))
> +		schedule_work_on(cpu, work);
> +}

As the sync rules aren't trivial, it'd be nice to have some comment
explaining what's going on.

Thanks.

-- 
tejun

