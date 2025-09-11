Return-Path: <cgroups+bounces-9976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E8B52642
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 04:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6377F7BA260
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 02:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28C2264B7;
	Thu, 11 Sep 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVFT2FaN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B320ADD6;
	Thu, 11 Sep 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556116; cv=none; b=WXZHP02TU6yHcLc6+TT4lB+j8/DQHKT0KUn7qYA2C26MNBf4hyVEzlwnsunwfMJKCzWZWOeJS5x98A/76h+6apyJwrZUIPbF6HqqBRbjy7GCPGmQg5S6I+61YRZcS0Jx5FdXmEvyvs+DIs16Bx8oKgSCdbrUgpVeMnDy/3tQdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556116; c=relaxed/simple;
	bh=M4vZtHDVg/z2yDq3EPvR1/N1D3KTDv8X9LniEfN5BcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCZtINpE8g9FJ0+b/FPqXvBVGjOFd7BlvvLRwdoFbPnbUXanZmQjAc4MToH5MTzJhmQONlnKuI/GLR+UITS9UEdYpxm2ApBKnAzgnGQJjYTTXk5SRuzAAoWQSs5Oebxv6YRFlfyccMJZHXUiIomvrChRoKm7sSgEziu8LbnhCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVFT2FaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FFFC4CEF0;
	Thu, 11 Sep 2025 02:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757556116;
	bh=M4vZtHDVg/z2yDq3EPvR1/N1D3KTDv8X9LniEfN5BcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVFT2FaNxdoz7WjlYRaU2KocZJNQ1rzTZwSfSShX8nGumRK0RD09dbVq2/pvDK3pu
	 Mgv+/fc1k1DBfVVYyzL0FWrVQmoD3vl0BpYugAztRnPiRVwy5heD3BVJFQ5exWAlvq
	 Abw2RvH2xJeRjIGQnx9uTX2/ESMYpifUyfB0btcfOKfANpfolPvveS0b9lkAeTgMUQ
	 BFPIJBGxIWCsm7khkXzqLFTHbxT/fnd7pde2dZSHn4Zo7XLFlNJUU9hh2KbqAKoAIR
	 9J+Lgi//ezj1vqUG3IYQAHRpDEViRx2NtlPa7adVY/DadaF7MVH6AJgHclliK2u57g
	 3uXTlI9cEWgQA==
Date: Wed, 10 Sep 2025 16:01:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <aMItk3c5H6Z2CD4X@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910155809.800554594@infradead.org>

Hello, Peter.

On Wed, Sep 10, 2025 at 05:44:22PM +0200, Peter Zijlstra wrote:
> Provide a LOCKED queue flag, indicating that the {en,de}queue()
> operation is in task_rq_lock() context.
> 
> Note: the sched_change in scx_bypass() is the only one that does not
> use task_rq_lock(). If that were fixed, we could have sched_change
> imply LOCKED.

I don't see any harm in doing task_rq_lock() in the scx_bypass() loop.
Please feel free to switch that for simplicity.

Thanks.

-- 
tejun

