Return-Path: <cgroups+bounces-1538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB1853EE1
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 23:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13D91C22385
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7362813;
	Tue, 13 Feb 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JN+F//BL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D6627EA
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863900; cv=none; b=JBeREwllJ4ZAgmOIU/FSIlFaj9LYU21MmhPNEssjDCiaOCa2JGekNSOTfCqf1dOZyKCwD6L1GvqZ9xOSl5+XkbFLBRPTGRmprW8NWqE/RDMcDd5CY5gUDrVa3whscDUHgDsE0dMbf9nT+zoPa4u1xHT8fcaxchYClyoKcKWMF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863900; c=relaxed/simple;
	bh=5lmrd2HyuhPw/NKgKAo36swBOE5JwrmFU/lD03z4V0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX0mJ6ldncMQnjqJ4c8c7IQUD55X65Ew67nY2HI+0zMl/fIItv997Wfp5L0Ow6dLy/JHVyDSsUXqDmApqydh7+1bw7Epc2Z/8fMG8HrQqPH/3Tllje+Aly2Ddow4BL/0XCFExvd/ylx6t7xb5hcCdr5Q9Ph+o+8p3K9ZNZPqk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JN+F//BL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290da27f597so2872182a91.2
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707863898; x=1708468698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2hiMS9Vllp3coocjvge8ABDhc28Vq8F9ZVWNu08lRdE=;
        b=JN+F//BLH7Bz/09VqERqN2GIBcP+TbsfziWnzCv44cKRm8+QI8c6fsRD8VpVYozHp4
         ZeuKjVg6bOhmyfSX6+yICv4uU2evm5CXHVx+of1l7AFBToCop6DZL81gdRz04pUSfjQV
         3rjHtZtyuSsrybiPg1kzNoz8Z1CYySDw4MrwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863898; x=1708468698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hiMS9Vllp3coocjvge8ABDhc28Vq8F9ZVWNu08lRdE=;
        b=mYbDQciK6MN1XrHwDKKasV+Jc29U4E7Kk4Z7V2J2bxGSmNvhGu2XHQHSQ+qcISbcPB
         HaRYxZc0uxBbEAF/5Gyow2MV+DkJichjV0P0doUpqzYsbod/VZluT/ggiSq6d5my8448
         afjncPZXDJzMlCbJCTcU4JAarWZeIT6LGt6FFP7Sq3UNrH7moQDJyOJkEl/c7S/DxgNk
         GWvzWUZwU+CLRFi8HbZZZtPw7Ik9X2DBIIrF8ST6Jy7ZORLuetKSXnEq7qzvqkmks4D/
         FsM+MJtQmhRYy9kcPF2wWe8JYnoFN5fyOADg1VUDlPG62yK47krGYyQdeeCFducVxl7S
         OLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSGtJYkr42rpJo7eHMSvotaBjOwp5V8smfoM2XeZpGpIYQX4Wol1E6dhORSyZE9px+7fp+OZTeddhYILzV7oDpgNzCyEFDNw==
X-Gm-Message-State: AOJu0YyB9ckjTwvmwwLfh4m03JQs2ZF/QTUs0sY0CHSZQmcijLYBAVdf
	IpcKTEEsAAundexWXS3GkB5xmth/39xGCdGTK4Aj7FqC2E/2N+GO5j9lGVak4Q==
X-Google-Smtp-Source: AGHT+IE89BKAX6X+Al/HN6rgXjncoMtWEvqiu4lqGZS4dH3e78NFlTKLgL96lwHD/24OxhZvDCwx7A==
X-Received: by 2002:a17:90b:24f:b0:297:1a1d:ca86 with SMTP id fz15-20020a17090b024f00b002971a1dca86mr997602pjb.0.1707863897956;
        Tue, 13 Feb 2024 14:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAJMGyS+cfE4Vm2UEiNKI/hecsbcAVG5WU/JHrRKkPbyIxrhsVjUn6Zi9OuF7mJnze7EYdor6qYoOKsCn8l4tMQmYmK/j47yu3M/lPS0Y9IgNhGhxdzHYC8jRKF6rcYTdZaVet8GHijHrj38weF04EDit6f8h5F20f2KGuxpehNQx3o3nAJox+coa8a+bjPvLNx0oEvLdolQ+1lVVE1tOCDnC2pgOuoKCMVZMqjMwPFqNvV7uULLMZiLRgxI8gwLUpFy/uV6qID+9NjuBNYMG12vCZHM7WCP8Bdd/jNaEXKRzpcngBW/+mwAuZ+gPLq9Ts+obYMaH3/Un48+/pL4/Lu6yj7TGH0wp2nRRqVVMMbLJMARzVsoQcMSapaM3EtoFqwoxydbubxnv3yVpvPThtnhILB0yRor3VOUu6pH/xtpAUORQUgIExaI8bixGj7KfPYv+uqJ71f3YzyS7zHqDC3D6peX5jywvDEn2CoBxOoF9qZyOgpIwmy6K+eWdJJtn187KGDWfVsmIu5FaSEbq4susI7ZxfLL1Rmz1bQ5sq4PhxOWIzGjs6L740RyKsDndaNQEXn3jZmwrl3+Cfq3vuCb9nM+t0chloxM8OhhopMK8HSW48i2nxxMPLu1cQBlEA0KpkMHRrltEIKuhNqiYXuyvb4j6P62sHq8bVVDcROr2w/LNlYg5lS203DjRScHnWHA+YRRiCxw9nSigv402S5c1vOEEGgb/528h2sdwRyBoL+ZLMZ7Q9d/5S8UAa+eMaYQSXcs8oQ9VlgNcIpfQm26V+
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 60-20020a17090a09c200b00298b2d60ae8sm40014pjo.11.2024.02.13.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:38:17 -0800 (PST)
Date: Tue, 13 Feb 2024 14:38:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402131436.2CA91AE@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook>
 <CAJuCfpGU+UhtcWxk7M3diSiz-b7H64_7NMBaKS5dxVdbYWvQqA@mail.gmail.com>
 <20240213222859.GE6184@frogsfrogsfrogs>
 <CAJuCfpGHrCXoK828KkmahJzsO7tJsz=7fKehhkWOT8rj-xsAmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGHrCXoK828KkmahJzsO7tJsz=7fKehhkWOT8rj-xsAmA@mail.gmail.com>

On Tue, Feb 13, 2024 at 02:35:29PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 2:29 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Feb 12, 2024 at 05:01:19PM -0800, Suren Baghdasaryan wrote:
> > > On Mon, Feb 12, 2024 at 2:40 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
> > > > > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
> > > > > instrument memory allocators. It registers an "alloc_tags" codetag type
> > > > > with /proc/allocinfo interface to output allocation tag information when
> > > >
> > > > Please don't add anything new to the top-level /proc directory. This
> > > > should likely live in /sys.
> > >
> > > Ack. I'll find a more appropriate place for it then.
> > > It just seemed like such generic information which would belong next
> > > to meminfo/zoneinfo and such...
> >
> > Save yourself a cycle of "rework the whole fs interface only to have
> > someone else tell you no" and put it in debugfs, not sysfs.  Wrangling
> > with debugfs is easier than all the macro-happy sysfs stuff; you don't
> > have to integrate with the "device" model; and there is no 'one value
> > per file' rule.
> 
> Thanks for the input. This file used to be in debugfs but reviewers
> felt it belonged in /proc if it's to be used in production
> environments. Some distros (like Android) disable debugfs in
> production.

FWIW, I agree debugfs is not right. If others feel it's right in /proc,
I certainly won't NAK -- it's just been that we've traditionally been
trying to avoid continuing to pollute the top-level /proc and instead
associate new things with something in /sys.

-- 
Kees Cook

