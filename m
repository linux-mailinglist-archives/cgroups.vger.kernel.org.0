Return-Path: <cgroups+bounces-9384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C75B33EFC
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5463C1A80E67
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989B2EDD64;
	Mon, 25 Aug 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QOEKwkyi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1A2EBDCD
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123705; cv=none; b=pKNTFukEYnYWYOwPDNRluLTHtbNrDctJmUDIf3z1SlqhJqsOJ3fbHjXiFTJdLsgK66duZEkvHs1j3QtDFpk7TA1YVbpyqcMqa0pQrh04m/MuxQHd5YL3S25R24UseLvaMt3zrLGztNBQWJKgL5jBt7nxwpk52boDCBN7lMd20is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123705; c=relaxed/simple;
	bh=oqdMoulvP9e05vx9QhuzvhSgTlS+Q/yL2qsM123y7iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYG+8R5caoBy9CuKh6cYNnWjSZjUq9wwJm8OJxcvxMjNN4CQhDNupBklFfWPx6pD7H2lBp3V+EX3M9hi/e4DrD/0iVvfL6yb3C71v6uIRhcX/oe1vXuuyWXLulze62YGbBwOjgVS/CypEM4R5ngNJ+DTJVqaBRHC/Pg9MQpsic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QOEKwkyi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3699826b3a.1
        for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756123702; x=1756728502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djLIMBABOQ5QMilKv8RGXgyY8Eozctcb9yd8r0Ea10E=;
        b=QOEKwkyivFaoLEnmSKCzs+hY2bN8tb+JAzdfm5m57PmUHpYK0e/MQ7gizWwLPvAgR3
         4AId3rz31efvOV2kjwumElbbn3yFwwzCJwP1aiC2uYRYIjSA9DJ75Gz6bJBtaWh9zPwC
         X5yFoi9XZ/hgRGcqr0M6vv2qnNx4ZoVpoz4+AhCTZ8AwWGKHztlVe/oIxxrYn4IBnqV8
         QW6zg+qnj+SozVL1TYSrySwGDjzGvIBigviE9gBiH6icMBu/BdxagvnZIpVMKJ8FV//6
         Lv1RWeMFnJx21bGQ2owiXj0tIUzjjfqFhBnVryJMtABq2PlBXMHWJBFd5mz9M0dPFVLJ
         +4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123702; x=1756728502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djLIMBABOQ5QMilKv8RGXgyY8Eozctcb9yd8r0Ea10E=;
        b=Ea20wQtv/Y4K+VzB5qHJVRbQLWrsO6Rd4ErHmeaEGq4z+hYxrxVNFaBsIZEkjxQGZx
         ptbvyv2mfeA/UcZFMo32DW2EgqoH2N2+/iRx85qxqM2x6TQoyR1cbf7oG79WOJttFOUj
         IkKVnsPCAH6Wj/weEWYFFdKXj5rScXuQAlDLhcg7cYUsr5zIW9Fb3xMH00HaSe6GkfRq
         xnEu4O/MU/CEbOUTrwHeenKtSmz9HTDgWLiXVRx7SWxmmbdhyWlSZ5pfJKE1Z7A6PQow
         yzP/0et7z/4H0boMuOoPgtvZDdCj4IHEX6G+VZLPCqqYXwn239jZZ+MpyecvKsDBGToH
         kIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXrYUMIVUDJOqMedI6AM96OGZdRjPRy0g1zdQK8zoxqiw8BIdQzQUFWGfPBk5sLjPyVzHiBXsKD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+YSDtJ+cJL3Nn6ouXAktZLYbV0mYBvn8zBYTeuKeaojdx9NG
	D7l4twvYHH13ZN1qQWvjJUEE7W7m9CUwoLa3THW0RxQN6wwKADyiF6j0QILbHnoLjcM=
X-Gm-Gg: ASbGncsrFeAro57B4H10M/41uY1KQ1SCFznKXU/43SsU0ilgUZn9YayjnBTYt1YzrC2
	QOln6PUUv8kGE1A+uyOs7QcxMODvhkRHNPRS/DEQV//6JTjX8AoeXHDx/5c8kEPniKR8ebvsG+x
	wqH2agYhuh5Hu/1xymXbT0wZWJiQj/t+8NOZgymflTgeQlxhvHXkEoGQN1s3xBbqo/kLqHQ0KDH
	Hh6372o3al1WBsHqd0rOUfEU0UjljrrpHNGFG1MuxloNQKGesu3X1V1FUCAc1XdNV8PXkHe0mXq
	7ZImjOtCqQkErFp90rWBD+R+kzBEJba5PcoKeWFdeftErvWTjKgNsRhTElenZ/YGUXf5nvv8ceo
	EHTr2+rMc9scUlR8XDrQ9wmopiisgWp9lwc7mUy1ScxrQQ1uiFCm5MRXry3vujL0RJlu1g2A=
X-Google-Smtp-Source: AGHT+IEANcNrkMuJ1PjBmSdPjmdk9y77EAYoFZYgAnfWDeZy+q3lUhQjHBWmnTqj+0/HSjBZ/qdDeQ==
X-Received: by 2002:a05:6a20:5493:b0:240:10d2:adf5 with SMTP id adf61e73a8af0-24340b57600mr17869147637.2.1756123701840;
        Mon, 25 Aug 2025 05:08:21 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3818abfsm6684739a91.0.2025.08.25.05.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:08:21 -0700 (PDT)
Message-ID: <6d54e933-5ff4-4711-abb9-96d39a5dd62e@bytedance.com>
Date: Mon, 25 Aug 2025 20:08:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Don't wait writeback completion when release
 memcg.
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 axboe@kernel.dk
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/25 18:13, Jan Kara 写道:

Hi, Jan

Thanks for your review and comments.

> On Thu 21-08-25 10:30:30, Julian Sun wrote:
>> On Thu, Aug 21, 2025 at 4:58 AM Tejun Heo <tj@kernel.org> wrote:
>>>
>>> On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
>>>> @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>>>        int __maybe_unused i;
>>>>
>>>>   #ifdef CONFIG_CGROUP_WRITEBACK
>>>> -     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>>>> -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>>>> +     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
>>>> +             struct wb_completion *done = memcg->cgwb_frn[i].done;
>>>> +
>>>> +             if (atomic_dec_and_test(&done->cnt))
>>>> +                     kfree(done);
>>>> +     }
>>>>   #endif
>>>
>>> Can't you just remove done? I don't think it's doing anything after your
>>> changes anyway.
>>
>> Thanks for your review.
>>
>> AFAICT done is also used to track free slots in
>> mem_cgroup_track_foreign_dirty_slowpath() and
>> mem_cgroup_flush_foreign(), otherwise we have no method to know which
>> one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
>>
>> Am I missing something?
> 
> True, but is that mechanism really needed? Given the approximate nature of
> foreign flushing, couldn't we just always replace the oldest foreign entry
> regardless of whether the writeback is running or not? I didn't give too
> deep thought to this but from a quick look this should work just fine...


AFAICT the mechanism is used to make the max number of wb works that we 
issue concurrently less than MEMCG_CGWB_FRN_CNT(4). If we replace the 
oldest and flush wb work whether the writeback is running or not, it 
seems that we are likely to flush more than MEMCG_CGWB_FRN_CNT wb works 
concurrently, I'm not sure how much influence this will have...
> 
> 								Honza

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

