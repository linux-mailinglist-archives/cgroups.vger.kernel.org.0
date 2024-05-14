Return-Path: <cgroups+bounces-2888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660E48C59FD
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6091F2268F
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349AE17F360;
	Tue, 14 May 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5fDHzy5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87A1D545
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705998; cv=none; b=MuWjxmOUJjVSPEgyl7XDmwirgKgD1X0r+N9Xsuv9ZDhNz4Z8Pwcg1vr/cq6iCnsoayChcqBFVLAocOL1Jmu90IbVyZQor75s3KHRu3hqi8AnPTwf57CsuH4hUqooZPO44KFXgz8a5PGQGmzZ3jmA/OoJFh0i7X5B2LiVQV47PJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705998; c=relaxed/simple;
	bh=3puDKRCrXC97Hh3eM9auD/+0l7RDPjAGfKBgxXpnnJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Opo1wEc3cLyrddPPRDFy2+uaHiMy4vRrBgD6PeM48lMHlBjs4d2lr2N176IJX/Oc6UHyW19pGLpXHW2ER4FQgQwAwiPhT8ujGxiCmW2JPAJtZ9lvtIizbozWUSCgv7kP6wg/sSEJ/MCVNGeRMZXWSDp1EN90StOqiyg0QB1swZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5fDHzy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715705995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB/G6KUfU+DCM/xaB8pIoFRp7BmXiyp1KdrOA+kE+Ck=;
	b=K5fDHzy5gdHmSPuBmJ2I0kcDqj9uwyFryvQwsA+53CzDQl1anCPhSJiVdkt4AxRMVAfi3Q
	828vNA2QfQp/20u0aBcCr3Mf4A56Pym79kZWcj4N6H9+H9/sQJCW2tT+YHtRmK+ytP15ng
	y0mZG6zsQYFNojzdED3+8FPBAEKbfDs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-rmFPpzH3MbKfVZSYz_h6VQ-1; Tue,
 14 May 2024 12:59:53 -0400
X-MC-Unique: rmFPpzH3MbKfVZSYz_h6VQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A74538000A1;
	Tue, 14 May 2024 16:59:53 +0000 (UTC)
Received: from [10.22.34.104] (unknown [10.22.34.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 754515423E1;
	Tue, 14 May 2024 16:59:52 +0000 (UTC)
Message-ID: <bc75227e-bbfa-4da3-9b83-a7fb2ef8a1e6@redhat.com>
Date: Tue, 14 May 2024 12:59:52 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Tejun Heo <tj@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 yosryahmed@google.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 shakeel.butt@linux.dev, kernel-team@cloudflare.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <0ef04a5c-ced8-4e30-bcde-43c218e35387@kernel.org>
 <ZkL83GKD7sga8tFX@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZkL83GKD7sga8tFX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 5/14/24 01:55, Tejun Heo wrote:
> On Tue, May 14, 2024 at 07:18:18AM +0200, Jesper Dangaard Brouer wrote:
>> Hi Tejun,
>>
>> Could we please apply this for-6.10, to avoid splitting tracepoint changes
>> over multiple kernel versions?
> Yeah, I can. Waiman, would that be okay?

I am OK with this commit as it shouldn't impose that much of a 
performance cost if the tracepoints are activated.

Cheers,
Longman


