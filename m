Return-Path: <cgroups+bounces-12164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 903FAC7BD1A
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 23:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A33BB355376
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937D30507E;
	Fri, 21 Nov 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYbbvqoi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73708274671;
	Fri, 21 Nov 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763762677; cv=none; b=qLP6W1uSqUuvPHZnRuxi/yzd2keyjQaY/HEs/aB6/P4wTLQ2KWFetr/2V5Y9Xn/PTl0B+oX91yrSLHpGX305cQIBPnhKoKXgCNJAwPs9wRP3fwO1CipLlmyFokw8QxiLUwNc6Cyq7iOEkjJm1tesAyogBVdsEn9S3pVt/E6hwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763762677; c=relaxed/simple;
	bh=9xKWBuc1gcHIHSMFYOhH9czYmjSje8Y4RiNQUXP2ezE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3YKOlxvAWznXNLM/DDrFTuwMtYp4E4IRR18e3kmpdU0PQmWd7bZdBc7rZSTt1Wdcncqtk4zvkjNXw8oA8EmVpBKxxLCAsfq1OO9SQ9sJ5ZPBW6rAa3egwSQrbT8HwrKgJlt4kHP8N8VnKgLqWgm5IcYN+qPsdjS6nfb5Up+h74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYbbvqoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1821C4CEF1;
	Fri, 21 Nov 2025 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763762677;
	bh=9xKWBuc1gcHIHSMFYOhH9czYmjSje8Y4RiNQUXP2ezE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYbbvqoitMNBhZHlxFqN1JBEaPMNg9W2nL2hgmocM0qWkMXMliLU+Q/PhKrxKkDXQ
	 9VJE8+t7qswsZVbKxuULq/3ZcaE4wygjgIw4WB21DOXL3r2grY0NCusoVfwVJ9Y0xo
	 kjgR6cmaLkVUIiJ5vdukmMMNz1xfwXUgvcUM8YKWxWCC3WdKeFiyAxHte05NPg/1FT
	 gZoUb5rLBUuvoiqHtDb2b/yMlfHTLh2muodhP8qGcu75x+aDxSvfzDdtwav0DWncIv
	 X0n6fkGfqBz96l4B5aGAbkONOB0bw53W3u/FYRHKqLCHKpM+plZcLjDo8ftithi0kk
	 U64xc9R20D+WA==
Date: Fri, 21 Nov 2025 23:04:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/3 v3] genirq: Prevent from early irq thread spurious
 wake-ups
Message-ID: <aSDh8q_UdNtU3KZN@pavilion.home>
References: <20251121143500.42111-1-frederic@kernel.org>
 <20251121143500.42111-2-frederic@kernel.org>
 <878qfzjj2x.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qfzjj2x.ffs@tglx>

Le Fri, Nov 21, 2025 at 08:12:38PM +0100, Thomas Gleixner a écrit :
> On Fri, Nov 21 2025 at 15:34, Frederic Weisbecker wrote:
> > During initialization, the IRQ thread is created before the IRQ get a
> > chance to be enabled. But the IRQ enablement may happen before the first
> > official kthread wake up point. As a result, the firing IRQ can perform
> > an early wake-up of the IRQ thread before the first official kthread
> > wake up point.
> >
> > Although this has happened to be harmless so far, this uncontrolled
> > behaviour is a bug waiting to happen at some point in the future with
> > the threaded handler accessing halfway initialized states.
> 
> No. At the point where the first wake up can happen, the state used by
> the thread is completely initialized. That's right after setup_irq()
> drops the descriptor lock. Even if the hardware raises it immediately on
> starting the interrupt up, the handler is stuck on the descriptor lock,
> which is not released before everything is ready.
> 
> That kthread_bind() issue is a special case as it makes the assumption
> that the thread is still in that UNINTERRUPTIBLE state waiting for the
> initial wake up. That assumption is only true, when the thread creator
> guarantees that there is no wake up before kthread_bind() is invoked.
> 
> I'll rephrase that a bit. :)

Eh, thanks and sorry for the misinterpretation.

-- 
Frederic Weisbecker
SUSE Labs

