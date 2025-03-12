Return-Path: <cgroups+bounces-7007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EACA5DA2F
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C593189DB0F
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336C523C8D8;
	Wed, 12 Mar 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU7TRk0W"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021123C361
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774178; cv=none; b=QKY7u1maFxewf2SNHJFhKJtd9yFjDjj7FIWYxWcjoYi6guP6TL9Od7ZFiH2KlnN0+MCr/PIbHGMjqCax/RY1M0aTmeNqBjFAqxo9k7y5wJ3cjpbigxfxobkVvy92ZEtyAJiJTc/4lCAukdGnaMz3q140E8u/ZIO9Y6Ddb7iAonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774178; c=relaxed/simple;
	bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoHRCNq1HYM2Hjuk42zEqf00hNtYygBtN34nwttjIZFoUfpXseYoONJrmDnqoKezZ/xIK4dEhWKpUU9uUbo6Q6kCWoeVhpEruptX1ItD+36xBd1ADCfawr9Z6nXNWKlzrptwLFiy7l/5/EMkdYbiLZ3KjwDOBF9rz8faYC0DMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU7TRk0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741774175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
	b=eU7TRk0WVI1FxQboMjwvUi/D/vv9LFf9DTK1hVluZD1BkrjJa9etf4cJ7PkjWulDMd3W8x
	AUtK88ScmS/UkJ5xCy+OzP+BFJrljiHBrt5bgwp+qfcXi82BInM2LUegHH5CsQmkf8T2Za
	DpEvIX5o94WjJ18Eihd8FoVydeNGgGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-_DlqFi6BPeqLJ_VqC5O24A-1; Wed, 12 Mar 2025 06:09:33 -0400
X-MC-Unique: _DlqFi6BPeqLJ_VqC5O24A-1
X-Mimecast-MFC-AGG-ID: _DlqFi6BPeqLJ_VqC5O24A_1741774172
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso2195536f8f.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 03:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774172; x=1742378972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
        b=gXwWAd8sLKMU5dy01Cqv4WaldHLtBrhAR53KxgGXxmaH8w5mj5aRoS8gCVX4yIxwdy
         NGNQolV8TgqIiBbNI+I1wwU7xlvQF4b1XPKR3QX+Pr8YGmkKLY8kvCMhoe+Pt/HUZ95y
         5tU+0wTiBfwVDhkhXHZYriK8Tlgn73jarzYI9pM70G0neue9kOtrhkBy5/PWlF5MaLcx
         GnorcUQzyeYtz6w7ZAbL6hy4huqIkvhT277mU3f/sOKWGHpw4QR6HA6NKisxEgS94xQ/
         yDXhYSRXR9uZUpNj8EC5CNEm1ZnHvuvKpSjmmyq7eAcvDV03BUnlwi9pFXBJ/+7N6+zK
         EldA==
X-Forwarded-Encrypted: i=1; AJvYcCV41LfWGya5juQVnu+oaGYLBUiKRbwryoQYF3Q6bn4y8IPi6SMwQoGdhNhltp2hiDR+/qNCTHHI@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7PxVbtJSc1rZyOrA/9S3FeACGbNmuKenTrEPinvqiHN02C60
	g2pwkyex458oJUh5qkIkeHMTBk/vppLBcdCn7e8KfNGgFa7qXDSupF2H7BlTZyjTd3yjtZK7koS
	IwPRIGZ4EjspoL49XKAKmWMzyNt7dYxhQG1ToKSNbvkHrg+DB2Fa4qgg=
X-Gm-Gg: ASbGncsQTD41+QBcjmSbKg8dFpjDvsXsYPtkX9Dyy6eMT92p6OFa/PMmJwvtIYwm+Rd
	kOuLPQD/TF1MoKAMzQAbloIi1thboyR+LuLCVULrs+eSaYSJIi/C3RSmz5VkD15s+j2MuaQgrfE
	UqMLbSkLjVHwgXK2O62E5FcYmCBccOEEbO21sASyjOQEvidJmRShHqnqNoaaAOvKeIBpk8trGj7
	9p7RkHUn5YBsQhLs4OXc2JKfumPZUK8dJIl6P49lPgm6aME92fFAhze2WZaPEu0arIrJ++6KViu
	ATaxewzH6ke4hWrYR1Km+NME7tSdO3F/LcG06bgHlWw=
X-Received: by 2002:a05:6000:2ac:b0:391:1458:2233 with SMTP id ffacd0b85a97d-39132d30145mr16025044f8f.11.1741774172441;
        Wed, 12 Mar 2025 03:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC/oegylWFmX8HIfDOEmL2IfKq6J8f3RVSsBgAXMYe83/CsTxWQv7uki2xiMPLn7D1hW+oew==
X-Received: by 2002:a05:6000:2ac:b0:391:1458:2233 with SMTP id ffacd0b85a97d-39132d30145mr16025033f8f.11.1741774172078;
        Wed, 12 Mar 2025 03:09:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm20758388f8f.75.2025.03.12.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:09:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:09:29 +0100
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
Message-ID: <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>

On 12/03/25 10:53, Dietmar Eggemann wrote:
> On 11/03/2025 15:51, Waiman Long wrote:

...

> > You are right. cpuhp_tasks_frozen will be set in the suspend/resume
> > case. In that case, we do need to add a cpuset helper to acquire the
> > cpuset_mutex. A test patch as follows (no testing done yet):

...

> This seems to work.

Thanks for testing!

Waiman, how do you like to proceed. Separate patch (in this case can you
please send me that with changelog etc.) or incorporate your changes
into my original patch and possibly, if you like, add Co-authored-by?

> But what about a !CONFIG_CPUSETS build. In this case we won't have
> this DL accounting update during suspend/resume since
> dl_rebuild_rd_accounting() is empty.

I unfortunately very much suspect !CPUSETS accounting is broken. But if
that is indeed the case, it has been broken for a while. :(

Will need to double check that, but I would probably do it later on
separated from this set that at least seems to cure the most common
cases. What do people think?

Thanks,
Juri


