Return-Path: <cgroups+bounces-6369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5AA21716
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 05:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05387A3AA5
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 04:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199BD18FDC6;
	Wed, 29 Jan 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lt3k7LRY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081318BBAE
	for <cgroups@vger.kernel.org>; Wed, 29 Jan 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738126086; cv=none; b=ggp9YMEjWttdQhEjqcZTZNDBTm2SbuL67WqmL1q3ZcY9Dxhx3mIxiAnIeAabn0ed/gg1oEzfe5PPRjx1+Cmz5K9EeAtn/8oDImYJajtMakztRwcefOIuX3jnR7lfSOm0nTxmSj6fXNisB6XPQHpuKjSzhrDBrIpdOB4NvpAwgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738126086; c=relaxed/simple;
	bh=peWcLBmGw9O9vXyRSnEUD3ALTkxdirdqXdZSwpQylRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEX1U6AjOsJ0S0PUcoD2G/aCM6D/YRKHkG7+Lv0VcXpYTsPyai/NFqnAp6XKvmSp7sfOrzlN00s0YoyiabltgKUPfzPOI/AoGyWpnSn4eb23C+vvt0053vw9BCe3BENmeNIzmi41D2bV+idNdKEt0QzZbsqtcI0fAZ473RQUEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lt3k7LRY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166db59927so11857505ad.0
        for <cgroups@vger.kernel.org>; Tue, 28 Jan 2025 20:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738126084; x=1738730884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nBAJs/K3XCTXctROPnqYBKk6nvC0nwt2edw8ojQ7lg=;
        b=Lt3k7LRYozcgFjHizxN+y2ak7j/v6IEqkGVpTv8tthoZnMfYGpuCdQm9k7seLwRa2P
         IS/pJei54lkDhV3T7E+L+57UjWO54Hv31MPBRNKwGGExtyMSqCKrvG5khjNaf9VKiEXH
         MjGnYEFAudGKRMPp+nwf6KeJj1nJgxvwewelUGdOMuGF2opy4JiotMf9joMo7sx71scm
         tPZ0fZ/ujLe5fQLCz02MmQ+nf9XDRFpLfm8jWzyZTCy5s73/t4ZqZzT3B3NOowaN9C8W
         hxH9m8iQJVLYwlMFPQnpazTR0XW1HcXNKeA3pZOHiVHGAf2/T8MzlUfM2TRqqnw1mRhZ
         Kgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738126084; x=1738730884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nBAJs/K3XCTXctROPnqYBKk6nvC0nwt2edw8ojQ7lg=;
        b=rVnF570dA0Y9bvZO6k2s3zjEwllJ23R5ZGqoptHg7aSWRAaCWj6E6f/LZKU7jnFrUZ
         JGqmA+19wELearoPiancgVH6CD7WfPNKX/L52N7HWCKOTYwdeyANNxtZWTlszb7P/L72
         TtGfDuUeS+uBZqOR8DJKS/nScZ0aHWe019lM3+QSndi36u2W55+cHOQWUbwgxmo4I8cX
         6QvKZq/zhWZRtmimdpGwAf1eZm2PbvN5mNbPVEl2/XJOLcj7hSmrkLawtC1vtL8ubBUr
         sMIEOleKDRCz1otC/YkUEgrK3/5ZCgrMmG5Lc79cakpyJBfw3msF4KJJ+wWRnDyK4wYv
         IfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAIvLExWZJBYm2vSxMYF2dzipouKhvwmcvoaNzEIqZtZUZoJ3PzPdMMgNiEMOQj2I3vmO6Velr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+I6w8aQeLXjHyX21QhijTBJ0SCcpDesxwJnjfJ4QRjsnKVLEu
	PcxvSq2ilCvHmU7Aq342BNRwi8rQC3RoTRw56TuncJHGk0lMarPhx2IkE34GjLY=
X-Gm-Gg: ASbGncscxsAK/3IpPNPbszQw9lWW8ObmTHf6aUqyiXZ45PM86ioH7I4jnjMTl8KZTdO
	7clEF1iOAZcvtsDyQcmfGLrXV/+r6FXpYSnl2Qx+5jVA3UJIRoj2gGXbeAxKz2isPxix77CsagE
	ES2JJ9xT0pKjbsX8pEBVK4GDv9Dp7ChfXZULecSsXZjQ+n1mLEpr1ttmjt/h8PMzwAWIL/1WEgb
	3NmVgdKlZ4YKU7ogabJEZYpL4qeqHGs+zyWiGp+duljT9OduhzHDlgW9QT+3EJiEB/luvRBLde1
	1xx3cTz6oJBRJQ8AygjlziZopCb521nAfTYLtB+qGzJrAJyZnIY=
X-Google-Smtp-Source: AGHT+IH2SL9fkJmk2X8K7lTgSkBExNzIhKUEntMRXEEyWswgtjrpKfSvnvK7wAH+UMWjl6oI+Hf7kw==
X-Received: by 2002:a17:902:db09:b0:215:6533:f4ee with SMTP id d9443c01a7336-21dd7deeab0mr9770055ad.13.1738126084231;
        Tue, 28 Jan 2025 20:48:04 -0800 (PST)
Received: from [10.254.209.208] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f39fsm89622785ad.249.2025.01.28.20.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 20:48:03 -0800 (PST)
Message-ID: <784be226-d4a8-43bf-9096-dbb7ca8f0cff@bytedance.com>
Date: Wed, 29 Jan 2025 12:47:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu
 <yaoma@linux.alibaba.com>, Yury Norov <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-3-wuyun.abel@bytedance.com>
 <Z5fpw2uVYGP9kf18@slm.duckdns.org>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Z5fpw2uVYGP9kf18@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

On 1/28/25 4:17 AM, Tejun Heo Wrote:
> On Sat, Jan 25, 2025 at 01:25:11PM +0800, Abel Wu wrote:
>> There were efforts like b824766504e4 ("cgroup/rstat: add force idle show helper")
>> to escape from #ifdef hells, and there could be new stats coming out in
>> the future, let's clean it up once for all.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/cgroup/rstat.c | 47 ++++++++++++++++++++++++-------------------
>>   1 file changed, 26 insertions(+), 21 deletions(-)
> 
> Is this materially better? The existing code has ifdef in one place which
> the new code can't avoid. 

Indeed, # of ifdefs will stay unchanged, but they will be folded
into one place inside the bstats[] array quite the same as the
definition of the struct cgroup_base_stat, which IMHO won't hurt
readability.

> The new code is more complex and has more lines.
> Does the balance get better with additions of new entries?

The line diff is 5, and 4 of them are for readability. If adding
one more field into cpu.stat, 1 or 3 lines will be added w/o or
w/ ifdef respectively, comparing to 8 or 10 lines without this
cleanup. So the balance will be better if cpu.stat extends. And
it would also be better cleanup duplicated code for each field.

Thanks,
	Abel


