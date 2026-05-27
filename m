Return-Path: <cgroups+bounces-16344-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YELfHvu5FmqLqAcAu9opvQ
	(envelope-from <cgroups+bounces-16344-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 11:31:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3E5E1D74
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB8BA300398F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F33BD657;
	Wed, 27 May 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsjTDaB0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9237AA7A
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874296; cv=none; b=GXdMGebyNHPjNQbiGXDXZpUg0gJ+1L9nrz4lVro/RZ1/SZeHq6Wx73oT/AFKTJxQ8mGlCP0ka5YgNpM8uYzeD+quXGlnSfAolhZCZCLhIIb5Q4Ua0g9H8nbOfmvIkGvSGpioNEDYtlMuWpZrpXMDIRQOnySJpOvTzNgbcysB4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874296; c=relaxed/simple;
	bh=Ucv7tb+rmrQP+8WizGjWiU6fScLBdmJqqU5mtPvlgP4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QLMwhoX6O82w72ntiypqzEX069oHVydOq7tA64dWKTpn/bMqZNtaIGs11Nr35cvpQIEgMfBo4R0yRVOf0hg6D00e7gpnkUr01vFJo4T/3eG9xEJ/K9wWSLK76/hVaHbwvopCRxEoequ2eJ+gRs1UgkElbFYBLuO0aUGksUtTEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsjTDaB0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779874291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuHmtgVXBwRM6gWFejLSgCD1TBA09WsjOdpw2obbiq8=;
	b=fsjTDaB0b5qte/WIAecQkAPIKuw6nVsSpbTIf+6BctJmOUjYfsumfoQYf78vDzLMK/tLkg
	sYJMZhqLPfJv6F3AW/vyoB54xZhJCtm5zSdmguKpEea7cU/8I/fEoI2pbaMG2IUuW4Eml/
	Q0UQQ2PfILGhwbSHJD8pIjDYJGnG6cI=
Date: Wed, 27 May 2026 09:31:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <7f440116b23fba1e20fe70fda502ad66f7dbf158@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH bpf-next v7 00/11] mm: BPF struct_ops for dynamic
 memory protection and async reclaim
To: "Usama Arif" <usama.arif@linux.dev>
Cc: "Usama Arif" <usama.arif@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Muchun Song"
 <muchun.song@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Shuah Khan" <shuah@kernel.org>,
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
In-Reply-To: <20260526134115.816081-1-usama.arif@linux.dev>
References: <20260526134115.816081-1-usama.arif@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-16344-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 99C3E5E1D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
>=20On Tue, 26 May 2026 10:20:00 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:
>=20
>=20>=20
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
...
...
...
>=20>=20=20
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
> >  occur. The selftest for this feature (patch 10/11) validates the
> >  mechanism concretely: a workload that writes and mmaps a 64 MB file =
inside
> >  a 32 MB cgroup reliably triggers memory.events "max" events without =
BPF;
> >  with the async reclaim program attached, the "max" counter does not
> >  increase at all across the same workload.
> >=20
>=20Hi Hui,
>=20
>=20Thanks for the series.
> Would it not be simpler to just have another memcg knob, something like
> memory.high_async.
> When memory usage > memory.high_async, queue a per-memcg work item that=
 calls
> try_to_free_mem_cgroup_pages() until usage drops back below some thresh=
old.
> I am not sure I see what programability aspect from bpf you need here.
>=20
>=20Thanks

Hi Usama,

That's a good question.

By introducing a new BPF kfunc bpf_try_to_free_mem_cgroup_pages,
a BPF program can flexibly control when to start and stop async
reclaim, rather than being constrained to trigger and stop based
solely on memcg usage or one or two fixed events, as with
traditional proactive reclaim interfaces.

For example, async reclaim could be triggered based on PSI, or
on the number of page faults, or even on a combination of
multiple events working together to decide both when to start
and when to stop async reclaim.

That is the motivation behind adding the BPF kfunc
bpf_try_to_free_mem_cgroup_pages in this patch set.

I admit the cover letter did not explain this well enough, and
the example code does not demonstrate this use case either. I
will address both in the next version.

Best,
Hui

>=20
>=20>=20
>=20> 08/11 selftests/bpf: Add tests for memcg_bpf_ops
> >  Adds prog_tests/memcg_ops.c covering three scenarios:
> >  memcg_charged-only throttling, below_low + memcg_charged
> >  interaction, and below_min + memcg_charged interaction. A
> >  tracepoint on memcg:count_memcg_events (PGFAULT) is used to
> >  detect memory pressure and trigger hooks accordingly.
...
...
...
> >  --=20
>=20>  2.43.0
> >
>

