Return-Path: <cgroups+bounces-15120-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBMlGII8y2kFFAYAu9opvQ
	(envelope-from <cgroups+bounces-15120-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 05:16:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD29363A40
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 05:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A665F30490E5
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 03:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344F282F09;
	Tue, 31 Mar 2026 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGlfDsTs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D64223DE9
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774926924; cv=none; b=ueeJhM/+crMyLiOeBRHEcP3oNaiYvFN27mO0eDjzfcJObU43ubXMG7USt/vuHPq/FABSfKApkknNxRolZaCYLYmgF/1m+VObtt93XwL/9njVIcdP66GmPXp9UEpHAecC49W2TBYde8rgiT77R2M5v1XfQA/zpAslo0pBknqWLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774926924; c=relaxed/simple;
	bh=1d0YQx4hPQaBwhAKQsz2LmvPvOWFGCJTu42IJkX9DoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chTynoZI5fF797jvAa+xtgNjMq5DAfcbtw9qSf0Q2P9+xq1QlOAiq1kHi53kuwcOaTblCtAjkJpIKXv0vCoqRvEP8a8eA5/7c32wLGvgJLd/9jVvkoO1TAEMI+AOaKlT6/Qzyy7Sw5XAyhQiqwrJZjPcmWncx/SwdQ8RzzzNs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGlfDsTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774926922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8rlkQrzrOJfJRtM4z+1sXBieFpqYV94XKbvw/yLgf4=;
	b=MGlfDsTsd+Vzj51NpQ9vjz1BCn7181HqKDPSqaoc5bQRBYtdG3Nm0GmyC6sQrWdta7yoP1
	r1HJ62qVL3NCB+9uyPj4G8GAgKzONFIB5o4zVRQi/8QAJk3A2OM2wq/73i8S7Exlc0XI8S
	YsXKWfBgsQGrg9WLE2hi/1gmHzdOkD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-_6U7yy2FO-m0us9VVSsDzg-1; Mon,
 30 Mar 2026 23:15:18 -0400
X-MC-Unique: _6U7yy2FO-m0us9VVSsDzg-1
X-Mimecast-MFC-AGG-ID: _6U7yy2FO-m0us9VVSsDzg_1774926917
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0719180047F;
	Tue, 31 Mar 2026 03:15:16 +0000 (UTC)
Received: from [10.22.64.128] (unknown [10.22.64.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A80E1800361;
	Tue, 31 Mar 2026 03:15:14 +0000 (UTC)
Message-ID: <fbd04c5f-ee9c-4826-ac05-d815ede059b9@redhat.com>
Date: Mon, 30 Mar 2026 23:15:14 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Chen Ridong <chenridong@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-3-longman@redhat.com>
 <c80c6838-e33e-4e5c-82ac-9bfa4d012dcb@huaweicloud.com>
 <83e3d0fd-ab1c-4078-ae0a-e902e92fcdb6@redhat.com>
 <acq_ELmOia9K8dw4@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <acq_ELmOia9K8dw4@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15120-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDD29363A40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/30/26 2:21 PM, Tejun Heo wrote:
> Hello,
>
> On Mon, Mar 30, 2026 at 12:15:01PM -0400, Waiman Long wrote:
> ...
>>> If there are many tasks in the cpuset that has no CPUs, they will be migrated
>>> one by one. I'm afraid that only the first task will succeed, and the rest will
>>> fail because the flag is cleared after processing the first one.
>> The setsched_check flag is used in the cgroup_taskset_for_each() loop below.
>> That loop is going to iterate all the tasks to be migrated and so the flag
>> will apply to all of them. So it is not just the first one.
> During migration, a taskset is used to group tasks in a thread group if
> cgroup_migrate() called with %true @threadgroup. That doens't really apply
> here. cgroup_transfer_tasks() doesn't set @threadgroup and even if it were
> to set set, there can just be multiple procesess. Besides, it's rather odd
> for it be a one-shot param that gets cleared deep in the stack. Wouldn't it
> make more sense to make whoever sets it to be responsible for clearing it?

Apparently, I have misunderstood how cgroup_transfer_tasks() works. 
Right, it calls cgroup_migrate_execute() on a process-by-process basis. 
So I shouldn't clear the flag in the first call. As for clearing the 
flag, I think we can do it in the CPU hot-add situation or when the 
cpuset.cpus is modified.

Thanks,
Longman


