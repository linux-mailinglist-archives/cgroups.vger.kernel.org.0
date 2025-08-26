Return-Path: <cgroups+bounces-9401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51854B350F1
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038235E1090
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8C223301;
	Tue, 26 Aug 2025 01:20:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF4A92E;
	Tue, 26 Aug 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171243; cv=none; b=srdaV3QPuPPTirs3J4xLGRdoAGEM5GbXxqyuQqgioA/4i9cItv0KDTZyRWfJU10U8QTa49Mj7MFSVtLL/0hAUXGIYQWRC2Xk4+9x86C/lW9n8W+d3IBSmGWOl9Bh76QCPYLquCfKa6ggofb3x5Fz24PlQW1jK5RYu1zODzFDld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171243; c=relaxed/simple;
	bh=XYr2L+cpBUoKitOBNDZKLdj36nYteIK4cLflgZ1XGr0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=as5r0brxK32fG5uHQxAIJQE/NF7U0JtDO6kSuuwkKsxH8v8HrKfYUZ9DC3GvUudCjsdgwhDD3r76mw8olpAVAcJjFC95tylKfXbKvH5//bK/E9s9HWyZTeGkW2L0vPqPBBfuFRzx+p3lqDVm5xufrLYYbRlXvTMZZLVPWKMx9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9qbp1j2fzYQvQX;
	Tue, 26 Aug 2025 09:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BDCC51A1306;
	Tue, 26 Aug 2025 09:20:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IziC61oXkA8AQ--.14585S3;
	Tue, 26 Aug 2025 09:20:36 +0800 (CST)
Subject: Re: [PATCH RFC 7/7] block: fix disordered IO in the case recursive
 split
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-8-yukuai1@huaweicloud.com>
 <aKxD2hdsUpZrtqOy@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ac0ea34d-4572-43a6-c32d-11e0fba71f56@huaweicloud.com>
Date: Tue, 26 Aug 2025 09:20:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxD2hdsUpZrtqOy@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IziC61oXkA8AQ--.14585S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1ftF4DGw1rur4kWw4rXwb_yoWfWwbEg3
	sayFWDGw17CF97K3ZrKF1kArWqyFy2gry5u3yfW3ZrAa47XFWDGr1UZ39Iv39aq3y8XrnI
	vFs5t340yF4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRMv31DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 19:07, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 05:37:00PM +0800, Yu Kuai wrote:
>> +void submit_bio_noacct(struct bio *bio)
> 
> Maybe just have version of submit_bio_noacct that takes the split
> argument, and make submit_bio_noacct a tiny wrapper around it?  That
> should create less churns than this version I think.  In fact I suspect
> we can actually bypass submit_bio_noacct entirely, all the checks and
> accounting in it were already done when submitting the origin bio, so
> the bio split helper could just call into submit_bio_noacct_nocheck
> directly.
> 

I can do this, I was trying to avoid touching submit_bio_noacct()
because there are many many callers, a tiny wrapper sounds good!

And for bypassing submit_bio_noacct(), I think it's ok, just
blk_throtl_bio() should be called seperately. Perhaps we can do
this later.

Thanks,
Kuai

> .
> 


