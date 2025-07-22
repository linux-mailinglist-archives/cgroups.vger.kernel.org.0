Return-Path: <cgroups+bounces-8829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF4B0D532
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8178D1883A49
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72528A40F;
	Tue, 22 Jul 2025 09:02:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C97EAC6;
	Tue, 22 Jul 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174920; cv=none; b=NkZlc9tclF2YBSX8ZrrN42eGUXkmVVjUg3O2DjuUWh/5sO4U6mro7/cMFMZXGNrdv5KYeVYW/hXPSTAvG6qy/Df+Q8zfuKTU5Ouf2QXwi5IhF78eQbEQzZuO/59YibnhKSFYq5x+nQdx+P1flMQHXX/VjRba5UTtrjqmcBP0Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174920; c=relaxed/simple;
	bh=ILjREH/bSJPaVnQrYwEgocdYovo14iS3cmunmeZlu1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrFM1NqBRULM+LrZNLvMOanEs4heaYOWHX6jVM4yPfvWgtCKOSmNZH5tch3QS85mMDFZT7q8UNdKW39CDSaKWxGfjyOtr1Ky03mayHPFdjAxY7+Suz7scpyYqw6KTixWNqURvmBETsaBNO3mRiEVUzsAi3a4giEUa379miyOu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmWVB41nxzKHMwD;
	Tue, 22 Jul 2025 17:01:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 456CE1A1890;
	Tue, 22 Jul 2025 17:01:53 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC3drh_U39oJLBVBA--.60026S2;
	Tue, 22 Jul 2025 17:01:53 +0800 (CST)
Message-ID: <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
Date: Tue, 22 Jul 2025 17:01:50 +0800
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
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aHvHb0i6c8A_aCIo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3drh_U39oJLBVBA--.60026S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW3Gr15ArW7KF1DAFy5Jwb_yoW8Gr4kpF
	1DW343K3WDJa48ZFs2k3ZFgFyFv392ka429rnrAw1xJF1DZry5Cr1S9ayjgFy3C3s3ur1I
	vFW29FyDu392kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



On 2025/7/20 0:27, Tejun Heo wrote:
> On Sat, Jul 19, 2025 at 10:01:07AM +0800, Chen Ridong wrote:
> ...
>> What I'm considering is moving the implementation of cpu.stat from cgroup_base_files to
>> cpu_cgrp_subsys—without changing the user-facing interface (filenames and content remain the same).
>> However, the interface would only appear if the CPU subsystem is enabled.
>>
>> Currently, cpu.stat and cpu.stat.local are visible in every cgroup, even when the CPU subsystem is
>> disabled. The only populated fields in such cases are:
>>
>> - usage_usec
>> - user_usec
>> - system_usec
>> - nice_usec
>>
>> I’m unsure whether this change would be acceptable?
> 
> I don't think so and don't really see what benefits moving the stats would
> bring. Why would we move these?
> 
> Thanks.
> 

Thank you for your attention. My intention is to better modularize the cgroup code by moving CPU
subsystem-specific statistics out of the core cgroup implementation (cgroup.c and rstat.c).

Specifically, this change would allow us to:

1.Remove these CPU-specific callbacks from the core:
  css_extra_stat_show()
  css_local_stat_show()
2. Clean up the 'is_self' logic in rstat.c.
3. Make the stat handling consistent across subsystems (currently cpu.stat is the only
subsystem-specific stat implemented in the core).

Best regards,
Ridong.


