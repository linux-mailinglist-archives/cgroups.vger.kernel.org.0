Return-Path: <cgroups+bounces-7128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D7A66EC4
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA91899ECE
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D520458B;
	Tue, 18 Mar 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3GnNX1U"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FF1F09BF
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287450; cv=none; b=J2Tm3GxbwY6oZ5Iw6+P5s9oXi7PgkY9kASihx7CVPSsemoH2Ox/CYoh75c4lFX5DdvjyMNcrSztjhy3Xr8JnBbqW1SIMf1FMvxDR/KeeU+hfscSzvvv5zIKN5M7AD9H7+vAUBTHSrVG6HA373+WXyQ06Ag5eTvaJVo6hOS29cAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287450; c=relaxed/simple;
	bh=fHxfR/Fe1vR2g75IQ8QN4VFEb1/+MPRV0zX5VIgT1+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6xDu5SopqKHpnJZHW+RhFa5IDS9Vnv1yq/xkvnmYCx190Byg94vtGRYlfheUDFj1KrrM9M642zPZfSi00CM/FQ3poAAMeJIk+r/vjCU/t4y2QyDMToDdBitBzz5JC/uOy0aYm329HpXm7OIioUCMRYeoMha49YnyYEDCjoXggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3GnNX1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HDmgZLLIpwK6kAQW08mjGUXvGaI9Zvm7zThuVW477Ug=;
	b=M3GnNX1UiImDBtgc9tZoCcP+8lrV6mnytSFrABIY2DW2Tr8y7gBarwf3Fq+t7PmG+jegSf
	fVIDLI8CDuL+qeZYIuHWdtmA1kXyMVkV+RYrVh006HzaCM0UkzGvLxDMCmwNQoNZvi/Kir
	QRdfQYKs2o6IOR/Ld9PdUSI5QB8VLVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-JfviPBkTMFyvPtsmLMhOBA-1; Tue, 18 Mar 2025 04:44:06 -0400
X-MC-Unique: JfviPBkTMFyvPtsmLMhOBA-1
X-Mimecast-MFC-AGG-ID: JfviPBkTMFyvPtsmLMhOBA_1742287445
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914608e90eso3485613f8f.2
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 01:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287445; x=1742892245;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDmgZLLIpwK6kAQW08mjGUXvGaI9Zvm7zThuVW477Ug=;
        b=blG2+oKCQREKA+oDblMXuMd0yuewR50fuiAAq00OArmAUfpauE/RC/KrROJjgYHKQ2
         cwEvJRwCrGrHZd27qoXlEhTwesWdgaBu1F74g2S/A4vG/mbKCvVuYKsphciuo3Ekd0Lm
         RCPlxJHk6YUDJxCm7e3sgVFKp59fE6O15wcUQw9g+56kxdaM7SPmhbjUW9L+4CJ/dXUc
         0jvx1S/uPXVk9aZcXe90egl2em56ElosBSf43s98KO2fFSpsQDScEuZ7jVAX3Yotdrs0
         6kfPGHqHpj3DSNsE1YERSIAblCTI6xjlJwgb1YeVBnKxB65rOMSlXCweJkkStuCSZGTf
         yHSA==
X-Forwarded-Encrypted: i=1; AJvYcCWs4F2i3kDtUMFnZl7R6K5BaFi4SXZPdiXQ66XX37srokJHPhJuoh65+dmTpVyDYXFYbbJPxkks@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQrlHahaQKjrnchIwR8ljioKOpv+J92BnIrdH8zHOdg9CVGLi
	SSc/wv/IRkbmc2f6h/acsdFjIcj9DX85sdzdTfUQOc3n916C3GHzGAWZWHcBTW6iPxEtdxtkhNT
	4icRddOT2jIcLYPaBzv0Kd7NCkEK+DvEYm7WzJEB2FDEGsh+XrlOax9o=
X-Gm-Gg: ASbGncuBD9QOQfJz2RzV8kfYf5C1MbbHz0J/MegDkUP/yuopfjGlKtRWeujC7/yJ0Td
	D5jJrZP6MPdre2RsigKKUFcZEojlJTa2zwt2CRHLFGER1YYwA/fM1wtBh1znkwvgiDrj3fkho98
	+RNlXEsVgs45aC7ClNEbGxjlpqGIbrLnoLGaMHarzxvPqJfi+lhnK7Z22d1Brb/I5UupjmsQl5J
	GuXb0x8Rbsy6VSudXqxDmvMzi8XlEZeQ89x9o9NJbeKkGaf4DuT7YeubXWRq5o5fmSM0OKp7bDx
	czu+J9bCysp365+/Yd3Acn4xJJgGkwtFEGfJOrFsspTrVY80V8cu+2Z/K4A4ktMQ/eU2E2+CbEQ
	OXAPrGs7Lo27i46oLH0StYylqfAYR/e8UW3GvrPIXEg8=
X-Received: by 2002:adf:a403:0:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-3972029e76emr12128987f8f.34.1742287445223;
        Tue, 18 Mar 2025 01:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsMPDk30z1VcJpRB8YjodHuvxQ4d8je3JZS6Y7eZxfRI9LeTmUeExaG8tWg4CG2GeZC+ZVcg==
X-Received: by 2002:adf:a403:0:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-3972029e76emr12128962f8f.34.1742287444875;
        Tue, 18 Mar 2025 01:44:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b? (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b7656sm17079741f8f.40.2025.03.18.01.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:44:04 -0700 (PDT)
Message-ID: <0e48e415-b5db-4555-b73b-d2a032752bfd@redhat.com>
Date: Tue, 18 Mar 2025 09:44:03 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/proc/page: Refactoring to reduce code duplication.
To: Liu Ye <liuyerd@163.com>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev
Cc: akpm@linux-foundation.org, willy@infradead.org,
 svetly.todorov@memverge.com, vbabka@suse.cz, ran.xiaokai@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Liu Ye <liuye@kylinos.cn>
References: <20250318063226.223284-1-liuyerd@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250318063226.223284-1-liuyerd@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.25 07:32, Liu Ye wrote:
> From: Liu Ye <liuye@kylinos.cn>
> 
> The function kpageflags_read and kpagecgroup_read is quite similar
> to kpagecount_read. Consider refactoring common code into a helper
> function to reduce code duplication.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> 
> ---
> V4 : Update code remake patch.
> V3 : Add a stub for page_cgroup_ino and remove the #ifdef CONFIG_MEMCG.
> V2 : Use an enumeration to indicate the operation to be performed
> to avoid passing functions.
> ---

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


