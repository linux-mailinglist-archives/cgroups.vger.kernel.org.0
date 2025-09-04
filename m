Return-Path: <cgroups+bounces-9689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58CFB42EED
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BB13B03ED
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F61CD1E4;
	Thu,  4 Sep 2025 01:40:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6C1940A1;
	Thu,  4 Sep 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950020; cv=none; b=eOC0v1DS6doECFIYmRyFFTDfOUxNXrTVUHEE7QpVjR755jxu8pwLucfrnghr59M8XV195Q/wIw/kdWqYR+q2vrpSIhPx84RLaGBrqi5Q9xOXX+dhLXAdChJ2W4bIjpdIX/KhnFHjl6MoSOOSVYby5RXvQl02666ZoxR3cOpTeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950020; c=relaxed/simple;
	bh=MbPtQfbMRe9s59FcPN8+OJbEnT+coKqPntOEWN4MtVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saWVJy6B+Yj0yzaThaYs/F5QnT1T56WcKGfaPbg/8cKAFYfDsbLTvDEFfYqo3cA3RCL5AF7ZiXRf+KSp4on3ltyTorp4vFppEZ1eHhaskfc8/jYFL8dyllsKPXbq1qZAdB9fo/hSjvfYddqBDpDO1itm4uP+GKe7wccDuUuKUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cHMcG5mPZzYQvMd;
	Thu,  4 Sep 2025 09:40:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4CBE71A13A6;
	Thu,  4 Sep 2025 09:40:13 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgA30mn87bhoQU8sBQ--.49393S2;
	Thu, 04 Sep 2025 09:40:13 +0800 (CST)
Message-ID: <7e05b179-90ec-449b-86a8-796f4a12180a@huaweicloud.com>
Date: Thu, 4 Sep 2025 09:40:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
 <aLio7Z6YolSZ2lPo@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aLio7Z6YolSZ2lPo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA30mn87bhoQU8sBQ--.49393S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fGw4kWFWxtFy3WF4xXrb_yoW8GFy8pF
	9Yya4rJwsIk3W8ZF4vqay0v3WrW3y8ZF47JFW7A3W8AFsxGr1fZr4IvF45Zw1UZ3ZxXr12
	qw43Zry8tFWvy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yE_tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/4 4:45, Tejun Heo wrote:
> Hello, Michal.
> 
> On Wed, Sep 03, 2025 at 10:03:39PM +0200, Michal Koutný wrote:
>> On Wed, Sep 03, 2025 at 06:53:36AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
>>> disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
>>> from cgroup side.
>>
>> CLONE_INTO_CGROUP uses cgroup_mutex and threadgroup rwsem like regular
>> migration, no? Its effect is atomicity wrt clone.
>> Or, Tejum, what do you mean that it disappears? (I think we cannot give
>> up cgroup_mutex as it ensures synchronization of possible parent's
>> migration.)
> 
> Sorry, I was confused. We no longer need to write lock threadgroup rwsem
> when CLONE_INTO_CGROUP'ing into an empty cgroup. We do still need
> cgroup_mutex.
> 
>   671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree")
> 
> Thanks.
> 

I'm still a bit confused. Commit 671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when
updating csses on an empty subtree") only applies to CSS updates. However, cloning with
CLONE_INTO_CGROUP still requires acquiring the threadgroup_rwsem.

cgroup_can_fork
  cgroup_css_set_fork
    	if (kargs->flags & CLONE_INTO_CGROUP)
		cgroup_lock();
	cgroup_threadgroup_change_begin(current);

-- 
Best regards,
Ridong


