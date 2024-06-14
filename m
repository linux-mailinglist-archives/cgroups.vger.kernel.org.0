Return-Path: <cgroups+bounces-3185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA12908085
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 03:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F04B283ED8
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 01:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4C158D84;
	Fri, 14 Jun 2024 01:09:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD507158D78;
	Fri, 14 Jun 2024 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327364; cv=none; b=XitGEEP0YcE5HOoqrsSxVbO9P89nzs69zR58GAoKezohQddOlnnt2lDXx6lij6FTuxLUAIlJ3ksKxDgk8xw+Q/QLze85JUs6ZfcXVbrMgBJaCN3psZ3dMLc3xhoNio/ixb0wnNee0PeDj/RV0uG4cMPXp8sVjRZVzRP9G7iL4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327364; c=relaxed/simple;
	bh=4glP+BRzjyJ2L01GIVKDRo51xwzrVDNk7jCtas8TXlU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aIFQT7e9PHXE91Sly0LmUskL5BDh5tc3MpUBZC7+Tkp/xtci21FruicUdhR+ZfM8UReQ7xufvE0AjriIT+1CUF3PN3556vsk+VaXNab5FJXtgT8qlo+hopuWIrnYItmv2AxxxsFJuuSE7d4Ui0z/fGmC5CXQWjGuVSgEYuWRGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0h4m2Qpyz4f3jZj;
	Fri, 14 Jun 2024 09:09:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EF09E1A016E;
	Fri, 14 Jun 2024 09:09:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBE+mGtmdqCtPQ--.28489S3;
	Fri, 14 Jun 2024 09:09:18 +0800 (CST)
Subject: Re: [PATCH -next 2/2] blk-throttle: fix lower control under super low
 iops limit
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
 <20240513120848.2828797-3-yukuai1@huaweicloud.com>
 <ZmtzZKW1m6JpdfWx@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ff91d94e-8dcb-9722-d470-67e3eef1d219@huaweicloud.com>
Date: Fri, 14 Jun 2024 09:09:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmtzZKW1m6JpdfWx@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBE+mGtmdqCtPQ--.28489S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3ZrW3Cr48try7tFy5urg_yoWDWFb_uF
	92k3sakw1UXw4DuanxXFs0yrZa9F45X348Jryqqa1DCFyFkF18Xay3Gr9I9FnxZayfJFnx
	urs0v3yfCrsrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/14 6:32, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Mon, May 13, 2024 at 08:08:48PM +0800, Yu Kuai wrote:
> ...
>> However, if limit is quite low, the result can be 0, then
>> allowed IO in the slice is 0, this will cause missing dispatch and
>> control will be lower than limit.
>>
>> For example, set iops_limit to 5 with HD disk, and test will found that
>> iops will be 3.
> 
> Hmm... can't this be solved by starting the next slice with the right
> credit?

Of course, this looks like feasible. I'll look into this.
> 
>>   static unsigned int tg_throtl_slice(struct throtl_grp *tg, int rw)
>>   {
>> +	if (tg->throtl_slice[rw])
>> +		return tg->throtl_slice[rw];
>>   	return tg->td->throtl_slice;
> 
> Because this is a bit nasty. If we want to use difference throttling slices
> for different cgroups, we might as well do it universally.

I do thought about this, however, because different cgroups have
different slice start, I convinced myself this is fine to have different
slice as well.

Thanks,
Kuai

> 
> Thanks.
> 


