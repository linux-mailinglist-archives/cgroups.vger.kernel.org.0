Return-Path: <cgroups+bounces-3228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B390C6D1
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 12:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1F31C219C8
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8B13DDB6;
	Tue, 18 Jun 2024 08:03:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4253E24;
	Tue, 18 Jun 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697793; cv=none; b=hgVCsRF5GrhUWYdpLDNb4YlMrjnjYHPwUhMkIp8zBywokC6XZEs5xFUqeHNVm9wj8XzUuzV/0cQhZLFr+Lb+2vI6XkGgjdemW/htZPWcb9xEjcHNi19R6K/SrzJnlfk5LOCffXNaOTfWzLwPt4UzLOddh2/rtls7BX0rHOPDq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697793; c=relaxed/simple;
	bh=yVeL7ijLL7y2vwt1PyWoFnupRupapmSrFx1awBwdKE4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l2+7BrNoV4HhzC2Kmve98sz7PdKBlcElCeMoFgM731XhxWVw+xUUjTZdKU6y/ZGTaDISesoDNRMLF4BJUDZk/43Gc/e8tq9ksNPj4VwqTdPGDx/7Z37Q4yPOljOOQOnNjkYw7+KWyimm2TjvsySvQE2XN26ycetGD+o0jALWQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3K4L5wxrz4f3jLX;
	Tue, 18 Jun 2024 16:02:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9DB461A0199;
	Tue, 18 Jun 2024 16:03:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCH7ww4P3FmKWwPAQ--.20786S3;
	Tue, 18 Jun 2024 16:03:05 +0800 (CST)
Subject: Re: [PATCH RFC v2 0/7] blk-iocost: support to build iocost as kernel
 module
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
 bvanassche@acm.org, josef@toxicpanda.com, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
 <ZnEzZ0Xslaxfm-it@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1775a296-6ce0-afaf-cf4a-2e7171966654@huaweicloud.com>
Date: Tue, 18 Jun 2024 16:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZnEzZ0Xslaxfm-it@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7ww4P3FmKWwPAQ--.20786S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4xArW7GryktFWrZF4Dtwb_yoWkJwc_u3
	Z5JryI9a1UWa1UtF4ktrsakFZIqFWrCrWkJ34rXay3trn5AF17AFs3KFyFqFs5Jr4rJFn8
	uFn8XF9Yg343CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/18 15:12, Christoph Hellwig Ð´µÀ:
> On Tue, Jun 18, 2024 at 11:17:44AM +0800, Yu Kuai wrote:
>> The motivation is that iocost is not used widely in our production, and
>> some customers don't want to increase kernel size to enable iocost that
>> they will never use, and it'll be painful to maintain a new downstream
>> kernel. Hence it'll be beneficially to build iocost as kernel module:
>>
>> - Kernel Size and Resource Usage, modules are loaded only when their
>> specific functionality is required.
>>
>> - Flexibility and Maintainability, allows for dynamic loading and unloading
>> of modules at runtime without the need to recompile and restart the kernel,
>> for example we can just replace blk-iocost.ko to fix iocost CVE in our
>> production environment.
> 
> Given the amount of new exports and infrastructure it adds this still
> feels like a bad tradeoff.

Yes, I understand your concern, let's see if we can export less and
hopefully accept the tradeoff. :) All other cgroup policies and wbt can
benefit the same without more helpers to be exported.

Thanks,
Kuai
> 
> 
> .
> 


