Return-Path: <cgroups+bounces-12837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85062CEC0F1
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 15:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 665043026BDF
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D721D5AF;
	Wed, 31 Dec 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/KYCPL7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0501217F53;
	Wed, 31 Dec 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189758; cv=none; b=ZEiGfeuF/HOCT+JVYNeMJbFvN70P3/Q5eHOImgqng5qr1MWmUDkcDsBP0f6i4z0t4bldvJym1V7xeD9TDdi+DQKUtfWJ5BKbuIF8Xmc7hBzl7crFvDznID0sd9yxRfci82J6NxMjuveyL14O/S4K3blbYJu/MWYjfnEfPbugveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189758; c=relaxed/simple;
	bh=CBFfLku7dIdIU6H6oIpUvPWYyR6ucYYMUyo6GlFZdAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9OyGoe2LJ+Ze3m/J6cf+4H3/QKBQ+FlbIYRrc0fLjX2TqYmJMFLdcCtcID9tPwibNx4oMXurVE02zFArN0xZh3crzWEd/y2lKR0luZaj17sXb0+ku+W+20v1MAdKnq543jUXAwcwa7/8UccNYO2V2utcYNBY3WGUOF6b5YNPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/KYCPL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA17C113D0;
	Wed, 31 Dec 2025 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767189757;
	bh=CBFfLku7dIdIU6H6oIpUvPWYyR6ucYYMUyo6GlFZdAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/KYCPL7ZtkMijc6GCGy07DqTpJm2bcO1Hyk7oeLdmLDr4cryXHiAbYSa0rdHoTmz
	 xO1R86BMlXOvB7Bi6HCf0I6MrrXlvW4Tifmo/YaGV1r6/hXHdzochqy+Rx9CDugnW8
	 KL0pY73twndKcZdjNDfVh7l6tZDUjQW4VDWv/nAL9ad6qz6ZAUtNrHXDCfP2Cywtm6
	 ugYPs4h+jagAwy6hsofbysUt3OS9gH+6R84kJxL4x3DsSiKIXbQvIHr3qZRG6sMKpf
	 M6jkkbfhDqzpVpnYKxH0r6jDyw29DBX9RAwbViO1Y+CIGYDKBMqcVEFznqc1PXd0Hw
	 Qai/24OW/4z9w==
Date: Wed, 31 Dec 2025 15:02:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
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
	Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
Message-ID: <aVUs-mFYCO2qGmqT@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
 <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>

Le Mon, Dec 29, 2025 at 05:37:29PM -0700, Jens Axboe a écrit :
> On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
> > The block subsystem prevents running the workqueue to isolated CPUs,
> > including those defined by cpuset isolated partitions. Since
> > HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> > modifications, synchronize against housekeeping using the relevant lock.
> > 
> > For full support of cpuset changes, the block subsystem may need to
> > propagate changes to isolated cpumask through the workqueue in the
> > future.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  block/blk-mq.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 1978eef95dca..0037af1216f3 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >  
> >  		/*
> >  		 * Rule out isolated CPUs from hctx->cpumask to avoid
> > -		 * running block kworker on isolated CPUs
> > +		 * running block kworker on isolated CPUs.
> > +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> > +		 * here.
> >  		 */
> > +		rcu_read_lock();
> >  		for_each_cpu(cpu, hctx->cpumask) {
> >  			if (cpu_is_isolated(cpu))
> >  				cpumask_clear_cpu(cpu, hctx->cpumask);
> >  		}
> > +		rcu_read_unlock();
> 
> Want me to just take this one separately and get it out of your hair?
> Doesn't seem to have any dependencies.

The patch could be applied alone but the rest of the patchset needs it,
otherwise it may dereference freed memory. So I fear it needs to stay
within the lot.

I appreciate the offer though. But an ack would help, even if I must admit
this single patch (which doesn't change current behaviour) leaves a
bitter taste because complete handling of cpuset isolated partition change
will require more work.

Speaking of, is there a way that I missed to define/overwrite the above
hctx->cpumask on runtime?

Thanks.
-- 
Frederic Weisbecker
SUSE Labs

