Return-Path: <cgroups+bounces-6170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD76A12BD6
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE31A1886683
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048931D6DA1;
	Wed, 15 Jan 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h06KZ7Vm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009E1AAA09
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969942; cv=none; b=koRxL4xrC3bzZBZEVuIrQ/5jpLqwSDpnVmXPD2t9foeWtM+8/XL8u3nWEEsBX72CJj7ZPUI10owp7aWljTI22kLiooXGWlCigohcmINt5FvMk5D6e5roK4nQ1PHwXxxhHYYQBgp2QdwUB3XgCk9Y4bQQiQgO+PvAY9Z9rVMp5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969942; c=relaxed/simple;
	bh=Nri+ijQHgnnvw1Q+UTvOtmS15t6/cZj5z1xsRPl/cA0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YhHZCaNtHBY59RwUQywGYHSu80XaoFqnqgaOJQUq8CCvlZJSmkmQvq/U04cr+xN+MPBrM3GEN2gmhthcDPzgJXnOEL3p2L6jLSNecUi9k/tBL1Uc4rc6MhWf/fgROQ9IppKp5uKwAv47iHx6jMx6LEkv9SoV4D1nuXLQUw9Df8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h06KZ7Vm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b662090so809735ad.1
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736969940; x=1737574740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YT8LeYyl1IQE2OMUqDpDp3mQmKP3ywSVwhJGc5iz/kw=;
        b=h06KZ7Vm3EL2ZlYV03SEtPGKy+7yaYwlSALNNh2dethaWtd1Idiu5OwRvjduoilr3S
         mz9RpALbiiRy7IpBtfkt+mkUeD0ILNQiBfVAyVieGm8qawkTjrJzL4BXoQwqyF9sY5vb
         HvLiYiaJ3TPIefnlf7x1eO7G3sNjW329XtXydSoqrvFhuVZ1tRv1hjA8OlZEv8/IsLWQ
         VJ2JkpgyhcRPIQe+CZOEF+g9RQVrtoyFJG/jm4zaWGPJH6u7pko50MnR0Zzj7Zrx+qeg
         mqWzHcahlo6Re4Y6zxtzNRgGpXXDMmzRi5PkVSiBMm+QoUIff35BPojnGOWIGOtSPS88
         ZOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736969940; x=1737574740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YT8LeYyl1IQE2OMUqDpDp3mQmKP3ywSVwhJGc5iz/kw=;
        b=jXsAg/LI+ozMK5kkxY27At+hZ8ieFLffuPCsBw47qRQz8ulixdxbcGTsdQ7aqPpyB1
         ofJmeSL5bY9YR7f0LQc5yrcbEp6UGLoS0myWw+SgMIxRkCaEU8jSpjX/vWas4qJxCvQ+
         I+NkESZW6C+pXK94uOl8+VWm3IcM5DigLkWLqIs5DHHDTu62yEPkwzlAlgMpQhMBuc13
         3t+qLx+r4OJRFzDFcHzK095kmMOV7N9WrlgV/HuVaod3SWrVE13y1HdfoZorVYkwNL/Z
         MDuxWyilvfCM+2vZGWhtt1w/snn1h+58Bh0z/jfs6bCKqUkBQOf8BOgNCVt/k811cPsK
         pLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6BRmhVBokhKEya5j9b/6BHVA1gwRUr0aYQcLLN7z9uiCKfNgtYIAN0h7S8qLjA3y48v5wQg7@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLKEiJj0oOOIEdgsgvxV4vFhedpJu/RkLbP6jWi76jnoPHi6F
	eio4cPUc77RZcCaavtAFjDLXEXP7dvP3MXs/83ymFOw+fp6rHmVz
X-Gm-Gg: ASbGncvIkn75Vf/guWg8NZrheLlOWNl93G0TdebzKKQ/AxF2WiahPcL4KJ6Ekec42WL
	caR8BVUlB1bdXfEND9AAJAYFG0TTRiytIk231/pw0kf38RTXRpZa4f0Z6IwxFDPS8QT4XOjkt0f
	0y5iA1D7PM1Wu6T+ONv86FlTD+8xPrKOIuxZZEZe9VXvVffywK8AdRkeQcyBT7qki3tSCgjipnv
	qhTxLy+Yf4LbAcfHYKFJoRasCsdFZ4Ub7C+i2kVPbhSVd91sXxS61/mnULhFwN4izYNVDKSbdyq
	EDB13fN5wCgMpQ==
X-Google-Smtp-Source: AGHT+IFOKfNEni4cheEMDE4joOYaQXJ/C8N6Te9Lc9LoIuJOxFACSRD2Iq8Srr936C5fgptM1H/zEQ==
X-Received: by 2002:a17:903:1112:b0:216:138a:5956 with SMTP id d9443c01a7336-21a83f59822mr478521225ad.19.1736969940495;
        Wed, 15 Jan 2025 11:39:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:dc0e:edda:f2ff:379a? ([2620:10d:c090:500::7:7294])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21aba7sm87093735ad.113.2025.01.15.11.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 11:38:59 -0800 (PST)
Message-ID: <babbf756-48ec-47c7-91fc-895e44fb18cc@gmail.com>
Date: Wed, 15 Jan 2025 11:38:57 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
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
Content-Language: en-US
In-Reply-To: <CAJD7tkbhzWaSnMJwZJU+fdMFyXjXBAPB1yfa0tKADucU7HyxUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yosry,

On 1/14/25 5:39 PM, Yosry Ahmed wrote:
> On Tue, Jan 14, 2025 at 5:33 PM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
>> Hi Michal,
>>
>> On 1/13/25 10:25 AM, Shakeel Butt wrote:
>>> On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutný wrote:
>>>> Hello JP.
>>>>
>>>> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmail.com> wrote:
>>>>> I've been experimenting with these changes to allow for separate
>>>>> updating/flushing of cgroup stats per-subsystem.
>>>>
>>>> Nice.
>>>>
>>>>> I reached a point where this started to feel stable in my local testing, so I
>>>>> wanted to share and get feedback on this approach.
>>>>
>>>> The split is not straight-forwardly an improvement --
>>>
>>> The major improvement in my opinion is the performance isolation for
>>> stats readers i.e. cpu stats readers do not need to flush memory stats.
>>>
>>>> there's at least
>>>> higher memory footprint
>>>
>>> Yes this is indeed the case and JP, can you please give a ballmark on
>>> the memory overhead?
>>
>> Yes, the trade-off is using more memory to allow for separate trees.
>> With these patches the changes in allocated memory for the
>> cgroup_rstat_cpu instances and their associated locks are:
>> static
>>          reduced by 58%
>> dynamic
>>          increased by 344%
>>
>> The threefold increase on the dynamic side is attributed to now having 3
>> rstat trees per cgroup (1 for base stats, 1 for memory, 1 for io),
>> instead of originally just 1. The number will change if more subsystems
>> start or stop using rstat in the future. Feel free to let me know if you
>> would like to see the detailed breakdown of these values.
> 
> What is the absolute per-CPU memory usage?

This is what I calculate as the combined per-cpu usage.
before:
	one cgroup_rstat_cpu instance for every cgroup
	sizeof(cgroup_rstat_cpu) * nr_cgroups
after:
	three cgroup_rstat_cpu instances for every cgroup + updater lock for 
every subsystem plus one for base stats
	sizeof(cgroup_rstat_cpu) * 3 * nr_cgroups +
		sizeof(spinlock_t) * (CGROUP_SUBSYS_COUNT + 1)

Note that "every cgroup" includes the root cgroup. Also, 3 represents 
the number of current rstat clients: base stats, memory, and io 
(assuming all enabled).

As I'm writing this, I realize I might need to include the bpf cgroups 
as a fourth client and include this in my testing.

