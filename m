Return-Path: <cgroups+bounces-5029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EB98F432
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 18:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8782810A7
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0B1A7242;
	Thu,  3 Oct 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J9gCZ+qw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B01A4E9F
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972701; cv=none; b=il6htC0G6Zv8PTNKPq7MqhuATfHQrf2G63TwgJgUBgI0ZIKnzxhFQDQypoUqHWMKBDxaHr7JuFwCud4sl7j57NiFNYwGwUpucCCY22HzzD5jrS0Syw8AHsLlnZhGhOJH18pFQpNWT1j8sdANbst/TN9nr9OWgwuuNVKsDPsILPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972701; c=relaxed/simple;
	bh=c5mSYg2XdXcMDSZiWGIRL3DxU7U5Bp8mr4gN1KrOFoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCLd4rEm9d0ksue6CjEjexueVYICNFamZ/tWwnftmS9QJG1VJNqMIDuizyGYUzrH/e9GmdzzI8MHjqKhMtaz+0oXx1Y10VNA20ygpFqMRWdUD+ZzicMZmOLZb1MuQb8VNF0L8g5KfeBuSHEgVG4Ameh1LUURuDJlEBLSiBlI6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J9gCZ+qw; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso5642955ab.2
        for <cgroups@vger.kernel.org>; Thu, 03 Oct 2024 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727972699; x=1728577499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+yGl+395qWZ7t+tFCw2BHFnWs4Q2FUHCtqlVqKTNS8=;
        b=J9gCZ+qwVfIUAVk/jv0G/yo734e1bIzBJAe8NSajCPyVRjg+64gi5LPkkXzSHOJtOp
         ed1Dq72JjTi0CrhjihwYvos+XsiZ6f4bjRL51nVa7E1QigFTplyAUiwfyPApVxAk4192
         eN1ozSr2NjVNEe+gcXs8xihc3SSfcpEL+yI+eDO38Nz/MTWgeDouCT3kYEI2CZEBd3Li
         I0Xol+vKO4csdNX1I4N3em1H3/YKZcXe3p+BpWHDIdRypt2WZNKvPiVXsQyMxuKX3mSF
         9XnInmC0pp2UU2U0TznoerNPmvJq9PNES6wHM7rPY+DiWhQoXwmG3OXp7xtFb3ctDNoI
         KOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972699; x=1728577499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yGl+395qWZ7t+tFCw2BHFnWs4Q2FUHCtqlVqKTNS8=;
        b=MIfsHYZkwFCK+sQuxymQXoaYhNPg/NKXvu3xf3MaKCdtoi4QvdeALbC6UN1svMcEJT
         Xgnbf5VaXtWryHK4bo3PvObTgvOJy27gS9hmtR2yY0x0gcng8LYNvzRafms+TOvEq1Oc
         uopzwVmFvAiuACGEnoioBxfArseOpwhKcuY0DhVlKVkYrYpji9j1QIyBm7/XfCj2XJul
         A3LJrqYEi8YrU/xC2vNpVFzYyqkj+wGCFRbKPOfGVClszyOiaztL7Ijilm0gE7fTuffG
         jpP7GHtg7yZXpSmIaxBjruNbykIIOvnfEyy+RMQzayklOhOdmZ4GHxW1M9oQF5PXwg8Y
         l//Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQxUSvejqWiP/5yW6R131HuNDgYInFCw1kelJ5EufyGcxFRGjJUyza9EfrDH0QNkQdyncClWiB@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPmdrB2XCmW83A42yffa1T5qH+WuVdL11aoBUk8nUp9/yOP6s
	r4LOQ/NuKTkxBochQYLofRUvUiqJPxPd7E3yYbcJ0TiCWuzaiNA3xHnqZ003TuU=
X-Google-Smtp-Source: AGHT+IHPHazpOyRbzZD4+kLYjx9YhtxEXpdGJcxROwVFolHJwJUSsxkoWyXjVw8cOOIufMuVL0SK2Q==
X-Received: by 2002:a05:6e02:216c:b0:3a0:ae35:f2eb with SMTP id e9e14a558f8ab-3a365949f2dmr66621155ab.19.1727972698666;
        Thu, 03 Oct 2024 09:24:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55860e18sm334522173.22.2024.10.03.09.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:24:57 -0700 (PDT)
Message-ID: <00c60d28-15ee-49e3-aa53-b214029f390e@kernel.dk>
Date: Thu, 3 Oct 2024 10:24:57 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Waiman Long <longman@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
 <18f3929d-9a29-4734-8466-17fa9e528c8f@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <18f3929d-9a29-4734-8466-17fa9e528c8f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 9:49 AM, Waiman Long wrote:
> On 10/3/24 10:38, Jens Axboe wrote:
>> On 10/3/24 8:31 AM, Dan Carpenter wrote:
>>> On Thu, Oct 03, 2024 at 07:21:25AM -0600, Jens Axboe wrote:
>>>> On 10/3/24 6:03 AM, Dan Carpenter wrote:
>>>>>    3117                                  ioc_now(iocg->ioc, &now);
>>>>>    3118                                  weight_updated(iocg, &now);
>>>>>    3119                                  spin_unlock(&iocg->ioc->lock);
>>>>>    3120                          }
>>>>>    3121                  }
>>>>>    3122                  spin_unlock_irq(&blkcg->lock);
>>>>>    3123
>>>>>    3124                  return nbytes;
>>>>>    3125          }
>>>>>    3126
>>>>>    3127          blkg_conf_init(&ctx, buf);
>>>>>    3128
>>>>>    3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
>>>>>    3130          if (ret)
>>>>>    3131                  goto err;
>>>>>    3132
>>>>>    3133          iocg = blkg_to_iocg(ctx.blkg);
>>>>>    3134
>>>>>    3135          if (!strncmp(ctx.body, "default", 7)) {
>>>>>    3136                  v = 0;
>>>>>    3137          } else {
>>>>>    3138                  if (!sscanf(ctx.body, "%u", &v))
>>>>>    3139                          goto einval;
>>>>>    3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
>>>>>    3141                          goto einval;
>>>>>    3142          }
>>>>>    3143
>>>>>    3144          spin_lock(&iocg->ioc->lock);
>>>>>
>>>>> But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
>>>>> fine.
>>>> That's a bug.
>>>>
>>> I could obviously write this patch but I feel stupid writing the
>>> commit message. My level of understanding is Monkey See Monkey do.
>>> Could you take care of this?
>> Sure - or let's add Tejun who knows this code better. Ah he's already
>> added. Tejun?
>>
>>> So somewhere we're taking a lock in the IRQ handler and this can lead
>>> to a deadlock? I thought this would have been caught by lockdep?
>> It's nested inside blkcg->lock which is IRQ safe, that is enough. But
>> doing a quick scan of the file, the usage is definitely (widly)
>> inconsistent. Most times ioc->lock is grabbed disabling interrupts, but
>> there are also uses that doesn't disable interrupts, coming from things
>> like seq_file show paths which certainly look like they need it. lockdep
>> should certainly warn about this, only explanation I have is that nobody
>> bothered to do that :-)
> 
> The lockdep validator will only warn about this if a debug kernel with
> lockdep enabled has run a workload that exercises all the relevant
> locking sequences that can implicate a potential for deadlock.

Sure that's obvious, but there are quite a few easy ones in there, so
seems like it should be easy to trigger. It's not like it's only some
odd path, the irq on/off looks trivial.

-- 
Jens Axboe

