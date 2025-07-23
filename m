Return-Path: <cgroups+bounces-8879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE5B0E809
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 03:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12E04E6454
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85A15539A;
	Wed, 23 Jul 2025 01:28:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B172EAD7;
	Wed, 23 Jul 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234091; cv=none; b=VVFAhRiXYI2UuWE0ZT7KyvGcgQUhpBp8gEbnGna9iM9anMDuTax7hQg2HD9e6GJm76Xep0Y9JOyFfHnW8AfSPlXofDP6+A2RkWYjCNgJKuk6lnIi0xp4Oy20g6oODvbRWHX8kIkc1IHlG46J0HYKfNEhZNLqUVP35Q3KKgcrZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234091; c=relaxed/simple;
	bh=ZY89KN8ZlaV2FIJ/jBwusYJKFJj0xiuvVJlC8BeM5Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIrE/XuokH2ZBVMz3MH3Arp8OljUFYpBSeRa690VBhU6l0K4lZmnFovGXJgUqXM/kNQZay8wcwzngr0LjXbo+8S4pM9T8RscKtMGlHfC7Kf3b785vMFCnbku9wyh/xyJ4B+VDAl2ulSUkIzRjKuTB1twIiUBAtjioQqGSY1ehU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmxN62DbyzKHNVq;
	Wed, 23 Jul 2025 09:28:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0ABA21A0D2C;
	Wed, 23 Jul 2025 09:28:05 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgA3r9mjOoBoh_WaBA--.63440S2;
	Wed, 23 Jul 2025 09:28:04 +0800 (CST)
Message-ID: <0064b782-2bed-4375-aba8-3745aa306a6d@huaweicloud.com>
Date: Wed, 23 Jul 2025 09:28:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Tiffany Yang <ynaffit@google.com>,
 linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
 <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
 <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3r9mjOoBoh_WaBA--.63440S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWUJF4ktFW7WF48GrW5GFg_yoWfAFX_Gr
	n3ZF1xAr1xZF43CF4YkFWDZFy5JayqvFn8t3W7tFW7Ar18XFnrAF97ur95Ar18Ja95tF98
	CrnIva9FvwnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/22 19:54, Michal Koutný wrote:
> On Tue, Jul 22, 2025 at 05:01:50PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> Specifically, this change would allow us to:
>>
>> 1.Remove these CPU-specific callbacks from the core:
>>   css_extra_stat_show()
>>   css_local_stat_show()
>> 2. Clean up the 'is_self' logic in rstat.c.
> 
> If you see an option to organize the code better, why not. (At the same
> time, I currently also don't see the "why.)
> 
> 
>> 3. Make the stat handling consistent across subsystems (currently cpu.stat is the only
>> subsystem-specific stat implemented in the core).
> 
> But beware that the possibility of having cpu.stat without enabling the
> cpu controller on v2 is a user visible behavior and I'm quite sure some
> userspace relies on it, so you'd need to preserve that.
> 

This is what I worry about. Thank you for your confirmation.

Best regards,
Ridong


