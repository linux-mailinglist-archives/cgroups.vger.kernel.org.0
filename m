Return-Path: <cgroups+bounces-12150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E5C77C98
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 09:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86AFC34E764
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5CB217736;
	Fri, 21 Nov 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="taEnaWnq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97C222597
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712133; cv=none; b=Oc/YTYvMJEiBEvVHQig+svTCmrpqmaMeB2n8LMLxJCvZikDW+4d+wvp1Dj4M6chzWXKPcFxFGRc9iVzlP/w4Degp3VawgOVvIp6cD9U5imstkfbe09BXpaawzD2Y1P0HtzRM10s77xlIGB853qfWlJllqZqwf5JY/pVd1urQnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712133; c=relaxed/simple;
	bh=V6XxmJSu7WsQesjB0bw3TZhizmT+QhfYpoCMC9RrYms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGWoyA3LeJiA5t+nGbAGCsv606WhVCv6f6GHKxYyUcw2DvmEJdPhzVorGn4PLJgOmzwmUdbelK2cgH7ePdxWa66/1PQgmE6giN3f1Hadm77MW3HQ+UKIeTIZ59MliFdbV2fSje1Uhm/n4qt04DV/tn28H8PcCT8AhIoDplXq7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=taEnaWnq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f41a142-e640-4bf2-86da-234e2b758a0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763712126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jsx1i9elE0kDy4CTyd+VjXt9Xr7+9oM0mXmmN+UPkWY=;
	b=taEnaWnqKI1qjRkC8sjACrh6zOxo6tHvxfEgfzFsPVjEj3u57ibs7qBmM16cc1EKavRs5K
	kR11+LgUdgSVU+9F1+MxkChLBosbnglXHf7NGET+/sGrIqBrCB7T+6fgZf9ksEZ1bGWQ9+
	IU1R2QlzzuIkQxSy3FVZqwKhUty8WZ8=
Date: Fri, 21 Nov 2025 16:01:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <d5d72d101212e9fb82727c941d581c68728c7f53.1761658311.git.zhengqi.arch@bytedance.com>
 <aR_ZQjoAA9CFwcKG@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR_ZQjoAA9CFwcKG@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/21/25 11:15 AM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:34PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The following diagram illustrates how to ensure the safety of the folio
>> lruvec lock when LRU folios undergo reparenting.
>>
>> In the folio_lruvec_lock(folio) function:
>> ```
>>      rcu_read_lock();
>> retry:
>>      lruvec = folio_lruvec(folio);
>>      /* There is a possibility of folio reparenting at this point. */
>>      spin_lock(&lruvec->lru_lock);
>>      if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>>          /*
>>           * The wrong lruvec lock was acquired, and a retry is required.
>>           * This is because the folio resides on the parent memcg lruvec
>>           * list.
>>           */
>>          spin_unlock(&lruvec->lru_lock);
>>          goto retry;
>>      }
>>
>>      /* Reaching here indicates that folio_memcg() is stable. */
> 
> Does that mean we call rcu_read_unlock() in lruvec_unlock() instead of
> in folio_lruvec_lock() only to avoid false warnings inside the critical

Right.

> section, and technically calling rcu_read_unlock() right after acquiring
> the spinlock is fine?

Right.

> 


