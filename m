Return-Path: <cgroups+bounces-11603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A4C36B72
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9A1888B38
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CA32936B;
	Wed,  5 Nov 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVPncHIh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726A25E469;
	Wed,  5 Nov 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360093; cv=none; b=tL4IDQoTC1HG9ck3HH0k9qn5oNau+QdfIgs4VCuFxsCF2rmrcXUDZmAbIuK+4n/KHWQNQxUWlwXIWj1neaBQLTq+Xm5KMcsfUDqcLntyUe/6OhpBs29E1sVZvlsueqB5eaSvAe36ziZQOTCm1iOdFMZQg/HU1UVxqGnafK6bf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360093; c=relaxed/simple;
	bh=XZsR+JyD+p+0AmVN0UT/SExpbSqoB4WWhXwZyYv1juM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhEZN4sbjsIxJv+Loc0+mMbU08c/vdgKokVALj4h4uK88s7zFHMIFemhIriJTXhsPaVfGHYVTYQTcQj/35s+C+fchgoy3BB21G8dYzazQCnd2wfWNTe7CbT51w0Iyl5BSDT/njRkU0eMwcwibqc7F9L3rESyObdhvjj4Fec+6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVPncHIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33848C4CEF8;
	Wed,  5 Nov 2025 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360092;
	bh=XZsR+JyD+p+0AmVN0UT/SExpbSqoB4WWhXwZyYv1juM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVPncHIh/EOqGFCdREjl+2w+VGlqkjCAARlMMggMBvZaXK8WL0I7nOF5N4aUy12Cq
	 1MSijhgS4t1291bQKTZV13FU2rRXBsTAO6sw3VIanGxLl45tXeypLZpfH9cBgrprC5
	 fM1xwVaxJiZq6874ZxPd6vM4+G2lil3Imv1yectPVArs+70jgStj+MFd3Ah71oFg6O
	 zr7opLT5qYj/5SwzNxTtzqY28hyfZ5N9A4zxq7eSVVstrYiRaE1amTmjR9YabuZCi8
	 h9RLNiMmdI08k8CXbIE1EcfMEPVNt1U4TNNFRL6y1/AssFAz50F6+TmhCRxSGER9yX
	 s9v6wleyskP0A==
Date: Wed, 5 Nov 2025 17:28:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 16/33] PCI: Flush PCI probe workqueue on cpuset isolated
 partition change
Message-ID: <aQt7Gg3XJ7fVdD3W@localhost.localdomain>
References: <20251013203146.10162-17-frederic@kernel.org>
 <20251014205034.GA906667@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014205034.GA906667@bhelgaas>

Le Tue, Oct 14, 2025 at 03:50:34PM -0500, Bjorn Helgaas a écrit :
> On Mon, Oct 13, 2025 at 10:31:29PM +0200, Frederic Weisbecker wrote:
> > The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> > order to synchronize against PCI probe works and make sure that no
> > asynchronous probing is still pending or executing on a newly made
> > isolated CPU, the housekeeping susbsystem must flush the PCI probe
> > works.
> > 
> > However the PCI probe works can't be flushed easily since they are
> > queued to the main per-CPU workqueue pool.
> > 
> > Solve this with creating a PCI probe specific pool and provide and use
> > the appropriate flushing API.
> 
> s/modifyable/modifiable/
> s/newly made isolated/newly isolated/
> s/susbsystem/subsystem/
> s/PCI probe specific pool/PCI probe-specific pool/

All fixed! Thanks.


-- 
Frederic Weisbecker
SUSE Labs

