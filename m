Return-Path: <cgroups+bounces-9521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC290B3D656
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FB3B6939
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B001ADC97;
	Mon,  1 Sep 2025 01:39:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51EC2FB;
	Mon,  1 Sep 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756690742; cv=none; b=Lp91VBCHt43fXs+zTWQcoJqtDDhYv8DVPqlpRCR5mfwUG09cBF5jzVzzyKWUpRmfKoSo3Sz3h6R02XnjqJM4qbCiyU0+u8SW1xzl33MWUvgEh0GbyDLPbqtvAcyNoNxmeIdcG9u4GyWfxKplMP6GP4dDpLgcaVoTrB/FXwNneUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756690742; c=relaxed/simple;
	bh=KqqRGi+FKxfSAlLjJ4JXNrkj2FkYJBf8wMDLSDjDHNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk7oFVMhwpQxCZ4Az2sgcOt+8WbMfiGo+i70ouFtg4ptmjnLYQ8bT6gjqXPtigWoHKLrabxFsshtowGZo1UPk6gQ51y0jpICKzYiFamPjU4EwU9WB3Iq0Ij/OSI6Tkc/P/t9DxIdx8VBid0Pko79jPyEXTdRmsNQyMSstAI60hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFWk44l17zYQv6L;
	Mon,  1 Sep 2025 09:38:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3031C1A08C9;
	Mon,  1 Sep 2025 09:38:51 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDXII0p+bRoEMbrAw--.24215S2;
	Mon, 01 Sep 2025 09:38:51 +0800 (CST)
Message-ID: <afc56d3b-1fc7-48b8-a724-7abc59e06cdd@huaweicloud.com>
Date: Mon, 1 Sep 2025 09:38:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/psi: Set of->priv to NULL upon file release
To: Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, peterz@infradead.org,
 zhouchengming@bytedance.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com,
 libaokun1@huawei.com
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-3-chenridong@huaweicloud.com>
 <aKitWH39wpfTF5st@slm.duckdns.org>
 <2025082322-canopener-snugness-14e3@gregkh>
 <aKyeEIArL3gs0jNF@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aKyeEIArL3gs0jNF@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXII0p+bRoEMbrAw--.24215S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/26 1:32, Tejun Heo wrote:
> Hello, Greg.
> 
> On Sat, Aug 23, 2025 at 08:43:48AM +0200, Greg KH wrote:
>>> Applied to cgroup/for-6.17-fixes.
>>
>> Both or just this second patch?  Should I take the first through the
>> driver-core tree, or do you want to take it through the cgroup tree?  No
>> objection from me for you to take both :)
> 
> Sorry about the lack of clarity. Just the second one. The first one looks
> fine to me but it would probably be more appropriate if you take it.
> 
> Thanks!
> 

Hello all,

Any other opinions? Can this patch be applied?

-- 
Best regards,
Ridong


