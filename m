Return-Path: <cgroups+bounces-15436-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAzoFV+G52m+9gEAu9opvQ
	(envelope-from <cgroups+bounces-15436-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:14:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF4443BD93
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 634893028EBB
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B6D3D8104;
	Tue, 21 Apr 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/BpJI8p"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07833D301B
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780875; cv=none; b=afYDNcDjtPxsQDx2FjBBf6kssmbGWxz6Y8Q8Hxssmubm2ec4Hr4sMzbGWH7WlbigkXa4gqMuFpO5ZTLG2e7wjNf8jP/3vG1q6G8PZ9hYyc9/m/zamHoLRaT8UtZwVKU/ezCgmw/wPVE04v3ZhszHtHA/oSdxAbIiRtOujaqocco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780875; c=relaxed/simple;
	bh=9EVLxOxko56ykP0XKUiXqVA16ePSpExPWd0qgmq91lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZCVG83PsjWia5FQOXDqtgdW3URGu+7haGyF0afWFwnmGW16pyYtcL3mwAS/e2Larr+MfurNt62Mrx/yI3v6172vuy9WLL1XoW/aL9dMvOhOYj8YMfP3zLf9Okmyh+fRugheonuEmPcLbrhkPyg5NIH4jIbOmJjAOqBiQt04pzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/BpJI8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776780873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkSs5q895BkMlUjroUvolg58w1rFDrf/FdQnm8MeJy4=;
	b=R/BpJI8pmJA2Q+8Fw2B4kbgYBef1jDjeudX4JEFSjA1R3gjlZrk8AgQCUYsffPSziA4G3i
	30yWhnH6fxHDSW0Tis1xHZyyEFz0Gswi0B9WMM0/5N0YdeE7Lz7zwaUWOpSYvOBOTUF5LU
	1OqemSeVcMXmPsDsG0stydLmlvmWXiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-g7Ym5ECUP9WJNDNti_MzuQ-1; Tue,
 21 Apr 2026 10:14:28 -0400
X-MC-Unique: g7Ym5ECUP9WJNDNti_MzuQ-1
X-Mimecast-MFC-AGG-ID: g7Ym5ECUP9WJNDNti_MzuQ_1776780862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1011E18002C0;
	Tue, 21 Apr 2026 14:14:20 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67E2A19560AB;
	Tue, 21 Apr 2026 14:14:10 +0000 (UTC)
Message-ID: <3b796360-81e4-4f90-9b19-8a9f21cbac07@redhat.com>
Date: Tue, 21 Apr 2026 10:14:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] tick/nohz: Make nohz_full parameter optional
To: Thomas Gleixner <tglx@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-4-longman@redhat.com> <875x5kd88d.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <875x5kd88d.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15436-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CFF4443BD93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 4:32 AM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>> To provide nohz_full tick support, there is a set of tick dependency
>> masks that need to be evaluated on every IRQ and context switch.
> s/IRQ/interrupt/
>
> This is a changelog and not a SMS service.
>> Switching on nohz_full tick support at runtime will be problematic
>> as some of the tick dependency masks may not be properly set causing
>> problem down the road.
> That's useless blurb with zero content.
>
>> Allow nohz_full boot option to be specified without any
>> parameter to force enable nohz_full tick support without any
>> CPU in the tick_nohz_full_mask yet. The context_tracking_key and
>> tick_nohz_full_running flag will be enabled in this case to make
>> tick_nohz_full_enabled() return true.
> I kinda can crystal-ball what you are trying to say here, but that does
> not make it qualified as a proper change log.
>
>> There is still a small performance overhead by force enable nohz_full
>> this way. So it should only be used if there is a chance that some
>> CPUs may become isolated later via the cpuset isolated partition
>> functionality and better CPU isolation closed to nohz_full is desired.
> Why has this key to be enabled on boot if there are no CPUs in the
> isolated mask?
>
> If you want to manage this dynamically at runtime then enable the key
> once CPUs are isolated. Yes, it's more work, but that avoids the "should
> only be used" nonsense and makes this more robust down the road.

OK, I will try to make it fully dynamic. Of course, it will be more work.

Cheers,
Longman

> Thanks,
>
>          tglx
>
>


