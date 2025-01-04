Return-Path: <cgroups+bounces-6045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D238A01165
	for <lists+cgroups@lfdr.de>; Sat,  4 Jan 2025 01:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D886D164184
	for <lists+cgroups@lfdr.de>; Sat,  4 Jan 2025 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1C134BD;
	Sat,  4 Jan 2025 00:52:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD6211C;
	Sat,  4 Jan 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951963; cv=none; b=k9OXaF9VA0KzxMqSY8bvrk6bynBtKlLMaJ4nGzzG3HIkezNCt/On0Xnas6VdCNvC/czBddfhIS5mtaAxCHFHt8iiv8mFrUNR+KIE4qTaQaMwPISrgK3KCTC4KVtvIAL2oLFo0NxunRlyROjDzvruN8TrpGvqJl5hZTks5W0669M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951963; c=relaxed/simple;
	bh=G+2nzB6z7pR2xs6/A4xWFQ+pgRYiWhQC+Hh1tQDdl4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QE/xs1V+gAEWnKRBKHWRHbK7Htufku61j19Dg0CCF1rtJ15YRvp4c8qi5JTlQWnukSYlqk/KWpqKVMpCyjLo4Y7PKcSDjA32FBOJXdQZ13z3toHC0+XTPmJV/g3EFy3NXyGOaiIEjY2uOuD+jRcAc4w0OI3RkqNOdAQSK/lnkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YQ23B0tWyz4f3jqs;
	Sat,  4 Jan 2025 08:52:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 04C471A1455;
	Sat,  4 Jan 2025 08:52:37 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDXN+RThnhnkcy2GQ--.55130S2;
	Sat, 04 Jan 2025 08:52:36 +0800 (CST)
Message-ID: <362f274a-70ae-4588-afb3-e75ade66ea42@huaweicloud.com>
Date: Sat, 4 Jan 2025 08:52:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
 handai.szj@taobao.com, rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <ilnyxm3qdk5ix75tfketinbhm6ubrkklrafbvmcwrsnjlgnh35@sjltlqp434fv>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ilnyxm3qdk5ix75tfketinbhm6ubrkklrafbvmcwrsnjlgnh35@sjltlqp434fv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXN+RThnhnkcy2GQ--.55130S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fGF4rWFyUur1ruFyfJFb_yoW8Gr1rpF
	ZYg3W7t3Z7J3ZYgrnrZ392gF45uw4rGr43trWDur10v3sxWr1Fvr12kr4Yv398AF1Sv34j
	9rs09w1xKr1YkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



On 2025/1/4 0:18, Michal Koutný wrote:
> Hello.
> 
> On Tue, Dec 24, 2024 at 02:52:38AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> A soft lockup issue was found in the product with about 56,000 tasks were
>> in the OOM cgroup, it was traversing them when the soft lockup was
>> triggered.
> 
> Why is this softlockup a problem? 
> It's lot of tasks afterall and possibly a slow console (given looking
> for a victim among the comparable number didn't trigger it).
> 

It's not a slow console, but rather 'console pressure'. When a lot of
tasks apply to the console, it can make 'pr_info' slow. In my case,
these tasks will apply to the console. I reproduced this issue using a
test ko that creates many tasks, all of which just call 'pr_info'.

Best regards,
Ridong

>> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
>> function per 1000 iterations. For global OOM, call
>> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
> 
> This only hides the issue. It could be similarly fixed by simply
> decreasing loglevel= ;-)
> 
> cond_resched() in the memcg case may be OK but the arbitrary touch for
> global situation may hide possibly useful troubleshooting information.
> (Yeah, cond_resched() won't fit inside RCU section as in other global
> task iterations.)
> 
> 0.02€,
> Michal


