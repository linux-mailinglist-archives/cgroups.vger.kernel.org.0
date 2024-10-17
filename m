Return-Path: <cgroups+bounces-5150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8C9A2201
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E851F28FB0
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8061DCB0D;
	Thu, 17 Oct 2024 12:18:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1E1C695;
	Thu, 17 Oct 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167494; cv=none; b=IwvPUTpAmgY9a3ioxLoYEcVwEpfUc/M5ujMeFPbXGPYzQqeq8/1Sjj1iznZRatg94zhLx+xG0pAbW6jt6Ceoe79H316IoviHdKSjkpGLODNFKr71M4qO+l6UKfkupFFnUs3uDnCcMjE0fOJtanTsXKRchEWEt3g0y3D2Yn47aUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167494; c=relaxed/simple;
	bh=8xOP+fyn8S9TsJvLes6SdW4DK+kDiUgc2CPyz+uilZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN3QgLrnzhRGXCDmihUhFlCkITz1y9SxdIKlbuziLIx2e9hiwOp/Yl0RCUtHmlnCHjyWGzbai14qr5NktjVR4mhJlY2ehfhSM9oD8ZioYA34ScRKoPiuY52DTEQTRiY7QAaeVd3A6DW7EfhZeBnK5bqhOmY27FJSgVFJr+gRZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XTn0X3WzBz4f3lXV;
	Thu, 17 Oct 2024 20:17:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 901B81A08DC;
	Thu, 17 Oct 2024 20:18:00 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgB3q8d3ABFnPJpjEQ--.54302S2;
	Thu, 17 Oct 2024 20:18:00 +0800 (CST)
Message-ID: <12f57831-6b88-49db-bfb6-eabfc5e1d40c@huaweicloud.com>
Date: Thu, 17 Oct 2024 20:17:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/bpf: fix NULL pointer dereference at
 cgroup_bpf_offline
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, longman@redhat.com, john.fastabend@gmail.com,
 roman.gushchin@linux.dev, quanyang.wang@windriver.com, ast@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 wangweiyang2@huawei.com
References: <20241016093633.670555-1-chenridong@huaweicloud.com>
 <bidpqhgxflkaj6wzhkqj5fqoc2zumf3vcyidspz4mqm4erq3bu@r4mzs45sbe7g>
 <Zw_yHEJCBwtYFJoR@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Zw_yHEJCBwtYFJoR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3q8d3ABFnPJpjEQ--.54302S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrGr1DurWrJw4UJw4kXrb_yoW8ZF15pr
	savFnFk3Z5GrZ0yryvva4FvF15CF4Iq34UXrWUJry3AFnrWrWUtry2kFy5CF98AFn7Kr13
	JrWYvrySk3yq93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/17 1:04, Tejun Heo wrote:
> On Wed, Oct 16, 2024 at 03:13:52PM +0200, Michal Koutný wrote:
>> Hello.
>>
>> On Wed, Oct 16, 2024 at 09:36:33AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> As mentioned above, when cgroup_bpf_inherit returns an error in
>>> cgroup_setup_root, cgrp->bpf.refcnt has been exited. If cgrp->bpf.refcnt is
>>> killed again in the cgroup_kill_sb function, the data of cgrp->bpf.refcnt
>>> may have become NULL, leading to NULL pointer dereference.
>>>
>>> To fix this issue, goto err when cgroup_bpf_inherit returns an error.
>>> Additionally, if cgroup_bpf_inherit returns an error after rebinding
>>> subsystems, the root_cgrp->self.refcnt is exited, which leads to
>>> cgroup1_root_to_use return 1 (restart) when subsystems is  mounted next.
>>> This is due to a failure trying to get the refcnt(the root is root_cgrp,
>>> without rebinding back to cgrp_dfl_root). So move the call to
>>> cgroup_bpf_inherit above rebind_subsystems in the cgroup_setup_root.
>>>
>>> Fixes: 04f8ef5643bc ("cgroup: Fix memory leak caused by missing cgroup_bpf_offline")
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>
>> Hm, I always thought that BPF progs can only be attached to the default
>> hierarchy (cgroup_bpf_prog_attach/cgroup_get_from_fd should prevent
>> that).
>>
>> Thus I wonder whether cgroup_bpf_inherit (which is more like
>> cgroup_bpf_init in this case) needs to be called no v1 roots at all (and
>> with such a change, 04f8ef5643bc could be effectively reverted too).
>>
>> Or can bpf data be used on v1 hierarchies somehow?
> 
> We relaxed some of the usages (see cgroup_v1v2_get_from_fd()) but cgroup BPF
> progs can only be attached to v2.
> 
> Thanks.
> 

So, should commit 04f8ef5643bc ("cgroup: Fix memory leak caused by 
missing cgroup_bpf_offline") be reverted, and should cgroup_bpf_inherit 
be only called in v2?
Have I understood this correctly?

Best regards,
Ridong


