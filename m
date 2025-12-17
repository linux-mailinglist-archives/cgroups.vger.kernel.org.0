Return-Path: <cgroups+bounces-12438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4BCC8F55
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79B332067D2
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698429BDBF;
	Wed, 17 Dec 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCSwaN0a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AB1E9915;
	Wed, 17 Dec 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990628; cv=none; b=HjYcS1bzkalJ8ouZbl0Y2ho9ajCpO7slht7iG3kZj40sjzfECGjJdWFxX7ftNOK4F1yJ8FAlLw90Q8HhvLzr0zcgSf6lmvXwy0wbU9xGG1DtZZsf8PYBvzAKkNqFRhodApkhD5HqLTiqXtl61Ye+ji6aTyqcID+bXI7SpVamUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990628; c=relaxed/simple;
	bh=jJ7c1meemc+xtwYLs2ETpYQe8YYxev4XmAEAlKvd0hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhZag2veBiP0uV7b1Cl6dtLucBnRsvIBDNoa+VaXMeupDn2yBKAre6F1Z/xADGvu35SjIaUnSP/p76B1dQGwRZWFWRJY0d1OtF/YeRm7E1qXRRyGTtoU8eM8JJY50DOszJyNFeXopKJSuN/9sA/UKBCgmffbHME+P292UVwJ5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCSwaN0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647AEC116B1;
	Wed, 17 Dec 2025 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765990626;
	bh=jJ7c1meemc+xtwYLs2ETpYQe8YYxev4XmAEAlKvd0hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCSwaN0aB29JM2bw4bBeo2mdotAbnvPFvEVbSBPXBDM3xfrDmPXzWBeWk3skxMCqn
	 znyhXxBtTkvkm28ORZTUOjhbiWXxojKjwGhXWi2jayQ2RX2sUzDFaemeB2v1DvJwO6
	 c9j+mHhr8f/j9cuwjOPx53ixiL6PZF9RaAqWgTNr75t7UNp/5VBebk82K8sVN3mWn2
	 g5RO6pNrXluKvK6u99C7XGXtScA8V+oqceemTfOxWvrxxyu3RUGy4qRwNfGJas58Ec
	 DI8cHbmQD3zii9Z3ZghVZcTEq0gmlhvr9SPE7c8qDqCPSOxu/zBHWtIDFkns680MLK
	 ST2dsGtnT+2QA==
Date: Wed, 17 Dec 2025 06:57:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Message-ID: <aULg4f_nxLTbXvMh@slm.duckdns.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-5-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217162744.352391-5-mkoutny@suse.com>

On Wed, Dec 17, 2025 at 05:27:36PM +0100, Michal Koutný wrote:
> This comment is simpler than reworking level users for possible
> ioc_gq::ancestors __counted_by annotation.

I don't understand the change here. Can you please elaborate a bit more?

Thanks.

-- 
tejun

