Return-Path: <cgroups+bounces-6201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BFA140D7
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 18:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B1188E211
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3122C9F7;
	Thu, 16 Jan 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJSVWOAG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF21DDA14;
	Thu, 16 Jan 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048305; cv=none; b=SrB9FEVsITdMOSmkn1AK8G2cC46WuQ/Nr49fbhkr41SwGddGcTfYGDqhIeSgy5eS5BG8/7XvvGDe4lu/vb0tJeMBTmn3/e5PSg6pe6w0fMbVmv5QoBADmDAFPT/MMZ27eMgZnKxb/uId4JVevAwGdai3FGtZcHmakyVOWP5JFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048305; c=relaxed/simple;
	bh=QZQ0zPfzmVEDFjGBmgJIALXrZqHWXRgbFbLdHc4fatw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoGfyPj1y8VPDlHg4DUl2pRMvAsyhDOvpwKO0iY+dxdm+NvF0Nsv+LbCnVNuJR9w/zDyOxyLP9birAXrA3YNs4OeKjzoKDad47mmPq29pmuOlvL+rIu4gPYS/kFz3McpMLgIMQxrKcC5ekQbJ0/zyAVUm6ZgEJrE5x0IhNHlwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJSVWOAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75737C4CED6;
	Thu, 16 Jan 2025 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737048304;
	bh=QZQ0zPfzmVEDFjGBmgJIALXrZqHWXRgbFbLdHc4fatw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJSVWOAGvUa6FEDKC0xZDmdyV9ypY7OQbbrHUjtyP3eds5E7G4qbfZRvIIZ0K751t
	 ZrvuqxC5Mmd1EJkM+TThKOO80j/cE2N8zegZ1hsXBuJPG+znRQJoPI8MAmNA9wk7SL
	 U0yjJl+F8cvcoylA+0ljBzoq2s2xhmMnPmc+r7wcQJaSMRgVmw8NcMCFiW/lmQYrmv
	 p2bK81P7YIzFE45vBbRKy1SEILlsdx0HvKirU4ib1bU3zjPpe/JVNMCj6jtvelPyPd
	 Ob8E+2RCh20iB3emJngGpm1AcHuhiKrVW8L91mrzVziwGACclC5VBKE7OhVSgIFUV/
	 b7BeRkW76FWww==
Date: Thu, 16 Jan 2025 07:25:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <Z4lA702nBSWNFQYm@slm.duckdns.org>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>

Hello,

On Thu, Jan 16, 2025 at 03:05:32PM +0100, Michal Koutný wrote:
> On Thu, Jan 16, 2025 at 08:40:56AM -0500, Waiman Long <llong@redhat.com> wrote:
> > I do have some reservation in taking out /proc/<pid>/cpuset by default as
> > CPUSETS_V1 is off by default. This may break some existing user scripts.
> 
> Cannot be /proc/$pid/cpuset declared a v1 feature?
> Similar to cpuset fs (that is under CPUSETS_V1). If there's a breakage,
> the user is not non-v1 ready and CPUSETS_V1 must be enabled.

I think we can try given that the config is providing an exit path. After
all, users who were depending on cpusets on v1 are in the same boat.

Thanks.

-- 
tejun

