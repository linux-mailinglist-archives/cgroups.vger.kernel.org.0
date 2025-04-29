Return-Path: <cgroups+bounces-7890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA5AA0A61
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F35C169598
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF952D190E;
	Tue, 29 Apr 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cSPKGl9X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11402C2567
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926937; cv=none; b=PixgSUyCTJoV3W97uta9EKU1ScX+1W0pd3/K61EiS80xAXnxATDkte4aAvbwd8jC9QvGRLBAljuUOGkWhx8zEughLjA0E0tdN8p4pLl8Ud8WMXmJ121O6RG/ePf1sPrDUa8acgkzInV0yBJcsvb/x3jpsSeJ1gNWQ6AfatIXDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926937; c=relaxed/simple;
	bh=1pXLPMhmoxjMRNxn/3jRxQkvfWaqkkEBCKjj4zAnD8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plUbW1OoqlFp970jfoTm8fDGCQ1n+ZQteGnL8IBCBsLrO/GnPQTdB6vvjfxTf4LnNO8MRZTYtK8y6xpA8l7AxoX+YMnryAg5GhXlzZd2K2oXLl+9XqOjXWjta8ZzbuQsy7opEX3r/Z8xAxCeD6Ujuvxjfj9f/GBnHh6fiwIWJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cSPKGl9X; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso973138166b.1
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745926933; x=1746531733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ey+I5jL6iIXatVmqxM65zXGZtsNFeT7DcoIALExv/ys=;
        b=cSPKGl9XHpqjmUDOPZXbht/1rfTVbVLSAflZyBzOeLfZ6ZAmr6I8CbfB4ENlY+d5iT
         QD1m6tZF+RQ8OoVOqUrcZhtiwAnfz34LMF3yubFF5y05hi75luzKlCyqyXWyqj+rubuT
         ss1kKdFRhXY7VkhBuv0vMX2+RAW7JBtIqqLGJ9LZfLSs7wSYIrIGqG6r28moHUf7AOxh
         zxkbykN1vhuL4QL4iv0Ig/NEuMnlP93RvIlIG5G54ecgYSYXpvpH6a8AjMDoYeXkVpQo
         EJMsz0tEGyrOrw745uas+RtL/SOOvRrdl49BHyE4R1pXFlgw4TmfO0v0KHSYQmJTPLnh
         xWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745926933; x=1746531733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey+I5jL6iIXatVmqxM65zXGZtsNFeT7DcoIALExv/ys=;
        b=D60BvDbwsUM/IhlWbjsxi7FiEqge4IcmSddY46e9TxU3z4RFqKeQXobafWGfZdwB1P
         GSpj3XopdsrwVe8t+L27jHC/YrbbN7lH1y0MqmoBjTiwT7L06i4ZqkoiHUKiFeWyv/O2
         blesOtpf6apTx9dMGDFvN/tqpO5eAeEkm1srU/ILdNdrIx27WoUzAmTkka1/AeEHdyya
         jcAPvSe0tOp+Wgkw2rltNjtI/KTW67U2HeNMh1PgiSINI7SnQpMIHu8ivNvJnN/qfFxW
         hsF+HNDqrzRucfmFN2W3DDsD7EWvDRnYszLogx0K2V6WpGix/eQVMj8377uepKJuIPYb
         jFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmQMr4wM0b5sYPkDA7kGsuBqHaZCj/+QLGhl+BwaXIKLCRMuo8e43+U0kYsCqUuga8kpjsggws@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgCgJAv4G5JKGrO9sBTkPqQdvsYVp6A3UHvhSoV8epDikU0+t
	KkQGMNUwUcJYmzkLBbsYsjmG0fw2kDy6WpzqwU3QvBsl4oWcCD1xVB5pP+XMKX8=
X-Gm-Gg: ASbGnctTRo24U+GIavlybPau4h4JVzSp1cOdavVR7cwExudekjvTV6rn+Yfswz9HFb7
	33mne5/Ny3sGzIBfk3Qyqmylg7zrK6k5lhQP0uYxGWhQj/gsJLUcfhNDQyHTO0AtG8lAzUAF9bw
	paRX4bijmYpIJeLcvYKiaHQJCgcvJ6zOB7Q5YxtoalLBqluDMqIK2QBmw2eFmXPXA3VLN5KX2Tm
	4qVeiFUCPuh/umuwV74M4BYm+xTrLwl6+db3uOzLlh2JLy/+oMmUv7IyfHNMqDCD4nIjrY4t4Ee
	N32Bix6PTnMqpSyo3CvPeBVAw37Q2l8NPURqSw8JcfzENt/Ta4rT8Q==
X-Google-Smtp-Source: AGHT+IH7dcicAcnmj5NaE95QUGR24eCcfOm63TRGYwTmK3j5rlAl8p+nDrnlZU2xFwsK27po9Y9CvQ==
X-Received: by 2002:a17:907:60d0:b0:acb:63a4:e8e5 with SMTP id a640c23a62f3a-acec4ccfc22mr315665666b.6.1745926932884;
        Tue, 29 Apr 2025 04:42:12 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ed6affesm765813266b.130.2025.04.29.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:42:12 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:42:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aBC7E487qDSDTdBH@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>

On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
> This patchset adds an ability to customize the out of memory
> handling using bpf.
> 
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
> 
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking-based policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
> 
> It provides a generic hook which is called before the existing OOM
> killer code and allows implementing any policy, e.g.  picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).

Makes sense to me. I still have a slight concern though. We have 3
different oom handlers smashed into a single one with special casing
involved. This is manageable (although not great) for the in kernel
code but I am wondering whether we should do better for BPF based OOM
implementations. Would it make sense to have different callbacks for
cpuset, memcg and global oom killer handlers?

I can see you have already added some helper functions to deal with
memcgs but I do not see anything to iterate processes or find a process to
kill etc. Is that functionality generally available (sorry I am not
really familiar with BPF all that much so please bear with me)?

I like the way how you naturalely hooked into existing OOM primitives
like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
you waiting for a first user that needs to implement oom victim
synchronization or do you plan to integrate that into tasks iterators?
I am mostly asking because it is exactly these kind of details that
make the current in kernel oom handler quite complex and it would be
great if custom ones do not have to reproduce that complexity and only
focus on the high level policy.

> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls.

This makes sense to me as well. I have to admit I am not fully familiar
with PSI integration into sched code but from what I can see the
evaluation is done on regular bases from the worker context kicked off
from the scheduler code. There shouldn't be any locking constrains which
is good. Is there any risk if the oom handler took too long though?

Also an important question. I can see selftests which are using the
infrastructure. But have you tried to implement a real OOM handler with
this proposed infrastructure?

> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> [3]: https://github.com/facebookincubator/oomd
> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> 
> ----
> 
> This is an RFC version, which is not intended to be merged in the current form.
> Open questions/TODOs:
> 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
>    It has to be able to return a value, to be sleepable (to use cgroup iterators)
>    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
>    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
>    arguments as trusted"), which is not safe. One option is to fake acquire/release
>    semantics for the oom_control pointer. Other option is to introduce a completely
>    new attachment or program type, similar to lsm hooks.
> 2) Currently lockdep complaints about a potential circular dependency because
>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under oom_lock.
>    One way to fix it is to make it non-sleepable, but then it will require some
>    additional work to allow it using cgroup iterators. It's intervened with 1).

I cannot see this in the code. Could you be more specific please? Where
is this might_fault coming from? Is this BPF constrain?

> 3) What kind of hierarchical features are required? Do we want to nest oom policies?
>    Do we want to attach oom policies to cgroups? I think it's too complicated,
>    but if we want a full hierarchical support, it might be required.
>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes the true root
>    memcg, which is potentially outside of the ns of the loading process. Does
>    it require some additional capabilities checks? Should it be removed?

Yes, let's start simple and see where we get from there.

> 4) Documentation is lacking and will be added in the next version.

+1

Thanks!
-- 
Michal Hocko
SUSE Labs

