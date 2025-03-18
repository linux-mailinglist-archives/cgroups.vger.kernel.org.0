Return-Path: <cgroups+bounces-7136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A1A67888
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381D07A97E0
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803020FA91;
	Tue, 18 Mar 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/DKkdPc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50D1586C8;
	Tue, 18 Mar 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313498; cv=none; b=qJolWvD/u3LH2embPDJChZkkyJYfIsGbdwKbSKxxZRyS9MD+DmktCgER9u04WasqeuKphsSoF8Fgw+Xb/U/F+A7x9H8Jbut4a3fWaOdbIQl5sm7HLZPaml6O53a4CP8xyIa2CCLhFZLR7UNS53KKWBmhx2H224aKse7BYaiKGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313498; c=relaxed/simple;
	bh=N0n6ms3ZI7zDaW6aE8PBo8XfeGw9n2N1VrQkoiW+A0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuXtSgW5ty0zanoL6B8KHjuan3Sqnv2mZfbYq2VQ1p71IRQam8Cclvkcoi0Su0tbVkbnleKqo7YChbMRPOt+xNj8rNkP9WKeyHJRcsxEY8FJwcL2Lez/UEfJC/HjwZoKCSFIOzqQhQsajNMVcTepKLdLYfzj7IC2IFdcBrOPXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/DKkdPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E4C4CEDD;
	Tue, 18 Mar 2025 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742313496;
	bh=N0n6ms3ZI7zDaW6aE8PBo8XfeGw9n2N1VrQkoiW+A0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/DKkdPcuG++9S0mZCpsvi8X7G86SWSi0jje3deY9ZpmJx+T51yBNZF7oH9o92+TE
	 /8mNV6CtZ7SOhzbDyegMB+bQ/iCNUjwRLWDSKWHpYmdbrx6eJTEKYvbl8Il/20LQFd
	 phc5Mbt819lCKk/Nnf8eGWaeDtkglK3Ky4FzuP5Eecmg8Vj6fA7gh720e1+RPsOo+Q
	 rK55GX7YvI1IR1w+VMjUfU2B0ilUSHzPNLxfV56rVZ1zQYMv7m1WAg6/hp52pb0huB
	 LVO+L01cstzbc04Q+dvC5RG4YTnRYIgukSHAwf6y572nPTvySpNfwfptKwHqtSI6Jv
	 lQlC1IlTzZiyA==
Date: Tue, 18 Mar 2025 05:58:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
Message-ID: <Z9mYFw0-Q6e5Mjph@slm.duckdns.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-3-jiahao.kernel@gmail.com>

On Tue, Mar 18, 2025 at 03:58:33PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
> counter") introduced the pswpin and pswpout items in the memory.stat
> of cgroup v2. Therefore, update them accordingly in the cgroup-v2
> documentation.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Acked-by: Tejun Heo <tj@kernel.org>

Probably best to route it through -mm. If this should go through cgroup,
please let me know.

Thanks.

-- 
tejun

