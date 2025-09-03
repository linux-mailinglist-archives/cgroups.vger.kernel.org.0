Return-Path: <cgroups+bounces-9683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFCB428E0
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30F216B60A
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3131C368097;
	Wed,  3 Sep 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU18Pl8w"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC824CEEA;
	Wed,  3 Sep 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924851; cv=none; b=AxIaBJQLA6wM/46+iQisUTxsTQ66bM3i+z1kb2pHHP/BHcLLlYFdp4lvK8Iyoa2Bbg9WoCM/EVg04v2oF4zah64eRl5jQuCoGx7U+2KUQTQASLgwfN41bhz8xWw+lW0rxWpf3OWx7P9S3k/61sJE9xyPMpAC6WkZKg80GNe0hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924851; c=relaxed/simple;
	bh=unVLEo78qaEbXXswkqZwTH79e5LWyUFWR6RCl804SoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw91PjMXsMUhvl25CBJZm6fBTONYhicuiO5q7BN0+07UOudJ6tVN56+/AXmWMYQHypQTQFGJzZrAcLggNn+GpCJzyDO7L10QoGj6OioRWQEee3DWNeb0uKZLyhNStWpjd6jNKkeuznrG5NCnmU+f5x5VFywUee7ICk7rVtSeIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU18Pl8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403E9C4CEE7;
	Wed,  3 Sep 2025 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924850;
	bh=unVLEo78qaEbXXswkqZwTH79e5LWyUFWR6RCl804SoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hU18Pl8wDQ23KbdDDn4dIlDFKPrCKQP/9ZxzNnZgpEELscJS3EDxCn9U+/9hV4VK7
	 qkS+h3TehtSABSBKKrtHiskOMUI2spHWbMSwJdeA8QYMCGEAyAnvjAOZvpjY6MKhxu
	 AMLDvliuKnhLuUGNT4MDTlVRaCq8WdMuDjBZdFQc9IXMxyRDhkpmDf3YPdVRgLRp7I
	 kwTI6ibwb91zh/U1tn0yIR9avwzl/Dme7zXYDDPjkX/zJ3oHQcCsaGRmg6FOc7UB+Q
	 WAstgo2TgrgdxkfwMy/sITXhR+zbz+4EDhc1NYCXEafbHv8NhWrCzoxRVOypiFaSd9
	 +OxF5zsk4yvYA==
Date: Wed, 3 Sep 2025 08:40:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ashay Jaiswal <quic_ashayj@quicinc.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Prevent NULL pointer access in
 free_tmpmasks()
Message-ID: <aLiLsQsM2oxk8Cko@slm.duckdns.org>
References: <20250902181537.833102-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902181537.833102-1-longman@redhat.com>

On Tue, Sep 02, 2025 at 02:15:37PM -0400, Waiman Long wrote:
> Commit 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in
> cgroup") separates out the freeing of tmpmasks into a new free_tmpmask()
> helper but removes the NULL pointer check in the process. Unfortunately a
> NULL pointer can be passed to free_tmpmasks() in cpuset_handle_hotplug()
> if cpuset v1 is active. This can cause segmentation fault and crash
> the kernel.
> 
> Fix that by adding the NULL pointer check to free_tmpmasks().
> 
> Fixes: 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup")
> Reported-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> Closes: https://lore.kernel.org/lkml/20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com/
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

