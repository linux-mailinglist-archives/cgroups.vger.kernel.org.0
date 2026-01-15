Return-Path: <cgroups+bounces-13234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F0D22706
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 176903028450
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AC22AE45;
	Thu, 15 Jan 2026 05:33:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8D1391;
	Thu, 15 Jan 2026 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768455186; cv=none; b=opAERmdExn7UFgCRHoBJqcLNCXauO7+kTbwXedPjXJWM8JZpAmCmyNhBbdDbE5Kr99+KdUvoM4hH3aUnoPHiJhj3OAdNsfNggs9KyN51NGDp23k3YvAEzekdKO1cKcMBJHMknHul8vZ9YQiB1YQfhs44Nlo84Cj5qvtvgCCuJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768455186; c=relaxed/simple;
	bh=c5y1K8Iw/JBlnaServwJ53zjp00ciMj2On1YPP2ODNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdTwXBxLa9XiONmk/uGuvL+hQ6PMbkQ3IilYX2LME9xeAeMkwuagtK6gTxjFtry1TV0vAlIh9q/vidZNsIfNnAewFRCqk0k4JiBo0qmuQnN244QXvy/0MTCy7FLv62wov6lgbSRR4BySJSWdW1Kc9T2SY/QgH3zqcH/RdjOzwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dsBSS2005zKHMQK;
	Thu, 15 Jan 2026 13:32:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 641784056B;
	Thu, 15 Jan 2026 13:33:01 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgAXxfULfGhpImBxDw--.58413S3;
	Thu, 15 Jan 2026 13:33:01 +0800 (CST)
Message-ID: <2685a1b2-9c68-4b14-87bc-96c19a0a2e48@huaweicloud.com>
Date: Thu, 15 Jan 2026 13:32:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation and
 blkg destruction
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
 hch@infradead.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, Zheng Qixing <zhengqixing@huawei.com>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
 <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXxfULfGhpImBxDw--.58413S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Resend...

blkcg_activate_policy()                blkg_free_workfn()
-------------------                    ------------------
spin_lock(&q->queue_lock)
...
if (!pd) {
     spin_unlock(&q->queue_lock)
     ...
     goto enomem
     }
enomem:
     spin_lock(&q->queue_lock)
     if (pd) {

                        ->pd_free_fn()  // pd freed

        pd->online // uaf
        ...
     }

                        spin_lock(&q->queue_lock)

                        list_del_init(&blkg->q_node)

                        spin_unlock(&q->queue_lock) 


