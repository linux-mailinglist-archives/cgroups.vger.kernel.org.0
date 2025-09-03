Return-Path: <cgroups+bounces-9685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F6B42B42
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 22:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16B11A83A1C
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892412E8B91;
	Wed,  3 Sep 2025 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0WvETDi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450432E7F19;
	Wed,  3 Sep 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932335; cv=none; b=X8g1MOtpJW632g4G8kQ9NJ+4iZVMCqhRBdFP+0VLgtWqRvYiLe+Cx40bxwJ8SXpmkLEctNcW7SWzLGfN2sWsrIPYCitAR1RNB4hh5lJOU0VugPNu9NLZqRwqgvyYs+Aumq2qCYfa3yhS+kE9Ca0A8IMBnVI4rHGcVgKdNFb1H20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932335; c=relaxed/simple;
	bh=7Ja+OAeVHlPOiD/WFtbGpc9an2hCc7WlSqES3tFpsHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKJULgSSQ26bj3/RodIrl8nz1ZNBm6u5Xt/x8tGN6mX9bM9s4n+5P6JX/zojSr0OHqPACTABFHtP1fnTDUBArBMkc+gSTrJEaqd5W0AK6PuNMH6U3nXE5Xvj4xYxFIMZa3nyRe10pB88HTS5cpVMa10MTFRRmZ1WCp8C5E3swr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0WvETDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC65C4CEE7;
	Wed,  3 Sep 2025 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932334;
	bh=7Ja+OAeVHlPOiD/WFtbGpc9an2hCc7WlSqES3tFpsHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0WvETDiu2MjCpwE2LlS8iP7CvMyRxtgtvMpDwFR+g7bLj7tirxYM4bZP9CAbJFVQ
	 //S04BdssxySOdwADpv7lQCh2/A7lsI3OLZLJUFLlYooAwtjFv0Lv7vUdLXMtWxW/d
	 iUxDMJmwH62cvavGp+2C4VLXLO4PCysdSAMWVxq+0Jen4MLcLXFxpAiI1FUOnfE1E/
	 gzXAzokRdJZlucefH7Zgibk3+BoV69kpGinEGW0GArm5kSQwwihKZmJ6oigNw2ASbE
	 2hdV8goUQ+cVvxNs5fmFLScRV27VZPC49Hv7WZi2GuPCm9vqQpp/ZS594FpU3b4n3Z
	 HmRxjXHiJ0JMg==
Date: Wed, 3 Sep 2025 10:45:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLio7Z6YolSZ2lPo@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>

Hello, Michal.

On Wed, Sep 03, 2025 at 10:03:39PM +0200, Michal Koutný wrote:
> On Wed, Sep 03, 2025 at 06:53:36AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
> > disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
> > from cgroup side.
> 
> CLONE_INTO_CGROUP uses cgroup_mutex and threadgroup rwsem like regular
> migration, no? Its effect is atomicity wrt clone.
> Or, Tejum, what do you mean that it disappears? (I think we cannot give
> up cgroup_mutex as it ensures synchronization of possible parent's
> migration.)

Sorry, I was confused. We no longer need to write lock threadgroup rwsem
when CLONE_INTO_CGROUP'ing into an empty cgroup. We do still need
cgroup_mutex.

  671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree")

Thanks.

-- 
tejun

