Return-Path: <cgroups+bounces-16498-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XhYBDeiBHGp9OwkAu9opvQ
	(envelope-from <cgroups+bounces-16498-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 20:46:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB86178A6
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F723014977
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6F27BF93;
	Sun, 31 May 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="kDcr2Pzc"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2BBA3D;
	Sun, 31 May 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253156; cv=none; b=ZvVk1fDet/LOGITRaYydG4e18ynz8TIth9VU2J3zfswBBnSInI71Dc6f0cvkGVGHvZ4jfDCXjymiWKB7KUskFW5E5BZSN/p/aq31aV4e0jO/bcowGB14oKi7JiFhPVfG8dJ760qNSfTYmtijVkPNnzEjBU5MvjR9oxIVskwN/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253156; c=relaxed/simple;
	bh=C+n3ipnniUpHsjEyZXaV5XM9lxXibB7IYHMt7blN4+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jfm58B8hiOo9bT5jJES4l1edwD+o7jZj9R51NsfVKKI9omfiGuKlkZQxbaUn/mIDwjWC1yMVrSb45nZK6Wg/ojJZO8/N55P7mjtz42OppjzywkLgW4GeLBbfnKSo9mrLLa5iCPXYkp4qxjye43f7BrzqIvvadWSv2aCe7rxB6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=kDcr2Pzc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780253132; x=1780857932; i=spasswolf@web.de;
	bh=LFGmwpUPo4KFn3u0lTE0ipYME3o+jjYvY8sEwMfp2Q4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kDcr2Pzcv8yPpd3dQ1Y4ujhAyO2eVCmYdP02svHHIvDqvTE7dO08ixYH+vDjtj2H
	 gTj4nAlb3J9qA4CpC0ypRvE197CGfWTOPvwQVORkiGq6b2AxUnZUIUN/tr/f9kyVX
	 pmveMF07Y7kn7p5nLvQhF0Wj/iYoHvb+rSOEelmDlK3LtlGG5QF/b9NdGnDdSYH4q
	 K2RHcUiQM5EIwxWktjeXLuF4Ff7GVGF1nNaK4Yd0PiXhWrpNllvZBRGVXooSrXBIW
	 RqX2VFxuheOVlaBJtuU01sry5gZDJCbI6WnDKO9o6BlHl1mM3qoA6XsIYQrK0QAqs
	 ONSIfEcAZgn6yjNeKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1xI1fH1XDj-00uIw0; Sun, 31
 May 2026 20:45:32 +0200
Message-ID: <4e986b4ed7e16547805d54b6e67d09120bc4d2f2.camel@web.de>
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
From: Bert Karwatzki <spasswolf@web.de>
To: Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, spasswolf@web.de, Michal
 =?ISO-8859-1?Q?Koutn=FD?=	 <mkoutny@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Malat <oss@malat.biz>, kernel test robot
 <oliver.sang@intel.com>, Martin Pitt <martin@piware.de>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Date: Sun, 31 May 2026 20:45:30 +0200
In-Reply-To: <8b15e2465901b48ee63f4827c69a67ff6d0e6098.camel@web.de>
References: <20260505005121.1230198-1-tj@kernel.org>
			 <20260505005121.1230198-6-tj@kernel.org>
			 <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
			 <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
			 <fd72aa26-4fed-4fcb-b4b1-d7ce9d891fe4@sirena.org.uk>
	 <8b15e2465901b48ee63f4827c69a67ff6d0e6098.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3wp3ckbAC9I1I5eZq39rLmuxKbvDw+qXUkUYdbiJw2snoSMAHDO
 4KSKwUzKiHo9JpQUeyqCorS25FEyoMZ4ZTSTTE69zGCqfdyKKvEuGkDxpVt/ncN4IDoOSWs
 ohrNrnexW6qx8jiun++vXXfB98eikayAy+57pTI0jmsJKbjtwhKl3OEWtnpfEGVvpNbt4lz
 aGPWEzIjGuoaPahdfLCig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eYm60qgEqv8=;W8QMK6/8bR1gcH0eL1o/eOy4eBh
 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
 8WsnxdaZd8Zo3LnP/o=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16498-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,web.de,suse.com,linutronix.de,malat.biz,intel.com,piware.de,vger.kernel.org,arm.com];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 86DB86178A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Sonntag, dem 31.05.2026 um 11:19 +0200 schrieb Bert Karwatzki:
> Am Freitag, dem 29.05.2026 um 22:08 +0100 schrieb Mark Brown:
> > On Fri, May 29, 2026 at 07:25:29AM -1000, Tejun Heo wrote:
> > > On Wed, May 27, 2026 at 11:45:54AM +0100, Mark Brown wrote:
> > > > On Mon, May 04, 2026 at 02:51:21PM -1000, Tejun Heo wrote:
> >=20
> > > > with no further output and given that this is a cgroup locking cha=
nge
> > > > this does seem like a plausible commmit, though I didn't look into=
 it in
> > > > detail.  Bisect log and the list of LTP tests we're running in our=
 test
> > > > job below.  We are running multuple tests in parallel.
> >=20
> > > Unfortunately, I can't reproduce this in my environment. Any chance =
you can
> > > try testing on x86 tooa nd see whether it produces there?
> >=20
> > Not readily sadly, I'll see if I can figure something out.  Our rootfs
> > images are based on Debian Trixie if that's relevant?
>=20
> Using debian unstable (sid/forky) I can at least detect a timeout when r=
unning
> the ltp controller testsuite:
>=20
> # LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers
> Host information
>  Hostname: homer
>  Python: 3.13.12 (main, Feb 4 2026, 15:06:39) [GCC 15.2.0]
>  Directory: /tmp/kirk.root/tmp092in2yb
>=20
> Connecting to SUT: default
>=20
> Suite: controllers
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
> cgroup_core01: pass  (0.024s)
> cgroup_core02: pass  (0.004s)
> cgroup_core03: pass  (0.017s)
> cgroup: skip  (2m 41s)
> memcg_regression: skip  (3.414s)
> memcg_test_3: pass  (0.090s)
> memcg_failcnt: skip  (0.019s)
> memcg_force_empty: skip  (0.015s)
> memcg_limit_in_bytes: skip  (0.017s)
> memcg_stat_rss: skip  (0.015s)
> memcg_subgroup_charge: skip  (0.015s)
> memcg_max_usage_in_bytes: skip  (0.014s)
> memcg_move_charge_at_immigrate: skip  (0.014s)
> memcg_memsw_limit_in_bytes: skip  (0.015s)
> memcg_stat: skip  (0.015s)
> memcg_use_hierarchy: skip  (0.015s)
> memcg_usage_in_bytes: skip  (0.014s)
> memcg_stress: pass  (30m 4s)
> memcg_control: pass  (6.058s)
> memcontrol01: pass  (0.004s)
> memcontrol02: pass  (0.636s)
> memcontrol03: pass  (15.983s)
> memcontrol04: pass  (0.890s)
> cgroup_fj_function_debug: skip  (0.013s)
> cgroup_fj_function_cpuset: skip  (0.044s)
> cgroup_fj_function_cpu: skip  (0.050s)
> cgroup_fj_function_cpuacct: pass  (0.052s)
> cgroup_fj_function_memory: skip  (0.042s)
> cgroup_fj_function_freezer: pass  (0.044s)
> cgroup_fj_function_devices: pass  (0.066s)
> cgroup_fj_function_blkio: skip  (0.009s)
> cgroup_fj_function_net_cls: pass  (0.073s)
> cgroup_fj_function_perf_event: pass  (0.072s)
>=20
>=20
> Execution time: 1h 33m 13s
>=20
> Disconnecting from SUT: default
>=20
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
> Kernel:   Linux 7.1.0-rc5-next-20260528-master-dirty #480 SMP PREEMPT_RT=
 Thu May 28 19:55:12 CEST 2026
> Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.1.0-rc5-next-20260528-master-dirt=
y
>           root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
>           ro
>           quiet
> Machine:  unknown
> Arch:     x86_64
> RAM:      63439380 kB
> Swap:     78125052 kB
> Distro:   debian=20
>=20
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       TEST SUMMARY
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> Suite:   controllers
> Runtime: 33m 13s
> Runs:    347
>=20
> Results:
>     Passed:   181
>     Failed:   0
>     Broken:   0
>     Skipped:  350
>     Warnings: 0
>=20
> Session stopped
>=20
> In dmesg I get messages about task tst_cgtl hanging:
>=20
> [ 2212.794669] [    T346] INFO: task tst_cgctl:317896 blocked for more t=
han 122 seconds.
> [ 2212.794674] [    T346]       Not tainted 7.1.0-rc5-next-20260528-mast=
er-dirty #480
> [ 2212.794675] [    T346] "echo 0 > /proc/sys/kernel/hung_task_timeout_s=
ecs" disables this message.
>=20
> [...]=20
>=20
> [ 3318.721344] [    T346] INFO: task tst_cgctl:317896 blocked for more t=
han 1228 seconds.
> [ 3318.721349] [    T346]       Not tainted 7.1.0-rc5-next-20260528-mast=
er-dirty #480
> [ 3318.721351] [    T346] "echo 0 > /proc/sys/kernel/hung_task_timeout_s=
ecs" disables this message.
>=20
>=20
>=20
>=20
>=20
>=20
> On 6.19.14 the Results of this testrun is:
>=20
> # LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers
>=20
> [...]
>=20
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
> Kernel:   Linux 6.19.14-stable #1238 SMP PREEMPT_RT Sat May 30 17:28:29 =
CEST 2026
> Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-6.19.14-stable
>           root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
>           ro
>           quiet
> Machine:  unknown
> Arch:     x86_64
> RAM:      63436188 kB
> Swap:     78125052 kB
> Distro:   debian=20
>=20
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       TEST SUMMARY
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> Suite:   controllers
> Runtime: 36m 12s
> Runs:    347
>=20
> Results:
>     Passed:   1742
>     Failed:   0
>     Broken:   0
>     Skipped:  97
>     Warnings: 0
>=20
> Session stopped
>=20
> With 6.19.14 I also get no hung tasks.
>=20
> On 7.0.10 the tests also work:
>=20
> root@homer:/mnt/data/linux-forest/kirk# LTPROOT=3D/home/bert/ltp-install=
/ ./kirk --run-suite controllers
> Host information
> 	Hostname:   homer
> 	Python:     3.13.12 (main, Feb  4 2026, 15:06:39) [GCC 15.2.0]
> 	Directory:  /tmp/kirk.root/tmpq32b09g7
>=20
> Connecting to SUT: default
>=20
> Suite: controllers
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
> cgroup_core01: pass  (0.016s)
>=20
> [...]
>=20
> pids_9_100: pass  (0.107s)
>=20
> Execution time: 36m 15s
>=20
> Disconnecting from SUT: default
>=20
> Target information
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
> Kernel:   Linux 7.0.10-stable #1239 SMP PREEMPT_RT Sun May 31 00:42:41 C=
EST 2026
> Cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.0.10-stable
>           root=3DUUID=3D3d5cdc5d-1902-40bf-9e16-ca819372d350
>           ro
>           quiet
> Machine:  unknown
> Arch:     x86_64
> RAM:      63435940 kB
> Swap:     78125052 kB
> Distro:   debian=20
>=20
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>       TEST SUMMARY
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> Suite:   controllers
> Runtime: 36m 13s
> Runs:    347
>=20
> Results:
>     Passed:   1742
>     Failed:   0
>     Broken:   0
>     Skipped:  97
>     Warnings: 0
>=20
> Session stopped
>=20
>=20
>=20
> I'm not sure if this is related to the problems on arm64, but I'll try b=
isecting this.
>=20
> Bert Karwatzki

I finished my bisectiOn (from v7.0.0 to next-20260528) and it shows=20

commit 1dffd95575eb ("cgroup: Defer kill_css_finish() in cgroup_apply_cont=
rol_disable()")

as first bad commit, too. During the bisection I had to apply this patch (=
when it's cleanly applicable)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..712316a1e3e0 100644
=2D-- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen +=3D strlen("nodev");
-		newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
=20
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen =3D=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
 	 * Did the list change in the meantime?
 	 */
 	if (gen !=3D file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_string(=
void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
=20
 	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
+	 * Paired with consume fence in rcu_dereference() in filesystems_proc_sh=
ow()
 	 */
 	smp_store_release(&file_systems_string, new);
 	spin_unlock(&file_systems_lock);


to take care of a locking issue in commit
36b3306779ea ("fs: cache the string generated by reading /proc/filesystems=
")
https://lore.kernel.org/all/20260520225245.2962-1-spasswolf@web.de/

The test that hang when running
# LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers
is always  cgroup_fj_function_net_prio.
Also when bisecting this I disabled (i.e. commented out) the
memcg_stress test in ~/ltp-install/runtest/controllers as it takes a lot o=
f
time (30min) and succeeds even in the version where hangs occur.

Bert Karwatzki

