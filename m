Return-Path: <cgroups+bounces-8878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85203B0E799
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82948564FF2
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5235280;
	Wed, 23 Jul 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B4vsgDXv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A3E555;
	Wed, 23 Jul 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230569; cv=none; b=vBnnWYppNBrk8ukmrQt6KoDV0HXcfEsEFiewjVb7Ya7D0+jDPlyGqAKYDAgXvC/NcyHVoK/3/ha8PqgS1aLuoGPmhME837C1Wiab6ud9+FQNINjbQTltah7wWO5D8eLBV0PIDkLzMs4Cz7FD28Jlzq+O/cf2GKs18fkQtZXV4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230569; c=relaxed/simple;
	bh=8t4qc+1oVPIes96V6mDCFXqe004QTXFHw8Dcn/BmaOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmWZ1RVEJovzOvOCz+lsxFdEulKMIdK60khNSNeEDRbfqIYJzSl5hJf51v8W5mRTJQGlWx+JP+25eV86X8LfgLWaIPzgyAzYoUY32JSMAtn0X/uhGkEuAnLTcyyUbxy6/ORrx0yGPj008fGXlpYi2DR0+8psn8GZJsqEI+n51Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B4vsgDXv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 17:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753230552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ya/iMqP+L9J9OUdonPqQ6BajrGRFzQbsY8dxwMUGMDQ=;
	b=B4vsgDXvvTZuPekKEvlBPO/rcadIYkXZRtK1VWBTBeIq8ySKpTBHPE5nbhUJ8NveiKFnoB
	AT/Lq/U7xhSK5nAGAUh2GnfvB0/T+yUWCoT3N5eROHXYeL7yJd7UpQh2K5LOZIdKEiz7tH
	TA5ZtxEMHLFsdhPw43GKQSyLFlJfFfM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 02:59:33PM -0700, Kuniyuki Iwashima wrote:
> On Tue, Jul 22, 2025 at 12:56 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Jul 22, 2025 at 12:03:48PM -0700, Kuniyuki Iwashima wrote:
> > > On Tue, Jul 22, 2025 at 11:48 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > > > > >
> > > > > > I expect this state of jobs with different network accounting config
> > > > > > running concurrently is temporary while the migrationg from one to other
> > > > > > is happening. Please correct me if I am wrong.
> > > > >
> > > > > We need to migrate workload gradually and the system-wide config
> > > > > does not work at all.  AFAIU, there are already years of effort spent
> > > > > on the migration but it's not yet completed at Google.  So, I don't think
> > > > > the need is temporary.
> > > > >
> > > >
> > > > From what I remembered shared borg had completely moved to memcg
> > > > accounting of network memory (with sys container as an exception) years
> > > > ago. Did something change there?
> > >
> > > AFAICS, there are some workloads that opted out from memcg and
> > > consumed too much tcp memory due to tcp_mem=UINT_MAX, triggering
> > > OOM and disrupting other workloads.
> > >
> >
> > What were the reasons behind opting out? We should fix those
> > instead of a permanent opt-out option.
> >

Any response to the above?

> > > >
> > > > > >
> > > > > > My main concern with the memcg knob is that it is permanent and it
> > > > > > requires a hierarchical semantics. No need to add a permanent interface
> > > > > > for a temporary need and I don't see a clear hierarchical semantic for
> > > > > > this interface.
> > > > >
> > > > > I don't see merits of having hierarchical semantics for this knob.
> > > > > Regardless of this knob, hierarchical semantics is guaranteed
> > > > > by other knobs.  I think such semantics for this knob just complicates
> > > > > the code with no gain.
> > > > >
> > > >
> > > > Cgroup interfaces are hierarchical and we want to keep it that way.
> > > > Putting non-hierarchical interfaces just makes configuration and setup
> > > > hard to reason about.
> > >
> > > Actually, I tried that way in the initial draft version, but even if the
> > > parent's knob is 1 and child one is 0, a harmful scenario didn't come
> > > to my mind.
> > >
> >
> > It is not just about harmful scenario but more about clear semantics.
> > Check memory.zswap.writeback semantics.
> 
> zswap checks all parent cgroups when evaluating the knob, but
> this is not an option for the networking fast path as we cannot
> check them for every skb, which will degrade the performance.

That's an implementation detail and you can definitely optimize it. One
possible way might be caching the state in socket at creation time which
puts some restrictions like to change the config, workload needs to be
restarted.

> 
> Also, we don't track which sockets were created with the knob
> enabled and how many such sockets are still left under the cgroup,
> there is no way to keep options consistent throughout the hierarchy
> and no need to try hard to make the option pretend to be consistent
> if there's no real issue.
> 
> 
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > I am wondering if alternative approches for per-workload settings are
> > > > > > explore starting with BPF.
> > > > > >
> > > >
> > > > Any response on the above? Any alternative approaches explored?
> > >
> > > Do you mean flagging each socket by BPF at cgroup hook ?
> >
> > Not sure. Will it not be very similar to your current approach? Each
> > socket is associated with a memcg and the at the place where you need to
> > check which accounting method to use, just check that memcg setting in
> > bpf and you can cache the result in socket as well.
> 
> The socket pointer is not writable by default, thus we need to add
> a bpf helper or kfunc just for flipping a single bit.  As said, this is
> overkill, and per-memcg knob is much simpler.
> 

Your simple solution is exposing a stable permanent user facing API
which I suspect is temporary situation. Let's discuss it at the end.

> 
> >
> > >
> > > I think it's overkill and we don't need such finer granularity.
> > >
> > > Also it sounds way too hacky to use BPF to correct the weird
> > > behaviour from day0.
> >
> > What weird behavior? Two accounting mechanisms. Yes I agree but memcgs
> > with different accounting mechanisms concurrently is also weird.
> 
> Not that weird given the root cgroup does not allocate sk->sk_memcg
> and are subject to the global tcp memory accounting.  We already have
> a mixed set of memcgs.

Running workloads in root cgroup is not normal and comes with a warning
of no isolation provided.

I looked at the patch again to understand the modes you are introducing.
Initially, I thought the series introduced multiple modes, including an
option to exclude network memory from memcg accounting. However, if I
understand correctly, that is not the case—the opt-out applies only to
the global TCP/UDP accounting. That’s a relief, and I apologize for the
misunderstanding.

If I’m correct, you need a way to exclude a workload from the global
TCP/UDP accounting, and currently, memcg serves as a convenient
abstraction for the workload. Please let me know if I misunderstood.

Now memcg is one way to represent the workload. Another more natural, at
least to me, is the core cgroup. Basically cgroup.something interface.
BPF is yet another option.

To me cgroup seems preferrable but let's see what other memcg & cgroup
folks think. Also note that for cgroup and memcg the interface will need
to be hierarchical.

