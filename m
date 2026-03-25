Return-Path: <cgroups+bounces-15038-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOEYMIvRw2lLuQQAu9opvQ
	(envelope-from <cgroups+bounces-15038-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 13:14:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E7324991
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1A432E3A86
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710373CFF67;
	Wed, 25 Mar 2026 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZhINbLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gfW+tRjs"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A83CF661;
	Wed, 25 Mar 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439533; cv=none; b=SWkL3hBT7GkV6BAYjLuCaOIOtkwORX/HXxZ3B4XYvPryNxTfemQYHCOovPXcYHTtPE/e8yaMeXLhU7hHs4cfC/9ZlRW9CxZj/c1WcLUzIs3wn7Lxlf2tIMjpOJksGufflaAqn02omUel5d01T3BXE+SHLSf2LRpAs+2vhkBOp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439533; c=relaxed/simple;
	bh=+aDTUeQQn9wZslL6TzmMIw8i+6rixsxpnOc0bGWhBPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMOQbAOExC6Rf29TkouIJKgcaOnDcaGfNZaMZ7awiV4rErzF/dqLzCQuGsix0aVTMNRbojheC5LZmqn1ADFL5U+f2XgP0+b98cm/a4pnAXpm9smmSVG+ypikIAMvBKnFRBdXeaLDdDBzRIXwD/1PfKMqdV8r/p0fpNj5/YkFvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZhINbLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gfW+tRjs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Mar 2026 12:52:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774439528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmzCdllCY1cSQI/BPmhqvFc3tOR6AYvQqHpqIOkdB6s=;
	b=YZhINbLEb3/umtq/7pTw859yD5Pjh/KNXpuEP2bhncHICkCypvXg1SRctOMpttNXnZjeGi
	+8fxqBH1ZbtID2Z791CGnoqa2hZSk057WsEd+/pZp18odOE421l+2K3/a9yFKSmfBaIOm2
	bGU5Dom2fepjKotzHTo/bDAZ34x1KaHeIkpS3cM+L+taz/EW0wtYILG8NSvKDc+C+ces3W
	88t3p3kUuSJjFwg9xIyBoxBuowJDV5XO7wYDIz7GlCz0yfZaKoM4AUp7pBj85jWO4JWluN
	ze7J7rz9Q3qBHL8lOG/PoEJeX1keJ+dlCKm0o8xyzp0wTCFkIkCVrQ0m1xGkgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774439528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmzCdllCY1cSQI/BPmhqvFc3tOR6AYvQqHpqIOkdB6s=;
	b=gfW+tRjsNpLZi9xjYmeFTTrLKUXIR1lSa+uoV70Hj6DM7CZygTBRrAWDQktvCfeb4ofgQq
	s3CjyNPKUca+7VDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] cgroup: Wait for dying tasks to leave on rmdir
Message-ID: <20260325115207.y3WYPLZk@linutronix.de>
References: <20260323200205.1063629-1-tj@kernel.org>
 <20260324090402.k7NkNcEp@linutronix.de>
 <acLxYGxkgPYRP94e@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acLxYGxkgPYRP94e@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	TAGGED_FROM(0.00)[bounces-15038-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,poweroff.target:url,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 1E9E7324991
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-24 10:17:36 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> I'll apply this for now. Can you please try to reproduce the problem with
> the patches applied? How reliably does it reproduce? How is it stuck? Are
> tasks waiting on the waitq indefinitely with populated stuck at 1?

With the patches applied the test suite works. But now I accidentally did
poweroff :

| [  OK  ] Finished systemd-poweroff.service - System Power Off.
| [  OK  ] Reached target poweroff.target - System Power Off.
| INFO: task systemd:1 blocked for more than 10 seconds.
|       Not tainted 7.0.0-rc5+ #167
| "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
| task:systemd         state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00080000
| Call Trace:
|  <TASK>
|  __schedule+0x3d4/0xf80
|  schedule+0x27/0xd0
|  cgroup_drain_dying+0xb7/0x1b0
|  cgroup_rmdir+0x2f/0x100
|  kernfs_iop_rmdir+0x6a/0xd0
|  vfs_rmdir+0x11a/0x280
|  filename_rmdir+0x16f/0x1e0
|  __x64_sys_unlinkat+0x58/0x70
|  do_syscall_64+0x119/0x5a0
|  entry_SYSCALL_64_after_hwframe+0x76/0x7e
| RIP: 0033:0x7f06b8b7fc17
| RSP: 002b:00007ffe37f96c98 EFLAGS: 00000206 ORIG_RAX: 0000000000000107
| RAX: ffffffffffffffda RBX: 000055ee562eba40 RCX: 00007f06b8b7fc17
| RDX: 0000000000000200 RSI: 000055ee562eba53 RDI: 000000000000000c
| RBP: 000000000000000d R08: 000055ee562eba40 R09: 0000000000000000
| R10: 00000000000007a0 R11: 0000000000000206 R12: 000055ee5639daa0
| R13: 0000000000000000 R14: 000055ee562eba53 R15: 000055ee562ec030
|  </TASK>

This is not PREEMPT_RT and I can reproduce it also as of commit
6680c162b4850 ("selftests/cgroup: Don't require synchronous populated
update on task exit").
The reboot command is also affected in the same way. systemd is 260-1 in
case it should matter.

> Thanks.
> 
Sebastian

