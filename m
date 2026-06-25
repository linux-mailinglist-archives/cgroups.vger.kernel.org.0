Return-Path: <cgroups+bounces-17280-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XAVqD4+8PGqfrAgAu9opvQ
	(envelope-from <cgroups+bounces-17280-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 07:28:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A46C2CC7
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 07:28:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XhtSAMZ0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17280-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17280-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57083305488A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB767301004;
	Thu, 25 Jun 2026 05:28:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D53009E2
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 05:28:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365285; cv=none; b=qEhHxpKiVusZg4Y6fqEMy01lj2RiAJIsJ+M4xwXY990IFRD09GAJqvnutlerRh6LLO5HQSEgdcH8MjvGjgKM7DMwKkXVtjZ6Xx9jbimHErzK6diWuyMShJ09lv/6fiYc1O8AU8Ut75i63npqFvgITBOLV3mqCJh5n57INSKxrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365285; c=relaxed/simple;
	bh=aTi/pXkw91hda8Kdn4Vpsi0Sl3Y5Vo7qzyAsuTxvfuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwql9JxlDx/09u4We+bzsor/PG8KMdaWI2ejqdYY+cqcn2MGyHclMq7rLTIROMxMFaoc3/Rrdv2mj2kn8eYrpxM5/6ZHq/Vt6jx2ZHi3hNOf0DfwVfALe7c8NYHRTD0C1HW6aTA86qEc7eFMdLNhIFSp+b7n5qEXj1/b8lZ61R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhtSAMZ0; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782365283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkCv2oYuzPEka7BacCiWxFFuaGiHcvr95rXSLBOAyWM=;
	b=XhtSAMZ0cBOGE9qM5taYZ6Qfa3unMbY/S+EBi+m8Jl3C8RyX9z1dHd4WbID8iEZUXvHJG8
	cBHcNdijU1PT1fxfAhq6ySKU6NGY1H8PD7e7z7XTVzkwUZ9gKgcIczWvA3taSwZt/MSrMS
	ttmPnhrry1Lp3w3m/7WZe5xniZ5uCSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-i-fo0p_PO5-DT5CegNM5ZQ-1; Thu,
 25 Jun 2026 01:27:59 -0400
X-MC-Unique: i-fo0p_PO5-DT5CegNM5ZQ-1
X-Mimecast-MFC-AGG-ID: i-fo0p_PO5-DT5CegNM5ZQ_1782365278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DDAE1956043;
	Thu, 25 Jun 2026 05:27:57 +0000 (UTC)
Received: from [10.2.16.163] (unknown [10.2.16.163])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B4121800677;
	Thu, 25 Jun 2026 05:27:55 +0000 (UTC)
Message-ID: <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
Date: Thu, 25 Jun 2026 01:27:54 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
To: Jing Wu <realwujing@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, cgroups@vger.kernel.org,
 Qiliang Yuan <yuanql9@chinatelecom.cn>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260624063404.2106807-1-realwujing@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260624063404.2106807-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17280-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 927A46C2CC7

On 6/24/26 2:34 AM, Jing Wu wrote:
> Hi Waiman,
>
> Thomas Gleixner suggested we coordinate, so reaching out directly.
>
> We have been working on a similar feature called Dynamic Housekeeping
> Management (DHM) [1][2][3][4]. The RFC was posted on 2026-02-06, v1 on
> 2026-03-25, and v2 on 2026-04-13 — a week before your series appeared.
> It seems we developed these independently in parallel.
>
> After Thomas's review of DHM v3, we are rebuilding v4 around the
> CPU-by-CPU offline/online hotplug mechanism, which aligns with the
> direction of your series.
>
> There is one key difference in scope worth discussing:
>
>    Your series requires "nohz_full=" to be present at boot (even with
>    an empty CPU list) to opt into runtime updates. DHM targets systems
>    where nohz_full= was never configured at boot — enabling CPU noise
>    isolation purely at runtime without any boot-time setup.
>
>    This requires making the nohz_full infrastructure activatable at
>    runtime for the first time, rather than just extending an already-
>    initialized boot configuration.
>
> Before we start coding v4, a few questions:
>
>    1. Are you planning a v2 of your series? If so, what is your
>       timeline? We want to avoid duplicating effort on the subsystem
>       patches (tick, RCU, genirq).

Yes, I am planning to send out a v2 in a few weeks depending on whether 
I can finish the other works that I am doing right now.


>
>    2. Would you be open to extending your series to cover the
>       "no boot parameter" use case, or do you think it is better kept
>       as a separate series?
The reason to make the v1 series depending on the nohz_full parameter is 
basically a short cut as some code will change its behavior slightly 
depending on if the nohz_full parameter is set. By making it optional, 
we just have to add more code to enable them. It is more work, but 
doable. I will make that optional in the next version, but I probably 
won't have all the needed code other than the essential ones and the 
rests will be handled in a followup patch series.
>
>    3. Are there specific patches in your series where you would welcome
>       our contribution directly?

I have broken down the shutdown callback into separate portions as 
suggested by Thomas. The other major change that I am working on is to 
try to shutdown to only CPUHP_AP_OFFLINE state instead of all the way 
down to CPUHP_OFFLINE. That will require some adjustments to the 
nohz_full related hotplug functions. I have some ideas of what needs to 
be done. However, I haven't looked into RCU yet. I know RCU support 
changing the nocb mask for fully offline CPUs, I will need to find out 
if it possible to do that for partially offline CPUs.

The work has been suspended for a while as I have other works to do. 
Hopefully I can restart it soon to further refresh my memory and we can 
discuss collaboration at that point.

Cheers,
Longman


>
> Happy to collaborate on a unified approach.
>
> [1] DHM RFC (2026-02-06): https://lore.kernel.org/r/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com
> [2] DHM v1  (2026-03-25): https://lore.kernel.org/r/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com
> [3] DHM v2  (2026-04-13): https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
> [4] DHM v3  (2026-06-18): https://lore.kernel.org/r/20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com
> [5] Your series v1 (2026-04-20): https://lore.kernel.org/r/20260421030351.281436-1-longman@redhat.com
>
> Jing Wu <realwujing@gmail.com>
> Qiliang Yuan <yuanql9@chinatelecom.cn>
>


