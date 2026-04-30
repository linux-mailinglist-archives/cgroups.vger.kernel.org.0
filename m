Return-Path: <cgroups+bounces-15560-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA+rLET08mnNvwEAu9opvQ
	(envelope-from <cgroups+bounces-15560-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 08:18:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFA49DFDD
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 08:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA50930265AF
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9636920C;
	Thu, 30 Apr 2026 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b="tAtjzXlN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.piware.de (mail.piware.de [37.120.164.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5319D092
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.164.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529741; cv=none; b=FLgHsfrXOSNn5siEMdPhYJ5E5QYlVVaGGYBPLIGtnqMkNru5bbUvFy+cei/Whk9WSvWGOkUEG03UD9KMv0vYSF01dnfltVgSMNtfqPxRHw6gP+rwCDJmt5e3bvzEMlfTDsyHEbIY/0dPTFCZ9EkEoYHPgyAwGxNEoqYt2puYU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529741; c=relaxed/simple;
	bh=E4+ylKbyqg7Yh08Hc76TKdbHV10Z8nP9qTXS592twIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qgrvj+ClGYHjTxgF3XC4CCcYYf/CqP2NeA2FLLSbltM+L5K/muJnynpVo1p9QMog/nKyRJaUGzPpUrpVQKriUSPS9tjvgJxNjjzg9ax41rKgrBrnv+vTOaU32nL9tdfVaL3MTI63PhqOslcHcBFSIog+VP+R+AZkjBpvrR5Ce8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de; spf=pass smtp.mailfrom=piware.de; dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b=tAtjzXlN; arc=none smtp.client-ip=37.120.164.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piware.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piware.de; s=2025;
	t=1777529735; bh=E4+ylKbyqg7Yh08Hc76TKdbHV10Z8nP9qTXS592twIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tAtjzXlN5ScHZcV6tSmFfHwpQ6pOQxtg05/ZNfN3dXMAhbDSvwpW4VK7ZYXvkMRm5
	 GkU46R4ED6ToK4IH0ZKs2STwTMtcjb4R0eU64M8lQOAlrmx9Yj/qejDFQ3cqEi0VnL
	 wE3rXyMHaOb69XXsPazYYFS2p89v860vYYh5mnMfPtJZq14RVD3OZ9qEpiItNv2UFJ
	 h11Fi8LyzuRBUi8AYD4YPEHKnUp/0x/SK9dguq4Pao9havoutki11RTSwmqzxdv22u
	 uOU4BJ3d83mZRnEliHZNqGZIEbuOGsn/1FVnJFIrMAFoCBVT7a0WiRxRcQrls/lOV7
	 dUOa9B+IWg24g==
Received: from piware.de (localhost [127.0.0.1])
	by mail.piware.de (Postfix) with ESMTP id AC81EFF881;
	Thu, 30 Apr 2026 08:15:35 +0200 (CEST)
Date: Thu, 30 Apr 2026 08:15:33 +0200
From: Martin Pitt <martin@piware.de>
To: Tejun Heo <tj@kernel.org>
Cc: regressions@lists.linux.dev, cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [REGRESSION] 6.9.11: systemd hangs in cgroup_drain_dying during
 cleanup after podman operations
Message-ID: <afLzhRPSaD2Atp7G@piware.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e0670adb4abeab13da2c321582af9f@kernel.org>
 <f19d08689301f9cc0211e6273f833246@kernel.org>
X-Rspamd-Queue-Id: 30EFA49DFDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[piware.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[piware.de:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15560-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[piware.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@piware.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quay.io:url]

Hello Tejun,

(Dropping lizefan.x@bytedance.com from CC:, it doesn't exist any more)

Tejun Heo [2026-04-29  6:21 -1000]:
> Thanks for the report. The dmesg you attached has only a partial sysrq-t
> - the dying-task stacks I need were pushed out of the ring buffer. Could
> you increase log_buf_len, reproduce, trigger sysrq-t, and send the
> resulting dmesg?

Increased to 4M, which was enough. I added it to the bottom of the debug notes
comment [1], direct link: [2]. I suppose its' not necessary any more, but just
for the records..

[1] https://github.com/cockpit-project/bots/pull/8970#issuecomment-4342147158
[2] https://github.com/user-attachments/files/27231725/dmesg-task-dump.txt

Tejun Heo [2026-04-29 11:15 -1000]:
> I think I have the mechanism. The deadlock chains three things together.

You are a genius!

> 3. The container's PID 1 (whatever the entrypoint runs) is in
>    do_exit() but parked in zap_pid_ns_processes' second wait loop:

FTR, the container is pretty dumb, just 

  podman run quay.io/prometheus/busybox sh -c 'echo 123; sleep infinity'

we are not actually interested in the container workload for this tests, but
testing cockpit-podman for managing containers on the host.

However, I just confirmed that busybox'es sh, like "proper" bash, does reap
child processes (unlike for example running `sleep` directly as pid 1, then you
do get zombies)

> ----- min-repro.c -----

On Fedora 44 with 6.9.13, this hangs at

    A: rmdir(/sys/fs/cgroup/drain-min/inner) — wedges if bug present (deliberately NOT wait4-ing C)

root        1501  0.0  0.1   2460  1764 pts/0    D+   06:10   0:00 /tmp/repr
root        1502  0.0  0.0      0     0 pts/0    S+   06:10   0:00 [repr]
root        1503  0.0  0.0      0     0 pts/0    Z+   06:10   0:00 [repr] <defunct>

as expected. It does not wedge up the system in the same way as breaking all
"ls /proc" and such.

On Fedora 44 with older 6.9.10 kernel the reproducer finishes (no hang), with
EBUSY:

: B host pid=1444, C host pid=1445
  pid=1444 NSpid:	1444	1
  pid=1445 NSpid:	1445	2
A: rmdir(/sys/fs/cgroup/drain-min/inner) — wedges if bug present (deliberately NOT wait4-ing C)
A: rmdir returned -1 (errno=16 Device or resource busy)

I suppose you know all that, but just in case confirming on my setup helps in
any way.

Thanks!

Martin

