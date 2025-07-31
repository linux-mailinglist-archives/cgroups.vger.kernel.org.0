Return-Path: <cgroups+bounces-8963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B33B170B9
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ABB1899E27
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3AF2C374B;
	Thu, 31 Jul 2025 11:53:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61482C3246;
	Thu, 31 Jul 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962789; cv=none; b=tH0DzBmmpgU1In9C5Dno0GHjJseDMtVROhTUmucvwx/bORsVsGjWQ+oWgOJy0ahMZdkPzc7dQ9ysYHsYLgc9zFdbW3QsiJRDkUncCaVNt4zDH4obSTkrJRMsnTcXZRbXnQ0Qij2QHlv4Dn0wTwLTu+oudosdZ9ji2wHNPwGWGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962789; c=relaxed/simple;
	bh=4gSaWiwQEZvY2HR0uoKh1Gfjy+aPzU3Hy9DmKDta9JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqfYyOzXt+fZmIOCW0iv0hp2fXFJ/3K2TE0RbuWYNywWUUKFkhVMG6RnFXvHwWFzGHv4mXW7JRpDTiGVfDzS032ih9TTOFn2Yu7UFGcy6ULDE87DCif/bH75sl70bvjcrVg5RVAmLURc/vhk5wkedu80TR8GiPLjIqeo4Y6OIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bt6sY2cd8zKHMl3;
	Thu, 31 Jul 2025 19:53:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 45EF61A0B51;
	Thu, 31 Jul 2025 19:53:04 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCHAdweWYtoViA_CA--.22541S2;
	Thu, 31 Jul 2025 19:53:04 +0800 (CST)
Message-ID: <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>
Date: Thu, 31 Jul 2025 19:53:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHAdweWYtoViA_CA--.22541S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAq
	zxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/


> I acknowledge the issue (although rare in real world). Some entity will
> always have to wait of the offlining. It may be OK in cgroup_kill_sb
> (ideally, if this was bound to process context of umount caller, not
> sure if that's how kill_sb works).
> I slightly dislike the form of an empty lock/unlock -- which makes me
> wonder if this is the best solution.
> 
> Let me think more about this...
> 
> Thanks,
> Michal

Hi Michal,

Have you come up with a better solution for this?
Would appreciate your thoughts when you have time.

Best regards,
Ridong


