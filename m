Return-Path: <cgroups+bounces-6831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BEA4EA2F
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229F8423634
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA6205AC7;
	Tue,  4 Mar 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOAKXg1m"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991B2E3378
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109619; cv=none; b=F2VA4RmuAz0JxfPnvrb+zbS9GFWAC/tROfrg2zQ3BEkNHVnjVTRjkUADTNXBd1XmgUdpzIIk19VgncM++YemagK8+Rkoxon23aDHDrGZLRJ69qYEzaYSUoOAlgBKmPa8H1TfhLni/ct2/n2fQyiTwVcjcwz1O+NAzKAQHS0CkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109619; c=relaxed/simple;
	bh=bNdSqKlXHjCnildLaWJjGpSWWKI5F2WeOXv0PLvCCFg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tYmqfSRPuKtC7WSPZ+0qYCr0ODff4/O2+fNK3uhMqy746+UOR6FiaD04B2Fy73g451MErBp+ER5dxo8L56QeVplvwfBr6ByMeGYIW6DEv5WVa+FcSP1Wr4qQYlP3JkYbLQlYgvGlX+ytU/HJgt5a9bEEmNRkwU+UQ+tHQAVxxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOAKXg1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741109616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/gloNWENauCZr2RKyu+Q4jT9a16xZQ906Rg5zjtKlo=;
	b=ZOAKXg1mkhrR4XBigBOjWG00CLcmYQt7qPOeOCMXVE4x5JbC+0lkf4e/coeesWZBVEFBwV
	8fTOqkV+AcdoJ7fAQn4pM7zFsqbxL9WiLwzNpTkdcQGnOWeOctP8xNLHuX8xdBuqQrptQ0
	sNsA3lSlvbGolgl2pdlzDDZfEOD3Tm0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-YQb2J4ZANFyUcb6zv9wcpg-1; Tue, 04 Mar 2025 12:33:35 -0500
X-MC-Unique: YQb2J4ZANFyUcb6zv9wcpg-1
X-Mimecast-MFC-AGG-ID: YQb2J4ZANFyUcb6zv9wcpg_1741109614
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b78c7c4aso412193985a.1
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 09:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109614; x=1741714414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/gloNWENauCZr2RKyu+Q4jT9a16xZQ906Rg5zjtKlo=;
        b=UzAyvCchgqfcCbtWTfqM14DstX22JVmyKu0ok7bzyNtXKcUwl30sWEYZ3E761Y6zg5
         VGWSo1Jd3Nif21WR4BTNH9Egawg3hM7jiq0OjWv9x5RWrEwVY4KefCIzcfK2tbLT07Ic
         vuT7kyuJwjWZTmSPJ2Zi1MRRDyvzg4ozYJ0aizS5fV4kaQj5ikJKBTibfTRBxrj3TPWj
         rGUUCNn4Bk9rLzZqZzF5OBEQljFc9p91JU8KP5d4ntf4m9nEMU7eAl0MhapkkbzsQsQS
         dGOdhhSGie2zulwp1+/luT3pmThLrpg2i/BAZ8xrSUmD7SQ1832I4C5n8VdkzW9rQk5F
         NGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwnlYCQ4hrz1GPIAgoLYlq6aFew+per91kdfn/WhZEmZRhgqUy7mrZE+Xy7hkoxEv6gQfIv8oN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97ZQob2h54hcKCYEdgXEW1ZWntJ0mt5jrLgz7Gm67fyNcD5iT
	urEXUhczijwN9c1j1j9imdYK6XSLMemwo20seEGOvu7iWjOTZjQBxH/iLjMWCsVUK2ishBBYb4Q
	x4BAv0Vxvzlo+ApHQwi4rJZbJ1rzgHiQpAcdOZUjVxUGQPDX1n2TxJ6E=
X-Gm-Gg: ASbGncug11H+NeeUBe7SaVnsAEM5u7QJC3AR+/KKb00UnForwN4SLhBop3RiY8ROPPj
	PT7Njzf2A2/s3uGu+11q5eAUcrqrkYt93H7L8wlA61vPxH6rgFiSeuymt1Xackj1FcrFsXTkpN+
	2bq5EanqVYJ95etGP0+ipcOhgCi8zIt1qYXanpCG8z/Cx/mNteVwpK5hUSV1CsR/2EIQiVyQ6vV
	73+trWNoNanRizFufT8z61BhXRw8TUop35jOrTjUyY5iWo2ZA9sskdxGs6tuGjDrM3z0jc8vwhF
	8vmCdy7SNIsGzyZ2l05BnxYHD0ER10esM4bl7Ohuajzunx8pZVjAlVXtdLo=
X-Received: by 2002:a05:620a:8908:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7c3d8e15ce7mr23061385a.11.1741109614489;
        Tue, 04 Mar 2025 09:33:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmWg+hzZenzZ4mRN1NfTFISPU5M4QS3jH+9tCASNEau0B50X9pJfy2Hegsf7Yzo9avT0yhxQ==
X-Received: by 2002:a05:620a:8908:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7c3d8e15ce7mr23057985a.11.1741109614183;
        Tue, 04 Mar 2025 09:33:34 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef4bbasm768017685a.40.2025.03.04.09.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:33:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
Date: Tue, 4 Mar 2025 12:33:32 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
Content-Language: en-US
In-Reply-To: <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/25 12:10 PM, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 06:52:41AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
>> ...
>>> I do have some concern with the use of pr_warn*() because some users may
>>> attempt to use the panic_on_warn command line option.
>> Yeah, let's print these as info.
> The intention is _not_ to cause panic by any of this this.
> Note the difference between WARN() and pr_warn() (only the former
> panics).
> Warn level has precedent in mm/memcontrol-v1.c already.

I think you are right. The pr_warn() function should not cause a panic. 
I have the misconception that pr_warn() will be affected by 
panic_on_warn before. In that case, I have no objection to use pr_warn().

Thanks,
Longman


