Return-Path: <cgroups+bounces-10749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10484BDB525
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172233AABAF
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39659307486;
	Tue, 14 Oct 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axsarSWx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25B30505F;
	Tue, 14 Oct 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475036; cv=none; b=oeJjPMikxLBkpnt5OSGSavmkMlQj3qGryfh/5F7tcpF5KSnmQ9MX9X+MjvYwWFlU9PQxGEYx+sMoJIc4CTpsqhSOVF6719yPQ7Zlb5KMimF3tLvHyW8vwJSE6IVCfiPXOcLw8sHTIAL8HEgT7/qSU688YerNaQcn7WgZagNoyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475036; c=relaxed/simple;
	bh=5rxoTWolHOm4oraQzi00YA/zUXuac4iY3HiED5t3UAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZjFXygtVo6CxNiA7NDXEKrNo54KlyLLi7noeF9r7PBtGdPVCIkRplHbaPQ4/wuprn968JMm/Mx8oFJmwD7xcbUBQlkEMmmEnjFu3lkP3lKmg4rqUyFs9WpZb7djpnqz61D3NROyNzhIXwut25Qm+IitmZrA9FmF8oUkuMPy8qHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axsarSWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45767C4CEE7;
	Tue, 14 Oct 2025 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475035;
	bh=5rxoTWolHOm4oraQzi00YA/zUXuac4iY3HiED5t3UAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=axsarSWx827Fh8I2C7WoflR8ZEe8mbgEs9R6CNEb6ECRF5VzvbWJ7lxhJgY29BVla
	 00hCz190I4TJB55vPEw8SOgjqeKIwZNiDizKvjrSRahk1tH4/0AZQwjEGe6AFvBQW7
	 KMeLDw8WmfkNZa/bigvyqkE8GtU9qkyFABpYhCWiuxdm4ZxzvEPywsTf5N66DmsQpT
	 OK747OQH2ZOYXfuDc5kNybLckElodrxrtoImcUoDyIeBQJ3xD4cAtL9fAycICL2Oeo
	 VVEnQeIDZi1UX4ffYitoGKZ/qhA4CW0Ud24/ggKohRDgxpn3zp1xwRgHW83PZ6s3pf
	 Cz5dN01+ANVYw==
Date: Tue, 14 Oct 2025 15:50:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
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
Message-ID: <20251014205034.GA906667@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013203146.10162-17-frederic@kernel.org>

On Mon, Oct 13, 2025 at 10:31:29PM +0200, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> order to synchronize against PCI probe works and make sure that no
> asynchronous probing is still pending or executing on a newly made
> isolated CPU, the housekeeping susbsystem must flush the PCI probe
> works.
> 
> However the PCI probe works can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
> 
> Solve this with creating a PCI probe specific pool and provide and use
> the appropriate flushing API.

s/modifyable/modifiable/
s/newly made isolated/newly isolated/
s/susbsystem/subsystem/
s/PCI probe specific pool/PCI probe-specific pool/

