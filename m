Return-Path: <cgroups+bounces-12128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34636C744D2
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E813235D5A7
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A133CE87;
	Thu, 20 Nov 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kqt4D9kV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA91E51EB
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645670; cv=none; b=J3HkJ524Ll8HmnLUl5hFefHAkBCe/SgxojtiguAVe5SKVPvoh6zDP8GkKx/liklW5eNcFJNEE4pRWqWFAXp+1CNX7sjB7YgJ9PQCUxynRRdy+J7U1co6ynONqj8pXmWJrnxYo+bkGRz7m0ju4S3GsSt3L76tuysHL/puMgx4w9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645670; c=relaxed/simple;
	bh=2JqD0Cb3ldMQkMKei2Ngo5SxgtQmE3UlK1wNHQxiiko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GutZmYysp5b5onCgjU0ZUMS5dvatzKF997gYhQkuT3X4xFMS0MVw64mBeHT1JinSwNSPCVKmqvzYBtYpXVsotM0xSe6HSiC+DizdSGeAdXvAyQ2UkeHik5lYlts2JC3ELwTAsOgtuZQqm0xaEk1Jhd+UaKw1AAndg6DP2IT1whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kqt4D9kV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0addc62f-e0b3-456e-b172-9216a6d2b8d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763645666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MQr0CRFgIXovknIEHiu9j5T0LFNZ19+f2mtfiMOm/c=;
	b=Kqt4D9kVgo8JwZMHBEt00cKHZB42GRhjYrKiWjFMfvK33V+97UY6w4oO/R9vkQ9g1cBnkT
	DhDgOFCKVj9TlInMNBa3UzYy+bGA+d77esp3+g2SSJkirJGUqfphWkKICH5rLdRzceXQ9P
	k6mwGTxtL++xKJpiNHrBZiSW5jpvixk=
Date: Thu, 20 Nov 2025 21:34:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 11/26] mm: page_io: prevent memory cgroup release in
 page_io module
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
 <3076467321061767e16ca7abbaa33998bfee97cc.1761658310.git.zhengqi.arch@bytedance.com>
 <aR2NQl-w2O4PgvHr@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR2NQl-w2O4PgvHr@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 5:26 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:24PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in swap_writepage() and
> 
> nit:                                          ^ swap_writeout()

will fix it.

> 
>> bio_associate_blkg_from_page().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> 


