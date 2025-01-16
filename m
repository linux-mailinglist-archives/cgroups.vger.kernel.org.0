Return-Path: <cgroups+bounces-6203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F391FA14190
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 19:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C22A188D57C
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD222CBDC;
	Thu, 16 Jan 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOM25RG9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7522139CFF
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051636; cv=none; b=HOyndKuIIVyxEd2H3GKPPdRkIMMQLa5gtnvuypzqa6r/VpTxVqrc2TFoB1CXjv88F5mFTGVMaqtViL1nlZVcXTtSr+pZK9VH8i7kQR09CdmthIFithPiMccBbWl0Sx1BLjI5NmZM74Xk0SSARJeob5XZUVlsmN6Zy55d+G8DExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051636; c=relaxed/simple;
	bh=kyp01jzPw7FvzAqqAHavFQsVJlA4imAchizpuu4jnAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQbu4/mcF7gqFYAzxTx77uwDgXkdjybOGBETZKJ6Rjbj3E/WZuf/F6lQqNj5+eugkLd9nf0rC/T7D5J4HaWDWQnjvlHBrWS/QPkGH+tHIxqPka8v/9kkJlh8G6eQaO03YldGKT1dscOSRL2c4ycf7Ierk05oTM7lkq/NpQ4Dmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOM25RG9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so28891985ad.2
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737051634; x=1737656434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9mGqQGdJHpgWwMiBdNaQnEkV/H58D4+6ntUtA4C2ds=;
        b=iOM25RG9PHmSPK9HYpDVNg+loocHlXC2vjRanjs9lgrpUxhSOCIPOPhGPd9UW2/mDB
         epqrum5mUiDwW5NZuZh0aV69eOvvqhWi1hRfuuZ3Qeh6TDdkshhAP1zLiek6jvi2T2ZK
         S/smMMImvfHfk3gduOlreq93LXNPX/dUAuDgCIYiaA2TJKJQKrtY3J4C3SR584Bu5Ey3
         DBgk8tDt+6p4Hh2XaujHjdQtPvOIJVA87C/AnSAYzBwhx8r1DVTzB4kSNcA8vhbFqjcv
         4PXLBDb7QCSP74ot9tMvweBqp+vnaL046W8dzhN3AC8czGmTD6XCNkZTdjO/g+mGUGYt
         uW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051634; x=1737656434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9mGqQGdJHpgWwMiBdNaQnEkV/H58D4+6ntUtA4C2ds=;
        b=BNqRqxEDlRLyt85VHg4pJMdu9L5qhZ6iGW3vXV5Md9mkcb6BRPZR3LnMt8KFo+xcIO
         OzecmDOulh5voEUt1JXhB3lbCIoq+4ckZtnpnHNmg4oUw5XddtEbnnL4VBqYIBg/3c9j
         7AlfppnNSow7JEqoKZQccA44mBEsypjKCxqEYhyZBzXCxDDseIx1pAUxlfvJinp3/tcr
         rFTks9NJRII4FGXkaS9Bc49i81cBr3P8XhQkX9sW0eIbLq9kxZVu6V5SS0/wm7Onzyb3
         OChwSjFn/6P8F5woCDR5ccdebPDr0b4f4ID6Hpj55j+T+whwPUzQZdseWLlaGZ/sF/2z
         e3pg==
X-Forwarded-Encrypted: i=1; AJvYcCVrmAZfygk6TSBQ1TJ4j1nbke0KJtFxLT/U8RfN77baXOKHqqxhFsNXeN3BZXdusAxxH8FmFlEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlpsacIP21rw+945RK2hr5K+c+3RG+FL3X9wRcSlkvTd2rN5j
	xDfVgEZg4U046MmL/nkWlf5BHP96PK2EQHJ2hjiz9zwNgmjCbgTE
X-Gm-Gg: ASbGncvwPg17KOS0uBJxGYZYiMGlasqzlCyDZ2KC2WlNRvSjvAvW0kG1u0ROIG2JjAW
	nSIpJdzlU1S/BnoQVD6YvR7a2RpzztLShtWuc50Ff7XK868TItXvUP2YA8B8UEAi99IDRcfTiH3
	Gcy6nClvmpGJYFOPbur6LCqdmO3LYrLl2rPyy2RdYnlPn6ezIouncBU3zbTHhZbboulO19LR9hp
	irHjYWo/nQWQ0c3noNEqpAkaLB3PsgvW3TW/g2IYFMvVtnFcRNRbnHFAuclua4uiwwFBh5uYGYB
	5zk+6aKNmkZ2G4yKwLO+yutWgYQ=
X-Google-Smtp-Source: AGHT+IFHOx+zZgnYlRSi9+hTWBf4f17opgxm3PUVAuG5JYwdzZ7+IPOnNDQPIl3IG8aXjvFhQeycWw==
X-Received: by 2002:a05:6a00:124a:b0:725:f376:f4ff with SMTP id d2e1a72fcca58-72d21f7bc52mr29015885b3a.13.1737051633910;
        Thu, 16 Jan 2025 10:20:33 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:583f:3b88:2f88:a4d8? ([2620:10d:c090:500::5:a19b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba44453sm293830b3a.127.2025.01.16.10.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 10:20:32 -0800 (PST)
Message-ID: <3c078729-7455-4b7c-818f-bb8d293c00ec@gmail.com>
Date: Thu, 16 Jan 2025 10:20:30 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
 <3348742b-4e49-44c1-b447-b21553ff704a@gmail.com>
 <CAJD7tkbhzWaSnMJwZJU+fdMFyXjXBAPB1yfa0tKADucU7HyxUQ@mail.gmail.com>
 <babbf756-48ec-47c7-91fc-895e44fb18cc@gmail.com>
 <CAJD7tkZAc_ZBpUL2+X6zjBCQxU+EHjQy+jZMDg5C8XTT5vXm=w@mail.gmail.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CAJD7tkZAc_ZBpUL2+X6zjBCQxU+EHjQy+jZMDg5C8XTT5vXm=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/15/25 1:36 PM, Yosry Ahmed wrote:
> On Wed, Jan 15, 2025 at 11:39 AM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
>> Hi Yosry,
>>
>> On 1/14/25 5:39 PM, Yosry Ahmed wrote:
>>> On Tue, Jan 14, 2025 at 5:33 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>>>
>>>> Hi Michal,
>>>>
>>>> On 1/13/25 10:25 AM, Shakeel Butt wrote:
>>>>> On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutný wrote:
>>>>>> Hello JP.
>>>>>>
>>>>>> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmail.com> wrote:
>>>>>>> I've been experimenting with these changes to allow for separate
>>>>>>> updating/flushing of cgroup stats per-subsystem.
>>>>>>
>>>>>> Nice.
>>>>>>
>>>>>>> I reached a point where this started to feel stable in my local testing, so I
>>>>>>> wanted to share and get feedback on this approach.
>>>>>>
>>>>>> The split is not straight-forwardly an improvement --
>>>>>
>>>>> The major improvement in my opinion is the performance isolation for
>>>>> stats readers i.e. cpu stats readers do not need to flush memory stats.
>>>>>
>>>>>> there's at least
>>>>>> higher memory footprint
>>>>>
>>>>> Yes this is indeed the case and JP, can you please give a ballmark on
>>>>> the memory overhead?
>>>>
>>>> Yes, the trade-off is using more memory to allow for separate trees.
>>>> With these patches the changes in allocated memory for the
>>>> cgroup_rstat_cpu instances and their associated locks are:
>>>> static
>>>>           reduced by 58%
>>>> dynamic
>>>>           increased by 344%
>>>>
>>>> The threefold increase on the dynamic side is attributed to now having 3
>>>> rstat trees per cgroup (1 for base stats, 1 for memory, 1 for io),
>>>> instead of originally just 1. The number will change if more subsystems
>>>> start or stop using rstat in the future. Feel free to let me know if you
>>>> would like to see the detailed breakdown of these values.
>>>
>>> What is the absolute per-CPU memory usage?
>>
>> This is what I calculate as the combined per-cpu usage.
>> before:
>>          one cgroup_rstat_cpu instance for every cgroup
>>          sizeof(cgroup_rstat_cpu) * nr_cgroups
>> after:
>>          three cgroup_rstat_cpu instances for every cgroup + updater lock for
>> every subsystem plus one for base stats
>>          sizeof(cgroup_rstat_cpu) * 3 * nr_cgroups +
>>                  sizeof(spinlock_t) * (CGROUP_SUBSYS_COUNT + 1)
>>
>> Note that "every cgroup" includes the root cgroup. Also, 3 represents
>> the number of current rstat clients: base stats, memory, and io
>> (assuming all enabled).
> 
> On a config I have at hand sizeof(cgroup_rstat_cpu) is 160 bytes.
> Ignoring the spinlock for a second because it doesn't scale with
> cgroups, that'd be an extra 320 * nr_cgroups * nr_cpus bytes. On a
> moderately large machine with 256 CPUs and 100 cgroups for example
> that's ~8MB.
> 

Revisiting the cgroup_rstat_cpu struct, there might be an opportunity to 
save some memory here. This struct has several cgroup_base_stat fields 
that are not useful to the actual subsystems (memory, io). So I'm 
considering a scenario where the existing cgroup_rstat_cpu is used for 
the base stats while a new lighter struct is used for others that 
maintains compatibility with the rstat infrastructure.

>>
>> As I'm writing this, I realize I might need to include the bpf cgroups
>> as a fourth client and include this in my testing.


