Return-Path: <cgroups+bounces-7016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F45A5DEAC
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2C9189C2EE
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5CB24BC1C;
	Wed, 12 Mar 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbjmKPVk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9C1E3DE8
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788682; cv=none; b=tLM+xP0NeqtjR+Et1Sa2VDQbPniPCbwOZuzq1+Ww4cEQjpsW/Ivph02ZfuzScMzCsK6n0KWx+AqwmMOq0RvUOx99hjUkS18BEPmePDTMxvFA684EfbRb0AwOP7PD2+D0C3N2D/QxxlNR5i4zcS5FcGcwbC8EmKqJidt8O3bvn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788682; c=relaxed/simple;
	bh=+jSC05SJwjl/8d9CPD2/CFb6AqWqRmu7znZ++6eA6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Sz59WBOQChPBmk3i6Bw1Ajvyp9RBvMQotzVrbVUgT0DrRtON3b+SfFqOsJBefy4Kc36k/BAcXuXTOVibvbC2KXK2AtXQ0Q8/bDIXnfKdm6RmWFZQxx0DSqZ/pxdB3AV1Lwnu0gXSBPbUay7nz7mq+LmhmCsU85/24EUABEb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbjmKPVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741788680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGnUvFsDdnQ+lw0bRojPA/ofxLu41cVYkHj8QUAW/FI=;
	b=bbjmKPVkBRh6sFT5HAIoLSSMfzTOQCzCSjak1V9rwSB8JO+ldRJXsuOxIp1NQCFfVPJGcj
	sAuB12F5qHvxtvmLOtwdfkjdpVmXm6K7WDUvrXPU56rEAdX40NZnnVvjQasifMyT4l/b2x
	e+mo8nrTousZXbhHNUToctfHxpwZmwg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-w_k5iF2bMaaP1N-24yu_VA-1; Wed, 12 Mar 2025 10:11:18 -0400
X-MC-Unique: w_k5iF2bMaaP1N-24yu_VA-1
X-Mimecast-MFC-AGG-ID: w_k5iF2bMaaP1N-24yu_VA_1741788678
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32b08so3683121f8f.3
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 07:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788677; x=1742393477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGnUvFsDdnQ+lw0bRojPA/ofxLu41cVYkHj8QUAW/FI=;
        b=vhdyXAESjSu5I2ZGFNP1PrLPcfRANE1tA2Wp9YE1AGZqAXMKp78KKHYEi/61FocMmL
         OIWluTzhkJvoXnGOKxPeN+nKsqVrKOnMgYAR+mnVXmGgxQltbn/LRWd4bfBga2dNHUTw
         i+d6gQxbOKa6TmkRpcLpvGezpgvMtlhFckCCrR/lBIm0P2d4c48FidOzXBwlGnJ+J5yb
         iBX4AS3kK09hBOFthMsgUimMtqDmPEMP/PifmUeQeL0P5aQ4GkxhfFO0vF/zJb15+XXI
         JHcqQ/tpFaCxaF1kr7OgX9a5JX0WghW3Yf2kX5Z3UTkS/c/dPBBBzB2yXIfcJnI0OOvl
         7Hhw==
X-Forwarded-Encrypted: i=1; AJvYcCUdCLHuSpQKiLNzHVdA3tKmGPH9jpSputScxmXOzsM1lcquXMjHdGfcYEr6XFUxyDZqrrSR0bw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3YIcIUPnSU+nFsFORNBq0WUp9uqWQYNnBKpz2eUK43JBVKDO
	c0BURlrmCDgkXi2aaDFzeyBZFDU4TNyagPvUyiiAxlYe5q8FixhdBpXtOgrb3v2+d42uHvKcaor
	f8MbZB0PwU9FIgpx9x2oDLCa88b/vqG8idVgXXISaHIrphJE79CZs5/w=
X-Gm-Gg: ASbGncueI2yg6x8+lgrfTLRAACJClth+QzA+QdF/Ibnsu8ih0jQeg+v33GR+nH2hwa5
	ZdNf9kF9iEd/TVWYfcCy1td3kVqThZ40ZwzkCGaud/WgogRp3RZJ0pYOopbq8NJw7+/mWUHKm59
	WjncOjryWJRQ/9zglV5+GtOoOGafd1ne5Fk1OkViZn/TUnDsA3crDFGU+FoAHxpa30eYQz630hf
	ACSHyN+1g3TuklgZfqdDCbDrqdWIO4LmgQaX8ujPgW0PwbSL+8BnZD1fmEQZLQ+YgafjxSEWV+H
	Cfk5fVgpMg2HLmOU5xTw0+kh5Z8uvtChXk8eQR7mz+k=
X-Received: by 2002:a5d:6c6f:0:b0:38f:3224:660b with SMTP id ffacd0b85a97d-392641c041cmr8332705f8f.22.1741788677508;
        Wed, 12 Mar 2025 07:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWA0cY2BC6XgXEbxnii+AMUXiizzDFxBVcUGH0TiCHuNDmWjJcAwhup4D7hTAbzVX27jsUTw==
X-Received: by 2002:a5d:6c6f:0:b0:38f:3224:660b with SMTP id ffacd0b85a97d-392641c041cmr8332650f8f.22.1741788676892;
        Wed, 12 Mar 2025 07:11:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cb82sm21812071f8f.51.2025.03.12.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:11:16 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:13 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Z9GWAbxuddrTzCS9@jlelli-thinkpadt14gen4.remote.csb>
References: <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
 <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>

On 12/03/25 09:55, Waiman Long wrote:
> On 3/12/25 6:09 AM, Juri Lelli wrote:
> > On 12/03/25 10:53, Dietmar Eggemann wrote:
> > > On 11/03/2025 15:51, Waiman Long wrote:
> > ...
> > 
> > > > You are right. cpuhp_tasks_frozen will be set in the suspend/resume
> > > > case. In that case, we do need to add a cpuset helper to acquire the
> > > > cpuset_mutex. A test patch as follows (no testing done yet):
> > ...
> > 
> > > This seems to work.
> > Thanks for testing!
> > 
> > Waiman, how do you like to proceed. Separate patch (in this case can you
> > please send me that with changelog etc.) or incorporate your changes
> > into my original patch and possibly, if you like, add Co-authored-by?
> I think it will be better to merge into a single patch to avoid having a
> broken patch. It is up to you if you want me as a co-author. I don't really
> mind.
> > 
> > > But what about a !CONFIG_CPUSETS build. In this case we won't have
> > > this DL accounting update during suspend/resume since
> > > dl_rebuild_rd_accounting() is empty.
> > I unfortunately very much suspect !CPUSETS accounting is broken. But if
> > that is indeed the case, it has been broken for a while. :(
> Without CONFIG_CPUSETS, there will be one and only one global sched domain.
> Will this still be a problem?

Still need to double check. But I have a feeling we don't restore
accounting correctly (at all?!) without CPUSETS. Orthogonal to this
issue though, as if we don't, we didn't so far. :/

> > Will need to double check that, but I would probably do it later on
> > separated from this set that at least seems to cure the most common
> > cases. What do people think?
> 
> I am not aware of any distros without setting CONFIG_CPUSETS. So it is
> mostly a theoretical problem if there is one. So I would recommend going
> ahead with the current patch series instead of spending more time
> investigating this issue.

And I would agree (and then find time to look better into !CPUSETS
case). If nobody objects, I will refresh the series including Waiman's
changes and repost.

Thanks!
Juri


