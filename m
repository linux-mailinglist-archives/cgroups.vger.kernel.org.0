Return-Path: <cgroups+bounces-16486-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O8WDZP+G2oaIQkAu9opvQ
	(envelope-from <cgroups+bounces-16486-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 11:25:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31B61555A
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD67300EAB1
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2530EF77;
	Sun, 31 May 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="az3tWR5w"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56732E7382;
	Sun, 31 May 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219530; cv=none; b=c4BjotLakewQ/+CWedgJ5o1qAtdthzW3lQoXVY5k3EcVjDeu/GiRTmc+ul2ED9dEIwI1aM1Kq5abIequY/k8N8hBeJQWTP9ZU/Ym88UkXEIwhtHGexxUei+TjXyrqTMhyrWFfVrMgFsia4bOE4fXOKA8cQF9ju8PjPuyg9YOSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219530; c=relaxed/simple;
	bh=z2ACZIA6dK1pnTmD4y1Uuc5PTQ+UNlNCML2ujY8goTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGUxnwuFnCztL8Hr5QRbvLBEWTpcWIAe2CyLEEwlhEMk1aqLOBLGsDv2uJww6OoyJrkaqzoMevIfnp2r7YEIs7E2j98R3+R0eX/JkSrD32QXUGKgQePFjUQODNyz7G/OrHhJ3el64tLjL6mDlGb56cbZiEv2iHmfPPTkg8aQUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=az3tWR5w; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780219526; x=1780824326; i=spasswolf@web.de;
	bh=3gOrMi4X1MYwq05TPQ9gTFvL1sPr1d7Ctflj2G+aISU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=az3tWR5wc+qcHTx5rggh4N+kO3Am6B1rLccW6K1n9jyPvgljpye7uG3znnXs7kWO
	 IYSNvKA5xzfEwH1zE/aK6Dlfe2Myu/ztKwfQsOxzN5B5PN2WwZeSJC2hQ23xEuY1f
	 A7gdN9QFBAsiVHWyfI00zj/n8Qv+WV+51jtSCBvIYy55AUxECpGll+SgtFikM9JU8
	 4rGvDwvp5ImbADefwGOEPrPBYliehf7aRPfgA99p2J766Pz36hJG3SalsaCzFNKv0
	 bLz9w7jWk5vvQYIylXADcx27ZJCYeA99oJ45nApYLDR25kAETwcrTuf2NZ6AAwNUJ
	 cV7tKM0V1FNNU+cPJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1wl9DI0i6S-00RQy5; Sun, 31
 May 2026 11:19:32 +0200
Message-ID: <8b15e2465901b48ee63f4827c69a67ff6d0e6098.camel@web.de>
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
From: Bert Karwatzki <spasswolf@web.de>
To: Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, "spasswolf@web.de Michal"
 =?ISO-8859-1?Q?Koutn=FD?=	 <mkoutny@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Malat <oss@malat.biz>, kernel test robot
 <oliver.sang@intel.com>, Martin Pitt <martin@piware.de>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Date: Sun, 31 May 2026 11:19:30 +0200
In-Reply-To: <fd72aa26-4fed-4fcb-b4b1-d7ce9d891fe4@sirena.org.uk>
References: <20260505005121.1230198-1-tj@kernel.org>
		 <20260505005121.1230198-6-tj@kernel.org>
		 <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
		 <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
		 <fd72aa26-4fed-4fcb-b4b1-d7ce9d891fe4@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PJpERjCmYp7QAntkte6DQ8j+G3H5J88WPns8jX4HLS+/K469IRT
 ipFppwsqcYoafYaixsckeuh9JoqgzWEH9wxmOqD2k3KfneBwLt6GlFH5OLF3qPRSDjFrABG
 u6JQT/SBiBPbVsOpkFJF/guc8PHJkO6UD+UA2Iglm8INFTMROHULfADewCvTe/dbxlIXo2g
 4nWMrc7gsgqHtmPijXn8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VqTdsRsOAfo=;dsh2NsANL2SPc1yCCauc2rrY8ZT
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16486-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A31B61555A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Freitag, dem 29.05.2026 um 22:08 +0100 schrieb Mark Brown:
> On Fri, May 29, 2026 at 07:25:29AM -1000, Tejun Heo wrote:
> > On Wed, May 27, 2026 at 11:45:54AM +0100, Mark Brown wrote:
> > > On Mon, May 04, 2026 at 02:51:21PM -1000, Tejun Heo wrote:
>=20
> > > with no further output and given that this is a cgroup locking chang=
e
> > > this does seem like a plausible commmit, though I didn't look into i=
t in
> > > detail.  Bisect log and the list of LTP tests we're running in our t=
est
> > > job below.  We are running multuple tests in parallel.
>=20
> > Unfortunately, I can't reproduce this in my environment. Any chance yo=
u can
> > try testing on x86 tooa nd see whether it produces there?
>=20
> Not readily sadly, I'll see if I can figure something out.  Our rootfs
> images are based on Debian Trixie if that's relevant?

Using debian unstable (sid/forky) I can at least detect a timeout when run=
ning
the ltp controller testsuite:

# LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers
Host information
 Hostname: homer
 Python: 3.13.12 (main, Feb 4 2026, 15:06:39) [GCC 15.2.0]
 Directory: /tmp/kirk.root/tmp092in2yb

Connecting to SUT: default

Suite: controllers
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
cgroup_core01: pass  (0.024s)
cgroup_core02: pass  (0.004s)
cgroup_core03: pass  (0.017s)
cgroup: skip  (2m 41s)
memcg_regression: skip  (3.414s)
memcg_test_3: pass  (0.090s)
memcg_failcnt: skip  (0.019s)
memcg_force_empty: skip  (0.015s)
memcg_limit_in_bytes: skip  (0.017s)
memcg_stat_rss: skip  (0.015s)
memcg_subgroup_charge: skip  (0.015s)
memcg_max_usage_in_bytes: skip  (0.014s)
memcg_move_charge_at_immigrate: skip  (0.014s)
memcg_memsw_limit_in_bytes: skip  (0.015s)
memcg_stat: skip  (0.015s)
memcg_use_hierarchy: skip  (0.015s)
memcg_usage_in_bytes: skip  (0.014s)
memcg_stress: pass  (30m 4s)
memcg_control: pass  (6.058s)
memcontrol01: pass  (0.004s)
memcontrol02: pass  (0.636s)
memcontrol03: pass  (15.983s)
memcontrol04: pass  (0.890s)
cgroup_fj_function_debug: skip  (0.013s)
cgroup_fj_function_cpuset: skip  (0.044s)
cgroup_fj_function_cpu: skip  (0.050s)
cgroup_fj_function_cpuacct: pass  (0.052s)
cgroup_fj_function_memory: skip  (0.042s)
cgroup_fj_function_freezer: pass  (0.044s)
cgroup_fj_function_devices: pass  (0.066s)
cgroup_fj_function_blkio: skip  (0.009s)
cgroup_fj_function_net_cls: pass  (0.073s)
cgroup_fj_function_perf_event: pass  (0.072s)
cgroup_fj_function_net_prio: Suite 'controllers' timed out after 3600 seco=
nds

Execution time: 1h 33m 13s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
Kernel:   Linux 7.1.0-rc5-next-20260528-master-dirty #480 SMP PREEMPT_RT T=
hu May 28 19:55:12 CEST 2026
Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.1.0-rc5-next-20260528-master-dirty
          root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
          ro
          quiet
Machine:  unknown
Arch:     x86_64
RAM:      63439380 kB
Swap:     78125052 kB
Distro:   debian=20

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   controllers
Runtime: 33m 13s
Runs:    347

Results:
    Passed:   181
    Failed:   0
    Broken:   0
    Skipped:  350
    Warnings: 0

Session stopped

In dmesg I get messages about task tst_cgtl hanging:

[ 2212.794669] [    T346] INFO: task tst_cgctl:317896 blocked for more tha=
n 122 seconds.
[ 2212.794674] [    T346]       Not tainted 7.1.0-rc5-next-20260528-master=
-dirty #480
[ 2212.794675] [    T346] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.

[...]=20

[ 3318.721344] [    T346] INFO: task tst_cgctl:317896 blocked for more tha=
n 1228 seconds.
[ 3318.721349] [    T346]       Not tainted 7.1.0-rc5-next-20260528-master=
-dirty #480
[ 3318.721351] [    T346] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.






On 6.19.14 the Results of this testrun is:

# LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers

[...]

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
Kernel:   Linux 6.19.14-stable #1238 SMP PREEMPT_RT Sat May 30 17:28:29 CE=
ST 2026
Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-6.19.14-stable
          root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
          ro
          quiet
Machine:  unknown
Arch:     x86_64
RAM:      63436188 kB
Swap:     78125052 kB
Distro:   debian=20

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   controllers
Runtime: 36m 12s
Runs:    347

Results:
    Passed:   1742
    Failed:   0
    Broken:   0
    Skipped:  97
    Warnings: 0

Session stopped

With 6.19.14 I also get no hung tasks.

On 7.0.10 the tests also work:

root@homer:/mnt/data/linux-forest/kirk# LTPROOT=3D/home/bert/ltp-install/ =
./kirk --run-suite controllers
Host information
	Hostname:   homer
	Python:     3.13.12 (main, Feb  4 2026, 15:06:39) [GCC 15.2.0]
	Directory:  /tmp/kirk.root/tmpq32b09g7

Connecting to SUT: default

Suite: controllers
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
cgroup_core01: pass  (0.016s)

[...]

pids_9_100: pass  (0.107s)

Execution time: 36m 15s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
Kernel:   Linux 7.0.10-stable #1239 SMP PREEMPT_RT Sun May 31 00:42:41 CES=
T 2026
Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.0.10-stable
          root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
          ro
          quiet
Machine:  unknown
Arch:     x86_64
RAM:      63435940 kB
Swap:     78125052 kB
Distro:   debian=20

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   controllers
Runtime: 36m 13s
Runs:    347

Results:
    Passed:   1742
    Failed:   0
    Broken:   0
    Skipped:  97
    Warnings: 0

Session stopped



I'm not sure if this is related to the problems on arm64, but I'll try bis=
ecting this.

Bert Karwatzki

