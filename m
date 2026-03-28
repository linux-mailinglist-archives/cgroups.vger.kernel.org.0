Return-Path: <cgroups+bounces-15086-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL63ARYyx2mNUAUAu9opvQ
	(envelope-from <cgroups+bounces-15086-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 02:42:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B934CF99
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6549730628DC
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29233D6D6;
	Sat, 28 Mar 2026 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN6JuCq6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E633B6CC
	for <cgroups@vger.kernel.org>; Sat, 28 Mar 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774662152; cv=none; b=shQtfGLOV4gcPCtOFOXOmQLque5pfLpUpUDRbWqpLyUoMKQV26OnWi2Onpzr1U3nYID0hkuixPdiNHSorOOOXnWZvI9v8LhyXCGmz64ArGQTbsfhsLfwpy6NbHqQOujuKJ0z5NKqk+AyuykGQHGDM9yidTmDvXwwzvEGkW0eP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774662152; c=relaxed/simple;
	bh=Zxw6BEZt/X5JWZF3CLG8PgkbvRurpxDy3dPdY2ecr2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOUaXeddknnx3DOXju/y3SylQCwevRkeJb/qSwoWXgggFUjOMgiaLCyo+vZzAdIfEo/EeBfYe4XQRXQtRbXn4E2BcJfCBwzSIIDl6ZkW7a2Hgxg6vBGGraAODTDC/EruoUaLHiZozJCHbAJsDqgHlJMNcKaTDQvb35SigvBbzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UN6JuCq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774662150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqVzxyiLsd5PaN4PD+PqCSkisCpB3wCYllL7dq7ATMc=;
	b=UN6JuCq6sX/xn0k8ggIiPVvZior4nWEdmT6L/jBWrDlSWWcXIkvOnmLFUJh7X18T/ClCfg
	npyCPtg9CdeSMkHIB5+LvXORlnCGUBJgSAaGVeHTUREV62aCxFygOBNz6lJt7apM6guFBL
	4DDsTV2fsf2U9zU1x+DElKn6cS5//+U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-beep6VKfNx6E7MCVPWMNaw-1; Fri,
 27 Mar 2026 21:42:26 -0400
X-MC-Unique: beep6VKfNx6E7MCVPWMNaw-1
X-Mimecast-MFC-AGG-ID: beep6VKfNx6E7MCVPWMNaw_1774662145
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D391195608C;
	Sat, 28 Mar 2026 01:42:25 +0000 (UTC)
Received: from [10.22.90.2] (unknown [10.22.90.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA4721955D71;
	Sat, 28 Mar 2026 01:42:23 +0000 (UTC)
Message-ID: <746bf9c6-c35c-4c2d-b874-46cdc34d2cc4@redhat.com>
Date: Fri, 27 Mar 2026 21:42:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip security check for hotplug induced v1
 task migration
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, Johannes Weiner
 <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327201546.2463644-1-longman@redhat.com>
 <acbnI21DC-W_uE2F@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <acbnI21DC-W_uE2F@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15086-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B10B934CF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/27/26 4:22 PM, Tejun Heo wrote:
> On Fri, Mar 27, 2026 at 04:15:46PM -0400, Waiman Long wrote:
>> +	/*
>> +	 * Set to true if a kthread is moving tasks away from a v1 cpuset with
>> +	 * no CPUs
>> +	 */
>> +	kthread_move_task_from_empty_cs = !cpuset_v2() &&
>> +					  cpumask_empty(oldcs->effective_cpus) &&
>> +					  (current->flags & PF_KTHREAD);
> PF_KTHREAD test seems odd. Can't you pass this in as a flag from hotplug
> handler?

Yes, I can added a new CS flag like CS_TASK_MIGRATION in the hotplug 
handler to indicate that task migration is allowed. Thanks for the 
suggestion. I will send a v2 with that change.

Cheers,
Longman


