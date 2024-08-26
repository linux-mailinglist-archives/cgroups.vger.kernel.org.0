Return-Path: <cgroups+bounces-4471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04F95F9D1
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 21:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC99DB20D53
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FC1991D5;
	Mon, 26 Aug 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhYUjN1O"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE680034;
	Mon, 26 Aug 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701222; cv=none; b=hiH3j58StVYSaoVfY3dmoPzb9poG99yGg5P6KQtCVu4SmzzjTTm6D6aicUI0wJFfw5Pnk0McDmCKLvwnxaQv1aUvfdgiTD/729yDHUXN6+FLPYZktGqMZdSLglaNsHLVZoId8OWXvNdawQPlb0lNwUQPPmKoT8LLjGEg4wY0DZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701222; c=relaxed/simple;
	bh=iX7LV2kphm8h3qEmrJT4IcBuv9Gi7k++1WPKkYQPA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ytpo8hRvUWCmeEaNUI9QdZsSdkbvhfW9DryrIuwGQBKhcJVpfU/BwYVHP/MItmmiZ5yCGt4PevO7oNi5GNGLPf1p1pHzvTRYExjJVLAYNkDv2otDIBb+1XKDUnSEGQUm8pQBvBPp4NV1aV5h+aT+nDZwSVdfDz6gp/ZR1JgIJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhYUjN1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD80C8B7A3;
	Mon, 26 Aug 2024 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724701221;
	bh=iX7LV2kphm8h3qEmrJT4IcBuv9Gi7k++1WPKkYQPA5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhYUjN1OXeYECp4Ix3FITP9NU1ORVBUuLNpPjGiCbsmf3bcdBsFiEtKrEOAkQhPrk
	 4wIBXPJWGWRXxnmWNsIeksOUogy2+vcFg7be9MvGzKRAkpIzgtL4QpFPCrwgLsObhs
	 BWYlYtouTlyaWxEUss7gAYKWV6AvcYVYbC4HrjPDcKE8oIIU3EUQFKVzBHN8qi65gq
	 mHCEIgBvQQJNJ+oMZqIlOPfV76tAF5A+r5xUOdepinjpbABvgk2fZd7t3VO4lKHAFz
	 JU8iXYB1tyebhHPadZkXDIq8bGkzVLQtYNFr9lZBXtjqf44qOzm+aItaNTVeMoHmjC
	 yhpgsHFUhOhWg==
Date: Mon, 26 Aug 2024 09:40:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, adityakali@google.com, sergeh@kernel.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v2 -next 09/11] cgroup/cpuset: move v1 interfaces to
 cpuset-v1.c
Message-ID: <ZszaJFzcmBskojVS@slm.duckdns.org>
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-10-chenridong@huawei.com>
 <eaef1faf-c3f3-4664-ae7d-5cca611925e4@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaef1faf-c3f3-4664-ae7d-5cca611925e4@redhat.com>

On Mon, Aug 26, 2024 at 03:30:14PM -0400, Waiman Long wrote:
...
> Another alternative is to include cpuset-v1.c directly into cpuset.c like
> 
> #ifdef CONFIG_CPUSETS_V1
> #include "cpuset-v1.c"
> #else
>    ....
> #endif
> 
> Then you don't need to change the names and will not need cpuset-internal.h.
> It is up to you to decide what you want to do.

FWIW, I'd prefer to have cpuset1_ prefixed functions declared in cpuset1.h
or something rather than including .c file.

Thanks.

-- 
tejun

