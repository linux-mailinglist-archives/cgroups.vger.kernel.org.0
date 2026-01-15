Return-Path: <cgroups+bounces-13231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02656D22549
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 04:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6DD301FF56
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB029C321;
	Thu, 15 Jan 2026 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BhDYDSir"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582792BB17
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768449140; cv=none; b=oP+3+8GywXCxI7ePFEZTgs195zVwXWFRsZvqBuI1HqpRDxyfFm2AOInOg/TyAaw/hpPsCvB9j378N58yPctxXt5FUOOC0ugZOE8bHiaaxBnK0JpHl7jH7jVTQaNud2UaGMdqNvsykeyUr5dX5nBGHtNUu0GMZ6UJjrkwjtQrCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768449140; c=relaxed/simple;
	bh=SsEgVUsGPNB+7L3seXRVuoVhJsB4NRayKpq6zBtjXL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXM+pPDlUiWokXsCrxUm2GRQiuLekjV0xIC47HIYQjAt3mwWtdkj7qO5vsf3uplgXMHutaOD3V3L64zNldcrH+tvATvbh7P253P3IjgPU2SFKZKdMUkMRvQ9dTEk/3EaM44WeB/tPV4lYjftKFObHDHbvgLWx/0dis8aJxd7kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BhDYDSir; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98819615-5001-45f6-8e63-c4220a242257@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768449137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJanBQGwiNlIzIYjsIPkM4qYw0PVa/FwcDXKz//5f1Y=;
	b=BhDYDSirnJw+eHoRUHKJU//R0gZHAKbWUCDbxWoxDqkkOz+Ueo/bmbgXmC0y3o2lAfiBb+
	CtbQT78LdfZ76/j46TNgR+CZ7k3Hz/1/xflPkMJQrAx4+ZVoKssCf742EhN2/jOTFciGrh
	zUJEdJ7aqmqlcxX9p605iX8XQo/KpCQ=
Date: Thu, 15 Jan 2026 11:52:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/15/26 1:58 AM, Andrew Morton wrote:
> On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> This patchset is intended to transfer the LRU pages to the object cgroup
>> without holding a reference to the original memory cgroup in order to
>> address the issue of the dying memory cgroup.
> 
> Thanks.  I'll add this to mm.git for testing.  A patchset of this
> magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> so let's see.
> 
> I'll suppress the usual added-to-mm email spray.

Hi Andrew,

The issue reported by syzbot needs to be addressed. If you want to test
this patchset, would you like me to provide a fix patch, or would you
prefer me to update to v4?

Thanks,
Qi



