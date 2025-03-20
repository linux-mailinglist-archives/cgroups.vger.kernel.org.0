Return-Path: <cgroups+bounces-7202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F6A6AB81
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0415483F20
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4082222AC;
	Thu, 20 Mar 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiENWtni"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81F1E9B02;
	Thu, 20 Mar 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489619; cv=none; b=tpy+gXPNpjjo2DduVz97gOeHYRJz5YbJSXOxC0Rz9Z4Er8RXQoah7saLxxwCs5+qBaSiDLHSsTEzz6Xt4tHKPtnOBmuPAz2juorXuxGs6FUrBs75acJYqBGN6dFrJa6GsMZyetIkHHwhZ4KCpfD4SdL4Tufl7vNVQYEqDjnu6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489619; c=relaxed/simple;
	bh=KjmCKp/NJf3R2sO9/vCh37J/TX7XxEOqD+tQzob08mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja/mLlLGbTgmNg8FI/SLfVUzvXLvbiNRh1LRp7eJspfDGZOUGwC0ObLhoYtZLBffrw0gT6s2siSJ9JKtBEYOd25U3qhDXAOsrmi9WLDkWq8tCMejZwsS+ol2FfMDC1lZAq9RDJ70gWwAkBRIxKATj8Pg0w64UxjJeHOOvQDWXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiENWtni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F0C4CEDD;
	Thu, 20 Mar 2025 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489619;
	bh=KjmCKp/NJf3R2sO9/vCh37J/TX7XxEOqD+tQzob08mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiENWtniDLagGjucMoGsLCdBIczU0VtB2Ls6tUsGSB/uStLw1aievd/4/uZAW4OAn
	 gQ3x741HkyLwTE7qzq8NPUpLiJOPFU9JQrsw1t+uyL2d3bw08jJMBpwi8l5ydvDDbL
	 pptMDHy6Mj7DCkVR5J2uzV4nLr7WJe7nMsBEPMbM+vcOdIdpkZbcqA6bCF1mwyAadO
	 p201rVWLoc4r8gphb2+g5xqxv4dyMuRkAjkw9V+gnV7rTvRAq/ik5LjZQItQpzwIg/
	 dKh8V/csYA/FEdu9are4nMBLXrUe5s1bLBHa4P/vIv+NvwUMYFQk2m7YzvdXPb0Jt3
	 rWOOvp8o1jD3w==
Date: Thu, 20 Mar 2025 06:53:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Greg Thelen <gthelen@google.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.15] cgroup: rstat: Cleanup flushing
 functions and locking
Message-ID: <Z9xIEgxoGfZIfSkz@slm.duckdns.org>
References: <20250319210013.3572360-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319210013.3572360-1-yosry.ahmed@linux.dev>

On Wed, Mar 19, 2025 at 09:00:13PM +0000, Yosry Ahmed wrote:
> Now that the rstat lock is being re-acquired on every CPU iteration in
> cgroup_rstat_flush_locked(), having the initially acquire the lock is
> unnecessary and unclear.
> 
> Inline cgroup_rstat_flush_locked() into cgroup_rstat_flush() and move
> the lock/unlock calls to the beginning and ending of the loop body to
> make the critical section obvious.
> 
> cgroup_rstat_flush_hold/release() do not make much sense with the lock
> being dropped and reacquired internally. Since it has no external
> callers, remove it and explicitly acquire the lock in
> cgroup_base_stat_cputime_show() instead.
> 
> This leaves the code with a single flushing function,
> cgroup_rstat_flush().
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

