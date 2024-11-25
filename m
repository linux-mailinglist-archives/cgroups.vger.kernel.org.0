Return-Path: <cgroups+bounces-5677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE99D79FF
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 03:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949EEB2194E
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B714A8B;
	Mon, 25 Nov 2024 02:15:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339AD268;
	Mon, 25 Nov 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500907; cv=none; b=c+gNIX5iInzs2wcLuehoSmUKK3Gmb0HMNG0mdUK44+WWFZXU0NkgRXArYnoPnVz8Ry81s0uzGi4akeEnSUBnEu2NFIMiGuMGQvcyiloOkeciPGAQtRMbvlfoCqZ63Xxaw4Ak4vILbXT/mw+h09zjRmZoQ6ILy6Yv0kEagbAgkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500907; c=relaxed/simple;
	bh=4em1ntQWyZcilcqbBgAXc/BnYmbnhfHoISqDQL4sGe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzv8OnlmQGPj2VOTMrN+kHKddPdR/SVZF/SMNNUVh9zJpt3nhLyu7NSKkwjpc/nlwT7e/X5+s2auNLVFCBGuB16ssr5lc3ysIxRAk/6f6R09VEEzD/R9BHcSgQR1bc3Bq/DZnjljC3JoPCC3Pc9tMixAOthHj7U62+d6I9ThvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxTml22MMz4f3k5f;
	Mon, 25 Nov 2024 10:14:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E155B1A06D7;
	Mon, 25 Nov 2024 10:15:00 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCHroKj3UNnUBIFCw--.51361S2;
	Mon, 25 Nov 2024 10:15:00 +0800 (CST)
Message-ID: <3b03520e-775d-416a-91b1-1d78f3e91b1d@huaweicloud.com>
Date: Mon, 25 Nov 2024 10:14:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
To: Tejun Heo <tj@kernel.org>, peterz@infradead.org
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, =?UTF-8?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 cgroups@vger.kernel.org
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
 <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
 <ZzajsLHrXXtYk04l@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZzajsLHrXXtYk04l@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHroKj3UNnUBIFCw--.51361S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/15 9:28, Tejun Heo wrote:
> Hello,
> 
> On Fri, Nov 15, 2024 at 09:14:32AM +0800, Chen Ridong wrote:
>> Hi, Tj, There is no ambiguity what cgroup v2 shows. However, in cgroup
>> v1, the frozen tasks are reported as 'R'.  Do you think this is reseanable?
> 
> Oh, right, pardon my confusion. I thought this was about cgroup2 freezer.
> For cgroup1 freezer, yes, D is the closest state for reporting to userspace.
> 
> Thanks.
> 

Hello, Peterz, do you have any opinions?

Best regards,
Ridong


