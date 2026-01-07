Return-Path: <cgroups+bounces-12952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED34D00681
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 00:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C8AC3002D07
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A342F8BDF;
	Wed,  7 Jan 2026 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWc2qayR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA561A256E;
	Wed,  7 Jan 2026 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767829199; cv=none; b=KFQwdKYqvHpNT2tvj8vZhhmVSg2wdB48Ob5RQUXKooQJhUfAtBEWcZd24RUG7qWuNEhS79ZUmyYvY//RMwtEFR3VUO6u0TKaDnG5ni8O7/2wKM0mupwluNKTLuOHFRmRgZlPqeubCx2oXNejkzrvFR1Dtn0qXwin+LpqAVzHnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767829199; c=relaxed/simple;
	bh=TkPExvuLRdk+twI/ygMh7+/Ril+KIPyMUG6oDC8D2N0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lFn2nBW2RyKqkYzO+Zo+GZH/ECk8kwpCseAhv42IlryT4r9jpt1SS/W+Ryt+7hhUkBGq4zW62UAqczVV8XQ4AYhNVkt28tDdcaR1ZUhkBCIE2co7a6XJ9vQpG8DusWvgNfzJ5oPxmBYfU1ttQ/4Ajg0UbMVrGXmVQC7gB9dtwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWc2qayR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B94C19421;
	Wed,  7 Jan 2026 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767829197;
	bh=TkPExvuLRdk+twI/ygMh7+/Ril+KIPyMUG6oDC8D2N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QWc2qayRWh0hWdOy89mtUEyGFJiHeys6+PiJCJTh8FCimQmcF4f3KQLBEmA88hw10
	 /bZvZR94ATDjonBzReJDFiH2CWArObd+a8i78tc4q18E6ySfp6xu9HbUNc002v+3Yq
	 RGKRTbINxcjSZwP2MCkG/EPm88+Wt+jCjRwufGQCj4FqHeIPPOqf1yag/eYPs1lfGY
	 0bomX+d4DHXHvJjAMgVdrHQ5b5Gkap3ilsfChy/O55qxjVWHBeLNB4E2bl8dBsU0At
	 VIu+/mFZCjqTLTppjOwLawF4UDXaj7ciEXXMrX3JN+4r082FGEWMC4M7mH52MCEL+J
	 Klea0ah1V/qsA==
Date: Wed, 7 Jan 2026 17:39:56 -0600
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
Message-ID: <20260107233956.GA453841@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV7sheFKQWb23lsc@pavilion.home>

On Thu, Jan 08, 2026 at 12:30:13AM +0100, Frederic Weisbecker wrote:
> Le Wed, Jan 07, 2026 at 01:05:34PM -0600, Bjorn Helgaas a écrit :
> > On Thu, Jan 01, 2026 at 11:13:26PM +0100, Frederic Weisbecker wrote:
> > > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > > therefore be made modifiable at runtime. Synchronize against the cpumask
> > > update using RCU.
> > > 
> > > The RCU locked section includes both the housekeeping CPU target
> > > election for the PCI probe work and the work enqueue.
> > > 
> > > This way the housekeeping update side will simply need to flush the
> > > pending related works after updating the housekeeping mask in order to
> > > make sure that no PCI work ever executes on an isolated CPU. This part
> > > will be handled in a subsequent patch.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Just FYI, Jinhui posted a series that touches this same code and might
> > need some coordination:
> > 
> >   https://lore.kernel.org/r/20260107175548.1792-1-guojinhui.liam@bytedance.com
> > 
> > IIUC, Jinhui's series adds some more NUMA smarts in the driver core
> > sync probing path and removes corresponding NUMA code from the PCI
> > core probe path.
> 
> I see. I can't drop my change, otherwise my series alone could crash
> dereferencing garbage. But Jinhui's series removes the need for my
> changes.
> 
> So an unpleasant conflict will happen in -next (and if everything
> goes well, further in next merge window) and it should be resolved
> with simply ignoring my changes and only apply those of Jinhui.

I don't want to derail your series, and I don't think you need to
change anything right now.  Jinhui's series is early and might not be
ready to merge until after yours, which should be fine.

Bjorn

