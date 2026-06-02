Return-Path: <cgroups+bounces-16554-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A1IG7GSHmqblAkAu9opvQ
	(envelope-from <cgroups+bounces-16554-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:22:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A862A724
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0153E3097910
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 08:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780123C65E0;
	Tue,  2 Jun 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VGBZShPj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6383C4562;
	Tue,  2 Jun 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388043; cv=none; b=eI/HX7DTrD39hdiJxpcRg4i5ifaVF+3utHVVAgh2sSqv1yuLQBS+twVw6E1qah5RUvYappg72pD9HKhm6jRXqhrotOCIrnJ0EbSkm7JRZ81vqyGXsm3roSlB46CVzDhYURmebl2jT4jm0sEnmA97kzB00MFRImOSR+TzLRV4ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388043; c=relaxed/simple;
	bh=SQpcs0Q84C1o+7c9PpEn9q02bsqOrBkRPLLDOSUuAbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/YrsTR+NNven0S9meswqKY9O+eHSqAHppAw02WQsMJ89yy17NALSalHeq/ppUJOuKA2gL/HCUYqFGyfiXJuuiwXcXFpz86PpfkTzS5ae6eQxw4odqxdsomM33VrCqfGRnln9PXD9go7m3fI+ZSIoltOjzYbZDkUL59v06RwOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VGBZShPj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69b82f73-e89a-4271-a494-3c4d5684b7ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780388039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a60V33IIRXAacvUxlNYow4aNXv6LcX5H2j7rbYg219M=;
	b=VGBZShPjb5j6l9sY0VJtmo5N5VRFpNTjZ6F1N3UJNb6q3LgY/yOo9XuFkK1ulBnGsvVb4u
	uMMKPmNiUWcl5GG2Vsk0zir3faZ6xan5ow4qVa4DOO83RPOxL2hHsxX2bc9p/8VpuIZ9bd
	QgSMF1/wxC617Elh9xRkYhTcwAZaVxc=
Date: Tue, 2 Jun 2026 16:13:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup/cpuset: Remove Chen Ridong as a cpust reviewer for
 now
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602024422.249458-1-longman@redhat.com>
 <ah6LAfpMsdPLun2_@localhost.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <ah6LAfpMsdPLun2_@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16554-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_SPAM(0.00)[0.198];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Queue-Id: E34A862A724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/6/2 15:51, Michal Koutný wrote:
> +Cc: ridong.chen@linux.dev
> 
> (This looks like their new address.)
> 

Hi all,

Thank you, Michal.

Apologies for the email issue. I'm currently changing my company, The
ridong.chen@linux.dev email is valid.


> On Mon, Jun 01, 2026 at 10:44:22PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Chen Ridong has contributed quite a lot of fixes and cleanups to the
>> cpuset code. Unfortunately, his email address is now no longer valid. So
>> remove him as a cpuset reviewer until he shows up again or someone else
>> volunteers to take his place.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 74c86cf9bc65..c7a7126ea406 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6526,7 +6526,6 @@ F:	include/linux/blk-cgroup.h
>>  
>>  CONTROL GROUP - CPUSET
>>  M:	Waiman Long <longman@redhat.com>
>> -R:	Chen Ridong <chenridong@huaweicloud.com>
>>  L:	cgroups@vger.kernel.org
>>  S:	Maintained
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
>> -- 
>> 2.54.0
>>

-- 
Best regards,
Ridong

