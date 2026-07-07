Return-Path: <cgroups+bounces-17547-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djzIGGBbTGpSjgEAu9opvQ
	(envelope-from <cgroups+bounces-17547-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 03:50:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B2716AF1
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 03:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iGuO03Qb;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17547-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17547-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073B73026735
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CEA2FDC5E;
	Tue,  7 Jul 2026 01:50:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1523BD06
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 01:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783389020; cv=none; b=o+Le50v48qvkPunTSsnsW08VcZXgsaufmMt7poMcBVqyjpEc3LeFxN0M9yKlORdH3i5KndAaJJxzzagbkndjC8nV1ijwBdhqa/4jTWQ3yCQOeyoGPpI8ezuYfApbMO+cGnY4eRu918vD+qSP7l4gcPcOFV3lhbcyf2mLaWGEi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783389020; c=relaxed/simple;
	bh=C9KKzrMhbHQ4j6vaR8/cSitMU7Oq2QiOexBUmdy+Mi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5csYFBhpDxq2aXPJWX/AyCkhuKELbGgNLA2UvSZyoMKNOQsIJgG1e3e7Fdozx5vJvICNZoMVO2kLYfJ/AURNFqoVQnjdQ2ekP1xYUO27Rud+vrqpDisVIyYlqnWJPThoyJ0yxLnUVnnqVsNlKQC5/Uss2ChOqgTZWFItqsLqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGuO03Qb; arc=none smtp.client-ip=91.218.175.173
Date: Mon, 6 Jul 2026 18:50:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783389012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTk3bWiQbEnp9NY0pyiBv+XodrV//lC9BoLhtxJEGoA=;
	b=iGuO03QbteJKA9aIihTwgX5AqWkgRqrX05rDKfDWlAWxDk7BNPcW0y5ca39Xps5t56uFb/
	16s4rxVCluAQKhlh0zAY3smINquMtK0ZkTszFMX2OyuRCmfoPf5vVYOqLwrcLGYWDiEW8h
	Qjag8AlxR8nfinWL6s7frKd+vQzT4ls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ziyang Men <ziyang.meme@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, kernel-team@meta.com, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/bpf: compare BPF and memory.stat memcg
 stat readers
Message-ID: <akxW5dzvR9e2CfGq@linux.dev>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
 <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:ziyang.meme@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17547-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,vger.kernel.org,linux.dev,etsalapatis.com,meta.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 841B2716AF1

On Mon, Jul 06, 2026 at 05:17:50PM -0700, Eduard Zingerman wrote:
> On Fri, 2026-07-03 at 21:56 -0700, Ziyang Men wrote:
> 
> [...]
> 
> Hi Ziyang,
> 
> I'm a bit hesitant adding 2.5K lines of code to the BPF selftests,
> as this code would need to be (a) maintained, (b) run at each CI invocation.
> Hence, the tests added need to be relevant for the BPF sub-system.
> 
> Regarding the benchmarking part, as you state yourself:
> 
>   > In my testing (a 60-CPU VM) the BPF path is roughly an order of magnitude
>   > faster than the per-cgroup memory.stat parse for a whole-tree scan, mainly
>   > because it avoids the per-cgroup open/read and string parsing.
> 
> With this, I think the benchmarking code can be dropped altogether.
> 
> Next, the three memcg_stat_{reader,churn,churn_percpu}.c files share a
> lot of utility code almost verbatim (e.g. tree definition/construction).
> Such duplication should be avoided.
> 
> Finally, from the BPF point of view the test exercises the following functionality:
> - kfuncs:
>   - bpf_mem_cgroup_page_state
>   - bpf_mem_cgroup_vm_events
>   - bpf_put_mem_cgroup
>   - bpf_get_mem_cgroup
> - main iterator logic.
> 
> All kfuncs but bpf_get_mem_cgroup() are thin wrappers around mm/memcontrol.c code,
> all kfuncs including the bpf_get_mem_cgroup() are already exercised in the selftests.
> The iterator logic itself is covered by 8 sub-tests in the prog_tests/cgroup_iter.c.
> Hence two questions:
> - What do these new tests add in terms of tests coverage?
> - Why do BPF selftests need to exercise the churn and churn_percpu scenarios?
> 
> Shakeel, could you please comment as well?

Hi Eduard,

Thanks a lot for taking a look. The main motivation I had behind requesting
Ziyang to send this series (beside making him learn the tooling and process of
sending patches to lkml) was to have a reference implementation and performance
comparison for BPF based cgroup/memcg stats collection.

However you have correctly pointed out that selftests might not be the right
place for such kind of code as selftests are more focused on functional tests
and run by a lot of CIs while this is a performance benchmarking code.

I am wondering if there is a place for this benchmarking code in kernel under
tools folder but archiving it on lkml might be good enough and should be easily
searchable. Anyways thanks again for your time.

thanks,
Shakeel

