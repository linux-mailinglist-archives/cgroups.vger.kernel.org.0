Return-Path: <cgroups+bounces-6850-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251BA50A2D
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 19:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6228C3AC526
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407525332A;
	Wed,  5 Mar 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+J8zZnx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AA25291E;
	Wed,  5 Mar 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200286; cv=none; b=ph89Z9OifoDWziGpPp0X5s33I9WkPYTXaGViGVNdVleIi56EcvqYvu12E+y2u35u+XXN69g97FTqFzvuUIoGhd+bf5rZX/gQZcuDb2/S/GcRhQYE5KGe0Y7ZsWaYvZ0VXKZcP+GwtZ0um2ulWkIZH4VSkp5KRuDHEE8hn9WstY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200286; c=relaxed/simple;
	bh=ciTMolwFUhrPwvLE/snGpeinCiypi3lTipfn/yDrxHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX0D3he/2AhDO433701hxS+4I1S6kW9Wb2JgoOIKvYrAUKsC5sRk61VXqJfFWdhZWiYZzaLDIkD0OlgLa8fYKeK++H5SPvkaxLQfrcB4mmhxubc6qDwTKO+VI1zxnAPvr/8L9JZMuNSE/6ySIvyRP4HUWJBig6Xn0RsgJXaX30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+J8zZnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6672C4CEE8;
	Wed,  5 Mar 2025 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200286;
	bh=ciTMolwFUhrPwvLE/snGpeinCiypi3lTipfn/yDrxHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+J8zZnxgp48p1L/1XZhN4Z9lK4DiRF+DvC4CabDGBjZcAmIL3L7oyql6Rw9Uy+8w
	 ENXq1nNTwfKzCLWpa0/SGeBZFB30KV29tVcO3l6cs9F3EDj9FUPnU+R3uSiA81mvXb
	 uodq0LCE3LJBx5ND8adz6hIHA0x+RcOZ5HpiAItGnO2UP/C5adpqQ3VRCwCRN5uyG1
	 FhSCgaiKPGeum2UywMCG6op/Il1XZpk4IOtdx4YbkkTLIhmjiXCCTq6cA9yYwDU7x9
	 ZgI56BAJToC2u+dIrCA7f5pkBB+atlHF5EO5aGK7+l+ux/g3kBB6+uzY37joYJzXQR
	 uYiFufop9LBrw==
Date: Wed, 5 Mar 2025 08:44:45 -1000
From: Tejun Heo <tj@kernel.org>
To: shashank.mahadasyam@sony.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
Message-ID: <Z8ibndhPN10cL9Gs@slm.duckdns.org>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>

On Wed, Mar 05, 2025 at 01:12:43PM +0900, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
> 
> The cgroup v2 cpu controller has a limitation that if
> CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
> if all the realtime processes are in the root cgroup. The other
> controllers have no such restriction. They can be used for the resource
> control of realtime processes irrespective of whether
> CONFIG_RT_GROUP_SCHED is enabled or not.
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

