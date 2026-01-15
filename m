Return-Path: <cgroups+bounces-13250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1323D24D8A
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF9C30671C6
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9733A0E8E;
	Thu, 15 Jan 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z68PYJjA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eye+PD0n"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08D3A0E84
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485419; cv=none; b=J0Cs0kriFap4uQDHsTl2XShbnwjj7AsGQL8jMz+nJtt88OQj2sJhuzw6X7Eb4JUGOlPO4a7NV4Oa7EtfUN1UBzs4BVe14uhb8ETxqu/azp9XiBQG3+/ufnYxHwTYlKrmquITu+prrMQKq2TtCS7BsqWXspPy0Tg5E+U27llY5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485419; c=relaxed/simple;
	bh=FnyOTPf4m8Mp4nl4SL3AW2LPS9qsrPeFd58UUFtyVMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4AxRShVVXTr28/IIZGiHdaxofCAcOKneRnTHM+GuxFmtUnNj28AuiQzHIiJFiCyFF1E7M+z/5bsaHTptoMYh9spCn5PmDqgliL2H28i/Hk5NgIwhh9xTvfApjJP1cqaKyDGpQLyAuF+zem+9Mq/UqT+xbaYfU/uE/JE9EurhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z68PYJjA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eye+PD0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768485415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ane5kaNtNeusJK518LJGVJnPrrb1Tm+pD0hxe99rrg=;
	b=Z68PYJjA0mAbT66b231audfFaUuMsdCDew/LC4SmO0vvJbhRIApg4b1gH3p1Yg6H93JPXZ
	RDcK8SF1fhU6EeuesCpTm4TABn0U2kSSw7qCOKXYm4P/PMAVmu3cnLUsYaeejfNUD6SwwW
	yu5YLKWxXpunmS5K2WXLZE7UbyebZ7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-IRoP6BsHNbyxUPuRdZgJTA-1; Thu, 15 Jan 2026 08:56:54 -0500
X-MC-Unique: IRoP6BsHNbyxUPuRdZgJTA-1
X-Mimecast-MFC-AGG-ID: IRoP6BsHNbyxUPuRdZgJTA_1768485413
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so8401395e9.0
        for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 05:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768485413; x=1769090213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ane5kaNtNeusJK518LJGVJnPrrb1Tm+pD0hxe99rrg=;
        b=Eye+PD0nzTF7q1K4usE00+yYrisc3fH33vYcZQ14pYcU+6C7ThqRgGyeCvPbIWWuWQ
         3ZdsMJT69CDmYUJmPEBVq20quXTPgunxrtmdNXsoi4VFBwOsA7OxHPnEXg+VAf9Yh4R7
         a63zNmnPxGktFQfjZDPGlB9VEtwWM/JoQBiiKsQHqFaMZ6Nj6Fn1XM2XubCoSvU/H9fF
         62g56v7uVICfC5STTPYR6htMH46DBp/+9dMmpeF5KbP+kXCYnpXo30iVwPTjY4GdA+MZ
         rEzeZjafdCwXe37T4PqGMiDI+ZYuO/ZUjpuBabpSg7KEcX3MnqG8nDeG2rJuVWfpdVtC
         rRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768485413; x=1769090213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ane5kaNtNeusJK518LJGVJnPrrb1Tm+pD0hxe99rrg=;
        b=jI0TV1ftMnNbK+NCeCjGDtnsWwVSvteE2TRfef9kHYJbRazg+hYb97hx9DsHztpb1m
         ouTWAO8qwbrIN/p15IIM1aV61jtdOGmchIvoUsZnSXSao7HNuPSPQvLP+5aWDOc2y7TY
         O5JnK+1UlnrTQqp1L2zes9bcHsPMKGDC5uRLefNxVCzwP+1QVQXFzmp6wHx/OTvaWlTi
         LV4Y+Q05CG8r5mQmKL8baC3iDQfCzHNoRrtmCnNGubHcf98uu0guC2KDoZJyqHcds+2A
         /nGcu+20SUbOMB2bAsmO4cTVubUIa4qN+3Xh35IxVzKgMJEnPD4QPutDt6+is4N8hu0S
         yRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWZiLFqyvvtmqv4h98vJjbsT6ZbwtUU11pcuwpdFWTuSN0NZXdb6LNtnYPsqYTsCvr0v2bkFU@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXzmjVFmmVvmO4peuBIwZNPX8t9J1NQVn3+QOWbEQnGt9ZR6q
	u/p4ANn6vsxUUJAzFTezT5AUMxO75YszuFbl2OZ/rCrTTsDQVBPpaDMuVtEz8ZwMQSB0qZEMbD+
	/szeF532LevapaO/trguwIM7gtVQgKNrlWjLLxor7NHM0hAfezXd1bAeQM1Q=
X-Gm-Gg: AY/fxX5BcK1xcOmLrh8YZHsdnSRti2a5hk9w7bdnMqCZRTB/DF4xts/6+PmJewHCbSM
	H5T6+UpRWDpW7NQ0iI3Z5CnWtJQMp66sVaa297+eiKI3kdNrQCEYmqG6CmnkyjdwT3u3/uMFbI9
	bCFx6an/59ZW8UWTJ/antYNB1TcQsa32LdORGYL3wbWVIrco0VGUqyZAEJ2h3keeQdlNTHI2I2q
	IivbO47vQ6/DcQZPoGL8rQ6xlpOu+rv1hUvrXiu7DXPaafnPmTEBvBvYzdZDz2AGUD6ZEAzWtG+
	aKNhR61DWUTF2oKSDP8fS2D9yCCad/3os9SL/u+2Q79iec6HL72V7ER1oFodYfU2/zkoWiJjCB8
	iUQw3I/cOEtnHuq11SskBrLavNnWwLjU9etcymdXl
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47ee32e07c3mr82027535e9.6.1768485413210;
        Thu, 15 Jan 2026 05:56:53 -0800 (PST)
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47ee32e07c3mr82027055e9.6.1768485412762;
        Thu, 15 Jan 2026 05:56:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6535ddsm6044623f8f.15.2026.01.15.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:56:52 -0800 (PST)
Date: Thu, 15 Jan 2026 14:56:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <aWjyIROG6AqXtm1G@jlelli-thinkpadt14gen4.remote.csb>
References: <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
 <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
 <20260115082431.GE830755@noisy.programming.kicks-ass.net>
 <20260115090557.GC831285@noisy.programming.kicks-ass.net>
 <21da68c5-e6ec-4ffd-81eb-e1fda13dd7af@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21da68c5-e6ec-4ffd-81eb-e1fda13dd7af@arm.com>

On 15/01/26 14:13, Pierre Gondois wrote:
> Hello Peter,
> 
> On 1/15/26 10:05, Peter Zijlstra wrote:
> > On Thu, Jan 15, 2026 at 09:24:31AM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 14, 2026 at 03:20:48PM +0100, Juri Lelli wrote:
> > > 
> > > > > --- a/kernel/sched/syscalls.c
> > > > > +++ b/kernel/sched/syscalls.c
> > > > > @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
> > > > >   		 * itself.
> > > > >   		 */
> > > > >   		newprio = rt_effective_prio(p, newprio);
> > > > > -		if (newprio == oldprio)
> > > > > +		if (newprio == oldprio && !dl_prio(newprio))
> > > > >   			queue_flags &= ~DEQUEUE_MOVE;
> > > > >   	}
> > > > We have been using (improperly?) ENQUEUE_SAVE also to know when a new
> > > > entity gets setscheduled to DEADLINE (or its parameters are changed) and
> > > > it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
> > > > quick first look, it does sound good to me.
> > > If this is strictly about tasks coming into SCHED_DEADLINE there are a
> > > number of alternative options:
> > > 
> > >   - there are the sched_class::switch{ing,ed}_to() callbacks;
> > >   - there is (the fairly recent) ENQUEUE_CLASS.
> > > 
> > > Anyway, let me break up this one patch into individual bits and write
> > > changelogs. I'll stick them in queue/sched/urgent for now; hopefully
> > > Pierre can given them a spin and report back if it all sorts his
> > > problem).
> > Now live at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/urgent
> > 
> > Please test.
> I don't see the balance_callback or the double clock update warnings
> anymore.

FWIW (as I wasn't seeing the reported issue) I had a look as well and
tested locally. Patches look good and nothing to report on the test
side.

Thanks!
Juri


