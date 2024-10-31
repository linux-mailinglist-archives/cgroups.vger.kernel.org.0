Return-Path: <cgroups+bounces-5349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12A9B7604
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 09:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D03281DC0
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335EF14D6E1;
	Thu, 31 Oct 2024 08:04:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC312CDB6;
	Thu, 31 Oct 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361850; cv=none; b=tKlfUvLP8jSLwYh7RMdlY/gWNnKfkCwCOLTJ3rxsBnx1uhzhfCMy6V+0Yx6Od/gPef/4k2Q0mtGjjcMw1dGYyvHhjcq7WSSYWpw5IudHooiKu+7Ie9W9jusmESzzB/RRmLuHfehvmaxY/M2wAKfgAdIuwsNTEBhurZ9RSfQ8A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361850; c=relaxed/simple;
	bh=M2HXVbpzDsTg+HwYe96n52wNzDV2Oii+fM5cd4T49Nk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S1gvo8SeCT/p0neCx8MSse6y6Z3a+Ue3PpJfNCz5RKIAGDyWfTWWDj2T71bQwq6MZkcPAv6tNhJOFdT/m5C8j1GZ0ei6rk+GCW8YpTXn83DDaoymZLMyralZ3VqlO3POVJM4qZW/f/u3BPBqf5B7evyKF2NL4c1nGa567m5PZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XfGht543zz4f3lfg;
	Thu, 31 Oct 2024 16:03:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4275D1A018C;
	Thu, 31 Oct 2024 16:04:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHYobwOSNnHfjGAQ--.59788S3;
	Thu, 31 Oct 2024 16:04:01 +0800 (CST)
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
 <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <33183043-335f-fd07-1068-c873656f51d6@huaweicloud.com>
Date: Thu, 31 Oct 2024 16:04:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYobwOSNnHfjGAQ--.59788S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	F9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

ÔÚ 2024/10/01 1:11, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Mon, Sep 30, 2024 at 04:52:58PM +0800, Yu Kuai wrote:
>> +static inline bool blkg_print_dev_name(struct seq_file *sf,
>> +				       struct blkcg_gq *blkg)
>> +{
>> +	struct gendisk *disk = blkg->q->disk;
>> +
>> +	if (!disk)
>> +		return false;
>> +
>> +	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
>> +	return true;
>> +}
>> +
> 
> I wonder whether we just should add a name field to disk.

And suggestions on this set now? I guess add a name filed is not
appropriate. :(

Thanks,
Kuai

> 
> Thanks.
> 


