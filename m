Return-Path: <cgroups+bounces-17550-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /96lEcihTGpknQEAu9opvQ
	(envelope-from <cgroups+bounces-17550-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 08:50:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A89718229
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 08:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q2mbDs3M;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17550-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17550-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995BE3036F9C
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 06:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39683AA4F1;
	Tue,  7 Jul 2026 06:44:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A382226CF6;
	Tue,  7 Jul 2026 06:44:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406680; cv=none; b=n75cEobzUKA35D/lcYj9+G0khYvDp4jE6oomGpHxRTgRP7LwrVlJIwqJVGl281gShj24EIikSG6vYM8Pd8ub5kqX6Bh9p4zADDn9Q/2C/GCGvENTaxjnh+Eyl+edsDX/gLzXuYmC5awgW0tu6ziEmXRi7PCgTdhfW+7SybJlg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406680; c=relaxed/simple;
	bh=3vmTg1Nf17vATetjK6+dGNn9UUpDdzDbpAWCw+9ZISQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Content-Type; b=O/XRZHJZdg8QbeZEy1CTEcjdlg2ZdK/LVcuvuWng1aDrPw7jqodFb8AIKcbQF3E09KBIXpe67hDGWq6pfJGDugmvtYlDFAXgN+7YuRoMetfCk5ocB7Fu0txmfV4PgKgAp9t2jcA3J7o/vU0eZj+Ikq5rpugsfQjHzC4BoMLacow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2mbDs3M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53EF1F000E9;
	Tue,  7 Jul 2026 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783406679;
	bh=gQOyUCAfoqT5OpmxBYtWbyLMl+/h1XpIpduhJW2dwoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Q2mbDs3MmdGtgKAxCBGgKIcteT5aC71zrR1b+SwKTV1Lb0Mbq+uxvQxO+IC//s99f
	 OvQGSSzoi4o4dI1jvEzRpULA/qiD9TopS1PzTerCrzqeRQtcmfkoA+SE79TX5V+M0h
	 hYWHWGmLfs0vndBwQBM7T4dInfon0r5Wm6InfqBhegKzxqSaIv1N62umOc3HgoKFN4
	 8x0URZctrli0kmi4tQNRKbeQr9QAZhsAWqH1oUfDHNghsu+H9hWHv+2uPwfr93aTAX
	 TvS5RQJ4Mh32wODT8FvWmJlgt7RAEzrpWHDVUJqNR/cNAhXHyWAhEvQNTdhLvo6jiD
	 WaGYbCvnI1ulQ==
Message-ID: <e254af713b5345aec3d086771ecf1e71@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
Subject: Re: [PATCH-next v10 10/11] cgroup/cpuset: Support multiple destination cpusets for cpuset_*attach()
In-Reply-To: <20260702214757.579012-11-longman@redhat.com>
References: <20260702214757.579012-1-longman@redhat.com> <20260702214757.579012-11-longman@redhat.com>
Date: Mon, 06 Jul 2026 14:57:31 -1000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17550-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:ridong.chen@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8A89718229

Hello, Waiman.

On Thu, Jul 02, 2026 at 05:47:56PM -0400, Waiman Long wrote:
> It is assumed that a given cpuset cannot be both a source and a
> destination cpuset. [...] it will print a warning and fail the attach
> operation in these unexpected cases [...]

This assumption doesn't hold - the WARN_ON_ONCE() and -EINVAL fire on a
legitimate migration. It's the case sashiko flagged, and it does reach
can_attach().

Threaded subtree with partial cpuset delegation:

  P (+cpuset)
  |- R (cpuset)        <- destination
  |  `- C (no cpuset)  -> effective cpuset == R
  `- W (cpuset)

Group leader in R, thread_a in C, thread_b in W; migrate the whole
process into R (echo $PID > R/cgroup.procs). thread_a moves C->R: its
cgroup changes so compare_css_sets() keeps it in the taskset, but its
cpuset css is unchanged (C inherits R's), so task_cs() == cs == R. cpuset
is in ss_mask because thread_b (W->R) changed. can_attach() then tags R
as a source (thread_a) and the destination (thread_b):

  WARNING: kernel/cgroup/cpuset.c:3054 at cpuset_can_attach_check+0xcd/0x130
   cpuset_can_attach+0x131/0x2f0
   cgroup_migrate_execute+0x367/0x450
  cgroup.procs write returns -EINVAL

So a thread already in the destination's effective cpuset does show up in
the iteration when it reaches that cpuset through a different, non-cpuset
child - compare_css_sets() keys on the cgroup, not the cpuset css.

1-9 handle this correctly (the migration succeeds); the patch 10 guard
regresses it. I've taken 1-9 into for-7.3 - please respin 10-11. One
option: when oldcs == cs the pair is a cpuset no-op, so skip it and add
it to neither list.

Thanks.
--
tejun

