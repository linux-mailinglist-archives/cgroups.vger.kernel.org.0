Return-Path: <cgroups+bounces-17003-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W8ygBN9sMWoKjAUAu9opvQ
	(envelope-from <cgroups+bounces-17003-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 17:33:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4D69125A
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 17:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OzTFwDNS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17003-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17003-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74827305E164
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C9441035;
	Tue, 16 Jun 2026 15:27:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E243E48C
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 15:27:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623649; cv=none; b=bQ5Dr7GiFsllXvwWx7DJhjGUudQeg0RbwtpSm4vm3EkhbUs5w8OOgkiCWQUgfzzQRF+gUWHYwgrjoUBwPIKxpWc2yuVNHfDExZsNlSMHMpqS3dkxJfyFxGk71Fg7ULNtpCF2zlxWUr9+9nYecc0SvJanSMfeUHqR9YFSSCMVGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623649; c=relaxed/simple;
	bh=gWePh3Vznf74DWR5pPqi6EqAwqedNELsKH618o5hclA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzdxcpYkKTyQ/dWPOY8LsPj+yXLE70Nupi3WVu5i0v2SjbwlzVlA0b4eMMUzcejGzQ6mQwfNQdkZZU9EcBsGQJDZ8unoBhgNUdqD9K2DS2hCNoUpqVSSf1HinU1LtY9viqtZ791/e4UqJ75zmwLrZmXL7RIYW+tk+lfeowmSsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzTFwDNS; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781623647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM8sP3MAiJZZknY6HDXqfIBCoWcPf7VRCGmXyvu7wus=;
	b=OzTFwDNSBl3u2LRbBfCht4oYlTCf5fMXKy5A4LW7874ao80szCQZpZfK44I7IgHBkNKdaU
	qhZtxffnvvz/9UixPHc2TxPF2HTKkqA8ZVvyqY0Xfh6PZcuOVDc8K4N6BZhTZmloNlucKO
	SDe7lhM9hqS74ohof/OiXVhzMVJuqp4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-jgGo_N4IM2WI6zmN4LSXbA-1; Tue,
 16 Jun 2026 11:27:23 -0400
X-MC-Unique: jgGo_N4IM2WI6zmN4LSXbA-1
X-Mimecast-MFC-AGG-ID: jgGo_N4IM2WI6zmN4LSXbA_1781623638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AB4C1955F0D;
	Tue, 16 Jun 2026 15:27:17 +0000 (UTC)
Received: from [10.22.81.159] (unknown [10.22.81.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60017180058F;
	Tue, 16 Jun 2026 15:27:13 +0000 (UTC)
Message-ID: <cca24d1a-f4c9-43a2-8411-5b2919d4efb0@redhat.com>
Date: Tue, 16 Jun 2026 11:27:12 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
To: Gregory Price <gourry@gourry.net>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Farhad Alemi <falemi@asu.edu>,
 Yury Norov <ynorov@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, stable@vger.kernel.org
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
 <c1495b1b-9dee-4cd5-ac8e-eeb7a2d968ed@redhat.com>
 <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
 <ajFTVaMBeu-ViGIC@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ajFTVaMBeu-ViGIC@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17003-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:david@kernel.org,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[berkeley.edu,linux-foundation.org,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5C4D69125A

On 6/16/26 9:44 AM, Gregory Price wrote:
> On Tue, Jun 16, 2026 at 08:59:07AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/16/26 05:43, Waiman Long wrote:
>>> On 6/15/26 10:26 PM, Waiman Long wrote:
>>>>
>>>> The reason why I am suggesting to use cs->effective_mems to keep the old
>>>> cgroup v1 behavior. If the consensus is to use the output of
>>>> guarantee_online_mems() for mpol_rebind_mm(), I will not be against that but
>>>> it will be a slight change in user-visible behavior.
> I'm not grok'ing what is user-visible here.
>
> The two values should effectively be equivalent because we're
> using this value to constrain mpol's during a hotplug event.
>
> If the values differed, you would be saying there's a race condition
> that could affect correctness of the rebind (which can't happen,
> because this whole thing is done under the hotplug lock btw).
>
> Can you help me understand?

The effective_mems and guarantee_online_mems() should be more or less 
equivalent for v2, but not for v1. In my response to David, I gave an 
example of how the behavior will differ.

Cheers,
Longman


