Return-Path: <cgroups+bounces-11602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C200C36CC2
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C4E642EAD
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260AA338590;
	Wed,  5 Nov 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiLfEowj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0072153D4;
	Wed,  5 Nov 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359646; cv=none; b=lJK20MZtu7UhA1eH6pg0TTi10ZFsHWdSM5F/2DoJc03YIEX4DBplUAMhgwOT64eQMwR/HHqLC81j1h0avpQFwAV0Lknu1b8RibnjFNgv2yCtLL/sFXMTNs0zwIbA2hJHidNTvu+pZl2s267lCXBJk/MlZ1gxuEuzjhgBouI/V7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359646; c=relaxed/simple;
	bh=HORUZlleqGnWgVcZ+zlwYb20knRrXuIZGW9gxPsBS1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o096crF0RTaaSlQrJqgaY5JaxoQf39VMWJiPMSAXd5U9de427S3FpSyL37xHtrfsJphzBWSOANXq/8DyWYPfIEm+wQrja/lyQlwLTfSpjQAFIYn0ET82ybEz7rtqvO01l0B6/tnvaPvsXfHVMHOcx7sSqY7t63KOyoFHbUR9ERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiLfEowj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32444C4CEF5;
	Wed,  5 Nov 2025 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359646;
	bh=HORUZlleqGnWgVcZ+zlwYb20knRrXuIZGW9gxPsBS1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiLfEowj7vPT6Pl4dqLOpNLY19tVHGFP0v47Tp5DoiLPK3xnsdZTSTMYbQBZuDYTo
	 O8ghL6BtQTDv8INj+VzQMymaj/H6sDCtq2nZ1z93yqc/wAajbl0PM7tSyFsYTz/oVH
	 c8csoGsf6nUZsLr93DkgsE+Cs/pZZf/8MxHEhKtdWeWCWhSg8sO1fmV2EZOdjzsLTO
	 H7H0v2Y693fEb83TENOJX76XqlJgw1m/0x88JXsiSnJDU06mdLum59RV1AgxSyyYbj
	 J7MczXFdDh7ckB3jsb1hJrEMmddJbXEPtYbA3ja1mjnnM9yqIi9xRpUsUZ4UKN/XOw
	 qCnVKl+dXmmFg==
Date: Wed, 5 Nov 2025 17:20:44 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
Message-ID: <aQt5XImgRtxYYt0e@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-15-frederic@kernel.org>
 <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
 <a01172d1-d902-4d55-bc1e-c8234985e65a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a01172d1-d902-4d55-bc1e-c8234985e65a@redhat.com>

Le Tue, Oct 21, 2025 at 03:28:42PM -0400, Waiman Long a écrit :
> On 10/21/25 3:16 PM, Waiman Long wrote:
> According to commit dadb3ebcf39 ("workqueue: WQ_PERCPU added to
> alloc_workqueue users"), the default may be changed to WQ_UNBOUND in the
> future.

Ok, well if necessary it will be easy to change.

Thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

