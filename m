Return-Path: <cgroups+bounces-13094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D8ED14DF4
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2882130161DF
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002A31353B;
	Mon, 12 Jan 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZjsn1UP"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF70311948;
	Mon, 12 Jan 2026 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245086; cv=none; b=Bb+Lc0pWDrj8Uk/zmdACCNnSjjH93gmse4gEAgcjmIz1CBU/4nt85s1AtAv+tB/bGgbzbHFo4YLldstDAFAxNFbZ965OItmHcR4hoK/8fRbw/bXsF4H74ZpdYy17wPu6tWzYDkSXKLfxWByax7FXHGqQnuEjaGYuyXNdzs/pluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245086; c=relaxed/simple;
	bh=mjxczyL+BDMrZeDC82yRJcLP076mAV3WWq+5kJL46lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONO0pR5rf0GhmPtazte1t25/Ke/ZaHADbwgBEwwEMbrYobt+Y9v2EYg7qnR3/NSuO/LdMHzPKMi+vtiX/OkKnj627gsJvmGMXDqzmCf5WiMLRgmYUWOIuMS+v0m2jbta/sFGvOqkJA+eqrbIyHawYIkEvFwjbseQZghUftr9uSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YZjsn1UP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C7Iazn07BlU3KeyKwpk/Lh/6LTZKOYHbXLhopqmASho=; b=YZjsn1UPcJIXIVFSrthoKfcF73
	OuQpDbgQ5+PclN0GaVicHQGYXeuclRx1XYK8lT74EEDNPqfz9DRos0RuuKWp64AkYhNUxPv5+tZtW
	lxB1nJBa/biJbSRqHkgENMSDv71Mqp1Vld80mtOq3TMe6K3ObtkqCunIGlDjoEnBspgGAyxY9OHYs
	PE5Xe6oCr2zyvwULflE0ag4Cffl4mTWAiO1uMOe2Yn0s7saDgcobsRJkKeYtUtsh/7A8Ng3gw130o
	FzoVewjkdi7PAqN1l2FmrnNh6Hqul434ahEiIh/f07Mg26FBs+RQzwxvThSlRL5DNcQ/McZ661Suh
	6m/6FF6Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfNJz-00000005xs9-3ODZ;
	Mon, 12 Jan 2026 19:11:23 +0000
Message-ID: <f1a923f9-d1b2-484d-9253-99a2edaf41fd@infradead.org>
Date: Mon, 12 Jan 2026 11:11:23 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
To: Nauman Sabir <officialnaumansabir@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kbuild@vger.kernel.org
References: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260112160820.19075-1-officialnaumansabir@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 8:08 AM, Nauman Sabir wrote:
> Fix various typos and grammatical errors across documentation files:
> 
> - Fix missing preposition 'in' in process/changes.rst
> - Correct 'result by' to 'result from' in admin-guide/README.rst
> - Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
> - Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
>   cgroup-v2.rst, and kconfig-language.rst
> - Fix 'needs precisely know' to 'needs to precisely know'
> - Correct 'overcommited' to 'overcommitted' in hugetlb.rst
> - Fix subject-verb agreement: 'never causes' to 'never cause'
> - Fix 'there is enough' to 'there are enough' in hugetlb.rst
> - Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
> - Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx
> 
> Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/README.rst           |  2 +-
>  .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
>  Documentation/admin-guide/cgroup-v2.rst        |  2 +-
>  Documentation/filesystems/erofs.rst            |  2 +-
>  Documentation/kbuild/kconfig-language.rst      |  2 +-
>  Documentation/process/changes.rst              |  2 +-
>  Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 



-- 
~Randy

