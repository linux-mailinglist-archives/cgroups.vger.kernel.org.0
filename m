Return-Path: <cgroups+bounces-6948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19EA5A153
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6279518913D1
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02516227EA0;
	Mon, 10 Mar 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm4X+P8X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360022DFF3
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629574; cv=none; b=FLHmjlMw5MIqm43gz+jTpBM5nCEzijor+xJEMsSPlNHAheBwMKk3EbyIo9UGanBK6LghQcoLDKVc5GK8zzDTwckAACgAUzPWClaAZ+fjEXbnGOkH4QLO415EEmvL7X/LMNaJaJFuefrreHCxaJisLcLT71zB25Y4XzT/Bz51wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629574; c=relaxed/simple;
	bh=pcVLJkvqBoOuQmQ3a227EltVcSiuvcFsVjgLTZeJY5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOiRIEGozM2a0XDhv02U8zy04anYeQm5G2cKu8IS6aQtBQrZAgj9ZNNk0H+77KR0TDvt1NGjgjX+Utxps55kONEZllighmtW41dqO1SuPT5Vu79f0xbePCK/aD6LbCeDhxVLxgA38YPBOyFrxKrEkp40wrUcGKkX6tx1KMXr1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm4X+P8X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so89941285ad.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741629572; x=1742234372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNBr4INgu8tA+aI03AqyX19SI22Ahkw2EyMlvwGrywg=;
        b=fm4X+P8X1QLfRfu/j01mc5fpkpy/pIKWVeHSBulxZQEy6Vdd7Zol62sBzWXtKYJDGX
         8fWEF9fvXo2FMJpLrK90hMApAoLRjOzfBDlhwJoVuTSwMSrVmEXdZ3pe/TKtUb8iTRvU
         rFAbu7XpYeuBLfQkvfTuIaUM/6EXDBuXZVTSsWAYICojIH6iOKUkuOcn+KHqxcPFT1Mm
         J2Ajra/jZbJiui6avgOLvn9nOHgEQXtvJK9W5u2vHcMiiftJlmmC/bUEbqWzjxfhND7A
         QYR7gD5ZOOrPyMb30IZXkuVYgRi6KlErfYb78CNG3TfbTy9J3jt28gVBzEyfUDGUbe7B
         J1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741629572; x=1742234372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNBr4INgu8tA+aI03AqyX19SI22Ahkw2EyMlvwGrywg=;
        b=KTDR/YMJx+ty/s2sBDjFQC2HP25PFvuQYvqMpW4NIqCX2lYRszgkDOPQTyaPDS5KF1
         5gIrTGmj7DGtaV9+s6oa9DhnWpzM0UPpNgWZ7zTX9oIA9BzF6n6314gHaCH0zdgbkBw7
         02eGHWlxxVxMS5snQ52TEI+O9H2wf5nRdtwuX/J1nPxgp49DGYEnRD8OH+ASNZVZ3Nk6
         6k1Q2fKJGZj4/VkEFPlZXRxFu2mDHLw6qjGRMZnu7YPEtkCU0/Sl0lAAqSS+QlpFize+
         fqVe1a+1i3ejrUWC9QAMl4le0ldciKe93Ge8MHlftaLrqd0ezBpg7t/kwmOGaQm2adA6
         xImw==
X-Forwarded-Encrypted: i=1; AJvYcCWBSbt3mZQ9UymngCtKWEMHnZTVH3eXpDq3zdyuiV2b2G9gjrlOVGj3TZt3+349GlR3VGaiv/DW@vger.kernel.org
X-Gm-Message-State: AOJu0YxMF2E7fSzFwgtJl4MnVuadOpH0bhDii3q29BgqAZrh8tAuVvAt
	jIHH753nkYF/r3ZNnuz69UOwpEuYIqdQK3D5iYUdSGVUpjtKPlbD
X-Gm-Gg: ASbGncvO1/zs2tMwNeIhZzsOADZH6su81x/AEJvp9pCMg/SzYYba6obK9SlKZHhZsId
	Posbw3cjoFCKkjbgnFW9qIs1YWskTHCu2t3/iaVGAbaF0Hru9u+kw8L0qcQw8ckjR0l0hke/DWe
	8f2VhVBL5MqgXPDbTxNG5Z5cYuL82n/UWIuIOGCG90ugnAP1U4VgLlyF/KDheE3gFYLS6i+oGwz
	4CLnJygTVSDX9NVsCTx/0FxjYNpNGwOXyqYkufbW2bDPAPmFRKqRuQdrJL5aqnzE3pDP1uYoEJ+
	Lr0GK08GPTTNYbairIl+VgCOXPcJoghoQ0ZjMggXYMxPEorz5Mxm9lKXTHTTxZ0xS53MjHmwAfW
	y4A==
X-Google-Smtp-Source: AGHT+IHjl1aHKMZyxpEhQWcWi+UKBfOyPwBhyBPqoBuUmfXOH5Ljw9HIYiAxibizFH/qZI5kLXoDmA==
X-Received: by 2002:a17:902:da90:b0:224:3db:a296 with SMTP id d9443c01a7336-22428881fefmr246310595ad.2.1741629572569;
        Mon, 10 Mar 2025 10:59:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:9d6d:b3fc:984f:cf7b? ([2620:10d:c090:500::5:9a53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f93esm81183565ad.142.2025.03.10.10.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 10:59:32 -0700 (PDT)
Message-ID: <9c50b4ac-7c04-45ff-bf42-9630842eec21@gmail.com>
Date: Mon, 10 Mar 2025 10:59:30 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <6no5upfirmqnmyfz2vdbcuuxgnrfttvieznj6xjamvtpaz5ysv@swb4vfaqdmbh>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <6no5upfirmqnmyfz2vdbcuuxgnrfttvieznj6xjamvtpaz5ysv@swb4vfaqdmbh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 10:49 AM, Michal Koutný wrote:
> On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
>> I thought about this, but this would have unnecessary memory overhead as
>> we only need one lock per-subsystem. So having a lock in every single
>> css is wasteful.
>>
>> Maybe we can put the lock in struct cgroup_subsys? Then we can still
>> initialize them in cgroup_init_subsys().
> 
> Ah, yes, muscle memory, of course I had struct cgroup_subsys\> in mind.
> 
>> I think it will be confusing to have cgroup_rstat_boot() only initialize
>> some of the locks.
>>
>> I think if we initialize the subsys locks in cgroup_init_subsys(), then
>> we should open code initializing the base locks in cgroup_init(), and
>> remove cgroup_rstat_boot().
> 
> Can this work?
> 
> DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock) =
> 	__RAW_SPIN_LOCK_INITIALIZER(cgroup_rstat_base_cpu_lock);
> 
> (I see other places in kernel that assign into the per-cpu definition
> but I have no idea whether that does expands and links to what's
> expected. Neglecting the fact that the lock initializer is apparently
> not for external use.)

I gave this a try. Using lockdep fields to verify, it expanded as
intended:
[    1.442498] [ss_rstat_init] cpu:0, lock.magic:dead4ead, 
lock.owner_cpu:-1, lock.owner:ffffffffffffffff
[    1.443027] [ss_rstat_init] cpu:1, lock.magic:dead4ead, 
lock.owner_cpu:-1, lock.owner:ffffffffffffffff
...

Unless anyone has objections on using the double under macro, I will use
this in v3.

> 
>> Alternatively, we can make cgroup_rstat_boot() take in a subsys and
>> initialize its lock. If we pass NULL, then it initialize the base locks.
>> In this case we can call cgroup_rstat_boot() for each subsystem that has
>> an rstat callback in cgroup_init() (or cgroup_init_subsys()), and then
>> once for the base locks.
>>
>> WDYT?
> 
> Such calls from cgroup_init_subsys() are fine too.

Using the lock initializer macro above simplifies this situation. I'm
currently working with these changes that should appear in v3:

move global subsys locks to ss struct:
	struct cgroup_subsys {
		...
		spinlock_t lock;
		raw_spinlock_t __percpu *percpu_lock;
	};

change:
	cgroup_rstat_boot(void)
to:
	ss_rstat_init(struct cgroup_subsys *ss)

... and only use ss_rstat_init(ss) to initialize the new subsystem
lock fields, since the locks for base stats are now initialized at
definition.

Note that these changes also have the added benefit of not having to
perform an allocation of the per-cpu lock for subsystems that do not
participate in rstat. Previously it was wasted static memory.

