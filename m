Return-Path: <cgroups+bounces-14676-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLqsE4fZqWmaGQEAu9opvQ
	(envelope-from <cgroups+bounces-14676-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:29:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E02178A7
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EF8030229A6
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 19:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD337CD32;
	Thu,  5 Mar 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhP5G+eK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AD3793BF
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738846; cv=none; b=RkvRLV1dukYsbjv5TkgtlQ2icwfUvuFsDDdAoKg0s1bwN965/QWF6Jdz2JLglcjSU9GN5McWOf0vp5+7duOGbnLoDcs+FMyCcNOasuh/78kI0oB26rJfAmwI9NT0XjnZDqyenurCcYTfrgISadrkEYPxO8XkDJxs3WrwHgfVfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738846; c=relaxed/simple;
	bh=tnekzAPZwkEBEkGCvEEtNGrcYKML/48LHk+kqouYDvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKo94aHx0NuK8SUcBWyjPzfALP3cnh40rGnhxpsRGcT2WLNNL4uH2oz4kWWy3cfLaxr8yQAbtuYFcVX4B6UJ0YeWt7kZhMKs3toh4lti7Ms1l2dhrbD/pJblPK6B34/OM9qX2ANAHO5wtcd1DjXt8XXcr2nWWg30Qfnf44awSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhP5G+eK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772738844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jpw5YL/yfmcf2nfXTWQb6UEHn1RiCuCH4uCU1DxxWmI=;
	b=NhP5G+eKPHvXmEmLbv1PCPJJLOT066M+jDu5iXXbjje1xmB4cVJR1KscpV2zHs8STIeeg/
	aI34XTQ04oZ8AcK9w7sEErnkWcHLU1ABlbfQfyqOG6WR9KL0TVIJKMELj8DScYE4rkYnBi
	xncpwJrHjKL52Le2cIrgJbg8swH1Vfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-YKzTSNnvMXKV5U0hQVhGxg-1; Thu,
 05 Mar 2026 14:27:20 -0500
X-MC-Unique: YKzTSNnvMXKV5U0hQVhGxg-1
X-Mimecast-MFC-AGG-ID: YKzTSNnvMXKV5U0hQVhGxg_1772738839
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3D7918002CD;
	Thu,  5 Mar 2026 19:27:18 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40A60180049D;
	Thu,  5 Mar 2026 19:27:17 +0000 (UTC)
Message-ID: <40efb05d-ec68-4677-b0a6-952a26f84553@redhat.com>
Date: Thu, 5 Mar 2026 14:27:16 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Call rebuild_sched_domains() directly in
 hotplug
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
References: <20260304184100.71015-1-longman@redhat.com>
 <aamLD3MizuWIs8_x@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aamLD3MizuWIs8_x@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 509E02178A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14676-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/5/26 8:54 AM, Frederic Weisbecker wrote:
> Le Wed, Mar 04, 2026 at 01:41:00PM -0500, Waiman Long a écrit :
>> Besides deferring the call to housekeeping_update(), commit 6df415aa46ec
>> ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug
>> to workqueue") also defers the rebuild_sched_domains() call to
>> the workqueue. So a new offline CPU may still be in a sched domain
>> or new online CPU not showing up in the sched domains for a short
>> transition period. That could be a problem in some corner cases and
>> can be the cause of a reported test failure[1]. Fix it by calling
>> rebuild_sched_domains_cpuslocked() directly in hotplug as before. If
>> isolated partition invalidation or recreation is being done, the
>> housekeeping_update() call to update the housekeeping cpumasks will
>> still be deferred to a workqueue.
>>
>> In commit 3bfe47967191 ("cgroup/cpuset: Move
>> housekeeping_update()/rebuild_sched_domains() together"),
>> housekeeping_update() is called before rebuild_sched_domains() because
>> it needs to access the HK_TYPE_DOMAIN housekeeping cpumask. That is now
>> changed to use the static HK_TYPE_DOMAIN_BOOT cpumask as HK_TYPE_DOMAIN
>> cpumask is now changeable at run time.  As a result, we can move the
> But rebuild_sched_domains() will still handle the cpuset isolated partitions
> somehow right? Sorry for the question, I'm a bit lost in the
> partition_sched_domains() maze...

For v2, generate_sched_domains() has no dependency on housekeeping 
cpumasks other that the HK_TYPE_DOMAIN_BOOT to strip out boot-time 
isolated CPUs from the effective_cpus of top_cpuset. So 
rebuild_sched_domains() will do the right thing even if HK cpumasks 
haven't been fully updated yet. Please let me know if you can think of 
any corner cases that will still be problematic.

Cheers, Longman



