Return-Path: <cgroups+bounces-8957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA6B16DC6
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F553584567
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC429DB86;
	Thu, 31 Jul 2025 08:42:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C029346F;
	Thu, 31 Jul 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951338; cv=none; b=XyZNaKwQieZajYKWhaBMsJZdxdsv2Z28tv2qvdydy3no/+bb++AsQlEOMOQ3QG5CbwObBf9mTAiLa0rdWp3gMDNRKLD5pzGLPdUZA+wnl1LGTzAN+uaTA4tnrZeuePx0M6kg9ITBHej3kK5XvnE4c9GTGqeo3rp5Y7bnvBl/yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951338; c=relaxed/simple;
	bh=7i56Qw6VmNm1cmiaRW7qDLzGZLf70TSG4aP5qN2/M7Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CBxz5EzR6+VjBSsPfVMf18gMsjApymMhz9PwIpxPEyiOjHztKCfCCQgvRioh58TyTaIFAUucNB438OWa69teuC+ly613hrDPk8yCp5SzZeQ0D7AMxxbUife8WjS4ZCguIIf2eTuplWIfmEx6J5OLv4hw/lAv/H5O0GEsGgkFVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bt2dK5z58zYQvxX;
	Thu, 31 Jul 2025 16:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B68A1A06E0;
	Thu, 31 Jul 2025 16:42:12 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBFiLItoAoRWCA--.204S3;
	Thu, 31 Jul 2025 16:42:12 +0800 (CST)
Subject: Re: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching
 for sq elevator
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <aIsmvj_lxLA6ZaWe@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <99e9aa7e-b33c-ce2e-bf0f-0021434690e8@huaweicloud.com>
Date: Thu, 31 Jul 2025 16:42:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aIsmvj_lxLA6ZaWe@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBFiLItoAoRWCA--.204S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7V
	UbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/31 16:18, Ming Lei Ð´µÀ:
> batch dispatch may hurt io merge performance which is important for
> elevator, so please provide test data on real HDD. & SSD., instead of
> null_blk only, and it can be perfect if merge sensitive workload
> is evaluated.

Ok, I'll provide test data on HDD and SSD that I have for now.

For the elevator IO merge case, what I have in mind is that we issue
small sequential IO one by one with multiple contexts, so that bios
won't be merged in plug, and this will require IO issue > IO done, is
this case enough?

Thanks,
Kuai


