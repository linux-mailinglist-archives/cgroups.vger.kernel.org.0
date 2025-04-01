Return-Path: <cgroups+bounces-7284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E17A7818B
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1218845FC
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637120DD47;
	Tue,  1 Apr 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFW+cVhG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CF9461;
	Tue,  1 Apr 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528829; cv=none; b=k+O/1EAOHK6QQlyCs8urMoN9zBQSa/fid1nwTvRmO/vRPnp9UzWRD+Ol+H2Qw0Z13rubS2whDmDWgigzk10qupsk9CWERwTwKJLWyxdPn+E5/YDiAqnujv4lOnXtdnUGCbNY4IbFCr+G1Db7yMDWU/usopI2kWm6+AuliuGloO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528829; c=relaxed/simple;
	bh=Ybi/75q3rVOd12LnlD05Pf2gzBLxdBOD04aayJo+Mlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axkrP++HJ/Jq7K43LtZ6ho3bBx1MJEmVdw3yYHpyEEvZxYSc8jwDh764PPkMPgpB+lCmhI2FekLDO9IeR/wlBoCVNWXRX7sj2lCANCukC9NqUGyHHk0szVSHUOqVuKm0PXXbxcU4LkFFnuqFAUih5wgjH0xbcw89Gnc5TEGAKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFW+cVhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE1C4CEE4;
	Tue,  1 Apr 2025 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743528827;
	bh=Ybi/75q3rVOd12LnlD05Pf2gzBLxdBOD04aayJo+Mlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFW+cVhG/eeINvfuUc+YNO3aTlgH9IV9DlNoDlaVoo83t9qBC0+umU+9K4pfR0ydv
	 dZSm3livdNmt5qqaQ/G9aA/z9A/0a0JfXasGVWJ8F85zSODLyMEBZJty8yX1X3V29/
	 Z/wkleyjQz43Io2XStUaHIc888oE7tqzR37o6djtLm3TeSl+Z9bSYjPikKRR6dpbCm
	 DDVekJDs7FDJb/uEZp8Lhm7GhLqoy0B0H9g2tCW4xGjeHIM/ak40/9Rd++SicMDlvG
	 R0kA0v2X5QDaoAd/ZHh8oe7Jnf6PrtpMqrIgkPAx9jU/jeh7aw+8p3YBh+K7LtkWgG
	 3QqCO4Uq2do8g==
Date: Tue, 1 Apr 2025 07:33:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] cgroup: rstat: call cgroup_rstat_updated_list with
 cgroup_rstat_lock
Message-ID: <Z-wjegcnvWTEfnnG@slm.duckdns.org>
References: <20250401170912.2161953-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401170912.2161953-1-shakeel.butt@linux.dev>

On Tue, Apr 01, 2025 at 10:09:12AM -0700, Shakeel Butt wrote:
> The commit 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and
> locking") during cleanup accidentally changed the code to call
> cgroup_rstat_updated_list() without cgroup_rstat_lock which is required.
> Fix it.
> 
> Fixes: 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and locking")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6564c3d6-9372-4352-9847-1eb3aea07ca4@linux.ibm.com/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Applied to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

