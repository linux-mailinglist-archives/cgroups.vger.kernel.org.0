Return-Path: <cgroups+bounces-8032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1AAAB8B2
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 08:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DD53A1C12
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653E327A471;
	Tue,  6 May 2025 04:00:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3737296701;
	Tue,  6 May 2025 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746495421; cv=none; b=E50JCwes7xJl/EppIFsf9wH2iGqfL/B0S8OWMJqL8D1SI6w2MNb3njAVkGbwmE0kWr5DG7VeQn0O+isCJEaW72xa5KA7m2Y1q8c4klWjblTCPzxFif58vpOriM8MNheb/0FKlcCSWPhjGauHjWTTGPPqifEXu7ZSeJsGhmFLuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746495421; c=relaxed/simple;
	bh=DDFvjlDdt/4/U7VLsOKo1z0oIiNAqnlHhQNmb/lVbug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv9C0ERs3YAwMzM+DlvoHAeUJDfz2grpzd8kVx0vyMoWYZooRrv9C0/Qtknwukbo4uh0AkPJY9avgO3LnK27t8/MFM1IEcqAIHfNY9sUbG6JUjV3OM6rWJG5WgwxrTg7bMbMOlLcsZzBPVwxM3H2dZPe4bp9Drj9fbxDYQCRKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs1Fw007Yz4f3jt8;
	Tue,  6 May 2025 09:36:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 344C11A12C6;
	Tue,  6 May 2025 09:36:55 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDHhGedZxloAPfmLQ--.7835S2;
	Tue, 06 May 2025 09:36:55 +0800 (CST)
Message-ID: <84f3e74b-42ae-4cee-aace-c1e77372b940@huaweicloud.com>
Date: Tue, 6 May 2025 09:36:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com,
 roman.gushchin@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <6zxqs3ms52uvgsyryubna64xy5a6zxogssomsgiyhzishwmfbd@lylwjd6cdkli>
 <6bdac218-a18a-4cb5-b10e-c369d90b502c@huaweicloud.com>
 <kmmrseckjctb4gxcx2rdminrjnq2b4ipf7562nvfd432ld5v5m@2byj5eedkb2o>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <kmmrseckjctb4gxcx2rdminrjnq2b4ipf7562nvfd432ld5v5m@2byj5eedkb2o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHhGedZxloAPfmLQ--.7835S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF47JrykWFy7urWxuryUKFg_yoW8KFWDpF
	Z5KF1Yyr4kArn5C397AF4xZ348tanrGFW7Xw1rW3sYva9093Z5A34rWF4rurWUKrs8Jr1Y
	vwnFqwsIqa15CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/5/1 2:33, Michal Koutný wrote:
> On Fri, Jan 03, 2025 at 10:22:33AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> I think the commit 76bb5ab8f6e3 ("cpuset: break kernfs active protection
>> in cpuset_write_resmask()") is causing the warning I observed.
> 
> 
> I was considering
> bdb2fd7fc56e1 ("kernfs: Skip kernfs_drain_open_files() more aggressively") 
> in conjunction (the warning didn't exist back then).
> 

Thank you, Michal, I added two fixes:
Fixes: bdb2fd7fc56e ("kernfs: Skip kernfs_drain_open_files() more
aggressively")
Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in
cpuset_write_resmask()")

The patch "kernfs: Relax constraint in draining guard" makes sense to me.

Thanks,
Ridong

> 
>> writing to 'cpuset_write_resmask' cannot avoid concurrent removal of
>> the cgroup directory. Therefore, this could cause the warning.
>>
>>> As I read kernfs_break_active_protection() comment, I don't see cpuset
>>> code violating its conditions:
>>> a) it's broken/unbroken from withing a kernfs file operation handler,
>>> b) it pins the needed struct cpuset independently of kernfs_node (it's
>>>    ok to be removed)
>>>
>> I am not sure if it is safe to call
>> kernfs_unbreak_active_protection(atomic_inc(&kn->active)); after the
>> 'kn' has been removed. 
> 
> Thit'd render the break/unbreak mechanism useless if unbreak cannot be
> safely used. Users of unbreak know that they may get an inactive
> reference. IOW in this part of the race:
> 
>                                                                          kernfs_unbreak_active_protection
>                                                                          // active = 0x80000002
>     ...
>     kernfs_should_drain_open_files
>     WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
>                                                                          kernfs_put_active
> 
> the WARN_ON_ONCE seems misplaced if there are expected users of
> inactivated reference.
> 
> For your concern about atomic_inc(&kn->active)); after the 'kn' has been
> removed -- that's a different reference tracking (kn->count) and that
> should be enshured by generic VFS due to existence of inode that pins
> inode->i_private form kerfs_init_node().
> 
> All in all, the patch makes sense as a code cleanup (the deadlock is
> gone already) but it doesn't tackle any reference underflow (I'm
> bringing this up again because of CVE-2025-21634).
> 
> If anything, the warning in kernfs_should_drain_open_files() should be
> reviewed. 
> 
> WDYT?
> 
> Michal


