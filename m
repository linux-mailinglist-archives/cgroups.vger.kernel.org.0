Return-Path: <cgroups+bounces-8400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403ACAC98A4
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1A3B50D9
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89706320B;
	Sat, 31 May 2025 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcfwvsi7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44325846F
	for <cgroups@vger.kernel.org>; Sat, 31 May 2025 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748651852; cv=none; b=G+z1O5TWCH59Rr5EeL1huYh/ACn/jZXQoLWJhWAhCiAnDRdLVordLHefEkUNETE00/yLqmi8QLTS2ib9VWKfvNf7qnUtLL0+/yl5URl75xGtmj6oTOAMdYZPb15kfeMfslWG6V2JhREkBTBIyJ6bj/CDQiXcJ2UZQQtsMpGJDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748651852; c=relaxed/simple;
	bh=q1h4Y3BbifnxE3SpnCM+nf/Lth0Z0xKzR5qYr8s81QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ9CLQlfQ9mwea5hjD7q+3QGu2hhmszGXP9iMVmCMcuuNvRHOI8g02X8j4SlIuCkZ8FaGDXCoLQ1NoXGGius/iqzU7BIJ3K0KtsKgeG3PCQtrnz6iYhY0wmPSBtPjRK77fg1xZ+Wn0kTWpQmXvVPM7zif8fIepQGedA+VpYzdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcfwvsi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7EC4CEE9;
	Sat, 31 May 2025 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748651851;
	bh=q1h4Y3BbifnxE3SpnCM+nf/Lth0Z0xKzR5qYr8s81QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcfwvsi7wDUl3w0iBJTMCQShQp5dOx2HZmVqGaqDzQu9R05QcAuGC8thEwXlr0cDV
	 gWP0NYG77uA+RJWCNK5Oa+dp7HDv6SGE/cBX3h5OIzqBd1I78CVYadc3BpicdNtJo0
	 HQwFRkeJd1wQE4ayME74j/TSL4SqVRnNJ+EBK8Ok+rHM7yHQ0ttGnE2zOdFFGb6tPM
	 rthViDKsKvjB2Q1eGlihPXzReW4E5a/qFmC3In1XdaVl1kkMa3WSiIbkJnOPH5hi4T
	 ERTDIPfwaoa2X14e2q7gfjK6ys17uG7+8NPat8B6ri8rqs45SnaNgna+QW3Y9jfK4g
	 CaNlA6lef/haA==
Date: Fri, 30 May 2025 14:37:30 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: llong@redhat.com, klarasmodin@gmail.com, shakeel.butt@linux.dev,
	yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
Message-ID: <aDpPSvqIxmOmMjn8@slm.duckdns.org>
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

Applied to cgroup/for-6.16-fixes.

Thanks.

-- 
tejun

