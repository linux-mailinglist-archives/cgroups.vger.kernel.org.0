Return-Path: <cgroups+bounces-15729-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFaAOSylAWpKhAEAu9opvQ
	(envelope-from <cgroups+bounces-15729-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:45:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55D50B341
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C8DF304C11B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182A43BADAA;
	Mon, 11 May 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ1Y2kCq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C63ACF1A
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491090; cv=none; b=PxZ0RnTCxmgHj7vx1WbzbpQcuPyjHqPSzDbTTVMZy9SFTZjSio74DW91Q3ybdkfxSOJL1VKOlTLvw5WasfYukr53w28mVD/p9DtLykbGt5WHMZ64Ax30gZ1FMBKWXHi6MvOi4o40IAdRTyBjmuFjZv4BaezblJpAaEGYTPuBCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491090; c=relaxed/simple;
	bh=pwWkAtpKB25W5l/pFKutykzdZw0GbktZByfPApb8TKg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qg/JcQuEK809ToU43n8bayM1LOzJdlDuvMsWid2YxzfDIB8Vhr0D1XcNHWzSAKHd9augoVkCy8Gb7WHXqva/a4T1cxm0E3sZ9bZXSLnjX5S1vjSrTkT1PjIt1iups+Eo+YnZjvGM5GbKcQiC4Ergzu21rcvBm6ERhrLBl4U/3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ1Y2kCq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778491088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei0HxkGf9mos5QkEOT0Kl7X6cJ9/4FAxEWCyRzKiivY=;
	b=eJ1Y2kCqbzVRXs3FbYHFqsJKbbj7zAGatp02fNml+kTGuDGSioXSVXGkUkhQklStRfTs8t
	MGUZMwLZsv+eiVBQLLU1sf5AUqe1cl8ziybuG/zUHrWWJJCRhwVMTo9pVpdS2by2kuRqVj
	FF6UmBYifUsEWxPCwczzmthOn7hgMeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-w4C5fSlgOU6ehWR_qJvTjA-1; Mon,
 11 May 2026 05:18:04 -0400
X-MC-Unique: w4C5fSlgOU6ehWR_qJvTjA-1
X-Mimecast-MFC-AGG-ID: w4C5fSlgOU6ehWR_qJvTjA_1778491082
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DF461956096;
	Mon, 11 May 2026 09:18:00 +0000 (UTC)
Received: from jlelli-thinkpadt14gen4.remote.csb (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 390AC30001BE;
	Mon, 11 May 2026 09:17:53 +0000 (UTC)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
From: Juri Lelli <juri.lelli@redhat.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Chen Ridong <chenridong@huaweicloud.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20260509102031.97608-2-zhangguopeng@kylinos.cn>
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
 <20260509102031.97608-2-zhangguopeng@kylinos.cn>
Date: Mon, 11 May 2026 11:17:48 +0200
Message-Id: <177849106875.40525.17604766142898490713.b4-review@b4>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778491073; l=744;
 i=juri.lelli@redhat.com; s=20250626; h=from:subject:message-id;
 bh=pwWkAtpKB25W5l/pFKutykzdZw0GbktZByfPApb8TKg=;
 b=gCDpgyRUkJiJ/KLH1Ost4djuseF3N6kDpjk7XIvyGDqNrJA/Iadf19qNKe3vftt0bZY4nJu9G
 45TmyX5XQ2nDS4UGAkq7+pdREbRvF0m3BLQyP6PkLFHAox1ty2D3lOo
X-Developer-Key: i=juri.lelli@redhat.com; a=ed25519;
 pk=kSwf88oiY/PYrNMRL/tjuBPiSGzc+U3bD13Zag6wO5Q=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 4C55D50B341
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15729-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Sat, 09 May 2026 18:20:30 +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
> state in the destination cpuset while walking the taskset.
> 
> If a later task_can_attach() or security_task_setscheduler() check
> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
> and does not call cpuset_cancel_attach() for it. The partially
> accumulated state is then left behind and can be consumed by a later
> attach, corrupting cpuset DL task accounting and pending DL bandwidth
> accounting.
> 
> [...]

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>

-- 
Juri Lelli <juri.lelli@redhat.com>


