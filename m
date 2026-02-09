Return-Path: <cgroups+bounces-13813-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nabYE1Q8immsIgAAu9opvQ
	(envelope-from <cgroups+bounces-13813-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 20:58:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FA11447D
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 20:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64FDC301FAB0
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC9426D1F;
	Mon,  9 Feb 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipt/AXNJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbPsTO1C"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408C3A0B1E
	for <cgroups@vger.kernel.org>; Mon,  9 Feb 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667089; cv=none; b=eXStwVVf9ol6j31qjs7aDD9/4EWxaMRVYJwJzXMfAZXh6M35nk5yWohPjVFGXQM1ZI4PTE2q845iboUv9jwWtoGhDzJIxoXuGuC1gBkiMaRWffehEug5nvSBEI0Uf0wjGvgho7CdWmwTD3MZQ4HGsGO1munRE1614jKKVDyqu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667089; c=relaxed/simple;
	bh=DKxJZiDz9ccxnuuVZinzFLjD3WNJMiBa84gXZ1x7dQ0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZecmFPUNz4MJJS88/PnG5etMiG+97cA3mHqOTw3fYytMhmqfr0+YfLD2bNzX0wj04/d983iR2itM7KSg6y9iS7v+6kzCtxh1yraZ6OZlQJ6ePSIAROoFn4wfmz4GYSkhS4mWDwDwT/WH0GRfYffF98Dq52zxYcC520bI0EqX3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipt/AXNJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbPsTO1C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770667088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bS9CnvduVmoigg+neOslZilNw0RpbTWdyKznu9DDc1I=;
	b=ipt/AXNJvjlofkMQvm2lkrqzqu0+wsPcrCmPChHSenJg3N7sCrlli1Vble9V3FMXSPLImP
	te6z3fQoBE1TG+hrZkY6ZrXL7WHLG21nJjxG2NrRWmtqN1j4wyiIAm1YP0WMvKAnlSvHBJ
	kPGuDfokYr5JVqrDCj/K+pIKvS7LIc4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-hEOWEzBjNMyAPzyifqB4vA-1; Mon, 09 Feb 2026 14:58:06 -0500
X-MC-Unique: hEOWEzBjNMyAPzyifqB4vA-1
X-Mimecast-MFC-AGG-ID: hEOWEzBjNMyAPzyifqB4vA_1770667086
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c711251ac5so1352727685a.1
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770667086; x=1771271886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bS9CnvduVmoigg+neOslZilNw0RpbTWdyKznu9DDc1I=;
        b=BbPsTO1CyQ2QnaSLUH7/DCozrvgWC2OJcQWArnB9a0+4G4UKC7c4uwgf7vTSdyhU4p
         tKjMIVLg7xyx76g2thfmPGCtmWmozDw41yOFzPjUa27ztnx6C2FHpUrwkT1nt40sAo2O
         4MUkhEXMQXmOXEXiP3Jz2p4VEfm54UozOeU7K8pDqm5Oj0bJYLNjUdiQVzcYqydw+3Di
         lluepgRfZ00EQepjoETNvXDCfo7kDKgGROQm/4FBHVs7J5sTZE2IQ9AMBXgQt3egVofd
         ny0VHpxCLp46JzfvP8vfg6ZHyAsO7zaiRh7h+Zf7wRv1fXWWXtyQmqCY30Q0hUYthMXn
         shIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770667086; x=1771271886;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bS9CnvduVmoigg+neOslZilNw0RpbTWdyKznu9DDc1I=;
        b=v7uWZfCGnrDRfFYRo44IGQnEC7r9xHuiKEPwhrX7fsiuTpEODoBCFg9ts355rGqcVF
         fdzsoPbylxVtJBC2xmXz5W0cm8+JdCO92Rf+FU01HNYwYYrbHJDZek1ZCT49CNZV/YfV
         Lf3/3AfHNr7M7kiho0qlr/T7S/eC67QCjUToW4IV/jNC6siBLbxEHsGRpS9e3cey5HxO
         SqJo7tZUkt0m+jX2u6RHCPfo760Wn/Lk/Zsxk4f/NZDGCqXc/+rsxFECfeC67qwfXOjO
         1CUFY+V1WtYgnMPCY6D7VXFG7jzYvx+KtaZDyieURsq84URjrbTjhKLTKKFJfEFIwTLA
         upWA==
X-Gm-Message-State: AOJu0YxXO66kVdCF0ID281w4ZQT8Jlx1BzlenjRBKUF4maQU+ivVb2LD
	EGXJhK7VsV2Gz2P0bKxQlMYUsvQtBEaHgqar9Pxhm3z+3RwCTuMVrv06AQnSoaqOazER7lAGO5J
	5Sj7MLbMWxmctcMoYc6enxVdxixzARowfWhiMBIAbkE2eEoEXW0TLlTHUh0o=
X-Gm-Gg: AZuq6aL9zdfonphXH5qbyStMe+8YntQLf/NZUULaP1DmXit7iscUPiA99XvP2MtnaHY
	0UPloL979mh8ofnvQ0TLK+q3Z5sMp+sNVZf6bbONeCZZoRdubgM2RYSByWlxNUgZKzlJo1FV5sv
	U9+23+JYLiey+uSs2YBuuE2+b01lWZOBXvJ4gFwgNRvgnibpkHiC+XreyUci0+sJwU2/660cXte
	/Rre98uPzo2Do0O683X0tsgPklJvvCle1gE8qTbAPEwdv1xuBStBWlT0BHJzGMciPrtFLpyKOcR
	eIEPKSwiHjDGWI5hhZoUv8Qro1DoKHWHOBY0+tjkpWiu0+CSal30OO2brAKBA1Yc9xm8zJk8AbI
	YPXwWFPubgjfXP589YV3jSsHU/qghCWnH4APG7jCIuOZrtS5uA43bR1mT
X-Received: by 2002:a05:620a:6914:b0:8c5:2f36:660f with SMTP id af79cd13be357-8caf1db6729mr1621396585a.78.1770667086204;
        Mon, 09 Feb 2026 11:58:06 -0800 (PST)
X-Received: by 2002:a05:620a:6914:b0:8c5:2f36:660f with SMTP id af79cd13be357-8caf1db6729mr1621391985a.78.1770667085561;
        Mon, 09 Feb 2026 11:58:05 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89549659cdbsm64028966d6.13.2026.02.09.11.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 11:58:05 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <49b9bd3b-6a50-48f5-a06c-3e530819d2c8@redhat.com>
Date: Mon, 9 Feb 2026 14:58:03 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 1/4] cgroup/cpuset: Clarify exclusion rules
 for cpuset internal variables
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-2-longman@redhat.com>
 <c2d8e4ec-e255-43a3-b864-d82cd1201487@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c2d8e4ec-e255-43a3-b864-d82cd1201487@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13813-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF9FA11447D
X-Rspamd-Action: no action

On 2/8/26 10:41 PM, Chen Ridong wrote:
>
> On 2026/2/7 4:37, Waiman Long wrote:
>> Clarify the locking rules associated with file level internal variables
>> inside the cpuset code. There is no functional change.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 105 ++++++++++++++++++++++++-----------------
>>   1 file changed, 61 insertions(+), 44 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c43efef7df71..a4c6386a594d 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -61,6 +61,58 @@ static const char * const perr_strings[] = {
>>   	[PERR_REMOTE]    = "Have remote partition underneath",
>>   };
>>   
>> +/*
>> + * CPUSET Locking Convention
>> + * -------------------------
>> + *
>> + * Below are the three global locks guarding cpuset structures in lock
>> + * acquisition order:
>> + *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
>> + *  - cpuset_mutex
>> + *  - callback_lock (raw spinlock)
>> + *
>> + * A task must hold all the three locks to modify externally visible or
>> + * used fields of cpusets, though some of the internally used cpuset fields
>> + * and internal variables can be modified without holding callback_lock. If only
>> + * reliable read access of the externally used fields are needed, a task can
>> + * hold either cpuset_mutex or callback_lock which are exposed to other
>> + * external subsystems.
>> + *
>> + * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
>> + * ensuring that it is the only task able to also acquire callback_lock and
>> + * be able to modify cpusets.  It can perform various checks on the cpuset
>> + * structure first, knowing nothing will change. It can also allocate memory
>> + * without holding callback_lock. While it is performing these checks, various
>> + * callback routines can briefly acquire callback_lock to query cpusets.  Once
>> + * it is ready to make the changes, it takes callback_lock, blocking everyone
>> + * else.
>> + *
>> + * Calls to the kernel memory allocator cannot be made while holding
>> + * callback_lock which is a spinlock, as the memory allocator may sleep or
>> + * call back into cpuset code and acquire callback_lock.
>> + *
>> + * Now, the task_struct fields mems_allowed and mempolicy may be changed
>> + * by other task, we use alloc_lock in the task_struct fields to protect
>> + * them.
>> + *
>> + * The cpuset_common_seq_show() handlers only hold callback_lock across
>> + * small pieces of code, such as when reading out possibly multi-word
>> + * cpumasks and nodemasks.
>> + */
>> +
>> +static DEFINE_MUTEX(cpuset_mutex);
>> +
>> +/*
>> + * File level internal variables below follow one of the following exclusion
>> + * rules.
>> + *
>> + * RWCS: Read/write-able by holding either cpus_write_lock or both
>> + *       cpus_read_lock and cpuset_mutex.
>> + *
> Does this mean that variables can be read or written only by holding
> cpus_write_lock?
>
> I believe that to write cpuset variables, we must hold either (cpus_write_lock
> and cpuset_mutex) or (cpus_read_lock and cpuset_mutex).

The importance of the locking rule is to emphasize the condition for 
mutual exclusion. Once cpus_write_lock is held, no other task can hold 
cpus_read_lock and cpuset_mutex. I will consider holding cpuset_mutex as 
optional, though almost all the cpuset internal variables are accessed 
from the CPU hotplug side with both cpus_write_lock and cpuset_mutex 
held. The only exception is force_sd_rebuild (sd_rebuild) that can be 
set directly from the scheduling code without holding cpuset_mtuex. I 
can change it to "holding cpus_write_lock (and optionally cpuset_mutex) 
or both cpus_read_lock and cpuset_mutex" if that makes it clearer.

Cheers,
Longman


