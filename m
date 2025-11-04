Return-Path: <cgroups+bounces-11567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A20C30D93
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A98694E425B
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC42DA765;
	Tue,  4 Nov 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Rt4arT8K"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0E242D87;
	Tue,  4 Nov 2025 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257619; cv=none; b=uYyq4Zt2Bvn8pP1ELGICwW/yNU6dF2bw6xdpCCnpP1sMlKFD4l7CV8dzMKI9hwQ4eswi7D8nIZ1V4BRGbvrudR9K+DFIQyJ8rrYQbVeih/it1YWGkd+8tfuPSjOe3EffvGgJg1zKbih6dIh95pxfvU1DgkIJilS1N68tA7Jh8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257619; c=relaxed/simple;
	bh=Ws6Yw4vhHdh8BJHsetlG4FaY/IjUPbpyuyYf2aLMOkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RKRFPUsQa3YxnAMS15/moNg1V9hZrUxVs0pORhYbLoQxgzdRlDUZ/Hid0+T0lFRI0xdYHhkwz+vKxPxOCCtu+Qz0cKd0bY53Fayc6njka88xSZRdHbqxNo/NsRGvxZ08kbsSmtqGSI6bbhYb3IRub13i50vJewc0wxu295epBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Rt4arT8K; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GWGWKICQYbA8YGXyToNZABRrr/HL05Pn+y+G4CDwib4=;
	b=Rt4arT8KaGGJORIzSrG9G7VkvSKQdLjrARcaKIPiSAL2WjMy/iJ3Gw/e1AGBEV9uawwizOaRH
	4xQ+7ngz5Wq9Jx4On7AwcoQE0EJLsBT4qx9vc3z+9rNlzp2I3kqNp6pH7yKqN5lbKnrok/ongo4
	/D4nSWzNWIyjpmZ/WKoloyQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d16RW5Wm1z1prKB;
	Tue,  4 Nov 2025 19:58:31 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F97D140156;
	Tue,  4 Nov 2025 20:00:07 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 20:00:06 +0800
Received: from [10.67.110.40] (10.67.110.40) by kwepemq200017.china.huawei.com
 (7.202.195.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 20:00:06 +0800
Message-ID: <032f82e9-552a-4ad8-aff7-717e6f38af43@huawei.com>
Date: Tue, 4 Nov 2025 20:00:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: <llong@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
 <wpdddawlyxc27fkkkyfwfulq7zjqkxbqqe2upu4irqkcbzptft@jowwnu3yvgvg>
 <0d67adac-7ca2-4467-9d2e-049b62fcd7a2@huawei.com>
 <doalyrbxmhzm6vvkotoqganga7s375athzlsnbab343wadijb5@winjpuf5m7dd>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <doalyrbxmhzm6vvkotoqganga7s375athzlsnbab343wadijb5@winjpuf5m7dd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200017.china.huawei.com (7.202.195.228)

Therefore, when setting memory_spread_page, I also need to perform a 
drop cache operation.

This way, there is no need to restart the service.


Some previous ideas, such as using procfs or set_mempolicy to change the 
mempolicy of

non-current processes, could also achieve the goal after dropping the 
cache. [1]


Of course, changing the current memory distribution does not necessarily 
require dropping

the cache, but it will inevitably lead to a series of memory migrations.


[1] 
https://lore.kernel.org/all/20231122211200.31620-1-gregory.price@memverge.com/

https://lore.kernel.org/all/ZWS19JFHm_LFSsFd@tiehlicka/

On 11/3/2025 9:39 PM, Michal Koutný wrote:
> On Mon, Oct 20, 2025 at 02:20:30PM +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
>> The MPOL_INTERLEAVE setting requires restarting the DataNode service.
>> In this scenario, the issue can be resolved by restarting the service,
> \o/
>
>> but I would prefer not to restart the DataNode service if possible,
>> as it would cause a period of service interruption.
> AFAICS, the implementation of cpuset's spread page works only for new
> allocations (filemap_alloc_folio_noprof/cpuset_do_page_mem_spread) and
> there's no migraion in cpuset1_update_task_spread_flags(). So this
> simple v1-like spreading would still require restart of the service.
>
> (This challenge of dynamism also a reason why it's not ready for v2,
> IMO.)
>
> HTH,
> Michal

