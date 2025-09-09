Return-Path: <cgroups+bounces-9837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600FB503DC
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 19:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76C87A152A
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6842362091;
	Tue,  9 Sep 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMEX2HCJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDD25A324;
	Tue,  9 Sep 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437248; cv=none; b=Mb/PJoZt26Ohz7ZABCLBadc+MHGiNFgMJQs3PCcHkXf4GcfNa9Z8XJk6rQuk+BI7W+l+g95u4awAi/SHwfK33xW6aHLwrynOFCJBx2UAiFMlvf99qShtSvRlbVA3QVa+Vb+L1d1dG4X4QW89M5vhQcWoZC7Z/pWRsUMFEyps/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437248; c=relaxed/simple;
	bh=gwsDCpDbeOsYNSORjaB3vOk7Rjw/O46gUMvxCkrdSoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRKMAj8CJWAO2GutJ+xI3aiH7Ne3Jy8Xb332R32l+OFT2JvdBN5LwN1wh+kWw581cp6zXrpMMo7UoMsJBtch0DqA/s3Yr5Xd+i3S33ViDzC2jdB4hiT/Igkv7Utd+byXWxhp33f0wpiWn7vj+Ebvrot0fuufcBqmyOcmWFcUm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMEX2HCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BF8C4CEF4;
	Tue,  9 Sep 2025 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437247;
	bh=gwsDCpDbeOsYNSORjaB3vOk7Rjw/O46gUMvxCkrdSoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMEX2HCJSCcBNqAxYFZN6Gz0bYJIiJAJ1wQnYNo5LENNb18KIHCcYX2EW3IGJlCTI
	 D+G9bt0JNL1aGUlSQwnip9KnaOgBBwJPpzCt28AOmyhw4xdx2oOd7+zCrf6nlMCR6v
	 rwwgOOO0fywUY//TKK6bIH+1Xm6629bweCZxb6TXd+KOhf0F8zgIC2c7+yyIrVd5x7
	 aTEbaesXKPrzjRJ2vrGfyelR0ZX/V+54vJgdlcILTfVysHC5iNrxlYqH1n9sdbNG5S
	 2MFEVVcN0CO67A9fO/+/Wrx/tYeprlULVAyogpLajo9k48KFkM3KrbtbzmQ0pLH5Em
	 iSpTEqD4rYSvA==
Date: Tue, 9 Sep 2025 07:00:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] cgroup: refactor the cgroup_attach_lock code to
 make it clearer
Message-ID: <aMBdPoKF4unCqvds@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757403652.git.escape@linux.alibaba.com>
 <d4d27f16909eadf6a499971b63ed8bdacd85f71e.1757403652.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d27f16909eadf6a499971b63ed8bdacd85f71e.1757403652.git.escape@linux.alibaba.com>

On Tue, Sep 09, 2025 at 03:55:30PM +0800, Yi Tao wrote:
> +enum {

Please give it a type name. It makes difference when it gets exported
through BTF for debugging and tracing.

> +	/* Default */
> +	CGRP_ATTACH_LOCK_GLOBAL,
> +
> +	/* When pid=0 && threadgroup=false, see comments in cgroup_procs_write_start */
> +	CGRP_ATTACH_LOCK_NONE,
> +
> +	/* When favordynmods is on, see comments above CGRP_ROOT_FAVOR_DYNMODS */
> +	CGRP_ATTACH_LOCK_PER_THREADGROUP,
> +};

And, I'd put this before the actual patch too. Please make it a prep patch.

Thanks.

-- 
tejun

