Return-Path: <cgroups+bounces-10714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B7BD82B0
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BEC1894A90
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56530F942;
	Tue, 14 Oct 2025 08:26:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8F1A5B9D;
	Tue, 14 Oct 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430385; cv=none; b=DJ13V73tc5ItWTa0X0wLTgijhLB+nZzYEYekIo1nuaWrc7PKLFLe29AeQWo1wFE9Ghz0bVur9+PRLVHVgJNZZNUHh8db39Xd4Wsf6TQ9g8I2EXZl/lL5Z3SxALSYp+cuq8ZA1IA2tdsJvBRCTbrHPUPfrfNr0tB4og7sJsWZOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430385; c=relaxed/simple;
	bh=XEJeWI/kp1VCKKORqGfXqbGeJMiG5GcowV0ii/rIRU4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T04ntsZoHjrSV/VUAgN1y2VJTY2wmhxpUwTov1UvLzXYdsgwfRsek0/67GIsfWDl5QRgkSKMLG6jnVWn6wwHkL1Z3IqT9r4PlYbvznLzSPbYsovJXyrXxX23VkegdK/ROrsY9KrVyVKzU5o+tjBy0mcN+3Xf4aOyirJuwwTLRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cm6jb6yQSzYQtvk;
	Tue, 14 Oct 2025 16:25:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AB3971A0CC2;
	Tue, 14 Oct 2025 16:26:20 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUYrCe5oSNlMAQ--.28292S3;
	Tue, 14 Oct 2025 16:26:20 +0800 (CST)
Subject: Re: [PATCH 4/4] blk-mq-debugfs: make blk_mq_debugfs_register_rqos()
 static
To: Ming Lei <ming.lei@redhat.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-5-yukuai3@huawei.com> <aO4GoVOqVBh1RMw-@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bd7ef8fb-56c4-b837-e96f-9240e34e0cb0@huaweicloud.com>
Date: Tue, 14 Oct 2025 16:26:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aO4GoVOqVBh1RMw-@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3TUYrCe5oSNlMAQ--.28292S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	ouWlDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/10/14 16:15, Ming Lei Ð´µÀ:
> On Tue, Oct 14, 2025 at 10:21:49AM +0800, Yu Kuai wrote:
>> Because it's only used inside blk-mq-debugfs.c now.
> 
> If it is true, why do you export it in 2nd patch?

Patch 2 is a different helper,
- blk_mq_debugfs_register_rqos() is the old one to register one rqos;
- blk_mq_debugfs_regist_rq_qos() is the new one to iterate all rqos,
   check and register if it's unregistered.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 


