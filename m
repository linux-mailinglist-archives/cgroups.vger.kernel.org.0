Return-Path: <cgroups+bounces-4218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE394FC6A
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 05:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529E51F22857
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A41BC44;
	Tue, 13 Aug 2024 03:48:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC94179AE;
	Tue, 13 Aug 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520933; cv=none; b=kHy5Yj9O8mK+dSBGM7+o9xUqOb5457D0Bq+V1zxOoVeNgs5MPsCrziOR7SDTGSD1htcyJ9AxDOuGvQqiRX/DFCCRc47sgqlO9CnaFTb/QU/JyGMoFAwTW19FeratSXwCaQyDcywwqHD0rvh+rmlV0B9ZSh0ECz0W6iuFqDtC2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520933; c=relaxed/simple;
	bh=TkKGC/WQJU9DxCsjXfH82Ud0ZPfNIUkFc7pRXUo0/O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l4LWEv/rnWpH6AJRUFKIHlJ5T9fx62PUo6bhDxCD2seovUIGlRY9NomOiOQdIqw9ArW7hByoJW9CQoTwJWJjsI6Oc9w0XdKo8RSWfsei0+ssBpBUlkG1rpEa10lPwTxzNnd76ZteYSbvLLc++4B/DNpM1Fixu+Nq5MpwpzYAM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wjcgx0WKTzQpc5;
	Tue, 13 Aug 2024 11:44:13 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CE951400DC;
	Tue, 13 Aug 2024 11:48:46 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 13 Aug
 2024 11:48:45 +0800
Message-ID: <17f6eb65-e6c0-47be-b88a-e33819bbd66f@huawei.com>
Date: Tue, 13 Aug 2024 11:48:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
 <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/13 0:57, Michal Koutný wrote:
> Hello.
> 
> On Mon, Aug 12, 2024 at 07:37:46AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> cd /sys/fs/cgroup
>> echo '+pids' > cgroup.subtree_control
>> mkdir dlgt_grp_ns
>> echo '+pids' > dlgt_grp_ns/cgroup.subtree_control
>> mkdir dlgt_grp_ns/dlgt_grp_ns1
>> echo $$ > dlgt_grp_ns/dlgt_grp_ns1/cgroup.procs
>> echo 200 > dlgt_grp_ns/dlgt_grp_ns1/pids.max
>> unshare -Cm /bin/bash
>> echo max > /dlgt_grp_ns1/pids.max // Permission denied
>> echo -pids > dlgt_grp_ns/cgroup.subtree_control // pids was unlimited now
> 
> You could also have increased the ancestral limit (if there was any)
> echo max > dlgt_grp_ns/pids.max // similarly allowed
> 
> If you're a root (or otherwise have sufficient permissions) and you can
> _see_ an ancestral cgroup, you can write to its attributes according to
> permissions. Thus the delegation works via cgroup ns (in)visibility but
> cgroup ns root is visible on both sides of the boundary hence the extra
> check.
> 
> I can imagine that a container runtime process could enter the target
> cgroup ns while keeping visibility to the original cgroup ns and do some
> tuning on it before it drops any pointers to the original cgroup ns and
> exec's delegatee's workload. (But it's only my imagination to illustrate
> that this may be a breaking change.)
> 
Yes, this is a change. However, the process within the container can 
turn on subsystems , they can also turn off subsystems , which may not 
only affect the host machine but may also affect other containers. I 
believe this poses a danger.

> OTOH, I can see why this would be consistent with the migration rules
> that exist between sides of cgroup ns, so this could work if it was
> hidden behind (another) mount option like 'nsdelegate2' :-p
> 

Hello, Michal, I am sorry I can not get your point.
Did you mean this issue should be fixed with another mount option 
'nsdelegate2'? Or is the current patch acceptable?

> 
>> @@ -4134,8 +4134,10 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
>>   	 * cgroup.procs, cgroup.threads and cgroup.subtree_control.
>>   	 */
>>   	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
>> -	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
>> -	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
>> +		ctx->ns != &init_cgroup_ns &&
>> +		(!cgroup_is_descendant(cgrp, ctx->ns->root_cset->dfl_cgrp) ||
>> +			(!(cft->flags & CFTYPE_NS_DELEGATABLE) &&
>> +			ctx->ns->root_cset->dfl_cgrp == cgrp)))
>>   		return -EPERM;
> 
> Could you please also update the comment above, to describe the boundary
> vs subtree delegation?
> Thanks,
> Michal

Sure.

Thanks
Ridong

