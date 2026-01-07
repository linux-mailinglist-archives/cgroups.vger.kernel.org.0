Return-Path: <cgroups+bounces-12951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B6D00659
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 00:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BA13030930
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC552EBDD9;
	Wed,  7 Jan 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD9BLnDO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50018027;
	Wed,  7 Jan 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828616; cv=none; b=VZ1//yZUmabkmACj3soZFimTup1EZR6eltK+fs8CPfwAmg/6Nhd4twmynGJAsa4RuiClT36ePvHX5j6EZ5AiSbZl6IJwOw8Vy3j0XizdblQi6OIHDtV2wIQrcLr8LVA/MYAP52Z9ceaNf1W9Bn7H+OT0NURxv3b++38IOVQYUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828616; c=relaxed/simple;
	bh=JJUKBnRRM9z3Ei4dz7JLCEY8pd+eY/BXxSmSJZTydcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0jkOtoNnfFIRi2LkuyWre6vIHAAY+MIFr53c8ayVjYxubCC1BBJPj/BxtKHdb7lJGExts9VqYdWKSM64iqyh8icPg8MN+Jsc8DLmpgZsIlM2gfTGrDGsMeML20IYsrAadaE9E8/pnooqxtgdkGzx71Q8/tvxAMn2/URZvUkDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD9BLnDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E29CC4CEF1;
	Wed,  7 Jan 2026 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767828616;
	bh=JJUKBnRRM9z3Ei4dz7JLCEY8pd+eY/BXxSmSJZTydcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FD9BLnDOkE5gza7p0aI13xDJW1xjmBlp99SMKC13B/Vu4oiy+78aPYh+cbVuLnYGy
	 Fl7pXOjBsyLlmELBlm+4tVm4lT63RyIqyfDl24wlumHGuh2jgrHdHOEDbXU7Y+iG4J
	 /cHcKtewu+hEeQy6sIPWCWmwhQ3xTmh8+irt2gmFHTE1PNT3SnQzutRbgCHg4kMkqJ
	 1v0+eyQaw8MBLlsvVmyyPvKgWUeroyNXlpAAQskjsL5sHDX2UY4zCFhfUJoa3jI8OP
	 30a4z9OUHiAqzAQ4p/IXy7EOUGqDGWTd1vqf2YxHqqwsrhtrrNFsIBVPovzyz95bcV
	 p1KJ2zvhxZYtA==
Date: Thu, 8 Jan 2026 00:30:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aV7sheFKQWb23lsc@pavilion.home>
References: <20260101221359.22298-2-frederic@kernel.org>
 <20260107190534.GA441483@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107190534.GA441483@bhelgaas>

Le Wed, Jan 07, 2026 at 01:05:34PM -0600, Bjorn Helgaas a écrit :
> [+cc Jinhui]
> 
> On Thu, Jan 01, 2026 at 11:13:26PM +0100, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > therefore be made modifiable at runtime. Synchronize against the cpumask
> > update using RCU.
> > 
> > The RCU locked section includes both the housekeeping CPU target
> > election for the PCI probe work and the work enqueue.
> > 
> > This way the housekeeping update side will simply need to flush the
> > pending related works after updating the housekeeping mask in order to
> > make sure that no PCI work ever executes on an isolated CPU. This part
> > will be handled in a subsequent patch.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Just FYI, Jinhui posted a series that touches this same code and might
> need some coordination:
> 
>   https://lore.kernel.org/r/20260107175548.1792-1-guojinhui.liam@bytedance.com
> 
> IIUC, Jinhui's series adds some more NUMA smarts in the driver core
> sync probing path and removes corresponding NUMA code from the PCI
> core probe path.

I see. I can't drop my change, otherwise my series alone could crash
dereferencing garbage. But Jinhui's series removes the need for my changes.

So an unpleasant conflict will happen in -next (and if everything goes well,
further in next merge window) and it should be resolved with simply ignoring
my changes and only apply those of Jinhui.

Should we inform Linux Next people ahead?

Thanks for making me notice!

-- 
Frederic Weisbecker
SUSE Labs

