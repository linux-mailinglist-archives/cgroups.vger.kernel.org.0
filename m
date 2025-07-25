Return-Path: <cgroups+bounces-8907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC3B11617
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 03:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5893B4A7E
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF81F0E3E;
	Fri, 25 Jul 2025 01:54:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D8DDA9;
	Fri, 25 Jul 2025 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408480; cv=none; b=uXAKC2A6EUPSwiVotkM7W58b/wRdB6APRBiVHwDHw+PSdyl8frn3/xa9SOGXzkq1EA7FOmRQC6ySTpkOeXVtWwz+bceOkDtCue83Ox2VDbpZqQUbf1AEc+PR7n2d0Gp+RpDzeCRNTexRbRT98BUuO1J0LFrLFNUD+6AZl9gfxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408480; c=relaxed/simple;
	bh=7QA2XhirCdErGq0E2Mu2eOtTEn5CbyuoLwtcxlC4eQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW9klAWJZqBDI3ZU3E+XUAoShOX+JNqmTqwBlLyfbVwjoG40EuAq8N71FqkjAIyu4Y1GQ6uoFa2EZv2jNleplTU2H14/yqvkVv4KWWkVLWHEaUyJbjqL4UUEmsFPipApu06FcDi8uZG9fdRPEhK3SAbOzAaoKtd9ao/wd6ey8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bp9sm6GMNzYQvJG;
	Fri, 25 Jul 2025 09:54:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 922491A0B69;
	Fri, 25 Jul 2025 09:54:35 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDH07Xa44JoabeCBQ--.41840S2;
	Fri, 25 Jul 2025 09:54:35 +0800 (CST)
Message-ID: <7746e963-1c2d-402b-9a28-1554a34e096a@huaweicloud.com>
Date: Fri, 25 Jul 2025 09:54:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
 <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
 <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
 <0064b782-2bed-4375-aba8-3745aa306a6d@huaweicloud.com>
 <aILZDyD4mPkiMrfd@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aILZDyD4mPkiMrfd@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDH07Xa44JoabeCBQ--.41840S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18GFy3KF15uF45JrWxtFb_yoWxtrc_ur
	9F9F17WF18WF48Ar4avFyDCF95Gay0vF90q3yjqw47X3WxAFn2qrnrWrZIvw45KF92krnr
	GF1vvanIyw17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIb
	yZUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/25 9:08, Tejun Heo wrote:
> On Wed, Jul 23, 2025 at 09:28:02AM +0800, Chen Ridong wrote:
>>> But beware that the possibility of having cpu.stat without enabling the
>>> cpu controller on v2 is a user visible behavior and I'm quite sure some
>>> userspace relies on it, so you'd need to preserve that.
>>
>> This is what I worry about. Thank you for your confirmation.
> 
> Yeah, this was an intentional decision - sacrificing a bit of code org
> cleanliness for everyday usefulness. Enabling CPU controller can have
> substantial overhead and having cpu stats available by default doesn't cost
> much while improving usefulness.
> 
> Thanks.
> 

Thank you Tj, This is clear now.

Best regards,
Ridong


