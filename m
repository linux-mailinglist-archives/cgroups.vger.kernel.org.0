Return-Path: <cgroups+bounces-9136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4FB25042
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25773BCF11
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6228A3EF;
	Wed, 13 Aug 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3r4VVIl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCA2066CE;
	Wed, 13 Aug 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104041; cv=none; b=hiaYTBZ42g3pIOA0hm0v0bDDgVwxCMDjo6Tbw9I8Z08XWztxWyNK3ciO4OViv0XZLx3Er/tS/LrD86iaMTSXZdoonYKt2tZ+dfy02nfHUzPI95jrGc9VFdj43nq++HsyHRH/JaK1JzqXMEYRnwMKU+bJE7Qr8Xv32weIsw5KJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104041; c=relaxed/simple;
	bh=02NLdfKncdfClMLv2zOa1DkVPQDraLI+iMf3m2mBtUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH8zUuNYgKFeUxn705Fyvqg+gTooZAgpUuqTeVafMqLXQffxW0bQzbuZiXPPVTKOKGTCTBqJHyPs9/tiDVkVCWW2sLjbXx/sugo0p+vMhjqa0/PLBWUVCw88rRlCm7EOt1IERUY6YJKJOU7YpMH+eiSEM2yY3eVc9AJPBs4Piu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3r4VVIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021C3C4CEF1;
	Wed, 13 Aug 2025 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104041;
	bh=02NLdfKncdfClMLv2zOa1DkVPQDraLI+iMf3m2mBtUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3r4VVIl6icleNEroFt5+iAt9CwkHstZxpWsn/UadT+gt0c1mZ62yfxdQZTZrAMmv
	 VzWotJvJCtBCpWkmtRimU9pghSnAzYYXhFVDp5xZrmR0BJtvgkKqmlVu9vXvpwlxnD
	 S6MwuO8z1/yzlyOnNVU+s4I3FEKX/eBH6Ie0j4QgCRBOo9qEH65viCt3lvcMR95H5G
	 yn1x9UslrK1v9zuzwxEjWTZX3yq5xSOjKTKnHpyOoE3U0fKgb+AzH8mgBaWfFoaBMX
	 DSfm8OOYtqYEMSl0uB0q2cEWMYZ5LTXNXdpXZfY8WwZWnlg69AVgFy435xt4UY3xGy
	 vJ8TPtOFR5bJw==
Date: Wed, 13 Aug 2025 06:53:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] blkcg: Optimize exit to user space
Message-ID: <aJzDJ3DfzUK_ntZR@slm.duckdns.org>
References: <87qzxf6zde.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzxf6zde.ffs@tglx>

On Wed, Aug 13, 2025 at 04:59:57PM +0200, Thomas Gleixner wrote:
> blkcg uses TIF_NOTIFY_RESUME to handle throttling on exit to user
> space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> other entities as well.
> 
> This results in a unconditional blkcg_maybe_throttle_current() call for
> every invocation of resume_user_mode_work(), which is a pointless exercise
> as most of the time there is no throttling work to do.
> 
> Optimize this by doing a quick check of the throttling condition before
> invoking it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jens Axboe <axboe@kernel.dk>
...
> -void blkcg_maybe_throttle_current(void)
> +void __blkcg_maybe_throttle_current(void)
>  {
>  	struct gendisk *disk = current->throttle_disk;
>  	struct blkcg *blkcg;

A nit: __blkcg_maybe_throttle_current() ends up doing another NULL check.
Maybe drop that? Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

