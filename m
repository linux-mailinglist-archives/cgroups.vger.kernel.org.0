Return-Path: <cgroups+bounces-5332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154A9B635F
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462E52823F3
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC71EABAD;
	Wed, 30 Oct 2024 12:51:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD31E32D8;
	Wed, 30 Oct 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292672; cv=none; b=a/LRJpVJwnCFAMbvI6bnD8ulB2+Xsa2172/c6CZRZSPMasjKTh2QByzeGXSNcrvf+zia93o4RYOXidSyKC38cv882/13QTFJyYvh4FseH8B/bGphs18fCZ0Ep5rqf3dxaiJNz1DbafnuxRpcnGOCji/ukQCnVSu98yUoJ8+7rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292672; c=relaxed/simple;
	bh=amtuKIZRAbExp3+zXPKGfjQ5RMpg7nZEIXnnYLkh6os=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ApDoL4fjRD3Wv/uyKX4kvD1ooARG4iawAhGff3AB/eXmtpjirQVjriiQA9VFsG+tgvcO10WkofsPxwWM3RchFny/HAW1hliWrDQjwcO+09ff0WOg5im+urtJ5Zu/xNPMeO+pQoV0j7a6DPkLbgpf0NnQOzs9aIx2VAf3jAn3VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdn1G6lGqz6GDn7;
	Wed, 30 Oct 2024 20:46:10 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0915F140429;
	Wed, 30 Oct 2024 20:51:02 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 15:51:01 +0300
Message-ID: <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
Date: Wed, 30 Oct 2024 15:51:00 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stepanov.anatoly@huawei.com>, <alexander.kozhevnikov@huawei-partners.com>,
	<guohanjun@huawei.com>, <weiyongjun1@huawei.com>,
	<wangkefeng.wang@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>, <kang.sun@huawei.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <ZyHwgjK8t8kWkm9E@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 10/30/2024 11:38 AM, Michal Hocko wrote:
> On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
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
> 
> Do you have any specific examples where this would be benefitial?

Now we're mostly focused on database scenarios (MySQL, Redis).  

The main idea is to avoid using a global THP setting that can potentially waste 
overall resource and have per cgroup granularity.

Besides THP are being beneficial for DB performance, we observe high THP 
"over-usage" by some unrelated apps/services, when "always" mode is enabled 
globally.

With cgroup-THP, we're able to specify exact "THP-users", and plan to introduce
an ability to limit the amount of THPs per-cgroup.

We suppose it should be beneficial for some container-based workloads, when 
certain containers can have different THP-policies, but haven't looked into 
this case yet.

>> New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
>> have completely the same format as global THP enabled/defrag.
>>
>> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
>> cgroup mode changes aren't propagated to child cgroups.
> 
> So this breaks hierarchical property, doesn't it? In other words if a
> parent cgroup would like to enforce a certain policy to all descendants
> then this is not really possible. 

The first idea was to have some flexibility when changing THP policies. 

I will submit a new patch set which will enforce the cgroup hierarchy and change all
the children recursively.

-- 
Asier Gutierrez
Huawei


