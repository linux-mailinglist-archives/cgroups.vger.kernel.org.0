Return-Path: <cgroups+bounces-9778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D839BB4821B
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 03:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7303C06A2
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 01:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B711C54AF;
	Mon,  8 Sep 2025 01:32:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A12110;
	Mon,  8 Sep 2025 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295139; cv=none; b=eoompHCGv5T88MEfbQVsyt061iqt2AAgHYf+/cxqDKFtkJikAIAAoydc6aOoauSmgixfZSVjqye11r9IdhwS32DLpDOjfLCMRztQlywaXLmYSiAn4EyTUyiqccCiS9Kvm9mjQJRr2/ofOJlRKlc4W1W5oStGU31GHKJlm9puSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295139; c=relaxed/simple;
	bh=+eV1jTgxKlUFpHs6zB7ttmfep+nMsmqrdkfdLOJl5jM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bZg6Qv3YL8moIvrCBpa0P1pJYAqZ39dNycC0dI7UFNxhTajydVS7vwWY739qUTyjyXTSfvO6bYqWHEILgoOG/Xxo6SNF9rV0UWVI7sM0lZkO4CH7c2PXVxlSSQkIL7X0F27vqB97W3mdGgX6wIqmvhhGCoWAEMjQ/e767NU/Tkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cKqFD4KN2zYQtsW;
	Mon,  8 Sep 2025 09:32:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 193D71A1AE9;
	Mon,  8 Sep 2025 09:32:15 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0aMr5ome0LBw--.54766S3;
	Mon, 08 Sep 2025 09:32:12 +0800 (CST)
Subject: Re: [PATCH for-6.18/block 02/16] block: initialize bio issue time in
 blk_mq_submit_bio()
To: Yu Kuai <hailan@yukuai.org.cn>, kernel test robot <lkp@intel.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, bvanassche@acm.org,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250905070643.2533483-3-yukuai1@huaweicloud.com>
 <202509062332.tqE0Bc8k-lkp@intel.com>
 <9c763646-f320-4975-ae19-2a40607757b1@yukuai.org.cn>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <adb6b29c-ad24-0377-c5f3-17868f3e3116@huaweicloud.com>
Date: Mon, 8 Sep 2025 09:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c763646-f320-4975-ae19-2a40607757b1@yukuai.org.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0aMr5ome0LBw--.54766S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1fGFy7XrWxJw45ur1UGFg_yoWfGrgEgr
	WjvwnrWFy8Jw4kJF4Du3sIvrZ7Kw1ktFyF9345AF12g3Z5Xr98uFZ5Gr9aqw1kCw48Za1U
	CF4DXFZxXF43AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRwID5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/07 15:57, Yu Kuai 写道:
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202509062332.tqE0Bc8k-lkp@intel.com/ 
>>
>>
>> All errors (new ones prefixed by >>):
>>
>>     block/blk-mq.c: In function 'blk_mq_submit_bio':
>>>> block/blk-mq.c:3171:12: error: 'struct bio' has no member named 
>>>> 'issue_time_ns'
>>      3171 |         bio->issue_time_ns = blk_time_get_ns();
> 
> This should be included inside BLK_CGROUP config, sorry about this.
> 

I should keep the blkcg_bio_issue_init() and call it here. I'll wait for
sometime and let people revice other patches before I send a new
version.

Thanks,
Kuai


