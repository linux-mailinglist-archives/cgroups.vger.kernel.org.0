Return-Path: <cgroups+bounces-5862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC29EF72A
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D083401B4
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7B2165F0;
	Thu, 12 Dec 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWO+5QDW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59E1487CD;
	Thu, 12 Dec 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023964; cv=none; b=CjtMJ+3WdcI5g2FKGll1B9Jt8b+NsLjTjxmDRwk63cDeDu+4C+1xQMgX1g3OA/50cD3uxsrPo4TIaKSOZ8EZdnii9Xx0fKSOSBLd/pmJPl0QVvfLZ+pGDZrF5T2LdBteetDJE+AfJawBgnasYP37kWUv1yP2GNR5xiRJqKJDaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023964; c=relaxed/simple;
	bh=DkH6pOAD6QKqV51TEa2FwY8/RsRE/pLozR2Nuj2ICB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh6yNQT3HBtG1PCxxjUW3AzHW0vdIMfUQIKPR/Vswob1j3NJ0iW4OZuTiQC1wgaaky4ZU6eAj39rITAP9ZWfZFkVrg9aXfvJ1uBLRyooKYz40cHjClnjLz4ZtZX7OIBtNwxQBWskyGk/ld82l+QKKTIM3qJGDNE8txNXTxZeDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWO+5QDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936A4C4CECE;
	Thu, 12 Dec 2024 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023964;
	bh=DkH6pOAD6QKqV51TEa2FwY8/RsRE/pLozR2Nuj2ICB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWO+5QDWqclfAlSAKLa6E7bgNqlx9dQW3ew2/Z+uXYQ7KXgAvzocNLQVWcshzdPCK
	 lS6neF4G0lVdkYQb7K8ienigW6Q3hgIGq3xeVZY84SSLoDApC+Xf2G4p2/w1gRq1x1
	 kohx9KePCS7Z+RLf9SgfGg9HenjbQS31Pal8rSAOUPBi9SbusJuGxhzdYu3d1E044g
	 4UOq0O6Y5JEmQbySuc+kVDwyJwhh1pEkHUM1mGuKByLxSHPAGjW9yn+L0q7axlSDgU
	 KJTkETudMK/L7/KXC++CAhT9F5gYY/yV1nztOmqLajKIRvAZ2UMF//zYP9kVgDJkcY
	 obFWPPy+GxPVg==
Date: Thu, 12 Dec 2024 07:19:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	David Laight <david.laight@aculab.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Message-ID: <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>

On Thu, Dec 12, 2024 at 10:13:29AM -0700, Nathan Chancellor wrote:
> After a recent change to clamp() and its variants [1] that increases the
> coverage of the check that high is greater than low because it can be
> done through inlining, certain build configurations (such as s390
> defconfig) fail to build with clang with:
> 
>   block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit 1 greater than high limit active
>    1101 |                 inuse = clamp_t(u32, inuse, 1, active);
>         |                         ^
>   include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>     218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>         |                                    ^
>   include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>         |         ^
>   include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>     188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
>         |         ^
> 
> __propagate_weights() is called with an active value of zero in
> ioc_check_iocgs(), which results in the high value being less than the
> low value, which is undefined because the value returned depends on the
> order of the comparisons.
> 
> The purpose of this expression is to ensure inuse is not more than
> active and at least 1. This could be written more simply with a ternary
> expression that uses min(inuse, active) as the condition so that the
> value of that condition can be used if it is not zero and one if it is.
> Do this conversion to resolve the error and add a comment to deter
> people from turning this back into clamp().
> 
> Link: https://lore.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/ [1]
> Suggested-by: David Laight <david.laight@aculab.com>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/llvm/CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412120322.3GfVe3vF-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

This likely deserves:

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org # v5.4+

Thanks.

-- 
tejun

