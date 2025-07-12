Return-Path: <cgroups+bounces-8714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5FB02C27
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2365D7A72DE
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338941BFE00;
	Sat, 12 Jul 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxKd3tC1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D692C181
	for <cgroups@vger.kernel.org>; Sat, 12 Jul 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341703; cv=none; b=J/M5zql2cBacR656I9rrD93u5F8lLYAn67+ePJW90/80cBQ3QBOEb7xT5NkP6U+wUwMwSSkopwa7MC1R+Rhdr167jFIDuISBkKq8Oz1GeUFkUx6Ob9pQXU8RofonlHBPUSV6bGT2Ik4ENdyrW/49SzSCJIYYQZ5S0BN9aWzdx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341703; c=relaxed/simple;
	bh=KSJ/eauAmgy/B8sgYGccty78wIaCRYF3/LD/vC8vdzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwSvg3WcRJe4WPwCOm1y2Zy6o7wjFEVH2DXt/kgwnHvQihd8v6XE3j71udjxRCbEbCopFSN8uxCAtDkr0Xj6rjR1Yb534y5vfc3FFCA1ucnh4UDw11y45z4K/XGEuzAUm8uDkAjJ8gNptZdLkNGTNvG5n0C5XJkrSiXev/jyJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxKd3tC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCAC4CEEF;
	Sat, 12 Jul 2025 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752341702;
	bh=KSJ/eauAmgy/B8sgYGccty78wIaCRYF3/LD/vC8vdzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxKd3tC12urn9IPDRpCaO5yF3paVtHbQpdE3C/4mpild72TJvtrv4/1+uxiUTcAu1
	 v7c5YNegqtZozcWAXs0jIlyMecA9C7LQBeruOws28qc7UO1VtNO8rdgk9ZwZRvps9/
	 s5CjiH9JuCLTeNCx6lOtz24p7mEcnXH4++JGcFDpO+8WkPH4byKU4lEBNKES/Je6oD
	 ZF00CQ/3BovDRmY3/m1fopFGfQSRHAtt/UhamhzEY0gphk92L9kMnXaLN3HFibRt2u
	 x8HbS4HQNG8zWc3DmgUCnleFyBv4muJAoJ3uY9BFt+fii98F2GGSotu+sfEdAYjbMO
	 qU9m0fAK7hTXQ==
Date: Sat, 12 Jul 2025 07:35:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH] selftests: cgroup: Allow longer timeout for
 kmem_dead_cgroups cleanup
Message-ID: <aHKcxalhyxk_A9BE@slm.duckdns.org>
References: <20250702132336.25767-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702132336.25767-1-sebastian.chlad@suse.com>

On Wed, Jul 02, 2025 at 03:23:36PM +0200, Sebastian Chlad wrote:
> The test_kmem_dead_cgroups test currently assumes that RCU and
> memory reclaim will complete within 5 seconds. In some environments
> this timeout may be insufficient, leading to spurious test failures.
> 
> This patch introduces max_time set to 20 which is then used in the
> test. After 5th sec the debug message is printed to indicate the
> cleanup is still ongoing.
> 
> In the system under test with 16 CPUs the original test was failing
> most of the time and the cleanup time took usually approx. 6sec.
> Further tests were conducted with and without do_rcu_barrier and the
> results (respectively) are as follow:
> quantiles 0  0.25  0.5  0.75  1
>           1    2    3    8    20 (mean = 4.7667)
>           3    5    8    8    20 (mean = 7.6667)
> 
> Acked-by: Michal Koutny <mkoutny@suse.com>
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

