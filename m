Return-Path: <cgroups+bounces-13115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8DD1635E
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 02:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38646300A9A0
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830027E045;
	Tue, 13 Jan 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq6nkmJp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jYMFUl21"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326022B8CB
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268972; cv=none; b=pspnPOunXx8VsAQeGbSqwX6VbznbQlTPklNcxL6jOVEii9r+a8rofB5fXqzrznpp9/5CK6Nl/CS3vgaF/xKvAVWM/Pytn0Rht/gaRb3Ev9X8aGWfhrVnkxxGFuAgQBzs1lA+J8aLvj4E6MsxHuFxSMlLYx7nFy092tMMueepvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268972; c=relaxed/simple;
	bh=odrlExJfFzg0riamVUhcfYPGQohsWjwFOIvkcN9lcyU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=COEK3Uk3yYH+6vB64jTXPWmv3Y/6wdbcAash8SHpB95U4nHgmgP94QDOZLUDwNP8IyRL/FRt4zOhe1PJjyRevJ/NK9cUYBFxZUTRSwwSS6V+eCacq2iIlkJxYTArogMlzeGvBf1s3171pQiiMKQe6a2bS21WAtt4Kwg0Pf734jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq6nkmJp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jYMFUl21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768268969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ipl04u3803c/IO8SDz5fqTBlvGqq/KbVl3bI4vEOEvs=;
	b=cq6nkmJp7XLRu0u2mCD9I2beSGedYDfd9LPLQ9XCfMqI/PB7Rt9yH3Ij37aeKtX0rCD8UL
	D2UIGBmfqyPr/Y9e2JwccJ89HvJa6KaVgb+pJgaXFCTW9kGWyxYxGHuszs/9TatQnxK5m/
	4PyJU0YXmPaFYk77eIo2gUCuIWlAHG4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127--404ZvMgNIGAg4AFr1VQDg-1; Mon, 12 Jan 2026 20:49:28 -0500
X-MC-Unique: -404ZvMgNIGAg4AFr1VQDg-1
X-Mimecast-MFC-AGG-ID: -404ZvMgNIGAg4AFr1VQDg_1768268968
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f5ac349ecso8869043241.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768268967; x=1768873767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ipl04u3803c/IO8SDz5fqTBlvGqq/KbVl3bI4vEOEvs=;
        b=jYMFUl212ciIq5CSn6Wmac95+LZOvdKNrvFF0iJ1ebHrC5A3oOgGoCFXihFbgUiOzV
         2YS9T2Y8b9cLS9EmlYBkZ3PjDEg+zPLn32EDgXW+HXwIV+PSKU1pje8AbM+KeoOCTO3m
         Xt+9CMenVQkZ5F/b1orZLvEoxnq28rgzzt8d1Y7mpNnXuWeZ1/ijG00smmtUwKlr4BO5
         FwKubGtdNPHfikkUw8ljxJFgTPkmtkvYZlWmn+DkgZcGboXTS55aSaMRc6OLXapGhINR
         WGXvY6ZvX3jBUy1ClmsxxbC/FFwPghdtqNifKMM3sHe90goSydt5l0ncJYuIDhhLmrX9
         ASvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768268967; x=1768873767;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipl04u3803c/IO8SDz5fqTBlvGqq/KbVl3bI4vEOEvs=;
        b=bsHb/wYL787T8CX2Zc45zTQYXOe+2DNb3fQKHA4BdJTncOimKYliZTK21UB40qWWEl
         VWS+eC0My2jBOmhzFMn7WgCzDzhhjZbS7VMj49KKZgI5IN80cbazwRX5PDL2Vyk+Ymgj
         +DLTvw9vyQBCA4Ztgr4qShLrsMtpxwrM37eTNSDHReyo8xuxw4nyN+WCfy60gBEuIIlO
         wVDbHDBuch0ENZ0+/MIBy/0K1oSRm/LFP2WioF4uNUOeKTqd+LOI4Lowrd8IP3EbjjO1
         eWQgp6vT0UvkDXBMbQb6Tqe2IpnIypJTQZI5CSZaSCDtjcOdyu07poy/04aeD1PYkA+w
         eUmw==
X-Forwarded-Encrypted: i=1; AJvYcCWETk3q14CsFw4Ybyq0dP00EQJWMw0JfRDMgiB+//xhXmB7d0iFY+/L1N4jMotSK2ZYKKlkV8ke@vger.kernel.org
X-Gm-Message-State: AOJu0YwJs1do8fRN1769Fyf7TFDh1UP5BI970LMMF6FGK5hW7oNE3qhw
	eT06AUHfnGgh7uIqC0QUSrSne1UUZXc9SkHu9E0a0n23SUhldh3zuyt2DHUR+Mtt6xdNOf1LDCx
	MENI2dwohaa83d1q/V8VzEXEIGslHl3FA8+fOlslAPqZELTi5lBiqz+YXNco=
X-Gm-Gg: AY/fxX6MD7y8brkzESDD/2WLpznejB5e1Xyau8ZOc815FsqVK4IN/xUQLPrxF/ZYzpG
	5IvTiahHV2PrCgZNiWthMdAH0f1NR0bQXl4Wjl31BBcW8T9HMKBUQZqUxx12tVm+Ho8ZgU0XhB+
	KormlMkaHR2HqxEmt8epaBW9Q00V417ib/3hyFDEi7RabQjxWthvQJH2hSQDUI2RqviSZAq0kfu
	p40FN02FD5YJNzkwL/oMDgZm5J4OqEm5DTA6UtI4V7wiOEInzcd979wZo8rgxK1WAZG+EZvybDL
	zEXS4SFXF1Voui72Df11vNp3i1pAdTL4p+ZHr+Zn+jw+SDm/uTZ/VQI0DVz7CqrgdpIRZ2XQlDU
	h0wasljB+taB1JHp8oV6ai49bh+O0N7feq0I9TJmLF4GQhmHmabeV0KsP
X-Received: by 2002:a05:6122:4b89:b0:55b:305b:4e38 with SMTP id 71dfb90a1353d-5634800729cmr7402447e0c.19.1768268967531;
        Mon, 12 Jan 2026 17:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK3nQoFNSvzu3p3PMs7jwaVTVycoM8jcu4b27g95LRRVLuycfC94MCTb+8aGEaS+r94nXQbg==
X-Received: by 2002:a05:6122:4b89:b0:55b:305b:4e38 with SMTP id 71dfb90a1353d-5634800729cmr7402411e0c.19.1768268967043;
        Mon, 12 Jan 2026 17:49:27 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5635bd72c7esm13437373e0c.12.2026.01.12.17.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 17:49:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2857c203-96e5-4bf9-b19c-7a80b009cce2@redhat.com>
Date: Mon, 12 Jan 2026 20:49:11 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33 v6] cpuset/isolation: Honour kthreads preferred
 affinity
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Michal Koutny <mkoutny@suse.com>,
 netdev@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Michal Hocko <mhocko@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Simon Horman <horms@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Gabriele Monaco <gmonaco@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Will Deacon <will@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>
References: <20260101221359.22298-1-frederic@kernel.org>
 <437ccd7a-e839-4b40-840c-7c40d22f8166@redhat.com>
 <aWVxJVQYEWQiyO8Q@pavilion.home>
Content-Language: en-US
In-Reply-To: <aWVxJVQYEWQiyO8Q@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 5:09 PM, Frederic Weisbecker wrote:
> Le Mon, Jan 12, 2026 at 01:23:40PM -0500, Waiman Long a écrit :
>> On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
>>> Hi,
>>>
>>> The kthread code was enhanced lately to provide an infrastructure which
>>> manages the preferred affinity of unbound kthreads (node or custom
>>> cpumask) against housekeeping constraints and CPU hotplug events.
>>>
>>> One crucial missing piece is cpuset: when an isolated partition is
>>> created, deleted, or its CPUs updated, all the unbound kthreads in the
>>> top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
>>> their preferred affinity along the way
>>>
>>> Solve this with performing the kthreads affinity update from cpuset to
>>> the kthreads consolidated relevant code instead so that preferred
>>> affinities are honoured.
>>>
>>> The dispatch of the new cpumasks to workqueues and kthreads is performed
>>> by housekeeping, as per the nice Tejun's suggestion.
>>>
>>> As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
>>> from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
>>> now modifyable with specific synchronization. A big step toward making
>>> nohz_full= also mutable through cpuset in the future.
>>>
>>> Changes since v5:
>>>
>>> * Add more tags
>>>
>>> * Fix leaked destroy_work_on_stack() (Zhang Qiao, Waiman Long)
>>>
>>> * Comment schedule_drain_work() synchronization requirement (Tejun)
>>>
>>> * s/Revert of/Inverse of (Waiman Long)
>>>
>>> * Remove housekeeping_update() needless (for now) parameter (Chen Ridong)
>>>
>>> * Don't propagate housekeeping_update() failures beyond allocations (Waiman Long)
>>>
>>> * Whitespace cleanup (Waiman Long)
>>>
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>> 	kthread/core-v6
>>>
>>> HEAD: 811e87ca8a0a1e54eb5f23e71896cb97436cccdc
>>>
>>> Happy new year,
>>> 	Frederic
>> I don't see any major issue with this v6 version. There may be some minor
>> issues that can be cleaned up later. Now the issue is which tree should this
>> series go to as it touches a number of different subsystems with different
>> maintainers.
> It indeed crosses many subsystems. I would be fine if anybody takes it but
> nobody volunteered so far.
>
> The main purpose is to fix kthreads affinity (HK_TYPE_DOMAIN handling cpuset is
> a bonus). And since I made the pull request myself to Linus when I introduced
> kthreads managed affinity, I guess I could reiterate with this patchset. I
> already pushed it to linux-next.
>
> But if anybody wants to pull that to another tree, that's fine, just tell me
> so that we synchronize to avoid duplication on linux-next.
>
> Thanks.

Good to know as I am wondering where it will go. So you are going to 
push that directly to Linus.

Cheers,
Longman


