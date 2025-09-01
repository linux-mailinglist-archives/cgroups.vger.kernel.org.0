Return-Path: <cgroups+bounces-9520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B986B3D64F
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BCE177602
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E41F3BBB;
	Mon,  1 Sep 2025 01:29:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5F18027;
	Mon,  1 Sep 2025 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756690148; cv=none; b=iVafnO2eJpT06FikRZMfcbEWnQVbfEZbkvFjo3EgB4j2a/PcU94qtYItiHtkypFJ31X3bmIKVOcV9ogx5PTEW3/oeY4G8EuO2pfcanmNPPA6RFYMK00GoHLLSEjy9uuK29iRVlDkBDas3A+eN1xUgphhY97bn71FF9VgU6gTFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756690148; c=relaxed/simple;
	bh=OykKnMQUBLLM8S9sa+VO88UG8Iy3AxdPViOOGY5vWdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hm+x+uwhV28hjQk/yZ39liGeInf6SRJSCc2Pwo2+4nf3POdVn5f1/izEvf289vITjRPrlLxNO1l2sx61vGRc1zrcu2oDbscr/hRmmCLa5RzLBrWtLVQG8LnHsJ6MSMYecSd6P+2de8j6k4CrfKbqLCeX+KuhPTcRZKS3ubYLxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFWVm3QmKzKHMf9;
	Mon,  1 Sep 2025 09:29:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 488EB1A0E45;
	Mon,  1 Sep 2025 09:29:04 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAn5nve9rRo2fXYAw--.36778S2;
	Mon, 01 Sep 2025 09:29:04 +0800 (CST)
Message-ID: <9da518ad-9b44-4dbb-98e5-66cf8a3fe7c2@huaweicloud.com>
Date: Mon, 1 Sep 2025 09:29:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn5nve9rRo2fXYAw--.36778S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xCrWDAF1UJF4fWFy7Awb_yoW8Kw1kpF
	18Arn8JrWUJrs7Gr1Ut342qryrJry8Jw1UJr1UGa48JrW3AF1qqr1xur1j9F15Jrs7Wr17
	AF15JryUZry7XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/30 21:30, Gustavo A. R. Silva wrote:
> Hi all,
> 
> I'm working on enabling -Wflex-array-member-not-at-end in mainline, and
> I ran into thousands (yes, 14722 to be precise) of these warnings caused
> by an instance of `struct cgroup` in the middle of `struct cgroup_root`.
> See below:
> 
> 620 struct cgroup_root {
>     ...
> 633         /*
> 634          * The root cgroup. The containing cgroup_root will be destroyed on its
> 635          * release. cgrp->ancestors[0] will be used overflowing into the
> 636          * following field. cgrp_ancestor_storage must immediately follow.
> 637          */
> 638         struct cgroup cgrp;
> 639
> 640         /* must follow cgrp for cgrp->ancestors[0], see above */
> 641         struct cgroup *cgrp_ancestor_storage;
>     ...
> };
> 
> Based on the comments above, it seems that the original code was expecting
> cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
> memory.
> 
> However when I take a look at the pahole output, I see that these two members
> are actually misaligned by 56 bytes. See below:
> 
> struct cgroup_root {
>     ...
> 
>     /* --- cacheline 1 boundary (64 bytes) --- */
>     struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  2112 */
> 
>     /* XXX last struct has 56 bytes of padding */
> 
>     /* --- cacheline 34 boundary (2176 bytes) --- */
>     struct cgroup *            cgrp_ancestor_storage; /*  2176     8 */
> 
>     ...
> 
>     /* size: 6400, cachelines: 100, members: 11 */
>     /* sum members: 6336, holes: 1, sum holes: 16 */
>     /* padding: 48 */
>     /* paddings: 1, sum paddings: 56 */
>     /* forced alignments: 1, forced holes: 1, sum forced holes: 16 */
> } __attribute__((__aligned__(64)));
> 
> This is due to the fact that struct cgroup have some tailing padding after
> flexible-array member `ancestors` due to alignment to 64 bytes, see below:
> 
> struct cgroup {
>     ...
> 
>     struct cgroup *            ancestors[];          /*  2056     0 */
> 

Instead of using a flexible array member, could we convert this to a pointer and handle the memory
allocation explicitly?

-- 
Best regards,
Ridong


