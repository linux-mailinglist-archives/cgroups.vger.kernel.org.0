Return-Path: <cgroups+bounces-6880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFAA56301
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00B27A947A
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EB1DC99A;
	Fri,  7 Mar 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr5okCe6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D014D283
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337614; cv=none; b=ZhXJNFFnH4ePtHKWSeef2p/ovmJALp7FDMB5lz9tn4qd6dgcKzoVTkSov3JJFwGAnU42a3wruK/pY8x2Qs1d8IgY17WOvAELqwkMq1/b85cChPphcqmkLJojC3FuwkF/xKS3boTqwSyu+Wf2lv0FiC6BZlabUHHP3PvUkXkYZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337614; c=relaxed/simple;
	bh=trVq+/QuImX7PggLWSPIN3coPhqb1R9Aue9P2NTVfo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRyFYjj+n4CcnaEKhIqoWmlY8cnIrZ+fG34CuRWyAQrxnMn0kmkbPE0atLMh7jo0xEyULrO0tkkaTDisRYw1zB0VOWyGvdSn8ad00QaNwPNN7lCcmdOmx8PftKiWH0uLoiPVF6g/be+RGyvJS6QugdVJ/tcvXVE15vGoetLjFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr5okCe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741337611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLCvL7MTjAjZGB5lfv9MT1kgTWiIaHT/S9+g0TItFt8=;
	b=Tr5okCe6CCdb6Dw3yPZG0oEYJANgk6axbaqlGzpSCSB7PF6dUYS9NcgvcfSK0hMtJ5RhIT
	7sFVX94ePzYG2LBuKMOVrx5zFEao744ANJxqrWSltwXr25ZkulTrpQT5lEtf4hVYgzUkT1
	fu9PG6rRyLd0QFeCmf3fR8B7fy2W5dw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-6OHHyL9eP-OPfPRZlRjCUw-1; Fri, 07 Mar 2025 03:53:29 -0500
X-MC-Unique: 6OHHyL9eP-OPfPRZlRjCUw-1
X-Mimecast-MFC-AGG-ID: 6OHHyL9eP-OPfPRZlRjCUw_1741337609
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c24bb4f502so318328985a.3
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 00:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337609; x=1741942409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLCvL7MTjAjZGB5lfv9MT1kgTWiIaHT/S9+g0TItFt8=;
        b=CGpv+ceWddJVjGKNDYIP0UjiogoMnRPVoQJJsuorhWLa8X1ko8tmta8HS8ix2XIbiE
         67av5RQgkr0b5yto2cC/1NTJw7IkYOtAI5CG5m9XZUkt/26oaEgsV1P4aqYL9HwLP7yg
         XTFDqYHjNspBXdwlGNvEkFnJUnJOy0nJt1uiskaD/BQfNAdshz1eEKvpk1HnVQwbruuU
         swDSPP6elcDdVqKhyi63S9NN+hrSyBAiIt6UJVkGu4eDcoVYW4abxEtl/mMMp70Khdd0
         R0yoPzRw3tm6TDW3w2nFsUAEgkRR5VVU8hb4bVQAt3xnof3rYIjXK+sI5K7Y3Zlsyzc+
         LutA==
X-Forwarded-Encrypted: i=1; AJvYcCUun7kXKxjkwr7GgYQHU9izK6/ySy3dhe2GkqV2vmsbEG+Y2Q0xq4M4qxIqdkd2UF5/L8DNZ7xO@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxL5B0IqFpMFcbCr3XeOJmMrNWq2YvAjxhu67OikKDdt3wBe3
	wgphIzJiUtVLLIdioe66maQbCLPqgNvq6ZY2lr/I8J5RHn3gMA5U94Pb9aGSx+sxwrX+Zqm8HqO
	8OjVOCxdPQdeWFsnYJTPYb8mVqb8iecejC52gp/BW8tvMKDi5tRgskkQ=
X-Gm-Gg: ASbGncsKNvnrgIm9310sDwE5VAyfVMPDW7cKNON9dCzhIUNwodey2sdDWm9LE8WoriR
	bQTHC8zXylT468d81H6kIutHe9+y9hN7OBxU3G79nufNeHiGCmqqWFTEKyTr82+/59qa6m/+XWS
	UFn9Y4MBgWy0BzLrBAacMOaNCpo3wOVRBYxsAqeHiJ2XP7fMtc3VghECnS5H0nHxm9qI5S6isPF
	X1BZvf599z1vMFEq9SSCKXp5bOz+r8mdijBDxdIA1TMSbF9jbSk5ZaWKhht6v8UZ+GmP673cNH1
	UpkixlbFC9WzaP8SZmRnwRs9gsCjP1Sgh3NKETdhKkBxewmjSbgLyH5DOhNDAVrWrNuabi35C00
	qKKCv
X-Received: by 2002:a05:620a:847:b0:7c3:d86d:940 with SMTP id af79cd13be357-7c4e61aa101mr345969985a.54.1741337608800;
        Fri, 07 Mar 2025 00:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJPLd70g/e0BjM9dZ6h5h/iDHmxVQ5bPlBK/d3eOLZdc484dJRfYVIn8oWBqWpfXqk/32+PA==
X-Received: by 2002:a05:620a:847:b0:7c3:d86d:940 with SMTP id af79cd13be357-7c4e61aa101mr345967485a.54.1741337608510;
        Fri, 07 Mar 2025 00:53:28 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534c76fsm216015285a.41.2025.03.07.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:53:27 -0800 (PST)
Date: Fri, 7 Mar 2025 08:53:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8q0Alpk8AXbGxgW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>

Hi,

Thanks for the overall review!

On 07/03/25 12:04, Shrikanth Hegde wrote:
> Hi Juri.
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.

...

> Maybe sched_domains_mutex can be static since its only used in topology.c ?

We have a lockdep_assert in cpuset.c, don't we? We can create another
wrapper for that, but I am not sure it is going to be cleaner.

Thanks,
Juri


