Return-Path: <cgroups+bounces-9260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5BB29AF7
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7572E202DBF
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F027E07E;
	Mon, 18 Aug 2025 07:41:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D671D514E;
	Mon, 18 Aug 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502910; cv=none; b=iAuhzJHSgPfz+TbQNAv3s7KqSytK0/MYCKa/lxcoNLnknl/CU0H3eQG2yuwdnfymMus4SyERCNxkei3Wu0edLn/2zIXf0OPJlkqqSeKZpGLb/EzrOyc71M5E7aOZaooQKndel5FsszbA1EsOIXFNqehZqRcgZaMzYL8QBbmy0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502910; c=relaxed/simple;
	bh=5JA+cOuCOXGZzGfCEMP4tZuqW26ojOfyc0jLnPTjPEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9IEidQZyWLGrl6xPgRMMIHpllfOTVT7jtpefurMzGglMf0OoyFcY175feIIQxWaOPmAt81uWfVtxG/wiMsPmO5sooEb7jvJMxjZ9f+uOLGFTuhiStOKc0TxorI6Gyz1Z3tTSg543yAgGiD4kIoXz4qpSj3Zw1npDKCG6q1fheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c54RF3vjKzKHNDl;
	Mon, 18 Aug 2025 15:41:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E75411A0359;
	Mon, 18 Aug 2025 15:41:44 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAHzdc22aJot9wEEA--.41552S2;
	Mon, 18 Aug 2025 15:41:44 +0800 (CST)
Message-ID: <df28c8ff-281b-46c7-8a96-9d0300307c38@huaweicloud.com>
Date: Mon, 18 Aug 2025 15:41:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, peterz@infradead.org,
 zhouchengming@bytedance.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <2025081526-skeptic-cough-7fda@gregkh>
 <ql5573r2nbex53fyygwczyjipmtalc22n3hxxzmqwi2sgadodt@a5pesn5gunf2>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ql5573r2nbex53fyygwczyjipmtalc22n3hxxzmqwi2sgadodt@a5pesn5gunf2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHzdc22aJot9wEEA--.41552S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr48Cw18Ary5XF4rXFyxKrg_yoW8ur18pr
	n0kF4UtF4rJrykCr4kA3W093WrW39xtFyfXw1kW34fJwnIvr1kGF12gF4Yg3WDXrn3Jr4I
	qF4a9ayjq3s5XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/15 22:42, Michal Koutný wrote:
> On Fri, Aug 15, 2025 at 08:11:39AM +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
>>> index a6c692cac616..d5d01f0b9392 100644
>>> --- a/fs/kernfs/file.c
>>> +++ b/fs/kernfs/file.c
>>> @@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>>>  	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
>>>  	__poll_t ret;
>>>  
>>> -	if (!kernfs_get_active(kn))
>>> +	if (of->released || !kernfs_get_active(kn))
>>
>> I can see why the cgroup change is needed,
> 
> I don't see it that much. of->priv isn't checked in cgroup code anywhere
> so it isn't helpful zeroing. As Ridong writes it may trade UaF for NULL
> pointer deref :-/ (Additionally, same zeroing would be needed in error
> path in cgroup_file_open().)
> 

Thank you, Michal,

I believe assigning NULL to of->priv should be harmless. This change would make the bug more
observable in practice. Without this explicit NULL assignment, the use-after-free (UAF) issue might
remain hidden in some cases, particularly when KASAN is disabled.

> I _think_ the place to cleanup would be in
> @@ -3978,6 +3978,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of,
>                 psi->enabled = enable;
>                 if (enable)
>                         psi_cgroup_restart(psi);
> +               else
> +                       psi_trigger_destroy(???);
>         }
> 

Could you please provide more details about this modification? Do you mean we need to consider
additional cleanup work when disabling cgroup.pressure? The psi_trigger_destroy is invoked as
follows:

cgroup_file_show
  kernfs_drain
    kernfs_drain_open_files
      kernfs_release_file
        cgroup_file_release
          cft->release(of);
            cgroup_pressure_release
              psi_trigger_destroy

>         cgroup_kn_unlock(of->kn);
> 
> The issue is that cgroup_pressure_write doesn't know all possible
> triggers to be cancelled. (The fix with of->released would only
> sanitize effect but not the cause IMO.)
> 
> HTH,
> Michal

-- 
Best regards,
Ridong


