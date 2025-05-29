Return-Path: <cgroups+bounces-8380-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C511AC74BE
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330191C00C08
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1333F9;
	Thu, 29 May 2025 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xND7r1dX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173B1373
	for <cgroups@vger.kernel.org>; Thu, 29 May 2025 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476862; cv=none; b=RCb5kjr7lx0Fn2wEGDT5hg2PFETy3lIt+x/vvnH3GxqEdo/IoqFgH75+mPcRNjgu4EuyS24uRviX5bWwrUvw0bec1ewEXw7pCBW90t1ND89+dTcR5V4vE0A2UmZWX3TLzPCJQ4igHZlyDnJD3wuzKDyFNbt++pPnDKPzW5ilTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476862; c=relaxed/simple;
	bh=/Rk4EySiKDCR9vVk81As1s5Y4d57cctUNGfxIoYYeoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJHZVB7tRF7C00WAABXVwXMNwcMvPk5Mfy9uNWMtZG1wVdccGDkGWI8V3irSjtAs4IZq/8rVipbNcElHXAWj7P3YbAGe1j3CL2B/ZSJlZLj1ViGS66L1jDS20dwV3o7d4FQXTRUQ5p4nH3PPK28rPg59iWrOsdVMt1Z6fBQz89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xND7r1dX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 May 2025 17:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748476848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M19Wun+T/jJ/+LmaT5WIBW7yN90yHCTyuDE8y5A1O8=;
	b=xND7r1dXbot5NimFUYIk3+bQgLX5LYv9PAjXBBsgjE+QcVQIUgmCEGelFDhXPDdR6hmVqN
	CcWuDY8oiMBuE+UUXbl1KPfainFrPL6hWdsl2y+66J0nu/BhRKCwP1WCJdSPQgJ4h7rrHK
	do4S2KoW2MCuNR8b6ihDsEOnRQwo21s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, llong@redhat.com, klarasmodin@gmail.com, 
	yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
Message-ID: <76hefz2y5u62a6efpvi3336pwhoqhrjq5vqfzktw25xu6l7whj@vhv7klyreubm>
References: <20250528235130.200966-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528235130.200966-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 28, 2025 at 04:51:30PM -0700, JP Kobryn wrote:
> Previously it was found that on uniprocessor machines the size of
> raw_spinlock_t could be zero so a pre-processor conditional was used to
> avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did not take
> into account cases where lock debugging features were enabled. Cover these
> cases along with the original non-smp case by explicitly using the size of
> size of the lock type as criteria for allocation/access where applicable.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to avoid contention"
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202505281034.7ae1668d-lkp@intel.com

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

