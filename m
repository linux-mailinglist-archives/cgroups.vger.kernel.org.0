Return-Path: <cgroups+bounces-9320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5AB30B8F
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 04:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD65566B55
	for <lists+cgroups@lfdr.de>; Fri, 22 Aug 2025 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCB1E3762;
	Fri, 22 Aug 2025 01:57:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68981DE8A0;
	Fri, 22 Aug 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827878; cv=none; b=GdceEzNCFIv4F7jKROpXJVSG+n1w5/YZkFY8nfdVPse4zXcAz2RGJAAXo9AtT5jkortocrnHHStwfdyppgL8i8oI/db9VG2KvnmwWiGoSgkMkR7EeosUYBKh0q1X9h81MSVbEGfmDVS97Lk3jVGaj3CQv/qEtn7llEimF3GA20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827878; c=relaxed/simple;
	bh=yRDbTmQNyPNYdmnA/vgKUgB0b/pHIH588KMyZCw5plA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJd39S76MJro7QcFg2z5tbPmjLwDUv6yvTznBWKkxH/gX2P/Bxf4N+YjteT2RLtxCZwpqhPl4ftEyTCBkNhGQM/n5gShSJGlRQNRJJsBkJtPCoLRflBr2n15NOpRr4GIQqk259/NYtEL1iIKvKZnjQfpB++jXztUjlYRRMpiKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c7Ncf3V0TzYQtqB;
	Fri, 22 Aug 2025 09:57:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FB161A158A;
	Fri, 22 Aug 2025 09:57:53 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgC3fg+fzqdoemr_EQ--.16884S2;
	Fri, 22 Aug 2025 09:57:52 +0800 (CST)
Message-ID: <38ef3ff9-b380-44f0-9315-8b3714b0948d@huaweicloud.com>
Date: Fri, 22 Aug 2025 09:57:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
To: Tejun Heo <tj@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, cgroups@vger.kernel.org,
 chenridong@huawei.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, mkoutny@suse.com,
 peterz@infradead.org, zhouchengming@bytedance.com,
 Yang Erkun <yangerkun@huawei.com>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <0319ee9b-ce2c-4c02-a731-c538afcf008f@huawei.com>
 <e485b38a-183b-42c8-9aed-9c2d939add0b@huaweicloud.com>
 <aKUo7BuX-teh4IzF@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aKUo7BuX-teh4IzF@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3fg+fzqdoemr_EQ--.16884S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW8KrW7Jr13CryktF43Jrb_yoWDCwb_G3
	y0yrZ8AwnrJa1xCa13JrsIvr92qay5ZFnxJw4rX3yxK3s5Aa4DJFyfXr93Wr15G3yUGr9x
	KFnYqFyvy347ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/20 9:46, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 18, 2025 at 04:00:08PM +0800, Chen Ridong wrote:
>>> A potential solution is to make the lifecycles of cgroup_file_ctx and
>>> psi_trigger match the struct kernfs_open_file they're associated with.
>>> Maybe we could just get rid of the kernfs_release_file call in
>>> kernfs_drain_open_files?
>>>
>>
>> Hi, Tj, what do you think about this solution?
> 
> So, I think it's really fragile for a killed (drained) kernfs_open_file to
> be reused after the corresponding @kn is resurrected. Once killed, that file
> should stay dead. I think it'd be best if we can do this in a generic manner
> rather than trying to fix it only for poll.
> 
> kernfs_get_active() is the thing which gates active operations on the file.
> Maybe we can add a wrapper, say, kernfs_get_active_of(struct
> kernfs_open_file *of) which returns NULL if @of has already been killed or
> the underlying @kn can't be activated?
> 
> Thanks.
> 

Thank you Tj,

This is reasonable, I will try.

-- 
Best regards,
Ridong


