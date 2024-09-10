Return-Path: <cgroups+bounces-4784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EC972785
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 05:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483B0283719
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C114EC7E;
	Tue, 10 Sep 2024 03:09:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4B4436A;
	Tue, 10 Sep 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937750; cv=none; b=Vs2g2ZqECRtCmfQe4OiUZlh4dt3Nz1dZHdcITf/QyG77Zza5SNQl9Pw/McdY7Fyr6fQFd6CCYZc8ErHzMSSQM0VPn63r0+e3Ut5b62YdQ+8U8ImZp4jUS5gB/vNndpLRHrconS2YVA/+F9CPKewhuruImfuiUhGnA0BwOW3ZHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937750; c=relaxed/simple;
	bh=UTk8Zu7hwrWHb3hzTP51t1iDYNENzeDIdjFlCl2NVEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5Nb1hetqlH3C55xh9QOPJQRJMemc1DhtwY0cqa7TPSQuPIbJA6phgaJtOhgpkvkS0XOoVQ9rm+nFCzeoXgGogkzEkdLOCES2DjLCdG5bzWXu/QbthIXDqA3vyBzpm/DRd9AbwpfLad2y1+s+eJ5DVXfmp5ocOYurj3dVZInUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2pZG5yJSz4f3jkV;
	Tue, 10 Sep 2024 11:08:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 662E51A092F;
	Tue, 10 Sep 2024 11:09:05 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXzMhQuN9mJtiVAw--.14264S2;
	Tue, 10 Sep 2024 11:09:05 +0800 (CST)
Message-ID: <6768da54-b08a-4baa-88e6-987b4e42714f@huaweicloud.com>
Date: Tue, 10 Sep 2024 11:09:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 3/3] cgroup/freezer: Add freeze selftest
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-4-chenridong@huawei.com>
 <woqtbusaxdxgolhjylrvsdnmlspwg4tlzgynhse3mgqva2cepv@yzminbmkfyvm>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <woqtbusaxdxgolhjylrvsdnmlspwg4tlzgynhse3mgqva2cepv@yzminbmkfyvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXzMhQuN9mJtiVAw--.14264S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
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



On 2024/9/10 3:03, Michal Koutný wrote:
> On Thu, Sep 05, 2024 at 01:41:30PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> Add selftest to test cgroup.freeze and check cgroup.events state.
> 
> There is already tools/testing/selftests/cgroup/test_freezer.c
> Would you consider adding this as a new test for hierarchies there?
> So that all freezer tests can be run at once and maintained in same style?
> 
> (There are already some creation/removal/event helpers so it shouldn't
> be more difficult than the bash code.)
> 
> Thanks,
> Michal
> 
Okay, I will try.

Thanks,
Ridong


