Return-Path: <cgroups+bounces-11659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91713C3E49F
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D49E3ACACB
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5A2FBDFD;
	Fri,  7 Nov 2025 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R4sjC/6n"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F822DC784
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483945; cv=none; b=u1yl5NaChzKPTamKjUb0mLerXZq8hXoWE9kzgKr048FmtIdpB8GNYmDOfjb8sxpUJ7K06wDt+6DXMUPNDcHJ9i8M3m2pw+n/l9pQ2Wd64Pnhq3Wv7MFtlckTMJOmDK9RAtCOHPpGqTtvWwTkou5avxVa9ExgjPpoNNVV5Ng96Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483945; c=relaxed/simple;
	bh=dtCfywJRCI0d/IGRaQpOjWKRaSDzvTXLeI92Ehedf9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieSsHbLmmw6wABRLOd61lgntCqzEa+MIrm8BM5tXC5YJUB9C5M68Lcu2jncGzsJSMJoE/rXJMxfbwUK+uvnIsLBzcaCMq3C6GOQJU7GCRlYa346mvixQ0ONIGi7p1Mh+QCf7ABOdx9ndXwLpl3lLKRge2dFO9XSLWFDwyiZgQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R4sjC/6n; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfdc78de-febd-4224-94c7-bb02ee71aefe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762483941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52V3X2Sr5dWVePWtrbdXKFUg9bUNSzwTF2IQfUlVk1g=;
	b=R4sjC/6nQbXI1THBR/jGtbCwNaoEvDMv+9sTHSTixwKUhXSIGW4VrTtL1irRbcCqn7P9Qp
	6ziNkNoTXXiW+NdKynDTP43hyUfoXDL8ikKh1Jw36uhvJUDBVhSX1wrGtPt8pFvf6glDfL
	N6n+N84dA2UpqTPtP/3oAJ/uLdc9OaI=
Date: Fri, 7 Nov 2025 10:52:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
To: Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
 <20251106145213.jblfgslgjzfr3z7h@master>
 <20251106182949.1ffd6f5529aa18139f2ba9f3@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251106182949.1ffd6f5529aa18139f2ba9f3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/7/25 10:29 AM, Andrew Morton wrote:
> On Thu, 6 Nov 2025 14:52:13 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
> 
>>> +		if (folio_order(folio) > 1) {
>>> +			if (!list_empty(&folio->_deferred_list)) {
>>> +				ds_queue->split_queue_len--;
>>> +				/*
>>> +				 * Reinitialize page_deferred_list after removing the
>>> +				 * page from the split_queue, otherwise a subsequent
>>> +				 * split will see list corruption when checking the
>>> +				 * page_deferred_list.
>>> +				 */
>>> +				list_del_init(&folio->_deferred_list);
>>> +			}
>>> 			if (folio_test_partially_mapped(folio)) {
>>> 				folio_clear_partially_mapped(folio);
>>> 				mod_mthp_stat(folio_order(folio),
>>> 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>> 			}
>>> -			/*
>>> -			 * Reinitialize page_deferred_list after removing the
>>> -			 * page from the split_queue, otherwise a subsequent
>>> -			 * split will see list corruption when checking the
>>> -			 * page_deferred_list.
>>> -			 */
>>> -			list_del_init(&folio->_deferred_list);
>>
>> @Andrew
>>
>> Current mm-new looks not merge the code correctly?
>>
> 
> It happens.  We presently have 29 patches which alter mm/huge_memory.c.
> 
> Thanks for checking.  I'll drop version 5 of "reparent the THP split queue".
> 
> Please check what remains, and send a v6 against tomorrow's
> mm-new/mm-unstable.

OK, will rebase and resend it.




