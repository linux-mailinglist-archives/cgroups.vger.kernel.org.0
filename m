Return-Path: <cgroups+bounces-9017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A1B1D5BB
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891017AFA70
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285E22DFBA;
	Thu,  7 Aug 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="7OrwcfrK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D755145329;
	Thu,  7 Aug 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562137; cv=none; b=bA9tvPwXJfCVe3afoPYOGMFarRY2q27jlmS0M508j2/JirvrIEikwRWBSzcFRpQFgi9Mn4E7lXij0OGMKKBTN3h+CLEIfoZU6NmhbRkiuCgoQkp8lAFY04dPLWGSP8UYCkM7kOZIFUm3VT/bVpzggVyCzZvxPxLWEnRMd1KkIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562137; c=relaxed/simple;
	bh=XKJfQp0qgtOPO/tDYguu/9W0tHefgC09tDUtsbJX3Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UagMXNDxr6ty9PYHfBTSPs2oI0chIR2SduliUYx7TacY5sd/QPpkmVy7XitUnfJdNq/bGqZ6c93m0TEMdLf8Mn6Usa/MxbAZ2NcnS2r4V1F49G+WlcDAY/MKbsAYa9H9Zsvuah+xCPVkJ6l6Jc7I4e4PH3DmL5IliDHFblRDA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=7OrwcfrK; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1754562125; x=1755166925; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=UA01ZK7YVnyKFfoAYOxQGgqOGupBnkexzr8LbdxiehY=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=7OrwcfrKJV0FeENW6OBLqjmfQFZVrhBSb/hdRQXsWdHAjQ3H9fAQIWbf6piwCvXzs+lmG7wRAqW8Wx76B/mahwB9XlVVP0zFRuMWkxyQmYss2BxRsbS0avNG/TF5m4SFxZkHEIPnxUPgbkpLvpWsaffyaOlUzO1zO5k2XJZVFCY=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508071222029266;
        Thu, 07 Aug 2025 12:22:02 +0200
Message-ID: <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
Date: Thu, 7 Aug 2025 12:22:01 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A00210F.68947DBB.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 8/7/25 1:34 AM, Shakeel Butt wrote:
> On Wed, Aug 06, 2025 at 03:01:44PM -0700, Kuniyuki Iwashima wrote:
>> On Wed, Aug 6, 2025 at 2:54 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>> On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
>>>>>> -                     WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
>>>>>> +                     socket_pressure = jiffies + HZ;
>>>>>> +
>>>>>> +                     jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
>>>>>> +                     memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);
>>>>>
>>>>> KCSAN will complain about this. I think we can use atomic_long_add() and
>>>>> don't need the one with strict ordering.

Thanks for the KCSAN recommendation, I didn't know about this sanitizer.

>>>>
>>>> Assuming from atomic_ that vmpressure() could be called concurrently
>>>> for the same memcg, should we protect socket_pressure and duration
>>>> within the same lock instead of mixing WRITE/READ_ONCE() and
>>>> atomic?  Otherwise jiffies_diff could be incorrect (the error is smaller
>>>> than HZ though).
>>>>
>>>
>>> Yeah good point. Also this field needs to be hierarchical. So, with lock
>>> something like following is needed:

Thanks for the snippet, will incorporate it.

>>>
>>>          if (!spin_trylock(memcg->net_pressure_lock))
>>>                  return;
>>>
>>>          socket_pressure = jiffies + HZ;
>>>          diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
>>
>> READ_ONCE() should be unnecessary here.
>>
>>>
>>>          if (diff) {
>>>                  WRITE_ONCE(memcg->socket_pressure, socket_pressure);
>>>                  // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
>>>                  // OR
>>>                  // while (memcg) {
>>>                  //      memcg->sk_pressure_duration += diff;
>>>                  //      memcg = parent_mem_cgroup(memcg);
>>
>> The parents' sk_pressure_duration is not protected by the lock
>> taken by trylock.  Maybe we need another global mutex if we want
>> the hierarchy ?
> 
> We don't really need lock protection for sk_pressure_duration. The lock

By this you mean that we don't need the possible new global lock or the 
local memcg->net_pressure_lock?

> is only giving us consistent value of diff. Once we have computed the
> diff, we can add it to sk_pressure_duration of a memcg and all of its
> ancestor without lock.

Thanks!
Daniel


