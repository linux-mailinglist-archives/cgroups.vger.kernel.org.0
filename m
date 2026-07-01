Return-Path: <cgroups+bounces-17424-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uiSIDPJiRWrx/AoAu9opvQ
	(envelope-from <cgroups+bounces-17424-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 20:56:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6776F0BE7
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 20:56:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fKo5AVoG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17424-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17424-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FDA73014865
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0E36A01E;
	Wed,  1 Jul 2026 18:56:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C2371D08
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 18:56:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932204; cv=none; b=NpD2gnnNctlEOJrNFZg95i3S6MVd376ZF+Ai8cyzbpC67NaYCKmhUEyTUQ7m2CogtwGXQjmpYj08nvpnTudaTlifbuu10CWZCWWt7jxOt30451LiDcitVnNNj6d7gvFOMVIdAujZylYBAEB16epQDGtSbavDbV0Sxuakrpio9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932204; c=relaxed/simple;
	bh=4BgPV2/VaUukdlTO4jkR9GftjvZxqXwtX1sal7tPcek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxh0JwrFqZUeo5ONhirjhMoHEBMYQtBfa59p4PHaUuws1cNH1vgugBYnpDeDQ5LxvfLOVLFLld64kyPn8S69zFzpgM2ZvrLCmDelNHRx9Mhqb3d/ZKVUU1UVKtwhK3CMJrpGXn5dVn2GkVnn9KR4eVw7jTXInzdRKdpGsz/OHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKo5AVoG; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782932202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uZnPXlwthy6lScVWCuvfaYfSKsmQjXT7n+7jXDhe0Y=;
	b=fKo5AVoGZpG2C6Aac4GcwUD/IOg2Gc0PW55/Fq4dPyJen9tddOdOjlzCaA2TPp0CopHxcP
	RUJvp47i0ScwK0pYza1EyHKnCcA0OkfCENz9YJPq3LPtSrdOjoaU+zVvQ3rYoe0IRSvC7o
	qeaICCn8CrQLYp8+s2lHXcbl7dN88LM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-bMpicIl7P4ucYk2QumtGrw-1; Wed,
 01 Jul 2026 14:56:39 -0400
X-MC-Unique: bMpicIl7P4ucYk2QumtGrw-1
X-Mimecast-MFC-AGG-ID: bMpicIl7P4ucYk2QumtGrw_1782932197
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6161933EAC;
	Wed,  1 Jul 2026 18:56:37 +0000 (UTC)
Received: from [10.2.16.170] (unknown [10.2.16.170])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 622041955D53;
	Wed,  1 Jul 2026 18:56:35 +0000 (UTC)
Message-ID: <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com>
Date: Wed, 1 Jul 2026 14:56:34 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of
 nohz_full and managed_irq CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, cgroups@vger.kernel.org,
 Qiliang Yuan <yuanql9@chinatelecom.cn>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260624063404.2106807-1-realwujing@gmail.com>
 <4ad24488-9cc1-4f1c-8dc5-6830ae7420df@redhat.com>
 <akUii2CyEi7SRid7@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <akUii2CyEi7SRid7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,chinatelecom.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17424-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:frederic@kernel.org,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F6776F0BE7

On 7/1/26 10:22 AM, Frederic Weisbecker wrote:
> Le Thu, Jun 25, 2026 at 01:27:54AM -0400, Waiman Long a écrit :
>> On 6/24/26 2:34 AM, Jing Wu wrote:
>>>     3. Are there specific patches in your series where you would welcome
>>>        our contribution directly?
>> I have broken down the shutdown callback into separate portions as suggested
>> by Thomas. The other major change that I am working on is to try to shutdown
>> to only CPUHP_AP_OFFLINE state instead of all the way down to CPUHP_OFFLINE.
> What was the reason for that already? Can we perhaps ask the user to offline
> the target CPUs before toggling isolation on them?
The major problem about fully offlining the CPU is the CPU hotplug stop 
machine mechanism which put all the CPUs except the CPU to be offlined 
in a waiting loop within the IPI handler when the offline CPU is 
transitioning from CPUHP_TEARDOWN_CPU to  CPUHP_AP_IDLE_DEAD. If there 
is another active isolated partition running DPDK, for instance, it will 
break the low latency guarantee for a short duration.
>> That will require some adjustments to the nohz_full related hotplug
>> functions. I have some ideas of what needs to be done. However, I haven't
>> looked into RCU yet. I know RCU support changing the nocb mask for fully
>> offline CPUs, I will need to find out if it possible to do that for
>> partially offline CPUs.
> No because callbacks can still be enqueued at this stage. But we could
> manage to make it work with CPUHP_AP_IDLE_DEAD.

If we can only go as high as CPUHP_AP_IDLE_DEAD, we may as well go down 
all the way to CPUHP_OFFLINE as stop machine should be done at 
CPUHP_AP_IDLE_DEAD. In that case, we may have to break RCU out from 
HK_TYPE_KERNEL_NOISE and add a cpuset control switch for the system 
administrators to decide if they are willing to suffer a brief latency 
spike for an existing isolated partition or keep the RCU housekeeping 
mask unchanged to avoid that when creating a new or destroying an old 
isolated partition.

Cheers,
Longman

>
> Thanks.
>


