Return-Path: <cgroups+bounces-13536-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SODqCtcLfGkEKQIAu9opvQ
	(envelope-from <cgroups+bounces-13536-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:39:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2ABB634D
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 797383018753
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665A33122A;
	Fri, 30 Jan 2026 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo2zQLFW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="szet0zew"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AB32A3D7
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737172; cv=none; b=rOTjYHWaf8hmiI2S42BdgdGX29GsDZzySdOQjvzIlTMnY+uCf7o7s8LLOgKC4yS10/g96Ql52dmLHkUJI02TTJlOLyHcmcdVtktnWMG6u4ROY06zrXtrkFhRcN/AqAWrRMAQsd64/Mi3qcE+AGzQ63uQa7iIw9d9+KXsWpRyotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737172; c=relaxed/simple;
	bh=wdrxh6fAU9PLk/GqfeQNSeG4evn0JGL+pWgjOkSe0ao=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFKpvMw3IdFBfnEFccZu23nu/1R7c9u7h6qDe9RPW7VYRu6eIADiWMbPyuuw4wNuEd0jNuWXORz3yWOBKSXp/IzJIl4K+LsY8gWBSv3mEf7/jHsX/kT7zXqYrGKCJHtTD7++eycjDDDqJAk8U8LqXM//zKxaBdItB13/qyvyxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo2zQLFW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=szet0zew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769737170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaA0XM1BuGEr30lghRFkS4AIRI2kuTOe/L3KaghInyo=;
	b=Eo2zQLFW0IrYePeKbgLodL7vKqX96F6rfssCTRnuXcWUdAJl6WWzl49mS4YCRZ3i1fEGQt
	tPGExvai7TwqTFawvoyOn1p/f4FY4B3n6eWs09ekSvQGWI1I8EsDFN8uhZRtBpC5nhpSvo
	DzlNMCW5IcTI0kPPAwqc6Eehy6XY9JY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-zKutDFE_Mzmh_PMYUVPzMg-1; Thu, 29 Jan 2026 20:39:28 -0500
X-MC-Unique: zKutDFE_Mzmh_PMYUVPzMg-1
X-Mimecast-MFC-AGG-ID: zKutDFE_Mzmh_PMYUVPzMg_1769737168
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8887c0d3074so55510896d6.2
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 17:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769737168; x=1770341968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NaA0XM1BuGEr30lghRFkS4AIRI2kuTOe/L3KaghInyo=;
        b=szet0zew0O24ee5MOrTxNz8/fpYQSlSQLn1fE2aqxU/gT8mJjmVT7FkAUHKuTxGJhx
         1qZOmEhsXfxaulZWwGf8ETGjxMQvcNONzYd68j/7kFBhPGxaSWlrp4uuXeO66359/+4S
         e3F02Nwe5LGftT+Qj5fPYF8WkF2/DBljmEJTutONjEUiRJFg9N+1tYpz244qAKbJsw1m
         6CR2gdEJV3s+/qzhwT4bCICrdTXjE5mqPFHKV0YniYdf+3+6b/8lqWjNidCfv5K9sPbf
         yRsthn/oFbc9oHvfC5By6WlfiJBGun1oVxZm2tNwWeZz4OWwe7md1DcJKfmGLfRUidkQ
         IaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769737168; x=1770341968;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaA0XM1BuGEr30lghRFkS4AIRI2kuTOe/L3KaghInyo=;
        b=tQEEAdpjqsHFLvJJgtuM3jglMk0HRv+jHWI+bnYrBRtDisZ0x98VGEIjXEfgWz3X6d
         yvx5/yEd2dFU0KWBLYlCNHDgsHzu0As+1FEKq8duswggPqbyLy3YoJb6kYKNoKXws5WG
         8AWYJx8v/bbKxZn+MrXgAMOqyOgJVEeDBa1hXduivllkESxZZBoUvXDLtOuzfHb1jBD7
         tMH3+XCWqraCxCMw+FCi1+JyB27mZxZhy3qfvQcD1jGV4JIfMQHCa5Baa0BmFV+MxUiG
         Y9U2PkTRuJGF2GgS9WOtLS/K0IzSlln5mCDaXyXh8RBNBEFgh2eMDkkJkPgZI7+lBCp2
         taEg==
X-Gm-Message-State: AOJu0YzOB5KC3oP+o+63ZM7+iGiHhpITkF+5G+U5dFFe2y4GR/6s0L4C
	IcdCEvQq2QcTvXW/ejJcixtIAhdZ/IxH17cG1/GNPHt4rN64X5UQevVFjxfrkazm+g52jeICo0/
	ymsyUSZKElXGyc9wo5b8XHMFU7eMOnk8nokcjFZ6jtT/JrcbBN6B+fA7xYmU=
X-Gm-Gg: AZuq6aK05MyesonD7/R10JOe/fog81lz6LgsBSMf42Boync0yr8DGSNyGr0qW4+a/TE
	cvK/1Rc/0NKQhIg1hbGStLmUunTNagXUqoH2tHD2daIXEEWZhfFtbxilWu3V28NyUlKRoiMwvvT
	ouwdkFN6GtGN4HbNsqa4mcZsGyAklgtdY3eQ7dXtphL2hmgfka0QrHphhADrivNNLuM3xZDe3zI
	rbwd3TtQvHagMN/tm9Ch2Bn0K6tcKmbo8dbPg5A1DhLFwkXLEhKjUZ7NNPLG/sbOphpLRRftE5W
	ErYYdyLbBOl2Df7b0g0ZkNPlMKv6e6NabCqQdnZ/bptmfWWH4gqB5JWz3lYyqEM0JWeKnjObyU9
	sYG/gMhTN89QzFi/tCZCLkMfvirdaOi0D/HN49ET2isbyQ133gwtmBPYf
X-Received: by 2002:a05:620a:170c:b0:8b2:2066:ffca with SMTP id af79cd13be357-8c9eb367818mr204894885a.82.1769737168084;
        Thu, 29 Jan 2026 17:39:28 -0800 (PST)
X-Received: by 2002:a05:620a:170c:b0:8b2:2066:ffca with SMTP id af79cd13be357-8c9eb367818mr204893485a.82.1769737167757;
        Thu, 29 Jan 2026 17:39:27 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm49112516d6.45.2026.01.29.17.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 17:39:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6b89aa68-9b12-45f8-bb2b-29e0de67d107@redhat.com>
Date: Thu, 29 Jan 2026 20:39:26 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 1/2] cgroup/cpuset: Defer housekeeping_update()
 call from CPU hotplug to task_work
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
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-2-longman@redhat.com>
 <ccca8790-2bf9-46db-b355-ce8695ea7093@huaweicloud.com>
 <4d192246-d795-4f65-825f-5e4a413cae32@huaweicloud.com>
 <2ac13ef1-1fb1-44a9-9bb1-a82338bc27f0@redhat.com>
Content-Language: en-US
In-Reply-To: <2ac13ef1-1fb1-44a9-9bb1-a82338bc27f0@redhat.com>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13536-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B2ABB634D
X-Rspamd-Action: no action

On 1/29/26 8:37 PM, Waiman Long wrote:
>> The hotplug path just calls asyn_update_isolation_cpumasks(), 
>> cpuset_full_locked
>> and isolation_task_work_queued can be removed.
>>
> Thanks for the suggestions. I will adopt some of them. BTW, I am 
> switching to use workqueue instead of the task_work as the latter is 
> suitable in this use case.

Sorry, I mean "the latter is NOT suitable in this use case."

Cheers,
Longman


