Return-Path: <cgroups+bounces-14869-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AbgL3CgumlSZwIAu9opvQ
	(envelope-from <cgroups+bounces-14869-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 13:54:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D422BBDA6
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5719F30087D8
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C4C3D6CA3;
	Wed, 18 Mar 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRfkHcIP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B3364E87;
	Wed, 18 Mar 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838439; cv=none; b=TWMDObqSwqmfQ59EZuh6/Fy+qSDXLk42NtCt5H22zbKJzMEyQwJ5rlFb2/43x0+vl80kN1nsONMDeEC14Or8fET679qhtbobZPsbMhK3pwyj/HpgFIPTr9RuS8lajXiOriAhEOg0Avc5DaEjM93H0eJWHOnqG+TY+o/twc4Ts28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838439; c=relaxed/simple;
	bh=caMGsddOGzB5EUx4RaA/AS4te04RGmk7Z5M/jMu+IZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NltHM1qVX4nfNczLMv92obzJezud8GXkqC6xXp2J8UEcpPe7Cb4aFkQelBddNJvzRbp7/qPu84BrHAVKF/EM7/VJXXzKC8HqOQLwO6duMpQQ5zjiVoBtMnDe9yCQpwk9Y0aZcVM4em5iT82vrx/vCCTZutYFU0xYEo7MBDJTlYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRfkHcIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64358C19421;
	Wed, 18 Mar 2026 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773838439;
	bh=caMGsddOGzB5EUx4RaA/AS4te04RGmk7Z5M/jMu+IZk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=sRfkHcIP0bwJBCRZH4nfCqDPuMKqpxQdV6sd+/XjG+xTz6UKCeNDnGyaejaITfgn6
	 RX2hBPv9hO9Gq2PgyiNK36Frt/dFN+am4PWNY/8BoaeJgphI+StzaKTVjixmbs52cv
	 9qhvilvfXcYYJFhMRUTlrJ90VfnRuLLNUQARm9XJpDqyy4zCO19V61s3i5RwXyUusc
	 Wp6lCHYGawFAtvUCIp76hdZvygG6B4q3CboVct6/A7CVW1YpZhW8PhZzXwFV9NBWGY
	 sHjddcqC4cQ8Zv5Jom3XedR4Zor2muXwhKTv/usFAmBArKfgvjUWqV/PRsCjGlTo2W
	 a6Zvq8TTNmF7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7DFFBCE15EB; Wed, 18 Mar 2026 05:53:57 -0700 (PDT)
Date: Wed, 18 Mar 2026 05:53:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, frederic@kernel.org
Subject: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
Message-ID: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-14869-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kvm-remote.sh:url]
X-Rspamd-Queue-Id: 63D422BBDA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello!

Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
most frequently on the TREE03 scenario, which suffers about ten such
failures per hundred hours of test time.  Repeat-by is as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make

Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.

Bisection converges here:

6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")

Reverting this commit gets rid of the spurious CPU-hotplug failures.
Of course, this also gets rid of some ability to do dynamic nohz_full
processing.

Now, the problem might be that the workqueue handler might still be
in flight by the time that rcutorture fired up the next CPU-hotplug
operation, especially given that the TREE03 scenario only waits 200
milliseconds between these operations.  This suggests waiting for this
handler before ending each CPU-hotplug operation.  And the crude patch
below does make the problem go away.

This alleged fix is quite heavy-handed, and also fragile in that if
hk_sd_workfn() uses a different workqueue, this breaks.  It might be
better to call into the cgroups/cpusets code and to use flush_work()
to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
keep things trivial to start with.

Either way, please consider the patch below to be part of this bug report
rather than a proper fix.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e6..36a9399be331d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1514,6 +1514,7 @@ int remove_cpu(unsigned int cpu)
 
 	lock_device_hotplug();
 	ret = device_offline(get_cpu_device(cpu));
+	flush_workqueue(system_unbound_wq);
 	unlock_device_hotplug();
 
 	return ret;
@@ -1730,6 +1731,7 @@ int add_cpu(unsigned int cpu)
 
 	lock_device_hotplug();
 	ret = device_online(get_cpu_device(cpu));
+	flush_workqueue(system_unbound_wq);
 	unlock_device_hotplug();
 
 	return ret;

