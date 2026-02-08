Return-Path: <cgroups+bounces-13771-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM50Kljuh2mUfQQAu9opvQ
	(envelope-from <cgroups+bounces-13771-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 03:00:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDA107966
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 03:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 371103006690
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799063090D5;
	Sun,  8 Feb 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVakoOX0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qxNMvmAN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577A1A3164
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770516051; cv=none; b=DxGJkDdvqladXA3qKMV+9EVq/TePRuBICVppfN8ZzNUo//vXPytO3PRfuq9RMANJX8ie1JUt0JoKKpYmOIe8hAnLrk/gILHwWOxYEwAwLGx3+XyVABD7uAGvQo6DKd+CdADZbVVCuKt7DUplGqp3J6MJPOMflIC7nCC3HYHym6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770516051; c=relaxed/simple;
	bh=k/52INH8GyEadxGakCCLL4rMhjYRUVyVZopaV2PxmcM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z15RopKb5UY+aYU6MtEfdmqcpHgQvHl9MdCAs5zH1Yh/kBGZRz5gUzYyrrmICym1wH0IYhMavFZ3NYPbdhhbS1WKyVWImftqUwaNJECGlojdOcESD94bccsSBAUH7MQJmp3k2ePIliZ3zfhXU1umOZ1IJoiFl65c5sRrhrJQc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVakoOX0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qxNMvmAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770516049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehzROgKFMFthllC8CHPpVVo0jz1By/sLiuctOrPjOCs=;
	b=LVakoOX0TIa8jRc5PtSn810t/OllS6jLk8ag9HOj9KbJZ4RN9JkMostK9obWebpt+u9WeX
	0ejKpTkK+C+H0r7wmwB35jFIQXK5rjVBNmKKK9TRU3myOYQyFLjjrz9VY+jOnhx1LpdyVD
	swemRQVWmZEpE6mrYfFdWf8Xj7+s0LU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-62Uek9VMMIWfPJo13tQYfQ-1; Sat, 07 Feb 2026 21:00:48 -0500
X-MC-Unique: 62Uek9VMMIWfPJo13tQYfQ-1
X-Mimecast-MFC-AGG-ID: 62Uek9VMMIWfPJo13tQYfQ_1770516048
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50333a8184aso117382601cf.1
        for <cgroups@vger.kernel.org>; Sat, 07 Feb 2026 18:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770516048; x=1771120848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehzROgKFMFthllC8CHPpVVo0jz1By/sLiuctOrPjOCs=;
        b=qxNMvmANY3glUigpsAx/cb1UY71K4dIFNTA/TQr0iAn81IWhRI+B2xSyRYk6I1pZ0i
         l/JZwYFDzvjPMD5mgtz2+SEyRnzYJ1levyQsTA73mehdlL+++go5Q2TCtG8urFg4cHv/
         Jc/w4ALwHishXwXt96owXYOmPXn8X8Ay0V1axYfXR8H2D6D8C0272prTKQhRgCmWbsD7
         Jyyl/mNbyWyGiQzXUG+w4KBUsfPuipTHYGJAjX35abAJUNCd4VX7sbuIIgE4Dd2fK5G3
         IdZgDhxWNTNg9zpt5qkcnsS8dxaNaM23pMK9972NZwesYizc8XlWQoEWypxQQdB0kWsg
         ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770516048; x=1771120848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehzROgKFMFthllC8CHPpVVo0jz1By/sLiuctOrPjOCs=;
        b=RzMQWApwlzBBxY8aWxLDH0bfGTr5CbnG+ZOrThkH2cNUexPgKyKlvNPAlhZMV7BScR
         qitWoQckGK1PU4kMO0yZIb35JBbYb4ccQFfuHqtF1WSYzIrge3HHMkCkAWevRS/WiY5C
         7LsYNYeQEMyC5p61RCj8Ol7h5HB3W35rRSEE3Ea9r4H497Fipqk7pkGkFMIINEUh9fZp
         CXTSikQ6oAqkxxXjRrrLk0BfWfKszxaOmBtQw6uFgRL717eDHUwtRt82BaIdgo/ehAFu
         TSNh1wEv74PJrChnjRJ+jhkmkasWyN526mXWQBEmeU0Mllkp87ePpC0h5mhfrddfTxl1
         IH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEuecBiLzAGGlSm+iI+Fxsyf/Jx9JRhDjfA7ADdeTvCx54Ah+Uceo+Pn2Lz/RW/GnBKEXPjHXM@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2a8dfX/7xVLqCLDyk8fxmCiukns8ZD40QC5EKQFlg3HREHeg
	hV/y+kpI8FGCF9Ade15V7ceJ9GxfqCEvZV0WSlr53d90R0IbqDIOtsOcurqtNw/UPSkhB8cvo3S
	xmT/0n7cJRWcjkm1o0sEJPuyYx7++FhYVpAWG1OCSjHgzvrKbR+/pweWpf3c=
X-Gm-Gg: AZuq6aLbJH8xuVMXZbrG5D6XfJN38SH4oenfyXqQ5H7LzV7QR+dUEUu6l72Fn4ySEqL
	3CqunBHiU4qnMLPRByLEt1q9SVmX+kAtdsaUcEKys8s98FQq6fi3tfdwGO/ZoNHcRQE3D2Oss1W
	IRkFgtEoMJNO2PPchbVfcOSUeOOaOfDHp1jmw+at/7QLvEvsn/NoTZe7aMhZwduBxqR4H8vL92s
	Ah1bpKoDJ52hyoeu3kVX5nZyX2BHW4F6LX2KQiuR6XqIsPrTaYSjBXwSp2sH7lF2QyIZ0vgP7WX
	/wzMa3pBF3OkDuGsHSXNH+42AHOCAqlr/5IgR1UtC1eJw18nvG6WLwnQbNUrgSaKfM5wjcm0JKb
	ur3RSGaqWH3RUKtv+ejKAf8efM2bfHQ+2xwIQKvk3T/P3sm3d6kkKa60n
X-Received: by 2002:a05:622a:13c8:b0:501:3e5e:b027 with SMTP id d75a77b69052e-506398fe05emr101988851cf.19.1770516048046;
        Sat, 07 Feb 2026 18:00:48 -0800 (PST)
X-Received: by 2002:a05:622a:13c8:b0:501:3e5e:b027 with SMTP id d75a77b69052e-506398fe05emr101988501cf.19.1770516047672;
        Sat, 07 Feb 2026 18:00:47 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cafa3bff8asm493432085a.51.2026.02.07.18.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 18:00:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d1e4b070-9438-4152-847e-ef6ff6aa7820@redhat.com>
Date: Sat, 7 Feb 2026 21:00:45 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 2/4] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
To: Frederic Weisbecker <frederic@kernel.org>
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
Content-Language: en-US
In-Reply-To: <aYZrJaIIbTX4E-nO@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13771-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DDDA107966
X-Rspamd-Action: no action

On 2/6/26 5:28 PM, Frederic Weisbecker wrote:
> Le Fri, Feb 06, 2026 at 03:37:10PM -0500, Waiman Long a écrit :
>> The update_isolation_cpumasks() function can be called either directly
>> from regular cpuset control file write with cpuset_full_lock() called
>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update() directly
>> from update_isolation_cpumasks() will likely cause deadlock. So we
> Why do we need to call housekeeping_update() from hotplug? I would
> expect it to be called only when cpuset control file are written since
> housekeeping cpumask don't deal with online CPUs but with possible
> CPUs.

It needs to call housekeeping_update() only in the special case where 
there is only one active CPU in an isolated partition and that CPU goes 
offline. In this case, the partition becomes disabled that causes change 
in the isolated CPUs. I know this special case shouldn't happen in real 
world, but I do have test case to test that.

Theoretically, we can add code to handle this special case to keep this 
offline isolated CPU in a special pool without changing isolated_cpus 
and hence  HK_TYPE_DOMAIN cpumask. In this way, we shouldn't need to 
call housekeeping_update() from CPU hotplug. I will probably do that as 
CPU hotplug will be used when we make HK_TYPE_KERNEL_NOISE cpumask 
dynamic in the near future.

Cheers,
Longman


