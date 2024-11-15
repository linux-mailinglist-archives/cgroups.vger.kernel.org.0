Return-Path: <cgroups+bounces-5571-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32A9CDD0E
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE7C1F21AE2
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2E1B4F24;
	Fri, 15 Nov 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg9JOtXn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3571B3920
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668078; cv=none; b=CBfPSQIfunefMPuOy+cSGRCvkaaHZLew+/Dxl2+7LECKd8I4tdDFC+BxiKQjpnUI/a7sdRIdh/ZXqMWpaoNbqGowblOPPyTWzQGXa6VyYA4hteXYrWKrqVSpOs/IKDrsooLH3qQBYVGnjP1WF1eguhrBCLSiBHnK5hOFZtn1e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668078; c=relaxed/simple;
	bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT/TyEgmbi+ZfxRHirQstSJ+BFFI5+X37A5qAMid0Gem0A6j/Cf2saqrolI7T5QaGFL5HntvgVpGRkctguKmsy7Q/W3nggINJVfRsWv9gXOWMv49vqOjo1PCGOmlYXyDKehyJOVM0aud2uu2GXpCReny+9hPaZDOrNDgxk/jZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg9JOtXn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731668075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
	b=Jg9JOtXnpxWY23wa69Xy9kFb3SIy/ng7WCzh/VeYffflRBKvjojwRvMVG7vKdC4ui1KvVL
	ZP2q/8kOe4eg2NIT/7dbHEzkxZFySepoMwfRyJQ9LFesLnRJ5uhzhM4Hwyxlv0na4LWDt0
	JUiSCfSpJ4vm/QDpOzNXYoRrVTY8HPQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Uq80p_l0Memv6xmuP7OQfQ-1; Fri, 15 Nov 2024 05:54:34 -0500
X-MC-Unique: Uq80p_l0Memv6xmuP7OQfQ-1
X-Mimecast-MFC-AGG-ID: Uq80p_l0Memv6xmuP7OQfQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d56061a4cso933328f8f.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 02:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668073; x=1732272873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
        b=o62jt3SWWIJNaRl3jfwICKnUIyitC1hx6rBy1qYcoDe9/qKnzbPD1grgCpG91IoyEh
         PcPCLHNL3GdMCjiRhJpbptvM1q+I8mxgwcB6D2Oj13Pn8y/3AEfz25cWTEfde3luk4Be
         3TVkrSqUmOuJoOluq+3Brpbcj3hgSsq2eRaaAzsapCuNTPWBpFsqZYYjZbertgJ8Fu6+
         6godh2jeSjXRytxTe087evY6+WKC+MqJH+OcF4RNYMp9Q47t2j8gaMT1TymS9sbloYqg
         Uy2/7D5MMtPr2ukwFRFxLOTViyL8XU8+d37FLxZvKcQ6rM2WXNknQntJWLgN8zl+t2A/
         8GJw==
X-Forwarded-Encrypted: i=1; AJvYcCWCMui8Gu7VaI+CYRRMKWOpFF7rHiIvOoAqbsyqg5xDr8szBlWuXwCwUuaUtZXq+BKVir4OC6Fq@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbcXHXPHR+cd4HYcvawTjughyS5sv/OKq15VBThqbiBgzowl6
	olG96TmfyI/CfSueo6EJqV+vdDv07nnmgLzEum1/HHPRzTva0sxV/aSMducSxUB6EQR8rjrVqAJ
	OHveAlNvAg410+SPnCMBj+LibmTws4ggbhACaXBkENtLG//htr5rtAj3DKYn0ccU=
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id ffacd0b85a97d-38225a89fe4mr1992783f8f.46.1731668072814;
        Fri, 15 Nov 2024 02:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMLLahLve2i85NSHyBQknYctxJFodWGkT2mc+GIqMJNAdazw+5Xuwbvgn0mTfJ/qu2SQDiMw==
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id ffacd0b85a97d-38225a89fe4mr1992766f8f.46.1731668072454;
        Fri, 15 Nov 2024 02:54:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad619sm4022252f8f.27.2024.11.15.02.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:54:31 -0800 (PST)
Date: Fri, 15 Nov 2024 10:54:30 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114181915.142894-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114181915.142894-1-longman@redhat.com>

Hi Waiman,

On 14/11/24 13:19, Waiman Long wrote:
> With some recent proposed changes [1] in the deadline server code,
> it has caused a test failure in test_cpuset_prs.sh when a change
> is being made to an isolated partition. This is due to failing
> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
> validate_change().

What sort of change is being made to that isolated partition? Which test
is failing from the test_cpuset_prs.sh collection? Asking because I now
see "All tests PASSED" running that locally (with all my 3 patches on
top of cgroup/for-6.13 w/o this last patch from you).

Thanks,
Juri


