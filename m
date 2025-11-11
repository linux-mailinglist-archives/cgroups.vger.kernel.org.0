Return-Path: <cgroups+bounces-11780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829FC4B484
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CA2188BD3D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA487313E0B;
	Tue, 11 Nov 2025 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i2VXkTwr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B731353A
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830440; cv=none; b=qdhA7qJih9SW/tMV8V2mrN3wVJ5YlxGiLTRpHUAW/aiiB4fx1HRLK2Q++6hj30YGElv9yBPgLI9W+Fv7GNagOl+zn+0wBauu29lZYQV2a9KJiRcFBWScy2J6KKvwtw2Ih6WD9/tZGzv8s21QFjqBCb2mz9NC0sMCvthT9P21TLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830440; c=relaxed/simple;
	bh=C9MTaUCT55ut547f01PQNb6jRUKY3GznxjeXK2vW3mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4+OJLhMFhmYsoZ4SVg1ZTu5uteHdkRX3XjfJVbp3Ewk840ie61wC3cEVUxHAmwXa3nk3Tf/WHBG30ukiNOhRw/kQVvWUuxC1lFkuqK8u9hJ1UhED4QZtYBCjbbnnWh0bP1deir//ki1Ym4gBve/cyydZfotOQFSnjKxf9fMrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i2VXkTwr; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <982d6b8c-53e7-46f3-9357-afb85319d0a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762830437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coZlxvjouzIp2H+RXwQcczehI/L+km+mWX+nuQHuLuc=;
	b=i2VXkTwrEj122SnmJM/kZ5RGpk+CzulkvQbubkractg6E7mfog6AeRcXLOdWG1K07xKKJo
	3PSATPpRhFOSR6pWC2IQHDdfj13x4O+rsoI9YBNN/lzT8Lwd9xqxAJvLM96rPpnDJcphP/
	tfysCV3NdMZAEmDE402Rr8RVOpryFAA=
Date: Tue, 11 Nov 2025 11:07:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo> <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
 <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 11:00 AM, Shakeel Butt wrote:
> On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
>> Hi Shakeel,
>>
>> On 11/11/25 10:39 AM, Shakeel Butt wrote:
>>> On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
>>>> Hi,
>>>>
>>> [...]
>>>>>
>>>>> Are you or Qi planning a follow-up that converts spin_lock_irq() to
>>>>> spin_lock() in places where they disabled IRQs was just to update vmstat?
>>>>
>>>> Perhaps this change could be implemented together in [PATCH 1/4]?
>>>>
>>>> Of course, it's also reasonable to make it a separate patch. If we
>>>> choose this method, I’m fine with either me or Shakeel doing it.
>>>>
>>>
>>> Let's do it separately as I wanted to keep the memcg related changes
>>> self-contained.
>>
>> OK.
>>
>>>
>>> Qi, can you please take a stab at that?
>>
>> Sure, I will do it.
>>
>>>
>>>>>
>>>>> Qi's zombie memcg series will depends on that work I guess..
>>>>
>>>> Yes, and there are other places that also need to be converted, such as
>>>> __folio_migrate_mapping().
>>>
>>> I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
>>> using the same reasoning we can convert it to use mod_zone_page_state().
>>> Where else do you need to do these conversions (other than
>>> __folio_migrate_mapping)?
>>
>> I mean converting these places to use spin_lock() instead of
>> spin_lock_irq().
> 
> For only stats, right?

Right, for thoes places where they disabled IRQs was just to update
vmstat.



