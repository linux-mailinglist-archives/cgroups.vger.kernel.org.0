Return-Path: <cgroups+bounces-13814-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCPnAbBBimmwIwAAu9opvQ
	(envelope-from <cgroups+bounces-13814-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:21:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9975E11461C
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD285301D311
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CC33554F;
	Mon,  9 Feb 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAI7xkkZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZakpooa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9582333447
	for <cgroups@vger.kernel.org>; Mon,  9 Feb 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668457; cv=none; b=gyphfhXGAZcwKAkgiv4ND10nAATXcRTLgCMN5xUntAvsHebQ1lmY8PqmnylwGs086GOXW+1eFD19q91zpo5ZkbGW+kSaMOrtfRbdC3ixCTlwm8l67aN++qs0yOPipV0Vq0lM+9uyQy+TlG1ED+p/syqKa6VzgQOjbyelg5d7qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668457; c=relaxed/simple;
	bh=GB/u68ld+Eyp8AH4JqN9tcHOTLiMBq6jmzErDgxOy1c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aakCGGNmiSycf0N2Aw7lNrzUbpuvnAAMQcm00wGtFr8982aS3HEPMSKnf+PcfEoDdZczcTUAzSY8h/zFN+LHrud+QYQY2bGTjmWFA5NkY9ICSif/1F9bCC4u0WYVJcYTz6dqqY7q6QZ4iD9//7r6oyoPKkhIMyxjcaANfZrluog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAI7xkkZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZakpooa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770668455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ3P6U64D3dIwQ6JMmzaYcb4sLc7KKAd+gcH8cuFSaI=;
	b=dAI7xkkZRWS2qg3q2KCYlv0bFCCFi1ly32ssJq9ZNzyj2hwX/AJhzauwrq7BcknnzPNW03
	vFqf0sITF8O/1RCy2dp8xciZ4miqRaCaAVf18q+wzam2XKB9OP79CCErWjmHq5rCrmhbfF
	+MVOrRqToKHKHdUa0MldOUU4p2GU/70=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-aH3N1yaVOfCewTOKkd7-VQ-1; Mon, 09 Feb 2026 15:20:54 -0500
X-MC-Unique: aH3N1yaVOfCewTOKkd7-VQ-1
X-Mimecast-MFC-AGG-ID: aH3N1yaVOfCewTOKkd7-VQ_1770668454
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6ad709d8fso1211032585a.1
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 12:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770668454; x=1771273254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJ3P6U64D3dIwQ6JMmzaYcb4sLc7KKAd+gcH8cuFSaI=;
        b=OZakpooa7xNnfCsyGOM1eagBB7hiZoRR4yqFqKSLJZrPYR48Qgu8c6Cz4MJO6anRou
         phugegH4MvdlBrlBWOV0c6bJeIjgtuDHS8hvmdQXEY+/nvaHclPHBGx0L/7/wEsNShGX
         3SqlpPMEkSX83JlkPgV+qf1r9oSGGDt8Q6MbfXEuRR/5xeebTUbS5B7ZgHY2csFEehQw
         V4LUmQFMTio6FQ/okVrSMB5x17z9eZB0LcE4boM4T2F18ghqJEJThGLFVgwWlKUq1k+U
         N4MjFu7NdO3+lFGJUCUUR/E/51JefxWf3eIToKgBPT4FYP0C8KLW6gsZYcjwtoePEI20
         vlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668454; x=1771273254;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ3P6U64D3dIwQ6JMmzaYcb4sLc7KKAd+gcH8cuFSaI=;
        b=J5JY6vvZ2qX+OV9jB74ZhxXLbkohValI27xJQKbSMriVGXz8yEV4oXxRVQMcCBs3My
         UIXmM1IGslG5JDtSLdIMfPFR1lWoSB6x8yR6C4YAJrKFzeLkM3oCqBR0mCZepD448weA
         GYRT6dcPRZ1HU/wcZwtHsTDuQwBlsRn3KNVWdk7/qGrEhhIseU3TROo8iIzyiBAljhvN
         y0ag6cRlFiT3mF9Yl3YKBBoZZ9wn9609R1KuiRuUqpeVWBG3HU1Ec4EXyiSQnT77YKR+
         jfViqaOIGIinqgfz4zJmzALC/x7KzInBzCxNK1Zl66DtQ/pLD/m/Y3M/EwlP51GUcwK5
         zIww==
X-Gm-Message-State: AOJu0Yxb9CeRjy+gB8bAH2bSw/oof2NV5HYtE3+zYQ2Qi4zhN9n64Olt
	gv6ruJYfh8TqueSjnkPAAriR8QfLlaztqesH9jFVUvJMTtyDo0WKB3/lIcTfTiKhTHjvA3f7xLm
	iUNqGF6C6EjhxqNDHn3z8ju8H0hiP+CIQJzOpcM/xy2QW4c0ClTCf/xKprkQ=
X-Gm-Gg: AZuq6aJqBtgA97n0ubaOFxrULkHgoNB/9L1MSvwO9RSUMkFYOBnuUdgpppar6uXVF00
	Re5v7JBGO4fGR6v4SGHmIQjhoQK4mSq2+nR3xrHu0DFbqH2nMV6dt7JFztCyhGG1AIDoOmcd9n9
	D9m1aMop/NkTMQDsmMKbpnOibk2mteF5CNETdJD8RUn4Fa04vrXUQ8rgsFLUzLeqFHkxQeqvskh
	RECqUEMWV4SnpX85hRaAs3BsLKtwIpGwu5QKIEb9jip3xJTEzSBQJfGplt788cd6VtrkGviZOm2
	EZmNQE/0g/CdS0r2ByAkjeQqVg+Keti5SWJtce8rIn4Jm0RWZNQbA4pQrM+AVuJt0lT1olTHyvV
	yN56vt8++R1lR6sZmMIDvIBHErTrLCDW+gTSeYWsY0f3HHnB8aG49p31I
X-Received: by 2002:a05:620a:4048:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb1edb93f7mr11489485a.28.1770668453976;
        Mon, 09 Feb 2026 12:20:53 -0800 (PST)
X-Received: by 2002:a05:620a:4048:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb1edb93f7mr11485285a.28.1770668453604;
        Mon, 09 Feb 2026 12:20:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6c16sm868811185a.10.2026.02.09.12.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:20:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67f4b01a-7b23-49c2-a8db-059316300d39@redhat.com>
Date: Mon, 9 Feb 2026 15:20:51 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
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
 <20260206203712.1989610-4-longman@redhat.com>
 <119981d3-1cf9-412b-9b4d-bc4bcb188104@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <119981d3-1cf9-412b-9b4d-bc4bcb188104@huaweicloud.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13814-lists,cgroups=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 9975E11461C
X-Rspamd-Action: no action

On 2/9/26 2:23 AM, Chen Ridong wrote:
>
> On 2026/2/7 4:37, Waiman Long wrote:
>> +static cpumask_var_t	isolated_hk_cpus;	/* T */
> Can we get this from isolation.c instead?
>
> The name probably shouldn't include 'hk', since it refers to the inverse
> (housekeeping CPUs) of isolated CPUs, right?

The housekeeping_update() will create an inverse of the pass-in isolated 
cpumasks. As for the name, I add hk to indicate this cpumask is for 
passing to housekeeping_update() to update housekeeping cpumask. It is 
not directly related to the cpumasks in sched/isolation.c. Please let me 
know if you have  a suggestion for the name.

Cheers,
Longman


