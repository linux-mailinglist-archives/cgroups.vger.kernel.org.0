Return-Path: <cgroups+bounces-6612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8888DA3DBFB
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1151892AA4
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD021FC0ED;
	Thu, 20 Feb 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+RIB3Cx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51D1F9AB1
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059866; cv=none; b=cnkJqNjWTDFvFkmfHktoAJV0ycBJRdEUv6+Cxb3B/BqVIxTBPbFGyzQlHbSgngpba+Vs9TsW1tTq2HkBoDwVSCW4eb5Q3xkuGf77a60yuu4XieirWXGVXw0UWQ7X9BHNh2Y/n/lqSjlr6si1HloqJxKZZVCijZfdcN7gab+YWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059866; c=relaxed/simple;
	bh=zAaw7TSBKPS4D23Z/LaUwA9UKB+rY+vBnDdyES3CAN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHcAVAa0Ii4EYCILqckeDCUBJcTUXvoEQOI8OWDBMGocxG3HGFoOfMYwUlGDN1TxSYenZu+sDBdA74aO9+dm6xXVGPU57MxAsm1yWUjPLUks8C/5jfwuVji0qU9Z3psyscXdm3lg072OzWpfxEgGTvMtrIxj/5JP942bqbHdJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+RIB3Cx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740059863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GbsNh5jLWiTAFgo/FZTl4eCODFMMC/utoFBLfGp7ZI=;
	b=a+RIB3CxoEbYcgplokOdpHfQgGRCqM2RsqNAK7Ucc2y0JwicMp0euhrVJm3g+jxVAYPtPK
	jidcDsjzWu3ui4J+Zmj8CurjwtU7Ess9dqc4ssXX2fPMglNDhkcUOikFvo+/qS5NOO3ROy
	OuhaDKtS01lYZ/iVa8A6jEwmnptFkG0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-n4E2t8PuN4moT2bDFg9B0A-1; Thu, 20 Feb 2025 08:57:41 -0500
X-MC-Unique: n4E2t8PuN4moT2bDFg9B0A-1
X-Mimecast-MFC-AGG-ID: n4E2t8PuN4moT2bDFg9B0A_1740059861
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e067bbd3bcso1189774a12.3
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 05:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059861; x=1740664661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GbsNh5jLWiTAFgo/FZTl4eCODFMMC/utoFBLfGp7ZI=;
        b=Ifjqi1p0TpCzrm3+qL+0s5tTQ7UyODTcBdiji7ufRNolqB7MXIxtpiBslMniZWF1ea
         FT0RYQrqkY6tB3JyNOHhLjEVweCUd1auXBTrWlqP4+Gf86Wf2dIcgOfT2VkU/Gi3PAS7
         5dTKt1k8vSKmo3XSyzMNwF0idv1QxNB8IzQ1tVAbA8jWgPvsXmLuJgrleZMgT3FOdLUR
         S9UqvOWzcX7HUlxaKQtp/gw6qbwBv8+KfXHSCth4Dd5GAPr6D+OWpt09L3cqes83pIsU
         ScA66/7RIKfWfLlVeu9+uAYb/7IJjNVAyigxMwCSk570vCIydaqTo+uT9KmLU4S+15pi
         nohw==
X-Forwarded-Encrypted: i=1; AJvYcCUnaLiXhUM7WtN4Tdvyd2qjgYDK881QLiQ/hmnLh83QmtqFhKuHZGgpLrshPU5lQlpfL/a6EpAa@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFmKOWw+KY+fGBykPJqVpOIAtq8sNNq2GdgtF/qMpQeEy6PUs
	k6crATNiTaZLlD9wUt+jhmSLsQ8bnygGo29bxBi2MGljpsuPZQsIlyw93/pe3u+QXPYHZH3YNrr
	q8R/8iJ3x+V3neiCOWSVVMH0aEsZx6trUASCd7W1DpGSs4AOi5QD97wPpD8cmm+pC7By5PStKPU
	XwflOP1rthSQANeaFMQQYxC73eJXqQeQ==
X-Gm-Gg: ASbGncs6PDT7V1j+3cB3oqUQsOt4KbRRp5W8mbRVbokmheWP8YPJ5LRCex85uLMkOg9
	evs3+d328V4D9PT8p5tbH4TSLr/2zQFxoVT3Lh1YtgctmzMzX8CQ84Iz/tlI7oaS/c3Drsgx2fZ
	DRYD3kJHGUpyoiwp6o9StB
X-Received: by 2002:a05:6402:460a:b0:5e0:9f31:a27a with SMTP id 4fb4d7f45d1cf-5e09f31a801mr3841240a12.5.1740059860677;
        Thu, 20 Feb 2025 05:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ+HSoxaX4rgKgD2byWHvvYbCPJjojznGobqymjwiQmeynvrU3zlKQt2bAZTWEv659d9UlR7HukDtxZzIxLws=
X-Received: by 2002:a05:6402:460a:b0:5e0:9f31:a27a with SMTP id
 4fb4d7f45d1cf-5e09f31a801mr3841226a12.5.1740059860356; Thu, 20 Feb 2025
 05:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113190911.800623-1-costa.shul@redhat.com> <Z5EmtNh_lryVj0S3@localhost.localdomain>
In-Reply-To: <Z5EmtNh_lryVj0S3@localhost.localdomain>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 20 Feb 2025 15:57:04 +0200
X-Gm-Features: AWEUYZmgTIAbbHosP3KBusFPXm12J57Mr1T2iuZFofHgH8azDvEd3DyReff4XjM
Message-ID: <CADDUTFyoc5ecrYd-DAoMOndy_TMGy+D_UiH5M8UR6F6pjZcA2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1] Add kthreads_update_affinity()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, 22 Jan 2025 at 19:11, Frederic Weisbecker <frederic@kernel.org> wro=
te:
> > @@ -1355,6 +1355,7 @@ static void update_isolation_cpumasks(bool isolcp=
us_updated)
...
> > +     kthreads_update_affinity();
>
> A few things to consider:
>
> 1) update_isolation_cpumasks() will be called with cpus_read_lock()
>   (cf: sched_partition_write() and cpuset_write_resmask()), therefore
>   kthreads_online_cpu() can't run concurrently.

Sorry, but I don't understand what you mean by =E2=80=9Ckthreads_online_cpu=
()
can't run concurrently.=E2=80=9D Could you clarify please?

> 2) The constraint to turn on/off a CPU as nohz_full will be that the
>    target CPU is offline.

The final goal of CPU isolation is to isolate real-time applications from
disturbances and ensure low latency. However, CPU hotplug disrupts
real-time tasks including the oslat test, which measures latency using RDTS=
C.
While performing a full CPU offline-online cycle at runtime can help avoid
long reboots and reduce downtime, it does not achieve the goal of
maintaining consistently low latency for real-time applications.

> * scheduler (see the housekeeping_mask() references, especially the ilb w=
hich is
>   my biggest worry, get_nohz_timer_target() shouldn't be an issue)

Are you referring to find_new_ilb()? What are your concerns?

> * posix cpu timers (make tick_dep unconditional ?)
Do you refer to the arm_timer()?
Could you please clarify which condition you are referring to?

> But we are getting closer!
Thank you very much for the detailed review!

Thanks,
Costa


