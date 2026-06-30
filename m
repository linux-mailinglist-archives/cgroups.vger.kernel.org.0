Return-Path: <cgroups+bounces-17407-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y3C/GGADRGoQnQoAu9opvQ
	(envelope-from <cgroups+bounces-17407-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 19:56:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69806E70D2
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 19:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=SP14efyY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17407-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17407-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9295303F73E
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D973DF018;
	Tue, 30 Jun 2026 17:56:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCA3DD51F
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 17:56:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842205; cv=none; b=T5MWtgrsJuns5bLnCl9RpYriFB4yLDgP1q+hYL6lwfHfoEDQdzs5+9rNGf0cZGzixQWyCOXTkvL31g/zV3AiTI1+71iRXdB1ju7xSaImZTSEG5EJx6pWfqWJHWznz0OxwsZE8wL3Y8AoYwBFBDp0iD9/yatEwnQfENJe8ts9Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842205; c=relaxed/simple;
	bh=z64Zvugew+P1MInglJmh7Jam4FjCF1L/n6yrx55KL8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpCifJJMBDNg6E/1/YDhXxRLpnv5G8uM+0G1ny6W8gx//b8gUw8UEvFCcZqp3uCcTCp3CBrF5lTHSOwQDlPNY41U+HW3X+a74Ap7Nxs1StC+Fl1vHX7rkVqGmBrtBWj42DKrNiFXpaQr1n9MyTe1wyX/dfBl19BV2CdYF1VYHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP14efyY; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782842202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5XIm2s2oESgGUDdl7rh3Y8K1wz6Jr9u+0+fQyisStw=;
	b=SP14efyY/NUoEL1qOleDQ4uSy1Xiy8/ehYsXhMr+f19FAX0oTbkO7qwWdnL9z8HZrn0+AZ
	uoScmJE0MZRlTgRj1pxBbzXViIrJ0Id9zwtb27Wp9CnlRoAO7WrvDw6HbaRqmersVQRH08
	8I+acdwXaWK2lNg7Q7j/WCoALssYdLA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-IM9iqbr9OZuDB3leHEwJKw-1; Tue,
 30 Jun 2026 13:56:39 -0400
X-MC-Unique: IM9iqbr9OZuDB3leHEwJKw-1
X-Mimecast-MFC-AGG-ID: IM9iqbr9OZuDB3leHEwJKw_1782842197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01DFE18009E3;
	Tue, 30 Jun 2026 17:56:37 +0000 (UTC)
Received: from [10.2.17.12] (unknown [10.2.17.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C00E21956088;
	Tue, 30 Jun 2026 17:56:33 +0000 (UTC)
Message-ID: <e4ab9944-4687-45be-9935-4ad29f2a923c@redhat.com>
Date: Tue, 30 Jun 2026 13:56:32 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v9 01/11] cgroup/cpuset: Make nr_deadline_tasks an
 atomic_t
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-2-longman@redhat.com>
 <akPMKXppWM74-m9a@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <akPMKXppWM74-m9a@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17407-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:juri.lelli@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C69806E70D2


On 6/30/26 10:01 AM, Juri Lelli wrote:
> Hi Waiman,
>
> On 29/06/26 23:33, Waiman Long wrote:
>> The nr_deadline_tasks variable in the cpuset structure was introduced by
>> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
>> in cpusets"). It is reported by sashiko [1] that nr_deadline_tasks
>> can currently be modified by inc_dl_tasks_cs() under rq->lock and
>> by cpuset_attach() under cpuset_mutex. So if both updates happen
>> simultaneously, the nr_deadline_tasks variable can be corrupted leading
>> to incorrect operations down the road.
>>
>> Fix that by changing its type to atomic_t so that nr_deadline_tasks are
>> always atomically updated.
>>
>> [1] https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.comk
>>
>> Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
> Looks like Sashiko is yet not completely happy with this:
>
> https://sashiko.dev/#/patchset/20260630033344.352702-1-longman%40redhat.com
>
> I actually wondered the same and couldn't convince myself we don't
> actually have that problem with the window between sched_setscheduler()
> and cpuset_attach(). If issue is confirmed, not sure if wait_attach_
> done_lock() could help here as well? It's kind of a big lock for the
> scheduler, but maybe only affecting DEADLINE tasks and if migrations
> are ongoing.

Yes, I am aware of that. This patch can only partially close the race 
window. It doesn't completely eliminate it.

My current thought is for inc_dl_tasks_cs() to check if the in_progress 
flag is set. If so, it sets another flag for cpuset_attach() to double 
check the DL data for consistency. It will be a rather complicated 
solution in order to eliminate the race window. So I am postponing it to 
a later time when I have more free time to think about it.

Cheers,
Longman


