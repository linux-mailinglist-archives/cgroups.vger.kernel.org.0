Return-Path: <cgroups+bounces-2179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07088E782
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF62F1C28BAE
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BB142908;
	Wed, 27 Mar 2024 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ddWvQyf+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDF23765
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548452; cv=none; b=Img1aYSm7cXl6osjEaiabmuAxTCPK5/F0LNJgR0Fn0GHr1j8RbIaLQKA5oxMG1Tdaebsy7p/XswonmhNcZDExV4Q2RMvzCzNNrpCS/hBy37+62arlcJh4ibLpn50W9eeTZaBn0zeV2RJ3N01rG+hjcd3Kjn+lC1ROKEmbiOFM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548452; c=relaxed/simple;
	bh=q+TudwkyujwZ9RSMxmceL4yAGHkIN6TGROXf4z1JiDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChrBrmriB0feangaMnkpCjGdSs6oRQgR0UGSI3oYZkzX94AAVEIYtRUyXXsj/CyMWlQWoOS7NnGKV/a2gDT0c1RRr+SeH7Rgw6JoQbAgpApjDi9g33be0c+e/9r3qN93ApU2gfCju1lkYPuKym6yEjf270yxQaVB5NCRtSMkPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ddWvQyf+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e8f765146fso5214843b3a.0
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711548449; x=1712153249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9NR3I1lvrj9At5Q7ZdH6jHjAjFjQwA+LD/Cvlyba/g=;
        b=ddWvQyf+AYLAS5yVFrIcjVvGS1AHUN2duaZYzTmIkddQayYMEEJOmg7OS/bk7rrVEq
         oHM0UvbY+29iE13H4llgsjNP+XTIJlSXv7D+gi5z5kAwFXiC5FQd0H0UmWOsVLVYd7TP
         YEHW1Ao/Rl1lYEoLFxGWqJ+ArorlInclgBqw5COiYtDQnHzl4skao+EzaGHrqs8d6wEq
         fyZ+dlvyBt2Dl7cZc1nxQ13c7Gja2arP51IXFPxtZPQXcruTf1k6IOWLtWe8DS1sjR3O
         SjdLwRSK/Ohi5NDuBbTQ3ZvOPEjaTAcAU6YHS4PJJVUZj95R6kEoSVBNks0lzBGdVGGi
         7j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711548449; x=1712153249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9NR3I1lvrj9At5Q7ZdH6jHjAjFjQwA+LD/Cvlyba/g=;
        b=VuzhZYRePcgWpS5+he8uAsHkc3ylnVwf8HIK2c2IKzHVdan3aUpIYqCbOIaLTJeyAi
         amVvutEccVr783/DkjeL0K04qQqSe+xIf4bcN45Yv8WC3k4k7j1bR+whNAoqh/yUAfQG
         bbQLkmWLiu/V0LmKiEAMu+VlCFaWTws7X5PDOOM+dkrTrVrcRjj8LSBX6elF7Auljbb6
         6B+rgPRD+rCghtSSBRnYr90jWmRqSnvRZ/IRRPoPaOhJc0R944qaRtIDDszjp+gYxa38
         T3DcnXpLUhjTTonqa2tO3SmNfhNcBxRxzVMJKyOsRL/3HAr5/jV/ctz7qOHnTUYPLvMd
         z9rg==
X-Gm-Message-State: AOJu0YxQwIqVhDbUxpp5cjM1EQYvP60lAVLaREZl+P7RxlzTBshPDuNK
	+1y00jzNYIRU1dzUYkGgXjhJlYN8c6gsFjreX3Qr57PQWOCKqJTRy481CeOiVSQ=
X-Google-Smtp-Source: AGHT+IEilOGasBVM+UOZEr0UJZf2caoJxbYCxyihyLmQfIQ0u7QwgsHINcQJfIJ66tWyULCRWCSEkA==
X-Received: by 2002:a05:6a21:394a:b0:1a3:a76b:337c with SMTP id ac10-20020a056a21394a00b001a3a76b337cmr56906pzc.16.1711548449576;
        Wed, 27 Mar 2024 07:07:29 -0700 (PDT)
Received: from [10.254.186.57] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id m9-20020a62f209000000b006e6bf165a3asm8002394pfh.91.2024.03.27.07.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 07:07:29 -0700 (PDT)
Message-ID: <95a41821-6bae-4934-ac3c-9f720dc9a703@bytedance.com>
Date: Wed, 27 Mar 2024 22:07:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [problem] Hung task caused by memory migration when cpuset.mems
 changes
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, longman@redhat.com, hughd@google.com,
 wuyun.abel@bytedance.com, hezhongkun.hzk@bytedance.com,
 chenying.kernel@bytedance.com, zhanghaoyu.zhy@bytedance.com
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 01:26, Tejun Heo 写道:
> Hello,
> 
> On Mon, Mar 25, 2024 at 10:46:09PM +0800, Chuyi Zhou wrote:
>> In our production environment, we have observed several cases of hung tasks
>> blocked on the cgroup_mutex. The underlying cause is that when user modify
>> the cpuset.mems, memory migration operations are performed in the
>> work_queue. However, the duration of these operations depends on the memory
>> size of workloads and can consume a significant amount of time.
>>
>> In the __cgroup_procs_write operation, there is a flush_workqueue operation
>> that waits for the migration to complete while holding the cgroup_mutex.
>> As a result, most cgroup-related operations have the potential to
>> experience blocking.
>>
>> We have noticed the commit "cgroup/cpuset: Enable memory migration for
>> cpuset v2"[1]. This commit enforces memory migration when modifying the
>> cpuset. Furthermore, in cgroup v2, there is no option available for
>> users to disable CS_MEMORY_MIGRATE.
>>
>> In our scenario, we do need to perform memory migration when cpuset.mems
>> changes, while ensuring that other tasks are not blocked on cgroup_mutex
>> for an extended period of time.
>>
>> One feasible approach is to revert the commit "cgroup/cpuset: Enable memory
>> migration for cpuset v2"[1]. This way, modifying cpuset.mems will not
>> trigger memory migration, and we can manually perform memory migration
>> using migrate_pages()/move_pages() syscalls.
>>
>> Another solution is to use a lazy approach for memory migration[2]. In
>> this way we only walk through all the pages and sets pages to protnone,
>> and numa faults triggered by later touch will handle the movement. That
>> would significantly reduce the time spent in cpuset_migrate_mm_workfn.
>> But MPOL_MF_LAZY was disabled by commit 2cafb582173f ("mempolicy: remove
>> confusing MPOL_MF_LAZY dead code")
> 
> One approach we can take is pushing the cpuset_migrate_mm_wq flushing to
> task_work so that it happens after cpuset mutex is dropped. That way we
> maintain the operation synchronicity for the issuer while avoiding bothering
> anyone else.
> 
> Can you see whether the following patch fixes the issue for you? Thanks.


Thanks for the reply! I think it would help to fix this issue.

BTW, will you merge this patch to the mainline?


