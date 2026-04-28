Return-Path: <cgroups+bounces-15543-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBleKjH28GkpbgEAu9opvQ
	(envelope-from <cgroups+bounces-15543-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:02:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C948A56B
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9395F3017251
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB52453497;
	Tue, 28 Apr 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZDYGpB6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC268391831
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399343; cv=none; b=lvSK6CqBYCUIW83qTk6ruf1qLEbQUkZDUz26Vz1+IZfdLPO0LtR/nLZj9Qe9EfvJxSlZVWMklSW5Yg4nb+a4mq54LEpnKCeBeuC3Mp9UH1TCXWIajMB9NQgEW5sBAtSfZG3Gg1wwcSjvBPeWAStJ3EbBgPNBj9vf/7h11xvz558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399343; c=relaxed/simple;
	bh=dYGwWwtkKlPo1deJLx9BodMTvAxpwgOxdsVgFmjZsoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDxJ5w0MAvPQadSm6BEDV5V2fyFOCnGepjxrZVGIUVAJfPBNRTmcXlPpvM2KLmdI7JjZ0hi8IWdWoxNavNThGL6X+xepLs6igo4w6a5CRZhvysx1MVw7yJjLNdTwNU4QZw4iUf80oz4477WqtgQr8DPp8sl1Nc26uVRLrNvi0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZDYGpB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777399340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajb3tIPe2Fnx33E4Ll33pwLtSHp6m0qrFpGOVd8lamo=;
	b=KZDYGpB6glYSyZWgek6M+8gQY4zm+OjH5bqtbqNt7yon1nflekyNuKWj+QWJMIpR3pcxvl
	BamwK7pQh6qYEdyw4KxaYIkLUlNSyHtlHf/hn2EOTcddcSgESHlgghrEIxP3IVhJ7Mphs8
	8XTqII0CzL+E8sIv7KpfBnumnJGhCO8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-Ws1fpmuWNLuZhhR_lu7h5g-1; Tue,
 28 Apr 2026 14:02:17 -0400
X-MC-Unique: Ws1fpmuWNLuZhhR_lu7h5g-1
X-Mimecast-MFC-AGG-ID: Ws1fpmuWNLuZhhR_lu7h5g_1777399334
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42DE4186016B;
	Tue, 28 Apr 2026 18:02:13 +0000 (UTC)
Received: from [10.22.65.177] (unknown [10.22.65.177])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3674D1800671;
	Tue, 28 Apr 2026 18:02:11 +0000 (UTC)
Message-ID: <973442ef-ad08-4503-8afc-c97d07298c61@redhat.com>
Date: Tue, 28 Apr 2026 14:02:10 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Xie Maoyi <maoyi.xie@ntu.edu.sg>
References: <20260428033439.783246-1-longman@redhat.com>
 <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
 <9df75f61-0cbb-42b4-b64d-8e6fd49d50ca@redhat.com>
 <afDVwO-j2UOdSpQj@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <afDVwO-j2UOdSpQj@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 413C948A56B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15543-lists,cgroups=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/28/26 11:44 AM, Tejun Heo wrote:
> Hello,
>
> On Tue, Apr 28, 2026 at 11:19:16AM -0400, Waiman Long wrote:
> ...
>> Thank for the comment. Yes, that can be a valid configuration.
>>
>> One possible workaround may be to see if the current user has write access
>> to its parent partition root. If so, we can allow it to create a
>> sub-partition, if not, we will forbid it.
> I think this whole thing is a confusion. First of all, resource knobs in any
> given cgroup is owned by the parent. Delegations where the perm to a
> resource knob is given to delegatee is not supported and expected to affect
> resource distribution w.r.t. its siblings. Partition isn't special in this
> regard. memory.low or min can create similar effects. Maybe I'm missing
> something but I don't see anything happening that's not supposed to happen.

You are right. I am a bit confused about the exact delegation rules. 
After reading the delegation section of the cgroup-v2.rst file, I 
realize that the current behavior should be OK. For clarity, I am 
planning to send a documentation patch to clarify the current partition 
delegation behavior.

Thanks,
Longman


