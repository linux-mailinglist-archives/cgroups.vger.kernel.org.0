Return-Path: <cgroups+bounces-16510-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNIoNpxQHWpYYwkAu9opvQ
	(envelope-from <cgroups+bounces-16510-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 11:27:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551461C6A1
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F06C3028C56
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20A38F65C;
	Mon,  1 Jun 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dXJ858XE"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE883321AA;
	Mon,  1 Jun 2026 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305801; cv=none; b=FgUPPW1sUGfNsqmJhrvwJMU3Jd1mbuTmS7xlTPg6XW+iGVlLAK5jswbN7r1si2n3O2ry8CYP9gu+nmzEdLsgkbGZCQkLAXeehbSU/ovBLCVLICWkmXdXo4LBpuau8G3McldryK9lCq2WDOyb71WYlSSTnc8aRIXKJyp0dKUrQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305801; c=relaxed/simple;
	bh=YbPsHFvtCrHAUxR6ZRaO1QQgiaoDy05b2zspPXNSJtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBu9CSzmDJhtlKMsvMmrJqURNhaIcHHgehOUit73PbS+m8PPkNc1lV6MZ5rgnQWFitdoD+dfd7thxCeJQqmX9kvx4MLh957D/CKS+J4ud+EJ9BDcIXXpTu1JCc+0GVBO6FRXdf5Bf31lARjhcwOzb7F+c1HTz7pDzAfF8Fq9QoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dXJ858XE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780305763; x=1780910563; i=spasswolf@web.de;
	bh=0q44TTAxTxTQ/7BRgtDpiKiB80nV6Su7vCyImqSl4wU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dXJ858XEp0megDh9hqn78VRVPw9U4BR4K5L77ybc2YyKils5zyT0Fv/1jZM/d4W3
	 Zoo3FWtBsRRjKCtOhUJnaKFj59PMIgaSaHLhNiz9SiJLbYhygfDysFj/NLcOqTLvF
	 GDj2LopG1HnJOQqMvon/ASQZYYgh83Y1d4CFj69cM7QFc0nPjrAajwRsV7Dh/TtrD
	 T6ix7u3DT06U/pecZNewePDTu1DhEzY1vG4rIU1c9l+oo/LJZxgJkCUaF1V14fK5c
	 E35B9YzvK/woOf3I8dqAoAksW9RdebUTfyfXpDXOOEoThJbfsjVfu8GeYNvLs5Y4G
	 DPEjzj5hkOAEu0ZfrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1wPb8s3ogq-003EES; Mon, 01
 Jun 2026 11:22:43 +0200
Message-ID: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
From: Bert Karwatzki <spasswolf@web.de>
To: Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, spasswolf@web.de, Michal
 =?ISO-8859-1?Q?Koutn=FD?=	 <mkoutny@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Malat <oss@malat.biz>, kernel test robot
 <oliver.sang@intel.com>, Martin Pitt <martin@piware.de>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Date: Mon, 01 Jun 2026 11:22:38 +0200
In-Reply-To: <4e986b4ed7e16547805d54b6e67d09120bc4d2f2.camel@web.de>
References: <20260505005121.1230198-1-tj@kernel.org>
					 <20260505005121.1230198-6-tj@kernel.org>
					 <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
					 <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
					 <fd72aa26-4fed-4fcb-b4b1-d7ce9d891fe4@sirena.org.uk>
			 <8b15e2465901b48ee63f4827c69a67ff6d0e6098.camel@web.de>
		 <4e986b4ed7e16547805d54b6e67d09120bc4d2f2.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hEPf9S4Iex+sm2MzWocpeXNcaWHk3+h5nFYxLBKYwOU19ko/i6y
 dafnxHAVIQ1bmn1eF/vtRRZfSwEjsHIM8nh3ZvnneaVMz6e9fqEAsYHvmvpqo8pga9Hsq38
 dzl1fV+gG3CxHbGARg2x+ISgV/LhLMC/dlMYQ7iriVtNQbSREyRWB/3tkLQjM/LgArHldUZ
 BNmLSYP4EMUb0ANrtSCoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eT8RdpKPOFI=;PwQMLAVolgPNj1BzrSeHVIegw9t
 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
 Y6meLzH1bVOOTDwql8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16510-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5551461C6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Sonntag, dem 31.05.2026 um 20:45 +0200 schrieb Bert Karwatzki:
>=20
> The test that hang when running
> # LTPROOT=3D/home/bert/ltp-install/ ./kirk --run-suite controllers
> is always  cgroup_fj_function_net_prio.
> Also when bisecting this I disabled (i.e. commented out) the
> memcg_stress test in ~/ltp-install/runtest/controllers as it takes a lot=
 of
> time (30min) and succeeds even in the version where hangs occur.
>=20
> Bert Karwatzki

I've done more testing and found that running the
cgroup_fj_function_net_prio test alone gives no hang, the hang
only occurs when other tests are run before it:

Suite: controllers
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80
cgroup_core01: pass  (0.026s)
cgroup_core02: pass  (0.004s)
cgroup_core03: pass  (0.005s)
cgroup: fail  (2m 41s)
memcg_regression: skip  (3.558s)
memcg_test_3: pass  (0.112s)
memcg_failcnt: skip  (0.027s)
memcg_force_empty: skip  (0.016s)
memcg_limit_in_bytes: skip  (0.015s)
memcg_stat_rss: skip  (0.015s)
memcg_subgroup_charge: skip  (0.015s)
memcg_max_usage_in_bytes: skip  (0.014s)
memcg_move_charge_at_immigrate: skip  (0.015s)
memcg_memsw_limit_in_bytes: skip  (0.015s)
memcg_stat: skip  (0.014s)
memcg_use_hierarchy: skip  (0.015s)
memcg_usage_in_bytes: skip  (0.014s)
memcg_control: pass  (6.046s)
memcontrol01: pass  (0.004s)
memcontrol02: pass  (0.628s)
memcontrol03: pass  (16.009s)
memcontrol04: pass  (0.926s)
cgroup_fj_function_debug: skip  (0.012s)
cgroup_fj_function_cpuset: skip  (0.037s)
cgroup_fj_function_cpu: skip  (0.055s)
cgroup_fj_function_cpuacct: pass  (0.046s)
cgroup_fj_function_memory: skip  (0.035s)
cgroup_fj_function_freezer: pass  (0.044s)
cgroup_fj_function_devices: pass  (0.067s)
cgroup_fj_function_blkio: skip  (0.010s)
cgroup_fj_function_net_cls: pass  (0.055s)
cgroup_fj_function_perf_event: pass  (0.063s)
cgroup_fj_function_net_prio: HANG=20

I tried to narrow down this list and found that a hang occurs
int the net_prio test only if the perf_event test is run before it:

cgroup_fj_function_perf_event: pass  (0.063s)
cgroup_fj_function_net_prio: HANG


Bert Karwatzki

