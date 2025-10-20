Return-Path: <cgroups+bounces-10893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC8BEF73C
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6D71897210
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 06:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86A2D6E53;
	Mon, 20 Oct 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GibsK9mv"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416D2BE7AB;
	Mon, 20 Oct 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941237; cv=none; b=eWr1gR6YoLrNkIEv0HLyq2j6yUfk70Xa6cH3/CaIj9wkmznIdDXbAna7PD/8gLq4zH7ACN3MJA/HTH8vvKSCKEWwS8VJblY+hMD6/eH1JgWdie+shbhgmTJNe76/lBK9aOArr0FRL5kx2WlaE/p+Vhh8ZivkRS2RrmPqGC4RrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941237; c=relaxed/simple;
	bh=FMzwDLFPIaSEcR2/SgZ5u7C2uusNYOh1YFNZTnIg/B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gYnPAurK/vzqV5XH4eyHbhEM6AJlsDddt7kVcFup4WYhd0fuN737O1E0HsrXVgQD9uqK/md5WDDmZodmlAV/IsqZdUXPpthkrqWRGspnqm2cr0cNSFXShzNH9f/dfLHdNay5vhdjBfKVI8V2WABcPjlYMHuL2K0+ZD2RvwDPG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GibsK9mv; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y69aW3OVi711Rd8WiNYabEGSp7/jv8rsx82kizG6cK0=;
	b=GibsK9mvT93giLJYzeg0ifJSTIDvibrDvzw42oPR/BAcCGC41PxrUIlnyI7G/xuYI00DCg0kM
	dxR78LjKGdBzgGsTWUuEUNtkjhnZMyYvXMa6gKV3/NtKcyAkKk96kRYN9+1S3FyobL6UQQeCfEj
	HbYCLHZaqHRzMnF87sBs2Co=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqlf12wFSzLlVc;
	Mon, 20 Oct 2025 14:20:09 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B0AAA1A0188;
	Mon, 20 Oct 2025 14:20:32 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 14:20:32 +0800
Received: from [10.67.110.40] (10.67.110.40) by kwepemq200017.china.huawei.com
 (7.202.195.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 14:20:31 +0800
Message-ID: <0d67adac-7ca2-4467-9d2e-049b62fcd7a2@huawei.com>
Date: Mon, 20 Oct 2025 14:20:30 +0800
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
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <wpdddawlyxc27fkkkyfwfulq7zjqkxbqqe2upu4irqkcbzptft@jowwnu3yvgvg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)

I tried using memory.max, but clearing the page cache caused performance 
degradation. The MPOL_INTERLEAVE setting requires restarting the 
DataNode service. In this scenario, the issue can be resolved by 
restarting the service, but I would prefer not to restart the DataNode 
service if possible, as it would cause a period of service interruption.

On 9/30/2025 8:05 PM, Michal Koutný wrote:
> Hello Xinchen.
>
> On Tue, Sep 30, 2025 at 09:35:50AM +0000, Cai Xinchen <caixinchen1@huawei.com> wrote:
>> I discovered that the DataNode process had requested a large amount
>> of page cache. most of the page cache was concentrated in one NUMA node,
>> ultimately leading to the exhaustion of memory in that NUMA node.
> [...]
>> This issue can be resolved by migrating the DataNode into
>> a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
>> allow it to evenly request memory.
> Would it work in your case instead to apply memory.max or apply
> MPOL_INTERLEAVE to DataNode process?
>
> In anyway, please see commit 012c419f8d248 ("cgroup/cpuset-v1: Add
> deprecation messages to memory_spread_page and memory_spread_slab")
> since your patchset would need to touch that place(s) too.
>
> Thanks,
> Michal

