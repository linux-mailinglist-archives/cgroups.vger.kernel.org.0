Return-Path: <cgroups+bounces-17644-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u+8UG5lrUGqDygIAu9opvQ
	(envelope-from <cgroups+bounces-17644-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:48:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D847370CF
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ci+at1OI;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17644-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17644-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F3753026AA6
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A1243956;
	Fri, 10 Jul 2026 03:48:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235192D0603
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655295; cv=none; b=LnwaX2D9cKRgrKxwkqA/2fuB7EyZKWkqjF2o3s8EHyKjxJozTAkjrokSoiSWH8S+1Y3yjnW3kT2sLv9tWIXOK/DqDaPOqMw6F967dDPDJg+JFwIiwByyJ3RAj0w+sSiEgXgmg+YT/OeODMZECWmxq3kPygUC/mUL20Czm9/aVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655295; c=relaxed/simple;
	bh=/Fd6KrNmo6PySHgGRsYcL5y0JMVCNUErPiaGXKyuEQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbI4W+YYVN9kKQtqxyrpzua1BFe81cMeIR3uWcipb+JZyzHgry68WyVhl5b1Fg8gntEimOyzUs0gtncfSbSQOLOMhxV3Pxqsme4gHut0wIIjHqRlw+BfrUx6jgcaS0RBoK4/SY1Ioed/+trxOpkBjZRBNUt0b1N946XTuKWGxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ci+at1OI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783655293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTM73mbrNFeg9NAnrcfOYiEcBbQPeq+yx3xgufQSvnQ=;
	b=Ci+at1OIoektsy7UMphANkOFo3kBH8ZgXFXsvuBdFMVjhZWSi4ym4le5Wjz4iR49mTDMkv
	f79im1J2SZGe7YInRmN5V52cfuOWmOlS0AxooZdI0O32lLglQEgytXDmyTyTjk9uVz3y0b
	R1IvZlgMdlqNO1IvanBOHxjiJEMPuSA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-3xlsM3t9O3uzBfC4kNmdZg-1; Thu,
 09 Jul 2026 23:48:07 -0400
X-MC-Unique: 3xlsM3t9O3uzBfC4kNmdZg-1
X-Mimecast-MFC-AGG-ID: 3xlsM3t9O3uzBfC4kNmdZg_1783655286
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89EB01956042;
	Fri, 10 Jul 2026 03:48:05 +0000 (UTC)
Received: from [10.22.80.240] (unknown [10.22.80.240])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7172A1800348;
	Fri, 10 Jul 2026 03:48:03 +0000 (UTC)
Message-ID: <e117b3e9-3973-40de-8976-eb0ebef18c4c@redhat.com>
Date: Thu, 9 Jul 2026 23:48:02 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v10 10/11] cgroup/cpuset: Support multiple
 destination cpusets for cpuset_*attach()
To: Tejun Heo <tj@kernel.org>
Cc: Ridong Chen <ridong.chen@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260702214757.579012-1-longman@redhat.com>
 <20260702214757.579012-11-longman@redhat.com>
 <e254af713b5345aec3d086771ecf1e71@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e254af713b5345aec3d086771ecf1e71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17644-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:ridong.chen@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D847370CF

On 7/6/26 8:57 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Thu, Jul 02, 2026 at 05:47:56PM -0400, Waiman Long wrote:
>> It is assumed that a given cpuset cannot be both a source and a
>> destination cpuset. [...] it will print a warning and fail the attach
>> operation in these unexpected cases [...]
> This assumption doesn't hold - the WARN_ON_ONCE() and -EINVAL fire on a
> legitimate migration. It's the case sashiko flagged, and it does reach
> can_attach().
>
> Threaded subtree with partial cpuset delegation:
>
>    P (+cpuset)
>    |- R (cpuset)        <- destination
>    |  `- C (no cpuset)  -> effective cpuset == R
>    `- W (cpuset)
>
> Group leader in R, thread_a in C, thread_b in W; migrate the whole
> process into R (echo $PID > R/cgroup.procs). thread_a moves C->R: its
> cgroup changes so compare_css_sets() keeps it in the taskset, but its
> cpuset css is unchanged (C inherits R's), so task_cs() == cs == R. cpuset
> is in ss_mask because thread_b (W->R) changed. can_attach() then tags R
> as a source (thread_a) and the destination (thread_b):
>
>    WARNING: kernel/cgroup/cpuset.c:3054 at cpuset_can_attach_check+0xcd/0x130
>     cpuset_can_attach+0x131/0x2f0
>     cgroup_migrate_execute+0x367/0x450
>    cgroup.procs write returns -EINVAL
>
> So a thread already in the destination's effective cpuset does show up in
> the iteration when it reaches that cpuset through a different, non-cpuset
> child - compare_css_sets() keys on the cgroup, not the cpuset css.
>
> 1-9 handle this correctly (the migration succeeds); the patch 10 guard
> regresses it. I've taken 1-9 into for-7.3 - please respin 10-11. One
> option: when oldcs == cs the pair is a cpuset no-op, so skip it and add
> it to neither list.

Sorry for the late reply. I was offline for a few days because my labtop 
SSD was having problem.

Yes, I realize that my assumption about oldcs != cs is incorrect. I will 
revise the remaining patch to address the issue.

Thanks,
Longman


