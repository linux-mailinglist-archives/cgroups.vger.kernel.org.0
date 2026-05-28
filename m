Return-Path: <cgroups+bounces-16384-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPwmE5f9F2oTYQgAu9opvQ
	(envelope-from <cgroups+bounces-16384-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 10:32:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4135EE9F4
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D54F30276A5
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFA378D9B;
	Thu, 28 May 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ErYCF8Mx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0B3254A2
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956848; cv=none; b=GZkZ5FoFzuOadTToiOukimc3U768u980Etkxp8yINhmyFM4QcA9Vf03fLNCnTlRhOVZt9SVHXFkntSXTHTpuYG1FCERqNWYnfXtDLnPLq0gYDSliDhjLWFraeaGhFlPu9+gtfcLqML1IIlFLcfkUq4/r+hQtUjISyeXR7gb8rrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956848; c=relaxed/simple;
	bh=R83Zk9MPwHlNVvAL1SqF6psKEEdQEoajydtBTiAfb5g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=M6sEY1wTJvh0X67Y/F3w0IjPbN0XFbV/zqa4rxyVu2RYFuVGj6URhj/EW/6pDnVEfPao4F+kz/jGGnlu+oLhXyW8Tne00WZirxUe3Ci7FS5+fK2cYAXMM7OWF0C3pRBtFRJCes4SXdpcoGEGTFP5GOmXYw9YZEyjtluz5RuWckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ErYCF8Mx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779956842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE5vkgdKA1jGW+pTW446oAunyXUpwHm3Ex1DLaNXHJQ=;
	b=ErYCF8MxdKKJgJ2bsChhRvd83CNLBlJQsWHOx+SWyZogRkcY9bH5Ny8445eDaQIhL/oUFl
	8W8sKYUdESXAeK/TMvkxvlL5bS/4Tp66yE/RxcSSx2K35RuksXZ33YwXhFflH1sVFt+0sx
	ngQJtc4bbMoa1pHEVEYyyAFAFjqk5YU=
Date: Thu, 28 May 2026 08:27:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <1b58d56976202f26818d31dbd0da2ecb2e2460f5@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH bpf-next v7 00/11] mm: BPF struct_ops for dynamic
 memory protection and async reclaim
To: "Michal Hocko" <mhocko@suse.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "JP
 Kobryn" <inwardvessel@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Shuah Khan" <shuah@kernel.org>,
 davem@davemloft.net, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "KP
 Singh" <kpsingh@kernel.org>, "Tao Chen" <chen.dylane@linux.dev>, "Mykyta
 Yatsenko" <yatsenko@meta.com>, "Leon Hwang" <leon.hwang@linux.dev>,
 "Anton Protopopov" <a.s.protopopov@gmail.com>, "Amery Hung"
 <ameryhung@gmail.com>, "Tobias Klauser" <tklauser@distanz.ch>, "Eyal
 Birger" <eyal.birger@gmail.com>, "Rong Tao" <rongtao@cestc.cn>, "Hao Luo"
 <haoluo@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Jeff Xu"
 <jeffxu@chromium.org>, mkoutny@suse.com, "Jan Hendrik Farr"
 <kernel@jfarr.cc>, "Christian Brauner" <brauner@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Brian Gerst" <brgerst@gmail.com>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Willem de Bruijn"
 <willemb@google.com>, "Jason Xing" <kerneljasonxing@gmail.com>, "Paul
 Chaignon" <paul.chaignon@gmail.com>, "Chen Ridong"
 <chenridong@huaweicloud.com>, "Lance Yang" <lance.yang@linux.dev>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 geliang@kernel.org, baohua@kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <ahavmbcdXDX5gNup@tiehlicka>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
 <ahavmbcdXDX5gNup@tiehlicka>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-16384-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F4135EE9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
>=20On Tue 26-05-26 10:20:00, Hui Zhu wrote:
>=20

Hi=20Michal,

> >=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  Overview:
> >  This series introduces BPF struct_ops support for the memory control=
ler,
> >  enabling userspace BPF programs to implement custom, dynamic memory
> >  management policies per cgroup. The feature allows BPF programs to h=
ook
> >  into the core reclaim and charge paths without requiring kernel
> >  modifications, providing a flexible alternative to static knobs such=
 as
> >  memory.low and memory.min.
> >=20=20
>=20>  The series enables two complementary use cases.
> >=20=20
>=20>  Dynamic memory protection: static memory protection thresholds
> >  (memory.low, memory.min) are poor fits for workloads whose actual me=
mory
> >  activity varies over time. A high-priority cgroup holding a large wo=
rking
> >  set but temporarily idle will still suppress reclaim on its siblings=
,
> >  wasting available memory. A BPF-driven approach can observe real wor=
kload
> >  activity -- page faults, charge/uncharge events -- and activate or
> >  withdraw protection dynamically.
> >=20
>=20Why the same cannot be achieved by dynamically changing protection?

Dynamically adjusting memory.low or memory.min is indeed an
option, but it has a practical drawback: in many production
environments these values are managed and pushed down by a
cluster-level orchestrator (e.g. a container runtime or resource
manager). Modifying them from a separate BPF-based agent risks
conflicts with the orchestrator's own control loop and makes the
system harder to reason about.

Beyond that, the intended use case requires rapid, short-lived
adjustments -- reacting to bursts of page faults or PSI spikes
and reverting just as quickly once the pressure subsides. Mutating
the static knobs for that purpose feels like the wrong abstraction:
the knobs express policy intent, while what we need is a transient
override that sits on top of that policy.

The hooks are therefore not meant to replace the existing limits,
but to complement them: the orchestrator continues to own
memory.low / memory.min, while a BPF program makes small, brief
corrections in response to observed runtime behavior.

>=20
>=20>=20
>=20> The test results at the end of this
> >  letter quantify the difference: in a scenario where the high-priorit=
y
> >  cgroup is idle, the BPF-controlled low-priority cgroup achieves roug=
hly
> >  37x higher throughput than with static memory.low.
> >=20=20
>=20>  Asynchronous proactive reclaim: the memcg_charged and memcg_unchar=
ged
> >  hooks, combined with the BPF workqueue mechanism and the new
> >  bpf_try_to_free_mem_cgroup_pages() kfunc, enable BPF programs to per=
form
> >  proactive background reclaim without blocking the charge path. The
> >  pattern works as follows: the memcg_charged callback tracks accumula=
ted
> >  memory usage; when usage crosses a configurable threshold, it enqueu=
es an
> >  asynchronous work item via bpf_wq_start() and returns immediately wi=
thout
> >  throttling the charging task. The workqueue callback then invokes
> >  bpf_try_to_free_mem_cgroup_pages() to reclaim pages from the target
> >  cgroup; if usage remains elevated after reclaim, the callback re-enq=
ueues
> >  itself to continue. This allows a BPF program to keep a cgroup's
> >  footprint below its hard limit (memory.max) entirely in the backgrou=
nd,
> >  avoiding the OOM killer or direct-reclaim stalls that would otherwis=
e
> >  occur.
> >=20
>=20How do you account the overall work done to the specific memcg as the
> large part of the reclaim is done from WQ context?

One approach to attribute the reclaim work accurately to the target
memcg would be to expose a kfunc that creates a kthread_worker and
attaches it to a specific cgroup. Reclaim work enqueued to that
worker would then run in a context already associated with the
target memcg, so the accounting would naturally fall to the right
cgroup without any extra bookkeeping.

The tradeoff is additional complexity: creating a per-cgroup worker
introduces resource overhead and lifecycle management concerns
(e.g. when should the worker be torn down). Whether that cost is
justified depends on how strictly the caller needs the reclaim to
be attributed.

That said, I am not certain this is the right direction yet and
would welcome your thoughts on whether this is worth pursuing, or
whether there is a simpler mechanism I am overlooking.


> Also when introducing a BPF hook please focus on describing why existin=
g
> interfaces fail to achieve what you need. For the async reclaim why it
> is not practical or feasible to use userspace driven memory reclaim.


Noted, and thank you for both points. In the next revision I will
add a dedicated section to each hook's description covering:

Why existing interfaces are insufficient. For the async reclaim
case specifically, I will explain why userspace-driven reclaim
(e.g. memory.reclaim, cgroup-aware madvise, or a dedicated
reclaim daemon) is not practical: userspace cannot react at the
granularity or latency required, and the round-trip through a
syscall or procfs write introduces overhead that defeats the
purpose of proactive reclaim.
What gap the new hook fills that cannot be closed by tuning
existing knobs.

Best,
Hui


> --=20
>=20Michal Hocko
> SUSE Labs
>

