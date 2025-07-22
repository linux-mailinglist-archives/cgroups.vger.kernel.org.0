Return-Path: <cgroups+bounces-8819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA7B0D2FD
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F5216595E
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE312BE637;
	Tue, 22 Jul 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="pC+ynV3W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3128C00C;
	Tue, 22 Jul 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169230; cv=none; b=rgCxLccyP7Uqja9+gxRK1Bah3Pj7KPQd6imGSWpMiK1of8VNG3v6sun30HY1Ywvjt709xR8rmgOzJkF6OHNIt3ycy5Kl5i9D+dCAh3VjB+UIq9FILbS+MqoEcUSPFcXrbQ9GQNYHGI+U1v7VL4YcMIwqci5QCTpX42CvIvWNG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169230; c=relaxed/simple;
	bh=oW0fsdZpkuDnvUCPp9hj4ntdifZc1tSLSdUkaNgn7C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4DgVzUoGAIfsMdonsmyruRfCTpMF8/0lCZLl31/VDEWM5N9OZCxrvI3COQ4gF+rFWisGGBk4Wu5fyJ1ffNnef312MOQukHnSI5K/G60lZw27LJxFQPFtTAyWEPeIhOfCAZfR+bB2E6Ug6dFoyic2xJVRo+IACu3jhWcU2QryDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=pC+ynV3W; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753169223; x=1753774023; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=ugX0/5WzJEWczB5ILEP+4F4o+n6UggNVK+OdbQ/Pz+Q=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=pC+ynV3WDz3blBMgxiWi5zE0GR69FRJ8BbStpwr8yhq8Uo43covZlsXTNM333REQhI0Hf5F3EMW2WloK+B7KbJUGFcKc1A6NQ+6/Ydwu5fXkE979cUfmKkh3B3hqWzj7pNQ+sTFL5l7t8gINZ0JtUhNK6EGwFAuPYUGTQC3B13w=
Received: from [10.26.3.151] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507220927014709;
        Tue, 22 Jul 2025 09:27:01 +0200
Message-ID: <42f7889e-7f7e-4056-9d3a-424298e7df87@cdn77.com>
Date: Tue, 22 Jul 2025 09:27:01 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <CANn89i+sAgVOOoowNfqxv7+NrAa+8EzkWTVMP8LeGDJ23sFQpg@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CANn89i+sAgVOOoowNfqxv7+NrAa+8EzkWTVMP8LeGDJ23sFQpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002112.687F3D42.0054,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/22/25 9:17 AM, Eric Dumazet wrote:
> On Tue, Jul 22, 2025 at 12:12 AM Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>
>> This patch is a result of our long-standing debug sessions, where it all
>> started as "networking is slow", and TCP network throughput suddenly
>> dropped from tens of Gbps to few Mbps, and we could not see anything in
>> the kernel log or netstat counters.
>>
>> Currently, we have two memory pressure counters for TCP sockets [1],
>> which we manipulate only when the memory pressure is signalled through
>> the proto struct [2]. However, the memory pressure can also be signaled
>> through the cgroup memory subsystem, which we do not reflect in the
>> netstat counters. In the end, when the cgroup memory subsystem signals
>> that it is under pressure, we silently reduce the advertised TCP window
>> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
>> throughput reduction.
>>
>> Keep in mind that when the cgroup memory subsystem signals the socket
>> memory pressure, it affects all sockets used in that cgroup.
>>
>> This patch exposes a new file for each cgroup in sysfs which signals
>> the cgroup socket memory pressure. The file is accessible in
>> the following path.
>>
>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>>
>> The output value is an integer matching the internal semantics of the
>> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
>> representing the end of the said socket memory pressure, and once the
>> clock is re-armed it is set to jiffies + HZ.
>>
>> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
>> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
>> Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
>> Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
>> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
>> ---
>> Changes:
>> v2 -> v3:
>> - Expose the socket memory pressure on the cgroups instead of netstat
>> - Split patch
>> - Link: https://lore.kernel.org/netdev/20250714143613.42184-1-daniel.sedlak@cdn77.com/
>>
>> v1 -> v2:
>> - Add tracepoint
>> - Link: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sedlak@cdn77.com/
>>
>>
>>   mm/memcontrol.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 902da8a9c643..8e8808fb2d7a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4647,6 +4647,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>>          return nbytes;
>>   }
>>
>> +static int memory_socket_pressure_show(struct seq_file *m, void *v)
>> +{
>> +       struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>> +
>> +       seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure));
>> +
>> +       return 0;
>> +}
>> +
>>   static struct cftype memory_files[] = {
>>          {
>>                  .name = "current",
>> @@ -4718,6 +4727,11 @@ static struct cftype memory_files[] = {
>>                  .flags = CFTYPE_NS_DELEGATABLE,
>>                  .write = memory_reclaim,
>>          },
>> +       {
>> +               .name = "net.socket_pressure",
>> +               .flags = CFTYPE_NOT_ON_ROOT,
>> +               .seq_show = memory_socket_pressure_show,
>> +       },
>>          { }     /* terminate */
>>   };
>>
> 
> It seems you forgot to update Documentation/admin-guide/cgroup-v2.rst

Oops, missed that. I will add it to the v4.

Thanks!
Daniel


