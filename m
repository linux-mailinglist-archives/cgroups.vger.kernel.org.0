Return-Path: <cgroups+bounces-3357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF6916654
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9101F22561
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BF14B07C;
	Tue, 25 Jun 2024 11:38:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA447A64;
	Tue, 25 Jun 2024 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315523; cv=none; b=PrBoEMUEDeWM5OGLo3/rPKZgVsNAofzZkGGnshfyuioPBU7WXajitoCW8oWhcCH1DbJHZRZVDRsaaRsiBBrmNZjc0TuHD4s0pGujUE161F3/riC/xU/m95uSaWVqq5YzPbJStf4NnHlhQPn9R8cvVStcbi7Qo7PN/HjiBBxVE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315523; c=relaxed/simple;
	bh=tuKcN7msvExSJkenmqvA0RHkiHj+FhdQ9vmYGb1gdY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeIRuTr5/ni6riOpBdrWm3jvYRkK5OWHtcx2b3MrmvzWJx/GEgv+YNe7eiLdXKfb2TlG8IMQvTtBUEOeaY5fHY6rFdQKpWUs0+APYhQABc1XPRwh1YnYf8HwXfSrGqFvwhgRfA9bYk/XlOnXpkeztV/zorjnjV/IB6A8TAyZ1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W7jWh211Jz4f3l1y;
	Tue, 25 Jun 2024 19:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 619261A0189;
	Tue, 25 Jun 2024 19:38:36 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YY6rHpmAfY0AQ--.8681S3;
	Tue, 25 Jun 2024 19:38:36 +0800 (CST)
Message-ID: <77ed0b42-60ac-0746-9a5b-23676e9668f2@huaweicloud.com>
Date: Tue, 25 Jun 2024 19:38:34 +0800
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
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <5emugcorjnrcgczkmi7njfzwbotpqn6heu7acfho2zfkdsajpv@yrztl7hoa6ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0YY6rHpmAfY0AQ--.8681S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1kWrWkXF15Xr4fuw13twb_yoW8Aw1Dpa
	1Sv3W7Krn8Jr9ayF4vvF4F9FyfZrZ3Gr45AFn8Gw15Ar15Xr4DtrZakw4rua4xZrn3C3ya
	vF4jqF1DZ3Wqk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/6/25 18:34, Michal Koutný 写道:
> Hello.
>
> On Mon, Jun 24, 2024 at 09:09:40PM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> When a process migrates to another cgroup and the original cgroup is deleted,
>> the restrictions of throttled bios cannot be removed. If the restrictions
>> are set too low, it will take a long time to complete these bios.
> When pd_offline_fn is called because of disk going away, it makes sense
> to cancel the bios. However, when pd_offline_fn is called due to cgroup
> removal (with possibly surviving originating process), wouldn't bio
> cancelling lead to loss of data?
> Aha, it wouldn't -- the purpose of the function is to "flush" throttled
> bios (in the original patch they'd immediately fail, here they the IO
> operation may succeed).
> Is that correct? (Wouldn't there be a more descriptive name than
> tg_cancel_bios then?)
Thanks for your advice. It's indeed more appropriate to use "flush" 
instead of "cancel" here, I will change it soon.
>
> And if a user is allowed to remove cgroup and use this to bypass the
> throttling, they also must have permissions to migrate away from the
> cgroup (and consistent config would thus allow them to change the limit
> too), therefore this doesn't allow bypassing the throttling limit. If
> you agree, could you please add the explanation to commit message too?

I didn't quite get what you mean. Do you mean this patch will cause a 
change in mechanics, and it is necessary to add an explanation?

(After deleting the original cgroup,
  Before: the limit of the throttled bios can't be changed and the bios 
will complete under this limit;
  Now: the limit will be canceled and the throttled bios will be flushed 
immediately.)

> Thanks,
> Michal


