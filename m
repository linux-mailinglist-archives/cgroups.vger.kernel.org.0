Return-Path: <cgroups+bounces-2879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2AE8C5632
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 14:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C401C21AA3
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B8655C0A;
	Tue, 14 May 2024 12:51:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD12A8D7;
	Tue, 14 May 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691113; cv=none; b=bdHsAj5cV/tj2hXiuykFHm1l9+iBJHy3hc3gJ7piJ5YmoQ7jRi7GvorqIo9u845iumaFPPGoAdI8dAgdO+TDhR7RkLeEfQ6H/7Wm32/uNZJtdV2aqDSOIIPl64Kz1XATtrvoKrPCHAAU/29ZhZCXGjM6fPH90fJ3KqdfBcv9wtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691113; c=relaxed/simple;
	bh=aUbOwPaUPupYeFUaKwFn5yDwjguh9nzt7U4EFOp5KJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cCrwqHOVFJWy8ZkpTBeOCbRSPXuUkxkaPIleBm6hQyhZJQCwVgbXlGnbnxj0zQqg4Eq7BiMfZ9CrmXK+0wbVyDtckm3wd5oPl2CHnkd9YMksR5f/a4VZNUcYidbun1k14sIwurVQ2m1mFRIC/qOLr8luJjGh9k/dxMc2ZtqBDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vdx3d48ddzvXdj;
	Tue, 14 May 2024 20:48:13 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 71F4C18007D;
	Tue, 14 May 2024 20:51:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 20:51:40 +0800
Message-ID: <e0bc19d6-4a15-faa4-c8e1-163904276d5b@huawei.com>
Date: Tue, 14 May 2024 20:51:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/6] genirq: optimize irq_do_set_affinity()
To: Yury Norov <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Imran
 Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>, Peter Zijlstra
	<peterz@infradead.org>, Rik van Riel <riel@surriel.com>, Steven Rostedt
	<rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Waiman Long <longman@redhat.com>, Zefan
 Li <lizefan.x@bytedance.com>, <cgroups@vger.kernel.org>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-5-yury.norov@gmail.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240513220146.1461457-5-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/5/14 6:01, Yury Norov wrote:
> If mask == desc->irq_common_data.affinity, copying one to another is
> useless, and we can just skip it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/irq/manage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index bf9ae8a8686f..ad9ed9fdf919 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -285,7 +285,8 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	switch (ret) {
>  	case IRQ_SET_MASK_OK:
>  	case IRQ_SET_MASK_OK_DONE:
> -		cpumask_copy(desc->irq_common_data.affinity, mask);
> +		if (desc->irq_common_data.affinity != mask)
> +			cpumask_copy(desc->irq_common_data.affinity, mask);

It seems that mask is a pointer, shouldn't use "cpumask_equal"？

>  		fallthrough;
>  	case IRQ_SET_MASK_OK_NOCOPY:
>  		irq_validate_effective_affinity(data);

