Return-Path: <cgroups+bounces-12270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D4CA5D9B
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 02:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F214301096A
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2223EAA6;
	Fri,  5 Dec 2025 01:44:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057F2E413;
	Fri,  5 Dec 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899079; cv=none; b=fvUqP6Aq9JLYwJSkEud3YiSNyZvX07VKNDw7K1tRP2bhz2NkH2oLVtyGN+kle3FVGVe+TlgBV0LpPkNdtq4VgFaHOsLt8MDFhi9QJXs725k1tq2JWI5FS4Flde8HYJxRh2rQEpNRpgitty7CZ1F3GS25iMAMT+wyUG+ZEJEH+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899079; c=relaxed/simple;
	bh=fDoq2czki2fpg4CdJ9xIJn/4Ny95qRkLbUrgQoDXziA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glTjsKTpG5EvsXvq+C1ln7lW2Q4y/sKJtPTFwH3Wc+PRbcEbAo8+yP0QL2Dp++eS7F6xifGwPThfheitp5TJ3LAguLu5lbEAht3ddv6vPOuYNijtD4YMGQT9MlCweuKlfpWSzOR+k+NG67btVM4tvTF8Lsa8y/OGfygWTNMVNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dMvKh4vTVzKHMMG;
	Fri,  5 Dec 2025 09:43:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6E8851A0A22;
	Fri,  5 Dec 2025 09:44:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDXE4D7ODJpXJyFAg--.50165S2;
	Fri, 05 Dec 2025 09:44:28 +0800 (CST)
Message-ID: <3ffe4fbd-5748-42ef-8148-c7dfc149493f@huaweicloud.com>
Date: Fri, 5 Dec 2025 09:44:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251126020825.1511671-1-chenridong@huaweicloud.com>
 <nz6urfhwkgigftrovogbwzeqnrsnrnslmxcvpere7bv2im4uho@mdfhkvmpret4>
 <e5b53c3a-563a-4af6-94e6-1ce4acc7b399@huaweicloud.com>
 <ybae7fgr2cszhu2g2gx6v2pgmovajsue5atvxha4dhpe7alco7@vq3jdgy2ksmu>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ybae7fgr2cszhu2g2gx6v2pgmovajsue5atvxha4dhpe7alco7@vq3jdgy2ksmu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXE4D7ODJpXJyFAg--.50165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15ZrWxXFy5tF43AF1DJrb_yoW8Gr4fpF
	WjkrnYkFn7J3W0vw48Zw4xXw1fuanakF4DJFyrK3yrAr15Xr1agF1fKa4YkFy3Aw4fZw1a
	vw1av3sYkasxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/5 0:23, Michal Koutný wrote:
> On Tue, Dec 02, 2025 at 09:53:11PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> What do you think about this approach? If you have any suggestions for further improvement, I'd be
>> happy to incorporate them.
> 
> Yes, it's better due to the single place of definition.
> It made me to look around at some other filesystems from a random sample
> (skewed towards ones with more options) and I see:
> - many of them simply use the big switch/case in .parse_param,
> - ext4 has its specialized ext4_mount_opts array whose order needn't
>   match ext4_param_specs thanks to dynamic search.
> 
> All in all, I appreciate your effort, however, I'm not sure it's worth
> to deviate from the custom of other FS implementations.
> 
> Michal

Thank you for your feedback.

I also examined other filesystems, and you are correct—most do use a large switch/case structure in
.parse_param. However, none seem to have to maintain logic across three different functions like
cgroup does.

My intention was to avoid further expanding the if/switch chains, but given how many options we
already handle, perhaps a refactor isn't immediately necessary. We can leave it as is for now. If
mount options continue to increase, we might reconsider refactoring in the future.

Thank you again.

-- 
Best regards,
Ridong


