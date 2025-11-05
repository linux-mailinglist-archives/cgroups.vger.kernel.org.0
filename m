Return-Path: <cgroups+bounces-11607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AEDC37111
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CECE1895E4A
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2A334C25;
	Wed,  5 Nov 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OParZvII"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439C3126D6;
	Wed,  5 Nov 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363600; cv=none; b=hZfyIETKURFp7Vs85oNsKv5P2V/Asuqx20MpPZ4MgN9pkKzN7Z27tcTyS5VPTbtgy/MngxzK9PKZ8QKqtjzme0tfj6PMBK51/PLyijUZUAVn7Zg6XuzMsul9vTLHFoPjLaXKvWFZrxXWHUMxRfxhQw+KNMEmZCJ9GmIbwQy/fZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363600; c=relaxed/simple;
	bh=YFkDJLxlVgB8fCGfrzLzPiyZl67TcHqa4QAD1eCk1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDqo2rI62i/T2Sntswh4zcQ1LUIgoQvTBMUCKf7ZpLZjYi0MX3aHvVT8DCW98fBVxv1TCY+jsCJ079cOZcgyfQMRsQPBOns+zN4n3YIbQxkS+5Qn5x4wcMaBadze95237GtOGgzDkSQ/yCcO/ujljKevOSmt7oTc9GOb5lEin10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OParZvII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92223C4CEF8;
	Wed,  5 Nov 2025 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762363600;
	bh=YFkDJLxlVgB8fCGfrzLzPiyZl67TcHqa4QAD1eCk1n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OParZvIIPyLR/7+d2Nc6dNNHFfgvciQYcDXNfvWRUfLM3ALdZr2Qma8M0FObiSEDX
	 4yAZaB4HMBbFQrVX9l1Nc5Mz9Akx6GYVPeFSxJauPuNjV+cvXZHiYCJny752RKPXaZ
	 nb6HFbh2rTIqP1/GSHtyqu5D4fAirasFidCHLVTYcLZQRPj1LLeRYNMtTIBUkecGZD
	 NUQfI4i1crcBXLrqQ3YrkVWcmSf4kYDrq048l6zq2V/zPjyDvLarmgFinhmBNoPsqB
	 5DP9Yf37WOYWdxdZegji5DJs83/ZGNy27MtOeueRr7A8jum6leEhur43LN6wcOt6ld
	 1Fax28SwoFeww==
Date: Wed, 5 Nov 2025 18:26:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Simon Horman <horms@kernel.org>
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
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 30/33] kthread: Add API to update preferred affinity on
 kthread runtime
Message-ID: <aQuIzQo3tDbwoytv@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-31-frederic@kernel.org>
 <aO5Dn2AwQWn0SQKQ@horms.kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aO5Dn2AwQWn0SQKQ@horms.kernel.org>

Le Tue, Oct 14, 2025 at 01:35:43PM +0100, Simon Horman a écrit :
> On Mon, Oct 13, 2025 at 10:31:43PM +0200, Frederic Weisbecker wrote:
> 
> ...
> 
> > @@ -900,6 +899,46 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_affine_preferred);
> >  
> > +/**
> > + * kthread_affine_preferred_update - update a kthread's preferred affinity
> > + * @p: thread created by kthread_create().
> > + * @cpumask: new mask of CPUs (might not be online, must be possible) for @k
> > + *           to run on.
> 
> nit: @mask: ...

Thanks! I'm dropping the current patch anyway but...

> 
> Likewise for the documentation of kthread_affine_preferred()
> in a subsequent patch in this series.

...fixing it to that patch.

-- 
Frederic Weisbecker
SUSE Labs

