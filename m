Return-Path: <cgroups+bounces-8900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC0B104EE
	for <lists+cgroups@lfdr.de>; Thu, 24 Jul 2025 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4741A4E6518
	for <lists+cgroups@lfdr.de>; Thu, 24 Jul 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B276038;
	Thu, 24 Jul 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="GwYRcO66"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B274B40;
	Thu, 24 Jul 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346623; cv=none; b=eFv5UlLmA28ZLEh049e9mN/477ftPxW0NQ1b+4tIe0jcRHAYzgzPKl5cquJs7BAEXReLmQa62tgv3BE2pX17bEaNp2UBOWKQQXbSAjh68eOLHlmi6JtcvX0jR4EUXXhMmeQlEqD1gatObhq782/cN6ULvjlhap04NyT8dqwMQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346623; c=relaxed/simple;
	bh=f+MsmcuN4DSIn4FJTvrs6j24moPNmKKQrzDBANMkoHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bltDQetg41N709YSg6O0Wn9B0+9i7XzCHF7rwKDtgg+ktQ34+vBQHkQphdBIbW3mvMj0N9kG1lhsneLJkyCPEcItXWWMMqZUpoLvNn5X30oSYYWDMf1W8hs0+GEMwXhY0gnZ+5+afvdN/g8+Xx+4zE4vZrw1GQOKWoy7tf1IjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=GwYRcO66; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753346609; x=1753951409; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=geAcx1eFOfV1oq+qHzGfEHmoIVgBNQw8Y2UCNcB7q8Y=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=GwYRcO66cYM17QJ4JfNy0O/lJ4eIaR1dF/xVS4Df72l/0VV5LUIGJ67WQAn4K897TWePZsM5FjR8godG4FWcl/J//z+Y7632b7H/0WFzwpcPYDHs1c6Jr7gmqwEz45lZdBxIvkBDBUoycdVmzZgdcTTou7SkJE7AqA484NoN33Q=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507241043284798;
        Thu, 24 Jul 2025 10:43:28 +0200
Message-ID: <486bfabc-386c-4fdc-8903-d56ce207951f@cdn77.com>
Date: Thu, 24 Jul 2025 10:43:27 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
 <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
 <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A00210E.6881F1B5.00A4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/23/25 7:54 PM, Shakeel Butt wrote:
>>
>> To me, introducing the new PSI for sockets (like for CPU, IO, memory), would
>> be slightly better than cumulative counter because PSI can have the timing
>> information without frequent periodic scrapes. So it may help with live
>> debugs.
> 
> How would this PSI for sockets work? What would be the entry and exit
> points?
> 
Currently, we know the following information:

- we know when the pressure starts
- and we know when the pressure ends if not rearmed (start time + HZ)

 From that, we should be able to calculate a similar triplet to the 
pressure endpoints in the cgroups (cpu|io|memory|irq).pressure. That is, 
how much % of time on average was spent under pressure for avg10, avg60, 
avg300 i.e. average pressure over the past 10 seconds, 60 seconds, and 
300 seconds, respectively. (+ total time spent under pressure)

For example, if we had pressure for 5 seconds straight, then the output 
of socket.pressure could be:

	full avg10=50.00 avg60=8.33 avg300=1.66 total=77777

Do you think this would be feasible? If so, I can try to send it as v4.

Thanks!
Daniel

