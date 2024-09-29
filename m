Return-Path: <cgroups+bounces-4981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C99892B9
	for <lists+cgroups@lfdr.de>; Sun, 29 Sep 2024 04:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA829B23B02
	for <lists+cgroups@lfdr.de>; Sun, 29 Sep 2024 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862518AEA;
	Sun, 29 Sep 2024 02:38:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355E18EAB;
	Sun, 29 Sep 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577517; cv=none; b=e1cVjNhU7VVKrBd4FERksA/l502KBFAYVOnorD8r0q8p1z18qYKcoID84JC+Nw2H1MndYm9Y2Ikcldbr0Tb5rSKFAPRHHegXn+ztXFuGCf4ZnWnZhPyVsMY/AmiHmRqfkWxv3AhHbzbV93XPl134N8DpcoKQglVwz9O2vFml+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577517; c=relaxed/simple;
	bh=nHlfBp6BkF9yN8JZZMdMt//MlWivT2rbZSjxxxCmdiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCE83hoh+gO+y/3j2UzhVvVpfCkVcuO4avv/i3Nv9wjZ7sgkaX4znvNt2mh/PyAQaxzA7whZz+5xQMml3t5B07A0CLIxLyLKxVme2L7kxmg1Ei109KbmYb/mndkRRc7L1vKykh/hGd3Ngo4AqjtP3c6YPdqn2dUx0JAb5zkiFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XGT0C4Ky8z4f3jkj;
	Sun, 29 Sep 2024 10:38:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EE9101A0C31;
	Sun, 29 Sep 2024 10:38:30 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBnki6lvfhmPBBECg--.64483S2;
	Sun, 29 Sep 2024 10:38:30 +0800 (CST)
Message-ID: <8492b8ca-cdbc-4177-b5fe-48f352d60528@huaweicloud.com>
Date: Sun, 29 Sep 2024 10:38:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] add dedicated wq for cgroup bpf and adjust
 WQ_MAX_ACTIVE
To: Tejun Heo <tj@kernel.org>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <ZvcN7O_UBNNQlnSz@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZvcN7O_UBNNQlnSz@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnki6lvfhmPBBECg--.64483S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAq
	zxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJ
	UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/28 3:56, Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 23, 2024 at 11:43:49AM +0000, Chen Ridong wrote:
>> The patch series add a dedicated workqueue for cgroup bpf destruction,
>> add adjust WQ_MAX_ACTIVE from 512 to 2048.
> 
> Patchset generally looks good to me. I'll wait for an updated version
> addressing Michal's comments.
> 
> Thanks.
> 

Thank you, TJ, I will update version if Michal thinks the "NOTE" is 
acceptable. I am waiting his reply.

Best regards,
Ridong


