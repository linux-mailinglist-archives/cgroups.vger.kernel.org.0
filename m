Return-Path: <cgroups+bounces-13618-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KDpCcVIgWnNFQMAu9opvQ
	(envelope-from <cgroups+bounces-13618-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 02:00:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC007D3343
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 02:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E263F3038F0D
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 01:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578B21A95D;
	Tue,  3 Feb 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y74EcxfG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeZ9+QIn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC4224240
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080395; cv=none; b=NFCNA9f99T/og/dmit4iLgde6yHXszzowuebaMq8CQOa2w52nB6072CE3XVTyokeeKlYWfa600qGbqG17GJ1KB43y4A+SnKEfYl6C/XlMIypxR7KwWH+TfOHyNTPsIzMuc/NNx48XWYHPfRIqcZfOT/igS4OvVwiZar8NfZMeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080395; c=relaxed/simple;
	bh=gpORPuaOpk6tojkOwt62hlPXrsXqI7Yp6L3YHtKbwR0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MArTPEJ0UamnI5s+Gn3XGv3ZczwiL//6KnTRdCMvpRpCZQJMPFhGw18AfNWF0/Mn+dlhS2Yb2NqhaQXn992uSAY1KciBPavZ9nbpnhRT4x6ECkzQrFWR/kMj8mE/EO6iY0aXvMWMcFQXMoPgLE99pnWe7u3zq/glWBGSUGAJAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y74EcxfG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeZ9+QIn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770080393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKRfDEEvMLgrDWFTBlm5/V6r5Jaf/qoxoTLe5hblhdE=;
	b=Y74EcxfGYIIhnL0Krh9JjlbTgHGxnZgm76AWvaPF5KyShUrCuMo9tKzs3nbs3n65+Wp0+7
	QAwpCucf47JFTxP9+NB2gGrHHuKnzB/rsqSvBL2ArQ1dfzFVpe16i4WKUVZPFFDQxEnkqj
	snSI/DTjBB3+cSdDhMrzhDuJsDb3d+w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-_3RxcFGdPXO5FJXNvh5vrQ-1; Mon, 02 Feb 2026 19:59:51 -0500
X-MC-Unique: _3RxcFGdPXO5FJXNvh5vrQ-1
X-Mimecast-MFC-AGG-ID: _3RxcFGdPXO5FJXNvh5vrQ_1770080391
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-502d38a3e39so65832821cf.3
        for <cgroups@vger.kernel.org>; Mon, 02 Feb 2026 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770080391; x=1770685191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cKRfDEEvMLgrDWFTBlm5/V6r5Jaf/qoxoTLe5hblhdE=;
        b=VeZ9+QIni7chDO1l4SrTEIyQKhIslA3Xw7uLgbgltsclAAWH93dUnCHzjejagiF0Ml
         X5wHArfJn7kLFi5escB2ajiDRsE4JMhII+sc2YY2k6nBBLsVt7ZVLT19a2AecWX8Q+NB
         19wsQuOJQUAbuj6LfUsPYBUgbcWv5b4FcaciA1EOu075RPuDf2bmKjyCB45jkNj18E9x
         Y4WToMZ0JyeVBUM7G2y/lq6pM/xZH6t6gWEPrcBkswTrPLp9BLT5aFguQpwMcG907fJi
         zh6XHhL8FywviKa7vDkCm6yaCZyfqUwch6M1sPn5OnHJgzEveyfzbGTLtyse35JOnNWU
         SMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770080391; x=1770685191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKRfDEEvMLgrDWFTBlm5/V6r5Jaf/qoxoTLe5hblhdE=;
        b=ezIWl2/kltTp6n/flcpkGpJf/QGcLUM0VdrmK05Bc6a/d2l2AVh9Gd0XA0gGVph/oU
         d9xAc1k6OjuV44qdmKQpFb95byi3eovl1AXPb15T5JNF+tCLtyJkZeeBKJk2cKb6Zj0Y
         RWXMHKKk3tL6ZMfc6VXHW+dtzpRLXZ9dOAmTDTLtznPF/4wY9tgfXs+tTS2JBueR3mDW
         OlyrTo5LXa89HIy/4xWuby4eV56HdRtgR62q7RtpY5eWRhmrj4JGcJzuuR+3gGzIf1vb
         Oev5D1ftjKEi0SHI7Ph9Q2ojm7evO1g1ej4aYxm+7uRYsZkUT9NmnvaZ+HmIdqBIGq3J
         vy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQu3bmsgQHr0A79kOoCz4LCy78O0/G/p0KNpmu9Yj2itHMFYeFuU6kcbsb4xkx56TlqUWuY08J@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUOZVPj3zjZkoQqT5MXc+Lzf9O4BsKofQSXc5spnyoy9Uch4B
	Xv77ofURb513DqlWLmTH/oHI87evFP+ICg8xr1fzjFKo+UN2msDSkw+dSqquvqQbwuIvTDXmTIc
	FSxIZaPBm1VlyXotuHn1AcUIkapyibZUxG0bMk2HDBaKzJQtksp7cHYyoEGI=
X-Gm-Gg: AZuq6aIbW4oLIhzoIXYX6KoJPa9n5OdNxtP4tiOHSO1ahBQ5K2KE3I2Uu6sdx5ZZXOB
	saJwNNa0TgovfG/K23LpKteGZ0A/ZNcv2Sqz1fut162cZA/2KdQ5sbPeHczlzl1iRmpbfwWVQGZ
	0j0U5NlzRcBYjBc3xQCS13oKtnQvaAWwPlzy85HvVwsoqKQx0QIVPPC/dPPiMR53tj4ss301V1G
	HDH8lX6wUzGA1FVZOmGAzn9nzJ+Y6k2my8TrG9/tZpUVph0KJtOWHWE1Pvf5ENZ8W6OTwzNXPV2
	9o4C7uOsn+1uprdl5SjwEPU+DJXrGIRD0rpgt8x4iak5aKqHmb39ROcl6QgvK6NMVuSmB4261Ui
	Fuv/cRz+4i1JIasHHRqvqtKpFQf0xQ8M1aXLPrF2r6vZUyWX7imd27JtB
X-Received: by 2002:ac8:5801:0:b0:501:4b67:1210 with SMTP id d75a77b69052e-505d2291118mr190414591cf.56.1770080391380;
        Mon, 02 Feb 2026 16:59:51 -0800 (PST)
X-Received: by 2002:ac8:5801:0:b0:501:4b67:1210 with SMTP id d75a77b69052e-505d2291118mr190414341cf.56.1770080391015;
        Mon, 02 Feb 2026 16:59:51 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bb9d21sm115683351cf.26.2026.02.02.16.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 16:59:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c529e9e5-9ba4-454d-bec8-40f39d456ed6@redhat.com>
Date: Mon, 2 Feb 2026 19:59:48 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-2-longman@redhat.com>
 <20260202130526.GE1395266@noisy.programming.kicks-ass.net>
 <ca4e6c43-2bf3-42b9-91eb-dfce4777b5da@redhat.com>
 <20260202200457.GJ1282955@noisy.programming.kicks-ass.net>
 <20260202200610.GD1395416@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20260202200610.GD1395416@noisy.programming.kicks-ass.net>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13618-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: DC007D3343
X-Rspamd-Action: no action

On 2/2/26 3:06 PM, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 09:04:57PM +0100, Peter Zijlstra wrote:
>> On Mon, Feb 02, 2026 at 01:21:43PM -0500, Waiman Long wrote:
>>
>>> Yes, I am going to remove cpuset_locked in the next version. As for
>>> __guarded_by() annotation, I need to set up a clang environment that I can
>>> use to test it before I will work on that. I usually just use gcc for my
>>> compilation need.
>> Debian experimental has clang-22, but there is also:
>>
>>    https://github.com/llvm/llvm-project/releases/tag/llvmorg-22.1.0-rc2
> Damn, copied wrong link:
>
>    https://www.kernel.org/pub/tools/llvm/files/llvm-22.1.0-rc2-x86_64.tar.xz

Thanks for the link. Will play around with that.

Cheers,
Longman

>> See: Documentation/kbuild/llvm.rst
>>


