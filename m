Return-Path: <cgroups+bounces-5016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453D98E2B8
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 20:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD961F2356D
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD853215F6F;
	Wed,  2 Oct 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9sR/nv9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE92141B9
	for <cgroups@vger.kernel.org>; Wed,  2 Oct 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894468; cv=none; b=uq/Rfc7iFFTXGiD/n0dG3yjBQl7uvZriUjzux00sBmIKhX2PBBjwD+6uuldOJkqLAHHsD5CaErzYEbw0yK38pfsuc3JgSilkV16clNILoR8hgp6NvRXT18IW+GvgF5qDCQ8CHyimLSA7ak+rknUEMMhnmDEIGuzSYmnisXgOvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894468; c=relaxed/simple;
	bh=bpOJuwowU5pcBj4CeZ4iNAwG25deYeg+BobQloU177g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJzxSUUKXeLBsZt4ui1C6bqWXc62C13PmdhP80rvYBX7yIon9PjPBRAcrQ3yVDHzR7/6zu4WIuiEvUt8vivf4yLA3BupDUfk4WOqCLCaINPbazQy4ZKOC3YPNpWeUTCUier8r8/2cUz/gnuB+l4NCkPfS93D0nOJadAmGC/4AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9sR/nv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727894465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTuzt7MudVm/im7bgwfdRJU7jZDhH0Q0EoPoVe+9Wnc=;
	b=U9sR/nv9ZouuKiet6OGkShwAjGrZuUFfwRs/rFl6r4SiA7cIk99KQpitfhC7qLmjwkiVax
	Gx4UJKW6tXBd8ilFylt7uKuTVdyoLbhLbjEO3xTR/yK4Suj0wphdNqAykZBQ3nv1fcrnfx
	MR/kOU9GVIJOnR14N2E+lKL9/FQ5srQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-Pfv_BZlHOpa4KH7Pm4HH-w-1; Wed,
 02 Oct 2024 14:40:57 -0400
X-MC-Unique: Pfv_BZlHOpa4KH7Pm4HH-w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BDB21955F44;
	Wed,  2 Oct 2024 18:40:55 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45C3619560A2;
	Wed,  2 Oct 2024 18:40:53 +0000 (UTC)
Message-ID: <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
Date: Wed, 2 Oct 2024 14:40:52 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 10/2/24 14:10, Dan Carpenter wrote:
> On Wed, Oct 02, 2024 at 01:49:48PM -0400, Waiman Long wrote:
>>> -	spin_unlock_irq(&ioc->lock);
>>> +	spin_unlock(&ioc->lock);
>>>    	return 0;
>>>    }
>> I would suggest adding a "lockdep_assert_irqs_disabled()" call before
>> spin_lock() to confirm that irq is indeed disabled just in case the callers
>> are changed in the future.
> It's really hard to predict future bugs.  I doubt we'll add new callers.
> Outputting this information to a struct seq_file *sf is pretty specific.
>
> If there were a bug related to this, then wouldn't it be caught by lockdep?
>
> The other idea is that we could catch bugs like this using static analysis.
> Like every time we take the &ioc->lock, either IRQs should already be disabled
> or we disable it ourselves.  I could write a Smatch check like this.
>
> KTODO: add Smatch check to ensure IRQs are disabled for &ioc->lock

This is just a suggestion and it is fine if you don't think it is 
necessary. The call can also serve as a comment that irq should have 
been disabled at this point.

Cheers,
Longman


