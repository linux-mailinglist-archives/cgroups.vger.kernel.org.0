Return-Path: <cgroups+bounces-12569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F959CD4ABE
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 332D53004D15
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063E326930;
	Mon, 22 Dec 2025 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xm/bVOme"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC322155757
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375824; cv=none; b=giletSfc5U5Awa8L/o+OSCh5mdq5FhLinVwXZWGvFoWiN1WzUam72Oz8XwStVfEeoxkkIhn+paFIqjIdV5gfDXkKZoNO/SMIEVFL/kRrlaySnklNxn7wKoqHu0i0QnmqehdEdBec2d1L46iVR5+ux1Lgx2azdAdXAp4ZT5dDnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375824; c=relaxed/simple;
	bh=88NW62WtBK3X+8JxJVTX8uQIw/rd0j2D/2st8FfrRzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXi5vhMkWpV6AmsYvVSA6PQ2IDzitQuwTT1fahbI+YRlBCAv0IWIALCt7itQyTTggWpVsGBaryGvODVGlH8vosFVbPjwlWDtdB4MHlEByRZ1NdiT2liTNQiZCXlcRBg09WxC6FBcp7/UiOts6Iarnj5arvwullu690nT8tX4oCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xm/bVOme; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81e91219-478f-4f23-8bde-b307130ddf67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766375810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlV2Yr2sfGvqresY8S2eoKk7pM6GxAvG8vIiPkIJn+o=;
	b=xm/bVOmeP43/bzy2D21mp0seBwf+65r4f1RzLre+TL5t8rsBsOoIi7mbT7bk0mRyLIyeCU
	rzzqhSGGBYLV5msZfhXBdfVM/qPEyRxlc7REPjPHPcweD2pNJsnuMK5y83xiC9WdP/vmXv
	myMNW3MiMOIM1dgFQW5iOs8HA1VVs/M=
Date: Mon, 22 Dec 2025 11:56:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 26/28] mm: memcontrol: refactor memcg_reparent_objcgs()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <8e4dff3139390fc0f18546a770d2b35c9c148b8b.1765956026.git.zhengqi.arch@bytedance.com>
 <aUQFiFIsvSez8AAP@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUQFiFIsvSez8AAP@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 9:45 PM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:50PM +0800, Qi Zheng wrote:
>> +static void memcg_reparent_objcgs(struct mem_cgroup *src)
>> +{
>> +	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
>> +	struct mem_cgroup *dst = parent_mem_cgroup(src);
>> +
>> +	reparent_locks(src, dst);
>> +
>> +	__memcg_reparent_objcgs(src, dst);
> 
> Please have __memcg_reparent_objcgs() return the dead objcg for the
> percpu_ref_kill(), instead of doing the deref twice.

OK, will do.

> 
> And please use @child, @parent (or @memcg, @parent) throughout instead
> of @src and @dst.

OK.

> 
>> +
>> +	reparent_unlocks(src, dst);
>>   
>>   	percpu_ref_kill(&objcg->refcnt);
> 
> With that,
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!



