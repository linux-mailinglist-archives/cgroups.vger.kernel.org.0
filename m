Return-Path: <cgroups+bounces-4291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA21952729
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1260C1F22B47
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14315C3;
	Thu, 15 Aug 2024 00:50:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0163C;
	Thu, 15 Aug 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683031; cv=none; b=X1V6g4LwzEDyVCRPj/VH5NdsKtd4Gjtx5g8DMX4//rh1j9MASGNNSeYPhNeTwb7MINHyoN6Yb6mqR7aZsL7+LV4nQqz21/S0deOfOACEJrcCbu0F8OnqmDHUXqTtvxYFkh8DCXhdo3dJmr7sL6J8oP/7Oms/mJi8otxVXAr/AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683031; c=relaxed/simple;
	bh=Ij4+QPPx2+AHdCXlWTY6O7Em3IWid+VZPTixUOq+CDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XfcuDjn+ALxX9LdHQrL0Z53U9+5S1yXp+HUzMD6JeKnHP0ZF4KOVNARFChfQtnC3bPOqYYM0dv1zpTwbJIRxVP/N3OYSMLZmfkx7JivquYciW5fhhPnPpacaIojJMYRTJ4b19KrX8E7rOv52qF29nioEMqVXsyd3TA98e4UsAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wkmcr5GXrz1S7vK;
	Thu, 15 Aug 2024 08:45:32 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id CAEEA1400DC;
	Thu, 15 Aug 2024 08:50:25 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 15 Aug
 2024 08:50:25 +0800
Message-ID: <d7e3fc38-24ff-4cfc-972c-82834706981f@huawei.com>
Date: Thu, 15 Aug 2024 08:50:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
To: Tejun Heo <tj@kernel.org>
CC: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <longman@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
 <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
 <ZrutqDox2rrr7dlA@slm.duckdns.org>
 <e3bc3535-39af-4993-af29-bd4bd688d984@huawei.com>
 <Zrzg1xUSyw_GpMHH@slm.duckdns.org>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <Zrzg1xUSyw_GpMHH@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/15 0:52, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 14, 2024 at 04:09:59PM +0800, chenridong wrote:
> ...
>> Hi，TJ， We plan to use delegation in cgroup-v2, so I am conducting some
>> tests.
>> As doc mentions 'Because the resource control interface files in a given
>> directory control the distribution of the parent's resources, the delegatee
>> shouldn't be allowed to write to them.' However I found a root can write
>> parent's file(cgroup.subtree_control) to change the resource limits(a
>> fraudulent method). I believe this could pose a risk in some scenarios where
>> a root enters a new cgroup ns without unmounting original cgroup system, and
>> it can break limitations. For instance, running a docker with --privileged,
>> could this be a risk?
>>
>> So I sent this patch to discuss whether this case should be addressed?
> 
> That sounsd like a misconfiguration. cgroup NS doesn't make much sense if
> you don't limit the actual visibility. The interface is half broken in that
> situation anyway and if you're leaking filesystem visibility into a
> supposedly isolated container, relaxed resource limits aren't biggest of
> your problems.
> 
> While the proposed change isn't necessarily a bad idea, it's a behavior
> change and I don't either modifying existing behavior or introducing a new
> mount flag is justified here. Maybe just update the documentation indicating
> that the ancestral cgroups shouldn't be visible in a delegated ns?
> 
> Thanks.
> 

Thank you, TJ, I will send a patch to update comment and the documentation.

Thanks,
Ridong

