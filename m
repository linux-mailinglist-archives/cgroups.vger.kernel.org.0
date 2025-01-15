Return-Path: <cgroups+bounces-6159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5FA116A9
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 02:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392D718866DA
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416ABFBF6;
	Wed, 15 Jan 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2ESjeyq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25435952
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904803; cv=none; b=oDJUb1CUjYAaCK9b23dS8FtzQ+PDJ1TFRZFQNmp9BkIIr+SKolEze65rPTIVDxYPCM2vF4D+6PUHm4Kg8zNc4k0ELRv3bpXzhbK6aUe7HSm+JD9ngoeKYKFzFPPtFbBGhtPs9GCr1+AXWocZeruHril1EEw3d+opB36KUWrBQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904803; c=relaxed/simple;
	bh=AvjcrzAdmF43mxruVatCYO0MpeLO6w6bdFqV8EBoMsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgbfzpN9OaTdy+qXiXBj+jaDyzEhriqAcXcnVM+Dr6uRwBa5hoKTeM6AZ+GLstla/BNAWyHu98gJg8npf+wszVMuTfgRVlr1oyFEMYlBTkzptxYC8PUhL/eioUX33VeYqddJybK+EHTfTbEIdOTQKCM0oiWbmvkPHVGb+vOs+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2ESjeyq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so144872205ad.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 17:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736904800; x=1737509600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9P5/KEhDafJlP2HFwU6Lo/haCAgWGhZE6rmWKAwwYg=;
        b=N2ESjeyqJ3ikwlEV5J0tXTfseBPNlDChty8WQK98JjqV2IxQGFpaNLvV/E11O4nADs
         LtNejerpo2fjQzeLVivTb9MxMSREQqwCY4Ifaf+FP2kd7mq3H7HVG7ExgjUwPpwqDIhM
         1wXKCsf12RxUfg+i3IkbPfbHjhuXE7piQUzaQWJYnts6/oODHR3GlVDm/e2Yk8CqXkjM
         ay3qYGKvt2lja6APqe7C8udNSkNbruQvtMYZJJZq4MyvSyXsmDEqM9ophn2aormRgxv3
         TkdLGlwCS5oY9iRZ4IDxipZT5KooshK/+UcElo03gz3+ZNbWjOOYN6/gHaqogMDbmi1z
         33ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736904800; x=1737509600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9P5/KEhDafJlP2HFwU6Lo/haCAgWGhZE6rmWKAwwYg=;
        b=js/RWlJbZSZ+BEbo2m99i//qHeMRPUpff/6z4QnKL99zE+EoVtqdqwClPau7CBwdcC
         98FKbyQ+CNxDW9D4H07V8nd4O1kB5MHIKo+Pxv9o3+QjfcO+/87pVBWHabSNiXHT2PtW
         Y/lHr20R3Z3ObMdzkXsgdBWgJpOtS+Hhpfbg/hA9fJ4FKQTJcBL1LSY411ybIzipxWTg
         +3JaKiQk2yO/zN7S+cQsc9vC3Megyvb0RDz1BbY3UCKzEzO47Y/Z5VItlF8FUanw6MjP
         tWQds4juza7h17RNnEbLrZaQX0THNiBHYGqvXUtIQR3RCXXYDf1MVRCyE/6MlX+wkY0A
         8IXw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZZ2yqNrDQ07eJlxD5FjQ0WZFKpMwDi4VDLqTgukwKlHfUMApfq4AoxShsp+CmNAk/yuAEJFM@vger.kernel.org
X-Gm-Message-State: AOJu0YzSP7etWyrBlSEXSUi1caHZ3D812VLYjeD4gs5qyGnESSlIrZ1Q
	fEX2lBc30a08PKgJVt6zm9U6nGP8yE+K/OUkNLpyloFEK5jC8Nc6XxZ/bw==
X-Gm-Gg: ASbGncsa0R5oCbYVpDuOu3TY3bnSiMZdBa4eF12Mc/t8qZX4eikUsjSVN7EE0mRRL7Z
	YgGa2zZQgxS+tUaRUJAo64PmbEfdntgec5IGSxDcyhq8JaxQyUgZzujJf0GASI/raaediXikE4r
	3peWa2uDZUlEjqar+/PK1mTKDucv1Py40Ykx/ec2DiD8QoUr4ukxQvOV8svpLBxM4czaHvE5uq3
	dOLgxeUZr897eoyYsDAoZ7PcB2rCnYB65099YahLExRgpsRopeaj4Ti84fmpXHfdiQpv2I6l+tB
	zthcAw7oGrzXKLzzV2tNVda3uJk=
X-Google-Smtp-Source: AGHT+IF8WCGrsngtExiMEJPyGr2HFt1RxJSp++uB0HJ+ldZPbD42ZP+VfZFVFYg+hwKZeGQm/b/i5Q==
X-Received: by 2002:a17:902:f68b:b0:216:55a1:35a with SMTP id d9443c01a7336-21a83f9cbedmr389805695ad.30.1736904799907;
        Tue, 14 Jan 2025 17:33:19 -0800 (PST)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c154868sm191436a91.8.2025.01.14.17.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 17:33:19 -0800 (PST)
Message-ID: <3348742b-4e49-44c1-b447-b21553ff704a@gmail.com>
Date: Tue, 14 Jan 2025 17:33:17 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
To: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michal,

On 1/13/25 10:25 AM, Shakeel Butt wrote:
> On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutný wrote:
>> Hello JP.
>>
>> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmail.com> wrote:
>>> I've been experimenting with these changes to allow for separate
>>> updating/flushing of cgroup stats per-subsystem.
>>
>> Nice.
>>
>>> I reached a point where this started to feel stable in my local testing, so I
>>> wanted to share and get feedback on this approach.
>>
>> The split is not straight-forwardly an improvement --
> 
> The major improvement in my opinion is the performance isolation for
> stats readers i.e. cpu stats readers do not need to flush memory stats.
> 
>> there's at least
>> higher memory footprint
> 
> Yes this is indeed the case and JP, can you please give a ballmark on
> the memory overhead?

Yes, the trade-off is using more memory to allow for separate trees.
With these patches the changes in allocated memory for the 
cgroup_rstat_cpu instances and their associated locks are:
static
	reduced by 58%
dynamic
	increased by 344%

The threefold increase on the dynamic side is attributed to now having 3 
rstat trees per cgroup (1 for base stats, 1 for memory, 1 for io), 
instead of originally just 1. The number will change if more subsystems 
start or stop using rstat in the future. Feel free to let me know if you 
would like to see the detailed breakdown of these values.

> 
>> and flushing efffectiveness depends on how
>> individual readers are correlated,
> 
> Sorry I am confused by the above statement, can you please expand on
> what you meant by it?
> 
>> OTOH writer correlation affects
>> updaters when extending the update tree.
> 
> Here I am confused about the difference between writer and updater.
> 
>> So a workload dependent effect
>> can go (in my theory) both sides.
>> There are also in-kernel consumers of stats, namely memory controller
>> that's been optimized over the years to balance the tradeoff between
>> precision and latency.
> 
> In-kernel memcg stats readers will be unaffected most of the time with
> this change. The only difference will be when they flush, they will only
> flush memcg stats.
> 
>>
>> So do you have any measurements (or expectations) that show how readers
>> or writers are affected?
>>
> 
> Here I am assuming you meant measurements in terms of cpu cost or do you
> have something else in mind?
> 
> 
> Thanks a lot Michal for taking a look.


