Return-Path: <cgroups+bounces-13841-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CVbBwx/i2kzUwAAu9opvQ
	(envelope-from <cgroups+bounces-13841-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:55:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A030A11E750
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B96B3052361
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75138B99D;
	Tue, 10 Feb 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCLbCuvZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFQMHz2G"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AF38A9DD
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749604; cv=none; b=JG04exrnX0WNde3hK/HUAAsUKAigYMC9M09MT5t+TQY7AZgxvC5CAXMpT9lDmh976+KzrEc4agRzXj1MXH+VSCwC7ScFJBZbjlGuhA4zpqtZYkghduMzVH9QcRxldS/at47TzPcf3rZeQ+z21qNWAjKCicdgzMWVLuOSf3wcUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749604; c=relaxed/simple;
	bh=ykjrQDv3pQtbl1gvs1znR3inIiH9de5tevEToQRU/qg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YDjpiQ/NU81Ib/NwSKH2NWqycYZRkJ2WTXC76agLI0eCczO6UabIsR8f9epfMf4q7DxW0B9kNyr3xtvzWIXVoaN1IT6RV10Nzma+aRRmW8CU/YP1KdVoGkGiySzxu2XH+UrszQPgjrpeJvyCpffs/Xr01or/HC+Bdm2PvW/EgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCLbCuvZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFQMHz2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770749602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/eGIcJVf8/JKYHo3YPe7ZsYm/3Cem/DaAGFEvHE21M=;
	b=PCLbCuvZy3ZqkfydyLaFYUpAMQsiIlbzb+hr0FxH/Z448xtSe1a1yuyfpVRCERpnLGxUqu
	k0dXkyxLXCNIS5ntAtOL/9+wFC3ZmHyYhUnYobUZm5P/RXOvRQvurzc5O4nLkQwlpjc0qR
	bmAe+PZ+SaUzgjWLVpMfOTS0IVl2Y68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327--U6iyUbqPvSKyISsvY3PRQ-1; Tue, 10 Feb 2026 13:53:20 -0500
X-MC-Unique: -U6iyUbqPvSKyISsvY3PRQ-1
X-Mimecast-MFC-AGG-ID: -U6iyUbqPvSKyISsvY3PRQ_1770749600
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c538971a16so318901085a.1
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770749600; x=1771354400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/eGIcJVf8/JKYHo3YPe7ZsYm/3Cem/DaAGFEvHE21M=;
        b=jFQMHz2GUrsjBuK1ipUhybqZs6rCwpdqdhteoUOqJKQ8B2Eq0hXcmG6jab1RQ7iPKr
         bnwoKyvCyzsBWk3s/t30mCMvI97S04BVCn7eQGEIhbqckqxU/pOTXcCZLiJme8qKO4VX
         GC2YxHFvOJGoK6jWzg2Qn87wqkDosMT1B/XhnWpeD4e+BTAgNxxpIXeQffOIGGw2WdwA
         CPy06gGNFm23eNEyZmEodOa6M79uNupWQjGpKoc8bkYW2bzOr1e9HYstz7IA+oH4bU80
         Wavvulgt7BUIp1uzSKLJSvNgUNXpvtaKEp9TYsaGb9qJj4NS+ZJyh6exDYwH+Qv87fZ8
         Gzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770749600; x=1771354400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/eGIcJVf8/JKYHo3YPe7ZsYm/3Cem/DaAGFEvHE21M=;
        b=CPuoHDYsX4f25rsatkYcf7w8Ngc2iXfKfcETw0lhdRO9INV01Iga5Ox1UwOY3Fb9Fj
         JA5StR59fB4Unao98h12xzxmbsxWhPynvqARnUPub0GQnLN6j3crmkJHzvO5MVyvVRK9
         x5ekPUN+l08jP2IxBhBblAfluCalnGL/BpbMB56C/8VHTtCTu2WCgJ+M1nt7uYiWgXTj
         iM4vRmB+n/fF4yRclZoahNvpfQZocjFifrttsJyWOnfJdDXSPc5iXNf7dF2nj9mLZQMS
         pg485QLVHfb3QYZ66C1oD9YlPFz0ZKjovFUu0fy5aIPY2XBeQNUvRdEnvVt+tlZrxKwD
         wjog==
X-Forwarded-Encrypted: i=1; AJvYcCVBXlP/AK2RuliWRav2Nm3FvEF545oFizW7ZAv760lN6BvbLp06w1lfuLGU0srClgFgFzJwXcr9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0PmMyAZ7l/ubiJMd6RRmu6DwwEmie8pCw9CJ+HR1G+ZXVmf1
	9COjEtF/DS1mLu6HT9G25COhTdBAsbaeBS/NmPyoGPtrgrA/U6TnBdAWw0H61ga+Yye3R+/G282
	hCGSl0J+tHxDUc57s5glMchU14b+0ExlcwekAs6XePr1s7EZdiqP7TlLbZ9M=
X-Gm-Gg: AZuq6aIGBdInVYFUaNuO3XZRVvedX0xiU8b4sZuZ5yYwpVKLnXNdOjN6XeIL779efT3
	GSo+4NYBmpXCPPziV3AhyPdd14z+jUrCQdYBYEdJmB4odBw0CwlfztoMyv2BZqlNXGdNRLGBvQ9
	0BwZCGvHsu4ogO5BCTF3ItHIsmhf9ztxfQ81TIN+0j9nNSWFo2s1fjc4Sk9/NYesdfK14Tl7zl6
	L/I+IinaD22tOW3dj8x+PxZSxcK1x8yUz5Pptj+v5lmiF3sIJz4JTwgVGhEM4ZpqRXv31Yu853f
	g7NZOz8trKJ+5ZKLsjoxYWeGF+aJajjaN7hno5RD6VxHZRMqxHuv4idyngrqWqNnL0Qw+TJ0Cpn
	0M1RXbj7cORzN+/BwMNCLTE43vDQx0qvC4KF9WRhW3ioK7+/64Fcb5wKyojsdE0A/yLWF
X-Received: by 2002:a05:620a:bc2:b0:8b2:e922:5297 with SMTP id af79cd13be357-8caf0489e71mr2229207785a.21.1770749600101;
        Tue, 10 Feb 2026 10:53:20 -0800 (PST)
X-Received: by 2002:a05:620a:bc2:b0:8b2:e922:5297 with SMTP id af79cd13be357-8caf0489e71mr2229204685a.21.1770749599658;
        Tue, 10 Feb 2026 10:53:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aefb75sm1088129685a.22.2026.02.10.10.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 10:53:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2f4abe26-19f9-4550-ac0e-16c41d18c7fb@redhat.com>
Date: Tue, 10 Feb 2026 13:53:17 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 2/4] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-3-longman@redhat.com>
 <aYZrJaIIbTX4E-nO@pavilion.home>
 <d1e4b070-9438-4152-847e-ef6ff6aa7820@redhat.com>
 <aYtSyCb1EioSuDep@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aYtSyCb1EioSuDep@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13841-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A030A11E750
X-Rspamd-Action: no action

On 2/10/26 10:46 AM, Frederic Weisbecker wrote:
> Le Sat, Feb 07, 2026 at 09:00:45PM -0500, Waiman Long a écrit :
>> On 2/6/26 5:28 PM, Frederic Weisbecker wrote:
>>> Le Fri, Feb 06, 2026 at 03:37:10PM -0500, Waiman Long a écrit :
>>>> The update_isolation_cpumasks() function can be called either directly
>>>> from regular cpuset control file write with cpuset_full_lock() called
>>>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>>>
>>>> As we are going to enable dynamic update to the nozh_full housekeeping
>>>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>>>> allowing the CPU hotplug path to call into housekeeping_update() directly
>>>> from update_isolation_cpumasks() will likely cause deadlock. So we
>>> Why do we need to call housekeeping_update() from hotplug? I would
>>> expect it to be called only when cpuset control file are written since
>>> housekeeping cpumask don't deal with online CPUs but with possible
>>> CPUs.
>> It needs to call housekeeping_update() only in the special case where there
>> is only one active CPU in an isolated partition and that CPU goes offline.
>> In this case, the partition becomes disabled that causes change in the
>> isolated CPUs. I know this special case shouldn't happen in real world, but
>> I do have test case to test that.
> But why is that needed? This isn't changing the mask of domain isolated CPUs.
> Only their onlineness. I mean timers, workqueue, kthreads all have their
> hotplug callbacks able to deal with that already.

The current behavior is to remove the CPUs from the cpuset.cpus.isolated 
when an isolated partition is invalidated. It doesn't currently 
differentiate if that is from hotplug or by writing to the cpuset 
control files. I am planning to handle handle hotplug differently so 
that it won't need to change cpuset.cpus.isolated.

>
>> Theoretically, we can add code to handle this special case to keep this
>> offline isolated CPU in a special pool without changing isolated_cpus and
>> hence  HK_TYPE_DOMAIN cpumask. In this way, we shouldn't need to call
>> housekeeping_update() from CPU hotplug. I will probably do that as CPU
>> hotplug will be used when we make HK_TYPE_KERNEL_NOISE cpumask dynamic in
>> the near future.
> That doesn't look necessary.

Yes, I think we can use the existing infrastructure to handle it without 
the need to add a special pool.

Cheers,
Longman


