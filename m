Return-Path: <cgroups+bounces-17546-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6xORCJdGTGp/igEAu9opvQ
	(envelope-from <cgroups+bounces-17546-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 02:21:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E3E716791
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 02:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P2UChFPG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17546-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17546-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F064300EAAA
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769561A6813;
	Tue,  7 Jul 2026 00:17:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208321A6824
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 00:17:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383476; cv=none; b=aKHxhMc8XbyicsLStXWBccJ3Nr53ox+sHxYN3uiy1r10BzqTRfAqOpHTLdMGQjk41SKNbAoRIpxiUm/G49kWYMTIWtfOHR9T4J6T318HMyw+qo2AoWZkLy4NZ74F/EZCSQckgqpKCIoeyVgTcU0EGXeACqJFAWSNvk5sJz0g61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383476; c=relaxed/simple;
	bh=af72MIiNPASyMrPenWUlckSQNn+OURdtih1H9LpKlI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuqzwfvADIkm0I6+QlD4vj6g+jHBkzAs0cRtZTfi6Fm/EysjYD9GnKwBH+SmOsF4HFmJMtIJ5ykySKniB3TiO8xthhkkGtOnAOX8WJoVb9BjgMKe4BmEKh2+rqrvnfRwSwBgqv4SqovjbPYjwvsV49QVRg3QZBmLnK3ZH4Qr4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2UChFPG; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1676025a91.2
        for <cgroups@vger.kernel.org>; Mon, 06 Jul 2026 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783383474; x=1783988274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlYk0sNL0UkMJvtmh539AMWShHtruvV8sV0IdItG1l0=;
        b=P2UChFPGk+gSselBw1l9QAitcDVL1UVr1rYuMfJAJp/H02DWIazkdCjUUQTqDHR+wE
         gsPUm8oUz0Zdppyc1D7a6HBcy/zWtuvdA4up6FOx7SN3MJD5HSFAoBCvO9DumA5mg0Lw
         a42EdP/KKa3XN/SOvd+wF5IuQrDFnPPrZJOouz0o952YAmIypE1+6eyCRtyWTv7I0n+R
         u8tKEWp751lwecHjOhLXsn2Q/pxCtAVVWWyCaIYGu8wO3+zG4YOwwSiEhFgeKp4XFoo+
         A8LwOVhCR0g0Os0yfMwZVSfh4fhRqxbQa51HnhL2FnR8wYxvWBW/MSwOnOfutcQjzdK+
         f0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783383474; x=1783988274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlYk0sNL0UkMJvtmh539AMWShHtruvV8sV0IdItG1l0=;
        b=QykoNF60K2LpQk9jPsG9Wa8pRH91+CH2/fnuIBEe++XlxCq03zMU4kEM3uinmdYElq
         9NXgggN7MVb3Dslqhv5eeia2yZ/+uMIoIyM8BI1ReNFTUm9u800+AbfhBHqXTsJM1tkN
         tZO5vgbrmzaq6kPmyQE1YL1SopGvH6J5fsx2PBy4ej+H4I38yHUX6P1phixiDvi6U6w7
         pybT6LiWkKgOWg3rnywOj4LuEBPyh5jdObFjA5qPnHWv/EWPsDHCX6jEyo2cb+cRXt1u
         SFOs8UdhHSr6igWP0cEIbKXzH3EShRV/tsmE5nxRi+tuYgaPP1+DScuCs1csb1dMYoyP
         IGng==
X-Forwarded-Encrypted: i=1; AHgh+RqC8EHDV2hSpr4VTDewFgTCS1c1P1Sv0WINJHEMRlQdJlujG2MVq6whxjWZFTOlWXZXv6f+hpOp@vger.kernel.org
X-Gm-Message-State: AOJu0Yygqpid6yGtlUpNgjq83/Vbl4XreGg5eUHxfLmGLO8f72fapYQZ
	JrzSq7ivbfPhjUcgsgS2h0AjctUXqq4SNvY44FI7V1/vcwy1KMUjFtsZ
X-Gm-Gg: AfdE7ckT02qXQGGTYpgb5tkz5Xz+L+ZK1s/Wwn/bk1cq9AkMOFieN0zMfCs+PbyzBV0
	yh4CS2+W0b8D2nj4eS1OKh8UnUMPG1XsOa5uferVbteuRXA29jzqmiLSJ5QeAtCgsqhgHUYbIo6
	nEL43gDlfMKG6Lx9hHofqJ1CuTIY81Dzt/dOL8i8e3KZSsY9eYdq4alxKvC+FA5O564WxY9NMJo
	fraQpx8jzOY1hiudp0JSOctGZ7/vW28OjTh2fonhEtroMb8tE9NFD6WxcLYCO/7UBN0BS1qI+q3
	wjn5UpaJz6iCpFKfQgCcu1Y2M9RA5NdmdIcT3RC5iF0IVwW5B8veQjwAddqyJmRdXOjpGHaSO2W
	TpO8ekjXq6blU/TGJc8WuYkEooMFDagoaJq0geuTVVm9fyANeLKCGYuMz2FGdwNhBA9LW8xqUlQ
	ltN8g5FES7zco874f00c95FeUZZsp9U+paYYl9Y/H3vjWfn946w2/5+nRZNJDgWwwTFbKZFQ==
X-Received: by 2002:a17:90b:1845:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-38757d76999mr2730666a91.28.1783383474243;
        Mon, 06 Jul 2026 17:17:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:275a:65bb:602c:da1d? ([2620:10d:c090:500::1:7696])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a89a89sm1783645eec.20.2026.07.06.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 17:17:53 -0700 (PDT)
Message-ID: <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ziyang Men <ziyang.meme@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bpf@vger.kernel.org, shakeel.butt@linux.dev
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>,  Shuah Khan <shuah@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, kernel-team@meta.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org, Shakeel
 Butt <shakeel.butt@linux.dev>
Date: Mon, 06 Jul 2026 17:17:50 -0700
In-Reply-To: <20260704045617.487664-1-ziyang.meme@gmail.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17546-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ziyang.meme@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:shakeel.butt@linux.dev,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5E3E716791

On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:

[...]

Hi Ziyang,

I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
as this code would need to be (a) maintained, (b) run at each CI invocation=
.
Hence, the tests added need to be relevant for the BPF sub-system.

Regarding the benchmarking part, as you state yourself:

  > In my testing (a 60-CPU VM) the BPF path is roughly an order of magnitu=
de
  > faster than the per-cgroup memory.stat parse for a whole-tree scan, mai=
nly
  > because it avoids the per-cgroup open/read and string parsing.

With this, I think the benchmarking code can be dropped altogether.

Next, the three memcg_stat_{reader,churn,churn_percpu}.c files share a
lot of utility code almost verbatim (e.g. tree definition/construction).
Such duplication should be avoided.

Finally, from the BPF point of view the test exercises the following functi=
onality:
- kfuncs:
  - bpf_mem_cgroup_page_state
  - bpf_mem_cgroup_vm_events
  - bpf_put_mem_cgroup
  - bpf_get_mem_cgroup
- main iterator logic.

All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/memcontrol.=
c code,
all kfuncs including the bpf_get_mem_cgroup() are already exercised in the =
selftests.
The iterator logic itself is covered by 8 sub-tests in the prog_tests/cgrou=
p_iter.c.
Hence two questions:
- What do these new tests add in terms of tests coverage?
- Why do BPF selftests need to exercise the churn and churn_percpu scenario=
s?

Shakeel, could you please comment as well?

Thanks,
Eduard.

[...]

