Return-Path: <cgroups+bounces-13032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3FAD10395
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 02:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490603016FAE
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF9202F71;
	Mon, 12 Jan 2026 01:04:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DD29408;
	Mon, 12 Jan 2026 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179876; cv=none; b=k0JSdYG1Fi3xA+1+pnM5hhAjb4k+xtrr2nsIo2fzDIrQzddlKY8MnK9f50xDINfsEZ6BlGVSnXpAHBFdrT9+tHbekrFLwhFr+Ty6Z/I+2LfD87xpq0PTaxygLK2oxADaRpAw5Cr9cPPBDTOCopGv/s9TyTXbq3DnHVcKf4EsIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179876; c=relaxed/simple;
	bh=H4p3+C4o1YxbR2wbTXJQSehTNtb2xC1maGQgtk7t8To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkOJocDXXJzoJfjOJ4KnXCalwSdQZb0G65t3JdoS9iISj/ehfXIJZfgdw8xNIYeUELqiNAzcCe/JnU3iqRPOFyry8NsOq1Z2pg2HZFwnyAyAeebwqYpB2bS4nL6jK88IYBn/y09PIiKEiw/vWxkiH1EDC7xIHbvbeLZ6fNZQN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqDdz3zt2zKHMHx;
	Mon, 12 Jan 2026 09:03:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE7AF4056D;
	Mon, 12 Jan 2026 09:04:23 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgDXOPmVSGRpd4rwDQ--.2205S3;
	Mon, 12 Jan 2026 09:04:23 +0800 (CST)
Message-ID: <38634756-1a01-4e22-8af2-e9a2071c1aaa@huaweicloud.com>
Date: Mon, 12 Jan 2026 09:04:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, zhengqixing@huawei.com
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
 <heoizkdewdbvczav4xa4fylnkbswb7sjybt5naw7jlafbzmvin@tctcbn5oxqmb>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <heoizkdewdbvczav4xa4fylnkbswb7sjybt5naw7jlafbzmvin@tctcbn5oxqmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOPmVSGRpd4rwDQ--.2205S3
X-Coremail-Antispam: 1UD129KBjvdXoW5tw15Cry7XF1ruF45JryxZrb_yoWxXFX_uF
	97Cr18Ca1rJr48JFZavF1rJrs0ga4UKr18Jr1293sFga4jyr9xGanYkasYvF1Fka4xXFnx
	Krn8ta1Iyr43KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2026/1/9 22:44, Michal Koutný 写道:
> Hi Qixing.
>
> On Thu, Jan 08, 2026 at 09:44:14AM +0800, Zheng Qixing <zhengqixing@huaweicloud.com> wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> Move the teardown sequence which offlines and frees per-policy
>> blkg_policy_data (pd) into a helper for readability.
>>
>> No functional change intended.
> This rework isn't so big, so I'd leave it upon your discretion but
> consider please moving this patch towards the end of the series.
> (Generally, eases backports of such fixes.)

Good point. I will move this patch to the end of the series in v2.

Kind Regards,

Qixing


