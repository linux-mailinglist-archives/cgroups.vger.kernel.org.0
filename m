Return-Path: <cgroups+bounces-4466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D695F90D
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB3F1F24BC8
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39051991D8;
	Mon, 26 Aug 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWsCZYVb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923232C1AC;
	Mon, 26 Aug 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697357; cv=none; b=mCy1thEKp5lRuJaZi7DPogIwNdKU0nwPSj0kErpvgHVnug/mZ+owEe/WKfVCJ1LnHickUpi8RJfDMbt540GRfTtSg/6sUOwAsOR4td0PMy0qq8BLLh1IP7DqxyJEFqWiG0RoEY0fWTopuUOcPO3haEzrDAL52y0ViUGgHOgXiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697357; c=relaxed/simple;
	bh=41OWzCeR717jbdyTy5lfbsmYoBvRHigvaotbcJ+AcAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPWs1bOskkQ6xFxHZ+Evun9O2bpcxJLDHDE8ibpYiEYiPJczi5NMShGMSruIMqwxX68lM9vA/+C+HolaSt6oUsToAogGBquCrF5VWQTU/jEyJCD+RtXupTV5CA5hAhCm3FWuX9kGCRrhIeY09hXfakvI6GyS3GjPFGwP9KXuRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWsCZYVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533BCC4FEA2;
	Mon, 26 Aug 2024 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724697357;
	bh=41OWzCeR717jbdyTy5lfbsmYoBvRHigvaotbcJ+AcAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWsCZYVbTvpTbiWR8zNBWtHhYKp9jv7lmXpAq0Ve4WBwkg5UEweHGCqroHSdbzJBp
	 +22hgLR2M8eQNGewc4vs215HcyxZ0bBfAYBEZb/QAY0VAkFbFBMh8pPSPtKYlGGexE
	 0qtGp3j1mHl+OGBWMD9JSpyFAbH/aMB3leoezrxeNO9P+VnN04nH9abTTZbRbv/b2k
	 aHa32etdRPFtOHvMcWcERGqVrK1jpAO3JnM3tUXps6pzEoXFt+0/OOpyOBkA5wcu9g
	 RaIYOQONHXN74u8vPRixzyB6ZEU9z4dah7Jw7SDUQBhqjrRNqr5r+j0R3mJCm0A3qt
	 6AJCKXLFuB8Aw==
Date: Mon, 26 Aug 2024 08:35:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Konstantin Ovsepian <ovs@ovs.to>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, leitao@debian.org, ovs@meta.com
Subject: Re: [PATCH] blk_iocost: fix more out of bound shifts
Message-ID: <ZszLDKNSPsSAEXxr@slm.duckdns.org>
References: <20240822154137.2627818-1-ovs@ovs.to>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822154137.2627818-1-ovs@ovs.to>

On Thu, Aug 22, 2024 at 08:41:36AM -0700, Konstantin Ovsepian wrote:
> Recently running UBSAN caught few out of bound shifts in the
> ioc_forgive_debts() function:
> 
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2142:38
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2144:30
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> Call Trace:
> <IRQ>
> dump_stack_lvl+0xca/0x130
> __ubsan_handle_shift_out_of_bounds+0x22c/0x280
> ? __lock_acquire+0x6441/0x7c10
> ioc_timer_fn+0x6cec/0x7750
> ? blk_iocost_init+0x720/0x720
> ? call_timer_fn+0x5d/0x470
> call_timer_fn+0xfa/0x470
> ? blk_iocost_init+0x720/0x720
> __run_timer_base+0x519/0x700
> ...
> 
> Actual impact of this issue was not identified but I propose to fix the
> undefined behaviour.
> The proposed fix to prevent those out of bound shifts consist of
> precalculating exponent before using it the shift operations by taking
> min value from the actual exponent and maximum possible number of bits.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

