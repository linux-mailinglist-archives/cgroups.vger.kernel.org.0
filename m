Return-Path: <cgroups+bounces-10791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB2BE09C2
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 22:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2937F4E6CEB
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4A29B204;
	Wed, 15 Oct 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r5NurIyW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDF28A3F2;
	Wed, 15 Oct 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559471; cv=none; b=jLsCD6U49GYbd/JpIj92P1alqCnSOR0PadOXa4UGYW6b65CqOD1rFNqTuD8tq18RccTQZjXLzLgEM6N+zfhTFVHW+dTJUoA5hdlZ1mtOCoGEd/wIHqv2saJ5kI0CcuM5vJ6kr4OLupDwbxQqMzMHLqiKL72KEPzW7CWCPhFVS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559471; c=relaxed/simple;
	bh=AuLkftPTLJewXmjuYq/pzFJKexCaUt81R4Qe53LhJss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4pJcDja7gYsgV49Ovx8D0oplxGu5N9uwSxgWLAsg7cqqVYNjz5Fd1x2iRKd9xCkxNfZNbiwKTDre0IH+9it4Hhc87DaNAWinydxwcVY31VUQnGG6gb74+7i8ei+DgmrCiz0EokuLVPLefENZCJxiE/CrNntMP4SR2Z3w5Gypqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r5NurIyW; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760559467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuLkftPTLJewXmjuYq/pzFJKexCaUt81R4Qe53LhJss=;
	b=r5NurIyW2RIqeEEVAE7BbOgH4HGJpRaAU2V0Wa3BgTTIyBwiZNQ7kIIxqvLqZQu55aTfC1
	TSKyn1N1LR6f9uybzu/QC5UZAbVVciFtrS22W8NXdlMy3kAVc0oiPzSwpZyvvEPbbHhpSY
	qBD0JvnDagVDf/nKfUd6umK087STJ4Q=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  Daniel Sedlak
 <daniel.sedlak@cdn77.com>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jonathan
 Corbet <corbet@lwn.net>,  Neal Cardwell <ncardwell@google.com>,  David
 Ahern <dsahern@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Yosry Ahmed <yosry.ahmed@linux.dev>,  linux-mm@kvack.org,
  netdev@vger.kernel.org,  Johannes Weiner <hannes@cmpxchg.org>,  Michal
 Hocko <mhocko@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  cgroups@vger.kernel.org,  Tejun Heo <tj@kernel.org>,  Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD?=
 <mkoutny@suse.com>,  Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
In-Reply-To: <CAAVpQUCNV96vOReAeVHpwbUg9XJDLRTkHmcABh9dhm=f8p5O+g@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Wed, 15 Oct 2025 11:58:23 -0700")
References: <87qzvdqkyh.fsf@linux.dev>
	<13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
	<87o6qgnl9w.fsf@linux.dev>
	<tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
	<87a5205544.fsf@linux.dev>
	<qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
	<875xcn526v.fsf@linux.dev>
	<89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
	<6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
	<CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com>
	<cfoc35cqn7sa63w6kufwvq7rs6s7xiivfbmr752h4rmur4demz@d7joq6oho6qc>
	<CAAVpQUCNV96vOReAeVHpwbUg9XJDLRTkHmcABh9dhm=f8p5O+g@mail.gmail.com>
Date: Wed, 15 Oct 2025 13:17:36 -0700
Message-ID: <87a51rapi7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
>>
>> On Wed, Oct 15, 2025 at 11:21:17AM -0700, Kuniyuki Iwashima wrote:
>> > On Tue, Oct 14, 2025 at 1:33=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
>> > >
>> > > On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
>> > > [...]
>> > > > > > > > How about we track the actions taken by the callers of
>> > > > > > > > mem_cgroup_sk_under_memory_pressure()? Basically if networ=
k stack
>> > > > > > > > reduces the buffer size or whatever the other actions it m=
ay take when
>> > > > > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking th=
ose actions
>> > > > > > > > is what I think is needed here, at least for the debugging=
 use-case.
>> > > >
>> > > > I am not against it, but I feel that conveying those tracked actio=
ns (or how
>> > > > to represent them) to the user will be much harder. Are there alre=
ady
>> > > > existing APIs to push this information to the user?
>> > > >
>> > >
>> > > I discussed with Wei Wang and she suggested we should start tracking=
 the
>> > > calls to tcp_adjust_rcv_ssthresh() first. So, something like the
>> > > following. I would like feedback frm networking folks as well:
>> >
>> > I think we could simply put memcg_memory_event() in
>> > mem_cgroup_sk_under_memory_pressure() when it returns
>> > true.
>> >
>> > Other than tcp_adjust_rcv_ssthresh(), if tcp_under_memory_pressure()
>> > returns true, it indicates something bad will happen, failure to expand
>> > rcvbuf and sndbuf, need to prune out-of-order queue more aggressively,
>> > FIN deferred to a retransmitted packet.
>> >
>> > Also, we could cover mptcp and sctp too.
>> >
>>
>> I wanted to start simple and focus on one specific action but I am open
>> to other actins as well. Do we want a generic network throttled metric
>> or do we want different metric for different action? At the moment I
>> think for memcg, a single metric would be sufficient and then we can
>> have tracepoints for more fine grained debugging.
>
> I agree that a single metric would be enough if it can signal
> something bad is happening as a first step, then we can take
> further action with tracepoint, bpftrace, whatever.

+1 to a single metric

