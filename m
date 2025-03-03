Return-Path: <cgroups+bounces-6791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF037A4CBFC
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66217A2BA4
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2B1F428C;
	Mon,  3 Mar 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA+anWXB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C1C8604
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030276; cv=none; b=DvMX5uvdMnLQgKz1muAcXSOrwXYPLE/0kY1cShHZeoaqT6rQsMy7xkT5/btOrza+OsdEiJPUEyvZHzBOLDSv1OOKjZCWnXtbAgBADMki3bb29uRYfZl1fhYdEgWehfPomlNlSMlQ2YsG5naZT3QXSJLlAjc8knWrFKBwsqKEnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030276; c=relaxed/simple;
	bh=yCJfilg9kxC4r0oBqf3GLX9rZ4uk1pdnsHgTey6FPj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvu/GNzg6fLveZbw+d07map3VCCGvZU4ui4if/giazFrDgVpIhoEDKDUTiv7E6Opk3D3BoKNJ4d8YOogldO81vedOJbhP6n6gcxIV8sDruQT31xFSUnyI9yzQrxulkP9FL48RYwPFkfUtUmgAfjyFroTrfs57wAaI/CSVMnKfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA+anWXB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223594b3c6dso83028055ad.2
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741030274; x=1741635074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xr2rN8A24AmJOSUP943E0GXZqRJ+CVeATonOvCvW6QM=;
        b=OA+anWXB5QpF2ATI4XCnGU2Adnc3CPDRvhBjrO6sTO5fM5X1kX9Tjz4otBHcnHp2G6
         q1sQ1wcT2j8LMQaw2CCHqR5ujJpkvpJ9mVOhdIr8t4HkINwTco0ZGEHv5YQIPODQA5GZ
         +TgEqd1PqN8KcM39UD/lKsEeCFnln5NI/dWCpuGEvI2aRWY+210ubw9kCKNCrgkN5kxB
         LRea+L87YeF6Dh8betBYALeP91ro1OO7i1c3vDEYiCTaYGqvblTZMtfT+Nn4bjhJfRiq
         1wCBo6Cl/fQnKTrYZ8oEV4gmjxAgLww8L0rNnSrbyaY4zrgPOl5caJE9KOpVekceQj5T
         I7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030274; x=1741635074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr2rN8A24AmJOSUP943E0GXZqRJ+CVeATonOvCvW6QM=;
        b=TGkUX6h+JtiK7MxXwYx8pUry90bBIwBmYq5KNZR25nXQOE/3/3OnWW9lL4GBs0QIyN
         4FPGtPxyEwcfZx/5NiK5i7zzR/fGtFvgbjWS4Sd/61CnulGkIKUVRtOm1DiKa0+ETcgq
         D0oFv+2Un4+kECAUP3VMTHJS8UXlofwsYqNhmFtvxAraoYSHzEHMhS5hbHwr/Fa0cE9l
         kORql4EtOwNuujWo7nvL8loB+x8ZlOLM9zUAYScxrhGUyHVwixzMqV11d05cK/Axeib9
         OavgkrB5dRUPz7dHc1MgwabvzJmN1VyXYphH9wEasSngk1cQLndIgeIM1wAk5tl/F/50
         f5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWukguUnoBU9cKmSzQ3Cva7eGSOUX8EbAv3x3KCH6Xrtn3qMLOIXu9xOt4KCVpapGh6Rpp8XXNT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ltSjyKUJkTKJuUYH/5xSmCoSgohWbn/FI5Gkcw5pl1zku53T
	ciOhCFyBqf8DyeZjp3+xVkF7wbQAO6UhbJ6oftstVLCxU5tKt8CN
X-Gm-Gg: ASbGncuFkmw6UEkHqtB/suaCMLDBVw6Vnu9EWxDNcjc9crO2DsdXGlHm/aFK26bX8f9
	7OpXr4r/wrALvUtg7i5JyHgvIxUkOoaTW+nq+dQkdtFfj6V9xi/zSwvY8Qds7bgFbFlIiLmSS3z
	nNUJOCnEY3cM57Qm5Hn+UJh+0H2s5d2d06/i3oMXKCAYuoplupOlv5G6ftkJy2OVwx2wCBUxqb7
	ymSmzRKNWnkInMVP+snTs/sRVgKgNNqgNy920KN1TRAsGGC7DuLNhKwlRs1CdSDQRaxF7P/hQH6
	lkIn7XpnMoFDdfasf/VfrHjbH/wIMeXsiX+W+PV9tjdK43ajYBLtpkUTIkfgSNYMGgSrQb+yoT6
	CCw==
X-Google-Smtp-Source: AGHT+IFp8Bi/HibOCtj3YAxJ6OJ6F53DYMfe2BuEKNrb6c7O537wvsCXJ/ZNmlxoMT15B6Xp+1U4qQ==
X-Received: by 2002:a17:902:fc4f:b0:221:7343:80f5 with SMTP id d9443c01a7336-22369245249mr218997285ad.53.1741030273801;
        Mon, 03 Mar 2025 11:31:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:64c5:2132:888c:8c76? ([2620:10d:c090:500::7:c71d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7356173aedfsm7050767b3a.95.2025.03.03.11.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 11:31:13 -0800 (PST)
Message-ID: <a0dc5562-ca12-490c-a54a-ca2b918aceff@gmail.com>
Date: Mon, 3 Mar 2025 11:31:11 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
 <gilziqko6ynfgvi73fljk6uc56xgipbdnsoxllg27vmhl5mzix@3ixl334f4aju>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <gilziqko6ynfgvi73fljk6uc56xgipbdnsoxllg27vmhl5mzix@3ixl334f4aju>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 7:20 AM, Michal Koutný wrote:
> On Thu, Feb 27, 2025 at 01:55:40PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
>   ...
>> --- a/kernel/cgroup/cgroup-internal.h
>> +++ b/kernel/cgroup/cgroup-internal.h
>> @@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
>>   /*
>>    * rstat.c
>>    */
>> -int cgroup_rstat_init(struct cgroup *cgrp);
>> -void cgroup_rstat_exit(struct cgroup *cgrp);
>> +int cgroup_rstat_init(struct cgroup_subsys_state *css);
>> +void cgroup_rstat_exit(struct cgroup_subsys_state *css);
> 
> Given the functions have little in common with struct cgroup now, I'd
> not be afraid of renaming them to css_rstat_* so that names match the
> processed structure.
> (Similar, _updated and _flush and others.)

Makes sense. I can rename these (and others that now accept css) in the
next rev.

