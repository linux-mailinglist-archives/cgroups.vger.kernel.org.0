Return-Path: <cgroups+bounces-11757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2BC48FBA
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 613C134AEFD
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26B331A72;
	Mon, 10 Nov 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8l3KWm2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA6321F31
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802651; cv=none; b=QithBzKV+0sdANQYEJtU0YxudZ8CpxWHHV3CnnHiYbX98OYmFg7dlyOIH/32+macVChtD1AoTd+Drb4P3uOrt3Diw4iPjso73SDUR8IU9OOj4rNpTd+Is1XSCKPu7ZeqGLdtH6QTf+J0eyUri2PrAGedSpFwB9Ios2gWlXwMUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802651; c=relaxed/simple;
	bh=KtWEwtg7MDJfegORsZg1yms6PhzLTV6xv9D+IvLBI+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG+GID1dePBjOyWUhvIxDerjC3LBhy9tLB8IzbAJaUyYZHXwzFQiaLgL/tNrZozn7n0q/QMMFVG/QJSnpGgoZrXk2+c4+cKjNwcblfOOa04iw/HadqQTsFXJKoNEApUQN9MnMIGbul4I+UkDbf6apPGagPHPiEW0cORE3D5o6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8l3KWm2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298144fb9bcso13504345ad.0
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762802649; x=1763407449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aZiAriaFpcSO4WwPdL0RMujLkTEysUvR5KxZIxL0hk=;
        b=j8l3KWm2pDo9Kw53yv6aMJaJeE9bxY/G3o1UAqtCsq+mp1S5jGbqDYyiM6DourmeJB
         We1G3j1ng+VpqDJhEZ7yE5+JWINO7ZU07M//FoBcHM1LXkLSorg/mgWFfMOmsf8eYqBb
         1paJhfwIEevLkG9CyBv+G4BXBtKUxSaIeY/Y0kSXbVh4P480j7NiddRXH1ht7fGMIDOc
         +BSWzF4aCtQ8ZIsap36OhOefiI1bE5cBOzoGE1+W9yz6t46CQWSTpJ71zeg4uEHXpeGN
         ek2N2euvBhL2bQK0HlqZCK0pQqamrRyEnS2O7eXXKoAJatsBEidPGT5bmLRCUXBPjxIy
         6JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802649; x=1763407449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aZiAriaFpcSO4WwPdL0RMujLkTEysUvR5KxZIxL0hk=;
        b=XiF2hz7HdPuj6gxQrQzcMVTtd9SNdbGvhRDq1ludKSHTQ6eJDRVsyZknxqyf1Tl6vp
         rrX1pa7gr3ubwBVmsMzvc2SrAenbpXHyoxLaHMD7IXwcmknwAAsZUR0HaguWp8f5hEbT
         w2TZp9LVsFM5RE6MiHGt6G2YhgHoAI3HYDUZU1GI+TuD/pWoSenWERVFUEBfjD+BB86w
         CkxT3sLczw4sX5tzqt0jSLgcQ/U7E17V1qgQrsk/cdFipDvB5uemurEddsy2ZkRCqbNo
         7g/zj+Wbrt1SU7ZsTLVKjkyjj09yTgEk0pOOZ1NCh1szlfcflOructL+NKIG59WkmhD1
         PFpw==
X-Forwarded-Encrypted: i=1; AJvYcCULI+Dkgbsjl8adU3LADUtzVjIT+qoylx3E7ekOqnAu6n9AtmY0XJO4Dud8UaAovE3SbLDbq+Dk@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZk1EKUOoHNuHDm77w6W+tSGrG3kRtyGyWEpkd4EC+UIqCcmq
	/yY1iCYU/jAO3VvktH6YOOozvNpCsQfP/5ffaFRYnlDAbBMHIfV1GpgY
X-Gm-Gg: ASbGncugnbqmXlV1UOnfUAy0GnmyLUjVFc82KqWWmUbM7gI7FYgfpfU63GHQaKK676Y
	qkDa9vRNPBPcxNj9tz/COtwdvsgLv8ZSgu1+9PQ3y9Pmr5IWx2ROFh9NTh1jS/FVqBTLD+UYUQ3
	QvtSBV1xSzeTU6NIwq1H2wcr6msMPmkXAT+02JqCku3jdtdJrgiku5r+SPWoHcsOG9xlUMG7Y86
	Vh1cXk2ofb1pazFZisvFSRTla7VHPbnaShWrMq8LHYc8V5cz0LIobIGLijPprY0IMGfLZSt1bZz
	paGk4x8nhA7YCZSIcrQHTR6q/+ooTncqNrUOF/q0y4OK/G/P5W1hvOd7OjaAPM1cvntYvCBHAaa
	/ACej216wvpRxheYPq7aQqj+7E2X789mKa5JNK4SLV3WkMDp7oLpnNmAeKg3SJKRPtIEgIlm3Op
	v7QjXA9vbVllW3nHRw6j0JF4JlHiaoH1XYXle0/M46XWUi
X-Google-Smtp-Source: AGHT+IEfAMgWyE3Ndc3ssUFwIgGkinkSWPsXOWikHUjdgiJLp2PdUMQ1cJ8E1GKkTroGDK1oj6VzdA==
X-Received: by 2002:a17:903:fad:b0:295:9b9a:6a7f with SMTP id d9443c01a7336-297e571290cmr120832745ad.49.1762802649165;
        Mon, 10 Nov 2025 11:24:09 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:9ac6:a0c2:ad3d:6884? ([2620:10d:c090:500::6:8ce7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509680e5sm159021765ad.1.2025.11.10.11.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:24:08 -0800 (PST)
Message-ID: <51f1f343-c29f-49b5-8016-bbda4bc778a2@gmail.com>
Date: Mon, 10 Nov 2025 11:24:05 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
 hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev
References: <37aa86c5-2659-4626-a80b-b3d07c2512c9@gmail.com>
 <20251110062053.83754-1-leon.huangfu@shopee.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20251110062053.83754-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 10:20 PM, Leon Huang Fu wrote:
> On Fri, Nov 7, 2025 at 1:02 AM JP Kobryn <inwardvessel@gmail.com> wrote:
>>
>> On 11/4/25 11:49 PM, Leon Huang Fu wrote:
>>> On high-core count systems, memory cgroup statistics can become stale
>>> due to per-CPU caching and deferred aggregation. Monitoring tools and
>>> management applications sometimes need guaranteed up-to-date statistics
>>> at specific points in time to make accurate decisions.
>>>
>>> This patch adds write handlers to both memory.stat and memory.numa_stat
>>> files to allow userspace to explicitly force an immediate flush of
>>> memory statistics. When "1" is written to either file, it triggers
>>> __mem_cgroup_flush_stats(memcg, true), which unconditionally flushes
>>> all pending statistics for the cgroup and its descendants.
>>>
>>> The write operation validates the input and only accepts the value "1",
>>> returning -EINVAL for any other input.
>>>
>>> Usage example:
>>>     # Force immediate flush before reading critical statistics
>>>     echo 1 > /sys/fs/cgroup/mygroup/memory.stat
>>>     cat /sys/fs/cgroup/mygroup/memory.stat
>>>
>>> This provides several benefits:
>>>
>>> 1. On-demand accuracy: Tools can flush only when needed, avoiding
>>>      continuous overhead
>>>
>>> 2. Targeted flushing: Allows flushing specific cgroups when precision
>>>      is required for particular workloads
>>
>> I'm curious about your use case. Since you mention required precision,
>> are you planning on manually flushing before every read?
>>
> 
> Yes, for our use case, manual flushing before critical reads is necessary.
> We're going to run on high-core count servers (224-256 cores), where the
> per-CPU batching threshold (MEMCG_CHARGE_BATCH * num_online_cpus) can
> accumulate up to 16,384 events (on 256 cores) before an automatic flush is
> triggered. This means memory statistics can be likely stale, often exceeding
> acceptable tolerance for critical memory management decisions.
> 
> Our monitoring tools don't need to flush on every read - only when making
> critical decisions like OOM adjustments, container placement, or resource
> limit enforcement. The opt-in nature of this mechanism allows us to pay the
> flush cost only when precision is truly required.
> 
>>>
>>> 3. Integration flexibility: Monitoring scripts can decide when to pay
>>>      the flush cost based on their specific accuracy requirements
>>
>> [...]
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index c34029e92bab..d6a5d872fbcb 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -4531,6 +4531,17 @@ int memory_stat_show(struct seq_file *m, void *v)
>>>        return 0;
>>>    }
>>>
>>> +int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
>>> +{
>>> +     if (val != 1)
>>> +             return -EINVAL;
>>> +
>>> +     if (css)
>>> +             css_rstat_flush(css);
>>
>> This is a kfunc. You can do this right now from a bpf program without
>> any kernel changes.
>>
> 
> While css_rstat_flush() is indeed available as a BPF kfunc, the practical
> challenge is determining when to call it. The natural hook point would be
> memory_stat_show() using fentry, but this runs into a BPF verifier
> limitation: the function's 'struct seq_file *' argument doesn't provide a
> trusted path to obtain the 'struct cgroup_subsys_state *css' pointer
> required by css_rstat_flush().

Ok, I see this would only work on the css for base stats.

SEC("iter.s/cgroup")
int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
{
     struct cgroup *cgrp = ctx->cgroup;
     struct cgroup_subsys_state *css;

     if (!cgrp)
         return 1;

     /* example of flushing css for base cpu stats
      * css = container_of(cgrp, struct cgroup_subsys_state, cgroup);
      * if (!css)
      *     return 1;
      * css_rstat_flush(css);
      */

     /* get css for memcg stats */
     css = cgrp->subsys[memory_cgrp_id];
     if (!css)
         return 1;
     css_rstat_flush(css); <- confirm untrusted pointer arg error
     ...

> 
> I attempted to implement this via BPF (code below), but it fails
> verification because deriving the css pointer through
> seq->private->kn->parent->priv results in an untrusted scalar that the
> verifier rejects for the kfunc call:
> 
>      R1 invalid mem access 'scalar'
> 
> The verifier error occurs because:
> 1. seq->private is rdonly_untrusted_mem
> 2. Dereferencing through kernfs_node internals produces untracked pointers
> 3. css_rstat_flush() requires a trusted css pointer per its kfunc definition
> 
> A direct userspace interface (memory.stat_refresh) avoids these verifier
> limitations and provides a cleaner, more maintainable solution that doesn't
> require BPF expertise or complex workarounds.

This is subjective. After hearing more about your use case and how you
mention making critical decisions, you should have a look at the work
being done on BPF OOM [0][1]. I think you would benefit from this
series. Specifically for your case it provides the ability to flush
memcg on demand and also fetch stats.

[0] 
https://lore.kernel.org/all/20251027231727.472628-1-roman.gushchin@linux.dev/
[1] 
https://lore.kernel.org/all/20251027232206.473085-2-roman.gushchin@linux.dev/

