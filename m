Return-Path: <cgroups+bounces-13832-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Tr6vEi5Di2nLTgAAu9opvQ
	(envelope-from <cgroups+bounces-13832-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:39:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E611BFA5
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF5E3024A50
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA303803C3;
	Tue, 10 Feb 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFfzvWUQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhFX/Jrh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E736B05B
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734377; cv=none; b=lPF/113q/pUxoZZOwM0PzWsYX3u6AgwPcZ4dIcxZ/8HdVoIPF59NsBtz3E/H1gY9KQ5A5feHuNLNnhxEUvfGmljL9pLk5Dh5mOMQKQQDL+hcD3mHgkyp38d2jyK5tlR2Q8zq+QyT1btlW6mMYrKLwqsgUReZ3fzMoPW2PKwph6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734377; c=relaxed/simple;
	bh=vQaRXm2+AQXIYLnEQ4jVzPZq4om8wNPyfHiJq2lspn4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UNrvY9fhsJ2lTF4NDMjyjWbejvJXyhVzEsViz4tteizq42Vnu3HUUhxKh8wNyc9cyoCp5w7MHwVr6OJSgGse5kpx9hLNEunEFIykgxMccOMRv9ZK9nHJHQfVljRcqaZE0A5O9Iu0nYd7THuCfFaeg+tl+Exrrphaa93jTJmEkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFfzvWUQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhFX/Jrh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770734375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoguIq7tMxRUKFK+t5O/JiWw37kAXp4tCRjW/Z7hpYg=;
	b=XFfzvWUQN1urUgunvbyK+E+nNhDmSfPs8SGnlMgqa3cRw9br63KojYjyipc0uCqVY1qd3i
	5WARe4Voy2L5ey8NwtwF+4A1eRqqmw9bqce8GR7qsUB8X2ymYlhVr1+453DtC0SQVAz6L9
	FZaH14rkCo3b6EF410g3795stg0+tj8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-V6V3Nvv5MtWb-fZJwDWy6w-1; Tue, 10 Feb 2026 09:39:33 -0500
X-MC-Unique: V6V3Nvv5MtWb-fZJwDWy6w-1
X-Mimecast-MFC-AGG-ID: V6V3Nvv5MtWb-fZJwDWy6w_1770734373
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50355952ac2so159009871cf.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770734373; x=1771339173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uoguIq7tMxRUKFK+t5O/JiWw37kAXp4tCRjW/Z7hpYg=;
        b=RhFX/Jrh/uwhlMLD++hGfd4S1ZX8p8ZjVlJQCzf0OOMXdf4pjJVJcrGg13+40vb4Iz
         H1nSqaR61TyCMFuhqy9BVp20j9sNAMrmwZqA+8Yktyj6c0kkvoGd3ouk942jpTk5M69G
         jNX15Rm6BxV3aLqOJw5xMBRZUPpIQS4zPT9GEM3IbcyJRa3GxBj9fbT9CC4Yb2OCmkiG
         A85PjCcbZI2tymZUW1QYvkLSvFxWugzBiyVfn0hNWKh34QBD6MqMp7RAVsZAdoPegOON
         9FMkWD9cWGMisgvks181yN3B2R/EZDkUeT1Eitu9VOL7AVWDiWbj17n+Xh9m8gu9lhot
         Hwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734373; x=1771339173;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoguIq7tMxRUKFK+t5O/JiWw37kAXp4tCRjW/Z7hpYg=;
        b=ZaSeJIiJ6k2adMbfqIZwBjtotBjIjel3gRxaZuEIkyDacKrOq+57kbSvuJZjXRn2vY
         UtGtClZTr1YaXNtMIXVoH7r571TMnNCzAhfL+oxOlvU5uD5WRtUHx+1+1OI+OV3kctP6
         H9HG8Z0i1+DOXc2F1pNDOjJciLLFAovhvBLkKmAZczKtiu7iJJVb2NyZHtcEVmssEQVR
         ttTGmqfBwXmO2AluN5CNdC4UwcmF/4JJymP/WU87s2v41LkUKRJPpeV/rgWc48NBugaC
         nZZEC7V8v6DpsCvYz2bkVn8Gflj9Iw8aurv67UyU4ZZiiNI8F4P4D+kD83oSvjFGTnzx
         FjcQ==
X-Gm-Message-State: AOJu0YxPeHqBpEcHH+Ev4B+LuaitjqM4DM0US0BA8SV9cm8ihj/foSZC
	K3pybIOb21cX7XnCf5rZ9cC1mM+tlu+Yk6KJx6AfHobcrIs5igzC2E7vRk4A0aBTSfIHEP2M/3R
	eOQrFyF3Xg2HEVUNRoNe7aV4NkMF3bxh/GVY/9tWGXKVOMSK58tCVMOSgAYI=
X-Gm-Gg: AZuq6aLvfzmt38qZI7XmIJR36n68OyJ5/SMi+NkazAjU8QLw0bLvAY19g3HzzJnw3k5
	NQHWupYwCGsFO6i3rjc/BSb/yWLoc53xv2AJiMsx8V8dCcXO6/s+0JX6mHDIBzUFLgz5xGBfwiv
	o6C8f1YBCNM/gVcW3xIqv3KXpVjwZF77rlFU+Nv3SAshEsyOQJXWUKKjqrLIcsV8XvoZrygUqsB
	iw0VCnZv++qlnUDa4nVkT3Hk1WGIeCUKlHosLBHCeBQU5FuFa/zFzqMys3XSntww9GIcFH02w/o
	UrLnYjPx+QTfi7W+tkhAH8RM3wo8kZJAQY43DVkvVTmJnti/eEhJZKc7Th9BdOL5ix5sANYZhQ1
	8H9Jfcgu6u+ep52RRySEJgY/+AiTeWVF6+BOy/rvbb/dwobOupGlMXGxh5lyJlFlaax0W
X-Received: by 2002:ac8:5d92:0:b0:501:40b2:453d with SMTP id d75a77b69052e-50672e23c11mr29070571cf.23.1770734372858;
        Tue, 10 Feb 2026 06:39:32 -0800 (PST)
X-Received: by 2002:ac8:5d92:0:b0:501:40b2:453d with SMTP id d75a77b69052e-50672e23c11mr29070231cf.23.1770734372411;
        Tue, 10 Feb 2026 06:39:32 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392902eesm99012571cf.21.2026.02.10.06.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 06:39:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b1193a25-f38d-4f4f-bee0-565fc7b7402b@redhat.com>
Date: Tue, 10 Feb 2026 09:39:30 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-4-longman@redhat.com>
 <119981d3-1cf9-412b-9b4d-bc4bcb188104@huaweicloud.com>
 <67f4b01a-7b23-49c2-a8db-059316300d39@redhat.com>
 <08776cf5-054e-4137-9ce4-f193feeb2599@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <08776cf5-054e-4137-9ce4-f193feeb2599@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13832-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A60E611BFA5
X-Rspamd-Action: no action


On 2/9/26 8:39 PM, Chen Ridong wrote:
>
> On 2026/2/10 4:20, Waiman Long wrote:
>> On 2/9/26 2:23 AM, Chen Ridong wrote:
>>> On 2026/2/7 4:37, Waiman Long wrote:
>>>> +static cpumask_var_t    isolated_hk_cpus;    /* T */
>>> Can we get this from isolation.c instead?
>>>
>>> The name probably shouldn't include 'hk', since it refers to the inverse
>>> (housekeeping CPUs) of isolated CPUs, right?
>> The housekeeping_update() will create an inverse of the pass-in isolated
>> cpumasks. As for the name, I add hk to indicate this cpumask is for passing to
>> housekeeping_update() to update housekeeping cpumask. It is not directly related
>> to the cpumasks in sched/isolation.c. Please let me know if you have  a
>> suggestion for the name.
>>
> I understand the intent. However, when reading both cpuset.c and
> sched/isolation.c, it can be confusing whether isolated_hk_cpus is an inverse
> mask, since in sched/isolation.c “hk” consistently refers to the inverse.
>
> How about isolated_cpus_applied?

Applied to what? I did add a comment to describe isolated_hk_cpus as a 
copy of isolated_cpus to be passed to housekeeping_update(). "hk" in the 
name refers to its role for being passed to that function. I can't use 
"isolated_cpus" for now as it may get modified by CPU hotplug 
concurrently. In the future, if CPU hotplug no longer modify 
isolated_cpus, I will remove isolated_hk_cpus and pass isolated_cpus 
directly to housekeeping_update(). I don't think we need to spend extra 
time bikeshedding what the right name should be.

Cheers,
Longman


