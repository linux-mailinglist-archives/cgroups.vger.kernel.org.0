Return-Path: <cgroups+bounces-2554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E878A7A16
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 03:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752F7B22216
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852764690;
	Wed, 17 Apr 2024 01:13:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90053469D;
	Wed, 17 Apr 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713316421; cv=none; b=WMs0NyC7QG18q0UWE7uQ32IG8dY7E99GZHyXocipv7T6nRRyChbLqiukVbetEXfWuBPqjRQ6ul37YUth1jUmRGwwG0IrhmQHnu9evIigwy0dCRs4Ble4HsWOUdGCSOnjJ1oNe0fAwKtvKzkwSHQcbTn46AvBzp/Ui51EKARIf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713316421; c=relaxed/simple;
	bh=cH3GPoGLWHHMri9oLj0PsfXMsreaN3aUk79kYHE8Pcg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eEl+VMiSV3WkIT4nq6wi/gJlE85xsKexkejbz6rMi6FkPYO8hnZYaEfSji9nhtm3ZCtQpUPQqDya4t+pyzJU6/v7IpJDMF7qdNKkCubIM/p5bySjvzqO2StQR6jNhXaUuVNP4jaybXu67U5dhTpyMY88veRb2BxdMFYDsE1Yoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK2wW0cttz4f3jq6;
	Wed, 17 Apr 2024 09:13:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ABB451A0568;
	Wed, 17 Apr 2024 09:13:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RE+Ih9mWga8KA--.8183S3;
	Wed, 17 Apr 2024 09:13:35 +0800 (CST)
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
 <Zhl37slglnnTSMO7@slm.duckdns.org>
 <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>
 <Zh6wx4mXZy_EOViH@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <19086c09-3060-a4ce-4ac6-811a29653979@huaweicloud.com>
Date: Wed, 17 Apr 2024 09:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zh6wx4mXZy_EOViH@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RE+Ih9mWga8KA--.8183S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW8Xr1DZrW8CrWkGryDWrg_yoW3JrX_WF
	4v9rn7G3sxX3Z7C3WUKr4UAFZa9a45uFyDJ3ZFqFsFyF93ZFW8tFZ3CryIk34Fk3yfJasI
	gryjq34Yv3y3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/17 1:09, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Apr 13, 2024 at 10:06:00AM +0800, Yu Kuai wrote:
>> I think that we need find an appropriate time to unload blk-throttle
>> other than deleting the gendisk. I also think of adding a new user input
>> like "8:0 free" to do this. These are the solutions that I can think of
>> for now.
> 
> Probably a better interface is for unloading to force blk-throtl to be
> deactivated rather than asking the user to nuke all configs.

I was thinking that rmmod in this case should return busy, for example,
if bfq is currently used for some disk, rmmod bfq will return busy.

Is there any example that unloading will deactivate resources that users
are still using?

Thanks,
Kuai

> 
> Thanks.
> 


