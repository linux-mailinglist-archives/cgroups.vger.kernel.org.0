Return-Path: <cgroups+bounces-5375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D89B9142
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 13:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E705282C08
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425B19E992;
	Fri,  1 Nov 2024 12:44:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF419E96A;
	Fri,  1 Nov 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465054; cv=none; b=MC8DW1/cNzzEYzShQU/9Q7+V2/3RTwpFOEFmHD7jTvO4Hf0n0MEmw3TaII6GaX230An4Y6w0BVB2HvjmaGOuYPzZXn13dnYDR081PLcRVa5Oi1gTc+8xaJ0Ga+i1tCLRUC/l05m6TrHaHQ83NASXQTNWNmofdQbIc6xkMJEinP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465054; c=relaxed/simple;
	bh=Snyp2ySjpZzEgk0ZLrDhOfkntw7K4f2P1CXvtvSlq14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hEWpAumUuRwq4zKbtbyejDK2UrdM+mYDJHrjUuaSQuqHTDciVN7ZRAduoh0UybzMZ+WHweTsNRhdX/f2zK4HUT1TIFHWLqiDuRvDwhIlBJK3CTDRQZa2yLOahTeQeVEF72L2dVmtMoLMKIShC3KGb+yUCRMBxbujxvHGHR+vy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg0mK0jPzz6LD2q;
	Fri,  1 Nov 2024 20:39:13 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C03C140B55;
	Fri,  1 Nov 2024 20:44:07 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 15:44:06 +0300
Message-ID: <8e55d735-b65d-428f-8689-8f0b729d56c4@huawei.com>
Date: Fri, 1 Nov 2024 15:44:06 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Johannes Weiner <hannes@cmpxchg.org>,
	<gutierrez.asier@huawei-partners.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeel.butt@linux.dev>,
	<muchun.song@linux.dev>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <alexander.kozhevnikov@huawei-partners.com>,
	<guohanjun@huawei.com>, <weiyongjun1@huawei.com>,
	<wangkefeng.wang@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>, <kang.sun@huawei.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <20241030150851.GB706616@cmpxchg.org>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <20241030150851.GB706616@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 10/30/2024 6:08 PM, Johannes Weiner wrote:
> On Wed, Oct 30, 2024 at 04:33:08PM +0800, gutierrez.asier@huawei-partners.com wrote:
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Currently THP modes are set globally. It can be an overkill if only some
>> specific app/set of apps need to get benefits from THP usage. Moreover, various
>> apps might need different THP settings. Here we propose a cgroup-based THP
>> control mechanism.
>>
>> THP interface is added to memory cgroup subsystem. Existing global THP control
>> semantics is supported for backward compatibility. When THP modes are set
>> globally all the changes are propagated to memory cgroups. However, when a
>> particular cgroup changes its THP policy, the global THP policy in sysfs remains
>> the same.
>>
>> New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
>> have completely the same format as global THP enabled/defrag.
>>
>> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
>> cgroup mode changes aren't propagated to child cgroups.

> 
> Cgroups are for hierarchical resource distribution. It's tempting to
> add parameters you would want for flat collections of processes, but
> it gets weird when it comes to inheritance and hiearchical semantics
> inside the cgroup tree - like it does here. So this is not a good fit.
> 
> On this particular issue, I agree with what Willy and David: let's not
> proliferate THP knobs; let's focus on making them truly transparent.

We're also thinking about THP-limit direction (as mentioned in cover-letter)
Just have per-cgroup THP-limit and only global THP knobs, with couple additional global modes
(always-cgroup/madvise-cgroup).

"always-cgroup" for instance would enable THP for those tasks
which are attached to non-root memcg.

Per-cgroup THP limit might be used in combination with global THP knobs,
and in this we can maintain hiearchical semantics.

Now it's just an idea, may be it's better to have another RFC patch-set for this,
to be able to have more productive conversation.


-- 
Anatoly Stepanov, Huawei

