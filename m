Return-Path: <cgroups+bounces-17573-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h0+aK76QTWr62AEAu9opvQ
	(envelope-from <cgroups+bounces-17573-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 01:50:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC517207E8
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 01:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b7yS9Nqv;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17573-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17573-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98B61303FBBA
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 23:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F7395276;
	Tue,  7 Jul 2026 23:50:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CFC31A55E
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 23:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468216; cv=none; b=IyswQzieMGOyidITy6Osa2zrSrRRT5Ymz7MdCQDEbJmo8Fp9lQoMAcMmWky3th52PjDKUstb0xTrvwdlFiZV9xY2TKjFXHlTIGjuBFNChAe9mrDZy0Mnl1Vm/wWenERCo3drkHrvsibWVTFFt4aDgZXWr0dpmDjwJQZz1xslC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468216; c=relaxed/simple;
	bh=1M3v9ZAKeTOtwfF2kbO3O3vUSC1SJ1Oe8/V8bBAYYxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+555FxwGyqQgilTopoYIX2AZ9Y277CFMbvymTdliLO+txhfjQgNb5Gg+sa4fmtKPgCzPq/tOr6Eh0+/a88CXhycU9tizGaT+pxr5TtCIBTRyt0EkqVLN/CHF4p2nSR67B68h7cy8S5+WIjBk64JFfhfPCOl15Px+gNV2Y7DnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7yS9Nqv; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so20305a12.3
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 16:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783468214; x=1784073014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jR5FDbXPbDj7uRWgGm0G3zwUJBd3PGR+m1Sli1Axe2k=;
        b=b7yS9Nqv9WFf/NGmx5gV8UzW/6Wbq+tVsK3utgmh18x3hS9I7L9ZOvwarJn90ekpdU
         FI5EzolXevApwgqVAzzaV9Yhgir0C9L+Pwmw69nREu0XFiodzWPbolJ8UmoA0BQT4mVP
         gx1qFyiOFWK2jTkcmM4ap7ID10hO/r0HaBL2tg7pEoeBnN5dAFXxYbOdCb58oQEYCzw4
         YdkZ15d26CEZ62NHdvNq/L/LaXn34TWNlJG3/alnTvQPZldcy9/2sUhVykIvGeO10Qgi
         E70uTgyxLnDsNjTowq1yv3W/NWphMuCpUvdZFOl6vLSDzwfDgiNJrZ9kjhE+LUa6v6/c
         2diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783468214; x=1784073014;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jR5FDbXPbDj7uRWgGm0G3zwUJBd3PGR+m1Sli1Axe2k=;
        b=DKTYzf/VN6SWvqPyIE+fPb++PhjYQQ10kyTGNRfCBLmEi23NHH9iqcuS16aP6Oadvd
         jxGYG080W2NQEiX91YlJDTP1pFh0rkkqNAUTyPYSwNOnOztPXlptZ38sKHkyVKsPIzYA
         v1BzqBGYym/AaJNpJmA2pw3CqUBmL6O/pdPaJSEXP8FwR7SEUFTuk8jS9ijoNZaX+NmA
         RZI5ajnNR+QrLqRoMw6xf3Q43aU0QtBpdO70tGOpwTAWSnfZ7dhue/EndzxWC1LzA/Qd
         mmcUHRykXupxqtkHzJDwa7ybiHz5ShjBvE6l/brefKQ/Y6U6fAFC0OMDS3PSJUXE54yB
         eZiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjYJePEnlozdzh8BOdOAQ7aT3nUX0SCQGW+4EHCU9bWLVXeY+QSWerRMkJy69yEWnZS6UlrkrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QIb9V2LxJrVTQfHqJTYWFlaXLqLgXNax8nXFkS9on0REt4pD
	MRIGc1sRR2TqGl/pf1/AmFs/WIS29w60Z/QrDUucQtvbCqFcNBhWn0dz
X-Gm-Gg: AfdE7cnxoStmkvILuUNMkKjyXSYpqj70l7wwVjcve6cZxziSqiy5Vigeyt4rOI4nOBq
	btvdTVgt2pDO1AaA7iTAZ1BNT7XFe0jDp3xiznCupJFEDwj8TgLVd+aHgeGOhXu3qQ1v0WDS2rk
	wnh04G+h2qgVeSbTLYpKalPCojPTGOEj4jnfShpWcofBWxdAZzALgS9CEVd4FKcxdsw4wohtbX6
	8YQUey9noqZCgebQ8s7jUDVkDRI0YE2r7yEu6xzL7x4pgjEYHoilZLaUQjpjUHbVVj3oKtwj+fM
	lXqyhVfKPmaUm9KWOsZT5z1zApdT9UdieL2xDqu/AUl+sYr7CXmA8nn6h04anMS/YqYH+Ar4o9j
	X2Y/MKoo9EtOEJaofT+7BegeS2VbdwI3y2PFWCYpIeWx/5wvLSCwxfgAnlvWq79kdz/bs6dpILW
	7W1UJgKBS6xq/n1P8dIuwV3sstCpMMN3D/RYgAYXUtfjmIRnSkf0oYw06DSHUsPNgmGzwkpw==
X-Received: by 2002:a05:6a21:3295:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c08ed13de2mr7843747637.2.1783468214356;
        Tue, 07 Jul 2026 16:50:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f2fe:14ed:44aa:14cf? ([2620:10d:c090:500::2:84e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm13083613c88.12.2026.07.07.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 16:50:13 -0700 (PDT)
Message-ID: <bc47c75a00acab57e7fea72612e0f6f089ddecc9.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ziyang Men <ziyang.meme@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
 <shuah@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	kernel-team@meta.com, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 16:50:11 -0700
In-Reply-To: <ak2LXDWoPFSJL2Q9@devvm16600.scu0.facebook.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
	 <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
	 <akxW5dzvR9e2CfGq@linux.dev>
	 <eccfd9a8dd1af1668e142b9b866194333647b0d5.camel@gmail.com>
	 <ak2LXDWoPFSJL2Q9@devvm16600.scu0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17573-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ziyang.meme@gmail.com,m:shakeel.butt@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,etsalapatis.com,meta.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CC517207E8

On Tue, 2026-07-07 at 16:27 -0700, Ziyang Men wrote:
> On Tue, Jul 07, 2026 at 02:21:59AM -0700, Eduard Zingerman wrote:
> > On Mon, 2026-07-06 at 18:50 -0700, Shakeel Butt wrote:
> > > On Mon, Jul 06, 2026 at 05:17:50PM -0700, Eduard Zingerman wrote:
> > > > On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > Hi Ziyang,
> > > >=20
> > > > I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
> > > > as this code would need to be (a) maintained, (b) run at each CI in=
vocation.
> > > > Hence, the tests added need to be relevant for the BPF sub-system.
> > > >=20
> > > > Regarding the benchmarking part, as you state yourself:
> > > >=20
> > > > =C2=A0 > In my testing (a 60-CPU VM) the BPF path is roughly an ord=
er of magnitude
> > > > =C2=A0 > faster than the per-cgroup memory.stat parse for a whole-t=
ree scan, mainly
> > > > =C2=A0 > because it avoids the per-cgroup open/read and string pars=
ing.
> > > >=20
> > > > With this, I think the benchmarking code can be dropped altogether.
> > > >=20
> > > > Next, the three memcg_stat_{reader,churn,churn_percpu}.c files shar=
e a
> > > > lot of utility code almost verbatim (e.g. tree definition/construct=
ion).
> > > > Such duplication should be avoided.
> > > >=20
> > > > Finally, from the BPF point of view the test exercises the followin=
g functionality:
> > > > - kfuncs:
> > > > =C2=A0 - bpf_mem_cgroup_page_state
> > > > =C2=A0 - bpf_mem_cgroup_vm_events
> > > > =C2=A0 - bpf_put_mem_cgroup
> > > > =C2=A0 - bpf_get_mem_cgroup
> > > > - main iterator logic.
> > > >=20
> > > > All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/mem=
control.c code,
> > > > all kfuncs including the bpf_get_mem_cgroup() are already exercised=
 in the selftests.
> > > > The iterator logic itself is covered by 8 sub-tests in the prog_tes=
ts/cgroup_iter.c.
> > > > Hence two questions:
> > > > - What do these new tests add in terms of tests coverage?
> > > > - Why do BPF selftests need to exercise the churn and churn_percpu =
scenarios?
> > > >=20
> > > > Shakeel, could you please comment as well?
> > >=20
> > > Hi Eduard,
> > >=20
> > > Thanks a lot for taking a look. The main motivation I had behind requ=
esting
> > > Ziyang to send this series (beside making him learn the tooling and p=
rocess of
> > > sending patches to lkml) was to have a reference implementation and p=
erformance
> > > comparison for BPF based cgroup/memcg stats collection.
> > >=20
> > > However you have correctly pointed out that selftests might not be th=
e right
> > > place for such kind of code as selftests are more focused on function=
al tests
> > > and run by a lot of CIs while this is a performance benchmarking code=
.
> > >=20
> > > I am wondering if there is a place for this benchmarking code in kern=
el under
> > > tools folder but archiving it on lkml might be good enough and should=
 be easily
> > > searchable. Anyways thanks again for your time.
> >=20
> > Hi Shakeel,
> >=20
> > We do have bpf benchmarks in the kernel tree, the entry point is
> > tools/testing/selftests/bpf/bench.c. These are supposed to be
> > performance measurements and are executed manually from time to time
> > (quite rarely, as far as I understand), not by CI.
> > However, if I understand Ziyang's assessment correctly, this code is
> > not really a performance test, but kind of a load test.
> >=20
> > Thanks,
> > Eduard
>=20
> Hi Eduard,
>=20
> Thanks a lot for the review. Yes, as Shakeel mentioned, the performance
> comparison for BPF-based cgroup stats collection was the original motivat=
ion.

You said yourself that the test is comparing an in-kernel walk to
parsing strings and opening files.

> But the patch also carries functional value: alongside that comparison, i=
t
> checks the correctness of the stats the kfuncs return.
>=20
> Let me first answer the main question -- what these tests add over what w=
e
> already have -- and then lay out a plan.
>=20
> First, the static test (memcg_stat_reader) vs the existing cgroup_iter_me=
mcg.
>=20
> The existing test calls the kfuncs, but for each value it only checks whe=
ther it
> is greater than zero. For example, in prog_tests/cgroup_iter_memcg.c:
>=20
>      memset(map, 1, len);                    /* dirty some anon */
>      if (!ASSERT_OK(read_stats(link), "read stats"))
>              goto cleanup;
>      ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
>=20
> It never checks the value is actually correct -- i.e. compares it against=
 the
> value in cgroupfs -- only that it is non-zero.
>=20
> Besides, it also walks a single cgroup:
>=20
>      .cgroup.order =3D BPF_CGROUP_ITER_SELF_ONLY,
>=20
> and reads only five fields.

Arguably one of the the cgroup_iter_memcg.c tests can be extended to
allocate some mem and check if the value is reflected in the stats.
But there is a line between MM tests and BPF tests.
All BPF kfuncs except iterator logic itself are thin wrappers on
top of the existing MM functionality. Hence, I don't think that
BPF selftests are a place to stress-test these things.

>=20
> The memcg_stat_reader in this patch adds three things:
>=20
>    1. It compares the numbers. It reads the stats through the kfuncs and =
checks
>       they match the values in memory.stat, instead of only checking they=
 are
>       non-zero (memcg_stat_reader.c, check_correctness()):
>=20
>          /*
>           * anon (NR_ANON_MAPPED) is rstat-flushed and, with the charger
>           * stopped, deterministic: BPF and memory.stat must agree.
>           */
>          if ((b.anon > f.anon ? b.anon - f.anon
>                               : f.anon - b.anon) > anon_tol)
>                  anon_mism++;
>          ...
>          ASSERT_EQ(anon_mism, 0, "bpf vs file anon (rstat-flushed)");
>=20
>       This is the main gap: b.anon comes from the kfunc, f.anon from pars=
ing
>       memory.stat, and the test requires them to agree.

> "This is the main gap"
I'd prefer interacting with a human, not LLM.

>    2. It covers a whole subtree, not a single cgroup:
>=20
>          linfo.cgroup.order =3D BPF_CGROUP_ITER_DESCENDANTS_PRE;
>    3. It reads a much broader field set (~40 fields, collect_full_stats()=
).
>       Minor.

I don't think that it's responsibility of BPF selftests to check all
these fields.

> Second, the churn test adds something the static test cannot.
>=20
> These counters are kept separately on each CPU for speed, and are only ad=
ded
> together when the code "flushes" them. The existing test does call the fl=
ush,
> right before reading (progs/cgroup_iter_memcg.c):
>=20
>      bpf_mem_cgroup_flush_stats(memcg);
>      memcg_query.nr_anon_mapped =3D bpf_mem_cgroup_page_state(
>              memcg, bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPP=
ED));
>=20
> But if the cgroup is idle there is nothing to add up, so the flush does n=
o real
> work -- and since the result is only checked for non-zero, nothing verifi=
es the
> flush gathered anything. If bpf_mem_cgroup_flush_stats() were replaced by=
 an
> empty stub, this test would very likely still pass (the kernel also flush=
es on
> its own, periodically and on thresholds).
>=20
> With activity going on, especially spread across several CPUs, we can mak=
e the
> flush do real work and then check it by comparing the numbers after the a=
ctivity
> stops. That flush check is missing from all of the current tests, and thi=
s is
> where memcg_stat_churn / churn_percpu come in.

This sounds like an MM stress test.

> Finally, my plan:
>=20
>    1. Keep the static (value-correctness) test, or fold it into cgroup_it=
er_memcg
>       if that works better. I also noticed that several kfuncs are not ca=
lled by
>        any test today (no callers anywhere under tools/testing/selftests/=
bpf/,
>        only __ksym declarations in vmlinux.h): bpf_get_root_mem_cgroup,
>        bpf_mem_cgroup_usage, and bpf_mem_cgroup_memory_events. The static=
 test
>        would be a good place to cover them too.

From BPF perspective the test is over-complicated.
There is no need for a generic tree construction.
Creating a hierarchy of several cgroups, allocating memory within
these cgroups and walking them would work perfectly fine.
Existing selftests already do that. Aside from querying actual memory
amount what else do you want to cover?

>    2. Keep only one of the two churn tests -- most likely the per-CPU one=
, since
>       it is the stronger of the two -- and change its correctness check t=
o
>       actually verify the flush by comparing the numbers. The current che=
ck is
>       weak; it only checks non-zero values and that every cgroup was visi=
ted:
>=20
>          ASSERT_EQ(missing, 0, "all cgroups present in map");
>          ASSERT_GT(total_anon, 0, "tree carries anon under churn");

These are MM tests, not BPF tests.

>    3. Move the code these tests share into a common header, to remove the
>       duplication you pointed out. Or we can combine these two tests into=
 a
>       single one if works better.
>=20
>    4. Keep the focus on functional testing in the selftests. The file-vs-=
BPF
>       timing could stay as an extra bonus -- printed only as informationa=
l
>       output in verbose mode, never as pass/fail -- but I'm happy to move=
 that
>       comparison to the bench framework if you think it fits better there=
.
>=20
> Please let me know if you have any concerns with this plan. I am happy to=
 take
> any suggestions on how to improve the tests, or to change the focus of th=
e
> selftests
>=20
> Thanks again,
> Ziyang

