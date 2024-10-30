Return-Path: <cgroups+bounces-5335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222D9B640B
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D7F283116
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5F11E9093;
	Wed, 30 Oct 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8jmrLrj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276E1E7C11
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294836; cv=none; b=r4WinXbRXjtnN/icFP3ir7rADoKZelsrZ3WyJc5+eok0CEGS/E+plFqPxdYVG/L6ZCs63MUKf7H3cnRbcyeCqOfH8wSOWbJzzEVrcl8LIyFlGcrL4i+SX3+YStgUzbA3CS+EhHfw+LQ28RrxF9GXUOUWIqHDHuAaIuv6QeMg3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294836; c=relaxed/simple;
	bh=9e6O0Inrc0S2NfXiu9DIaNbgV/fEN0h4Z1kjcHVaOPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSTjLs+oKvqa5ATfEF3j+h60/58G2GcKvXcsYD+eJRG4MbS1aZlulh1KeWC6ahWiNeqp0IZy3UEA+HoL1GoLr8UYxw+qihERaBjEQUS9h8U/vTcZfXI7c6QrdyP84MR6qEpZLHjPCGKzhiAMmGtGCshchkOBKKEyFhxs/rfaZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8jmrLrj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso916168766b.1
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730294831; x=1730899631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HtbxSjryw90OYXsSzx4HPo4i/eL/q8xZDQ/o/edBKU=;
        b=E8jmrLrjs67D2k/B0W14vfZg7oDpAdOLWsbHQF5c1IBVs5lDgDV6duLC6/+ZO2+/j4
         KhARoESYNMb3EvgvVpQTvuOdY5chEmmA1tTrVvw+VRMWmM20MEaYAdKUACP5Ewv3ShZ9
         n2iHfT1vOENtkzO38PNbrteOwyBRUTdYF11XmJvNpVtUznoOtHs0DvSp3nI5Bu6Xq8Um
         clyyhCP5iPc9qWQcdJVTbUJFo2or7FdktAysFMZfBu6SMwu84aA9v2ue5wXIYrROatFE
         DpIOEjEcniQbJQJFfeoAg/yAnEwTUu+9GHECWUZg6rgS442omo9ZkKrG7Sz/zhwG8OwQ
         MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294831; x=1730899631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HtbxSjryw90OYXsSzx4HPo4i/eL/q8xZDQ/o/edBKU=;
        b=Gr+9g+Nh2xTqBj7pxVlYkYZZTzRU+trJP5GJabnMXPa3UElz+Gu6fV5rs/uq4yxe9r
         fmbPVQo+zLCfyQnH1QJiTRQukq8V2hCMX2Clsp7qaOWXkte5rOxW1ibwG59x3TjYYwkT
         6DX+tn6S+m0J3WeQOxw2YZCpB2+YGAftCBn3Upoyoz6WhIltiXeFICqLS37qK9Eo6WAj
         XPY/qTlAPnka5AxiopNGH8V0Rbf2R9eeu7Ga5VUyY/OGPmpk1r+YDtWx2Ypa8g2qxqlP
         hDhHfk2aktdwjSx2H9lG2vnP62boc09toYFr6ldQRrZzGoar6r87iGD5uRr8J2GKRHf7
         6xTg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJkVshrzIrlxGdOs8IRUWOz0JtV2uo8Xjkt0XS64rhZoH0SuPzOHNol5Cs9xTa/spr5+eYJDG@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/DANQf4gROH7zYjSvzqARjp7TqxEEiNgJBpHSKuW3TWqAF1W
	8DbeeeaLxFWO3IH7qIInlMSE8u9pfY8iPCkAlW/rMqgQZS3WEdWnseAh96mG+5s=
X-Google-Smtp-Source: AGHT+IGNnCF/FyNFK8tuf24boPmjQ1iWz91QATCHGLGVRRgZ9UV9vllz/ZNEqKzDBnkV52IH5/GP6w==
X-Received: by 2002:a17:906:c112:b0:a9a:26c9:ac14 with SMTP id a640c23a62f3a-a9de5d6ed92mr1556299966b.1.1730294831015;
        Wed, 30 Oct 2024 06:27:11 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbde87sm566397766b.23.2024.10.30.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:27:10 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:27:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyI0LTV2YgC4CGfW@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>

On Wed 30-10-24 15:51:00, Gutierrez Asier wrote:
> 
> 
> On 10/30/2024 11:38 AM, Michal Hocko wrote:
> > On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Currently THP modes are set globally. It can be an overkill if only some
> >> specific app/set of apps need to get benefits from THP usage. Moreover, various
> >> apps might need different THP settings. Here we propose a cgroup-based THP
> >> control mechanism.
> >>
> >> THP interface is added to memory cgroup subsystem. Existing global THP control
> >> semantics is supported for backward compatibility. When THP modes are set
> >> globally all the changes are propagated to memory cgroups. However, when a
> >> particular cgroup changes its THP policy, the global THP policy in sysfs remains
> >> the same.
> > 
> > Do you have any specific examples where this would be benefitial?
> 
> Now we're mostly focused on database scenarios (MySQL, Redis).  

That seems to be more process than workload oriented. Why the existing
per-process tuning doesn't work?

[...]
> >> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
> >> cgroup mode changes aren't propagated to child cgroups.
> > 
> > So this breaks hierarchical property, doesn't it? In other words if a
> > parent cgroup would like to enforce a certain policy to all descendants
> > then this is not really possible. 
> 
> The first idea was to have some flexibility when changing THP policies. 
> 
> I will submit a new patch set which will enforce the cgroup hierarchy and change all
> the children recursively.

What is the expected semantics then?
-- 
Michal Hocko
SUSE Labs

