Return-Path: <cgroups+bounces-829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897D806187
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 23:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F4828209A
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA876E2BC;
	Tue,  5 Dec 2023 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLsujGkp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E05137
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701814581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2Vem31mI/E1rxmbZRCBYAPkrSR+YjFerajC0+h+2EI=;
	b=iLsujGkp6DR+gpI8vZpffJztXxPMhDWwQkTQh3sl3lBg66/V4aPAsKAoAPmU1Qz+oUriUP
	SDLYFE5Q9/8jEnR2ihSV9Uj4C187CnFXxJN12RgbzNYEIp2yHGlkcf1k1Wsux7VpNgipH/
	rICKTpPGiN1/9wZBJn8PRKkYi0pq0yc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-3LYAxG9aN0qe_CfFGknouw-1; Tue,
 05 Dec 2023 17:16:16 -0500
X-MC-Unique: 3LYAxG9aN0qe_CfFGknouw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F03511C0BB41;
	Tue,  5 Dec 2023 22:16:15 +0000 (UTC)
Received: from [10.22.8.88] (unknown [10.22.8.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCC8C112131D;
	Tue,  5 Dec 2023 22:16:14 +0000 (UTC)
Message-ID: <7284ef19-ba26-46cd-9630-cad18c2e3ce7@redhat.com>
Date: Tue, 5 Dec 2023 17:16:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in
 cpu_is_isolated() check
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
 Ryan Phillips <rphillips@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Peter Hunt <pehunt@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
 <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
 <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
 <b6f88157-cf5e-4c7b-99f3-1944b4e7ebde@redhat.com>
 <ZWoSrfztmprcdkpO@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZWoSrfztmprcdkpO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 12/1/23 12:06, Tejun Heo wrote:
> Hello,
>
> On Wed, Nov 29, 2023 at 11:01:04AM -0500, Waiman Long wrote:
> ...
>>>> Depending on how the cpumask operators are implemented, we may not have a
>>>> guarantee that testing CPU 2, for instance, will always return true. That is
>>> Can you please elaborate this part a bit? I'm having a difficult time
>>> imagining the sequence of operations where this would matter but that could
>>> easily be me not being familiar with the details.
>> I may be a bit paranoid about incorrect result due to racing as I had been
>> burned before. Just testing a bit in the bitmask may probably be OK. I don't
> Setting and clearing a bit is as atomic as it gets, right?
Yes, I think so.
>
>> think it will be a problem for x86, but I am less certain about other more
>> exotic architectures like arm64 or PPC which I am less familiar about. I add
>> a seqcount for synchronization just for the peace of mind. I can take the
>> seqcount out if you don't it is necessary.
> I just can't think of a case where this would be broken. The data being read
> and written is atomic. There's no way to break a bit operation into multiple
> pieces. It is possible to write a really bone-headed bitmask operations
> (like, if you shift the bits into place or sth) to make the bits go through
> unintended changes but that'd just be a flat-out broken implementation. Even
> for a bitmask where write accesses are synchronized through a spinlock, we
> should still be able to use test_bit() without holding the lock. This seems
> like a pretty basic assumption.
>
> Adding unnecessary synchronization confuses the readers. If we don't need
> it, we shouldn't have it.

OK, I will send a simplified v2 patch.

Cheers,
Longman


