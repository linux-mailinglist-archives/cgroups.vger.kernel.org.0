Return-Path: <cgroups+bounces-16346-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WProI5LLFmr7sAcAu9opvQ
	(envelope-from <cgroups+bounces-16346-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 12:46:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24695E2EE7
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9DD300AB00
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3D3F39C6;
	Wed, 27 May 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCJYAjrx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27858F7D;
	Wed, 27 May 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878761; cv=none; b=jZ2BvpyR9vMdBuawSQ+XU9qd/v20L1tpNBdr7e+K+NWLnn8zV7HJi7n1f5qzqOvNpoBLd3eZXNO1f0zO34pbjf9k/RKBNXLwBB4KnmP/ZL8QrZueOcVQjsFvzxINJeOJOPMVro8FRIGdFhLw0UqhECopUsKc64/rB7vbdApjnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878761; c=relaxed/simple;
	bh=723Op351wS54GuGCfDJOYFzjr8WQN2rOeYslE5bwBI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU9jn+NsYUzRhWPUo0VBSmqrVNXYTz+e6K3s5HWPoI2+eEQRGLhT9E6+mjDZlYCRF9l48fJH7mL5zmnO9qWiY6YAWETSCFdR6NRf/aPm0phkfLLCo7NOkU3XLuEslxJi115I/gwrS6xvBWXGq8hUajpycROVVejl4Sc40hpl0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCJYAjrx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAA21F000E9;
	Wed, 27 May 2026 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878759;
	bh=c+pjRVAsZZ54Fz4Gr9BMt8Bv0VKGjYeVhiilbZlZUEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCJYAjrxZ+/uafgt1MMG05m2wdeURHGSvgrJRUjkFmUUUMoa7mZD7s1caZrgTKCSH
	 DKTCKANmaoy2Lm+npvTF28Mx6aoqlmK7nCQO/43llGXg7kdUAxdfkEIHifUycslyow
	 yrV0FXcqOXPnfNbX++eHSl6dO2sPQZXRS1hkmcQUIvv7gv/ceQwUv3M0ivoSImNZxE
	 YUkotqcui030DeHT2yGXSCfC8ALxgp/Khnoog3G46Eh4ZUPUjnBW/OZBn/d4wxJqnz
	 p1mmTdvOeK+g7IBCsjadFfuvGgQ/1QrRgMelbrA8D6silVVUksp+JdmF5+kDS9lWx6
	 AYUSTcrECU6Zw==
Date: Wed, 27 May 2026 11:45:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>, Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
Message-ID: <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
References: <20260505005121.1230198-1-tj@kernel.org>
 <20260505005121.1230198-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YphcTKzXUfvVlAy+"
Content-Disposition: inline
In-Reply-To: <20260505005121.1230198-6-tj@kernel.org>
X-Cookie: That's no moon...
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16346-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: E24695E2EE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--YphcTKzXUfvVlAy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2026 at 02:51:21PM -1000, Tejun Heo wrote:

> Same race shape as the rmdir path that 93618edf7538 ("cgroup: Defer css
> percpu_ref kill on rmdir until cgroup is depopulated") fixed: a task past
> exit_signals() whose cset subsys[ssid] still pins the disabled controller's
> css can be touching subsys state while ->css_offline() runs. The earlier
> patches in this series built up the per-subsys-css deferral machinery and
> routed cgroup_destroy_locked() through it. Apply the same shape to
> cgroup_apply_control_disable():

We've been seeing hangs during testing in our testing of -next on
multiple arm64 platforms when running LTP test jobs which bisect to this
patch, which is 1dffd95575eb05bc7e in -next.  It looks like we hit a
deadlock running stress tests, the end of a typical log looks like this:

<12>[  181.849144] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_none: end (returncode: 0)
<12>[  181.860375] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_one: start (command: cgroup_fj_stress.sh blkio 3 3 one)
cgroup_fj_stress_blkio_3_3_one: pass  (1.166s)
<12>[  183.053379] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_one: end (returncode: 0)
<12>[  183.064884] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_each: start (command: cgroup_fj_stress.sh blkio 4 4 each)
cgroup_fj_stress_blkio_4_4_each: pass  (8.183s)
<12>[  191.275815] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_each: end (returncode: 0)
<12>[  191.287614] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_none: start (command: cgroup_fj_stress.sh blkio 4 4 none)
cgroup_fj_stress_blkio_4_4_none: pass  (3.570s)
<12>[  194.884173] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_none: end (returncode: 0)
<12>[  194.895255] /opt/ltp/kirk[558]: cgroup_fj_stress_cpu_1_200_each: start (command: cgroup_fj_stress.sh cpu 1 200 each)

with no further output and given that this is a cgroup locking change
this does seem like a plausible commmit, though I didn't look into it in
detail.  Bisect log and the list of LTP tests we're running in our test
job below.  We are running multuple tests in parallel.

bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [d387b06f7c15b4639244ad66b4b0900c6a02b430] Add linux-next specific files for 20260525
git bisect bad d387b06f7c15b4639244ad66b4b0900c6a02b430
# status: waiting for good commit(s), bad commit known
# good: [c745c46074da99cdcef8c1fc6093030c6f9d7143] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good c745c46074da99cdcef8c1fc6093030c6f9d7143
# good: [4c0ea14d8ec6f6fcb94b7ad9248679ffcf747e9b] Merge branch 'libcrypto-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
git bisect good 4c0ea14d8ec6f6fcb94b7ad9248679ffcf747e9b
# good: [af3c2d822a4b67034aa47554c178b5ffcf973456] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect good af3c2d822a4b67034aa47554c178b5ffcf973456
# good: [2f8df83b202ec7f8080a25b2e9da79c3361775fd] Merge branch 'char-misc-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
git bisect good 2f8df83b202ec7f8080a25b2e9da79c3361775fd
# good: [1c70737e40e31fb0ba2d49ba06f8cac7a5e809a3] Merge branch 'staging-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 1c70737e40e31fb0ba2d49ba06f8cac7a5e809a3
# bad: [4be0d6b749c63b04d4daebf43925149271943af4] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
git bisect bad 4be0d6b749c63b04d4daebf43925149271943af4
# bad: [1feee04d568fb4c3f56beaea3735da71d159b6f6] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
git bisect bad 1feee04d568fb4c3f56beaea3735da71d159b6f6
# bad: [adfcff24160cca9a20fd0bf8a1b8b5cacba6061d] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
git bisect bad adfcff24160cca9a20fd0bf8a1b8b5cacba6061d
# good: [a234764e334b01b4b4a631b1c94df3458f3f57cb] Merge branch 'for-7.1-fixes' into for-next
git bisect good a234764e334b01b4b4a631b1c94df3458f3f57cb
# bad: [81807796db07bb1a4c066c75ccb5fcf04cbea3ed] Merge branch 'for-7.1-fixes' into for-next
git bisect bad 81807796db07bb1a4c066c75ccb5fcf04cbea3ed
# good: [c4799253a3ee74ebb27be72fb991c597a5902c01] cgroup: Move populated counters to cgroup_subsys_state
git bisect good c4799253a3ee74ebb27be72fb991c597a5902c01
# bad: [6c79fb30f5cd939f22959bd9b54d7f30c713a759] Merge branch 'for-7.2' into for-next
git bisect bad 6c79fb30f5cd939f22959bd9b54d7f30c713a759
# bad: [1dffd95575eb05bc7ec20ec096ce73be4c5d1ed5] cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()
git bisect bad 1dffd95575eb05bc7ec20ec096ce73be4c5d1ed5
# good: [cfc1da7e1127b4c8787f4dc25d59987c10c9107f] cgroup: Add per-subsys-css kill_css_finish deferral
git bisect good cfc1da7e1127b4c8787f4dc25d59987c10c9107f
# first bad commit: [1dffd95575eb05bc7ec20ec096ce73be4c5d1ed5] cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()

test list:

abort01 abort01
abs01 abs01
accept01 accept01
accept4_01 accept4_01
access01 access01
access02 access02
access03 access03
access04 access04
acct01 acct01
acct02 acct02
add_key01 add_key01
add_key02 add_key02
add_key03 add_key03
add_key04 add_key04
add_key05 add_key05
adjtimex01 adjtimex01
adjtimex02 adjtimex02
adjtimex03 adjtimex03
alarm02 alarm02
alarm03 alarm03
alarm05 alarm05
alarm06 alarm06
alarm07 alarm07
ar_sh export TCdat=$LTPROOT/testcases/bin; ar01.sh
asapi_01 asapi_01
asapi_02 asapi_02
asapi_03 asapi_03
atof01 atof01
autogroup01 autogroup01
bind01 bind01
bind02 bind02
bind03 bind03
bind04 bind04
bind05 bind05
binfmt_misc01 binfmt_misc01.sh
binfmt_misc02 binfmt_misc02.sh
brk01 brk01
capget01 capget01
capget02 capget02
capset01 capset01
capset02 capset02
capset03 capset03
capset04 capset04
cgroup_fj_function_blkio cgroup_fj_function.sh blkio
cgroup_fj_function_cpu cgroup_fj_function.sh cpu
cgroup_fj_function_cpuacct cgroup_fj_function.sh cpuacct
cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
cgroup_fj_function_devices cgroup_fj_function.sh devices
cgroup_fj_function_hugetlb cgroup_fj_function.sh hugetlb
cgroup_fj_function_memory cgroup_fj_function.sh memory
cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
cgroup_fj_stress_blkio_1_200_each cgroup_fj_stress.sh blkio 1 200 each
cgroup_fj_stress_blkio_1_200_none cgroup_fj_stress.sh blkio 1 200 none
cgroup_fj_stress_blkio_1_200_one cgroup_fj_stress.sh blkio 1 200 one
cgroup_fj_stress_blkio_200_1_each cgroup_fj_stress.sh blkio 200 1 each
cgroup_fj_stress_blkio_200_1_none cgroup_fj_stress.sh blkio 200 1 none
cgroup_fj_stress_blkio_2_2_each cgroup_fj_stress.sh blkio 2 2 each
cgroup_fj_stress_blkio_2_2_none cgroup_fj_stress.sh blkio 2 2 none
cgroup_fj_stress_blkio_2_2_one cgroup_fj_stress.sh blkio 2 2 one
cgroup_fj_stress_blkio_2_9_none cgroup_fj_stress.sh blkio 2 9 none
cgroup_fj_stress_blkio_3_3_each cgroup_fj_stress.sh blkio 3 3 each
cgroup_fj_stress_blkio_3_3_none cgroup_fj_stress.sh blkio 3 3 none
cgroup_fj_stress_blkio_3_3_one cgroup_fj_stress.sh blkio 3 3 one
cgroup_fj_stress_blkio_4_4_each cgroup_fj_stress.sh blkio 4 4 each
cgroup_fj_stress_blkio_4_4_none cgroup_fj_stress.sh blkio 4 4 none
cgroup_fj_stress_cpu_1_200_each cgroup_fj_stress.sh cpu 1 200 each
cgroup_fj_stress_cpu_1_200_none cgroup_fj_stress.sh cpu 1 200 none
cgroup_fj_stress_cpu_1_200_one cgroup_fj_stress.sh cpu 1 200 one
cgroup_fj_stress_cpu_200_1_each cgroup_fj_stress.sh cpu 200 1 each
cgroup_fj_stress_cpu_200_1_none cgroup_fj_stress.sh cpu 200 1 none
cgroup_fj_stress_cpu_2_2_each cgroup_fj_stress.sh cpu 2 2 each
cgroup_fj_stress_cpu_2_2_none cgroup_fj_stress.sh cpu 2 2 none
cgroup_fj_stress_cpu_2_2_one cgroup_fj_stress.sh cpu 2 2 one
cgroup_fj_stress_cpu_2_9_none cgroup_fj_stress.sh cpu 2 9 none
cgroup_fj_stress_cpu_3_3_each cgroup_fj_stress.sh cpu 3 3 each
cgroup_fj_stress_cpu_3_3_none cgroup_fj_stress.sh cpu 3 3 none
cgroup_fj_stress_cpu_3_3_one cgroup_fj_stress.sh cpu 3 3 one
cgroup_fj_stress_cpu_4_4_each cgroup_fj_stress.sh cpu 4 4 each
cgroup_fj_stress_cpu_4_4_none cgroup_fj_stress.sh cpu 4 4 none
cgroup_fj_stress_cpuacct_10_3_none cgroup_fj_stress.sh cpuacct 10 3 none
cgroup_fj_stress_cpuacct_1_200_each cgroup_fj_stress.sh cpuacct 1 200 each
cgroup_fj_stress_cpuacct_1_200_none cgroup_fj_stress.sh cpuacct 1 200 none
cgroup_fj_stress_cpuacct_1_200_one cgroup_fj_stress.sh cpuacct 1 200 one
cgroup_fj_stress_cpuacct_200_1_none cgroup_fj_stress.sh cpuacct 200 1 none
cgroup_fj_stress_cpuacct_200_1_one cgroup_fj_stress.sh cpuacct 200 1 one
cgroup_fj_stress_cpuacct_2_2_each cgroup_fj_stress.sh cpuacct 2 2 each
cgroup_fj_stress_cpuacct_2_2_none cgroup_fj_stress.sh cpuacct 2 2 none
cgroup_fj_stress_cpuacct_2_2_one cgroup_fj_stress.sh cpuacct 2 2 one
cgroup_fj_stress_cpuacct_2_9_none cgroup_fj_stress.sh cpuacct 2 9 none
cgroup_fj_stress_cpuacct_3_3_each cgroup_fj_stress.sh cpuacct 3 3 each
cgroup_fj_stress_cpuacct_3_3_none cgroup_fj_stress.sh cpuacct 3 3 none
cgroup_fj_stress_cpuacct_3_3_one cgroup_fj_stress.sh cpuacct 3 3 one
cgroup_fj_stress_cpuacct_4_4_each cgroup_fj_stress.sh cpuacct 4 4 each
cgroup_fj_stress_cpuacct_4_4_none cgroup_fj_stress.sh cpuacct 4 4 none
cgroup_fj_stress_cpuset_1_200_each cgroup_fj_stress.sh cpuset 1 200 each
cgroup_fj_stress_cpuset_1_200_none cgroup_fj_stress.sh cpuset 1 200 none
cgroup_fj_stress_cpuset_1_200_one cgroup_fj_stress.sh cpuset 1 200 one
cgroup_fj_stress_cpuset_200_1_none cgroup_fj_stress.sh cpuset 200 1 none
cgroup_fj_stress_cpuset_2_2_each cgroup_fj_stress.sh cpuset 2 2 each
cgroup_fj_stress_cpuset_2_2_none cgroup_fj_stress.sh cpuset 2 2 none
cgroup_fj_stress_cpuset_2_2_one cgroup_fj_stress.sh cpuset 2 2 one
cgroup_fj_stress_cpuset_3_3_each cgroup_fj_stress.sh cpuset 3 3 each
cgroup_fj_stress_cpuset_3_3_none cgroup_fj_stress.sh cpuset 3 3 none
cgroup_fj_stress_cpuset_3_3_one cgroup_fj_stress.sh cpuset 3 3 one
cgroup_fj_stress_cpuset_4_4_none cgroup_fj_stress.sh cpuset 4 4 none
cgroup_fj_stress_devices_10_3_none cgroup_fj_stress.sh devices 10 3 none
cgroup_fj_stress_devices_1_200_each cgroup_fj_stress.sh devices 1 200 each
cgroup_fj_stress_devices_1_200_none cgroup_fj_stress.sh devices 1 200 none
cgroup_fj_stress_devices_1_200_one cgroup_fj_stress.sh devices 1 200 one
cgroup_fj_stress_devices_200_1_each cgroup_fj_stress.sh devices 200 1 each
cgroup_fj_stress_devices_200_1_none cgroup_fj_stress.sh devices 200 1 none
cgroup_fj_stress_devices_2_2_each cgroup_fj_stress.sh devices 2 2 each
cgroup_fj_stress_devices_2_2_none cgroup_fj_stress.sh devices 2 2 none
cgroup_fj_stress_devices_2_2_one cgroup_fj_stress.sh devices 2 2 one
cgroup_fj_stress_devices_2_9_none cgroup_fj_stress.sh devices 2 9 none
cgroup_fj_stress_devices_3_3_each cgroup_fj_stress.sh devices 3 3 each
cgroup_fj_stress_devices_3_3_none cgroup_fj_stress.sh devices 3 3 none
cgroup_fj_stress_devices_3_3_one cgroup_fj_stress.sh devices 3 3 one
cgroup_fj_stress_devices_4_4_each cgroup_fj_stress.sh devices 4 4 each
cgroup_fj_stress_devices_4_4_none cgroup_fj_stress.sh devices 4 4 none
cgroup_fj_stress_hugetlb_1_200_each cgroup_fj_stress.sh hugetlb 1 200 each
cgroup_fj_stress_hugetlb_1_200_none cgroup_fj_stress.sh hugetlb 1 200 none
cgroup_fj_stress_hugetlb_1_200_one cgroup_fj_stress.sh hugetlb 1 200 one
cgroup_fj_stress_hugetlb_200_1_each cgroup_fj_stress.sh hugetlb 200 1 each
cgroup_fj_stress_hugetlb_200_1_none cgroup_fj_stress.sh hugetlb 200 1 none
cgroup_fj_stress_hugetlb_2_2_each cgroup_fj_stress.sh hugetlb 2 2 each
cgroup_fj_stress_hugetlb_2_2_none cgroup_fj_stress.sh hugetlb 2 2 none
cgroup_fj_stress_hugetlb_2_2_one cgroup_fj_stress.sh hugetlb 2 2 one
cgroup_fj_stress_hugetlb_2_9_none cgroup_fj_stress.sh hugetlb 2 9 none
cgroup_fj_stress_hugetlb_3_3_each cgroup_fj_stress.sh hugetlb 3 3 each
cgroup_fj_stress_hugetlb_3_3_none cgroup_fj_stress.sh hugetlb 3 3 none
cgroup_fj_stress_hugetlb_3_3_one cgroup_fj_stress.sh hugetlb 3 3 one
cgroup_fj_stress_hugetlb_4_4_each cgroup_fj_stress.sh hugetlb 4 4 each
cgroup_fj_stress_hugetlb_4_4_none cgroup_fj_stress.sh hugetlb 4 4 none
cgroup_fj_stress_memory_10_3_none cgroup_fj_stress.sh memory 10 3 none
cgroup_fj_stress_memory_1_200_each cgroup_fj_stress.sh memory 1 200 each
cgroup_fj_stress_memory_1_200_none cgroup_fj_stress.sh memory 1 200 none
cgroup_fj_stress_memory_1_200_one cgroup_fj_stress.sh memory 1 200 one
cgroup_fj_stress_memory_200_1_each cgroup_fj_stress.sh memory 200 1 each
cgroup_fj_stress_memory_200_1_none cgroup_fj_stress.sh memory 200 1 none
cgroup_fj_stress_memory_2_2_each cgroup_fj_stress.sh memory 2 2 each
cgroup_fj_stress_memory_2_2_none cgroup_fj_stress.sh memory 2 2 none
cgroup_fj_stress_memory_2_2_one cgroup_fj_stress.sh memory 2 2 one
cgroup_fj_stress_memory_2_9_none cgroup_fj_stress.sh memory 2 9 none
cgroup_fj_stress_memory_3_3_each cgroup_fj_stress.sh memory 3 3 each
cgroup_fj_stress_memory_3_3_none cgroup_fj_stress.sh memory 3 3 none
cgroup_fj_stress_memory_3_3_one cgroup_fj_stress.sh memory 3 3 one
cgroup_fj_stress_memory_4_4_each cgroup_fj_stress.sh memory 4 4 each
cgroup_fj_stress_memory_4_4_none cgroup_fj_stress.sh memory 4 4 none
cgroup_fj_stress_perf_event_1_200_each cgroup_fj_stress.sh perf_event 1 200 each
cgroup_fj_stress_perf_event_1_200_none cgroup_fj_stress.sh perf_event 1 200 none
cgroup_fj_stress_perf_event_1_200_one cgroup_fj_stress.sh perf_event 1 200 one
cgroup_fj_stress_perf_event_200_1_none cgroup_fj_stress.sh perf_event 200 1 none
cgroup_fj_stress_perf_event_200_1_one cgroup_fj_stress.sh perf_event 200 1 one
cgroup_fj_stress_perf_event_2_2_each cgroup_fj_stress.sh perf_event 2 2 each
cgroup_fj_stress_perf_event_2_2_none cgroup_fj_stress.sh perf_event 2 2 none
cgroup_fj_stress_perf_event_2_2_one cgroup_fj_stress.sh perf_event 2 2 one
cgroup_fj_stress_perf_event_2_9_none cgroup_fj_stress.sh perf_event 2 9 none
cgroup_fj_stress_perf_event_3_3_each cgroup_fj_stress.sh perf_event 3 3 each
cgroup_fj_stress_perf_event_3_3_none cgroup_fj_stress.sh perf_event 3 3 none
cgroup_fj_stress_perf_event_3_3_one cgroup_fj_stress.sh perf_event 3 3 one
cgroup_fj_stress_perf_event_4_4_each cgroup_fj_stress.sh perf_event 4 4 each
cgroup_fj_stress_perf_event_4_4_none cgroup_fj_stress.sh perf_event 4 4 none
cgroup_xattr cgroup_xattr
chdir01 chdir01
chdir04 chdir04
chmod01 chmod01
chmod03 chmod03
chmod05 chmod05
chmod06 chmod06
chmod07 chmod07
chown01 chown01
chown02 chown02
chown03 chown03
chown04 chown04
chown05 chown05
chroot01 chroot01
chroot02 chroot02
chroot03 chroot03
chroot04 chroot04
clock_adjtime01 clock_adjtime01
clock_adjtime02 clock_adjtime02
clock_getres01 clock_getres01
clock_gettime01 clock_gettime01
clock_gettime02 clock_gettime02
clock_nanosleep01 clock_nanosleep01
clock_nanosleep02 clock_nanosleep02
clock_nanosleep03 clock_nanosleep03
clock_nanosleep03 clock_nanosleep03
clock_nanosleep04 clock_nanosleep04
clock_settime01 clock_settime01
clock_settime02 clock_settime02
clock_settime03 clock_settime03
clone01 clone01
clone02 clone02
clone03 clone03
clone04 clone04
clone05 clone05
clone06 clone06
clone07 clone07
clone08 clone08
clone09 clone09
clone301 clone301
clone302 clone302
close01 close01
close02 close02
confstr01 confstr01
connect01 connect01
connect02 connect02
copy_file_range01 copy_file_range01
copy_file_range02 copy_file_range02
copy_file_range03 copy_file_range03
cp01_sh cp_tests.sh
cpio01_sh cpio_tests.sh
cpuacct_100_1 cpuacct.sh 100 1
cpuacct_10_10 cpuacct.sh 10 10
cpuacct_1_1 cpuacct.sh 1 1
cpuacct_1_10 cpuacct.sh 1 10
cpuacct_1_100 cpuacct.sh 1 100
cpuhotplug02 cpuhotplug02.sh -c 1 -l 1
cpuhotplug03 cpuhotplug03.sh -c 1 -l 1
cpuhotplug04 cpuhotplug04.sh -l 1
cpuhotplug06 cpuhotplug06.sh -c 1 -l 1
cpuset_hotplug cpuset_hotplug_test.sh
cpuset_inherit cpuset_inherit_testset.sh
cpuset_regression_test cpuset_regression_test.sh
creat01 creat01
creat03 creat03
creat04 creat04
creat05 creat05
creat06 creat06
creat08 creat08
cve-2011-2183 ksm05 -I 10
cve-2012-0957 uname04
cve-2014-0196 cve-2014-0196
cve-2015-0235 gethostbyname_r01
cve-2015-7550 keyctl02
cve-2016-10044 cve-2016-10044
cve-2016-4997 setsockopt03
cve-2016-5195 dirtyc0w
cve-2016-7042 cve-2016-7042
cve-2016-7117 cve-2016-7117
cve-2016-8655 setsockopt06

--YphcTKzXUfvVlAy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoWy2EACgkQJNaLcl1U
h9Bkogf/Qeplem2YrLC64xviTrwzO7aTfIY2vf11RL0+hZr3gcpVftI4V1ZtsV3b
vQXBDfeh4kPWQQt9vB0QPTLF4HW3qBF9y2ocDuyTSzoJA56+lKjtyVEbfJNlcL0f
jbPjX+oEwjgRoQtHu+UO/Ss0fOO7+Vh+OSf78opPQFAb524Sf07jo5LXDGc3zD3H
HJYtO8AG4eqlmcheT/6AY7IuSJeQHKSqfk8bENxpPwJ3bB/G53jmBRRYdvB7eaie
q05jVBVEgY9/HwSEcugSu0YuEzj/RTyiRh+ggbnAfEv34e18sviZyvSKGlFgS0BK
ri4f0jJOvc1qeiLN0gR31vtN11W2wA==
=+tYI
-----END PGP SIGNATURE-----

--YphcTKzXUfvVlAy+--

