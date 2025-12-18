Return-Path: <cgroups+bounces-12520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E3CCDFD4
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D8330A663A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715932FC037;
	Thu, 18 Dec 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SsihqVBI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1C2F7ADE
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100863; cv=none; b=hcqGLOn4AvSTiZc11gQ5JoDbpXkRmi/ulZ+K8hhNlyomCyOL/uBcilt9JtT5oHtHM31ONVFdiXrWMAl8CzrSGiVMq+AijMIAI9uYnmOdSEXn5ny/WwCobK+bdywRIrIUWkPTNHnrg6nFFus7i+i9nw00WI0HXLpGK2bBlwC4kHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100863; c=relaxed/simple;
	bh=izU0zourZGCySuJ1YSVffE8S0MPI7JkiCTSLkEnuU/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0i0fAbNgVFS80R+XzU95G+YtkK+Wm48icVVK/f6KKOgtwOspCIrG0ABUrB0os3g7NKiWYlBRqFKNSQ5rxeZXHs51A4pXsWwIL5nH4GkNQkGG368GtK7F/Bz+YriI3szv5FcpJe4iQfe0q22U6C9es6E9quYSETp8GFaA/8N2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SsihqVBI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 15:34:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766100858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FksPB/81q1/fiq/yVCprH0gxfgwUBo6bbyxzq+WvCbg=;
	b=SsihqVBIK7pZltgy7boa9xHlaoOpOOhjuXXjmAUIa/m5Ghdxm16C+Cc2a+gqS2GScrwDkk
	iHM2aB3K7g82Dl7lREYLFRpOwQ93lFelkZ5pRcvB9HeHMuIc7XuJwpl2bo5aXy1yWrHBaN
	hNlpioKEED2g5oW7+DHzXkK0Korhz1I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH v2 03/28] mm: rename unlock_page_lruvec_irq and its
 variants
Message-ID: <w5dudwxtraadmclm6exyjal6lheiw6qqraiq4yz2i3y7heoued@b5ikfcfwiwwy>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <a11ca717ddd52fd83e1fff9942fc49c9c5c5b78c.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11ca717ddd52fd83e1fff9942fc49c9c5c5b78c.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:27PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> It is inappropriate to use folio_lruvec_lock() variants in conjunction
> with unlock_page_lruvec() variants, as this involves the inconsistent
> operation of locking a folio while unlocking a page. To rectify this, the
> functions unlock_page_lruvec{_irq, _irqrestore} are renamed to
> lruvec_unlock{_irq,_irqrestore}.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

