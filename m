Return-Path: <cgroups+bounces-12949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F9CFFD2A
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 20:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6EA330AB50
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60A31326C;
	Wed,  7 Jan 2026 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4RHJTdV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCF1EB9E1;
	Wed,  7 Jan 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812736; cv=none; b=oRKZozxZSSjwdTs+XF5CkwfYYHV0+IJmC5Yr9FleceiiYhmjFOnlWyJt1A6+9rGPhtpodPcTKZIK8MtsWCzBqqA1CnCDJ9zTOPVVFMm2zH2I+BfD5eGrkUb021Ywr57A4/xuiDhO163hZwgnEknaWLZ7ieTKiFJtl3Tp6CcrJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812736; c=relaxed/simple;
	bh=cXrxAzv98+rTuAo6AZR2IpL01l/GgbnBK6hzUkgo918=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JgW3CwVayZkeEv8ASfTK2hgrZg9l9Ds+Vy1KmLG2IHtz2ENkZi7Na8ie8hFo8KwC0Kng3X7ijrci6B6lOfPlXSi/54Bbiap9dxphnsAok6SYZ+YcP39BtNQBwuJPOI69yaOFewP/u9UyqEX7R5fBszfNvOyARhrGQ0HgAZvnWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4RHJTdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10CC4CEF1;
	Wed,  7 Jan 2026 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767812735;
	bh=cXrxAzv98+rTuAo6AZR2IpL01l/GgbnBK6hzUkgo918=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A4RHJTdVg2eo8w4IuucYp7SsRoCH3YT//hVw93Zkkrf5yuY7VdVHzXn5p17rzjL12
	 qFhnYO1sBxAF8pzvUHMpneAhxajxGMSSn/P5eWKV8DgEr+V8cC0I0it/mxBoIwnpzA
	 ZTG5e65Y87dMZvAKJQ5K5dt9Ppt1bkZCnEZg46y9U/FleUdZZwCi/IwOgRoSRZueGl
	 wWU3xb2cH5R7JKWBRu+isqhIrXzOJQiW5H8Z0OLzuYO0YHMw3moiytq6UZetkvnrs/
	 q+BCtxWtQqAd1Xg6v3hFI08liH2/hzx+9bPTHbu7bb9UT4hw/68aVlXtLjWeg5+mZk
	 TljZ3k+3lL8bg==
Date: Wed, 7 Jan 2026 13:05:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <20260107190534.GA441483@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101221359.22298-2-frederic@kernel.org>

[+cc Jinhui]

On Thu, Jan 01, 2026 at 11:13:26PM +0100, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> therefore be made modifiable at runtime. Synchronize against the cpumask
> update using RCU.
> 
> The RCU locked section includes both the housekeeping CPU target
> election for the PCI probe work and the work enqueue.
> 
> This way the housekeeping update side will simply need to flush the
> pending related works after updating the housekeeping mask in order to
> make sure that no PCI work ever executes on an isolated CPU. This part
> will be handled in a subsequent patch.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Just FYI, Jinhui posted a series that touches this same code and might
need some coordination:

  https://lore.kernel.org/r/20260107175548.1792-1-guojinhui.liam@bytedance.com

IIUC, Jinhui's series adds some more NUMA smarts in the driver core
sync probing path and removes corresponding NUMA code from the PCI
core probe path.

Bjorn

