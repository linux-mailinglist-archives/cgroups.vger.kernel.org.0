Return-Path: <cgroups+bounces-3433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE291B4E2
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 04:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D5B21A06
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 02:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423D14277;
	Fri, 28 Jun 2024 02:05:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDB14265;
	Fri, 28 Jun 2024 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540306; cv=none; b=ek4GwBertRVtNCnpvW9lW3DlxRX7DvGanStnnG/4+cIZ/6biiooV8C8rePk/iMBNjbIF6Wfn/4h2RIC9WE59yzCGjf5rRX8vb5VAu2jtmkDpHsuY8FXonDp09qGS4Y1gIfIv01E5sMygRUH0q7viWDLl4Ns4LoDUsOPQfJ1tXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540306; c=relaxed/simple;
	bh=0CYIoszVVn7vVHdDk6YgfaISeLiswBRIB5FtaPqZ12Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUcb5GsUvd9EWZxuh9VAT1XWUE4DROcmAjXKXH8HXQzU+C1ME9d31obmFdLxBo4pgJ2ERVhNKsjgaK8iXahtm+9wZt7/7WlQurp752pmmZsVCWwTE7Yy50VDQPiyngp8jWHmmzW8wFTXlqFButgcXnUsTBxRQNioCn94XPe2iZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W9JfT0hPKz4f3jdq;
	Fri, 28 Jun 2024 10:04:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 01C5A1A0170;
	Fri, 28 Jun 2024 10:05:00 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnkYZKGn5mtbcuAg--.46324S3;
	Fri, 28 Jun 2024 10:04:59 +0800 (CST)
Message-ID: <e828dba4-2daa-4c40-b238-2f32ffb73ec4@huaweicloud.com>
Date: Fri, 28 Jun 2024 10:04:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] block: cancel all throttled bios when deleting the cgroup
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com,
 houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com
References: <20240624130940.3751791-1-lilingfeng@huaweicloud.com>
 <5emugcorjnrcgczkmi7njfzwbotpqn6heu7acfho2zfkdsajpv@yrztl7hoa6ky>
 <77ed0b42-60ac-0746-9a5b-23676e9668f2@huaweicloud.com>
 <lke5obdxztncs2mtbvgylngxspzzzrmlveibye32cqwog7xw5a@bk22ajawnbtn>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <lke5obdxztncs2mtbvgylngxspzzzrmlveibye32cqwog7xw5a@bk22ajawnbtn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnkYZKGn5mtbcuAg--.46324S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1kWryDtw4ktFWDuFW8Xrb_yoWkuwcEgr
	WqvFn2yw1UX395Ca4FkFW3uFW3Ka18Gr1UC34jqryxGryFyF4kuFWv9rWxZF1ayayxtr9r
	Z3srAw1UZw1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQzVbUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/6/27 22:48, Michal Koutný 写道:
> On Tue, Jun 25, 2024 at 07:38:34PM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>> Thanks for your advice. It's indeed more appropriate to use "flush" instead
>> of "cancel" here, I will change it soon.
> I saw your v2. Didn't you forget to change also the function name?
Yes, sorry for losing it.
>
>> I didn't quite get what you mean. Do you mean this patch will cause a change
>> in mechanics, and it is necessary to add an explanation?
>>
>> (After deleting the original cgroup,
>>   Before: the limit of the throttled bios can't be changed and the bios will
>> complete under this limit;
>>   Now: the limit will be canceled and the throttled bios will be flushed
>> immediately.)
> I mean -- can the new mechanics be exploited to bypass throttling by
> sending IO from a process, migrate it between cgroups and rmdir them?
> That should be covered in the commit log.
Yes.
Migrating a process to a new cgroup means we want the next bio will be
throttled by the new limit.
We can flush the throttled bios by deleting the old cgroup, or keep it
to make the previous bios complete slowly under the original limit.


Thanks.

>
> Thanks,
> Michal


