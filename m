Return-Path: <cgroups+bounces-3663-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D932893054B
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E51F21A46
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB287344A;
	Sat, 13 Jul 2024 10:57:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0FF51B;
	Sat, 13 Jul 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868226; cv=none; b=k+yx6f5YVmPjxPcbsb5h6Nw8ZHrJeMmzK29uSnxDZ2CvbC+elNJwUJybeILDjbfQfSxVTEPoRD2sNXeolZi3h5qV/YPiQDa4dJy6s+dZAQyo8xeW7AZqGMlHsvuhDREf23Ek7ouBPn1bAC9NaWXGQHlbCanKtvz5nj7U4f+h8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868226; c=relaxed/simple;
	bh=QzVXk7APsQy77nrz5fXBLxvDVTuBB5pTDsN5HIi/ots=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=il275qKJIrvf+ZW3wKZnG8rzfZ6q6Amzae+kVwbsKd5GIM6BXLHGH+pw5jiumu7jWRaANjYZP7FwV7sPKbc5zB0X2quK7bJRsgqSriKxJPAAi9x4FDQ3FADVNn0rtgiUDwM4iaeHFTF3F3jZ5W741S74Wqkgh1F/90SZcbwj7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WLllR301nz4f3jMJ;
	Sat, 13 Jul 2024 18:56:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 35E521A016E;
	Sat, 13 Jul 2024 18:56:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHazl5XZJmoREJAA--.5337S3;
	Sat, 13 Jul 2024 18:56:59 +0800 (CST)
Subject: Re: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
To: Tejun Heo <tj@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240712085141.3288708-1-xiujianfeng@huawei.com>
 <ZpFlsrNMMUMnT_Lq@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a39656fd-f34c-fa69-7d20-8b86fc1cb0c4@huaweicloud.com>
Date: Sat, 13 Jul 2024 18:56:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpFlsrNMMUMnT_Lq@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazl5XZJmoREJAA--.5337S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw1kCF47tFy8Wryxtry7Jrb_yoWDJFc_ur
	Wjv397urWUJr48A3W3Kw15t390k3y5Gry5Jryqq3yUXa4Fyr18Kw1vg3y3Zry8JF40qF9x
	CF93AayFkrn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

ÔÚ 2024/07/13 1:19, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Fri, Jul 12, 2024 at 08:51:41AM +0000, Xiu Jianfeng wrote:
>> The congestion_count was introduced by commit d09d8df3a294 ("blkcg:
>> add generic throttling mechanism"), but since it is closely related
>> to the blkio subsys, it is not appropriate to put it in the struct
>> cgroup, so move it to struct blkcg.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>> only compiling tested
> 
> blkcg is per cgroup and blkg is per cgroup-device pair, so the change isn't
> just moving the field but updating what it means and how it works. The
> change needs a lot more thinking, justification and testing
I understand blkcg and blkg, however, maybe I'm being noob, I don't see
how this patch is related to blkg, the change is that 'congestion_count'
is moved from cgroup to blkcg. This look quite straightforward to me,
maybe I'm missing something, can you explain more?

Thanks,
Kuai

> 
> Thanks.
> 


