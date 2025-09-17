Return-Path: <cgroups+bounces-10217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C69B81BBF
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D1C7B675D
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530D2DE70C;
	Wed, 17 Sep 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMiSRl9c"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6552C327E;
	Wed, 17 Sep 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140123; cv=none; b=O2CIdxHEb1RD/yR3fgw4qb4MF3p6f5UD5P/mK4Ls3gic5WoOMRL4u5EBcS6H+VZu/M2YYQIQbvAWNUvD2djn5+7Rj+ALr5kKc8dMYqE697yaNCcrx4ru67M3nFDbDWISExOw94ofH1nFa7t7HPp6FKcp3hsRFLUzO1iZid0UpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140123; c=relaxed/simple;
	bh=oNFa9hwyHgBlCFAoJzpEdMKYbKIFK/L49C59hxmtHA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYeQaIYohTCU5OjEgjcDDwQBgFJENOnZSWehsGtwDPNMAo4KJUvrWjh3O1slxpbd99tv67xDYkSuNbscsFhdeWIhlaLBgmSWA4fst61D8K4nLjU7uPOhNq746uUkwttagOhAofoOAKMhykkJh+jdHgOyIi45r+/uqILqQPtS0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMiSRl9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F29C4CEE7;
	Wed, 17 Sep 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758140122;
	bh=oNFa9hwyHgBlCFAoJzpEdMKYbKIFK/L49C59hxmtHA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMiSRl9cupAEXlLYZ10Y8AkHbXas6DM/97kiiMAA39+cVLoT3at12NXW6WlksxgCA
	 UTxHalJt+Eh6RnrC2YTJp/ftsgRaOnJpA5kJ3r4U+S4pYJRmeo1Qyn5O/Drv4nkbxl
	 vYok7WbvAZAKyECtDa+I2D9T7RGiuIDOQD+vqN1UFNNlNvTNO1M3eRQTPQhHW0RfNs
	 sRraLWuPYupxtDEEa/6xG7hpKyalRZpNB7u1pFOsaa5j6o82ysMK3/1zmKaH2fe2jT
	 dw55dWxbhpnIG3NaKfBt4tSEJQgnhGDfOk2Kg1D7fj9qytu2YMwD2+UQVWmIPfrOOj
	 Mbg/viwphoL6Q==
Date: Wed, 17 Sep 2025 10:15:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next 00/11] Refactor cpus mask setting
Message-ID: <aMsW2WGWrZUm5Qee@slm.duckdns.org>
References: <20250917060454.2885698-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917060454.2885698-1-chenridong@huaweicloud.com>

On Wed, Sep 17, 2025 at 06:04:43AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This patch series refactors the CPU mask configuration logic for both
> cpuset.cpus and cpuset.cpus.exclusive settings. The primary goal is to
> improve code readability through comprehensive function restructuring.
> 
> The CPU mask update process follows these steps:
> 1. Parse user input
> 2. Skip processing if no actual change to CPU mask
> 3. Compute trial cpuset's effective exclusive CPUs
> 4. Validate changes and return error if invalid
> 5. Handle partition state changes resulting from CPU mask modifications
> 6. Apply new CPU mask to the cpuset
> 7. Propagate changes through the hierarchy
> 
> The series is organized as follows:
> patches 1-3: Code cleanup and preparation for refactoring
> patches 4-9: Refactoring of cpuset.cpus configuration logic
> patches 10-11: Refactoring of cpuset.cpus.exclusive configuration logic

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

