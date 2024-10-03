Return-Path: <cgroups+bounces-5028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E598F331
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEE31C21E4A
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B91A4F08;
	Thu,  3 Oct 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWt9wwHC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40D15C0
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970594; cv=none; b=GMDnpN3URQneSnG/Qw+jzdJ212UoP5jX4JmhnZTOxNeXhPQ0v7cxQPXU0tCgyakgPMKfF7GKv+qfiYVqjNDxpKpTwhU+bOxRchiwPnUeJDQJH9urP8k7C4h5uo4VZK0IrbWT7Xd8nCnJWUmZsuk5xVPzFnT6qc7nh1ynxT1CwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970594; c=relaxed/simple;
	bh=HBoZKzlCgXMLWnSt5LsdPtOaqSCa/zCq3mpaSqju2i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRze7glTKWGzKKXA6T9BMhpV9/IlcA1OqiiE6+3XRXQ2/qCTqkXygmaNAkJerPn3OPkbaN5W8PgpBcO9a/J4r5rnXKr58z9h2Cqnmg3p0+XTR5bg5UnRqKmu1j3KiY/3NxNEXnUOPX/fyql80OB0MyIdBX2saEnnP/7C3yuNcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWt9wwHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727970591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/+JJP6IwNI/OgGJi3ENm7HucRM3TLm/O3z7U+CaXoE=;
	b=OWt9wwHCTln2cuSIq26ykpaoUc9ox3Hqnq3JWUbib0dzwWg12leRNu0GEqq8h7AIevzpin
	mynsjn+RTIqJiM0tc1c9g5r3HxHKSqoMu8mKhfMphlIJjBS/nmxlpzLXXt8eW4kOHcILFW
	y6E04f9o2HVYkGHwYX4I3Cug5yvssTo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-bp-PBI54OdSnzP37k9LIsg-1; Thu,
 03 Oct 2024 11:49:45 -0400
X-MC-Unique: bp-PBI54OdSnzP37k9LIsg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81DA41955F42;
	Thu,  3 Oct 2024 15:49:43 +0000 (UTC)
Received: from [10.2.16.72] (unknown [10.2.16.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 567801955E8C;
	Thu,  3 Oct 2024 15:49:40 +0000 (UTC)
Message-ID: <18f3929d-9a29-4734-8466-17fa9e528c8f@redhat.com>
Date: Thu, 3 Oct 2024 11:49:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Jens Axboe <axboe@kernel.dk>, Dan Carpenter <dan.carpenter@linaro.org>
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/3/24 10:38, Jens Axboe wrote:
> On 10/3/24 8:31 AM, Dan Carpenter wrote:
>> On Thu, Oct 03, 2024 at 07:21:25AM -0600, Jens Axboe wrote:
>>> On 10/3/24 6:03 AM, Dan Carpenter wrote:
>>>>    3117                                  ioc_now(iocg->ioc, &now);
>>>>    3118                                  weight_updated(iocg, &now);
>>>>    3119                                  spin_unlock(&iocg->ioc->lock);
>>>>    3120                          }
>>>>    3121                  }
>>>>    3122                  spin_unlock_irq(&blkcg->lock);
>>>>    3123
>>>>    3124                  return nbytes;
>>>>    3125          }
>>>>    3126
>>>>    3127          blkg_conf_init(&ctx, buf);
>>>>    3128
>>>>    3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
>>>>    3130          if (ret)
>>>>    3131                  goto err;
>>>>    3132
>>>>    3133          iocg = blkg_to_iocg(ctx.blkg);
>>>>    3134
>>>>    3135          if (!strncmp(ctx.body, "default", 7)) {
>>>>    3136                  v = 0;
>>>>    3137          } else {
>>>>    3138                  if (!sscanf(ctx.body, "%u", &v))
>>>>    3139                          goto einval;
>>>>    3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
>>>>    3141                          goto einval;
>>>>    3142          }
>>>>    3143
>>>>    3144          spin_lock(&iocg->ioc->lock);
>>>>
>>>> But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
>>>> fine.
>>> That's a bug.
>>>
>> I could obviously write this patch but I feel stupid writing the
>> commit message. My level of understanding is Monkey See Monkey do.
>> Could you take care of this?
> Sure - or let's add Tejun who knows this code better. Ah he's already
> added. Tejun?
>
>> So somewhere we're taking a lock in the IRQ handler and this can lead
>> to a deadlock? I thought this would have been caught by lockdep?
> It's nested inside blkcg->lock which is IRQ safe, that is enough. But
> doing a quick scan of the file, the usage is definitely (widly)
> inconsistent. Most times ioc->lock is grabbed disabling interrupts, but
> there are also uses that doesn't disable interrupts, coming from things
> like seq_file show paths which certainly look like they need it. lockdep
> should certainly warn about this, only explanation I have is that nobody
> bothered to do that :-)

The lockdep validator will only warn about this if a debug kernel with 
lockdep enabled has run a workload that exercises all the relevant 
locking sequences that can implicate a potential for deadlock.

Cheers,
Longman


