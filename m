Return-Path: <cgroups+bounces-15552-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMZ9ObDP8WlrkgEAu9opvQ
	(envelope-from <cgroups+bounces-15552-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 11:30:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DC491EC9
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D12D3063AAB
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A393B95E9;
	Wed, 29 Apr 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b="C87voxvv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.piware.de (mail.piware.de [37.120.164.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2C3B95F9
	for <cgroups@vger.kernel.org>; Wed, 29 Apr 2026 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.164.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454880; cv=none; b=aH1QNIjikKg1nIpbPWoz+jzXAAK6wR0hHYo5HXouH7o3qxmk2rbqJCq8xEYxGsUMi4Udz0SdF/R2H4SBFHhDPRc42ND9SPcZghsDJQSgYhmp3uiQz/1ba1WjxgV8/c5607CxZ5MY3oNC2nssNlhJuwzVpec1GRy/oYG/jVQlXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454880; c=relaxed/simple;
	bh=lbnV1yh2q7Kw2N6Hs/665oEorNYsmRrbx0PyoUuKNVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hyrIlOYZSF30ddlBXEiaz2KuhGNRp78xpUBZmRDsZlUyXRXrN9HyT+nHF0HXVDo8k56FUip18HsWiECRLzokUpYx+jQUpD5/fFFtpFFjfwvm4ZWSkfb8bpC0y/OigoQZew+2WpTkacZ4e+IHMYlotAtsOOzPj/Uo0WGMjkD3Mqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de; spf=pass smtp.mailfrom=piware.de; dkim=pass (2048-bit key) header.d=piware.de header.i=@piware.de header.b=C87voxvv; arc=none smtp.client-ip=37.120.164.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=piware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piware.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piware.de; s=2025;
	t=1777454468; bh=lbnV1yh2q7Kw2N6Hs/665oEorNYsmRrbx0PyoUuKNVs=;
	h=Date:From:To:Cc:Subject:From;
	b=C87voxvvfYTJiTUkg/JB+oLEJkglbZQ1oN3PO5bPjHZeKaQMsVhU9PfSfzflWZ/Mk
	 80yTwbhQol4ZazuH+8cGpejhmVZVOfmnH8spFncT9SqiK+ME9OR2O/SqTCHCLqJgZ2
	 wduFKsEsRmzA2NjOeiWFLAxpBmbhic0+QolP7eUn8GLpwXyVcsLNYeIqSGwhs/VdYX
	 CJ9PmaAobAKz1dHsn2Y024TfZdc9dGrGKk7JQkNC06RTVKfmOuuSvlgREGGKnN6FJO
	 Dr3bIZpB7K7No6RLX2tNmfxMymow5pdQ7RYp1VbMu/pGAsnV3Snf3eLke2OhsAJLsF
	 +D3drWwN+dlWQ==
Received: from piware.de (localhost [127.0.0.1])
	by mail.piware.de (Postfix) with ESMTP id 81470FF881;
	Wed, 29 Apr 2026 11:21:08 +0200 (CEST)
Date: Wed, 29 Apr 2026 11:21:07 +0200
From: Martin Pitt <martin@piware.de>
To: regressions@lists.linux.dev
Cc: cgroups@vger.kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Subject: [REGRESSION] 6.9.11: systemd hangs in cgroup_drain_dying during
 cleanup after podman operations
Message-ID: <afHNg2VX2jy9bW7y@piware.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A6DC491EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[piware.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[piware.de:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15552-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[piware.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@piware.de,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

Our cockpit tests found a kernel regression introduced between 6.9.10 (working)
and 6.9.11 (broken) that causes a system hang during cgroup cleanup after
podman container operations. I've kept notes in
https://github.com/cockpit-project/bots/pull/8970#issuecomment-4342147158 , but
now I am at the end of my wisdom how to squeeze more information out of this.

=== Summary ===

When running podman REST API operations on rootless containers followed by user
session cleanup (loginctl/pkill), systemd (pid 1) gets stuck in
cgroup_drain_dying trying to remove an empty cgroup. After that, I'm

- Unable to run commands that access /proc (ps, top, lsns, ls /proc, etc.)
- Unable to create new SSH sessions or VT logins
- If I previously logged into the QEMU VT, that login session remains
  more or less functional, except not being able to run most commands

=== Kernel Versions ===

- Last known working: 6.9.10
- Broken: 6.9.11 (OpenSUSE Tumbleweed), 6.9.13 (Fedora 44), 6.9.14 (Fedora 44),
  Ubuntu 26.04 (7.0.0)

=== Stack Trace ===

From sysrq-trigger task dump, systemd is stuck in:

[  207.958946] task:systemd         state:D stack:0     pid:1     tgid:1     ppid:0
[  207.959734] Call Trace:
[  207.960117]  <TASK>
[  207.960333]  __schedule+0x2b2/0x5d0
[  207.960603]  schedule+0x27/0x80
[  207.960945]  cgroup_drain_dying+0xef/0x1a0
[  207.961287]  ? __pfx_autoremove_wake_function+0x10/0x10
[  207.961639]  cgroup_rmdir+0x37/0x100
[  207.961945]  kernfs_iop_rmdir+0x6a/0xd0
[  207.962239]  vfs_rmdir+0x154/0x270
[  207.962486]  do_rmdir+0x201/0x280
[  207.962723]  __x64_sys_unlinkat+0x8c/0xd0

=== Observations ===

- /sys/fs/cgroup/user.slice/user-1000.slice/cgroup.procs was empty, indicating
  all processes were killed but the cgroup itself cannot be removed
- Multiple zombie processes present, unable to be reaped (user@1000.service
  systemd, podman, conmon processes)
- RCU subsystem appears healthy (rcu_exp_gp_kthr in S state)

=== Reproducer ===

The bug is triggered by a specific sequence of podman REST API operations on
rootless containers, followed by user cleanup. The reproducer is part of the
cockpit-podman test suite. I created a branch where I reduced the test to the
absolute minimum, and also replaced as many UI clicks as possible with shell
operations (all but one):

  https://github.com/martinpitt/cockpit-podman/blob/kernel-hang/test/check-application#L1486

Sequence:
1. Create and stop a rootless container as the admin user
2. Call podman REST API lifecycle operations: start → restart → stop
3. Create an exec session (console/TTY connection) via REST API
4. Start the container again via REST API
5. Cleanup: loginctl terminate-user admin; loginctl kill-user admin; pkill -9 -u admin

Using podman CLI commands (e.g., "podman start swamped-crate") instead of the
REST API does NOT trigger the hang, only when using the REST API. That may be
because of the different process layout, or just sheer timing -- as eventually,
both CLI and API should result in the same actual cgroup/container operations
on the podman side.

The bug is very timing-sensitive. I attempted to create a standalone shell
script reproducer, but failed, it always passes with that. Even with the
original cockpit-podman integration test failure it's unreliable: it can hang
on the first iteration, most of the time it fails within 5 runs, but I've had
stretches where 50+ iterations passed before the hang happened.

=== Full debug output ===

The above GitHub PR comment links to the full dmesg log. Direct link:
https://github.com/user-attachments/files/27195205/dmesg-cgrouphang.txt

This covers initial boot up to the hang, and then the outputs of sysrq task
dump (t), memory info (m), and blocked tasks (w).

=== Additional Notes ===

In one early test run, a different hang pattern was observed where
rcu_exp_gp_kthr was in D state with a process stuck in
synchronize_rcu_expedited during namespace cleanup, but this variant has not
reproduced in subsequent runs. The cgroup cleanup deadlock appears to be the
primary manifestation.

This is my first (non-trivial) kernel bug report, so please bear with me. I'm
normally stay firmly in userland.

Thanks,

Martin Pitt

