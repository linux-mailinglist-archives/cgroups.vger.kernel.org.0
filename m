Return-Path: <cgroups+bounces-9342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C28B325C1
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 02:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30505B61CF0
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB017C77;
	Sat, 23 Aug 2025 00:23:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1732F37;
	Sat, 23 Aug 2025 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908596; cv=none; b=LL/ER5XkqLue5Rq8AYnKK1YL2ZX9lfwVEIsdtqFWDCubltqpluS+wkTXrzLHAIz4AKvTxSmQzRcVplOSGTxByx8y0/1qtM3N7V5EbQxALePJM613OLQNW+5279+HaN4+oCEikm/dVPYwDsNLfhNsvA6X/pB5nfB9sJL4nSdKTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908596; c=relaxed/simple;
	bh=JFPgLs60x7RQ6nCtYxBn9aCNjrsem1AKaxTNJxqpvAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSyLIE5KR51h1M1pH8w4l6O5kj52KH4junXKAPuOFR8QfzrOkzTDGiWSRLsIVLB0r47LYy8n5HffRXksevnCe78fcm20x3nlTR93FjBsi4Bo+e/dN2yjlEIlQebLrRJAbMnL+GwPws3e9MAOIK1/f7xevp0+k6CtAAfs11xvrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c7ySp4fBxzYQvCQ;
	Sat, 23 Aug 2025 08:23:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 346BC1A084E;
	Sat, 23 Aug 2025 08:23:05 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBXZLbnCalo_XMmEg--.20431S2;
	Sat, 23 Aug 2025 08:23:05 +0800 (CST)
Message-ID: <eec759ad-7567-449e-8a31-66464051d18f@huaweicloud.com>
Date: Sat, 23 Aug 2025 08:23:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cgroup: split cgroup_destroy_wq into 3 workqueues
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, hdanton@sina.com, gaoyingjie@uniontech.com
References: <aKNeF68tmjLKB6dK@slm.duckdns.org>
 <20250819010724.1338654-1-chenridong@huaweicloud.com>
 <aKisu29TdvbeEPdY@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aKisu29TdvbeEPdY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXZLbnCalo_XMmEg--.20431S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4DXFy5Zw43CrWkAF1rXrb_yoW5Gw48pF
	Z5C3Wjy3WrGr17ua1vva40q3W0qFs7Xw4UXr1Igw1UJF47Wr92qFsFyF1jqF1kArnrCry7
	Z3WYvr1Sk34qyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/23 1:45, Tejun Heo wrote:
> On Tue, Aug 19, 2025 at 01:07:24AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A hung task can occur during [1] LTP cgroup testing when repeatedly
>> mounting/unmounting perf_event and net_prio controllers with
>> systemd.unified_cgroup_hierarchy=1. The hang manifests in
>> cgroup_lock_and_drain_offline() during root destruction.
>>
>> Related case:
>> cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
>> cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio
>>
>> Call Trace:
>> 	cgroup_lock_and_drain_offline+0x14c/0x1e8
>> 	cgroup_destroy_root+0x3c/0x2c0
>> 	css_free_rwork_fn+0x248/0x338
>> 	process_one_work+0x16c/0x3b8
>> 	worker_thread+0x22c/0x3b0
>> 	kthread+0xec/0x100
>> 	ret_from_fork+0x10/0x20
>>
>> Root Cause:
>>
>> CPU0                            CPU1
>> mount perf_event                umount net_prio
>> cgroup1_get_tree                cgroup_kill_sb
>> rebind_subsystems               // root destruction enqueues
>> 				// cgroup_destroy_wq
>> // kill all perf_event css
>>                                 // one perf_event css A is dying
>>                                 // css A offline enqueues cgroup_destroy_wq
>>                                 // root destruction will be executed first
>>                                 css_free_rwork_fn
>>                                 cgroup_destroy_root
>>                                 cgroup_lock_and_drain_offline
>>                                 // some perf descendants are dying
>>                                 // cgroup_destroy_wq max_active = 1
>>                                 // waiting for css A to die
>>
>> Problem scenario:
>> 1. CPU0 mounts perf_event (rebind_subsystems)
>> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
>> 3. A dying perf_event CSS gets queued for offline after root destruction
>> 4. Root destruction waits for offline completion, but offline work is
>>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
>>
>> Solution:
>> Split cgroup_destroy_wq into three dedicated workqueues:
>> cgroup_offline_wq – Handles CSS offline operations
>> cgroup_release_wq – Manages resource release
>> cgroup_free_wq – Performs final memory deallocation
>>
>> This separation eliminates blocking in the CSS free path while waiting for
>> offline operations to complete.
>>
>> [1] https://github.com/linux-test-project/ltp/blob/master/runtest/controllers
>> Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
>> Reported-by: Gao Yingjie <gaoyingjie@uniontech.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> Suggested-by: Teju Heo <tj@kernel.org>
> 
> Applied to cgroup/for-6.17-fixes. Sorry about the delay. I missed the
> thread.
> 
> Thanks.
> 

Thanks

-- 
Best regards,
Ridong


