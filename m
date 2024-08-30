Return-Path: <cgroups+bounces-4650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F5966A25
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A8D1C21D09
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC81BF311;
	Fri, 30 Aug 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTJj33sl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C91BF301;
	Fri, 30 Aug 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048076; cv=none; b=FYh77qCIXAAlTJj8UpkVd6MXAzzsAd+IbcXNflvnalwypAg1AmBivtbY91YSuil5SbXC82SOBEpjJbzWepHm48Ul0qHxQMaW4wTTd5mK/B54n8vOYCVkpGj937Jf9Ah+YKTontpyewYYXGejcbbc8EthwblFcGyv9uBcjIkHNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048076; c=relaxed/simple;
	bh=IkNP+rL0nE1/+pswh0mJ/JZVMjfOwbI1RsqL5MB1ZL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/fYqY+ZAkx4DrILoaXLeEY2fl0bU7ccec5+NuVw3hCmnG4N77D3OX+9XmNx698YckxRf2umI1WT5Roz0P6alwwBO8JR/hKAkxGMSEPPUtEy3LYJ5Veke7wwsl6hTiD/dcfKktdR2wtyGoAEVlqr9vsev5NDM2NO6aSeZ0ASrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTJj33sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAFBC4CEC2;
	Fri, 30 Aug 2024 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725048076;
	bh=IkNP+rL0nE1/+pswh0mJ/JZVMjfOwbI1RsqL5MB1ZL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTJj33sl8cjMbJ/5OUF34D0LBkaYPmoy0kiGAGdEynbFNkc4rz/oW4lkeoVNglSfl
	 3OuN+kv8lRIFVtZB6l63+55TGcAo+pJJq+zGHRMHxn1hYYNX5nFwYDeh8FwZg3ulAg
	 Ft8RbuU66qio4kz2Y+4cJS0zH9Ay7y1t5DvS3aHZbvFu8FCyMOYgwdC+ILfXA8rWWc
	 l3WHAKkWJ+af1h8R49ZryZsjfoiKRUGsjVgOH3vlMqldu02hnEBtyLKWWtZPfbhmsz
	 8rhGJFtkrASUR/DBpb8qMPcdiD+BY1ZyCLx64djaz+Ads4e6xEObNEMfQZdtEUzi4r
	 b+r4zkACv8FOg==
Date: Fri, 30 Aug 2024 10:01:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenridong@huaweicloud.com
Subject: Re: [PATCH v4 -next 00/12] cgroup:cpuset:separate legacy cgroup v1
 code and put under config option
Message-ID: <ZtIlC7pH17WkGXE6@slm.duckdns.org>
References: <20240830100229.953012-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>

On Fri, Aug 30, 2024 at 10:02:17AM +0000, Chen Ridong wrote:
> Cgroups v2 have been around for a while and many users have fully adopted
> them, so they never use cgroups v1 features and functionality. Yet they
> have to "pay" for the cgroup v1 support anyway:
> 1) the kernel binary contains an unused cgroup v1 code,
> 2) some code paths have additional checks which are not needed,
> 3) some common structures like task_struct and mem_cgroup contain unused
>    cgroup v1-specific members.
> 
> Cgroup memory controller has already separated legacy code to
> memory-v1.c. So it is time to do the same thing for cpuset controller.
> 
> This patchset aims to do:
> 1) moving cgroup v1-specific cpuset code to the new cpuset-v1.c file,
> 2) putting definitions shared by cpuset.c and cpuset-v1.c into the
>    cpuset-internal.h header,
> 3) introducing the CONFIG_CPUSETS_V1 config option, turned off by default,
> 4) making cpuset-v1.c to compile only if CONFIG_CPUSETS_V1 is set.

Applied the series to cgroup/for-6.12.

Thanks.

-- 
tejun

