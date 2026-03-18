Return-Path: <cgroups+bounces-14874-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIuVLEj9umlHeAIAu9opvQ
	(envelope-from <cgroups+bounces-14874-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:30:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAD2C205C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D14230AB87D
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12D3F0747;
	Wed, 18 Mar 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcC8s/nL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E733F074F
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862175; cv=none; b=YPDZOVj0v44bQSoC/4Nn/yqDamlXNivANzdBSI0D2At+EEZ599QNdCtZ72HH20O7vB3x+nV9GvAipIIogqf1x5ln4p3xRc+QsEIjZuIN/fv+tbagB9wZ3I+ZJ5jj9uF12nZYoUOiiaS4l/uHOLwpAs8vV051/jomuSTuk/NrMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862175; c=relaxed/simple;
	bh=HNEjWWg+eFhY1R3/DXjm6+z8FMPs8I2QwA5CTW4Zue4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jl0BD5YgQAyyicSogqptWSGSI7EnauhkE99FUsdodttyHu79cq17vZJH0NY+BcJbuCOYxmHssq1AnwPc8W7kNF/1/auFjkX7Qct0x9Ldki+JTFqc0uzG6mV5xIDI8Y3bvDpHbGRrsf6R/As3nRVluFI4tQfTJMFKHH+URE9U7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcC8s/nL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773862173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNDKa/Jl/+Ss4rYeY3MICivAnfJy5RYCpPz3D5LnUaw=;
	b=BcC8s/nLmKlWaqEG0B1Wc+Qfdhkl8Lghe5iHv2pSqUmfBr8bjsV3eIljzN6OtD/pSXzbsQ
	/6xefF7Wf13EedQZDO29RWuiLvqCRzp30UDOqNTjWg8o34YRsXyqoqbfRMb7JCBscPzv/k
	tPDcjUeHqiEaYEPJSHDBmOinMULLfMY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-BzNYZuzYNK27-vUsJPNt5A-1; Wed,
 18 Mar 2026 15:29:29 -0400
X-MC-Unique: BzNYZuzYNK27-vUsJPNt5A-1
X-Mimecast-MFC-AGG-ID: BzNYZuzYNK27-vUsJPNt5A_1773862168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2F018005B2;
	Wed, 18 Mar 2026 19:29:27 +0000 (UTC)
Received: from [10.22.81.226] (unknown [10.22.81.226])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 038C7180075D;
	Wed, 18 Mar 2026 19:29:25 +0000 (UTC)
Message-ID: <22f1e3d1-3f5e-41cd-b7e7-6a0ee5c192bf@redhat.com>
Date: Wed, 18 Mar 2026 15:29:25 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, frederic@kernel.org
References: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
 <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
 <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14874-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31CAD2C205C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/26 2:43 PM, Paul E. McKenney wrote:
> On Wed, Mar 18, 2026 at 11:02:16AM -0400, Waiman Long wrote:
>> On 3/18/26 8:53 AM, Paul E. McKenney wrote:
>>> Hello!
>>>
>>> Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
>>> most frequently on the TREE03 scenario, which suffers about ten such
>>> failures per hundred hours of test time.  Repeat-by is as follows:
>>>
>>> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make
>>>
>>> Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.
>>>
>>> Bisection converges here:
>>>
>>> 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
>>>
>>> Reverting this commit gets rid of the spurious CPU-hotplug failures.
>>> Of course, this also gets rid of some ability to do dynamic nohz_full
>>> processing.
>>>
>>> Now, the problem might be that the workqueue handler might still be
>>> in flight by the time that rcutorture fired up the next CPU-hotplug
>>> operation, especially given that the TREE03 scenario only waits 200
>>> milliseconds between these operations.  This suggests waiting for this
>>> handler before ending each CPU-hotplug operation.  And the crude patch
>>> below does make the problem go away.
>>>
>>> This alleged fix is quite heavy-handed, and also fragile in that if
>>> hk_sd_workfn() uses a different workqueue, this breaks.  It might be
>>> better to call into the cgroups/cpusets code and to use flush_work()
>>> to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
>>> keep things trivial to start with.
>>>
>>> Either way, please consider the patch below to be part of this bug report
>>> rather than a proper fix.
>>>
>>> Thoughts?
>>>
>>> 							Thanx, Paul
>> There is a fix commit ca174c705db5 ("cgroup/cpuset: Call
>> rebuild_sched_domains() directly in hotplug") in rc4 that may help. Could
>> you try out the rc4 kernel to see if that can resolve the problem that you
>> have?
> It does, thank you!
>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>
Thanks for the confirmation.

Cheers,
Longman


