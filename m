Return-Path: <cgroups+bounces-7019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A86A5E20B
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B843B7ABCAD
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D1242900;
	Wed, 12 Mar 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3SXBYo5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D461F03EB
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798305; cv=none; b=mPe699k1LSeQqF+xKxFpxlqLiKTdqatr+KeJkioUnN+b0dqDBo1Z+U819rx4aNkVPnWzlttojqcc/k96Y5eyLT/1d+i8pozNQqjy8lQOX38ueOmIT7pQWkG/wDarShQ/3XtxL1gqS3xpEGplGgw+n3pSyha/lce1zdzal2WviSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798305; c=relaxed/simple;
	bh=/xk9BSbVzT8YdrZU+8qu2kEBkOWLWjLBT09+jVAfDSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZzHWW/VW0y7mzdw0ZEcwHm7ZUF7OTlDQT7JJsFbl65K9xbjm8AUvRf/EqCPPgQ/eOt10zp/ci/l06PCKuy428R6Mz6HBNmupiA5gx9Dt65C3VeRHvfhtDI+8JAXjpxSL0B0S/Ufb5yVTQVMnd/7bxm/Bu1K7HgRtbxBo1/ZV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3SXBYo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741798302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhC3dGei2rmob1KmMR9I6J8XiZcIS7aiLPCRejPFAkg=;
	b=M3SXBYo5a+L3tCzVlQ7k/N7SBvIJSU4gvVq6D95lPJEZkAA/c6wDC/ZyqdNlaBaEYF2VGY
	tb7NVzbyo7YqkOZfAhTJ5OcPAjA9b6uEXDcE/Fg/BUQBV8N5SLin/+z31JkXQrIxgkrYnJ
	DT+TWanq+sEMiUStUTmKMpTf/PFu458=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-lWNn78ltNSmL4WrKg0Q_tw-1; Wed, 12 Mar 2025 12:51:40 -0400
X-MC-Unique: lWNn78ltNSmL4WrKg0Q_tw-1
X-Mimecast-MFC-AGG-ID: lWNn78ltNSmL4WrKg0Q_tw_1741798300
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so33595e9.1
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 09:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741798299; x=1742403099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhC3dGei2rmob1KmMR9I6J8XiZcIS7aiLPCRejPFAkg=;
        b=NAZbyPP7fMz4qNOviStTw32XNUZ3h1sWjdjzYUDpdqrpVjiUaqIZgvZsYynLFkD+cw
         SvYQoAuwdrrAg1USNPX3PwfSOvHb5A8VxKeg3iRO39fCr0OByXp28/oqwAAslkAH4pY4
         IZMPZp0etXDsRKZdl36FYji/PUQV+O3KP2vCyi4kG+5liXQMFZrt0VqyAYzqhRl1N98T
         SGZx/U3/cT5oBqTpkeFE2AWa0lcxszIXpzAtbL+CMGN+QRJ8Ap8V1+eWSmL6ghex60T6
         qYEyZnOa2bLXvmhZ5iTpprsKeWeAUa0yve2wiNP/dxhVJUE/Iiud4eD5qUs9aIk2CSqR
         JNcw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRC7K7N/UE5An6QUz0vaRtWZDUkOsS8N5zvCPTUqUGcF+HjUiybySufPVVC8Ca+HaDUIF0tmI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZbwdtWqCQvwEZT+uUm7MCIHl2Jdu5MFfYuAGV6zE1A+eixP2
	03jsKcYfJfkt9c4hMAamMqrgeqsy4QTO82cTTZbW2kWvgLWAR+kwtpZSOTEfzn95ce2HyPKA/Qa
	TEupaxYBF06YnXea4gwnRYXo/EZKJ76gcA3hVqSrVZGOn9ZZLqAQHF3I=
X-Gm-Gg: ASbGnctszgfMagiHFpLjMRymgsinFBQVIjF9F6B1VuoThurvl6TgoPnZKOZV2biofoa
	24Mj6+EV9AT1PxSt4msIE66IYyA0rvFCMxTyDiRYMOqMdUT4AjcBiKC7XRfoWpeIi3Bb6txabkS
	cuA8K3F62DkCbFLe5o5SLNfNMcN8rDXgfbO8DVNwsRpX8wkdCsynGWDdxSOChswIywNU9dE68cH
	MgtQ+ipKfo6yVDkl3PC1Os4Bzsn0QjrxiYb+D6LRUHM7bGsFp+00r3YcvEqt64zqyszWLqkUbmT
	4ypiYUl5cYiVk1KbTKTn4eq8NUJe1LiuCh3MGKK2vMM=
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d05ecc145mr65274625e9.10.1741798299626;
        Wed, 12 Mar 2025 09:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuP4Gn6dH73Db2O+BlcqpNQGP2AydhiF2o9YtbaI8drJWF4RsJmiH3wOi6KmOdX07GL/JZGg==
X-Received: by 2002:a05:600c:4589:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43d05ecc145mr65274405e9.10.1741798299266;
        Wed, 12 Mar 2025 09:51:39 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74d4bbsm26286775e9.13.2025.03.12.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:51:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:51:36 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z9G7mMQ3xG15FmLy@jlelli-thinkpadt14gen4.remote.csb>
References: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
 <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
 <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
 <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bc0eda-7471-404d-a816-bd5f1a8d4b27@arm.com>

On 12/03/25 17:29, Dietmar Eggemann wrote:
> On 12/03/2025 15:11, Juri Lelli wrote:
> > On 12/03/25 09:55, Waiman Long wrote:
> >> On 3/12/25 6:09 AM, Juri Lelli wrote:
> >>> On 12/03/25 10:53, Dietmar Eggemann wrote:
> >>>> On 11/03/2025 15:51, Waiman Long wrote:
> 
> [...]
> 
> >>> I unfortunately very much suspect !CPUSETS accounting is broken. But if
> >>> that is indeed the case, it has been broken for a while. :(
> >> Without CONFIG_CPUSETS, there will be one and only one global sched domain.
> >> Will this still be a problem?
> > 
> > Still need to double check. But I have a feeling we don't restore
> > accounting correctly (at all?!) without CPUSETS. Orthogonal to this
> > issue though, as if we don't, we didn't so far. :/
> 
> As expected:
> 
> Since dl_rebuild_rd_accounting() is empty with !CONFIG_CPUSETS, the same
> issue happens.

Right, suspicion confirmed. :)

But, as I was saying, I believe it has been broken for a while/forever.
Not only suspend/resume, the accounting itself.

Would you be OK if we address the !CPUSETS case with a separate later
series?

Thanks!
Juri


