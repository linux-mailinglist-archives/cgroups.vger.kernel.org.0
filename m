Return-Path: <cgroups+bounces-9244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D75B28F5D
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5F3ADB30
	for <lists+cgroups@lfdr.de>; Sat, 16 Aug 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4A1C700D;
	Sat, 16 Aug 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI6+JTao"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309823C01;
	Sat, 16 Aug 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360980; cv=none; b=I3eUvEO7CbyJKqBK0UFGmaemg6heRUZTFjiosaPE1WH8ix2owW5SkvKSZV9+b7z+Nw1U61+zzbYwHlHmL3mnw3xHs6xvxGSovZQcZ5TKrNH7kpKVt4jotL6y6Ne3LlezzgFP0afDPmAl9bAMxb2+6NSVRwMeLV6vIlQZTobPL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360980; c=relaxed/simple;
	bh=qPNXLe8tzO3+FvnN5ohddaSwyHeRgFJ5nkVOSzxcnnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw5xQ05W3PFWRxmUNYPm+lQk3LWA9AcjcPDhquExxw7loQ05r0i/z7OwEglkdVJg/aVjPW7vMkJYEYOwwaWg8mtaekghbI9mJQZnVcsNOzNrLqqARDpnD/i/kdG80bqd2kdaB4y/GInRnq5YooH2Csv30mIIPXViuQl8kiujMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI6+JTao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9382CC4CEEF;
	Sat, 16 Aug 2025 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755360979;
	bh=qPNXLe8tzO3+FvnN5ohddaSwyHeRgFJ5nkVOSzxcnnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI6+JTaoVejmS6pWhdT4L9lj4FInjaqIEGpc4lu1g8P90DTzi6eqWNGTgtGSWCBZk
	 woyeIsjJwIKr0Vz3wkFlHrDjT/m0+gQnURov3PHzxeHmx6w0R9JMUCKS4Z8rUjzIyZ
	 MQtnUhykzeh8h3GTPvrYIaKYVjenTQzv3NaYKEVikG2B8l1gaafDEWIVBDQdiXa2kT
	 KRznDUJCbO27FLw1Y26/OJCh7FsHjMHgmOQt92bxvL8WltcVQt0IU1yg8uLsAvHKBD
	 6B4kxRnHLK92ZwmQtR5LZPPxkgA07WzIF1vOx+eNZv7UmVWJ5+IF8JFuEVDgaRsykU
	 fJg+Ykaq/kpDg==
Date: Sat, 16 Aug 2025 06:16:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com
Subject: Re: [PATCH v3] cgroup: cgroup: drain specific subsystems when
 mounting/destroying a root
Message-ID: <aKCu0oLBbgxtKg_S@slm.duckdns.org>
References: <20250815070518.1255842-1-chenridong@huaweicloud.com>
 <aJ9yBuDnUu2jIgYT@slm.duckdns.org>
 <33990c53-5d7a-4f15-81b4-661c7bb96937@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33990c53-5d7a-4f15-81b4-661c7bb96937@huaweicloud.com>

Hello,

On Sat, Aug 16, 2025 at 09:26:59AM +0800, Chen Ridong wrote:
...
> I've tested that adding a dedicated cgroup_offline_wq workqueue for CSS offline operations, which
> could resolve the current issue.
> 
> Going further, I propose we split cgroup_destroy_wq into three specialized workqueues to better
> match the destruction lifecycle:
> cgroup_offline_wq - Handles offline operations
> cgroup_release_wq - Manages resource release
> cgroup_free_wq - Performs final memory freeing
> 
> This explicit separation would clearly delineate responsibilities for each workqueue.
> 
> What are your thoughts on this approach, Tejun?

Yeah, sure. It'd also be helpful to note in a comment why separate
workqueues are used.

Thanks.

-- 
tejun

