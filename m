Return-Path: <cgroups+bounces-12765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E4CDF13B
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37B6D30052ED
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7A305E21;
	Fri, 26 Dec 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5/4A7Gb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRhC2VIt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A051FF1C7
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787215; cv=none; b=iSTOyBAq5A95oc8rBa5qwvKrjsWcSWL4XHTmXrMpgU+FWbh4GQtZy5fkQHV7iYTCI9RmrwM0ITGL1qgWCTon8trDmbZuq/FaLC21Qgou3HA3O7zQ0994U93Mia8aOBEJFTLa5XAnAC3g3lq7so9ngvQ3UU5okRNaAhcrl30Thu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787215; c=relaxed/simple;
	bh=38SETu3HZwoc8bpPyvY57PyJDti9cAF1uQy2Al3c77g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kr9acGCiO4NM4HEgyc4nfM6nRKGhh7d7FGwCHjttAHFkT6/RuqUiR9Upt2IG5aW6khbQDoEp3UVLyqg/HrPfdIP+trrb7q2/Che2PhZF03FlZ/5uz9ZGHU5LdkPlxi1YKSeVoj5+ENtDGse9hT5672llUX/TloXC5JrXVeoz6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5/4A7Gb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRhC2VIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
	b=g5/4A7Gb8zcN/98NWgwy6X94pzMfxhlp/uRBbr7rIHqkCixHxJQ6ucD84rwNlhiP5eqWi4
	/rmwg5xUoIggEeYf6FajIyOdyOIICT4ckyR/BTHwN1oCD2Sd4QMSqpu+DNqrgcldGdjpBD
	GdT9Co8Wyy0degMwda8VUNs6TmtrmA8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Mftyb5EqPSWSRBlc74zLmw-1; Fri, 26 Dec 2025 17:13:30 -0500
X-MC-Unique: Mftyb5EqPSWSRBlc74zLmw-1
X-Mimecast-MFC-AGG-ID: Mftyb5EqPSWSRBlc74zLmw_1766787210
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a2f8e7d8dso202619316d6.1
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787210; x=1767392010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=FRhC2VItRuJvOg2H7zCbbHgRrbqiQs7UhLao4Y5EJob/ZLXo7HRhCK0SFMQHx9oylD
         Et5xRRYE8wpnraa7C4PoZT79EZvfYkJlCpn7o+yGMGqQkQqS/Sd1uAfLsrcQpwp0Rdfj
         nHaNosZwd/L3bxQawUw66njcan+mTievdwuVyj966FFivyOzGn5UHw7h9avcAdnC2lA1
         a0qM2HhshEGXRGzm4/V6XEnhiwKBnSALZHK+HfFbAje8h9rFpjUsgqSXf6PG0pdKOMU9
         1l+EOVPwigSiRKDsy2rYt3bQ6a5v4aqnFDum2zbORqxcV7sqsOqQ7GbTByuAt8LSEPrW
         kb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787210; x=1767392010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=RZRJZSNBheJwIhqodJX2/UaiW17y3tt4USUde6ago0+MBWKCTVcQCu7DnugrXEsr5O
         x3rTncT2w1UVgk/6ULpxB+PFwxsw8N3VYlRATvK9JosvsnPnFDcvOaUg8nPSUopA016X
         yA7l42Nn/SZ6nHH/XkFFCTGI0369ECssFG8BZ5vhy47maaaGT52Vjw2Gs2Iuoa6prwQj
         dm+LfqBNpCGqgCiYIhgrymWJmPM8bGmwc8i0y+5KikkFnK5MC3tAh3Cwi2ziNmvboBxu
         Z+5ti2s2bZg6YW8AnP4XsUjiqgqs67bMTYcw7lazSuJqBqVEI4QpOiG0icv5eTGOsKCG
         T0XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/NyXyIxlHvEVWClCJE/Mz1q3DwGk8qWOrQsG8ChTvZyFia1ppWgKjl/JtuGgNCQk7CgDUOvj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0V2AiPJGQGwh/fVlFb9r+CwrOcnERMbgAzT1xrgy9xg9XFosK
	9Fd3om4SqJK11jHflx2OmTFGwstKyqeD3/KFpJ3w4z0PpqNi/LlMFSHTAjlcYeZn4Ny1SuV3a+Z
	zCpDYGfecvu2xBiVz3MUNkXkN17htPgNsgzvSWEIrVdiPah3cUO+rHjdrEhI=
X-Gm-Gg: AY/fxX7rYcjwIxjJMwXNKuJ36Bgz4HqmKBHOzieJxEDC2JEw/yOdxHPIten06R0dzyk
	a2SSRysLPz4Yy2odk+wsscpwyW9vwLEXe0LxQ6gmkO+1a9YrZqNfNkbt2ipVSJuR7Hvg9hi0Zbe
	9R+ks/TjmjQLJ8wARRRNtPR069nU0AyN5zAzHOdzQbOIlWcfsGc+dzgbITWYlhxH3DIerlbEqcm
	ydDr3lz1ycVk/5T9owKtkfQSKYYJAfh7cnbmHQzVilaIqlFJGDJnLv4wbSNCwxtXp/3j8U6gyBe
	ZNOWkn+rePCrVYyoj9RaVo5vIF8tWVydyHh5Rs6mYS35lRz0D5BUbRThYn+ICgjeZu0/xIhC2zP
	XUqY2YpbJ7enPt7U+Tn7QheheAfmkvgM7OfY5grRUbmvN3evFZu4y4NWC
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406254446d6.5.1766787210438;
        Fri, 26 Dec 2025 14:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYVLwcCzEd9vRQ5ZAiqiA7WVLjHHO5Pqc++xoxQfNciNGScOhGispLouTYQ6DDT3yyTzTvrQ==
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406253916d6.5.1766787209977;
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm115870181cf.1.2025.12.26.14.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <48f8bff9-178c-4ab7-a8ef-7edba9b0e7bb@redhat.com>
Date: Fri, 26 Dec 2025 17:13:25 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] kthread: Include kthreadd to the managed affinity
 list
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
 <20251224134520.33231-27-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-27-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The unbound kthreads affinity management performed by cpuset is going to
> be imported to the kthread core code for consolidation purposes.
>
> Treat kthreadd just like any other kthread.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 51c0908d3d02..85ccf5bb17c9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -818,12 +818,13 @@ int kthreadd(void *unused)
>   	/* Setup a clean context for our children to inherit. */
>   	set_task_comm(tsk, comm);
>   	ignore_signals(tsk);
> -	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
>   	set_mems_allowed(node_states[N_MEMORY]);
>   
>   	current->flags |= PF_NOFREEZE;
>   	cgroup_init_kthreadd();
>   
> +	kthread_affine_node();
> +
>   	for (;;) {
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		if (list_empty(&kthread_create_list))
Reviewed-by: Waiman Long <longman@redhat.com>


