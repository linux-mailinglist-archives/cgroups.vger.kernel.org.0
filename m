Return-Path: <cgroups+bounces-10297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A5B8A9EC
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4284E5A347A
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332523191A1;
	Fri, 19 Sep 2025 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCxaxfHV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D1F12E0;
	Fri, 19 Sep 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300238; cv=none; b=Do+cWyvzWsZOpFj0ERORGe/p5jPxotCXaL8kzy3LI1R32gau4Guq+KdVVd7dMaVTr0AwmKW+KBgdMf4bHwdemc9TjOMMaRSkqBY4B++laBR/70ZpZx4XrpH5l9VwU6ueVFmohFgbiwYnpagJqgnrVF02mwQVTqknyhaLJXNsY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300238; c=relaxed/simple;
	bh=iECX9ELSHhQq0vx5eFeCAxVcMZqOHbUzRpxZPYtIw1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/kuSoOQxfFqB3f5D/ryZq75HCq7XAv6XMENeuK2cAf7oWDqr4HKVQonhzZRkl0Y2US3LGO/8OUVWCBTt9r6KkXEShiqo7FPgL3miTUbWMTZ2uGbQPw/ImrMpy+ehGDExtOoaVeQW5JTdHkcGDmTVYsz4Ds3gF29NPNeJUfAOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCxaxfHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70987C4CEF0;
	Fri, 19 Sep 2025 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300237;
	bh=iECX9ELSHhQq0vx5eFeCAxVcMZqOHbUzRpxZPYtIw1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCxaxfHVgSAGCOgIKCZA8F8GPBeOK93UWNJTbjWvQvUXesbCFg8jMQl9ZpX9RAVAg
	 wV8eMC5zTPvbERvg11Fq9qvzMwPf8TDVQCa0XpYk6kHSnrJ73PXQDe5A9kix+ENVtV
	 dhaHJHOYk6M0HUaU8/jK4otA23Fe5DGM8pLbgldCsxZDvJBjP4ujm2+l5RV9NQ1+We
	 VhngHvZ7ut5MVJPrS/WTI+BOIiQ5cF8abwF2YY4Kjj+/vRCy5bLKfQ30vlNr0ML1vm
	 fQrD0vAV7df+snqaS0c/7Np+vyDeYBTs1XtiYiY0iV7axHiyJq+tO3UzA+NEiBFRTc
	 V9bUXUXjUYOGg==
Date: Fri, 19 Sep 2025 06:43:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH cgroup/for-next] cpuset: fix missing error return in
 update_cpumask
Message-ID: <aM2ITLVvzU-k9I6i@slm.duckdns.org>
References: <20250917060454.2885698-9-chenridong@huaweicloud.com>
 <20250919094903.3060470-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919094903.3060470-1-chenridong@huaweicloud.com>

On Fri, Sep 19, 2025 at 09:49:03AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The commit c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
> inadvertently removed the error return when cpus_allowed_validate_change()
> fails. This patch restores the proper error handling by returning retval
> when the validation check fails.
> 
> Fixes: c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

