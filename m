Return-Path: <cgroups+bounces-13031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C2D0E12B
	for <lists+cgroups@lfdr.de>; Sun, 11 Jan 2026 05:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4321530145BD
	for <lists+cgroups@lfdr.de>; Sun, 11 Jan 2026 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023D21ADCB;
	Sun, 11 Jan 2026 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaXpFLd+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2B1862
	for <cgroups@vger.kernel.org>; Sun, 11 Jan 2026 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768106274; cv=none; b=A7GGyuYhiYpQWXDqMx5LAI8xB9fWwL6IzWZYoZIQXq3AXNTokHd8VoWqYkmoDiJ2equ7XJ8202kM8wIDykwZHqntAT11pAtH8X+IuRm+6UoJMEQ8qUzKoA5VApTqgFW6PlGRDRdwg0NYcqA8ogbvRDbrzfw+dQHoOWRSxm219jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768106274; c=relaxed/simple;
	bh=hjLWyIMfXve/7USHSBgB8047m2M6oT9dUUbbUhUxm/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk4eZ2jemkw6/wXs8nEkMKLSiCWcZHrEvpxKI6PYm8N8N3Qt5X0/KVIswiFBBvsIU01KnKa3KhaQiHCo/AYDHOat80ev2tcQK54L0glxJWIEsDIlxVopPIle8PKohkhRP7jNwERV9kluvFXg+ubUZ5hhtsThCiU+qQqiwyCOhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaXpFLd+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c3e921afad1so2292596a12.1
        for <cgroups@vger.kernel.org>; Sat, 10 Jan 2026 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768106272; x=1768711072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNTdXLWPuwQ2gqvJAF5I8RETChv7O8Xp8mYA5oOn2BQ=;
        b=GaXpFLd+2aJlmREAcC73oNEisH4tUAsilDW8pxuWdyW5toEQTnIUuYz5KEDoxHvWSy
         OYfUdnnFuNJEy7BvpmOXeG/lR4cFQwgbEHwSwr2jv5Ty9K8FwVfuKxZ8q5HLGqc2+oG5
         XNED8LJprOjzHdvimQW28QaT1wZiylLIfKmN+zZaA/gZLo+WjupeBBRj0yhxDU4KboqX
         JVONTBKCT6nVd/HncUu/TzJdqxEU7jXk9VUeg9N4eeMIdxzVFVngOYwd+jD2SndZq5zZ
         WvuhO31cszV5gbTltr16fj3+X9sVPIxzYtmbFcb5PQjs6vqpP0X5HnWegxjdTQNg0MY3
         6p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768106272; x=1768711072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNTdXLWPuwQ2gqvJAF5I8RETChv7O8Xp8mYA5oOn2BQ=;
        b=EdEy0+IfnIsV8tEd+RKstJOCKp3WPEODf9u10cTRT7t83mrsian94EGORZVzIOJ0+2
         1qiceS8mnbGEoqDTXvsvIIGoa+L+1x+Zrj3Di9WXV3UnUQxF8LdHeGkVU8sk2LUus3n4
         /gOuaWZp7peqJJ542mCKMVS/pYsWtnMvn8pFSQ251DDIvztkpYWruuWkQv56aRCzrlAv
         XCH6mjat4N1V4E+0c7UeDTPsOm0V8WeWkvbAt5D9nFGU08eJ6gS8vnTzTkM5LOMAxrF2
         IoMrnbT3fIx669kgVSJ0VkbcZRqxg50ZEZfNIuDdPrcXZjLRjLRm9Jd7XZ7HaH0daoAD
         IfWw==
X-Forwarded-Encrypted: i=1; AJvYcCX52Y78HXrSHnHK73zzUy+A/u95rCRDp6KYI8TWhQpgv3zem9Fkk6dPl0Dp9AuYB9RM3Na9rQ3+@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZrNJxZkzZEcNSZo7b5nA7lhguqdZ0dSN7nZEtQt61Fj4Ol0m
	3VA2gDSwY6dMiWFcvH0xu0vA3TJXvE9Gq53HNPtx8A8JiXcLSIpTI1iyf3z4J4GC
X-Gm-Gg: AY/fxX4wWhBJLmhdi5r5UrNZMA1BebpsigW9/4eJcluoGfctEoi+FQaA/a2p6HOOsc1
	rDHDgqN3uCJZ0ga4ywzS11rmtt0gjcTuPt35SDD94P1UxHG3kmG1yA/PRf8ku5aSoZKtfFZPRbn
	XHztM4ZRTQHKE5BGOTUjuL6S0PSEYtJS9hwbVC8dJAM8da4TP5URHctrkzpqY8Jf6UW3xS0ZDxN
	mDPeoSyFk7AYvfP9Cc9eyBKLEB8NpxcriIDXYeB9Rmeyw6g1y8+JQzrcKgVxauyu0atarw3tH7c
	fyeif3tRT+fX2jhSfXBXSKBLKyTX+6vLfgT9uf4oON0pXc5qL3f5lIM+VaMnBBD4Di2MzvdfVE0
	JYHzY7Iy/j3fj+aYhqDgu3KbY+YQh56cPzwMuBRyQ/00dqDr6LJncVPWm/p3R0CfeGCsn7XUhxf
	5ENgNRpo28UxIeaZ5fckBU8sPGVw4IbgykcAQ=
X-Google-Smtp-Source: AGHT+IHUjVKIUncy/1zb6Wdvi6STOzA2v6PUBocX3XLH54HTDpNmKPMrWhTth1yxgQUS2bUbP5n5oA==
X-Received: by 2002:a05:6a21:3387:b0:35f:5fc4:d886 with SMTP id adf61e73a8af0-3898f9cf3d7mr13042946637.43.1768106272064;
        Sat, 10 Jan 2026 20:37:52 -0800 (PST)
Received: from [172.29.225.215] ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f476sm165049a12.8.2026.01.10.20.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 20:37:51 -0800 (PST)
Message-ID: <7210e5e0-2a93-4d3b-a564-85c0fe117ef5@gmail.com>
Date: Sun, 11 Jan 2026 12:37:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: optimize stat output for 11% sys time reduce
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org
References: <CAJxJ_jioPFeTL3og-5qO+Xu4UE7ohcGUSQuodNSfYuX32Xj=EQ@mail.gmail.com>
 <20260110042249.31960-1-jianyuew@nvidia.com>
 <20260110153342.7e689e794ce43a0a39c699fc@linux-foundation.org>
From: Jianyue Wu <wujianyue000@gmail.com>
In-Reply-To: <20260110153342.7e689e794ce43a0a39c699fc@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/2026 7:33 AM, Andrew Morton wrote:
> On Sat, 10 Jan 2026 12:22:49 +0800 Jianyue Wu <wujianyue000@gmail.com> wrote:
>
>> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
>> printf parsing in memcg stats output.
>>
> I don't understand - your previous email led me to believe that the new
> BPF interface can be used to address this issue?

Yes, previously I think can directly use BPF interface to speedup. Later 
I think maybe this is still needed, as some platform didn't have BPF 
installed might still use these sysfs files.


