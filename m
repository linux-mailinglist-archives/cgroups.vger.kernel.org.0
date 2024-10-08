Return-Path: <cgroups+bounces-5062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF0993F0C
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4511C21FFA
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314881D27BF;
	Tue,  8 Oct 2024 06:24:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769513B2B8;
	Tue,  8 Oct 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368695; cv=none; b=KXC3PtcStWOvGrn7ldJDIkkwyHYp3HF3qGLO7LxqOvCcZ8GRi6GDQktmLWC8x7+raRoOS9Y+9E5WmPI/jnyQD6UnBy9R/QEbgGHwPNR3TSm0k/Fd+JRQrWu+Z3g9JX8SSP9p4bXQAO2ZKyfAZcN1Zn5fkakGpyl7cBSu88cNTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368695; c=relaxed/simple;
	bh=NSZQYul1LgLAy0nrr/tXr6PsqZqpJG1Ku86c4I4Wr28=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X9k94gT2/8Ctupa0sElH9XbQIEFMcDc8IAV7FxryQzGxK3ucnFcarAQgtVOdzGRCppOQaXDSMlIkIxSm3R0upSF+tkgHr/Pxuif2T8DihkPZefrYiEG746JSp81AqWd4lckFcuCJ/N6vVVo984VvF6orjtlbljlBiUVxwxn0FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN5b14N5hz4f3kvm;
	Tue,  8 Oct 2024 14:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22FFB1A06D7;
	Tue,  8 Oct 2024 14:24:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8Qt0ARnxzL9DQ--.55295S3;
	Tue, 08 Oct 2024 14:24:46 +0800 (CST)
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
 <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
 <ce2b9ed1-cf74-1d50-a72a-23733c0d1db0@huaweicloud.com>
 <ZwS8lwQ_fN2HY93p@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8aab9d5d-ed45-dc38-085b-e6ed67d0b3c6@huaweicloud.com>
Date: Tue, 8 Oct 2024 14:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZwS8lwQ_fN2HY93p@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8Qt0ARnxzL9DQ--.55295S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1UCFyUWrW8Jw1UZryfXrb_yoWfurc_ua
	43Cr4UC3W3G3WkJrs8Kr13GayDJF1DGFW5Z3WxJFsxZas8ZasxJFWUJas3Jws7AF40q3Zx
	C3Z8Za40gFW2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/10/08 13:01, Christoph Hellwig 写道:
> On Tue, Oct 08, 2024 at 09:39:05AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/10/01 1:11, Tejun Heo 写道:
>>> Hello,
>>>
>>> On Mon, Sep 30, 2024 at 04:52:58PM +0800, Yu Kuai wrote:
>>>> +static inline bool blkg_print_dev_name(struct seq_file *sf,
>>>> +				       struct blkcg_gq *blkg)
>>>> +{
>>>> +	struct gendisk *disk = blkg->q->disk;
>>>> +
>>>> +	if (!disk)
>>>> +		return false;
>>>> +
>>>> +	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
>>>> +	return true;
>>>> +}
>>>> +
>>>
>>> I wonder whether we just should add a name field to disk.
>>>
>>
>> Of course we can, however, I'm not sure if this is better, because
>> this field is not used in the fast path.
> 
> Struct gendisk does have a (disk_)name field aleady.

Yes, but this name is not major and minor(for example, sda instead of
8:0), Tejun was probably talking about major and minor name field.

Thanks,
Kuai

> 
> .
> 


