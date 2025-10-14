Return-Path: <cgroups+bounces-10745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00772BDB10B
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A7D4E306C
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86457259CA9;
	Tue, 14 Oct 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exlk9FKU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477719E7D1
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470348; cv=none; b=TypbDl1V2y/P+drV8qI8fPaSzA3lZR3KJ5hSF9YUz18c67AsrXuGhGdf5pxItqulGiPsokgl6r2MEJIXejZx3zruj/c94ZULUOUh70BsFtx9UKb+tpyWAwCq5kT5QAA6/9aN/onP1QvusY2uDwRWVcJelXplLwgnzQBc5ursp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470348; c=relaxed/simple;
	bh=4mKKRoA4iUl+TlFChIRCddceiE1chfQN78lGzwwF6j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2ebs3L++1aEdJUyeqZaGrsuzTWPG8C/hs7r6OHALxb9rl3Uw0J7+ULoRHjiZFmMkA9DF8wy1BU1Zu2XPkCm3ghLu/v4JscY6KM4SHZDI52SLJENLnJSSgo0AvWXNSWYfhcYjwOAtSpFbMW6/yaixXTNdzZO2F1pPwgAfrY9X78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exlk9FKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1562C4CEE7;
	Tue, 14 Oct 2025 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760470348;
	bh=4mKKRoA4iUl+TlFChIRCddceiE1chfQN78lGzwwF6j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Exlk9FKUA6abvEMbr7+ec3EoO6rpxGFmPnhqnqR1QzXyZv/0SUh28XP8eVC+GHqVK
	 Atb/qsf/+6NMTmXupl2mpFEYLhpQrGZV/Wri7UBo2GgCYRzyYOoO61mUJ9feIWRGAj
	 MB3/diYxnFZvWUz0x2Fe8YzA+bVddqImqdL7dmpPazMYRD/Wqp8AXtjpxsUYTmYgGv
	 9T6gCaPeYMQk1ae60bxdYGuExfuYN1enOD0mGOiR3Emw9XBbCneupnUEYe7uEOGJGj
	 Uu4vkzlBgdPAMcq83m+DKnW91vDI1VCuasdjhAGz7A7Ac409PXla1BtB+6tvzR+p5S
	 qErVHrGPIH7ig==
Date: Tue, 14 Oct 2025 09:32:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 1/2] selftests: cgroup: add values_close_assert helper
Message-ID: <aO6lSuegFp4G7lRE@slm.duckdns.org>
References: <20251014143151.5790-1-sebastian.chlad@suse.com>
 <20251014143151.5790-2-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014143151.5790-2-sebastian.chlad@suse.com>

Hello,

On Tue, Oct 14, 2025 at 04:31:50PM +0200, Sebastian Chlad wrote:
> +/*
> + * Checks if two given values differ by less than err% of their sum and assert
> + * with detailed debug info if not.
> + */
> +static inline int values_close_assert(long a, long b, int err)

I wonder whether assert is a bit misleading given that asserts are generally
expected to terminate the program on failure. Maybe sth like
values_close_verbose() or values_close_report()?

> +{
> +	long diff  = labs(a - b);
> +	long limit = (a + b) / 100 * err;
> +	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
> +	int close = diff <= limit;
> +
> +	if (!close) {
> +		fprintf(stderr,
> +			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
> +			"tolerance=%d%% | actual_error=%.2f%%\n",
> +			a, b, diff, limit, err, actual_err);
> +	}

{} are unnecessary here. Can you please drop them?

Thanks.

-- 
tejun

