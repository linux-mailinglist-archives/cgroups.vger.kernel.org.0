Return-Path: <cgroups+bounces-8895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59968B0ED76
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AA816E066
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAC28000C;
	Wed, 23 Jul 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="BR7ahQgq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4990248F4D;
	Wed, 23 Jul 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260102; cv=none; b=AOKatES4cELLHPC6bvxFr8NKbJR8p5Ss/HWLgJrjKDjKbAD3E83kXtlC7GYf35hO2VKj+OzoQNkdNmYebh+/+jN6S5xuomL8Vb7iaB+Mt0x0Km+veJLDBB4UN3tX3dTVIp7c3gYL9iN+9ZvXz+wdfZbpahvCofptASW6VHl/uek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260102; c=relaxed/simple;
	bh=Fiz5/RmNLboPKQ//AZin06j5TZgW8T/C51Hwp6nezps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3CS3rHtgRluUb22XnOA/nfTyoWXbf2KQ9iDIvLEHYNagqLYtrJLj3QGRt3ZKgvOLedJDkTT2Sce2laA1FohQRi2vPqw3scHwfuZZpgLWlPNW1mqY2CL9I6WdRTeA4OKnIuXh/2l047ZNowhGN15XBYSIhp7YktvWAjkbzMAFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=BR7ahQgq; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753260092; x=1753864892; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=Y7eCUOWke4mAzQtpD5jhgOmBpiDVIy3hPcFQXQYgQgc=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=BR7ahQgqu5jB0ylvabvi4zREjcqEqtUDjpslN0Pv3tRrLJNBX9OpvjPjghki2fSxvbakWXxu85HlBksvmrIOdNzs/RzqY+RupdFNNdrziFO3ZwB2r/1Q/GDckKS6rHWATPjKqAfoeV8hpIA5HcL9PMoDrJQly8IOBPZW6o0AQOM=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507231041312250;
        Wed, 23 Jul 2025 10:41:31 +0200
Message-ID: <01ab2653-dbff-4a3f-ac91-f3f21a06dd2e@cdn77.com>
Date: Wed, 23 Jul 2025 10:41:30 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A00211C.6880A03E.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/22/25 9:05 PM, Shakeel Butt wrote:
> On Tue, Jul 22, 2025 at 11:27:39AM -0700, Kuniyuki Iwashima wrote:
>> On Tue, Jul 22, 2025 at 10:50 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutný wrote:
>>>> Hello Daniel.
>>>>
>>>> On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>>>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>>>>>
>>>>> The output value is an integer matching the internal semantics of the
>>>>> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
>>>>> representing the end of the said socket memory pressure, and once the
>>>>> clock is re-armed it is set to jiffies + HZ.
>>>>
>>>> I don't find it ideal to expose this value in its raw form that is
>>>> rather an implementation detail.
>>>>
>>>> IIUC, the information is possibly valid only during one jiffy interval.
>>>> How would be the userspace consuming this?
>>>>
>>>> I'd consider exposing this as a cummulative counter in memory.stat for
>>>> simplicity (or possibly cummulative time spent in the pressure
>>>> condition).
>>>>
>>>> Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
>>>> thought it's kind of legacy.
>>>
>>>
>>> Yes vmpressure is legacy and we should not expose raw underlying number
>>> to the userspace. How about just 0 or 1 and use
>>> mem_cgroup_under_socket_pressure() underlying? In future if we change
>>> the underlying implementation, the output of this interface should be
>>> consistent.
>>
>> But this is available only for 1 second, and it will not be useful
>> except for live debugging ?
> 
> 1 second is the current implementation and it can be more if the memcg
> remains in memory pressure.

In our production environment, when this so-called pressure happens, it 
typically stays under pressure for a few hours straight. So, in our 
scenario, even a 1 or 0 would be helpful since it does not oscillate.



