Return-Path: <cgroups+bounces-7217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A73A6D2F2
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 03:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A03B3B2DAE
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360F44C94;
	Mon, 24 Mar 2025 02:06:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3DA1362;
	Mon, 24 Mar 2025 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782004; cv=none; b=oH8nWnjwkAd0oOqxkUEX4p191yTaiG2zubPAZUz0oTF7KRzqJsOQrHr2iQnA5lLF4UDc/YSlcENK/7ydrkprVMWQLdnuoOrhy0Btmy3uwdDIwntnjTklWfoGx3rgqxUNsuF0blqL3U9jCcoupdAVvBVWKRdLak7O0SueGFJSM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782004; c=relaxed/simple;
	bh=Hi4oW6GyVoQTk60WFu4HDfjDhU2apN+Ms5+ZxheYusE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C/7BsMjVEKiXMC2cukMWkDZoNZSyA3tvpS/CXF1iJ3DzxghvytIsgNwMlfT93RzZum+yy/6CSjUCBaYgcZ0wmC8dmToEaeXX65/uuJ3len2/kwf+GUxSc3dzPeTJEw9Q1CzDZWvcRVt2sHNWgfWO0VHk9ecphC2abWkUn7Jxh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZLbxy28Jhz4f3jtJ;
	Mon, 24 Mar 2025 10:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB7341A1CA8;
	Mon, 24 Mar 2025 10:06:31 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8lvuBnEoqPHQ--.16986S3;
	Mon, 24 Mar 2025 10:06:31 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora> <Z88K5JtR4rhhIFsY@slm.duckdns.org>
 <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>
 <Z9CQOuJA-bo4xZkH@slm.duckdns.org>
 <c1e467a9-7499-e42b-88ed-b8e34b831515@huaweicloud.com>
 <Z9GrD-7tW6tKVimk@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9d87351a-8ea6-9ed9-7359-3963672cdc17@huaweicloud.com>
Date: Mon, 24 Mar 2025 10:06:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9GrD-7tW6tKVimk@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8lvuBnEoqPHQ--.16986S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8Kw1xuw4fGw1UtF4Dtwb_yoW5Jw15pa
	yfGwnayFs5W3ZrCFn3ur4xuryF9rZ5Gw45Jrn5Gr4DZr4Y93WxJr4xtayrAF929r4Sya42
	qwn5Xas8Xas8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

ÔÚ 2025/03/12 23:41, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Wed, Mar 12, 2025 at 09:51:30AM +0800, Yu Kuai wrote:
> ...
>> In the case of dirty pages writeback, BIO is 4k, while RQ can be up to
>> hw_sectors_kb. Our user are limiting iops based on real disk capacity
>> and they found BIO merge will be broken.
>>
>> The idea way really is rq-qos based iops limit, which is after BIO merge
>> and BIO merge is ensured not borken. In this case, I have to suggest
>> them set a high iops limit or just remove the iops limit.
> 

My apology for the late reply.

> I get that that particular situation may be worked around with what you're
> suggesting but you should be able to see that this would create the exact
> opposite problem for people who are limiting by the IOs they issue, which
> would be the majority of the existing users, so I don't think we can flip
> the meaning of the existing knobs.

Yes, I understand the current situation. I just feel blk-throttle have
no such capacity to limit IOs that are issuing from user. There could
also be filesystems, and data blocks can be fragmented.
> 
> re. introducing new knobs or a switch, one thing to consider is that
> independent iops limits are not that useful to begin with. A device's iops
> capacity can vary drastically depending on e.g. IO sizes and there usually
> is no one good iops limit value that both doesn't get in the way and
> isolates the impact on other users, so it does feel like trying to polish
> something which is fundamentally flawed.

It's not just fundamentally flawed, and the implementation is just too
one-sided. So what is the next step?

- remove iops limit since it's not that useful;
- swith iops limit to against disk;
- do nothing?
> 
> Whether bio or rq based, can you actually achieve meaningful isolation with
> blk-throtl's iops/bw limits? If switching to rq based (or something
> approximating that) substantially improves the situation, adding new sets of
> knobs would make sense, but I'm skeptical this will be all that useful. If
> this is just going to be a coarse safety mechanism to guard against things
> going completely out of hands or throttle already known IO patterns, whether
> the limits are based on bio or rq doesn't make whole lot of difference.

Most of our users will just set meaningful bps limit, however, since
iops limit is supported they will set it as well, without much knowledge
how it really works, causing some unexpected phenomenon. And for now,
we'll suggest not to set iops limit, no even a high limit.

Thanks,
Kuai

> 
> Thanks.
> 


