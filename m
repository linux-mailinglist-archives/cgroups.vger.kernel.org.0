Return-Path: <cgroups+bounces-5749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE79E30F2
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 02:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B3282334
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9316426;
	Wed,  4 Dec 2024 01:52:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CA4C76;
	Wed,  4 Dec 2024 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277146; cv=none; b=F9kIgigG2K42WgprNorlG92reQ5bGWftKZSN5wB9m66hlpz6M9VhyGybjC8S7Z2ZEtjHJz58Gg4YTX1CLlROB7Tfc9dDqOlPEPQgNHS5uMGgSGmG5jM6YKG6eTXqfCu3yU0DfhQStOOKXXreHWsO/iSO7sV7NMveSrHnCOkJkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277146; c=relaxed/simple;
	bh=J/RuSwlyJPB7AxuW8FEImoms8QVmHlY4BFcefXUGF98=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMVwFSVVL33pV6Qo/U2HXy3bbL00gJk2tMWVn3lQ/7Uuqhn/eeJtK+th0x7iHZVESby56UqXlcpgNoZPYmUSEitoGW+FBq/jlhVryyLcpLV4A5c3UF+KN257I50LWk3mmBoECgKLD0GKx/COJXvCF89qaJIRggf7YJhVBs6uagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y30rM1Y1cz4f3jt6;
	Wed,  4 Dec 2024 09:52:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2FF0E1A0359;
	Wed,  4 Dec 2024 09:52:17 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgD30YXPtU9ntb9jDg--.36505S2;
	Wed, 04 Dec 2024 09:52:16 +0800 (CST)
Message-ID: <c56b2347-7475-4190-85a5-a38954ae9c08@huaweicloud.com>
Date: Wed, 4 Dec 2024 09:52:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
From: Chen Ridong <chenridong@huaweicloud.com>
To: Tejun Heo <tj@kernel.org>, peterz@infradead.org
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 =?UTF-8?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 cgroups@vger.kernel.org
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
 <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
 <ZzajsLHrXXtYk04l@slm.duckdns.org>
 <3b03520e-775d-416a-91b1-1d78f3e91b1d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <3b03520e-775d-416a-91b1-1d78f3e91b1d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD30YXPtU9ntb9jDg--.36505S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
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



On 2024/11/25 10:14, Chen Ridong wrote:
> 
> 
> On 2024/11/15 9:28, Tejun Heo wrote:
>> Hello,
>>
>> On Fri, Nov 15, 2024 at 09:14:32AM +0800, Chen Ridong wrote:
>>> Hi, Tj, There is no ambiguity what cgroup v2 shows. However, in cgroup
>>> v1, the frozen tasks are reported as 'R'.  Do you think this is reseanable?
>>
>> Oh, right, pardon my confusion. I thought this was about cgroup2 freezer.
>> For cgroup1 freezer, yes, D is the closest state for reporting to userspace.
>>
>> Thanks.
>>
> 
> Hello, Peterz, do you have any opinions?
> 
> Best regards,
> Ridong
> 

Friendly ping.

Does anyone have any opinions?


