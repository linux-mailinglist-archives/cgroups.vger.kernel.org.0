Return-Path: <cgroups+bounces-16981-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OKiCM+hiMGqiSQUAu9opvQ
	(envelope-from <cgroups+bounces-16981-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 22:39:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E9689F0E
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 22:39:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ihGdw57i;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16981-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16981-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE88F3007229
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DA3B5DEE;
	Mon, 15 Jun 2026 20:38:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF23AE6F7;
	Mon, 15 Jun 2026 20:38:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555936; cv=none; b=MP5kcUGUKOg2rNreeFHVapU/nSxy8AoEpLD8Y8h4RGALmnzgKT1iWuBCMsaAPYh4NYYsdUwXEYvQo3lw8gsfL5huUrDJrJwgZA4CpEvvxeXAa25Ypr3x9C17RecWQe9dwVJzunUy5FLFuu/Cz/evkzFccfWOYbbKleUMFp0sX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555936; c=relaxed/simple;
	bh=9efHCy9u9lkxqey6rm+NLvlIWq9xOAh4xTRHJ8RpoGw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA4Mks5g0LcJlj9Yd3L9b2m+/FE3CwTjToxvrdulxG1rXKzFOzAaNow22rx3659QDWo91rrTTH0f9wgC1S0/VIwzsxmwxbnTI8U3Oo6wiPIxHqW1SGvG0qdITBXepI1+26CEudSiTTlET6YehWZ3gcDJKvWB74VUeUnOf/PvUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihGdw57i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D701F00A3A;
	Mon, 15 Jun 2026 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781555935;
	bh=G0Zxb6wcybl1wg/ZQjQgD0PpsW9ICU1qTTRzoJ2k1NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ihGdw57iqm+UWZ7hnU6AagPDSjuDFkvEUBj5ROsHKHTCGEb787VhKzODodoJNqFhh
	 W88sTaSed9EnNwOY5REupPsqPaXJCwOU0nOE1PnUyr3GgBgJJJe/PIzcAWzdr8aFMT
	 9bfqaRfT61FAJ8ZQtpaiLteM+eSXfMA4/MAEYEyvZNQmA77B/LwRi3DofGWMxkI9vu
	 Z8yO9tX6qwpgR2yoZHp8GL/FUo6upYSYfJnSCczO2rVkF53X6YZTjAdIvMix6+uoda
	 XuBIsQ/xS7h3hF7gFYiyQnEPl724TH+phSJ34fOvsYHJhyVBgft/EgXV3WKo7vToPa
	 H6ZS5nb1Fgeyw==
Date: Mon, 15 Jun 2026 10:38:54 -1000
Message-ID: <bcedd13fc22cb7ba590791a4c1387ecc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,cmpxchg.org,suse.com];
	TAGGED_FROM(0.00)[bounces-16981-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B02E9689F0E

Hello,

Looks great. Two things:

1. cpu.rt.internal doesn't follow the naming convention. The file is the
   cgroup's own budget (cpu.rt.max minus its children), so
   cpu.rt.max.effective.local fits better: .effective like
   cpuset.cpus.effective, .local like memory.events.local.

2. root's cpu.rt.max: sched_rt_runtime_us already caps total DL/RT
   bandwidth and rt-cgroups admit against the same pool, so what does
   reserving the cgroup share separately at root add? It's also a writable
   control on root, which we otherwise keep off root.

Thanks.

--
tejun

