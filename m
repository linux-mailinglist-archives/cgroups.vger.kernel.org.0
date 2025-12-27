Return-Path: <cgroups+bounces-12771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A318CCDF2D3
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 01:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D27300B9A8
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2C1EFF93;
	Sat, 27 Dec 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tduMpdCm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99321A3166;
	Sat, 27 Dec 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794686; cv=none; b=uYpGgV4hImTv3w1kJhsWtVpHC/2ABU7rPi0r0q44QPQKeCuJY7GCMP4+GmyLx456QObofrnBJSB+jop989OpZozGlgB0vPZhaTP2oJd9vpBO6yXjIYzrkobDJX2eipJ7irjI4JwZGD+COJ3DdI3tkw4sH7pkWQ5EHzrbGu4NVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794686; c=relaxed/simple;
	bh=ZqpJU+rrtyriuXVbfa8/1GLYlSPnOy7NbFVtMvqk1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0P6FpKDqCN5YIBPDLCSO/masb4exqKc6KRbTofazAjZ1SBx5713botXilpBMKgt7qnWQt+CyziElmS7GJHdp3EtfqCJeKtX3SpfiuGSdJporLtvfF4lPgR3ouDtilOlc7Cm7jYTN0tzC6oZe+pXi/gjvdA0SZpBsiv7lTByfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tduMpdCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F066C4CEF7;
	Sat, 27 Dec 2025 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766794686;
	bh=ZqpJU+rrtyriuXVbfa8/1GLYlSPnOy7NbFVtMvqk1so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tduMpdCm7pTU545ESqbiCA9OZMUAVvB4CzcHOhvSiJfeHqftgQCgmlMdDZwImZ0je
	 g8gEFnw4krUQuccQ0OMgu0Kv3Fz5iPLHuGKiJTV+qsqBtqF0j6ykjSlhaX3N6RsT3O
	 P6qkaOv/wtXzqWrZ//onWroe6YEnQn5jt+HhekOR5TasgETXMgdvyTGjNAGKrhMzsB
	 KE8n+88ZNp6U9Pvu/FYPmsB0cbUiZu6HvKgQgmIsi5kpMngPZrD1k6arRFvELAHWN8
	 AJ/zWgabDLlnKrCqpClwTNBuhtZlm2B4uJFjmeBTj9e4gSvzkm4m3dhI9DZLsCfLK8
	 UYuhDQ1G9YJkg==
Date: Fri, 26 Dec 2025 14:18:05 -1000
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
Subject: Re: [PATCH 18/33] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
Message-ID: <aU8lvW7nfTukNKGK@slm.duckdns.org>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-19-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224134520.33231-19-frederic@kernel.org>

On Wed, Dec 24, 2025 at 02:45:05PM +0100, Frederic Weisbecker wrote:
> Until now, cpuset would propagate isolated partition changes to
> workqueues so that unbound workers get properly reaffined.
> 
> Since housekeeping now centralizes, synchronize and propagates isolation
> cpumask changes, perform the work from that subsystem for consolidation
> and consistency purposes.
> 
> For simplification purpose, the target function is adapted to take the
> new housekeeping mask instead of the isolated mask.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

