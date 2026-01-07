Return-Path: <cgroups+bounces-12950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E2CFFE02
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2692E300949C
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAD318BBC;
	Wed,  7 Jan 2026 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+5UJpAh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPQoEvvw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E513016F5
	for <cgroups@vger.kernel.org>; Wed,  7 Jan 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815834; cv=none; b=gonvppgHuUdTfZq1iVkCV+LFbiw5gW2tLbcfcFyDHqsnOlzqRJzlmhudgoEdmYJyf+ayf45LbnH/3aXpt7nMSX6J3+se94ynilbWtV4+daA+qo38FvblSWfpjvv9Y98zBHnsJ6U7mkh8Wx/pGw0nwHoy9naT1JyLObWWdxc5PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815834; c=relaxed/simple;
	bh=6KkNeExA7CKywiEokQ1a0mgoybRkOeNnvWya3+2zXy8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g/Hf2ZmxguDakyGyIV02qYrrtVvMy/9RZND3pKVnYvgOI+KOUb+zEEFklmFkbDq7+emaCdjVJe4uBv2Ygtrwaom8a4ysc2Qhxkm0btRmpPqy9tS2Xs3dbwkChedg3xvVYYzaPdQ4Km1Mah+R9qqEJ0Rk4uZieH3QZwXrvmocTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+5UJpAh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPQoEvvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767815831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98wbyDYOiVM9lVvm96PIUZwPmx3Asqpf8X6e4K1BRHU=;
	b=b+5UJpAhoBEprm3P9Vu5/t37SuH6SmzrfAbMky29BtZo5V8OJiQGtrvYWEBiMG9W7J5Vsc
	vkJJYWiM7UJpqaafI8tyoDFXG2FULlG0ZBuxqlH8PtVfzJcNRhgUpDszDmrR9JC7Kxeneg
	cvLsbw6kNT+/McsRkWZASspj48OWP24=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-fBajg_WqMyqafMxNIp6o3A-1; Wed, 07 Jan 2026 14:57:09 -0500
X-MC-Unique: fBajg_WqMyqafMxNIp6o3A-1
X-Mimecast-MFC-AGG-ID: fBajg_WqMyqafMxNIp6o3A_1767815829
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-55fc5f8498dso2098528e0c.3
        for <cgroups@vger.kernel.org>; Wed, 07 Jan 2026 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767815829; x=1768420629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=98wbyDYOiVM9lVvm96PIUZwPmx3Asqpf8X6e4K1BRHU=;
        b=UPQoEvvweG2qf4+jJiNWCm9emX15loDiACTp9snDgzCRsnbYHmWZsVeirbMQDaLdcB
         +fK+u6A7hB2wbnqff3Y0djlEkmZMEMKT7Hb/EVZ68Hzag6IZ4NOp+OpJwtIROxASna2s
         ix0Q7+86ByLJRUtdU9Xzlenatg4ax1PGjH7GUZ5+/g7RtGX89gmwCgJz3ZvNpHP5kCkc
         EP1f4u0+z50jicR2KezMSB7dpjBqu8eUTB/LpiSTvdtKv38jcySlsK3inmdGbJkNR0jR
         iLafn0We/PpYz1ljdYypoQprY2Sj0SLCL59Koq4xfRfrrEFcEyc2HOqbMOVpjHbxm+jw
         QBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767815829; x=1768420629;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98wbyDYOiVM9lVvm96PIUZwPmx3Asqpf8X6e4K1BRHU=;
        b=boUkn5nZgAVkPnuw2nF8wM+OGi/6SVHoGT7G67A7RT43mGw3mLwRIIU9tcuBSHhPXu
         8BqJ0OEa7n0h/w4qz4FLHhhRVgjh4qOTLlpkPXXVCNoOWgzRo514T/MiojdlR9AqZ7Qe
         awDyeWAaKu2t/o18D/jMKBJ7xbjjWRrMuwafCF92BHwauFZcFlZeimT4ODhQ7hJYTJpu
         cD2YoPDUwow9dFlCBWIH68sgjJQlCOA38PJzhAhz3ZUF6X1UV803Vl/HOQuZvSlC7Yib
         2FmymXdz7iRDBRMob/G0Xv4E+QG3iOOgwYWdyxlJQ8Pym62fU5NOMnn/X6aYxuMrV+6o
         cCZg==
X-Gm-Message-State: AOJu0YxFAG/630RiBBAp+6aSCmSuouLynzaKmJSkhqSpRgt3MyRPVGDv
	OMidRagTwK/BpL5TKycT5gacqXJqLWiMaXg05KY72q/ZyJjdusu88k1ZcDR1O+GwLVHo3fIs/P8
	kTpXcLgWkVq4WyDMNuBM4qNRPNK5qHSeDYv/Iye5IUXUJqgi0u4mSYwxQs1A=
X-Gm-Gg: AY/fxX6BJdqVFYmY6SUPvJw29G7msiB2HbwmLqD/0EuQAhhzDq+U+RD7RknGWhB+POO
	QIAffbpHgBQRztK4uCST7KerMXiElvkzm4CvpSnDXSEippBVx3O6pfZpW/fb+C+9y+mP0KKcSxm
	+rOBq6QH5A4lJYRs+JpYj0IalnnxIXoufqpvfN/SgUqIcmYqyhnJk4TZh2ekrMZZvABfWvftqn8
	SdmPuTdQaq6PvYxCZOmRsMgWxVvgeJmH4PpK0b5MV5dE895IdXC6j1FbtDeH4102Y4+ARHumrpt
	ebFc54Sm3XNI9sx/kUMEh9/H0/mgkil+19zF9DUb37A+Y6zPcI/JPXPVDNfK9s4+C3SfkfrQlF1
	70Z5uhMRyaLycvAfDa5iYoIpN5NIOzPpj5+vGti5e2ie1qw2OHWQ2h59s
X-Received: by 2002:a05:6122:8d4:b0:559:6b7f:b110 with SMTP id 71dfb90a1353d-56347d3a261mr1539013e0c.2.1767815829389;
        Wed, 07 Jan 2026 11:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG0X3qf/hyMn6mBbAMEAUok+y9+txGhueuwDwjIhfkqolDutAjKTI0pytjF+WHbiJLH/hybQ==
X-Received: by 2002:a05:6122:8d4:b0:559:6b7f:b110 with SMTP id 71dfb90a1353d-56347d3a261mr1538995e0c.2.1767815828965;
        Wed, 07 Jan 2026 11:57:08 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633ad02b3bsm3973267e0c.2.2026.01.07.11.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 11:57:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9deefb73-fb3a-4bb0-a808-88c478ea3240@redhat.com>
Date: Wed, 7 Jan 2026 14:57:00 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Pingfan Liu <piliu@redhat.com>
References: <20251119095525.12019-3-piliu@redhat.com>
 <20251125032630.8746-1-piliu@redhat.com>
 <aSVlX5Rk1y2FuThP@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <aSVlX5Rk1y2FuThP@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/25/25 3:14 AM, Juri Lelli wrote:
> Hi,
>
> On 25/11/25 11:26, Pingfan Liu wrote:
>> These two patches address the issue reported by Juri [1] (thanks!).
>>
>> The first removes an unnecessary comment, the second is the actual fix.
>>
>> @Tejun, while these could be squashed together, I kept them separate to
>> maintain the one-patch-one-purpose rule. let me know if you'd like me to
>> resend these in a different format, or feel free to adjust as needed.
>>
>> [1]: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
>>
>> Pingfan Liu (2):
>>    sched/deadline: Remove unnecessary comment in
>>      dl_add_task_root_domain()
>>    sched/deadline: Fix potential race in dl_add_task_root_domain()
>>
>>   kernel/sched/deadline.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
> For both
>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Peter,

Are these 2 patches eligible to be merged into the the scheduler branch 
of the tip tree? These are bug fixes to the deadline scheduler code.

Cheers,
Longman


