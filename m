Return-Path: <cgroups+bounces-10902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F6BF332B
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 21:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF4818C2C78
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615EF328B4A;
	Mon, 20 Oct 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMNK6L47"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873572D8DD6
	for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988337; cv=none; b=KCEqZBqOvgDzoVfuvrgzW2erZ4NK/KcFf7Ost8n0Q8vK2WOdfshAje6mcbPznU77hbAfftk6ROLbS+OgflFqLJXnij3Ol6mnCxvzGz01Ox6MPXytJmxkuk1/a7aNwKQu9/d1La5HrSfp6cbnjK1OoHQ8BGrLKgfuBQmIa9aOi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988337; c=relaxed/simple;
	bh=Wbm1ygRsjezHORU08fF/499OQmmFQus/opuJpZ42+1M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K+SU41Ns11UVp/pDwsnvQYxhe2dMKWBw30WOPspmyufTnnsHOX2BSD7gdhRdGyc/RuA5HaCWon6ZG3+71YbFsuiF7AMBgBXafEMGs5Z5sfyB1eMiNAJTgiqc6nDc4hTJ2IAUlKGN9Z+edlkKfu4A5z31hyw9J95BhfrIHONO7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMNK6L47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760988334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4JESqtwQUS70W7By+0xAr07eVoyj86fvuT0XAPYk34=;
	b=FMNK6L47gd/ZQbvKJTIipnfNQXwmaWLuCkNSCe4pHV7ywW86aC9dxH2GWpTloN7/K6/N8i
	zpPtm+bACZRkykZuZgq6bgxMxqu56lD2ajtR1ng0KMRlUXrL2BCNGUApEm4nRddlHgS22q
	JaSqyRZPJ+K7zUZInBBnnZdk6nF+FL0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-m7U3SrTjPw--bJ_DDZ4QJA-1; Mon, 20 Oct 2025 15:25:32 -0400
X-MC-Unique: m7U3SrTjPw--bJ_DDZ4QJA-1
X-Mimecast-MFC-AGG-ID: m7U3SrTjPw--bJ_DDZ4QJA_1760988330
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so49399025ad.0
        for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 12:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988330; x=1761593130;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4JESqtwQUS70W7By+0xAr07eVoyj86fvuT0XAPYk34=;
        b=lQ1zd32CioGtHcjcCUegcCVerFZScQ/s8D6pDqwGnrOPavFqjmAzcW9sSs/70yfegj
         geRa+J9mnirfMrIZ7OoZROOeUVAmWmnge3NyJYtpzmXT9ZOK4HexCoJ6/kZoLZQAs7oh
         t6e8VHQYw/GcxOLuhNaGneXkn2/GpxwsrBnETpvH49kP4QAM8OxjCYy4mAb+4GNuHJfs
         udEHgjc13W2k3c7j1auG2cnl7Xuw9KM3Rvh4sbVylCd/iRwA5bj6AejUsOtXawv0yQ/F
         Q9fLekAzEM3idR0awmuNEM8CQ/SRTmfz2JkKK82aAlmK6I1O+2p+JqsChcqyqbLg9N9C
         5Q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRJoT20YoHgSYFVRaEg7L+L0cwBvYo2NJ234dROzQDeXX9V4rAUnYzkyfj7EACxNtVGknMniEp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxks5qigHoEUTyRqYItQdqDDvu7m2md6tkmZY+dUZrzcHiJpqbH
	ua14ZTtGXDQuIYvGBpGEK190O36tgjCbbBxBesY+jB4Fjdp2z0bn3bnwjB5yByvGqwc89e7omnm
	M/sdGD1pmEdf84VuUkwUg5a2kDoKxuqYIPw6NfR9HbGDbyUH7ZqraIpAJz90=
X-Gm-Gg: ASbGncvLnN0I6E+Adde6o5eWVx3SB6hho477r04FeG7acOW2sLxh1sowabdO1UlXKU9
	FW0U8xldaOOASGsaCZVaFud5Dr9Pv7REae98443vzFAy06sGuwD6P+cde0008M0VPeu0E6RnV+h
	8rWcut/wwNaLhEQMiC5oAHSpFCiDmRMDASCR1On4gCeMTrO1luG2UWOCzsuCLv7K4XkkuTyPs/M
	PNbLHsaGMXVfY0SnWinvpwYDaOtjlQcd+/NwXfDiGa3ZUVovXUkc9NrRktetBM+Ewjvks86CV0r
	JV5FIz0FXjmlYE8ZCQaczqr24kD8Gi+eZs8J7d31/bvcpnzDdS8Lkz+3gA5OBPo+nrW5nS2STqN
	wCN5UvOIS7661gvwdhJjW7bHQdgC9VSwyO/PRl5ZEPxemhg==
X-Received: by 2002:a17:902:d48d:b0:28e:cbbd:975f with SMTP id d9443c01a7336-290918cbc07mr183114335ad.1.1760988329925;
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7MxRvQT1Q80b2Ca4WrbvNmJOsadkDAbT1SVRanvNr5ICan1Hwu3+VuUStpIJbA59QNwxJpw==
X-Received: by 2002:a17:902:d48d:b0:28e:cbbd:975f with SMTP id d9443c01a7336-290918cbc07mr183114045ad.1.1760988329584;
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292a8c8e231sm33579975ad.36.2025.10.20.12.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <05900ad4-fdbd-4505-a080-1e71bedb5f4a@redhat.com>
Date: Mon, 20 Oct 2025 15:25:28 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup/cpuset: Change callback_lock to raw_spinlock_t
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-3-longman@redhat.com>
 <aPZqk4h0ek_QM9o5@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <aPZqk4h0ek_QM9o5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 1:00 PM, Tejun Heo wrote:
> On Sun, Oct 19, 2025 at 10:32:07PM -0400, Waiman Long wrote:
>> The callback_lock is acquired either to read a stable set of cpu
>> or node masks or to modify those masks when cpuset_mutex is also
>> acquired. Sometime, it may need to go up the cgroup hierarchy while
>> holding the lock to find the right set of masks to use. Assuming that
>> the depth of the cgroup hierarch is finite and typically small, the
>> lock hold time should be limited.
>>
>> As a result, it can be converted to raw_spinlock_t to reduce overhead
>> in a PREEMPT_RT setting without introducing excessive latency.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Is this something that RT people would like? Why does the overhead of the
> lock matter? I think this patch requires more justifications.

Yes, I will push a new patch and cc the RT guys to see if they have any 
objection. I had seen that callback_lock was changed to raw_spinlock_t 
in one or more of the releases of the linux-rt-devel tree before the 
mainline merge.

Thanks,
Longman


