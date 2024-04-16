Return-Path: <cgroups+bounces-2492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD42F8A60BD
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 04:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640301F21557
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8661097B;
	Tue, 16 Apr 2024 02:12:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22811170F;
	Tue, 16 Apr 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233523; cv=none; b=IpbkxXuTNSg6Q3J2MDj8tC44sMVKyn8Ih1f1otFujUL8D0umpVFrIKS2up0pgMRSk3BvH+7OiIOkcKPOxyi7pzSrXwCfxxoPkxq7H+kcV9m9qIn6fZrnqrVbj7qlLklasfP8z83JIiEd2emMAe+fXtBeB5l/H6npuevbyC2FdCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233523; c=relaxed/simple;
	bh=DumwjCT+zsnFe2/rvMBe8hvDr+KZ6VVjoavyH4FnRiI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uNQKYUI1MAnpWVTe2tXs45PglS6n1DasLWzRhuwLC7Y8VTYm50dbFAesQKii5njI8+FoY9vxePEfLvJgD6N4m1hT+pUHpMNywdOwNTykE+HtzHI25h1AENIRjTOOEzElPnJCgRFpWdAL4rovzkPW1vuz7+vR8acXwy5M7DGYdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSGF4R2dz4f3nJK;
	Tue, 16 Apr 2024 10:11:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79C221A0E6E;
	Tue, 16 Apr 2024 10:11:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFr3h1mHPxnKA--.36211S3;
	Tue, 16 Apr 2024 10:11:56 +0800 (CST)
Subject: Re: [PATCH RFC v2 2/6] blk-throttle: delay initialization until
 configuration
To: Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-3-yukuai1@huaweicloud.com>
 <Zhl2a2m3L3QEELtj@slm.duckdns.org>
 <7531ba77-964a-169d-f55f-a8dcfcdbb450@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f1cbd12d-b66b-131d-44ed-8db67b9186db@huaweicloud.com>
Date: Tue, 16 Apr 2024 10:11:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7531ba77-964a-169d-f55f-a8dcfcdbb450@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFr3h1mHPxnKA--.36211S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20E
	Y4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

ÔÚ 2024/04/13 9:59, Yu Kuai Ð´µÀ:
> Can you please also
> add how you tested the change?

I just sent a patchset to add some tests to blktests, a basic functional
test and a few regression test, this is not enough but it's a start.

https://lore.kernel.org/all/20240416020042.509291-1-yukuai1@huaweicloud.com/

Thanks,
Kuai


