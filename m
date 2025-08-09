Return-Path: <cgroups+bounces-9058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF7B1F5D5
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1867F3BD7BC
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6AD2BE636;
	Sat,  9 Aug 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpo9QR5z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF82E36F1;
	Sat,  9 Aug 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765042; cv=none; b=IYvb3lhURXtvti8Zty6NSlYpUkzKTwjrKmNeXD8wfwu83x71HGJrE20XjJzV/xiqUMcnc9tLqH6K6fKKrSwzj/cryJ8hsI8fmhX6hReHyNKBrT26KQv24V1iZuK8UeppjfO0dFN9k7z+5rHV7CKT4KunKtOjRVrLnRW9E9YzWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765042; c=relaxed/simple;
	bh=aa8IQJFKCDIitHyQPjymTeuf9Brbrmd71giZYI4ySvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/dQ+oP9S/iRtyBhOX//xb9k2r/1TQUXfSCI+TOIKAGhZg7ChSqUMEjNGbtRYTFmkqfqcLvbFyG3DCc6Uum6gdqasn4b2NU3VMf4LaohK0rdGcizaSz8rtTRj8pJIHgsX55SYAiJyt7C1ORMzwYjZAOrdti8RNwohJ8bXT+lO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpo9QR5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D0C4CEE7;
	Sat,  9 Aug 2025 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754765041;
	bh=aa8IQJFKCDIitHyQPjymTeuf9Brbrmd71giZYI4ySvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpo9QR5zU48PvAAnMdDxQ7voZJK8GoqLzvrBUY1IeRgkt//WL3fRwGtdhFnCmQBtW
	 UDXwf3xONEM4QagTrHbSxScfiLXP/VGD6RMzA3Sek9HyHegMR1QYRRlgVphTILaYox
	 FHdlQgeRJ9yVcuZI8SDC8U0tpYidA0lqWvEQ0srlQKUKcufAHilIwmy6DA5ZONMPeJ
	 OItN6Vxl1mQ/pnk66B7Tfjrcu29d+ZrbvVTIGRT8RrLdGATex/y4zp53n8jOsY1tBO
	 LXnqQE60vOSu9vSjMl23A/Em2VHctnMszPvTHMyXwgGJp07TH8XR9m+p6IU26mqpxe
	 zRsfUQ1pDGTdQ==
Date: Sat, 9 Aug 2025 08:44:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cgroup/cpuset: Miscellaneous fixes and cleanup
Message-ID: <aJeW8JeDVuR_-NX8@slm.duckdns.org>
References: <20250806172430.1155133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806172430.1155133-1-longman@redhat.com>

On Wed, Aug 06, 2025 at 01:24:27PM -0400, Waiman Long wrote:
> This patch series includes 2 bug fixes patches and 1 cleanup patch. 
> 
> Waiman Long (3):
>   cgroup/cpuset: Use static_branch_enable_cpuslocked() on
>     cpusets_insane_config_key
>   cgroup/cpuset.c: Fix a partition error with CPU hotplug
>   cgroup/cpuset: Remove the unnecessary css_get/put() in
>     cpuset_partition_write()

Applied 1-3 to cgroup/for-6.17-fixes.

Thanks.

-- 
tejun

