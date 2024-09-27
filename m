Return-Path: <cgroups+bounces-4965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4798800B
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 10:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A645C1C22279
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C91898E0;
	Fri, 27 Sep 2024 08:08:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB7189520;
	Fri, 27 Sep 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424519; cv=none; b=LzmWJoiN+fBluz6kUFaptlXg+XVSqYMNZT6T4t4L2UPoORLQRkmvrRXWh9skyB7GN6lmRNSp5MrvPg3M+eOyhBSnk0LIPGoHoa22neo/qGmB5rAa4zsg0SsFdxpd2/eHBrk6QYNI98SfLFEfUUtBZZBw3ndeueTant8Ww+0Kypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424519; c=relaxed/simple;
	bh=DmH1bdqnmvsqJTkNwjchhRxv+dIOQ+T+/wC54Fa6HWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJsGXY2TtRlpxKa1DeFgSeE74EOKDrpSbU4lBHHJugBITSf8hi4BuIdUzbzN3EQVCiM54XoYqu1rg0TmaW7cEqHARDlwPsXvVd6p4slWmHEmf6T59dxCkwKhT1x+BA6Rr2lYpKXnzWS3GqsZ1YSkHxYRF8GMZH5Tv0KRcu0zOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFNPk4Sw0z4f3lDN;
	Fri, 27 Sep 2024 16:08:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A187C1A0568;
	Fri, 27 Sep 2024 16:08:27 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgBn51z6Z_ZmuE3hCQ--.32299S2;
	Fri, 27 Sep 2024 16:08:27 +0800 (CST)
Message-ID: <6a2f4e01-c9f5-4fb5-953e-2999e00a4b37@huaweicloud.com>
Date: Fri, 27 Sep 2024 16:08:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] workqueue: doc: Add a note saturating the
 system_wq is not permitted
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-3-chenridong@huaweicloud.com>
 <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn51z6Z_ZmuE3hCQ--.32299S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxZw4xJFWxAw1kAFWkZwb_yoW8GFWfpF
	s7uw1jk3Wvyr4Iyws8Zw1j9F4fZF1kua1UtrnrG3s2yr4DGrn3KFyfKF1rZa1YgFn3C342
	vFW2v3yDCa4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/26 20:49, Michal Koutný wrote:
> On Mon, Sep 23, 2024 at 11:43:51AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> +  Note: If something is expected to generate a large number of concurrent
>> +  works, it should utilize its own dedicated workqueue rather than
>> +  system wq. Because this may saturate system_wq and potentially lead
>> +  to deadlock.
> 
> How does "large number of concurrent" translate practically?
> 
> The example with released cgroup_bpf from
>    cgroup_destroy_locked
>      cgroup_bpf_offline
> which is serialized under cgroup_mutex as argued previously. So this
> generates a single entry at a time and it wouldn't hint towards the
> creation of cgroup_bpf_destroy_wq.
> 
> I reckon the argument could be something like the processing rate vs
> production rate of entry items should be such that number of active
> items is bound. But I'm not sure it's practical since users may not know
> the comparison result and they would end up always creating a dedicated
> workqueue.
> 
> 
> Michal

Thank you, Michal.
I think it's difficult to measure the comparison result. Actually, if 
something generates work at a high frequency, it would be better to use 
dedicated wq.

How about:
Note: If something may generate works frequently, it may saturate the 
system_wq and potentially lead to deadlock. It should utilize its own 
dedicated workqueue rather than system wq.

Best regards,
Ridong


