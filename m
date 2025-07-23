Return-Path: <cgroups+bounces-8896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F5B0EDE0
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 10:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA62A965931
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15F28153D;
	Wed, 23 Jul 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="aYZzS/O3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55242281508;
	Wed, 23 Jul 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261098; cv=none; b=r41oSI5enu9/ieeSIWYWgIjTgjLcNbScYJE/2KmAv7XZ9AT7Mwn1nOAss17FRa7elAdYUEg3kAa+PSLW2yOgs0djEVJWrmHpLipH1KrI0dIPx/3hxB/+mxgTxckt0m1SDJ7QAlLmpnEoEIt42O5TyzEnF56RFCnfmZDIYn5+910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261098; c=relaxed/simple;
	bh=tvFD5y3cZfEGe1kEOdIbC5bPES8cwLlvohF873gZKv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK2E3LpzPfCWd95Glxsoox6zqI0qZ8tLiXDxStZdxPtKQxoeOem3hXX4zIxdDqsofYee61jO922bcS+JH7rRnCTpG1O9tyAIJ7Usz8LyhljHQmo6LspGDOhW5vEgCISp8k+rS8P1I/MIr8k7hrnVSDB+a24yY2qaPo6d+zXpM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=aYZzS/O3; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753261092; x=1753865892; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=qlvvdL23jI5cq5kK00WWJ2ZXbCbxmnFqWOhjy1ud0KM=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=aYZzS/O3GfR/K3vWLe49gCjzaBG7alC51w2ImiZpsGS1aYHJSPV7OOU7xdTJxvlrQ37+tm/yVdGPQjZ4BYwRncoiXfc/jTXXQATheYM3dRRtznNFPjEcKO8w3XqUVXJUQ0HDZOHhTbCoCumjS1QaEIoA72QUtvB3mRFfguAzfJY=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507231058116534;
        Wed, 23 Jul 2025 10:58:11 +0200
Message-ID: <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
Date: Wed, 23 Jul 2025 10:58:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
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
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002105.6880A424.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/23/25 10:38 AM, Michal Koutný wrote:
> On Tue, Jul 22, 2025 at 01:11:05PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>> 1 second is the current implementation and it can be more if the memcg
>>>> remains in memory pressure. Regarding usefullness I think the periodic
>>>> stat collectors (like cadvisor or Google's internal borglet+rumbo) would
>>>> be interested in scraping this interface.
>>>
>>> I think the cumulative counter suggested above is better at least.
>>
>> It is tied to the underlying implementation. If we decide to use, for
>> example, PSI in future, what should this interface show?
> 
> Actually, if it was exposed as cummulative time under pressure (not
> cummulative events), that's quite similar to PSI.

I think overall the cumulative counter is better than just signaling 1 
or 0, but it lacks the time information (if not scraped periodically). 
In addition, it may oscillate between under_pressure=true/false rather 
quickly so the cumulative counter would catch this.

To me, introducing the new PSI for sockets (like for CPU, IO, memory), 
would be slightly better than cumulative counter because PSI can have 
the timing information without frequent periodic scrapes. So it may help 
with live debugs.

However, if we were to just add a new counter to the memory.stat in each 
cgroup, then it would be easier to do so?

