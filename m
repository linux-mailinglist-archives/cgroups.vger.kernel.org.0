Return-Path: <cgroups+bounces-4711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A996CC62
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA36287EEC
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D30BE5E;
	Thu,  5 Sep 2024 01:48:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06378F6E;
	Thu,  5 Sep 2024 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500912; cv=none; b=MGDpEH7a5ILRVdGw2lonoy+J6YsdJCUgmIxMLTC0GK+4FD87R/9zDm/Y5IvGIM6DZKsQOYf3tICRY6rm7c5FJaACdPURH/eDoWSwXRsHVp4mN2FHT+A+qXFB3HioNO+LIho8a9NRbS6KqUnr8SJ/mDCvqogTHP3ZCt25wiCRHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500912; c=relaxed/simple;
	bh=yIphmlHathP5Wz8+1/m1DOpN6KOZy/rtpCdj9vcnA+I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L91/G29Jb8oIBFD6/2/8xD+ZhQlnCkLXX2lXN0kxu9gqTrqDIMsqffMpakvzXbgsQwlHWXRd/WBF2+D1FeIl6iJECteTygrN2m3umHIi47rQGtt5uyHv/3+VI6uY/GHYZmOCqhDXlGQ3Ym3terUC6rA7vyajAtUp/+gqDdXNvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wzj1W6dMgz4f3jkP;
	Thu,  5 Sep 2024 09:48:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3FA0A1A0925;
	Thu,  5 Sep 2024 09:48:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8foDdlmObuyAQ--.63759S3;
	Thu, 05 Sep 2024 09:48:26 +0800 (CST)
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Jens Axboe <axboe@kernel.dk>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, paolo.valente@unimore.it, mauro.andreolini@unimore.it,
 avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <b5b0e655-fb17-4967-9104-4386710ee8db@acm.org>
 <80732d0d-e1a6-8b5e-791d-7c8a8091159a@huaweicloud.com>
 <db586849-a7d6-44b2-96d0-113629f8d8f9@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <52711505-53db-315c-0e39-143fe8379514@huaweicloud.com>
Date: Thu, 5 Sep 2024 09:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <db586849-a7d6-44b2-96d0-113629f8d8f9@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8foDdlmObuyAQ--.63759S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4DGw4DKFy8AF18Zw4fXwb_yoW8Gw47pa
	y8ta42yrsrJry5C3sFqw1jkrySkrZIy347tr1DXryYkr9I93Wft3W5t39Y9asrZw1xZw1j
	9FWrZ3Z3Cw1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/09/05 1:17, Bart Van Assche 写道:
> On 9/3/24 7:45 PM, Yu Kuai wrote:
>> 在 2024/09/04 10:28, Bart Van Assche 写道:
>>> On 9/3/24 6:32 PM, Yu Kuai wrote:
>>>> We do have customers are using bfq in downstream kernels, and we are
>>>> still running lots of test for bfq.
>>>
>>> It may take less time to add any missing functionality to another I/O
>>> scheduler rather than to keep maintaining BFQ.
>>>
>>> If Android device vendors would stop using BFQ, my job would become
>>> easier.
>>
>> I'm confused now, I think keep maintaining BFQ won't stop you from
>> adding new functionality to another scheduler, right? Is this something
>> that all scheduler have to support?
> 
> As long as the BFQ I/O scheduler does not get deprecated, there will be
> Android device vendors that select it for their devices. BFQ bug reports
> are either sent to one of my colleagues or to myself.

Then, you can share them to me now, I'll like to help.
> 
> For Android devices that use UFS storage, we noticed that the
> mq-deadline scheduler is good enough. The device boot time is shorter
> and I'm not aware of any significant differences in application startup
> time.

We're using bfq for HDD, performance overhead in bfq is not less,
like you said, if bfq doen't show better results in UFS storage, and you
don't want to use the io control feature, you can choose not to use it,
however, remove bfq will be too aggressive.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> .
> 


