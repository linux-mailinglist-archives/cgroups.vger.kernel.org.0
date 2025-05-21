Return-Path: <cgroups+bounces-8292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3433ABFC48
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162961BC29E8
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2828937B;
	Wed, 21 May 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e60mdWsx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A618DF8D;
	Wed, 21 May 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848697; cv=none; b=p22MoRrjZJXCEXceF4O5sbEsZT8N5vLrapikzfjBdMD9Rk8tMElarCK5haW4F4Tw/GxjXqn3Fx2FR+fLYMcdAB5efCWzno6FogLt30e+0oMz18pUu4mz3kt+6pKfFrpItER2oRJXCHfsbrRDeD6Eg8OvMXQFdcYU+ZajrnxEc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848697; c=relaxed/simple;
	bh=klDb4xzzppN0ISLP1qGT6akbTZrEeBnZCIlZ4sISv4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks07S/LxVkX6lAfRcS2cPnS5odKIRV5wWYxa4Y2WSMb7TF4vmVktX5Za2h8zNhm2FSsNPKtjcOrIAQ7pE4u4ep8TxEl3nZ0WZSIyKnwblJ3EFQkwVAEFnNjc/RD3JiaGuHAUXm1Pm3ZL8zAYIgWkiQK7ZHC34KGBavKJH3d6aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e60mdWsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D50C4CEE4;
	Wed, 21 May 2025 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747848696;
	bh=klDb4xzzppN0ISLP1qGT6akbTZrEeBnZCIlZ4sISv4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e60mdWsxutEbi7taRxN+FERft6Kpe7Oi4N3LQzlg/yjuxmYmqNTkBFRery2qgStse
	 0ykwGJGCdrfxYc/HDUlsmLkINSsukdRAcmRFrRSKUSNMEHzPxU2pLEcul0C252Vpyj
	 68ya0p0c9256GHXaDrtLboxD5uXELqbX8JHjhoOBAaV34pvCwzI7FZpwgw37uvtOJL
	 0nTHT+Se5QpxHwdTSg/y4trQR+MMAXbrl5O6m6NUlg9iKe31kJ1qoVZzK0H5vSqnQC
	 1/qljKE4ei4IqcyulgXWtbrLROayq/3NjnVo0i1aJBI8cflAyZyFq6ZH4Xt8G9lt8A
	 SYhXt40dJUbxA==
Date: Wed, 21 May 2025 07:31:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2 3/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Message-ID: <aC4N9z0MuTLC2lf0@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-3-70a2b6a1b703@sony.com>
 <aCzjJp1ovS6kCqHj@slm.duckdns.org>
 <aC2Fl4DVRbn6bS8H@JPC00244420>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC2Fl4DVRbn6bS8H@JPC00244420>

On Wed, May 21, 2025 at 04:49:43PM +0900, Shashank Balaji wrote:
> > > +Note that the ``cgroup_*`` family of callbacks require ``CONFIG_EXT_GROUP_SCHED``

CONFIG_EXT_GROUP_SCHED is auto-enabled if CONFIG_SCHED_CLASS_EXT and
CONFIG_CGROUP_SCHED are enabled, so no need to mention it explicitly.

> > > +to be enabled. For each of the following interface files, the above categories
> > > +will be referred to. All time durations are in microseconds.
> > 
> > Can we document the above in sched_ext documentation and point to it from
> > here? Documenting sched_ext details here seems a bit out of place and prone
> > to becoming stale over time.
> 
> Got it. Apart from that, is the content alright? 

Other than the above, yeah, looks correct to me.

Thanks.

-- 
tejun

