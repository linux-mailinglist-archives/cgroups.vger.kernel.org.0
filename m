Return-Path: <cgroups+bounces-15040-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFKIBW4TxGmfwAQAu9opvQ
	(envelope-from <cgroups+bounces-15040-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:55:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD9329713
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90A3A30D6CD1
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E563FB076;
	Wed, 25 Mar 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGDxpGRY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A093FB044
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457268; cv=none; b=OJoD8+3OaPIftcFTF/t0uOWCCbXoWz1K3Kz6pqT9neT970XUer5X/4VeDU2Lv/XwiiWtIHDd/qKAYECoUBlngWsdLQpIWU6ELs2GDDt9bSTaV54pVxZZvDPJV0WWn4A5b3LSUg5l5nxaVdXKCPUxNc8wlAy31Bxqoi51XENUQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457268; c=relaxed/simple;
	bh=K4BxcvVT9DOS+ciJJUryQSjfzZ3lt769DJsYGCnCnxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDhnUH5byKaQ8PHk5/qPY7Igh8SdGSlhQW9vDhOAblgcmwrPeoejKey9IrP+COHkH1n3ch0YRLgk1rVPPJD9HwU1IfEGQzBh4r45YZcj7gUc4gPnumOLxj/OGz/KyGS6bhnUbPcj6qyI4qF3wwCzBGApmXlYbGHdsbc7xD3Uk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGDxpGRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774457260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qr1ol5vgsFYLsTQCwug9Kc0NRV9WjDpLVa+vxqFIkA=;
	b=CGDxpGRYIf6Hm3FReacDXlF6bISnCPz1HQjqWgZTcU9NPP/sOu2UgOYPa3wag1CQ1faUQG
	jt5jmcsEqRYE4ZElLOyKnlKPRdr6zxhAC2VOf7pK9E7kI1WzERhSMUVjCtwE0LcXjyXZrk
	xWOQbE0yLisYjYFYIHwiAxGfDpfDZ2U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-LZwgIJoPN5aDYJv_C8P7yg-1; Wed,
 25 Mar 2026 12:47:34 -0400
X-MC-Unique: LZwgIJoPN5aDYJv_C8P7yg-1
X-Mimecast-MFC-AGG-ID: LZwgIJoPN5aDYJv_C8P7yg_1774457252
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73AC2195607A;
	Wed, 25 Mar 2026 16:47:31 +0000 (UTC)
Received: from [10.22.90.27] (unknown [10.22.90.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E61D19560B1;
	Wed, 25 Mar 2026 16:47:27 +0000 (UTC)
Message-ID: <f7159388-c13f-408c-8cb5-02da8b474f57@redhat.com>
Date: Wed, 25 Mar 2026 12:47:26 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with
 int_sqrt(nr_cpus+2)
To: Yosry Ahmed <yosry@kernel.org>, Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-2-longman@redhat.com> <acE2MoIZ0pl7U7PX@redhat.com>
 <CAO9r8zOTYPgqc_7TVWjQ=adn=pH1TLLX2cBNfa1Y-x=TOFJT1Q@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAO9r8zOTYPgqc_7TVWjQ=adn=pH1TLLX2cBNfa1Y-x=TOFJT1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-15040-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DFD9329713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 8:15 PM, Yosry Ahmed wrote:
> On Mon, Mar 23, 2026 at 5:46 AM Li Wang <liwang@redhat.com> wrote:
>> On Fri, Mar 20, 2026 at 04:42:35PM -0400, Waiman Long wrote:
>>> The vmstats flush threshold currently increases linearly with the
>>> number of online CPUs. As the number of CPUs increases over time, it
>>> will become increasingly difficult to meet the threshold and update the
>>> vmstats data in a timely manner. These days, systems with hundreds of
>>> CPUs or even thousands of them are becoming more common.
>>>
>>> For example, the test_memcg_sock test of test_memcontrol always fails
>>> when running on an arm64 system with 128 CPUs. It is because the
>>> threshold is now 64*128 = 8192. With 4k page size, it needs changes in
>>> 32 MB of memory. It will be even worse with larger page size like 64k.
>>>
>>> To make the output of memory.stat more correct, it is better to scale
>>> up the threshold slower than linearly with the number of CPUs. The
>>> int_sqrt() function is a good compromise as suggested by Li Wang [1].
>>> An extra 2 is added to make sure that we will double the threshold for
>>> a 2-core system. The increase will be slower after that.
>>>
>>> With the int_sqrt() scale, we can use the possibly larger
>>> num_possible_cpus() instead of num_online_cpus() which may change at
>>> run time.
>>>
>>> Although there is supposed to be a periodic and asynchronous flush of
>>> vmstats every 2 seconds, the actual time lag between succesive runs
>>> can actually vary quite a bit. In fact, I have seen time lags of up
>>> to 10s of seconds in some cases. So we couldn't too rely on the hope
>>> that there will be an asynchronous vmstats flush every 2 seconds. This
>>> may be something we need to look into.
>>>
>>> [1] https://lore.kernel.org/lkml/ab0kAE7mJkEL9kWb@redhat.com/
>>>
>>> Suggested-by: Li Wang <liwang@redhat.com>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
> What's the motivation for this fix? Is it purely to make tests more
> reliable on systems with larger page sizes?
>
> We need some performance tests to make sure we're not flushing too
> eagerly with the sqrt scale imo. We need to make sure that when we
> have a lot of cgroups and a lot of flushers we don't end up performing
> worse.

I will include some performance data in the next version. Do you have 
any suggestion of which readily available tests that I can use for this 
performance testing purpose.

Cheers,
Longman


