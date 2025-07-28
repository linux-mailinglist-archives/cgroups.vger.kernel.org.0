Return-Path: <cgroups+bounces-8915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE46B139DC
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453403A9E83
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496725C6F1;
	Mon, 28 Jul 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="uCncNpE5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01319202998;
	Mon, 28 Jul 2025 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702182; cv=none; b=P6uO9Vbs5tuNBms6NjTEHCGl7jMNr1fhv8+lvLNf7vVFuPwqhUTvNNnjYXbB123t9znUe27ht8XO11c4vE9Fb4wayWa/o/Sdj4Jh7mH8CzQv1FG4EposCB1QiCv0VipQkRjaEp9zhYkHujhgw33tYE8f6FB1QSIDENZJF4AyOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702182; c=relaxed/simple;
	bh=1G1bnuP3apPi1qJ1RU6vHZqlaWWEFA7LpVNSzrZV5r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZS9hYqbk49C2pdVgjAsLHPQEbOUxEAzh6ITOVqlHmugiAVM7GtZ32rtZpshu6bUedAMQ4kdnt4bmuvJkhgkgx9VtyWOn/8qmj6fKAb3OgnVFq4hsjC8d2TZILpj0kZPiT9w41FHlTWBBU9sBVQQQvgmh/Ykk+/jzn9QWn1vd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=uCncNpE5; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753702172; x=1754306972; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=KJKiJr+tG3FAfmMlaEVSvdKXkB/PgPhRU4B/I5SDZaA=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=uCncNpE5DBkvi37xKEm0B4brCr3ocRD9YpR8NsqYGHOp/DWBSdq7t2hBLNOH7W045BZKntLrkz22QSN9BYkBQGTe6d0h8wRA/4MiZwz6nEJthP3FmCtMKvdu9+3Y0XxOadrVV7RoK+3GILChS2HiEuOo0FKmYAH2+Xzr8QnI6R0=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507281329311901;
        Mon, 28 Jul 2025 13:29:31 +0200
Message-ID: <924a8a12-ed89-45e5-900d-6d937108ec3e@cdn77.com>
Date: Mon, 28 Jul 2025 13:29:29 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Kuniyuki Iwashima <kuniyu@google.com>,
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
References: <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
 <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
 <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
 <486bfabc-386c-4fdc-8903-d56ce207951f@cdn77.com>
 <aILTi2-iZ1ge3D8n@slm.duckdns.org>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <aILTi2-iZ1ge3D8n@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A002110.68875ED5.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/25/25 2:44 AM, Tejun Heo wrote:
> On Thu, Jul 24, 2025 at 10:43:27AM +0200, Daniel Sedlak wrote:
> ...
>> Currently, we know the following information:
>>
>> - we know when the pressure starts
>> - and we know when the pressure ends if not rearmed (start time + HZ)
>>
>>  From that, we should be able to calculate a similar triplet to the pressure
>> endpoints in the cgroups (cpu|io|memory|irq).pressure. That is, how much %
>> of time on average was spent under pressure for avg10, avg60, avg300 i.e.
>> average pressure over the past 10 seconds, 60 seconds, and 300 seconds,
>> respectively. (+ total time spent under pressure)
> 
> Let's just add the cumulative duration that socket pressure was present.
> 
> Thanks.
> 

Ok, I will send it as v4, if no other objections are made. In which 
units the duration should be? Milliseconds? It can also be microseconds, 
which are now used in (cpu|io|memory|irq).pressure files.

Thanks!
Daniel

