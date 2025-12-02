Return-Path: <cgroups+bounces-12247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B311EC9A35C
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 07:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E1C3A47CB
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBF2FFDC9;
	Tue,  2 Dec 2025 06:14:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DB2FF656;
	Tue,  2 Dec 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656065; cv=none; b=rtc3GVpDvg4nEqtO3LMwkNCgnf/TzfkgJgS4Z3CBVzVEg+e+VTzTnWYkp+XBoVrSlgx3oxQjnNN6zNVJj/qYioQJRUWVMerTwYrHR4nsQysxMO8uwqolvxh2hLe+ze7XBIidUjfIrNJUq0Vr5FeHIH1q8/SNdrv9OIYqww9TtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656065; c=relaxed/simple;
	bh=jW4Pdc/rgZ2W/n9VEu4/IvHKHQYailZHQn1UYTOh4F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op+9ICzAwNIvgS4JLnaXhY2c7S3rUFmhy+L0Cn6+nkWkCHDl95P7HLpIsLnR4uTfDyNGULFc81H2GrKLcN6oz7esTjWh5PU43ZMbIvxX1Gsmyf8fMKg+L5Bj1efD/euaYB5ZrRI1QLqesjtWzQeNrW64OMYCwnebnEie+3pchSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dL9TQ37nFzYQtms;
	Tue,  2 Dec 2025 14:14:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A66CA1A018D;
	Tue,  2 Dec 2025 14:14:19 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDnIn+6gy5pYO0+AQ--.12066S2;
	Tue, 02 Dec 2025 14:14:19 +0800 (CST)
Message-ID: <31b2febb-9f80-48d1-81e8-291c48c44ab9@huaweicloud.com>
Date: Tue, 2 Dec 2025 14:14:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20251126091158.1610673-1-chenridong@huaweicloud.com>
 <518ffa19-fcb2-4131-942d-02aa8328a815@redhat.com>
 <1165075e-baa2-4120-8e58-50532b2b459d@huaweicloud.com>
 <aS55RdSgpdXNOfJ-@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aS55RdSgpdXNOfJ-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnIn+6gy5pYO0+AQ--.12066S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE_
	_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/2 13:29, Tejun Heo wrote:
> On Tue, Dec 02, 2025 at 08:57:45AM +0800, Chen Ridong wrote:
>> Just checking, can this patch be applied? Wanted to make sure you saw it.
> 
> Yeah, I missed it. Will apply after merge window.
> 
> Thanks.
> 

Thank you.

-- 
Best regards,
Ridong


