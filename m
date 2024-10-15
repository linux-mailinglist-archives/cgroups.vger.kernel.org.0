Return-Path: <cgroups+bounces-5128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71A99F06B
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD01F2557C
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058CE1F6685;
	Tue, 15 Oct 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgllidQ+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D81F6675;
	Tue, 15 Oct 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004113; cv=none; b=nVYiBreAs2IJd84QyCOQUCJiBI9bKzBHpCHpayG2PWZEYZ4gt0qI3dvF9X12KtjqccOTARNWzvNJOckO6LHqZlunPucSiMSLKI/qLK0pe3OY1uwHVf+okinsOSEQzB61QSRGTvwFGAjTNTu+UfGgrmLVRP0TQwFcXh4xyxNcGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004113; c=relaxed/simple;
	bh=LAU2t0tX8u4+cLoq3khTc4llt8hB37V4SrghmuLrjqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1MhgLCx4TuJQ9e4ViCFEHdm3KHFqkFWxQrRG/l5MQB2YEs5Zld4U0G+ChmjoKYh0+n1wyDu3wlK7sPUWVg6zJWXxyWy1pKedmwkE5rIj9s40VpSNbDk0RkKAwuk89rU+oF/EtKKWWH/x/KiY2gRHy4WAIOWAElav5tZ+sRCGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgllidQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F6C4CECD;
	Tue, 15 Oct 2024 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729004113;
	bh=LAU2t0tX8u4+cLoq3khTc4llt8hB37V4SrghmuLrjqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgllidQ+2uqSzizBImi7L4RYjk4sCAM3Holk6HusvJkJbPTG8TG1AODd3RjF2nTvP
	 ykFAlI6lTwoYVqNxZsfF9QhhTD3++Q+ZL3lksBUhiY6KYPoWSHilSDaPZfEZySyYzp
	 F3r0Ck/h/I4za70rn+LL6oZzuqGz+dnB85jXPJqbuqUd/ttpNk78rG7XiIji0QVR7a
	 bXNXAFTXpTPlfNC4Gh5f2caw5DKcKo/0SHA9pTAost9t2TxL0PsHYBMnMJT3kQeQ+u
	 uWchgTGGNVRjvihXiHutlhnkwnwZsYyAYPKBCmmnordDa06asMs3TSGNBcUk9ALJwA
	 fJU7msAkMawYQ==
Date: Tue, 15 Oct 2024 04:55:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiuhong Wang <xiuhong.wang@unisoc.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, ke.wang@unisoc.com,
	xiuhong.wang.cn@gmail.com
Subject: Re: [PATCH] Revert "blk-throttle: Fix IO hang for a corner case"
Message-ID: <Zw6CUDg1xfQk12Ah@slm.duckdns.org>
References: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>

On Fri, Oct 11, 2024 at 09:47:24AM +0800, Xiuhong Wang wrote:
> This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.
> 
> The throtl_adjusted_limit function was removed after
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
> able to scale after setting bps or iops to 1 will not occur.
> So revert this commit that bps/iops can be set to 1.
> 
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Please update the description to clarify that it's mostly a cleanup. Other
than that:

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

