Return-Path: <cgroups+bounces-5342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C049B6794
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8DA1C20964
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823E2141D6;
	Wed, 30 Oct 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xo6mshiO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56272141CF
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301329; cv=none; b=roFYx9ppXIe60Yh1ErKr7mN4O3YoqA/oe7rCsyz/KDgEkp/jypIU3k9SXWMMBIHZXtJqbjFa8JpmBDK0o/2MlByh+sfbMKkRGgjal2FvRGtrMCFZkFUiAi9kzNLs6nUOiOxOxwOiQtw/5G0ckL8S/H99ZhWIbkMw8SftdBiQ8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301329; c=relaxed/simple;
	bh=qqYEMyI6sX4xCkMKVuzYgDlpga1SNQ2xr3Wr3Dao+cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whzw/rtMsYzXBmy67+3s6BJy7/ZoW63d9XWQT40O8M0noSDgDQWtSc2vBc3oVA6jHQB2qF/jpljHKQaCA1muc423XaovmLQzGAcVz1Gl41X2gtHanabHj/WylYDwJmVcSnP8OKGQgf7k/jgTAlSOj1q52/Mh2TjIYEO+Ghbtotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xo6mshiO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so20428a12.0
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730301325; x=1730906125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mXV62pgMZbmaqYrc2CINf4sAWYHtBW5gtgN0SFvCuQ=;
        b=Xo6mshiO4ADx8wCfQdrzJfqq3xpPpogTiBY9MZPm6TJgzc9kC59WEzNBfRd+NnnWqd
         IWvP6ynrkSbtZJmYyQhuFCmd+gqyt8JOMib0MTmh2PU1aqpnNRh8jv7722eEeXUtq17C
         xWAJnzUcmnCVtu+dPWeTSU6jPhWBJkhqOyAt92GRYgIIeS8PECd7PvgZU5XKuSz5AJCo
         /L42ycVT8TZV0UAWsGuaL29ffpIve/477dHK1xwpGBV4Wvj0nm3eAEUmZnU0KxK1S3ag
         iDAee5HFslWFhwFA59emCaUdzAAf+UueZ38lf+4JG0apyjqCo1qZ0b6TUGdldOlZfMb8
         NhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301325; x=1730906125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mXV62pgMZbmaqYrc2CINf4sAWYHtBW5gtgN0SFvCuQ=;
        b=J9ZJdrAlBh5PSdwpNklrcxIJxl/9lihFvfcv1xLTWoBAZH/s5mbA3WoNlTYn6outmM
         +A1+9d8lxOG5Z5nkwEWyzhdPQltt5q3d5fMia+uBNCvzg21DsRDagB+RB0NXg/Jj+jyp
         TWc/YvojVNHsAIT5gY0Lj3xMH7jH/uDbLOuyIwsa7FQu13zF1usap9Fo5F/RpSB1H0d0
         NtEbnqDA3pt2XYOzqIdu0IhUJu93P79+XJ9t8wOLGoreBz70d9V6RfilWllZWeqjBv8g
         1K1iaufA/390WcIwUcKIDKg9kyecXmhJZ92wFIGqkhXGatoHE32GC5hHueGkhc5AjWZQ
         93/g==
X-Forwarded-Encrypted: i=1; AJvYcCW1RNVbm52LEi2Jd3pivuL7cnwKRS7dPPbckwzckvc/IU5bVS3DPKIhm0JUzgzTgZx8k6OUrk2n@vger.kernel.org
X-Gm-Message-State: AOJu0YxltWyKOuc31z2TeOUTG88wIxqzTFuWhU/DykhkhgupM5CqNx2E
	HbM93l4c7impsQV5tv/Rs1x8PDtfIubdy5Dz6WONwweYSdYaLFgBW+6PeayLeeI=
X-Google-Smtp-Source: AGHT+IGjLjC5WVGAkUHRu5xNuEkhAwUHz0t+DNaa+GRia2twxV7czGC15dNpQlzuzVDPwmh3J3fQYg==
X-Received: by 2002:a05:6402:350b:b0:5ca:193a:8b5a with SMTP id 4fb4d7f45d1cf-5cbbf8d84a8mr11804108a12.21.1730301324548;
        Wed, 30 Oct 2024 08:15:24 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629cdb7sm4809120a12.28.2024.10.30.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:15:24 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:15:23 +0100
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
Message-ID: <ZyJNizBQ-h4feuJe@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>

On Wed 30-10-24 17:58:04, Gutierrez Asier wrote:
> 
> 
> On 10/30/2024 4:27 PM, Michal Hocko wrote:
> > On Wed 30-10-24 15:51:00, Gutierrez Asier wrote:
> >>
> >>
> >> On 10/30/2024 11:38 AM, Michal Hocko wrote:
> >>> On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
> >>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>>
> >>>> Currently THP modes are set globally. It can be an overkill if only some
> >>>> specific app/set of apps need to get benefits from THP usage. Moreover, various
> >>>> apps might need different THP settings. Here we propose a cgroup-based THP
> >>>> control mechanism.
> >>>>
> >>>> THP interface is added to memory cgroup subsystem. Existing global THP control
> >>>> semantics is supported for backward compatibility. When THP modes are set
> >>>> globally all the changes are propagated to memory cgroups. However, when a
> >>>> particular cgroup changes its THP policy, the global THP policy in sysfs remains
> >>>> the same.
> >>>
> >>> Do you have any specific examples where this would be benefitial?
> >>
> >> Now we're mostly focused on database scenarios (MySQL, Redis).  
> > 
> > That seems to be more process than workload oriented. Why the existing
> > per-process tuning doesn't work?
> > 
> > [...]
> 
> 1st Point
> 
> We're trying to provide a transparent mechanism, but all the existing per-process
> methods require to modify an app itself (MADV_HUGE, MADV_COLLAPSE, hugetlbfs)

There is also prctl to define per-process policy. We currently have
means to disable THP for the process to override the defeault behavior.
That would be mostly transparent for the application. 

You have not really answered a more fundamental question though. Why the
THP behavior should be at the cgroup scope? From a practical POV that
would represent containers which are a mixed bag of applications to
support the workload. Why does the same THP policy apply to all of them?
Doesn't this make the sub-optimal global behavior the same on the cgroup
level when some parts will benefit while others will not?

> Moreover we're using file-backed THPs too (for .text mostly), which make it for
> user-space developers even more complicated.
> 
> >>>> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
> >>>> cgroup mode changes aren't propagated to child cgroups.
> >>>
> >>> So this breaks hierarchical property, doesn't it? In other words if a
> >>> parent cgroup would like to enforce a certain policy to all descendants
> >>> then this is not really possible. 
> >>
> >> The first idea was to have some flexibility when changing THP policies. 
> >>
> >> I will submit a new patch set which will enforce the cgroup hierarchy and change all
> >> the children recursively.
> > 
> > What is the expected semantics then?
> 
> 2nd point (on semantics)
> 1. Children inherit the THP policy upon creation
> 2. Parent's policy changes are propagated to all the children
> 3. Children can set the policy independently

So if the parent decides that none of the children should be using THP
they can override that so the tuning at parent has no imperative
control. This is breaking hierarchical property that is expected from
cgroup control files.
-- 
Michal Hocko
SUSE Labs

