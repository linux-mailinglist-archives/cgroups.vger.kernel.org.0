Return-Path: <cgroups+bounces-10579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410FBC0F77
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D31899BEC
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B62D7DE3;
	Tue,  7 Oct 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFkf4gje"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E52D47EE
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831691; cv=none; b=lOR+OC40zcnkzKDGd+Qn4R5ra/6Y7dWNCh+RIPr5RzqV06qMguZJmuTpq8MxHqWAylnSXmSqZp9OlmQI6/1PoTY35+IMZOm//bggsdATltVwZRhgcS6mY/V4MqaoEsCG3knY3jXx91P0thgehx10co4VEd3NgpiPPrY/IMfvLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831691; c=relaxed/simple;
	bh=X1iciAMY8PqRMVBzYSqFJyHJLL4pQ951fQtXxmSzeas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=livLr4xt5LwDBiZalSCPhHPGtKCsPtOZLvrMLfkmVHEXkyNJ5RO+P1YrMumXw/sYEvQEnCBxQwtp1McXXKgKPDm+EKpRyrKd1yTYaoHd4CakqsYHz3LZ8WTt8DYCzwGQ+48ceaCqEwdfYyF9QUczDMO4blfTAZnlPwnIQ5YstmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFkf4gje; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759831688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
	b=bFkf4gjeBOdM8bIIO3o1zI93ozAqQNcNPfoXklkK579WKrAHdsvSGJqpvtf5VIzL2FaSt8
	guRtzxkkXKYkGX0QGw0xbFfdmocmA0hdE4kJnvVcJRH8Gse4fymYnic0UOJBVRDZ0TnZ9D
	nvMEjJqbe4q/XWb58VN48lJdQMvkiKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-vM7n4Dn2MUC0FMU6l-ghMw-1; Tue, 07 Oct 2025 06:08:07 -0400
X-MC-Unique: vM7n4Dn2MUC0FMU6l-ghMw-1
X-Mimecast-MFC-AGG-ID: vM7n4Dn2MUC0FMU6l-ghMw_1759831686
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee1317b132so3355451f8f.0
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831686; x=1760436486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
        b=e2T/XQgtT+i8bBKmh8QbbH0h+BZt24p95hvjRM8f+XVabxTKrrEreQ0hUXYI2yp4FU
         DCSw1xkijWF9pbhAz5SGKWNQq3QnkpeGm3+j1RzXVKedncw2J/dWNLLc5pLDc6JKEHiM
         IFSkDDhabYGDAcwPYAKBuUncBeiBvW3K9G2waD1X+velavL3+u38ZWhqHWIYuYYzFoIE
         fCXQ2wFLZt9QA6/GO9lctrK+I353EswZfZNqEVIlgl/lEFlHL2qPY6Zu6qtJaWiBpJjm
         fCYgE1+EKXtLYP/+gFbx8wlZrTACFVmOJKll9nPsJm86FEmFmR9CdojxCN/jHHjlw9NX
         Q0/w==
X-Forwarded-Encrypted: i=1; AJvYcCUsAuITnKGpnEs3p9BiAM8K5MrBJrkXKeujkf1Tr36Iv8LO9GIb5wr5sd3LzC8NTiiYi0tALM1q@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsphnzVEaEf/yllJSErvp2BIaYo53gtdxdTNZnEBePqN+ftnU
	nqQ68VjFPP3cvasxYu6LuHZtgop1VDNLhxbavzk3BSjYRrghKaBlDAZkwu8s0xEwCZOWfUlnKEg
	Kj9IsmWYDYIhoNtLf0eMIZ8oyTFXQxyZcUtkNY8aZMjzlAobUje9UKw55jl4=
X-Gm-Gg: ASbGnctnpv1Hu9AtcJjo0pWnjkdk8wt0YnsPdK6RXH+s7YVVHaCmRnYo4JoLBemvSav
	rsALBMFCk6AKXhIwlzJDYU4Bdl5i1KOdUUvHL26RFT54tTX6isaL8HPgbDGO/dw9LxH4phlFQuW
	MwYVLO7IcOiQI7+88xnvbQMau8DIRQO9GwNmCL/ANcx4hMVcL3GgFDo2dvfrTX+YK1hjl8gvaVy
	uVHjU331wrypHxGLcesbxxtCOVxokpRogpIQC10RsNlA2JPbmlcmYYQQRfadUKCrmDdgkkSFgPf
	EskCYL82vllvL9dlKn/H1OgzHdt8zY1bweXSvsGsPmkDI2ojeQSstYpm56/J9yYiscigtj10L2X
	yug==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150995f8f.56.1759831685977;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoOnbt3zl/Z0zIFMaawiwiieruc6RIjDSa5Y4OtsLc9P/dDQ+rp/oPqBnApnJV75iKliXKtA==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150970f8f.56.1759831685538;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm24882138f8f.26.2025.10.07.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:08:03 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006105453.522934521@infradead.org>

Hi Peter,

On 06/10/25 12:46, Peter Zijlstra wrote:
> Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> enables easy tracking of which runqueues are modified over a
> lock-break.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Nice.

> @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
>  	if (this_rq->cfs.h_nr_queued && !pulled_task)
>  		pulled_task = 1;
>  
> -	/* Is there a task of a high priority class? */
> -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> +	/* If a higher prio class was modified, restart the pick */
> +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
>  		pulled_task = -1;

Does this however want a self-documenting inline helper or macro to make
it even more clear? If this is always going to be the only caller maybe
not so much.

Thanks,
Juri


