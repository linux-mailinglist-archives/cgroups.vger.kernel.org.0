Return-Path: <cgroups+bounces-9956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C1B51EDB
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9858D1B2736C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBA31A067;
	Wed, 10 Sep 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roqLPyx+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81C255F5E;
	Wed, 10 Sep 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525213; cv=none; b=Gzzxb+DDVs0XCQnt6bykQd+1gzyOdQZpPP3J4feH52bhh4wsKxDrOt6kLWUMuT3faLUxaRngr/vVhvteQ9RnTEb+xVTwDRmWxj0be6W0f8MZcq2Lfkm+9noErUolFYtw7VJhA95H1P2ZD4ugm7bh/2gMuba9yjW958IVVU4Gj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525213; c=relaxed/simple;
	bh=sP/Wq009U4PO/U1ngEdD9RGgsY6WC8CMLGnVJ9QAU0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIc/o+1e263HMj6ra+ejaQofuBuosJnjCx0652/wQrcXNJcJCRG2LFURxgKjQ1hnnREf1yDuQEaiUOsVuTLs8Yb/Xn7VI9e+XuZxqNuRlAd1GsWl5GZZu4t74DX6m/SQR4invo3PSfiik33k5Zj0AzypkrfFMVsFysANmLAitmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roqLPyx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE14C4CEEB;
	Wed, 10 Sep 2025 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525213;
	bh=sP/Wq009U4PO/U1ngEdD9RGgsY6WC8CMLGnVJ9QAU0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roqLPyx++GjgeyGv48e8dAHsqvxZl0SfLAslDInzR8A9piZ+tQRriEWsXrpj/5s9e
	 v4yKyfk7cpiZgdhF8FmWWflL20zaHCVhqiiOFpCcJhALF/poIR3dAxZfq8uxCtV0t5
	 0kOGpPFVm7qqv23q6HooVE76AWRCfN5+eedQxAxe+qGu23mEG0+X0b6mkmJj5meJBU
	 ZXbFgM/AWcf9WONbTxfos5VATPmvWjj9uS4QFSmZMHqpVKs05Y5Pz4jh8CfY5MWEOy
	 Jyoz3CPbvrzWzM+vPzxvIhsS6f9uCSUMCqsJrVVAJjdht0nf1i3E8PEw30qlGJCNFq
	 0wXC+DonIn6Vg==
Date: Wed, 10 Sep 2025 07:26:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cgroup: refactor the cgroup_attach_lock code to
 make it clearer
Message-ID: <aMG02wO6fvsHY4bL@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <e1c56f0ac5826010dbbddf781641306a0cf666cd.1757486368.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c56f0ac5826010dbbddf781641306a0cf666cd.1757486368.git.escape@linux.alibaba.com>

On Wed, Sep 10, 2025 at 02:59:33PM +0800, Yi Tao wrote:
> Dynamic cgroup migration involving threadgroup locks can be in one of
> two states: no lock held, or holding the global lock. Explicitly
> declaring the different lock modes to make the code easier to
> understand and facilitates future extensions of the lock modes.
> 
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>

Applied to cgroup/for-6.18. There was a conflict that I resolved. Please
check the tree to make sure that it looks alright.

Thanks.

-- 
tejun

