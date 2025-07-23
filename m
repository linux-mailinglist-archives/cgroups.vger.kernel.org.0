Return-Path: <cgroups+bounces-8893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D001B0EA5A
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 08:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D91F7AE6C2
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A034248F4F;
	Wed, 23 Jul 2025 06:10:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0821DF270;
	Wed, 23 Jul 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251035; cv=none; b=bUy7fmSmW2fnDKX1UOxfauOR/EjNBKnoHNcMHqcQ7PE0VCdZ71n9iR1o2YeuT9fTepl60+RHew2cfHAoq+iiODiirTDcZMVr+08c40TonLq2o+BHrPvv/KpPlekgXKPHwnJNw7MRpjSSlWVeJ9QCaMRgoImfUQpyI8iQM8KBTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251035; c=relaxed/simple;
	bh=Up4e+Yh+TFp6xF5GI5N1UdKYKtDQiGnnMcm26vc0/HQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VcjoCLCYHGb7LbwCYFqjx6Wuj+Oyy+5OdC4+41TzRceXF/fJU1uKTdVvXkMnHAy4Oc6N3CXDGs733Ju4Z8A7M9ZQPUtu6rmfOULFHr3379hnUHWo8WlGSF+pW0MT6S6qEoqHzf6zaBHEaabB3B882QfcR9mu2k4dPkM7m39WP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bn3dv1xMfzKHMXH;
	Wed, 23 Jul 2025 14:10:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 00D631A058E;
	Wed, 23 Jul 2025 14:10:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgD3cNvPfIBoL_KwBA--.45357S3;
	Wed, 23 Jul 2025 14:10:25 +0800 (CST)
Subject: Re: [PATCH 4/6] elevator: factor elevator lock out of
 dispatch_request method
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-5-yukuai1@huaweicloud.com>
 <08c989bd-20d8-476c-af99-c9eb8065349d@kernel.org>
 <cc6f72cb-3782-4426-57c2-4d54fc4f38f2@huaweicloud.com>
 <d32d44ef-a964-430a-a735-f63f2fa5e7ed@kernel.org>
 <2b48b0eb-7294-c4e1-8b84-ce2e860f3a75@huaweicloud.com>
 <352c67be-b39e-4372-9f69-f942b0a9818d@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <36056c2f-f0c3-5758-3848-ca06371a6241@huaweicloud.com>
Date: Wed, 23 Jul 2025 14:10:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <352c67be-b39e-4372-9f69-f942b0a9818d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3cNvPfIBoL_KwBA--.45357S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1fKw4xur15JF18JF1fJFb_yoWxZFg_Z3
	y3t348G3WUJr1SqF4jyF43tr4xKayrWry5Gr1ktw4rXFWUuFZ0qwsYvr17Ar1UtFWSyas3
	Awnxuw40v3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/23 12:34, Damien Le Moal 写道:
> What about something like this:
> 1) Introduce the elevator common/generic lock (first part of patch 1 + middle
> of patch 4 squashed together)
> 2) Convert deadline to use elevator generic lock (second part of patch 1 + end
> of patch 4)
> 3) Convert bfq to use elevator generic lock (patch 3 + beginning of patch 4)
> 4) Patch 6
> 
> As for the ioc changes, they do not seem directly related to the elevator lock
> changes, but since the code may conflict, maybe bring them as prep patches at
> the beginning (0).

This sounds good. BTW, the ioc changes has to be in front of step 3), to
prevent queue_lock to be nested in elevator lock.

Thanks,
Kuai


