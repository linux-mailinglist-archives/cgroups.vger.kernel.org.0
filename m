Return-Path: <cgroups+bounces-9958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49CBB51EFE
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D1F189E069
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7733438E;
	Wed, 10 Sep 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBdSwa+e"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51F28C2D2;
	Wed, 10 Sep 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525496; cv=none; b=M2MxlVtQFAfy8t1UV62cgAsR8XpAdIKN/Iv8kLNHnM+7qjRR9dAZfBfms/zQrC5G+EMkZzduhHI6jm0DfRYHlWO4wu02OntnlkSPwXYrBOklVAI7OiaRYHNDm1hhiTBa3AGDEN6EkVQdRHw9oDjdiXOtfRgeNWKSxz7cQPQmnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525496; c=relaxed/simple;
	bh=bDvZCO/6e5P7DQo+13wSuZhi6IoMrtDUiq3exFB6llg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNA10+E6nDxmKOqARbEa5na2U6Uq1Okquio2pMkrqSuom39wXdWTxmoZfvZFnbYlqI7jXj3kGmgL13PtWdJaJGBtUnkllEUoqD7Jw8dwAN+/nifWob7pqCah30mU3S3HXrXqlGXa8+3t9JapkxVnhjiIpsbh/VzJMa1+F2tCRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBdSwa+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77EDC4CEEB;
	Wed, 10 Sep 2025 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525495;
	bh=bDvZCO/6e5P7DQo+13wSuZhi6IoMrtDUiq3exFB6llg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBdSwa+e8bzSt4O4mZ4VG8taMajBBnTTAQ0dqACzGNjWq4CoYh1QJL77OT2XZXJ4T
	 soMLiEuaGUDvwniqkBobHGliN5fWO6JYdWhSJZKwcR4urb+/DN0fwC2Zi/UI36ASO1
	 Rs45Pl4xQS9wzyAnxgqllMhbJ02xiNFxAvJXiHtf+EcY6t+w5fWvSGTch08PQ55UT3
	 sUe4utaZ7MtNq0XCBDZVvcQMl/zx+IUAe3fK2IPeUacP4dq/Au7mJyl+zvw0nU895L
	 3srBpggE+8cq4NAWWHfjaTDaKHkXu+0528AZSsXtb73h8ZSiILWHCsIG+tUHOhz1JF
	 wwwXdpaTkrmOA==
Date: Wed, 10 Sep 2025 07:31:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] cgroup: relocate cgroup_attach_lock within
 cgroup_procs_write_start
Message-ID: <aMG19vnh_nd_jm_h@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>

On Wed, Sep 10, 2025 at 02:59:34PM +0800, Yi Tao wrote:
> Later patches will introduce a new parameter `task` to
> cgroup_attach_lock, thus adjusting the position of cgroup_attach_lock
> within cgroup_procs_write_start.
> 
> Between obtaining the threadgroup leader via PID and acquiring the
> cgroup attach lock, the threadgroup leader may change, which could lead
> to incorrect cgroup migration. Therefore, after acquiring the cgroup
> attach lock, we check whether the threadgroup leader has changed, and if
> so, retry the operation.
> 
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>

Applied to cgroup/for-6.18 with minor comment adjustments.

Thanks.

-- 
tejun

