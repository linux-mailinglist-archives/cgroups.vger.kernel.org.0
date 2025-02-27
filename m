Return-Path: <cgroups+bounces-6723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC4AA47333
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E0D188E21F
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202717A5A4;
	Thu, 27 Feb 2025 02:49:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66A13AA31;
	Thu, 27 Feb 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624599; cv=none; b=MHeyKcM7VUTgaKJzRs99F97cjJWgAz/jymBs0AeOpRYbR8xOQ8DmVvxnNOXYBII2vteN0r7MZV6XLacwx5Prfo+ouyHf2FIY2zkZ1fti29ecQAd3qoEywC1JwJbOAGZ48ylQyeiQaCwBL8DzwCh/mVTxJdATMiN/eZFm5YvPi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624599; c=relaxed/simple;
	bh=Ab7eo57PFCFC9WhnnwSJx1S7OQ+3hKFiHMvngc6cB+A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IRb03ZovsJa1mnGUS8KDj81FvxfOtR4bM7VsaUu3fjjqBBP+0eURbsehiybVf+kprj86Wm94QtT6gfM4wfCINA1Mxek3G14V3/S7DdcnNIL3kFbNrwZd1HPeDGpcn06l533rkNwIV6lL5E71jEkQ8MU2MqeDffonkRvv+9fHs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3G5Y66mGz4f3jt8;
	Thu, 27 Feb 2025 10:49:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 620251A0FA5;
	Thu, 27 Feb 2025 10:49:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_R0r9nxjIMFA--.28039S3;
	Thu, 27 Feb 2025 10:49:54 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, vgoyal@redhat.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250226011627.242912-1-yukuai1@huaweicloud.com>
 <Z77R_rqgDdAvFVgP@fedora>
 <021e6495-11e5-3b39-2786-d69cc4bf24f7@huaweicloud.com>
 <Z77uID36yIvWDQEj@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6ce659d4-460d-b8bc-4834-8ad0702e7bdc@huaweicloud.com>
Date: Thu, 27 Feb 2025 10:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z77uID36yIvWDQEj@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_R0r9nxjIMFA--.28039S3
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
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	F9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/26 18:34, Ming Lei 写道:
> Actually the in-tree code already covers deviation from the rounddown(),
> but turns out it is still not enough, so this patch increases one extra
> def slice size. With this thing is documented, feel free to add:
> 
> Reviewed-by: Ming Lei<ming.lei@redhat.com>

Thanks for the review, will send a new verion.
Kuai


