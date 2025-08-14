Return-Path: <cgroups+bounces-9166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11043B26D46
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B7A2881F
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C91FDA89;
	Thu, 14 Aug 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXsWYLOX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398231E4BE
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191460; cv=none; b=dtGi4EvxyFgY88V+kdHs5N0TNlcRBaz/qQPzwIF4GV3DlyZUoZCCgGAqfdqGTREDz6uuuCeI8Yowax0FZSAoxPYAwNRYEHMfnKs6rV4aem8fmd1xct1bzo0BpSo46+HJlIpFew6UBkILg0htJXnz68lWxvw5eAj1f7LYMw5NpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191460; c=relaxed/simple;
	bh=dAo4ZBVGhdI3Zawy71eZfhBS7jYeb8Z7J6f/6ef9OR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DosTb0nxjceGPj8oaAIUJVDjUWJSEEXI3PVXSbi+ArZW6r4jf9RUCsjWz45HArmJMsgxECTAmgolOD+cBTS3mmYIdyGfZOwYMlMOWxz4D6JS8rarhBQCPWstj9cExGhPUkxey9NOIc2ZLgb3sQRToLc/GPpjwr4Umiuc/IJQfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXsWYLOX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 10:10:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755191446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b72U+nUww1KIINPCaJtfTVRc5RFVRFTZ9UiCYeqDFTM=;
	b=cXsWYLOXEk20ToAZj4NZeb4vbiW+anqqntunu2SZjI0Z27Wukw1bISf3JD/U8jT2xAaxyO
	fq5tGOPqHQ3QaByLt6HkqisNdCpm/3pEzcd6n1ya0V6+EN69wKb3UM4Hcki9s7sc+h3xpo
	6iYHyz9wzFN3ymO2uVI8Jg8VLgSnfbk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <23roz4za55rarfkzcz2ej6m5mqwouzjcpvnfvn37mo7jeqk2t2@somfzyl5kf5b>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
 <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
 <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
 <CAAVpQUD6hCY2FDWKVnoiQ59RmovLizTPCC+ZNqB=oyP5B4-2Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUD6hCY2FDWKVnoiQ59RmovLizTPCC+ZNqB=oyP5B4-2Aw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 09:34:01PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 13, 2025 at 5:55 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 8/13/25 1:53 PM, Shakeel Butt wrote:
> > > What I think is the right approach is to have BPF struct ops based
> > > approach with possible callback 'is this socket under pressure' or maybe
> > > 'is this socket isolated' and then you can do whatever you want in those
> > > callbacks. In this way your can follow the same approach of caching the
> > > result in kernel (lower bits of sk->sk_memcg).
> > >
> > > I am CCing bpf list to get some suggestions or concerns on this
> > > approach.
> >
> > I have quickly looked at the set. In patch 11, it sets a bit in sk->sk_memcg.
> >
> > On the bpf side, there are already cgroup bpf progs that can do bpf_setsockopt
> > on a sk, so the same can be done here. The bpf_setsockopt does not have to set
> > option/knob that is only available in the uapi in case we don't want to expose
> > this to the user space.
> >
> > The cgroup bpf prog (BPF_CGROUP_INET_SOCK_CREATE) can already be run when a
> > "inet" sock is created. This hook (i.e. attach_type) does not have access to
> > bpf_setsockopt but should be easy to add.
> 
> Okay, I will try the bpf_setsockopt() approach.
> Should I post patch 1-10 to net-next separately ?
> They are pure net material to gather memcg code under CONFIG_MEMCG.

Yes please.

