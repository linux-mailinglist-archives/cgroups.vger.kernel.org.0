Return-Path: <cgroups+bounces-16581-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZDiCNMQkH2pNiAAAu9opvQ
	(envelope-from <cgroups+bounces-16581-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:45:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7946312F7
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JOEtOcl8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16581-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16581-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C41A8300F10A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A92395AE1;
	Tue,  2 Jun 2026 18:41:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D572301704
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 18:41:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425676; cv=none; b=Oj6BHObCntALoaO/y0NBp3b3qAUUsXEOdkolhgFwCNb2TLVAxXHb1oZ7tfvsaOe4zZc0S9w2LRiQq+TUu2ow2BoyOwJohndEgnIOXCyc+hbYZLMR/7vQlz17FlH8qmE+A8XGmgzjYtCHZQcDP5eXVMeqMhRWakBCDjJU/G5jd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425676; c=relaxed/simple;
	bh=7CEOeeMkYleRQI+bsuAcOX0rDu1Ov9r/EXuZwfO4a1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czDAH0vSAim7zLYXfVHCv6e9JWimhl2pjY9CcakT/KqcH/OCD5Wgzf+/U/5biOYjflQgt5jeXqH5wTVKsl8cLkpJGS3MFyh9jYrSedXgbeQdfQnHiDO4fw5R/riJa2YgOo55NheARjQAaO9OEFWL2xLEtYzM1ncKmpm/PPHduKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOEtOcl8; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780425674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE5wctSYjWkdf1ZgrGHwvibuILqVxW5SF0xcJklrqtk=;
	b=JOEtOcl8JfsYtm2LUfSKe1C/lxTbnN3qf+6k3OV+9TxrLA5iqiREw5/Zrp0emOjbkuQhZy
	uqyVoYuphkRoYWjPueoR7THrfqUrF5MPHC8XPgh8abTYB/duUAmUjFHkr027SlHap+wgHM
	iZ3LwvajxpxV4rKqoo3bH8OhoFbRu/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-UG4Rm6QUMQe1Dl5nbr1feQ-1; Tue,
 02 Jun 2026 14:41:11 -0400
X-MC-Unique: UG4Rm6QUMQe1Dl5nbr1feQ-1
X-Mimecast-MFC-AGG-ID: UG4Rm6QUMQe1Dl5nbr1feQ_1780425669
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FD518002C7;
	Tue,  2 Jun 2026 18:41:09 +0000 (UTC)
Received: from [10.22.80.32] (unknown [10.22.80.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AAA81800352;
	Tue,  2 Jun 2026 18:41:07 +0000 (UTC)
Message-ID: <9fad648e-4b46-4326-ae92-9a46302990cc@redhat.com>
Date: Tue, 2 Jun 2026 14:41:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Fix update_prstate() always returning 0
 on partition errors
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tao Cui <cui.tao@linux.dev>
Cc: chenridong@huaweicloud.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260602045521.2381230-1-cui.tao@linux.dev>
 <ah6JpNvdO7vaBmjS@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ah6JpNvdO7vaBmjS@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-16581-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:cui.tao@linux.dev,m:chenridong@huaweicloud.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B7946312F7


On 6/2/26 3:46 AM, Michal Koutný wrote:
> Hi.
>
> On Tue, Jun 02, 2026 at 12:55:21PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
>> update_prstate() stores the error code in cs->prs_err and transitions
>> the partition to an invalid state, but always returns 0. The caller
>> cpuset_partition_write() uses "return retval ?: nbytes", so the write
>> syscall always appears to succeed from userspace even when the partition
>> became invalid.
>> Return -EINVAL when err is set so userspace can detect
>> the failure immediately.
> This is quite a visible UAPI change (a write can succeed to invalidate a
> partition) and users are meant to watch for cpuset.cpus.partition state
> anyway for asynchronous changes.

Right, it is purposely done to not return a write error when writing any 
cpuset control files. The only exception is cpuset.cpus.exclusive which 
can return failure when  an exclusive CPU has been taken. It is 
documented in cgroup-v2.rst.

Cheers,
Longman


