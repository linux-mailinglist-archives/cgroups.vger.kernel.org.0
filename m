Return-Path: <cgroups+bounces-2542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF88A74A9
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C3A1C21557
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12B9137C35;
	Tue, 16 Apr 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvbRZFBB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8C137769
	for <cgroups@vger.kernel.org>; Tue, 16 Apr 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295662; cv=none; b=ZkazKf6TNw7jihUyZ75h8mqD+srfAu4KDgx44mWLMG6xvxUHQzpdJofjM+HR5beu0nziNx2lnBktb/OoDnePsgRT9a1iKoSbxQlVdlua8cXBW8CffQ3Bs9+kjNBF88JVNOShEp7dEqiUaYJ1WkNB44aNyt8IKD3mDRrNBYeZTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295662; c=relaxed/simple;
	bh=RufGQt9my60Mib6mWU1jcDTJNb1IE0wkA2B8tPsK8us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wt+WHb8iZLfof4EODLb0zmfTumjTRAvREyuGbyrYsxegePws+YMRElTUXwtxum8rJIIbmMb13yspPGNdTLqTWA/wln0KG3d+a3ddmfwlw4AbtVCwgSpv6c7sChvR7N4EF0v+/MAecT6RkwfqKx22hJpGcUSz/iiT+5A3fGp8xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvbRZFBB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a5066ddd4cso4447947a91.0
        for <cgroups@vger.kernel.org>; Tue, 16 Apr 2024 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713295661; x=1713900461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsLs5TwgQbCoTsIhV0PbmPPMuBa5UPbtwmIm4dUFoNk=;
        b=SvbRZFBBHdUyF2JQkr/B1Xk727bFBqVoePFp28FftSdwLHsmTsBPvmoGGhR1n3NEyy
         qr0B3vDvwaaFDBjQ7mfjhH3+k9l0CH2F3pa/LkVW58A8QyG+KbkW7DYd44TFzQxWDOo1
         BJ7Sfiri0/E4F1olSET/nK9PODdBc3YWbB57IDkTuRFeGhGYX+eZ4zE/jRaHzv5xx/oe
         waoRf1Sp9UO3Oh7rxqePykg1YPdypiRpee4K4+GoY+140Q5TKG5uhd6ktn9uZh95RWLZ
         GF48QYwJOuJf9PVQGw4klPVIhTQa7Xvm/u2pT/SSdF0tfKAp3DA1WSXtJilKHDUi7jJx
         7hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295661; x=1713900461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsLs5TwgQbCoTsIhV0PbmPPMuBa5UPbtwmIm4dUFoNk=;
        b=KTgVX5LjSItVcWGoN5sgdnypRb5iJREak8d9BdfMchBxjuLT/qnu+U0Sow/W0SOhPg
         a1M6c9GHx96FvkLfjRZDkOR7jSPxyRSQWX7S62D1J8eWH6MeChvm3g10EHrZZETkHCKB
         TBf67cM+xUT8w2ARHG9BuKcgOL4yWhbLCRE8I1EYAlJ1yzIBMhLN0C0NdlJ75fEPyZJj
         HwrJ4KNTaBs6hGd5D9eGdFzgybQltUsjk/HK7iwOc24U3IjOT2h1uyRDCBYkpruYkMA8
         JPOCOTBN9UHBySJi/DtsC+cGtTkHwiDD3fAT/H9lxdT2MY/uWlETLlyEkehqORuNGLSz
         KWEA==
X-Forwarded-Encrypted: i=1; AJvYcCUAS0Oj5GYcW5YtuTFOU5rQCpSy6ip+rmsjft5wXoYNpO6wWeP67045b0Emy6PVSw0Y/vHtkx0XVv0Ad6QDjkF+RDs2ccs0WQ==
X-Gm-Message-State: AOJu0YyTFXvuGixhoOLWB084p3tAPZmq5pCO5pRE4ehhhjlbQtfRsCPX
	iRMIhrN4zYS3CJcvp8xB4Pdxp2vgqrf62GM1vF2DuiIXsvnZre9z3vg/QaX9roqj+Sr8IOVXxTk
	NQZSJ94MEPJJhMlBskO8pPg==
X-Google-Smtp-Source: AGHT+IED/ON5W+u4mp98k4aqr7W8SbX1tGPdGimAJ5/wpGhdwwYIMlKzk0LXAacFJYRY3XXR8O+beFOD5S0sddsmYg==
X-Received: from souravbig.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b3a])
 (user=souravpanda job=sendgmr) by 2002:a17:90b:3bc8:b0:2a2:8b25:745e with
 SMTP id ph8-20020a17090b3bc800b002a28b25745emr87242pjb.0.1713295660670; Tue,
 16 Apr 2024 12:27:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:27:38 +0000
In-Reply-To: <20240321163705.3067592-31-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-31-surenb@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416192738.3429967-1-souravpanda@google.com>
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
From: Sourav Panda <souravpanda@google.com>
To: surenb@google.com
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, aliceryhl@google.com, 
	andreyknvl@gmail.com, arnd@arndb.de, axboe@kernel.dk, bristot@redhat.com, 
	bsegall@google.com, catalin.marinas@arm.com, cgroups@vger.kernel.org, 
	cl@linux.com, corbet@lwn.net, dave.hansen@linux.intel.com, dave@stgolabs.net, 
	david@redhat.com, dennis@kernel.org, dhowells@redhat.com, 
	dietmar.eggemann@arm.com, dvyukov@google.com, ebiggers@google.com, 
	elver@google.com, glider@google.com, gregkh@linuxfoundation.org, 
	hannes@cmpxchg.org, hughd@google.com, iamjoonsoo.kim@lge.com, 
	iommu@lists.linux.dev, jbaron@akamai.com, jhubbard@nvidia.com, 
	juri.lelli@redhat.com, kaleshsingh@google.com, kasan-dev@googlegroups.com, 
	keescook@chromium.org, kent.overstreet@linux.dev, kernel-team@android.com, 
	liam.howlett@oracle.com, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org, 
	mgorman@suse.de, mhocko@suse.com, minchan@google.com, mingo@redhat.com, 
	muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	pasha.tatashin@soleen.com, paulmck@kernel.org, penberg@kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, peterx@redhat.com, peterz@infradead.org, 
	rientjes@google.com, roman.gushchin@linux.dev, rostedt@goodmis.org, 
	rppt@kernel.org, songmuchun@bytedance.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, void@manifault.com, 
	vschneid@redhat.com, vvvvvv@google.com, will@kernel.org, willy@infradead.org, 
	x86@kernel.org, yosryahmed@google.com, ytcoode@gmail.com, yuzhao@google.com, 
	souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"

> -void *__vcalloc(size_t n, size_t size, gfp_t flags)
> +void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
>  {
>  	return __vmalloc_array(n, size, flags | __GFP_ZERO);
>  }
> -EXPORT_SYMBOL(__vcalloc);
> +EXPORT_SYMBOL(__vcalloc_noprof);

__vmalloc_array should instead be __vmalloc_array_noprof. This is because
we would want the more specific tag present in /proc/allocinfo

