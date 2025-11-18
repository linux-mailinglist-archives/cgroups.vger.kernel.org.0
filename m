Return-Path: <cgroups+bounces-12069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0055C6B0C9
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04843350202
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195B33C1AB;
	Tue, 18 Nov 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKQRaVDD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFA298CB2;
	Tue, 18 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487883; cv=none; b=LXsks5D8QA8Zi6GCNloSHA2vA3Whyhgou4BDRvLfjV6qlReV5Ew9yiqN14mJ3nILaDFeH0FOKr0LhWV7QLGAO40J1ko++kLnodCnBz3HXJ6yCP7UQM2c/s5s7bQT3MHVY7BQ7CY7iktVm8jM5Q17RNgEJWone+NOs3z8sPqg9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487883; c=relaxed/simple;
	bh=qouANUxIMYkfob49oIeAZYG0Q46j6DSR++IbkL0Fjss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIyJe0CCBjp/JOXffA8eNzOJHW5uGiyzndWfwCK8cVzKKU8FUMnLcHvpMbL1B+zsW9sjQu+EGWQDFYwWKNuc0hrKVMKtT0GGvYnpRRfdjSm+ihKZQ8NVkWckZ0+PAZyXwbZZIYirKACIXBaqhUKePyOrLDJVqHHssWSsA2tUMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKQRaVDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9AEC16AAE;
	Tue, 18 Nov 2025 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763487882;
	bh=qouANUxIMYkfob49oIeAZYG0Q46j6DSR++IbkL0Fjss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKQRaVDD0mEAv6nQ+6JBmVo5K+YkSH2kc6BcF2JEnApkLRk/WH0gT0ANhFBIJpRgr
	 xfe4+G/+zJYwt9MiO5Qil/tcthJ1HA0Uqi1mRNmuOsh3461X8L+Qq4IhvNvroZlfZE
	 Mu14ECJIyfjQQf+UqdotiW/kwReOahpxZlbV7tGCyfYlGpLgXcxQ25tqkq6uXEO5OK
	 PToJlP/wjFoXqoq0b18Ptpy9cxQb5sPNVfNhObVCYHa696ZQEuCWO6dAOVwoLb7egs
	 CsCoCLhmt/wq0bupjNf8cufH1jr9309IyiG0O4/rYgg4dclEPtrC7nlLn+1RhFxNep
	 In5Mon0Bkyzpw==
Date: Tue, 18 Nov 2025 18:44:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] genirq: Fix IRQ threads VS cpuset
Message-ID: <aRywhhLcSN-XY1Iu@pavilion.home>
References: <20251118143052.68778-1-frederic@kernel.org>
 <87seeb5q5b.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87seeb5q5b.ffs@tglx>

Le Tue, Nov 18, 2025 at 04:14:40PM +0100, Thomas Gleixner a écrit :
> On Tue, Nov 18 2025 at 15:30, Frederic Weisbecker wrote:
> > See here for previous patch:
> >
> > 	https://lore.kernel.org/lkml/20251105131726.46364-1-frederic@kernel.org/
> 
> It would be really useful if you would have 'PATCH V2' in the subject
> lines of the series so it's easy distinguishable for humans and tools.

Right, I usually do but failed this time...

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

