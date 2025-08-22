Return-Path: <cgroups+bounces-9334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD2B321BD
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BE3642D36
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C1285CB2;
	Fri, 22 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQh9Mbyv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AC280335;
	Fri, 22 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884889; cv=none; b=kzFlS5v0dVnFUaN/fIP0vcNSbaoFieG16bUL75GPHF/4lK0lB5/AFLz95iFxh8zTff/LFqFMs6iEQmKDN/V4tACxye6t/EPxsT6OQtLLG0DaoqL6fgN5FyoDiFwfzNaB0qcJA0Cxkar7/6y/Bu4+lBRtbQKVGdcdWCB4aDNbgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884889; c=relaxed/simple;
	bh=bawwJYcFS67p2XyiS6mrS3GbOPCZtnc2YPCaCZhdb3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj0VYpZHTaRoW5cCxXv7bjawu4lUsLrgJ+NKvjrsiVTiPUP6OX2Vwao9AQA4HkZnrSXRJk8EJAFzfY9T1S9JClkxxlzvNHv8TeMlzGtZ/p1E3NiKS5kkrhnUJOH67R4+CmP5a5GfwsyDuMVTwiQRoRO5AbD+VO4kCy4IlxoHwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQh9Mbyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156F9C4CEED;
	Fri, 22 Aug 2025 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884889;
	bh=bawwJYcFS67p2XyiS6mrS3GbOPCZtnc2YPCaCZhdb3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQh9MbyvY5xmQAiIsvXYLm9Kk0lTRh0j0JJukPANKD6TvfyJTE/96U+m0tXiKxbr9
	 jlQ+YOIn2FY41M//cP2zDFw8lwSn7nJPVbcWYmrzQZOjeqjW2zX5T/XuAZ1IAt59O7
	 sMrVce6tMVte9tJ6NETZeDhRvqFExaBB0XK2Jh87kXSoS3evIsIvmua2ELW5ssiBgG
	 PwDHiR1bYxUaOmkJMJbZQDomN/Dt7jbJgo/uDNPxGvqy+/0+oG6W53u6CMrMZHMOTI
	 KSTpFUovFpa6Vz+24Dasbml3tsi5sXp0z90wNDnL9jnQ2ZfrBnyaMqvYJ+KoWSoCm+
	 F2Hc/40X++k3A==
Date: Fri, 22 Aug 2025 07:48:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: gregkh@linuxfoundation.org, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 2/2] cgroup/psi: Set of->priv to NULL upon file release
Message-ID: <aKitWH39wpfTF5st@slm.duckdns.org>
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822070715.1565236-3-chenridong@huaweicloud.com>

On Fri, Aug 22, 2025 at 07:07:15AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Setting of->priv to NULL when the file is released enables earlier bug
> detection. This allows potential bugs to manifest as NULL pointer
> dereferences rather than use-after-free errors[1], which are generally more
> difficult to diagnose.
> 
> [1] https://lore.kernel.org/cgroups/38ef3ff9-b380-44f0-9315-8b3714b0948d@huaweicloud.com/T/#m8a3b3f88f0ff3da5925d342e90043394f8b2091b
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.17-fixes.

Thanks.

-- 
tejun

