Return-Path: <cgroups+bounces-10588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081EBC2348
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB11886815
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05F2E8B80;
	Tue,  7 Oct 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3IUhfCl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689762E7F2A
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856333; cv=none; b=DMg/gfD1BZcbt4QbK5Px9fGFJV5gLdZW6eF9mdC3EaZj3MYBcHi/P8oizhaM2lq3r+1zxXjZk7y3yV2VgE0q5fFpyePBUErTD3mYdD/Q59Iu2v+3WQVuTqjQDAIwc9LoAZo9LqHEdZcueIBgFsgSczgIWV85vks69If9aCb0xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856333; c=relaxed/simple;
	bh=jGRdwrk0WiFSH1LDOpIbZJ7IaN2969IhOnXv8zywGVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqYuLWxKsRfouneoWGRlmVta8NQDpAoY8oMcnbXajG5y0XPxns0WUxg5NzLKU93wnDqKv5vYnelz7dI+dp1tDUHhcluTu93uCVAoePUSu08qnWfWxr0LOLXRY+B65jqh79AH5MA/OugnSBksm5GMKakgMtQcK1k2wdVWz8v/h/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3IUhfCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759856330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
	b=X3IUhfClXM97pZQeLbFqBybkdZbBHtc9m8LXq4WXaapBJhPVi3igONAbzX46OR0wIKmQGe
	CkL5uFdXmCcO13BY5A2VbybEL0O7eZuIYT5JsKUls1wXbdOWy6kOuhpdiwl+sKcafsHnkq
	7WcwSDU0VKaQ8WNoV8R1qT4cm7v0SHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-VIK5ESqIOJarcRMQ_nhuKw-1; Tue, 07 Oct 2025 12:58:49 -0400
X-MC-Unique: VIK5ESqIOJarcRMQ_nhuKw-1
X-Mimecast-MFC-AGG-ID: VIK5ESqIOJarcRMQ_nhuKw_1759856328
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso34838115e9.1
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 09:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856328; x=1760461128;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
        b=QMh9ZU4tvIpvCaB9zC4TqzG2c3kmwL82u0ZQIUp1t5gImiM3FhAnhjMQNnhoFHwhnA
         sK6e4pDS7r071jYEefeJBP8wSQRhKWKRy3GfNWitZ2y89Z0D4NblLhYB27XHp1D8CWB/
         XXI06ACOhRN7uuECl9M46QD1HvS7fpQZQqawtpum8KBS0BUy5aYIm0VkEMU9BbekBP8h
         o60gt0J1TOZ82WyH08dnAmQXn3ry0sWBK+vjccK6MZ7pUQ6fL1u0YK1gt7aGeX8b9dPZ
         fpoTnQMPpcsvk+2eMGeLDTcx+9jpugslKKZm1VLwJUwCLqLQAB1hnjJjaLQBFIbWOagL
         /FzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfrR8e2ELymcOSrfNFvMzxIxMrkIlBOkpg0VIGcifaBPtZRiRXy+2BoeUHmuKLTLkHIy/sbxtr@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIzeBnKP0pJT/IzuLjadKe+8643lOoL/2Jh8DFU/mS+g5Svfg
	pyyUqoCUWtGemYrhS6/at8cEzELpGVeZlMPBL+ZXKdMBCuZvWm1T5dVs+VgL8ayh0D7EujIxXY2
	FTobRn73XWwn1/x4e6Aqut3UFZQKuA4eEYG+icccxbnocX0UMuoKe4FhdTiY=
X-Gm-Gg: ASbGncviTJBMmjGkrAaUVv1gnicxqxZ++CIO3b6Qo9pEMonhlcicE/xxKmgLTcRo0pl
	pgWwEwHy44/+7PyDPTa5stuuX3+XpoKvAAb8nOc1mmWm4JF7uTTmJguFKbaRQGZpeQeIuhN8xEC
	tMXBeysYtG9mDIfIHY60bpwob0Mq4y5APusKBYEIrXHH6DIK2gvn5kz0KLmOIesTAb02YuoqAcG
	2nxJY2Iv82get+TpXAXrW3w1Y3prhQxmsVjeSbfYvjvO8IUumGR1G6m4tfGsjzJuCOT+h3zlEh4
	JNYiZpIcem8NjD7j+m20c/fw3VAW0bGEoAPbVTZxZw2FGbBtHaPSZjc+sQwqZ8QI3tVGRXDJXNt
	XN8IkpFiSW/NCA9dj7dmFXOA5UMDulAQ=
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2690185e9.6.1759856327521;
        Tue, 07 Oct 2025 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwECPkX1ww7TuvN8jwk7t/3HaNmLFBxphplQDqgkXaFZv+r5HSiHGWEg5jQHe1bx3Y1Vl/Hw==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2689785e9.6.1759856326877;
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d67e97sm21615545e9.1.2025.10.07.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
In-Reply-To: <20251006104526.613879143@infradead.org>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
Date: Tue, 07 Oct 2025 18:58:44 +0200
Message-ID: <xhsmhecrehcmz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> @@ -7391,52 +7391,42 @@ void rt_mutex_setprio(struct task_struct
>       if (prev_class != next_class && p->se.sched_delayed)
>               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
>
> -	queued = task_on_rq_queued(p);
> -	running = task_current_donor(rq, p);


I'm not sure how that plays with sched_ext, but for the "standard" change
pattern such as this one & the others in core.c, that becomes a
task_current() per sched_change_begin(). I'm guessing we want to make
sched_change_begin() use task_current_donor() instead?


