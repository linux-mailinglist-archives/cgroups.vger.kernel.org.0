Return-Path: <cgroups+bounces-12766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF3CDF148
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 23:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EFD30047A7
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6B800;
	Fri, 26 Dec 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0pJk+UB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZnPWdDm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85286347
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787424; cv=none; b=f9QcXRzNVNNrAQySGj3t3duaNAzE3Iq+q511IMKnV6b/2/9j0JFdU7o/nG5cOhyHIbT5u1Q9TW/88tm79td0VlXi+rl0Ul5orLNvMf6KnCjO4GkGx+XsqVcjsKuljKHu6XILHuo7k0WLhgoHckpFu/XDhDnC7v++6fK2EP+tCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787424; c=relaxed/simple;
	bh=K7jrXMCamOjh0o8gNLafIFaofRuPpjA5ujgvXl1Ddrs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B4ZaerD6SqO7QZ3nVXd7qlMV11tsf444t71ag/wpBCc+XDzABjIWiW1b6KQdx00UNuaOmuJdu2SRtpfBtzo8RhVf97bJgCUL2IXTE3xeTdpaQB4nhYfXw+2lDCsJvTIqayDLrCuL2l+0C+n9SvOY7UKbzkw4h50vK1SlbB7VN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0pJk+UB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZnPWdDm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
	b=d0pJk+UBil7d0TNuXgVSAFqSsz1UkHMD+fhnWvxd2VU79CI/VKTpCKYpMJH7xiQIxokCt4
	Xq5M636MDoPCsC6InRJb/TvcbKzvuZgdCgyBjddreTDCZ9A/Q8SA3mcw3xbn0lKhC1vf8X
	wr7P3l0c7OCIGk2JfW3LtoyTLBDpJAY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-0HsUsB9NNCKuuYcsxiv1SA-1; Fri, 26 Dec 2025 17:16:59 -0500
X-MC-Unique: 0HsUsB9NNCKuuYcsxiv1SA-1
X-Mimecast-MFC-AGG-ID: 0HsUsB9NNCKuuYcsxiv1SA_1766787419
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0c1c57bcso275436321cf.2
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787419; x=1767392219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
        b=jZnPWdDmBeHLIjSB7h2/OdxQx/d2Cxydu0/9C8QTALGQcDT2AYZEdOSXBcP5WAKnUB
         CdfeBH7kvPmwrL4MvrojWpFB37z4tmCCncerf/KILZa4R2kY7baUSvSunLoC6uQAmWKb
         jECC3PYtRfh7Y7uluo3z0riiK1MMYMgj8+Ro+ba3r93f389pDzBfIKUTUNZtB5el4GNs
         R2DrDSA6BNtd0cd1bKRnYJC23muYBiPlhgICpmR/iTAzc2U5dX/fZW1kZFmcg/Ic98Ax
         q/MVQdJMPCo764auu+8uy+Uhy9rePrkh4UB5HcCaTf00pd0eXMJ0UB0/tUzUQByEvjBo
         bFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787419; x=1767392219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
        b=vNNlIQtpu0nHIbIu7UXgOpO2oIAp8LlU/iqE16hSFWjkBwSoyyc8Ii3z5mDgkLNwWA
         dJbwGk5eG2PGAKATZxSwX6S7R8McPdhogxT8CuKFp7SYC+h5C8/+LV4L7J0UeSAHsWRT
         9sOxzUA7PQWTJ0DSi/7QivbGFB+bbCd/1WAdfcfW2q0iTTCUNXvlsC0Bj7pe44H9fefq
         THjNPu7KMo2aD58zW8Na0C/xQr7nb1EXYEB7iDdB0noblqEtcPJDbTspPV+nluaqgyLZ
         i7r+qKo7bCcBQsdJrnAYQnmKEcsDXllmIMO9y7MG85cK3pCp5QSllCujuqpmCCv5fOqY
         pC/g==
X-Forwarded-Encrypted: i=1; AJvYcCW3q9YHPa/Fm1NQG0S7ky57johYI1z3HlNyEyjjRG/Z2EKMliUdxmuEHVesnHGFesmsQ7hcviGv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7T6RmThY2omg1NXfOSSHwpjXLRwbRwMhYUyD1++keiJWmOq1d
	i+9wvHSv/V7E8PxV0FoyApSbGQgF2xQh+W/IRUaLhf8RsN3Ev3S364fYVYcz1wlfCAcVEU4v5pV
	yAmC3+o3gd2iq3ycPsKrV5fjXkVL7o44+QrZ9ODXe4+7SZS5gMZsM8dOdHgM=
X-Gm-Gg: AY/fxX6mdVxylOuMtZWrYa0QfW1sWciJ0fQ3Cg3ksD+2bCqpG5KZocU0yUwFJOqUwlz
	UspXDSUszNGBJ66dOl/MyaJhXPGLa+uObsrhork75Kh6Tfi5tPg1403ObMTMztVNxzGrTvz6qKR
	bl6+Tz1r+6B8GoXB0iuKTa2RXZd/ALISzMUP4guD3W9h1tvlI7oYhHZ5G1QMe8HdtSnWJTq/T00
	csBBD53thIEg7avyMsV5Okqp4Sn1YuHLC0v1KxjPamiHYawNAjiu+avfC+D//45+EUCMFU/wV9v
	26gfJVJH5vjnMa4JXQ0vNXxU3TQbkm0D/kkleBZiiFtLwth60zPvINkTW4IamK03asgBXKKm5bZ
	CNl7AoHvszlp5mryAA4c7HVj4oEUjEBehiwko9o3pNtW+ASHKIyNc37+/
X-Received: by 2002:a05:622a:cc:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4f4abd801f1mr367336461cf.51.1766787419321;
        Fri, 26 Dec 2025 14:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRvuLHSyqUpCT4r+1J8I9GjzOXah9qpvn8vbYEiTnx2y0sMdtY9oMwdnxWWZ/KZalKRQ1OSQ==
X-Received: by 2002:a05:622a:cc:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4f4abd801f1mr367336221cf.51.1766787418961;
        Fri, 26 Dec 2025 14:16:58 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac54adb9sm164334711cf.10.2025.12.26.14.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:16:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <46a613e8-cf5b-4fbc-9299-48ab1a6f347b@redhat.com>
Date: Fri, 26 Dec 2025 17:16:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] kthread: Rely on HK_TYPE_DOMAIN for preferred
 affinity management
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-28-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-28-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Unbound kthreads want to run neither on nohz_full CPUs nor on domain
> isolated CPUs. And since nohz_full implies domain isolation, checking
> the latter is enough to verify both.
>
> Therefore exclude kthreads from domain isolation.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 85ccf5bb17c9..968fa5868d21 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -362,18 +362,20 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   {
>   	const struct cpumask *pref;
>   
> +	guard(rcu)();
> +
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
>   		if (kthread->node == NUMA_NO_NODE)
> -			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +			pref = housekeeping_cpumask(HK_TYPE_DOMAIN);
>   		else
>   			pref = cpumask_of_node(kthread->node);
>   	}
>   
> -	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> +	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   	if (cpumask_empty(cpumask))
> -		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
> +		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   }
>   
>   static void kthread_affine_node(void)
Reviewed-by: Waiman Long <longman@redhat.com>


