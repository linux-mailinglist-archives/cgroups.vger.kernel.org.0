Return-Path: <cgroups+bounces-17815-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Md5ACLPhVmpoCQEAu9opvQ
	(envelope-from <cgroups+bounces-17815-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:26:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67128759DF1
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=VBwH8qHL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17815-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17815-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E010530607F1
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CC37AA78;
	Wed, 15 Jul 2026 01:25:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F036E46F
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 01:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078718; cv=none; b=YbgfiZC6iDhoaJCW43yRgsj2SrwKpvSbw/S6l+5U/5Oa7TnyPizHsqJzBbljDe9LvV8cFvb7cDfTz4N2XqNcRZtLDME1kuzoQTX9w5dCHsqVgl33FdwurSCz4MWkCd9CN0mdSSNCEXLVba/JqpAUCqiECD2qSKJP8iHZutoBXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078718; c=relaxed/simple;
	bh=fQc0UySND5bjKbOv5Ct/62qDQrvwkXh7jC5u/Df6Kcw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qWIaHZARArjudMyxf1AtfzaH6z+bwDezqGuG1s+0aECLyaan231w5I7W86kEcBH+DwAD36wLzFXGo6LXhP0hF0ZY4qhOt2RUTJ7raHGKY8rexgOlmxV4KLT8i6mJkW2cHEsTxRH4CbnD2cNdp0DU6BGksrr/TyScFMy3Hi12flA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBwH8qHL; arc=none smtp.client-ip=95.215.58.187
Message-ID: <2e5102e4-0732-41c2-a5be-bbff2f386e58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784078704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMfqtbwByVVJ0J11DXgOpPnnBY2/aNxzKbNLuBb0kU4=;
	b=VBwH8qHLlu1u6MM+HFVp7tAn8Dai4mT2ZkZYbiiC8oEG1ciTvqeUyA7WBgcMRhfhGz77aD
	0TXmcctL3Hgv9zrRms6NU2mqvWzeh2VH1kWH2fKfC8cqAhCtCZ5mIwB7Th43712LkUL0uf
	8zCjM+B/KpYdNpCjotoFE35t46oOkwI=
Date: Wed, 15 Jul 2026 09:24:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: Fix intermittent test_cgfreezer_ptrace
 test failures
To: Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
References: <20260714183125.521650-1-longman@redhat.com>
 <4ae04b8055b7145e182380a46f92c26e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <4ae04b8055b7145e182380a46f92c26e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17815-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:tj@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cgroup.events:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67128759DF1



在 2026/7/15 06:09, Tejun Heo 写道:
> Hello, Waiman.
> 
>> +	usleep(1000);
>>  	if (cg_check_frozen(cgroup, true))
>>  		goto cleanup;
> 
> A fixed 1ms sleep only hides the race. On a loaded machine or a slow arch
> (you mention ppc64) the refreeze can take longer than 1ms, and the test
> reads the unfrozen state and fails anyway.
> 
> The freezer test already has a way to wait for this properly.
> cg_prepare_for_wait() sets up an inotify watch on cgroup.events and
> cg_wait_for() blocks until it changes. cg_enter_and_wait_for_frozen() shows
> the pattern: loop cg_wait_for() then cg_check_frozen(). The cgroup always
> ends up frozen, so looping until cg_check_frozen() reports frozen is
> reliable and doesn't depend on timing.
> 
> Can you respin using that instead of usleep()?
> 
> Also, temporaily -> temporarily, in both the changelog and the comment.
> 

Hi Tejun, Waiman,

I ran into a similar issue a while back and can add a data point on
the reproducibility: when running the full cgroup selftest suite, a
few cases -- test_cgfreezer_ptrace and test_cgfreezer_stopped -- fail
intermittently (around 40-70% on VMs), yet each failing case passes
reliably when run on its own. That points at state carried across
tests rather than a per-test bug, which is also why a fixed sleep/retry
is fragile.

On the "unfrozen state" above, I traced where CGRP_FROZEN actually gets
cleared. When the frozen tracee is woken by PTRACE_INTERRUPT,
JOBCTL_TRAP_STOP takes priority over JOBCTL_TRAP_FREEZE in get_signal(),
so the task enters ptrace_stop() instead of going back to
do_freezer_trap(). With debug printk in cgroup_update_frozen_flag() and
cgroup_leave_frozen(), the cg_test_ptrace trace shows:

  0 -> 1  nr_frozen=1  task_count=1   /* initial freeze            */
  1 -> 0  nr_frozen=0  task_count=1   /* dec, task still in cgroup */
  0 -> 1  nr_frozen=0  task_count=0   /* task left cgroup          */

The 1 -> 0 step (nr_frozen 1->0 while task_count is still 1) is
cgroup_dec_frozen_cnt(), called from cgroup_leave_frozen(true) at the
end of ptrace_stop() (signal.c:2479) when the tracee is woken by
PTRACE_DETACH. That clears CGRP_FROZEN until the task loops back into
do_freezer_trap() and re-enters the frozen state -- the transient
unfrozen window the test hits.

As a kernel-side attempt I changed cgroup_enter_frozen() so it no longer
returns early when current->frozen is already true: css_set_lock is
taken before the check and, if CGRP_FREEZE is still set,
cgroup_update_frozen() is called to re-verify the cgroup frozen state
when a frozen task is handed off to ptrace.

Due to other work I've had to pause this investigation for now, so I'm
sharing the above as a data point rather than a finished fix.

Thanks,
Tao

> Thanks.
> 


