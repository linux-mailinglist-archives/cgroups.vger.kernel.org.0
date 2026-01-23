Return-Path: <cgroups+bounces-13380-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JYDFvrecmntqwAAu9opvQ
	(envelope-from <cgroups+bounces-13380-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 03:37:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F240A6FB7B
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 03:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 584B130074AE
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E42DC35C;
	Fri, 23 Jan 2026 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcjmv093";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tN98pa/u"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4E1C5F27
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135857; cv=none; b=Lu9x4z4vD+Oxd/yUqfuLoky+MkC44zKjFsDzDucHym5frt6i5gdJt7swibl2qKYB6i0kZYLmLM9zEVR/RCa3nUFYWnGdKqZMV7LFK3Z7LKSRzhJpY4pkBK5CubDF3AT30pucl5QfUIRB6eyUdsRXHpoC8v4+j4+Q9+CtHxHnwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135857; c=relaxed/simple;
	bh=nZITKJErlso2Bgz5Ln+dPDBQXJ8NIkNHCKM8j6U7QsM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SX3nYzQgt93Hg+01yBjyv1EwOdH212BczZlDIBIgnEk7am9XCtwieCgUn+zW/egUzeMVlK9cnD6Nk6qAFUHogLQvTg+lRIcOKb7giRj8FKHRHjqSksCBDxl3aRI6vL0niMp8yuSAPTA8TfQtjGp5lbLT8UAzoewDT7vB16a/5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcjmv093; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tN98pa/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769135834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzvqH5BbVW02qcza+OTtMnYW0YDbZKhWCWlfBaXwkWw=;
	b=fcjmv0937EwQwGhD9HW02k6RZRp7o13YT+Evctr1bfyCN4+PoaTxWYx80euCAsE5NK1j7W
	Y1EievmpSJbW4N6UpjU0ulOSoS1jkhAMctclbFXThh4ke83qjHxmyJ1FWvHwxuaPpyUXzr
	Yl9j6/nndZjGc2T0oIozNZ0h8WSoM0k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-N73vvdAIOva9KlpmPEXw_g-1; Thu, 22 Jan 2026 21:37:12 -0500
X-MC-Unique: N73vvdAIOva9KlpmPEXw_g-1
X-Mimecast-MFC-AGG-ID: N73vvdAIOva9KlpmPEXw_g_1769135832
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8905883e793so41004576d6.2
        for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 18:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769135832; x=1769740632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BzvqH5BbVW02qcza+OTtMnYW0YDbZKhWCWlfBaXwkWw=;
        b=tN98pa/u+Vs29fBgZN7BU8xID9l38eiqMAyAfcrfzDi61mBhBdFloFB9MhIBKlcpJf
         +hnSgBJBec8Bbh1VVsmi7IV1EUM+JD8Ba83PpKM6a4ZDSiec0AsrFWw0fpm9ljOIKsxL
         e+vHXvRWJCSwGXMgINOva7pl2dbce5sKoSj7WmSzzCZpErO0dBBVhSkDvlX+xIcLYGTh
         DO1bPobUUlxGZK8u/6izTGxL12n/OVfGmqiNOwEMmX00jLAsaMBn/UdE+0PFtdcTIeU4
         NUFXRb6EbOFdrfJhfi/3azs3UlxK1n/p9rMvc8RxIoqMULI0Kuxz6U4tyHq6MH6pD2WN
         Tb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135832; x=1769740632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzvqH5BbVW02qcza+OTtMnYW0YDbZKhWCWlfBaXwkWw=;
        b=jZHPmNxfAcbUczRcOKJ5M8AqcunabCraRG4g5Qpblz8YZigfPtaDvXv6woa5ui5zrz
         tsgqXu3ouZE2YGV6PMWfsQXFRKkELaxeDauPZKfd342zy+AsifgWfvRae8DdUO3ogq26
         JQfFhxKHEopQ6PFbzPXl9+VC6PbEo7fw8lhIfdvMv1RXjawJAlTftMz/GKkkJU4lWkSw
         rWygaK1b3nqPrrHB7xibcCmyQxne+bPpF2sOwGrlwBDQW8VQ/wMW6WU5Ah09Rki7iCq8
         rgBoEWgeeeGIFVUjQ4nyQRlTSfiq5P71+VmJ8xIZ0S70pQQB7RCF7FM6RENjPk+Mpi4f
         R/rA==
X-Gm-Message-State: AOJu0YzWjSBs+EcKPDYgERddtv/Lkbv+fdWKHPLUR/Y5bsghgljlXI8V
	ZBDu+EZaGyVZYlwOAJOnNLoK8NY6vetJFl4vewO0sc8i9Zz8SKWCzLDkB6zgj2kgesul77kaGy7
	6S2kEIBeewb1c1Aseirkjo4g+jeGU8BtBv7wraG6gVKlHr5qWYkOZqEo5GJw=
X-Gm-Gg: AZuq6aImjb64yPBNzxapuaLmIY1TCFQvgMur3pHG80J595pTwVcsZxHls9Uk8KUY2A6
	nisColDuzvrhSdc/RH5WmvMBr94WrlFiAOhUBgRscW5c0i6Vr7W94zOHe50bqUakIPS07Nx+uCJ
	AJClRYlgUfDqunzsPnvg/1g0zyNBr+YNcqUa0f0J5YBAeZlxqHMMDLkbSgUlMWVfF9s/hz/bEOl
	zJ+FzHzer7hfjWgMDqrmL9j5ZXsHBpRRPlyBMe6QHeyjbQ5s0xUu5PjTUAyGPOuuG5qn9feICsc
	aihjwARbtAK1e4l+G8Ky7rRYYf/CFcHM/JyvPr+TgPAeaoaTz7/8zQ4f3OPBi2OqLk1gU9t/kXb
	PdS7QZ9TW1k3Ixcu3d4HYk8qF0/hWhsBPLlDUU+6E0vLBpPFZy3qGkJkJ
X-Received: by 2002:a05:6214:19e8:b0:88a:589b:5da3 with SMTP id 6a1803df08f44-89490188fe4mr26637916d6.6.1769135832140;
        Thu, 22 Jan 2026 18:37:12 -0800 (PST)
X-Received: by 2002:a05:6214:19e8:b0:88a:589b:5da3 with SMTP id 6a1803df08f44-89490188fe4mr26637756d6.6.1769135831744;
        Thu, 22 Jan 2026 18:37:11 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c661fsm76246685a.1.2026.01.22.18.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:37:11 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5a6bd6f6-7dda-4665-9308-4ae8b0d64c9f@redhat.com>
Date: Thu, 22 Jan 2026 21:37:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sched/isolation: Use
 static_branch_enable_cpuslocked() on housekeeping_update
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260122080902.2312721-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20260122080902.2312721-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-13380-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: F240A6FB7B
X-Rspamd-Action: no action

On 1/22/26 3:09 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The warning is observed:
>
>   WARNING: possible recursive locking detected
>   6.19.0-rc6-next-20260121 #1046 Not tainted
>   --------------------------------------------
>   test_cpuset_prs/686 is trying to acquire lock:
>   (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xd/0x20
>
>   but task is already holding lock:
>   (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x72/0x10
>
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
>
>          CPU0
>          ----
>     lock(cpu_hotplug_lock);
>     lock(cpu_hotplug_lock);
>
>    *** DEADLOCK ***
>
>    May be due to missing lock nesting notation
>
>   stack backtrace:
>   CPU: 11 UID: 0 PID: 686 Comm: test_cpuset_prs  6.19.0-rc6-next-20260121 #1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x82/0xd0
>    print_deadlock_bug+0x288/0x3c0
>    __lock_acquire+0x1506/0x27f0
>    lock_acquire+0xc8/0x2d0
>    ? static_key_enable+0xd/0x20
>    cpus_read_lock+0x3b/0xd0
>    ? static_key_enable+0xd/0x20
>    static_key_enable+0xd/0x20
>    housekeeping_update+0xe7/0x1b0
>    update_prstate+0x3f2/0x580
>    cpuset_partition_write+0x98/0x100
>    kernfs_fop_write_iter+0x14e/0x200
>    vfs_write+0x367/0x510
>    ksys_write+0x66/0xe0
>    do_syscall_64+0x6b/0x390
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f824cf8c887
>
> The commit 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from
> cpuset") introduced housekeeping_update, which calls static_branch_enable
> while cpu_read_lock() is held. Since static_key_enable itself also acquires
> cpu_read_lock, this leads to a lockdep warning. To resolve this issue,
> replace the call to static_key_enable with static_branch_enable_cpuslocked.
>
> Fixes: 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c   | 2 --
>   kernel/sched/isolation.c | 4 +++-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 392ce795656d..a26ccff55bb7 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1308,8 +1308,6 @@ static void update_isolation_cpumasks(void)
>   	if (!isolated_cpus_updating)
>   		return;
>   
> -	lockdep_assert_cpus_held();
> -
>   	ret = housekeeping_update(isolated_cpus);
>   	WARN_ON_ONCE(ret < 0);
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index ef152d401fe2..3b725d39c06e 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -123,6 +123,8 @@ int housekeeping_update(struct cpumask *isol_mask)
>   	struct cpumask *trial, *old = NULL;
>   	int err;
>   
> +	lockdep_assert_cpus_held();
> +
>   	trial = kmalloc(cpumask_size(), GFP_KERNEL);
>   	if (!trial)
>   		return -ENOMEM;
> @@ -134,7 +136,7 @@ int housekeeping_update(struct cpumask *isol_mask)
>   	}
>   
>   	if (!housekeeping.flags)
> -		static_branch_enable(&housekeeping_overridden);
> +		static_branch_enable_cpuslocked(&housekeeping_overridden);
>   
>   	if (housekeeping.flags & HK_FLAG_DOMAIN)
>   		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);

Good catch.

Thanks,
Longman


