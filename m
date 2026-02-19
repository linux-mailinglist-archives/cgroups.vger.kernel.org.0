Return-Path: <cgroups+bounces-14022-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHT+Cuhkl2n/xgIAu9opvQ
	(envelope-from <cgroups+bounces-14022-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 20:30:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963C162093
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 20:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E41C3020017
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73977308F33;
	Thu, 19 Feb 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d3yuVqKb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29E2E0B71
	for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529436; cv=none; b=EFUG/QkZ+YXyrS1fJFXF5kKVONqPyxg6HwObTTZR2KfgbxpCuXAYdwsCJvlVPdBzKD6GruLmk8BBJ/EeajwNDB03pDTpnGxBohYnvbxGTc/pbIsb22E3QyowbFp1e7c6hc2rgooipidsN4GIjw23qmNhIW+2kMtTr03/e1kI14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529436; c=relaxed/simple;
	bh=gN9ZUsqQrSAI3cyJyrV/V0WAlQclpKMv03oAD7EgttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Bu5JgZZVpIOGZ/AsrtoP7qQShQTiF4f+CT3bcvpIp1mlDrtm8AQUtX78TKrmy+81k2eb8kajwQgsH7oGyJ8aqYf+H+xJX9S/2UwMefuDfoLmKvWccpIl/g8Kd8I4SP2ue46YhAmWvQT6xwhXdQESStxGn01xWZrkBOtGXtLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d3yuVqKb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483703e4b08so10318995e9.1
        for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771529433; x=1772134233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkc+W3z7LdbV7qOK0XaTDRftTDho1sOCxk9yc12rgDA=;
        b=d3yuVqKb+SJxvzuxkBreHupWw50rqKNwZ81xxaGToPOVvc9VxoNqk+DG6zeW9eDFVJ
         mdFLTCTD5nx6PaoZZkSf8PIuaNBtKuyA7jk9ydEpWBK7Id8py7JOjamU/rqM6stZBbH/
         DXFsMPrRA7H6HaytAymmQPGFnrcI/OcpL7ND5NZSrgDdPBBxQA4yC7unNmVKv2B9nbeE
         27cgyj+iQhWxX5weRmdxjGaAtHXuIuhLbSAIcRwQWsAeamrSZsdRMCSpyHrdMo/mN0l9
         iSvb8GgbmT1n4cpZUKU/PCn9QI6/At2NpIys5j+6cbE7VGCvEfCEps0azxR4A0P+ddQL
         qEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529433; x=1772134233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkc+W3z7LdbV7qOK0XaTDRftTDho1sOCxk9yc12rgDA=;
        b=n9sC7WfPpby2AyR/XU0xBuD90MvYu2u5Xrz+ON+AK+SEOQw2TUUH4lzXnoRg0eefCz
         ChImMfiy9gxsRvXn6/B8xDWG9swEI0ou4XwYrtG8/86IxpnVhjgQ80ObEUmMDtmz+pef
         zt51QGVSDAu7MVzz+wmxtmK979/qh6/yPsMniiIxrqtPdgs+6dxARs8B7IiMrX/7Urje
         tYph/ykeuDaBgcYjGKRuLpOiTgemSQ1vvbTwlNRGxLjzYW2d8MFgfjflBB0R9KG7DuRV
         4PHRtoGda9Cw2AIxFKi7rUyjnTNViq5jQoyn/RxximoqFEQZgfQCm2DB08hznepIfdVn
         4OCw==
X-Forwarded-Encrypted: i=1; AJvYcCXi8od8Kn+FYfWV1XobquV89NBLBobXsrAKHt7oqjErRkSVLQAAB48MXlsNCNJYknEOzTkOXkvS@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDSTVzNEo12IR6ODm5D2BBPehSef3CA3ldKmU4yWlGUcvXA4J
	gDXbXMBx0VzMBwKITE+951iJdpg5x+M/Ml4V3Bv6Xe29znAl5pBnFIfudS3oFvGyBUMog7gIr0A
	Cc2li
X-Gm-Gg: AZuq6aIErtGSRYEJOsDZjSLiABt5IMves6+cQjJZRilX5Qbh93VNU0VnURy3GFGL2Ns
	13a7Zkc0mBFstc6c65ZWDX55yvau+De5CFWMOjap3Pf8MOGZpCQE1cJLF/QjO/AHJmVN6OlHVA5
	XdGok7TZsHALJCxzdxDntYlhrjmX9SQ4KwBuef1SBwyghxI0FRaPUzpfTQPlLwlFo3MWkxmnbCX
	wOPvcpmHX7nP65OUVbqHuIy4D/NSvb17Gpowjh8X/F1gxdZFx6VhoCPLZt9auxr8LVcjsTeRIZS
	7SPRCpq/M2Df/FC0CfHtNgw/4Rxw5sXKVjl51RdRI+vlfZJlVYpA4etkUySojsrJNV14snH13yT
	qeLNNzDfkd1E0ZFIugyG94TawPnnQcBfqmQpOc8GyxU/cjxYO/U9n77ckOCcnRLafeS3MaS0gu2
	tugUnRZdFt93EkpU5OAH+6Og1lqX/JlJc=
X-Received: by 2002:a05:600c:8a0a:10b0:483:a2b0:d210 with SMTP id 5b1f17b1804b1-483a2b0d22fmr25084335e9.7.1771529433119;
        Thu, 19 Feb 2026 11:30:33 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm36582425e9.8.2026.02.19.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:30:32 -0800 (PST)
Date: Thu, 19 Feb 2026 20:30:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZdk19MqYhWK90Do@tiehlicka>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcr255pGT3B/eaL@tpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14022-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 6963C162093
X-Rspamd-Action: no action

On Thu 19-02-26 12:27:23, Marcelo Tosatti wrote:
> Michal,
> 
> Again, i don't see how moving operations to happen at return to 
> kernel would help (assuming you are talking about 
> "context_tracking,x86: Defer some IPIs until a user->kernel transition").

Nope, I am not talking about IPIs, although those are an example of pcp
state as well. I am sorry I do not have a link handy, I am pretty sure
Frederic will have that. Another example, though, was vmstat flushes
that need to be pcp. There are many other examples. 

[...]

> You can't delay either kmalloc (removal of object from per-CPU freelist), 
> or kfree (return of object from per-CPU freelist), or kmem_cache_shrink 
> or kmem_cache_shrink to return to userspace.

Why?

> What i missing something here? (or do you have something on your mind
> which i can't see).

I am really sorry for being really vague here. Let me try to draw
a more abstract problem definition and let's see whether we are trying
to solve the same problem here. Maybe not...

I believe the main usecase of the interest here is uninterrupted
userspace execution and delayed pcp work that migh disturb such workload
after it has returned to the userspace. Right?
That is usually hauskeeping work that for, performance reasons, doesn't
happen in hot paths while the workload was executing in the kernel
space.

There are more ways to deal with that. You can either change the hot
path to not require deferred operation (tricky withtout introducing
regressions for most workloads) or you can define a more suitable place
to perform the housekeeping while still running in the kernel. 

Your QWP work relies on local_lock -> spin_lock transition and
performing the pcp work remotely so you do not need to disturb that
remote cpu. Correct?

Alternative approach is to define a moment when the housekeeping
operation is performed on that local cpu while still running in the
kernel space - e.g. when returning to the userspace. Delayed work is
then not necessary and userspace is not disrupted after returning to the
userspace.

Do I make more sense or does the above sound like a complete gibberish?
-- 
Michal Hocko
SUSE Labs

