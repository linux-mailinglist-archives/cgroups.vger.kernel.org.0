Return-Path: <cgroups+bounces-10296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9AB8A9C5
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3713A1CC03F5
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85131E0EB;
	Fri, 19 Sep 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2GxxygT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07726B75C;
	Fri, 19 Sep 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300113; cv=none; b=UkXxayOIXCFT06h8JodXIBzCm/Gtq6/T9CDKlz6Dx8uNdS+FVQHoGo+6m7hKcc7bVIO5YTn4tVwfcagOVxbxp3LSSihotSdfCvxYuguDoFar5Ok8sdUmqYJTSL/sq/o137QgILk9rbyyclwx/y+Yoeb3QIQUtsWQVoCCJeC4hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300113; c=relaxed/simple;
	bh=567C8e6Kj+sE1mLBbyKmdfMk5RD/zYPcHPmp+ZckOOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THUawTMShG/nR1Xfkowhq0fpwr6nn2twfB9d4xXnvfDRVOOqmxqq+JdDNt1uXFl2Ri7MDf+dtGQStZu3Z+PbA5RSxS+UuOzIP7P5CantlK55nJgkP81vO3y3xpM7zMbtuyO6PuvGkRPAOnDIr7WoakNgtreaaQgIvdZcofo/EVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2GxxygT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91765C4CEF0;
	Fri, 19 Sep 2025 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300113;
	bh=567C8e6Kj+sE1mLBbyKmdfMk5RD/zYPcHPmp+ZckOOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2GxxygTL4z2gtZ9ZDdkXeJFNx2ks/GGftzkRY0hWD+EgVPkypeCT9uiHsuxT3301
	 ght+1/hEtIriKn+EdRb1Ou+Iy4eL+OfmfjwtnkoHBMFpbTVw+SDyBfJnRGkg93RNYE
	 /abTCfRCzau4iDivtB349Q72e3I2UPDPRIjGB+Gdoz1K2zojNt6ttUt6QX/sHkntXn
	 8wxsdza+Xb2/f/YqtnQwqur1RJDEnNowyFEb1jhq0zm0zlINVoRp5ZSe05cpLzFJGp
	 mkTL6ABOPpIWhk3YjaSkUGExs+gxnOq9Dtu6uFyQQweLAlFcU00YSPjN4AXAYNV4E0
	 mTlZz+PGp96nw==
Date: Fri, 19 Sep 2025 06:41:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH cgroup/for-next v2 0/2] cpuset: fix failure to enable
 isolated partition when containing isolcpus
Message-ID: <aM2H0DrhTWGXT4O-@slm.duckdns.org>
References: <20250919011227.2991696-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919011227.2991696-1-chenridong@huaweicloud.com>

On Fri, Sep 19, 2025 at 01:12:25AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This series fixes an issue where enabling an isolated partition fails if
> the cpuset contains isolcpus. Additionally, the patches include
> modifications to address a potential related issue.
> 
> ---
> Changes from v1:
> - patch1: update the fixed commit id.
> 
> Chen Ridong (2):
>   cpuset: fix failure to enable isolated partition when containing
>     isolcpus
>   cpuset: Use new excpus for nocpu error check when enabling root
>     partition

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

