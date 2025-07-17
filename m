Return-Path: <cgroups+bounces-8757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B0B093B0
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C19E7AC453
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA72FE399;
	Thu, 17 Jul 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ1qMCct"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0F2FE324;
	Thu, 17 Jul 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775146; cv=none; b=mFQZ1mvpSjKe4Cx5bz7+9eRwfrsAMpUmtDBEioDwPBN+s1gVAN3Tqzuxx+lgSYzOR2qU2Xa9YrpeM0NQNWoL22UfVnNQZtxz3mlbv2Kt5XZIgyipey+OT9SKmqWL9FCtPPo6mSnd9aCZdDjPKbFQmScBAVLFwCmfEZlZI/Q/pD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775146; c=relaxed/simple;
	bh=ar6G2fTgDub/2OfLp0XAsoF8x/8+ZLCrP33KcJlCJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHJDF5YBRCEG73nu3rxcNkOZHhhZZopcWdGtUHRv5N+i0dv27orIo8U1vmmbqS/n0iZl9rgOkA6WBzba7Xhl0u2gTlcoud3V5+j+tDojQ0EwGcxRcRb0414QL6A5VSngrcg07j59pImKJ2OyGFDEzhksDxtmBsnBxc3Rd5+PoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ1qMCct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9208C4CEE3;
	Thu, 17 Jul 2025 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752775145;
	bh=ar6G2fTgDub/2OfLp0XAsoF8x/8+ZLCrP33KcJlCJBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQ1qMCctLa1peTl2fXlQAxtXE+20jpPJuunFCVcHMkgpTSsxmbxLH3nNLWHbpBC+w
	 h6JHWb51ggGw/D2kXKzi/wpz6mZe9+JoFWSjojdXYWVMJJum1mofW99QCwZwrt0kve
	 MNVFhwS4lO+hrS8YZOVu1R/iB4qQdfmr9s+r8crlxni20nJURpMGBzv9jMBwt3vs3G
	 zRpOOCFXTNplFTo5e8DSWqRAPAk97FADYo/ha0e0UDdFxyqH1aJEnog12Uw0xLnjMG
	 8FQ6Wp0wttPqnEhuCLzsovo3yAQHp31GHeBbl1NC/Ig5qGJ1PI/yWdm2xbfFslcYrm
	 ltsJzHQJpbJxQ==
Date: Thu, 17 Jul 2025 07:59:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, rafael@kernel.org,
	pavel@kernel.org, timvp@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH v2 -next 0/2] sched,freezer: prevent tasks from escaping
 being frozen
Message-ID: <aHk56Fjey4SpxYhT@slm.duckdns.org>
References: <20250717085550.3828781-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717085550.3828781-1-chenridong@huaweicloud.com>

On Thu, Jul 17, 2025 at 08:55:48AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This series fixes an issue where a task may escape freezing.

Applied 1-2 to cgroup/for-6.16-fixes.

Thanks.

-- 
tejun

