Return-Path: <cgroups+bounces-14871-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GGYNeC+umkGbgIAu9opvQ
	(envelope-from <cgroups+bounces-14871-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 16:04:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AE2BDD0B
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 447B23028B44
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E843D75C4;
	Wed, 18 Mar 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/2HL6a0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A53285CB9
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846147; cv=none; b=OvfAc1/C4j9O0Zl4GEO/4bhONK6F/5KNp7cw7lLnyEH9VXfnEcnIKMLmZ1uqOkYxNppVRuiqVt3deOLGduap7rchtLUPXIOJh7cOm+iJoSS0HFKep4OKjhqN0BoToLRNReqVeJAzu6GAvKWepS4YUPTJKBIc0hK0z/3l1HRxC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846147; c=relaxed/simple;
	bh=QkIg3QZnf0WAMGUUWMahsFFNKAisytaKr6/Ov5XsM1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYEr/ZMXMICWeoL9vGNVlr3W/5f8a1lxQgQkyS9MPcRA6FhbwZN8Op5EP+v5ijaIxfwh0uCYWIZcj5HFZNfDAzh8Ii69qRccVm8l7Inl+Llmb5RSZdUuwCPgCm/BcN5kOKBOzedwP1qFP9Oj293G6lUMRHu6PcmZV5gDnvZAbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/2HL6a0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773846145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGdUptq9+9ZwnSp6u5PETPM98DUZPWeLFupePcwxUKA=;
	b=c/2HL6a0ZJi+V60QT7DFxiShMBhvMPz3w2vkjEoqlrPtWrE6cfA+51mzp876lvMr0y6gg2
	M8uD1chSQJ8xQq/D53wKVMnKQdwk3dyZHS+0CTqrTBi/72e3Orqg7tMm1pSF330Cw51uHo
	LBLYjHLo+X+mXTxxbVqc/zGiE23c/t4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-Hcm2rpEMPZSV4DQXWd_G_A-1; Wed,
 18 Mar 2026 11:02:21 -0400
X-MC-Unique: Hcm2rpEMPZSV4DQXWd_G_A-1
X-Mimecast-MFC-AGG-ID: Hcm2rpEMPZSV4DQXWd_G_A_1773846139
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E51C519560AA;
	Wed, 18 Mar 2026 15:02:18 +0000 (UTC)
Received: from [10.22.81.226] (unknown [10.22.81.226])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4841830002C3;
	Wed, 18 Mar 2026 15:02:17 +0000 (UTC)
Message-ID: <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
Date: Wed, 18 Mar 2026 11:02:16 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
To: paulmck@kernel.org, Tejun Heo <tj@kernel.org>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, frederic@kernel.org
References: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14871-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kvm-remote.sh:url]
X-Rspamd-Queue-Id: 797AE2BDD0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 8:53 AM, Paul E. McKenney wrote:
> Hello!
>
> Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
> most frequently on the TREE03 scenario, which suffers about ten such
> failures per hundred hours of test time.  Repeat-by is as follows:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make
>
> Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.
>
> Bisection converges here:
>
> 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
>
> Reverting this commit gets rid of the spurious CPU-hotplug failures.
> Of course, this also gets rid of some ability to do dynamic nohz_full
> processing.
>
> Now, the problem might be that the workqueue handler might still be
> in flight by the time that rcutorture fired up the next CPU-hotplug
> operation, especially given that the TREE03 scenario only waits 200
> milliseconds between these operations.  This suggests waiting for this
> handler before ending each CPU-hotplug operation.  And the crude patch
> below does make the problem go away.
>
> This alleged fix is quite heavy-handed, and also fragile in that if
> hk_sd_workfn() uses a different workqueue, this breaks.  It might be
> better to call into the cgroups/cpusets code and to use flush_work()
> to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
> keep things trivial to start with.
>
> Either way, please consider the patch below to be part of this bug report
> rather than a proper fix.
>
> Thoughts?
>
> 							Thanx, Paul
There is a fix commit ca174c705db5 ("cgroup/cpuset: Call
rebuild_sched_domains() directly in hotplug") in rc4 that may help. Could
you try out the rc4 kernel to see if that can resolve the problem that 
you have?

Thanks,
Longman


