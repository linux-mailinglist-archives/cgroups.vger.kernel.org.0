Return-Path: <cgroups+bounces-5583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF029CF594
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 21:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2E31F22398
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE861E2306;
	Fri, 15 Nov 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEl/Y8WR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C51D90C8
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701802; cv=none; b=PrfLH+K0rNgkbFfKSRCV3lGSRYFWJ7T2VLGO7MPCdtZNBMfTcbUdu+n7oZseTMNSRG4z3kbXErUZAbcqMrpiBnrhLtipNgHMu2lbSU+W2i4noSXFysg+7UXlUZShtVFGyJHm/o92bkbUUds3dLTvslHV+yL4ahtVZTyN68l6giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701802; c=relaxed/simple;
	bh=1SznUmdqtZegKerQ3VgWTpXRnwOhIQ/2Dr8SUd0yV3Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YOFZkmnxqocOSUQJtYlgbNCmC3jDPeX++7+jiTilbn8TMXxyitSC/0yhwyMMb19BZxPTTHVfoAC+1r2yZb7J1jhBUEEu9sPOXuKyAamW6wqprGJPTZf9VmlBTiPR3HaI5AygxmkM13FpxY2MDu5KMedkxNt796C/Z82dIZ0SyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEl/Y8WR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731701799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
	b=bEl/Y8WRQEcQUC2Dtc/fzk9Q/6fCQkz2zj/q2jVh/JXVALeCpYeDTbJqDFNF+mnGZTDh5F
	K4xBVFL2sWFnIq0xpIPCX12yFNMfFVBbAsei911uQ331lhOOM2ufI/7uW4BfOZrozH9QFv
	ss+rKLM0hLNCcOJ1Nxl4+Ug8mLN396o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-CtDAlgk9NwuR41gbLohdiw-1; Fri, 15 Nov 2024 15:16:38 -0500
X-MC-Unique: CtDAlgk9NwuR41gbLohdiw-1
X-Mimecast-MFC-AGG-ID: CtDAlgk9NwuR41gbLohdiw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460b71eb996so27703421cf.3
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 12:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701796; x=1732306596;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
        b=l8aPZYxAkLVwxpwo9CIghsxskp5lqsSBAyxKKMiZEUmB8GHlBoO3TpzRaxrWd2ZbkI
         NHYnkhHO3v0xai3wwS1e28xFpz8QmHafkuWRX/23yDERP6mHP7H5yc+fDEdHjtrfa4HQ
         2m6nii4j7bg3m5tIus23OdvkZuYvL09kq+VUfa8uYl3bx9Y4sB17b1FInB9QSApG9dnC
         f+nkmCu1xr7ZzkGwVptBm0oj1m/5k4quBq/aGahIgDkDwjqUKhMMY6MgJhaWbzQzy0X0
         H+cnyZZQcHHoMhvlyBqMrtKgeNEI6Cx8XAUN1hVjxrLNGESaJtKxGjlBp7IIHwLwNB28
         GVzw==
X-Forwarded-Encrypted: i=1; AJvYcCXnU2nEnbZGVjlVJUX9E42OFJSyVQAsrga3SrjJgkajRhpq8JsfLdP7KmM+O64n3XezjRjclxav@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIn43aiS4In+/y4JO7Eii88i3Q/V0x2eEJHQ/nB/hHApErz4N
	/8dBrdrJTgeF/KR8KFdhFNcO6lxaNchueQAVDjs+ITgTEQj0VHfXPNo/iy4UF6nYEvTTHz08rs0
	wXwyC+DoNGgQQvqGqhlYvfZxKrKkg/wx/oEZEWtU+P5NG+a+jxgfDeD9h2rRZotw=
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44684091cf.21.1731701795693;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERnY+JbNXc4WeIlKHasy1jkDmzupHTdQb4rkdAIssWtSl07qv5EwwZHB2cPIgwgHVNBb/tLA==
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44683821cf.21.1731701795305;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9cc353sm23604461cf.18.2024.11.15.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 12:16:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a840176f-2a46-4a2f-b48f-9eab40e542f9@redhat.com>
Date: Fri, 15 Nov 2024 15:16:33 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
 <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Language: en-US
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/15/24 10:45 AM, Michal Koutný wrote:
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redhat.com> wrote:
>> Cgroups allow configuring isolated_cpus at runtime.
>> However, blk-mq may still use managed interrupts on the
>> newly isolated CPUs.
>>
>> Rebuild hctx->cpumask considering isolated CPUs to avoid
>> managed interrupts on those CPUs and reclaim non-isolated ones.
>>
>> The patch is based on
>> isolation: Exclude dynamically isolated CPUs from housekeeping masks:
>> https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?

The cpuset had already been changed to take note of the statically 
isolated CPUs and included them in its consideration. They are recorded 
in the boot_hk_cpus mask. It relies on the fact that most users will set 
both nohz_full and isolcpus boot parameters. If only nohz_full is set 
without isolcpus, it will not be recorded.

Cheers,
Longman



