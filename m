Return-Path: <cgroups+bounces-12376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C61BECC2994
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDB7E302B787
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134C352FBE;
	Tue, 16 Dec 2025 12:14:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2534F250;
	Tue, 16 Dec 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887241; cv=none; b=neEzwJi7fqxTLg12Omk+nZ0JG0/zKaeR3c3HJ2m4n43AJdDRLyZFhgiTxFr1KnZC1iVm+kMAk+0DJSslydMA+KeNUTdsFZov/bSVJfsNbBplu4sF4rVG5I3Az+MbSGUduYuEZnLtMF5mxB+MTuBoTzgCfUiy1ZxWkXMtzaAKHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887241; c=relaxed/simple;
	bh=2fKq0fv7tkGX0jDlyAWTqhRbU8gPHZ5i4feABeAa+28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtof3w52poKMvk4Wvoqs2ooWrKnDXxGP1X7AV92qdYgMWOd/sjqHwxDcCZDVncqBv9hVbR48hoZaLile162vxiC4Tv3pqkQFZEetfmeb5AjE08bgdwsov5qGLjSlpxSKrUIwh+pKOjfJ0oyS3YARtMs82564nngOGKSzb3xPYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVwnP6kzMzYQtHl;
	Tue, 16 Dec 2025 20:13:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEB3D4056B;
	Tue, 16 Dec 2025 20:13:54 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vYBTUFpIn6SAQ--.7985S2;
	Tue, 16 Dec 2025 20:13:54 +0800 (CST)
Message-ID: <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>
Date: Tue, 16 Dec 2025 20:13:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
 <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vYBTUFpIn6SAQ--.7985S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rKr17Cry3Gr4xuw1rZwb_yoW8AF1DpF
	yDCa1DtF4UJFyxu3Z7X390qryIgwnrKF4UtFyrA3WFyF47AFy7uF1Ig3WYqr15Gr18G34x
	ZFyYgws2gas0kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/16 17:51, Michal Koutný wrote:
> On Tue, Dec 16, 2025 at 01:28:45AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> This commit introduces the cpuset1_online_css helper to centralize
>> v1-specific handling during cpuset online. It performs operations such as
>> updating the CS_SPREAD_PAGE, CS_SPREAD_SLAB, and CGRP_CPUSET_CLONE_CHILDREN
>> flags, which are unique to the cpuset v1 control group interface.
>>
>> The helper is now placed in cpuset-v1.c to maintain clear separation
>> between v1 and v2 logic.
> 
> It makes sense to me.
> 
>> +/* v1-specific operation — caller must hold cpuset_full_lock. */
>> +void cpuset1_online_css(struct cgroup_subsys_state *css)
>> +{
>> +	struct cpuset *tmp_cs;
>> +	struct cgroup_subsys_state *pos_css;
>> +	struct cpuset *cs = css_cs(css);
>> +	struct cpuset *parent = parent_cs(cs);
>> +
> 
> +	lockdep_assert_held(&cpuset_mutex);
> +	lockdep_assert_cpus_held();
> 

Thanks for the feedback, Michal.

Regarding the lock assertions: cpuset_mutex is defined in cpuset.c and is not visible in
cpuset-v1.c. Given that cpuset v1 is deprecated, would you prefer that we add a helper to assert
cpuset_mutex is locked? Is that worth?

> When it's carved out from under cpuset_full_lock().
> 
> 
>> @@ -3636,39 +3630,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>>  		cs->effective_mems = parent->effective_mems;
>>  	}
>>  	spin_unlock_irq(&callback_lock);
>> +	cpuset1_online_css(css);
> 
> guard with !is_in_v2mode()
> 

Should we guard with !cpuset_v2() or !is_in_v2mode()?

In cgroup v1, if the cpuset is operating in v2 mode, are these flags still valid?

-- 
Best regards,
Ridong


