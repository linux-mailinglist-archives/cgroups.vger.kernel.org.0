Return-Path: <cgroups+bounces-4939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2854983BA8
	for <lists+cgroups@lfdr.de>; Tue, 24 Sep 2024 05:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D521C215BC
	for <lists+cgroups@lfdr.de>; Tue, 24 Sep 2024 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C718E1F;
	Tue, 24 Sep 2024 03:49:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3341B85D6
	for <cgroups@vger.kernel.org>; Tue, 24 Sep 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727149763; cv=none; b=cGa4+NOD81WVazsm/yJGKYMWe8gn9yYgFckrRxOnm+5s2rzq2qI0qZN7hR4FOxF26xzML0cEyCkC9Ods9bXaJ+q1UCcxKg3q/NVY5g8OKMmZ5dJpGjvdAqgzXyFXvT6EW1J4P4ErUjlFQMj+iAM26mLy/K4My7NPS3SoMePpeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727149763; c=relaxed/simple;
	bh=zb2x+dDjJ+Qmh/0eH3GDFHNw9Dou8cXxIakBcuXQb/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuqFoA0MqTWjJ1psbsB6/iUoo1BnkaA2FqFghUaUDZ6CVAvTFBY+cbBoS/egUT042rb4E2B8NuxoDNVBSEs+OlNih0RUgteDmpoLGjFIRgDzgWuH9zDVgAZF6fV0qXsLZtt+t6O6u4ozvL6zSj2bn+Au2IlRpMnD/XlohuVyHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XCQp4447Xz4f3jdS
	for <cgroups@vger.kernel.org>; Tue, 24 Sep 2024 11:49:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B371F1A0568
	for <cgroups@vger.kernel.org>; Tue, 24 Sep 2024 11:49:16 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgC36sa7NvJmo3vBCA--.29008S2;
	Tue, 24 Sep 2024 11:49:16 +0800 (CST)
Message-ID: <345d9498-f36e-4fcd-a0d6-3e4a7379214e@huaweicloud.com>
Date: Tue, 24 Sep 2024 11:49:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHC v3 -next 0/3] Some optimizations about freezer
To: Tejun Heo <tj@kernel.org>, chenridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
 adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com, guro@fb.com,
 cgroups@vger.kernel.org
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <d9a9186b-8b4b-4ead-8e39-83b173539f3e@huawei.com>
 <ZvGLAwzherQwdP_P@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZvGLAwzherQwdP_P@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC36sa7NvJmo3vBCA--.29008S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/23 23:36, Tejun Heo wrote:
> On Mon, Sep 23, 2024 at 11:37:14AM +0800, chenridong wrote:
>> Friendly ping.
> 
> Will apply after the merge window.
> 
> Thanks.
> 
Thank you.

Best regards,
Ridong


