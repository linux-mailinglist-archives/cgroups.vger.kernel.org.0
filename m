Return-Path: <cgroups+bounces-6840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66298A4FD76
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 12:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D3C188F154
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6764232392;
	Wed,  5 Mar 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHE5nSPw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C0221F27
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173652; cv=none; b=lTdETyMpHgVRf4U6IXIsT9TDTUvLoo4uta6oAmdjBtG5S9D7SptDTuxHWhISWiPgxghFC3HG6ffCgo/CLXBrQj4YhtgdgvK+t4wv8qngB3X6gtMulKqpzfcjMTxRb/K4beegpWy7L85H393ZeQIgtL91vBgYA/qGNkt3JD9O4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173652; c=relaxed/simple;
	bh=9KuRPMrgSumxM9wAGEbWI0xRLjlalFYSuV3BqkFTFfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHS/eFA13aat+a7l7YwJQTWmKaEvaH1xmOeCTtB91YOkrv2agSO6Oialjp19vwdyGR5nbbNAuTQz1jKQQ70UKZmt3RlRgCLXYT+DYexXMz3QMG7K1nwvtXzuG1Jf+FvH47LocqSnlZ8nnjtiVCN28VtAql0NXnQx1hGZrKVxkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHE5nSPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741173649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bkakf8mAIpubx1gm0eZsv8Rzs6PFtDE2Ih4XhtXqzk=;
	b=LHE5nSPwI3CUPyq6EfeGvTFfAsDwHlp5YHmtW+Vf5IKbVS1U0BR8VGfd9aJ8p0mxKBKWlW
	Xl3qSTCzsZ2K+chLqFRsxbh9NxDxEFwgrGvSTh7LxvOdOMpxAOdXkCVH3zP3VaFPYqIjIO
	k8ZrotDeFlAKhLlgX50pIA69doki4pM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-FVqnDMFkNDe1B_6RxRc5VA-1; Wed, 05 Mar 2025 06:20:38 -0500
X-MC-Unique: FVqnDMFkNDe1B_6RxRc5VA-1
X-Mimecast-MFC-AGG-ID: FVqnDMFkNDe1B_6RxRc5VA_1741173637
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd1ad95dbso3269825e9.1
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 03:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173636; x=1741778436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Bkakf8mAIpubx1gm0eZsv8Rzs6PFtDE2Ih4XhtXqzk=;
        b=G8GU6/2cHGVzlMIj11CisZylN+UagE7GI3pKJ9Yv71qxG9uTY1yNmh7ggFZTywyrYr
         mojetAvlbmjmoESVXNocHaFyIswMxnF+zeFQxaL74Nt+CR9Z5zwKgNnL+kPKNpSCtj65
         umZnnsZ0BvZZss5RBZ0GLRN+4fTT/sLuvmsVD0dp/Neyb8xxavMFZCMDNX2fqtsVzS0V
         xlV5kEicIGpspi0W804VMI2IuxacK6rlIHaWCB2ZQXaA8ZOVamyYkyBKIzkUeT0iV5ii
         WPeoWq13GG0Q2O6Isjew++kEwLH27iNVDMZgynkdTodpVx3DXT5U7lKJca4rZsRMvJcK
         GIwg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6jDm22hLSKAE3OWrzrDZhByFp1Gy45gbECQHxjHhTu8AYdFLjlOZSC8SrvDlHzCz6yFe6vs8@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbtCqeAO16MJW55bIKdSpGnYg6SJ50F3YVxCCBCd265Yc24Eu
	zGhh56RPStlwEPl8l8AHDBhUnF5zDbC6uyo+Ok1LRVBdH6xzT8I5jAnNuX9E2oygFB80OF50Z+U
	V/rqW9DuXJMrBzIwGPZSn2VaLfXKilDfWNlsGMQWQVDScgIMM+S4QoAin1YGpLdf7NSbU
X-Gm-Gg: ASbGncuW46gMVFVFz5yADtG7u9p6pliJh7wotv8sXFLRZBufnRLB3f8lw6EYQkVYeWC
	3cEPlcPzdpiTFOa8CUC5Wf2lFEMuZ2t2RxbzzOVgzRCwJEwLoyuCPqixYoz54oDaYzG7J1BlA5Y
	cPx4eXmRcTto9QCUrc2DdUO4CPIbVxtzLat1iJbUxb52RHZG0L9mWGn1JCAn9QZNJ5/zbSBC1mH
	jIYEf0g98NiljY31MCTeS/WOUYRCDdxqSSxTn35JRQi3kSUd2RfaCowhciSmuCmGXQKMhAIV98u
	4HSMgTyaFWJt9yb6H5bSBA0Y59REnTrGLXLD4E3wanaD6pb78j69QFVt5IxsvSmgoWU+Gy2KJVu
	/1+u0
X-Received: by 2002:a05:6000:4009:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3911e9df21fmr2382069f8f.8.1741173636282;
        Wed, 05 Mar 2025 03:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAJ1N42vGbNNXbqzgWkiEhUsL47Sj04Lni5aulHIgSDua9zvjpyKfNY1AIXLGlW6iWXZF7ZA==
X-Received: by 2002:a05:6000:4009:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3911e9df21fmr2382052f8f.8.1741173635956;
        Wed, 05 Mar 2025 03:20:35 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm21079334f8f.63.2025.03.05.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:20:34 -0800 (PST)
Date: Wed, 5 Mar 2025 11:20:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z8gzgfhBeYxvboFA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>

On 04/03/25 10:17, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:

...

> > @@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   {
> >   	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > -	dl_rebuild_rd_accounting();
> >   	sched_domains_mutex_unlock();
> >   }
> 
> With this patch, partition_and_rebuild_sched_domains() is essentially the
> same as partition_sched_domains(). We can remove
> partition_and_rebuild_sched_domains() and use partition_sched_domains()
> directly. Also we don't need to expose partition_sched_domains_locked() as
> well as there is no more caller outside of topology.c.

Indeed!

Thanks,
Juri


