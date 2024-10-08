Return-Path: <cgroups+bounces-5076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30310995800
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540B81C21376
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0D213EFC;
	Tue,  8 Oct 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du1Y863U"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2C7DA76
	for <cgroups@vger.kernel.org>; Tue,  8 Oct 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417621; cv=none; b=gjxyNB9xmYMgYnZhPgmwnlg/2GOw/pziaKZqb8NfM49qb+nfiCfl3TRGoYfIL++qT32pEkfoZSAw6AswXMEoC07EwJuwjHmnfa7iu+5jxdaYv15uQFzCeZsIDb6i8qLbrSDMr9FoSB3+GTameNgOe/3/GJ125WZOT3BT9lX6nGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417621; c=relaxed/simple;
	bh=jZNlIVJNu3pQP4BfKX+ZZfcg/eF7qqcjt/kO0OoSjqY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pqSc0KuJsklDaenq/ohNw4XRboV9KjSbosUs4EqKsoBv3i40QlEkk9tcGYXypR83+DJ34I72yhWfk8WsFSaUKr6UxtWddIT4X8f1mxEXhTpOkwVHgQlkBKqPLfH0v6JfZfGxsCXWWfOR2v+0bIbdq6BEQq6DtlMwC22yT/7hnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=du1Y863U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728417617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MObZzYucpeIvsY1Jse5Uz3zevG/TvvXUOk3aKsny1xc=;
	b=du1Y863UWLscHBwymrGlztutHTOfx/bJfnNyQDBYDoRKEGov2uFU/VmxE1OgDz7hBr9a4l
	gHIi2BdExJKBc2sT+nTVdGKs6QK1i1b5yw6JkQtim2MbRhNn1TuM9EgUZpS74GMyrUA1N7
	QpTRNlpA4qiwSk0lTr/3PaLFSBUdvEQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-qcnESdJcMnuVJ_auzFVmEA-1; Tue, 08 Oct 2024 16:00:15 -0400
X-MC-Unique: qcnESdJcMnuVJ_auzFVmEA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-832160abde4so12499339f.1
        for <cgroups@vger.kernel.org>; Tue, 08 Oct 2024 13:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417615; x=1729022415;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MObZzYucpeIvsY1Jse5Uz3zevG/TvvXUOk3aKsny1xc=;
        b=UlNyAb0jgwQwdcZIRus96IvZ7gauk92fGeywO5SDZOz0e5nIFDmREIvbCCl6KEVMUt
         tGBRm+cHRZuoblvwaqQwsgtrEYRy5Z43RgpckLO4qNRIHoNGgeGwF9f+acndgLBNiQp6
         5RENb2QMSMBAklP99zslkDr20tqYcBFuauL4LbGnu+OuIYS41iKGwrh+uuUB0nwLtOmJ
         F02n7Zd/SJAUtIPtgTvrcS0ESe37d7CD0IVMUJ+Vic5ssPMHvZRLPpKj1r66tEPoVSLA
         lnaQnCC2C6pO54L9t2rhhjxPqTXPG6Z5r//xuQ+Y2/MY7NVJQVMEJJU7yq5o6IMjmRdM
         yenw==
X-Forwarded-Encrypted: i=1; AJvYcCWZIciYjwhTTj+AHb9GX36GstPWU/S1pC8Ni6NhfA9ZKuXjeII7ycRj0EwcVeAaiEeTCvaW8A56@vger.kernel.org
X-Gm-Message-State: AOJu0YwYG8P7TyWwVURg6YM+lIpBMZOMenuGAIsUmJ70acZLuw9HIsl9
	SvlvyTDatFF5zR2CDPDglIS3iR85iDEKde1VO4FxylOmx0a2m5ERIa7zA8h8Z+f+8sa6BSEEuw2
	FXSyRrkPaUtJR7bE+4wauTw+ieHQAMOi/yr3EBHgBuyBHTzgVKZckRic=
X-Received: by 2002:a05:6602:6404:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-8353bd5f792mr24963839f.2.1728417615044;
        Tue, 08 Oct 2024 13:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb/gNCzEh7KldvpPLOCBRHkdbQAEa/qjLdBELHthZDFAyg1V7V+5LqxV3lj9h68DULAuahIw==
X-Received: by 2002:a05:6602:6404:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-8353bd5f792mr24961939f.2.1728417614666;
        Tue, 08 Oct 2024 13:00:14 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b305dfsm189543039f.53.2024.10.08.13.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 13:00:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7451b309-6f7e-43d9-801b-224a0a5cb08d@redhat.com>
Date: Tue, 8 Oct 2024 16:00:12 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] cgroup/cpuset: Optimize domain counting using
 updated uf_union()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, Waiman Long <llong@redhat.com>
Cc: xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
 jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <20241007152833.2282199-6-visitorckw@gmail.com>
 <ef7f2495-06fc-4409-8233-062d2e884271@redhat.com>
 <ZwVhxDEz8cSeForw@visitorckw-System-Product-Name>
Content-Language: en-US
In-Reply-To: <ZwVhxDEz8cSeForw@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 12:45 PM, Kuan-Wei Chiu wrote:
> On Tue, Oct 08, 2024 at 10:02:23AM -0400, Waiman Long wrote:
>> On 10/7/24 11:28 AM, Kuan-Wei Chiu wrote:
>>> Improve the efficiency of calculating the total number of scheduling
>>> domains by using the updated uf_union function, which now returns a
>>> boolean to indicate if a merge occurred. Previously, an additional loop
>>> was needed to count root nodes for distinct groups. With this change,
>>> each successful merge reduces the domain count (ndoms) directly,
>>> eliminating the need for the final loop and enhancing performance.
>>>
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>> ---
>>> Note: Tested with test_cpuset_prs.sh
>>>
>>> Side note: I know this optimization provides limited efficiency
>>> improvements in this case, but since the union-find code is in the
>>> library and other users may need group counting in the future, and
>>> the required code change is minimal, I think it's still worthwhile.
>>>
>>>    kernel/cgroup/cpuset.c | 10 +++-------
>>>    1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index a4dd285cdf39..5e9301550d43 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -817,6 +817,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>    	if (root_load_balance && (csn == 1))
>>>    		goto single_root_domain;
>>> +	ndoms = csn;
>>> +
>>>    	for (i = 0; i < csn; i++)
>>>    		uf_node_init(&csa[i]->node);
>>> @@ -829,17 +831,11 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>    				 * partition root cpusets.
>>>    				 */
>>>    				WARN_ON_ONCE(cgrpv2);
>>> -				uf_union(&csa[i]->node, &csa[j]->node);
>>> +				ndoms -= uf_union(&csa[i]->node, &csa[j]->node);
>> You are taking the implicit assumption that a boolean true is casted to int
>> 1. That is the usual practice, but it is not part of the C standard itself
>> though it is for C++.  I will be more comfortable with the "if (cond)
>> ndoms++" form. It will also be more clear.
>>
> Thanks for your feedback. I appreciate your point regarding the implicit
> casting of boolean values. And changing the code to:
>
> if (uf_union(&csa[i]->node, &csa[j]->node))
>      --ndoms;
>
> would also enhance clarity and readability.
>
> Would you like me to resend v3? I'm asking because I suspect Tejun may
> want to see more user cases before considering such optimizations.

I agreed with Tejun that union-find performance is not that important 
for the cpuset use case which is also the only use case at the moment. I 
will support a v3 if you can find another use case where performance is 
more important.

Cheers,
Longman


