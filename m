Return-Path: <cgroups+bounces-10325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50CB8F77F
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEF43AD436
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B22D0C7E;
	Mon, 22 Sep 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e96SZKxJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963883208
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529237; cv=none; b=sjex1RQptyLXKqdYOFlZRRKKWigL5sC8gAUuDlQ7gX7FI+r4eK+K48Ypo/PAI/R+xZLPn6EpezwvHUYCehEfHohe6lvOhKvMyTqcxoux8JhaakZ2RV/EGh4gPVQB9g/tuMEp+8XzZA9dSuqqf+Lo3EIsKywdyVWLbKsVrpbDCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529237; c=relaxed/simple;
	bh=q4uDnpl//KvaSiLrv1hiujXPyi4VIOjO6H2gptE6lH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGu4j/1QXds5T05q8AV2rSRtM+Fj32yhLjiF8v/joZwbjw34RNIjjq5x2T5LZqEiggF9ANbf/EIL0mF76xWjgPFOYcMEdtObyvQNBMU4bB3+m9shhvTrVdAR8QH4FPkTJzsrAevCNruo+yRjXiP4tJE7zkaUjI6iWgiyaAkGpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e96SZKxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758529234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTSpYQLpgM+WlNuI8Mgb7BwU+wlgVRKKnQKSWw8SEIo=;
	b=e96SZKxJwmhFg7AXSszvXOctv7o07pcCWLeRFRe8CznGFMkChpDwpCgz3xmMnqZYTSpszq
	BKcoWZcBaYlJUYTX6PsclcK5/G/RBNtbZA8T7AXEbjvQB8Da5x9HoUwjHcByG71+4x/PZk
	s+tGNk6dKFynXgNg5RmfshEDPWScJKk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-mhWf8nLbOlyG6sZq__NoDg-1; Mon, 22 Sep 2025 04:20:32 -0400
X-MC-Unique: mhWf8nLbOlyG6sZq__NoDg-1
X-Mimecast-MFC-AGG-ID: mhWf8nLbOlyG6sZq__NoDg_1758529231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso3373484f8f.1
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 01:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529231; x=1759134031;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTSpYQLpgM+WlNuI8Mgb7BwU+wlgVRKKnQKSWw8SEIo=;
        b=RYQtm/4Rr5DXlFPGNPJaAWegVGSV/Q9gyTwkZFCSJMILrz288KKTMD4D3L73w9HQKm
         wZr75IdFmnfESGTumF/QVqw4VWSBGFJ3A5C5Ydrv460YIQtCkE5gBYIkemJUWGUzeNKB
         yaqM9BIgHkN6KRjDUNwrJy37FebINFA5YiKpsgn3sQq7m37+/Z/waZKqbJmCsweqDavv
         gDeX8sQVbO6qCMQ7RWT+P2PXxTn9wosMevdEMgVQ4T8F0rPbrm1OvHVGPK6ollw1jEQn
         iYSN6bwwdYRFRy9UYphVi+gsCEiyseyZ0TgeacZ0RAbXbm5DLJZjljXhKCBBekJT7ajF
         78EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntJDHEAqa1iBoJ+J80Yy7JsUR3T1Bbv1W5VU+55IaPUSjFLLdsCtes/efhWLoE80q3WV0l7Ly@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcKZNhdooSH7yhpyoVH5Qx4gRWi+jBghx7+YE6ApTEWi1D3Jc
	hr5k+s13ZOyS1OG8JRxORSvnY2xOEGYDgPI7DV78FsJZZ6RjeGEUcI/peLJw3RhYvHQ9ImDLVSs
	dlTUWZreOiJ84KK/KU7rJJBU/iJmfPAcz6NqVOPK0Jd8GD8tlIxGRaO6ga5g=
X-Gm-Gg: ASbGncvithn6D24ecCgfqhTSkqz0j80LpPWlthVoQOkJhCrKE1FgRkAY0DBj0q3v3L3
	pvTVMnOHtcEQtHvm2iOB47az7zuzChd3HieE6uXP3YYHLNug/8/zg+AG5uOMW2OWgQsKpNWJjoo
	GVdUQbg/O9jMSL2cwxqZwCQtgHguxIyb5HCEioOM9cS2lh+YriG4KxHLbjJs7CgFqlBz82iu2H0
	q8++qQUrs8niFAjde4JwSePTScWbV9AQUh/4c2BFYhQlLvKB25VcVm/46y/VehWXaCZi+ySiPj3
	j9NLDmib7itzcCzTu2ZYswgnwbEa2UyM1aAsjSdVKNis71y2h5wH3EVhAYvDLzfO616UHrFVgLb
	U5/r8NL6J9lBGdLFMszKPpExDRjyhyTVnsXE3KxvRXAz/8Y8GP6zJ8TT2zo7wZGg=
X-Received: by 2002:a05:6000:184b:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3ee86b847d0mr9158646f8f.58.1758529231154;
        Mon, 22 Sep 2025 01:20:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazbIH7Du/DsNo7NjTJHkKOkoTzV8fJz70pe2Vh7GdEk0mHUE3AUP3Fk3uP3f6E62YKDdVFQ==
X-Received: by 2002:a05:6000:184b:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3ee86b847d0mr9158607f8f.58.1758529230671;
        Mon, 22 Sep 2025 01:20:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm13959503f8f.40.2025.09.22.01.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:20:30 -0700 (PDT)
Message-ID: <835caf4a-0218-4f02-8459-e11757d36e51@redhat.com>
Date: Mon, 22 Sep 2025 10:20:28 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its
 variants
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 05:46, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In future memcg removal, the binding between a folio and a memcg may
> change, making the split lock within the memcg unstable when held.
> 
> A new approach is required to reparent the split queue to its parent. This
> patch starts introducing a unified way to acquire the split lock for
> future work.
> 
> It's a code-only refactoring with no functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks sane, I assume the build issue is easily fixed

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


