Return-Path: <cgroups+bounces-17426-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VX9FNuZ4RWolAwsAu9opvQ
	(envelope-from <cgroups+bounces-17426-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:30:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87756F1780
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=A+xtj9qG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17426-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17426-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EEE43068459
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C13B3C18;
	Wed,  1 Jul 2026 20:19:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9363BCD0A
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 20:19:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937167; cv=none; b=Geq04iutvVlIH9pSa0UynuZpMb08aidvmVIgmmLnquyx9Z0+Peu5sUH+uELwq93JFkq5aKG26dEQzNYNOwg8EVt98hMPNzRskFzKzSotSMocoCgJKo5Lf7rpbF3NU7OTSw0n2PRIcWx5WEb43Ob2++y59l9zDDpQ0vHpiMvntCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937167; c=relaxed/simple;
	bh=P2XaUmrl//82i1qJCceBWozgG8tYQzAsnfdiZDbolvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8vkGmqxR/1NvRqYlA6iWijIX44QGCb3AjDyljbpLZgysi93dxUi0HvRzOT70+176LYa+prHbbDgvi9AuVyVyzEFC5UVyfSemO+Rn77ow8p5/cB8de4qMqyYUMGCu/lb/MEDVCiF13WD0D7HxQ9kmKT/zcIL62zzjKVFvqUWmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+xtj9qG; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782937162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79DoWJeAeXloYm2n+Rci/dmY81HSXAaiftH5DSNv554=;
	b=A+xtj9qGSu1PdJb8g7wGxZ3VRVpkM4NTUVef6VMX94C+3weHs4EDIzAirjBe3Sc1JEZ0JH
	JuqSHIDUGILyxAS+1iYq3zQvp0KoZBBFkrEDEd3rtlwffK3zATv+JXUPHGuMj9JiNi9hHp
	GYgpZoI2gPaNvUeY299+A3NSDYCgUMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-kZQShflBM2mh9OFVBVp14A-1; Wed,
 01 Jul 2026 16:19:16 -0400
X-MC-Unique: kZQShflBM2mh9OFVBVp14A-1
X-Mimecast-MFC-AGG-ID: kZQShflBM2mh9OFVBVp14A_1782937155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53DF41926B8F;
	Wed,  1 Jul 2026 20:19:14 +0000 (UTC)
Received: from [10.2.16.170] (unknown [10.2.16.170])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 019B630001BE;
	Wed,  1 Jul 2026 20:19:10 +0000 (UTC)
Message-ID: <fbab6706-12b2-4d97-afa1-5bcd5d943095@redhat.com>
Date: Wed, 1 Jul 2026 16:19:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v9 03/11] cgroup/cpuset: Prevent race between task
 attach and cpuset state change
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-4-longman@redhat.com>
 <e28a38fa-5998-4e73-886c-2cbbd26ae98f@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e28a38fa-5998-4e73-886c-2cbbd26ae98f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17426-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D87756F1780


On 6/30/26 9:41 PM, Ridong Chen wrote:
>> @@ -3246,7 +3268,12 @@ ssize_t cpuset_write_resmask(struct 
>> kernfs_open_file *of,
>>           return -EACCES;
>>         buf = strstrip(buf);
>> -    cpuset_full_lock();
>> +
>> +    /* cpuset_mutex acquired in wait_attach_done_lock() */
>> +    mutex_lock(&cpuset_top_mutex);
>> +    cpus_read_lock();
>> +    wait_attach_done_lock();
>> +
>
> Would it be cleaner to just pass this into cpuset_full_lock() as a flag?
>
> void cpuset_full_lock(bool wait_attach)
> {
>       mutex_lock(&cpuset_top_mutex);
>       cpus_read_lock();
>       if (wait_attach)
>               wait_attach_done_lock();
>       else
>               mutex_lock(&cpuset_mutex);
> }
> Then the two write paths become a single cpuset_full_lock(true). The
> downside is the other 6 callers would need cpuset_full_lock(false). 
> Not sure it's worth it â what do you think?

I would like to put wait_attach_done_lock() at places where it will wait 
for the completion of the attach operation. Putting it inside 
cpuset_full_lock() will make it harder to find out which operations will 
need to wait for task attach. So I will keep the code as is.

Cheers,
Longman


