Return-Path: <cgroups+bounces-11904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B04C5544E
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91A60346E83
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F61299947;
	Thu, 13 Nov 2025 01:38:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CD7080D;
	Thu, 13 Nov 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997928; cv=none; b=dJcrvhQ7i03uO5/PHSa1/IjkN/wpj5jiVXhxnOJSA5nESxhfyfvt8ldFZU4jYRzyG+SzCRo5QmQrHSsLdrTa1di883UwULtHixJkMb8Hh+ENPEvdRRkrdHuxmuy/9Ap8cFyxqFuYY/IEAySaQ7YpTO/UNkjfLDrykBTpnnnpFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997928; c=relaxed/simple;
	bh=LIh8RDAWy3cT1zY51OFhE+AMZKjCYqDdMrHqtaKGAQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L85j5GmiSdNWel40m7Id2zG7cqUlNuE1Oo1HAFsZs6LrHZotPRZxCCu2lWfiR8mXSlJwOn8FXgtOOqPTKMy3OIb0LLozuqXItzn0+SZkavYqHMsosCq6ss94lPRUzfYzxHaG40tMiluld1akKBP1tIn9cWHIdiEA08zi4D6jxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6NFr4ctbzKHMfY;
	Thu, 13 Nov 2025 09:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 09C9B1A0359;
	Thu, 13 Nov 2025 09:38:43 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBHcF2iNhVpvpk0Ag--.35973S2;
	Thu, 13 Nov 2025 09:38:42 +0800 (CST)
Message-ID: <040fa315-4273-47cb-aad7-2b2debb1d7bc@huaweicloud.com>
Date: Thu, 13 Nov 2025 09:38:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/22] cpuset: introduce partition_enable()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-5-chenridong@huaweicloud.com>
 <95f36634-d4d7-4d47-b949-e34b6bb0cce2@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <95f36634-d4d7-4d47-b949-e34b6bb0cce2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHcF2iNhVpvpk0Ag--.35973S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy3JryruF4xXryxZryxZrb_yoWfGrg_Xw
	17A3WF9r1qqrySqa15AanxKryku3W5Cr1DJF15trW5Zwnav397Zan2gr1I934rXw1YqF13
	C3Z5Aan0vFW2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFBT5DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 4:40, Waiman Long wrote:
> 
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Add partition_enable() to consolidate updates to key cpuset structures
>> during partition enablement, including:
>> - remote_sibling
>> - effective_xcpus
>> - partition_root_state
>> - prs_err
>>
>> Key operations performed:
>> - Invokes partition_xcpus_add() to assign exclusive CPUs
>> - Maintains remote partition sibling links
>> - Syncs the effective_xcpus mask
>> - Updates partition_root_state and prs_err
>> - Triggers scheduler domain rebuilds
>> - Sends partition change notifications
> 
> Could you add a leading space before '-' so that the itemized lists won't look like part of a diff
> file?
> 
> Cheers,
> Longman
> 
> 

Sorry for the confusion.

I will update with next version.

-- 
Best regards,
Ridong


