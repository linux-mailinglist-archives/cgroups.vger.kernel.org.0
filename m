Return-Path: <cgroups+bounces-17574-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZHPrM5eaTWoR2wEAu9opvQ
	(envelope-from <cgroups+bounces-17574-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 02:32:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844F720A2D
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 02:32:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wZd7chiX;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17574-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17574-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D66930439B6
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96D1EFF93;
	Wed,  8 Jul 2026 00:31:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1581EB5FD
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 00:31:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470708; cv=none; b=q9TojuSiBsw8gNzuvtJqigPNJrv12XEjvpNCdpO35CFBnwyOdxFbPxTxWRKpsnDDH6bIqLj1LRbNVdbRzxP7x00EbzRQLW0Ypj4jNOAv6BcZBP4iCm9ZeaFCfmYFb2mbeRGvuohJZMGoDUGdHk7MGW5Er1kNK/AsIk/5H5o0818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470708; c=relaxed/simple;
	bh=1pIEFUpfph2x0b93MBVHNonPuLGE2FMsB57c9Y4celg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h62kHU+PgObWjP6n3E55V8OgS0RDXLyNIOku6h/+b5f6HlFM+0VXN7xBkJ8PKSv1udE0oSTio8UFTFj8cxMoKhwAxFnXLtey/TElhyfqWMGWfas70i8YdYvzfjhcO3vh/MexY5mAbDwCrBjsxoyjNiwgBYYmq8SKmmgJNvdw2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZd7chiX; arc=none smtp.client-ip=91.218.175.185
Date: Tue, 7 Jul 2026 17:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783470694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zryoqLpY5XcbZJXngdfeetx+hhc/I/xTEt/aoCxXbTw=;
	b=wZd7chiXqMIHJ5/8OfDPYrJ7LFoLqsDa7aEOq7QpzXPekS3QnHdYiZNSWF1vz8+QF4LbKg
	bWuVsOIsC2ByfC7tQZvhUVEv702FwmStEl9Fl/muJOPeOwG1Wt+KJchE+EGSWO2toNpgOv
	+8rkP1aaO7Fl54Svwvr0VdVVdt6SFSM=
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
Message-ID: <ak2Wpk6OnhTyon65@linux.dev>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
 <bc12730fe6eccde10d36e6544607ae2464357e05.camel@gmail.com>
 <akxW5dzvR9e2CfGq@linux.dev>
 <eccfd9a8dd1af1668e142b9b866194333647b0d5.camel@gmail.com>
 <ak2LXDWoPFSJL2Q9@devvm16600.scu0.facebook.com>
 <bc47c75a00acab57e7fea72612e0f6f089ddecc9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc47c75a00acab57e7fea72612e0f6f089ddecc9.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:ziyang.meme@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17574-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3844F720A2D

On Tue, Jul 07, 2026 at 04:50:11PM -0700, Eduard Zingerman wrote:
> On Tue, 2026-07-07 at 16:27 -0700, Ziyang Men wrote:
> > But the patch also carries functional value: alongside that comparison, it
> > checks the correctness of the stats the kfuncs return.
> > 
> > Let me first answer the main question -- what these tests add over what we
> > already have -- and then lay out a plan.
> > 
> > First, the static test (memcg_stat_reader) vs the existing cgroup_iter_memcg.
> > 
> > The existing test calls the kfuncs, but for each value it only checks whether it
> > is greater than zero. For example, in prog_tests/cgroup_iter_memcg.c:
> > 
> >      memset(map, 1, len);                    /* dirty some anon */
> >      if (!ASSERT_OK(read_stats(link), "read stats"))
> >              goto cleanup;
> >      ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
> > 
> > It never checks the value is actually correct -- i.e. compares it against the
> > value in cgroupfs -- only that it is non-zero.
> > 
> > Besides, it also walks a single cgroup:
> > 
> >      .cgroup.order = BPF_CGROUP_ITER_SELF_ONLY,
> > 
> > and reads only five fields.
> 
> Arguably one of the the cgroup_iter_memcg.c tests can be extended to
> allocate some mem and check if the value is reflected in the stats.
> But there is a line between MM tests and BPF tests.
> All BPF kfuncs except iterator logic itself are thin wrappers on
> top of the existing MM functionality. Hence, I don't think that
> BPF selftests are a place to stress-test these things.

That is actually a good discussion point. Where does such kind of tests (i.e.
testing that bpf based memcg stats read functionality is equivalent to
traditional memcg stats reading). As more subsystems are exposed to bpf, similar
questions would arise more often.

In this particular case, IIUC you want only tests for bpf related code (wrappers
& iterator) to be present in bpf selftests, right?

Personally I don't have strong opinion where this test should live.
Functionality wise as it is testing rstat infra, I think cgroup selftests might
be better home for this.

