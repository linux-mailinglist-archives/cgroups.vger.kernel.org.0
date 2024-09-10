Return-Path: <cgroups+bounces-4782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0B972747
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 04:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD13B214E5
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176A143C6E;
	Tue, 10 Sep 2024 02:39:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725057CBE;
	Tue, 10 Sep 2024 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935975; cv=none; b=ARBLM2jBH+eD7CSjH0wedp4gDrzGvBDdvlbO+cDAr0qZu+8j6xWk7OKUcpXujW2bu/LfkajGl4Y3ou9h6C8iMcOTzQ6uuDeZvxO8nzNCzR2WGl5eeEDZ5Sr7E52GlBw8ZflAkuUu9yyLo1S8ulPVwtrFH5qNJD92+2wAprsDAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935975; c=relaxed/simple;
	bh=P85DDE/rnv7fhO+Aj41O9Y2tinp3PZlbTs6zHKgtzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPy8EiUWvHsdLZ/qI6Z0goS0YUyhlau7wBNsexcomIDi6XXQyn5sru/75u8+urXNP7faiuTepHXVfeIzkcbQ/ObK5XOim/FpKYcjxKG00fX5k3Zh5ZfbB6y+RH4g8nfBJFNNvXRPM7O7zsZMsV650wmUAFKTsfm2/TQkaqGfMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2nvz2Y4tz4f3js1;
	Tue, 10 Sep 2024 10:39:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AE1F71A154C;
	Tue, 10 Sep 2024 10:39:26 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBHm4ddsd9m1mB1Aw--.57596S2;
	Tue, 10 Sep 2024 10:39:26 +0800 (CST)
Message-ID: <98d20bd5-5b07-46c1-b098-0d883255484e@huaweicloud.com>
Date: Tue, 10 Sep 2024 10:39:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 1/3] cgroup/freezer: Reduce redundant traversal
 for cgroup_freeze
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-2-chenridong@huawei.com>
 <quuw3s2y47l74ge54a43yjeaeoofqwg6ozofb3nwgvn55oj55p@o7bb5yrhvbj2>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <quuw3s2y47l74ge54a43yjeaeoofqwg6ozofb3nwgvn55oj55p@o7bb5yrhvbj2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHm4ddsd9m1mB1Aw--.57596S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UCw1fCF1rur1fZFW8JFb_yoW8XF1kpr
	WDAa1vkw1YvF4jkrs2qa40vw1Fkrs3Jr47Kr98ta4xAFnxZas5tr1xCa45Wr1DAFnak34j
	qa1Y9wn3Cr1qvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/10 3:01, Michal Koutný wrote:
> On Thu, Sep 05, 2024 at 01:41:28PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> Whether a cgroup is frozen is determined solely by whether it is set to
>> to be frozen and whether its parent is frozen. Currently, when is cgroup
>> is frozen or unfrozen, it iterates through the entire subtree to freeze
>> or unfreeze its descentdants.
> 
> It's more to maintain the numeric freeze "layers".
> 
>> However, this is unesessary for a cgroup that does not change its
>> effective frozen status.
> 
> True.
> 
>> +static inline void cgroup_update_efreeze(struct cgroup *cgrp)
>> +{
>> +	struct cgroup *parent = cgroup_parent(cgrp);
>> +	bool p_e = false;
>> +
>> +	if (parent)
>> +		p_e = parent->freezer.e_freeze;
>> +
>> +	cgrp->freezer.e_freeze = cgrp->freezer.freeze | p_e;
> 
> Better be || on bools
> 

Thanks you, that is right.

> I'd open code this inside the loop of cgroup_freeze since it is not
> context-less function and it relies on top-down processing.
> 
> Root cgrp cannot be frozen. You can bail out early in the beginning of
> cgroup_freeze() (possibly with a WARN_ON) and then assume parent is
> always valid when iterating.
> 

'cgroup.freeze' is with CFTYPE_NOT_ON_ROOT tag, root cgroup will never 
be frozen, considering root cgroup seems to be unesessary. I will open 
the code inside the loop of cgroup_freeze in next patch.

Thanks
Ridong

> I think maintaining the e_freeze in this "saturated arithmetic" form is
> a sensible change.
> 
> Thanks,
> Michal


