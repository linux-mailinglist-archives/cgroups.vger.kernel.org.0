Return-Path: <cgroups+bounces-5864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C69EF8FB
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9228EE17
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D34229686;
	Thu, 12 Dec 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ/lQM3Z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D808225A21;
	Thu, 12 Dec 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025489; cv=none; b=gosvCpc09dkOQsPYLSaurKO59YTEiEZIYgkgqoxsAuQMwSzh/zq5fKKV3VPe8SiDdMXyLqAbdbdPFYjeOV1mEJKIOfTRNz1YZ4cAYKdzPDhftKFKsmIX6jWeNU1zlrT+/ATILhzB37ThcBNY0DVhHCr/F1j++RHM5FC7LwOs2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025489; c=relaxed/simple;
	bh=9tKjhSY0qkGEtTedwIdJnqlX2zVR0a9N/gnmnBVr8Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BStbIw/mfA6PsMPcSof8VvpOHmOplCypNzT035tBA/MQjl4qtr6Jt+D2K86ivP1CNW7bXAfNpBx2UvHhhWkEMZt6yBh0Ftk+w87yyuBbIRgcHusCZ4tfOc0l42/UdZfE/1l6KkW/4EH6xkJLsYJwEqHOysfJL4uu12bBz7AG/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ/lQM3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0240C4CECE;
	Thu, 12 Dec 2024 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734025489;
	bh=9tKjhSY0qkGEtTedwIdJnqlX2zVR0a9N/gnmnBVr8Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZ/lQM3ZxOQj99+ru5U9GsTlZXmtrv+GycdFGABcKJfO9Q+DJwIQDnhUhtIo2WGDD
	 0O7N12jymgot0QCYpOQsOQWkA4IlP7n5+kS1u5HGaRIFZ1n+TlnqoEHJaE2cNyM1GK
	 yVDuEx5J3ZBDI5UfdmEWkDJtHEr/xuOCwvKbCHKdkPj0BFq+CIhRji3Jj/I+Tu4rOr
	 F2jaTLwG29mt7Yf1PjVYwms8TI08NDirPHha8hmieFpPg+CpkSphA8Jw1gojDo1txk
	 PNfR0bmasi8JPKfolBueyWqBpfWZ3NKX9O/Jzq/1wFXsLhprLL+bdrMv/ZbX9lfv9u
	 3cOKTDkWORYJw==
Date: Thu, 12 Dec 2024 10:44:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	David Laight <david.laight@aculab.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Message-ID: <20241212174444.GB2149156@ax162>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
 <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1sbG2zh8xmb-lxu@slm.duckdns.org>

On Thu, Dec 12, 2024 at 07:19:23AM -1000, Tejun Heo wrote:
> On Thu, Dec 12, 2024 at 10:13:29AM -0700, Nathan Chancellor wrote:
> > After a recent change to clamp() and its variants [1] that increases the
> > coverage of the check that high is greater than low because it can be
> > done through inlining, certain build configurations (such as s390
> > defconfig) fail to build with clang with:
> > 
> >   block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit 1 greater than high limit active
> >    1101 |                 inuse = clamp_t(u32, inuse, 1, active);
> >         |                         ^
> >   include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
> >     218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
> >         |                                    ^
> >   include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
> >     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
> >         |         ^
> >   include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
> >     188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
> >         |         ^
> > 
> > __propagate_weights() is called with an active value of zero in
> > ioc_check_iocgs(), which results in the high value being less than the
> > low value, which is undefined because the value returned depends on the
> > order of the comparisons.
> > 
> > The purpose of this expression is to ensure inuse is not more than
> > active and at least 1. This could be written more simply with a ternary
> > expression that uses min(inuse, active) as the condition so that the
> > value of that condition can be used if it is not zero and one if it is.
> > Do this conversion to resolve the error and add a comment to deter
> > people from turning this back into clamp().
> > 
> > Link: https://lore.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/ [1]
> > Suggested-by: David Laight <david.laight@aculab.com>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/llvm/CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202412120322.3GfVe3vF-lkp@intel.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks for the quick response!

> This likely deserves:
> 
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Cc: stable@vger.kernel.org # v5.4+

Thanks, I was wondering if I should have provided those. I'll carry them
forward on any future revisions, as I assume Jens can pick those up with
your tag if this is good enough.

> 
> -- 
> tejun
> 

