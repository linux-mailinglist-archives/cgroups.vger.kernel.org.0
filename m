Return-Path: <cgroups+bounces-8795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E1B0C791
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BB0174578
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26C2DECA1;
	Mon, 21 Jul 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4Sj4JeC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960B2D3745
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111704; cv=none; b=jXR8vZ5tX6+dyGW/Ui1A8q4+dWi7m5hADtjGVAtrgb7+d6tZwsEdJGD1A7ZdnVe5FdTsgWhxjhBTG2VANUETYGWeLLD1BIVJ6dGwVwGFOl3zyNUdB0x11MzlSlOcmjpotaK9BmK0BPDLNlFeaLEsYGtpr4Q6KW+3aU27qpgLw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111704; c=relaxed/simple;
	bh=KAjqmmSNUJsaFZnkWyXBZPCS3oCAxo7Zdsxi3lRn0ug=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OatMbPvm+7OitZSpOHOCdZCK/bepnUgHEaONgIZTkGBqmI+C/ZneDDci239OKzWt3Vwz6D08i0/FxM++ZcTgp1DDG2IlCnFC4NizIVd+TSBegJxXvOE/5KTt20ITc+F/99LoLXMTxttmjjX3mPAcFlMUzfbCqxMCRKbVRJmKibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4Sj4JeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FAGnQIaMxJlnDMfsOE3b9V6crtiwzXirYY+AEfUHfA=;
	b=K4Sj4JeC+mJBm/B/0Q4VFDHrXi2CoaXEBYOJ/DcH3kgcHVkRB+dWT4BmlEG038nE7FxP3G
	nmA79B4nU/u8FqYqmQsY4mcaUwTcCNXfyttnW/vbj8cowYfiCbl5RePV9atigOZC7onJIM
	d2xfLFuPBFbPfYDYavE92QGnOj46Qvw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-k2DJytUFMA-hSQqqdPHEjg-1; Mon, 21 Jul 2025 11:28:20 -0400
X-MC-Unique: k2DJytUFMA-hSQqqdPHEjg-1
X-Mimecast-MFC-AGG-ID: k2DJytUFMA-hSQqqdPHEjg_1753111699
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74d12fa4619so3823101b3a.0
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111699; x=1753716499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FAGnQIaMxJlnDMfsOE3b9V6crtiwzXirYY+AEfUHfA=;
        b=sJg3s4IIfPWDNojvTXSNUDrcehen+q3i3px/ck1c7tzNRp9LSX/O9r+GEw/nCp8oCS
         2CX/Plj59xVKSiqog3mu2bLVL/eW1AK1DiPhXZFUjUItwHI5EYOFcrC73VBmDmu0QDhl
         P8XpkTd+nXIer6OdMH1rMr9R/JGCYpz6WG++JG+OAKR039Tg/HihE8r7RNqPd87Z+s/t
         INUUBx7XtVO+VB2hp7fvoNYCtTt+rhSh1z5RAKo/HPF/y6LfjimTt7zwBRiwHCQdE3by
         CV3diHMCqAlxoGHQESEvskM0frL7dCLIFOhLfM9ZGGJR9Sl29egXdGXzVlbG99tgH7Kh
         mUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL5GRriHkDb4+avMKTrrC41gdc8QsdhwTyg73PeEUlUIX9cLWKWTH6dTCA3WMGL1gGIZcIFWlV@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeEj+xWOli9Ts2q6q6Glx1AU8rBBwZtkWv+YHXBZBytsC8LRi
	3SC8temoggJJJsnADiOkPG5FFpp25ufq2drUjQmWva45RqQdJAoU/48iOwHbDuxYN6B9ilRFQTS
	/PR+Sb7gCeIn2wSbVMVK1g0oWh51sKwA80mkXV/YIOKK9WS/BLMSZdmmOX5s=
X-Gm-Gg: ASbGncvB2AJ9KgFa87XegxdFTRo/S8AnyjGIQRTP4turhNyeNeKUWQ2suz6mfZXrR5N
	nhp0xFWq5c7K4Y2dW/KCyJK0+KcHdBcGEjv4TNSEHGIs2jBFcZ/D48ASE3cul1F+EPuRPEor6og
	lZmyLVwT3gqRvOvmKSVPwSlT5Hz0qQDKYgWJV4IRJktsOjGNy6sAFy4j8pLejJmW/aMwICdh9Qe
	7pe6kD+IIGCw9ZszKvGJ7xx6nXdfrepuxofI0Uc2DZYrxWLeYILtrcGwXHIpSNLGPNGCceCM2qF
	6djTJAAaPdzAqZYUQ1rCOlVMs+950ygvDBdOS8GyrMh/FMJPcVEkF2MhLAJr/PFSfGrOKHKlciF
	9L/BKJarx8w==
X-Received: by 2002:a05:6a00:3981:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-759adcd49c4mr17806668b3a.18.1753111699391;
        Mon, 21 Jul 2025 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPM0nuxfEYmVcmD9DluTfp24c3r9Je30bankMzwjCMPBJmunsQVaJMVzxVXE4/wnie8bPkcA==
X-Received: by 2002:a05:6a00:3981:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-759adcd49c4mr17806622b3a.18.1753111698925;
        Mon, 21 Jul 2025 08:28:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15761dsm6021416b3a.67.2025.07.21.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:28:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9bd275be-45df-47f3-9be3-f7e1458815a4@redhat.com>
Date: Mon, 21 Jul 2025 11:28:15 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
 <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
Content-Language: en-US
In-Reply-To: <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 11:13 AM, Michal Koutný wrote:
> On Fri, Jul 18, 2025 at 12:48:56PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Chen Ridong reported that cpuset could report a kernel warning for a task
>> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>>
>> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>>     be the same as the cpuset.cpus of its cpuset,
>> 2) all the CPUs assigned to that cpuset were taken offline, and
>> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
> Does this make sense for cpuset v2 (or no cpuset at all for that matter)?
> I'm asking whether this mask modification could only be extracted into
> cpuset-v1.c (like cgroup_tranfer_tasks() or a new function)

This corner case as specified in Chen Ridong's patch only happens with a 
cpuset v1 environment, but it is still the case that the default cpu 
affinity of the root cgroup (with or without CONFIG_CGROUPS) will 
include offline CPUs, if present. So it still make senses to skip the 
sched_setaffinity() setting if there is no online CPU left, though it 
will be much harder to have such a condition without using cpuset v1.

Cheers,
Longman


