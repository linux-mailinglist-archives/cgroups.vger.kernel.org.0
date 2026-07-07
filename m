Return-Path: <cgroups+bounces-17553-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QfApKLTHTGqtpgEAu9opvQ
	(envelope-from <cgroups+bounces-17553-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 11:32:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28428719D2C
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 11:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OTchNMg6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17553-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17553-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3F430C91D5
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922A3911CD;
	Tue,  7 Jul 2026 09:22:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE938736C
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 09:22:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416125; cv=none; b=YB11OTF0Yj/6EqpRFEpD64xNxrhtsBP6hX870u0vUjrCdGuHc34NT9o/Rm+tSHaOr9QCiRemAQ29dLdNI0nmKOafr+MFzUp5PleaHZYocM7j/sB3eX9fDhTI70CyykTnT8IfKX+aayaWQnfC360mKf0PmjG73G7U3L3inQyedxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416125; c=relaxed/simple;
	bh=czp6DDn3Tg1L7Caksu341JziUocBqKvToENHXSg/2y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JqNFAc2v2OneaMDiNJn+Rp4zsMNnTPQ++Te8mNsOQuv9fOYzREZOe24SpKVMELN5xB3FEXcDtsMmRCw3aD+OAH2/KMDil5mE0fmfqAPuxnIc+SZ1zjjbgrFpz2LvbH95nj1+okoc7q0zd88g2N95qoAA88nZgoZ0XCgKmL1h/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTchNMg6; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383adaa461fso2103837a91.3
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416123; x=1784020923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=czp6DDn3Tg1L7Caksu341JziUocBqKvToENHXSg/2y4=;
        b=OTchNMg6Nr408gjbQUSEhOec2z3BU3wfwys7zE4w2l30J/8PADUboPXSXAG1jaDfyI
         VDCW+xE9ZPe5FTk0kXeYP/6U0JgP8JCnby+fIo4x/oE/QQa0hO+eIikgrlPplYqWmVF7
         /U+4pkGDwEieKXxMweNrYyzjsu2aJznJh5HU8qLf3QLbl+swfQC9a7JiaK5kv6YLAg91
         v50FENbd2ZyjEU5AVxMKV7n8/aysUZ8DRMeVQlioZZEiGsTUpfLZ2h62TIFF08p2UzrF
         bP0l9mV0R1L9pZUF63RPZsFwi1nKmkRqVZtjC9B9MvOQA2fYFQWmTUWafF0aOsVMQ4+q
         k6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416123; x=1784020923;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czp6DDn3Tg1L7Caksu341JziUocBqKvToENHXSg/2y4=;
        b=OZpBvUDAQq8scfHQ8o9yTsLGIGaUjOy3Ll+FUzB8V1jLxQFCjK6nGQk1a7G8ezsf5N
         Und6DRAQe9h8dOOmWbbQxDITbN/LUSVzcpxvMUgcLh1mGsS4lN9eUH7z8mpKHQhvLbKk
         9I2iv7QzQtIA2Q2CmW52nuHjzpdDbZKhe/jHjIfPC0smUM0hedvW5UXTSRxNIpHxwXIW
         iaE0gUomdszeuHW9TZ5q5219QimSmljNXYVCXUDbNRlFIKYymbjwvmnjH5pc+za+I8WE
         0+IYP8AERCDgEmhT6lvahOyR8RFBEYkmgREp7KO0zTdF8JjXYNXizibp83Ow5MFKKlmC
         50Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rpm1l8vcGefIyuco+lg7i57wW7U97G1K1zx1SQswlfms1eb+61CNe0ayBirmefInotzuRaUNcXP@vger.kernel.org
X-Gm-Message-State: AOJu0YwBM9lpL0Bs8p+bzV26aRUnxACGOahGVxU6WwnuQ5yJaPIPBE1B
	LojNGXLLhlTFH9aPu4a8fQGPy21wnt2K+F+JjBvgiKBG3KIRlJQduKyo
X-Gm-Gg: AfdE7ck/N5T/8i72xDrHYRIkZaEQW9329NZ7dLD+tpUO2Gb+BIpQDqJYCERU14uZ6wD
	9s/l0p0VQXBlvliotrMOSWbqPzUkIvBawUp1QaKQJFMjfAAV9IqOYTLMwjmRIRHz4K0i2XbqUtI
	/clvPLAddqbSS32fnssyeZWODegHNmRLrP1SOXS0AnfgGB5NFAerSQDkcH773lsW4TqprKxtfYp
	c/LL8PvpdkID3lXaUtCWyTSjVphbnYIZQfE3+z/29pIKF82f81KQ+OqSvX/Ypq5V9jIP1EUFjFD
	jbPwmimmjJ3W6DaRqMkJc0seCNgoi2EZz9ogK4rndX3cnNudCCrhvgXAE+8LWz+gCFVldob9Tgg
	9KsRQkKNL40ICG9xCvbtscmbQ8gKaXDDnsMY1PwzHUmb4h3EQUIrPAws0I/LZds8IPyHTSwLkB0
	KG8daJnEg0j3bNiHuomEZp4zXa9bpWLC1/6O/EqvNIu7+9hfQDxA0=
X-Received: by 2002:a17:90b:5350:b0:37f:9cdf:f03d with SMTP id 98e67ed59e1d1-38757894fc7mr4396669a91.32.1783416123050;
        Tue, 07 Jul 2026 02:22:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676easm759200a91.9.2026.07.07.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:22:02 -0700 (PDT)
Message-ID: <eccfd9a8dd1af1668e142b9b866194333647b0d5.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Ziyang Men <ziyang.meme@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
 <shuah@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	kernel-team@meta.com, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 02:21:59 -0700
In-Reply-To: <akxW5dzvR9e2CfGq@linux.dev>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
	 <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
	 <akxW5dzvR9e2CfGq@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17553-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:ziyang.meme@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,vger.kernel.org,linux.dev,etsalapatis.com,meta.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28428719D2C

On Mon, 2026-07-06 at 18:50 -0700, Shakeel Butt wrote:
> On Mon, Jul 06, 2026 at 05:17:50PM -0700, Eduard Zingerman wrote:
> > On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:
> >=20
> > [...]
> >=20
> > Hi Ziyang,
> >=20
> > I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
> > as this code would need to be (a) maintained, (b) run at each CI invoca=
tion.
> > Hence, the tests added need to be relevant for the BPF sub-system.
> >=20
> > Regarding the benchmarking part, as you state yourself:
> >=20
> > =C2=A0 > In my testing (a 60-CPU VM) the BPF path is roughly an order o=
f magnitude
> > =C2=A0 > faster than the per-cgroup memory.stat parse for a whole-tree =
scan, mainly
> > =C2=A0 > because it avoids the per-cgroup open/read and string parsing.
> >=20
> > With this, I think the benchmarking code can be dropped altogether.
> >=20
> > Next, the three memcg_stat_{reader,churn,churn_percpu}.c files share a
> > lot of utility code almost verbatim (e.g. tree definition/construction)=
.
> > Such duplication should be avoided.
> >=20
> > Finally, from the BPF point of view the test exercises the following fu=
nctionality:
> > - kfuncs:
> > =C2=A0 - bpf_mem_cgroup_page_state
> > =C2=A0 - bpf_mem_cgroup_vm_events
> > =C2=A0 - bpf_put_mem_cgroup
> > =C2=A0 - bpf_get_mem_cgroup
> > - main iterator logic.
> >=20
> > All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/memcont=
rol.c code,
> > all kfuncs including the bpf_get_mem_cgroup() are already exercised in =
the selftests.
> > The iterator logic itself is covered by 8 sub-tests in the prog_tests/c=
group_iter.c.
> > Hence two questions:
> > - What do these new tests add in terms of tests coverage?
> > - Why do BPF selftests need to exercise the churn and churn_percpu scen=
arios?
> >=20
> > Shakeel, could you please comment as well?
>=20
> Hi Eduard,
>=20
> Thanks a lot for taking a look. The main motivation I had behind requesti=
ng
> Ziyang to send this series (beside making him learn the tooling and proce=
ss of
> sending patches to lkml) was to have a reference implementation and perfo=
rmance
> comparison for BPF based cgroup/memcg stats collection.
>=20
> However you have correctly pointed out that selftests might not be the ri=
ght
> place for such kind of code as selftests are more focused on functional t=
ests
> and run by a lot of CIs while this is a performance benchmarking code.
>=20
> I am wondering if there is a place for this benchmarking code in kernel u=
nder
> tools folder but archiving it on lkml might be good enough and should be =
easily
> searchable. Anyways thanks again for your time.

Hi Shakeel,

We do have bpf benchmarks in the kernel tree, the entry point is
tools/testing/selftests/bpf/bench.c. These are supposed to be
performance measurements and are executed manually from time to time
(quite rarely, as far as I understand), not by CI.
However, if I understand Ziyang's assessment correctly, this code is
not really a performance test, but kind of a load test.

Thanks,
Eduard

