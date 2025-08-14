Return-Path: <cgroups+bounces-9153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093DB25899
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809DF9A1228
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F6013B7AE;
	Thu, 14 Aug 2025 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6HQjTqi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F7182B4
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132904; cv=none; b=aVdbofvFQWnVQPmOkQgi4YoIpsXojLA04By/49uprxJd93BWn6jeDp59YuT4KY4tFhlV9WN/LYA4udq3l/H9Ms+xaPHka9N1So6ADzkRujy1FUcWLFYA01LYm09igk/Z9DX7ImWlEhKuab29OqdbloKZMrPRSQLJ6Ko/oZoaI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132904; c=relaxed/simple;
	bh=JydQgnfv1smbfa7kiZsNg0dRzfJLvvk2h3GZdX1R0Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMgkfSApznE0b5B3YZum5dCF7E76jFBoJQN5MiK1cgdMXhN+ArlHfYJ8KGkLnLKZqxXsiCm1DFIHckWfmM2USxkHZUtb8IBBiWyc36EWo1yTRT/az7bDBALycCn+TBz/7wX53/S7J4AwJNbRWBBGSCWZgGi/x2sjgVmqV48o2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6HQjTqi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755132890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdHhV4i8i+lWGHS2gl9FLlu2TgUgJbbs4bD/Zxld7c4=;
	b=j6HQjTqifsSO2Uppl1+E8juWlz85WB6Puvvo38zR0af1UA37Dw9SimZLmZuB9dm1eOcmBg
	ClajNZt92ETnf/J4hcXbQq43iGyGJsz35Oj+8z3oHgpyWVoPyIp+xlvpV5UK78DWgLMmi1
	7Au6epSZeq1y5zb1TVkFgVNw6Q6r0ZU=
Date: Wed, 13 Aug 2025 17:54:43 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
 Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
 <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/13/25 1:53 PM, Shakeel Butt wrote:
> What I think is the right approach is to have BPF struct ops based
> approach with possible callback 'is this socket under pressure' or maybe
> 'is this socket isolated' and then you can do whatever you want in those
> callbacks. In this way your can follow the same approach of caching the
> result in kernel (lower bits of sk->sk_memcg).
> 
> I am CCing bpf list to get some suggestions or concerns on this
> approach.

I have quickly looked at the set. In patch 11, it sets a bit in sk->sk_memcg.

On the bpf side, there are already cgroup bpf progs that can do bpf_setsockopt 
on a sk, so the same can be done here. The bpf_setsockopt does not have to set 
option/knob that is only available in the uapi in case we don't want to expose 
this to the user space.

The cgroup bpf prog (BPF_CGROUP_INET_SOCK_CREATE) can already be run when a 
"inet" sock is created. This hook (i.e. attach_type) does not have access to 
bpf_setsockopt but should be easy to add.

For more comprehensive mem charge policy that needs new bpf hook, that probably 
will need struct_ops instead of another cgroup attach_type but that will be 
implementation details.

