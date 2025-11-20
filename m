Return-Path: <cgroups+bounces-12125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E854C743FD
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA55E4ED6DD
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B793081CC;
	Thu, 20 Nov 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE7qLKoU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C561F0995;
	Thu, 20 Nov 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644836; cv=none; b=o8NumbQ8F5W5mvdULoqVvBClE2pJe/8PwWCXmyw0fwfoY6ik7ZUHYwrh7kfF6n0TD/D+jVtAbpN922PjFGAWBwTg1ftjHEhajb7jjE1vCMhub2+KPK3DxU+nSU3kIcU4EAB3+tnwwtqexBjuCwUNN9bjyB01wiuk31HDd5yyAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644836; c=relaxed/simple;
	bh=suChz3lb455K0CTc0lxqoZMuUln/t/yNRJylmUEI0uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc3HIgtpRTSWuLOT+qWNUL4c3rTzQCQmwOuusx/DnBCRINQnEWVgi4w1z0OjvufjIvJEbQvIY5Tu/KZ1QNz+uWULCB2C77+1XF+Qk9DjnciERBQz8t08rA/wxBURTTYuCgHBQu5jl8p8ZZ7Rhsj2Uu9qWw9ZCpGuW1jyBkqRt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE7qLKoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07699C4CEF1;
	Thu, 20 Nov 2025 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763644836;
	bh=suChz3lb455K0CTc0lxqoZMuUln/t/yNRJylmUEI0uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE7qLKoUsAPutpbnrmwjp9vykq5EjMzu28IBVF6NPPhgbKwMmq35tpdqtrW7GGY5F
	 BvLDy/Sj0j2uq0jpopWM0Fd9dJvjewEhLskgTZsSH6d3c2ttcvsYkZt37iIWmPNetG
	 RflX4Rv+1h/0vlA0wE8zQKkybUB5H8ZOKqHDphGdLjbimNLclXaSBswEseHXF+Lljg
	 19ulMxpDPqlPNs1IIZq47CPRKrUI01VQ5ZC5KwzaaBJKF6U+KFpJk7pjEoxkIjPlTU
	 d5u1/6VfG9fLGdD2rq2ShBoFe71Kk5pBCE0/fFhL65xCVmSS6V7XLY9efhPOwJ2LTm
	 0kQa3l8fUq8xg==
Date: Thu, 20 Nov 2025 14:20:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
Message-ID: <aR8VoUxBncOu4H47@localhost.localdomain>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
 <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>

Le Thu, Nov 20, 2025 at 12:51:31PM +0100, Marek Szyprowski a écrit :
> On 18.11.2025 15:30, Frederic Weisbecker wrote:
> > When a cpuset isolated partition is created / updated or destroyed,
> > the IRQ threads are affine blindly to all the non-isolated CPUs. And
> > this happens without taking into account the IRQ thread initial
> > affinity that becomes ignored.
> >
> > For example in a system with 8 CPUs, if an IRQ and its kthread are
> > initially affine to CPU 5, creating an isolated partition with only
> > CPU 2 inside will eventually end up affining the IRQ kthread to all
> > CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
> > CPU 5.
> >
> > Besides the blind re-affinity, this doesn't take care of the actual
> > low level interrupt which isn't migrated. As of today the only way to
> > isolate non managed interrupts, along with their kthreads, is to
> > overwrite their affinity separately, for example through /proc/irq/
> >
> > To avoid doing that manually, future development should focus on
> > updating the IRQs affinity whenever cpuset isolated partitions are
> > updated.
> >
> > In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
> > To prevent from that, set the PF_NO_SETAFFINITY flag to them.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> This patch landed in today's linux-next as commit 844dcacab287 ("genirq: 
> Fix interrupt threads affinity vs. cpuset isolated partitions"). In my 
> tests I found that it triggers a warnings on some of my test systems. 
> This is example of such warning:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/kthread.c:599 kthread_bind_mask+0x2c/0x84

Erm, does this means that the IRQ thread got awaken before the first official
wakeup in wake_up_and_wait_for_irq_thread_ready()? This looks wrong...

irq_startup() may be called on a few occcasions before. So perhaps
the IRQ already fired and woke up the kthread once before the "official"
first wake up?

There seem to be some initialization ordering issue here...

Thomas?

Thanks.
-- 
Frederic Weisbecker
SUSE Labs

