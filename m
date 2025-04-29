Return-Path: <cgroups+bounces-7891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDDAA0AAA
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0531A814EE
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E882D9983;
	Tue, 29 Apr 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a7C2cKzz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFF2D4B57
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927173; cv=none; b=ksL7+OR5HiDNma0MI9SN0DhC2BwNSgCEO7LJH1evW5h4/e4TvySE+DouyfqfEPfrFSc+GTFAAIj7KFTjkxbXh3od8AdAjZ5ZrXP8e7all/kj2jOT5gKHXOTU2BX5TPjW8tz5ro1z1/sdBeWFXO9FJv/wHjvDGLUVKScPV6xc4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927173; c=relaxed/simple;
	bh=ULcK5tqpMbySYpVfeIJT28xVpefLfkaAs7WExUaK2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwcckfMfO2Q8RTeg2/0g8FNJzhLISaNvyawJDomTHFP3bIbr9eKasGsxMBxOcV1NEhL4oa4ZC5jUY0wWgr4X5QmaJQbaM8f+bRhh/C97/WabGUdOGluiMZo+D0BvfWPHrfHiRiYWL6iLw3kuAxvIoj3ViTyt6baKmJLCT2zBvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a7C2cKzz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb39c45b4eso935886766b.1
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745927169; x=1746531969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znQpdTxcq5Q59q25hWrDZ7jqcfAs7XVIcl5H5jOTHxU=;
        b=a7C2cKzzs5yVR2SxJNS71x0+DFcvalG3AghOtS2uiVLM5AZ76PHFlHPLtsu+ES8sed
         dF3/kWuVEjSlUIFMzEOd6nSF7Vfjm6vI6/iaC3zfpvzaqJhVoSapa0yfYBhifS9YysHR
         Epy9teKgO4XaTz3RKnVxaNOHW+xfh4m0R3RZqyrl9yJZaXa222G1KsxfJYmOjD8V+tyW
         ocd1SHaDznCXG0cIoctclzO700ie6+UkRtK6f642d/JD4a4bc0pEyk1KHU6yvSJL9xiN
         HJHcwE2yCQ8nsdCv65douqA26vAUpeeXtT2busSV/SXz5AluR/fletWR4Q33uH9cibEo
         l6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927169; x=1746531969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znQpdTxcq5Q59q25hWrDZ7jqcfAs7XVIcl5H5jOTHxU=;
        b=sfqoi1zOf/0w10/UqBYr1CI3+CmNPOCy6cZFsDk/I18tLq2gpPeflibXuJNnSLV3Xk
         PLjGjP8LNywZ7ka/RYLhQciPVK5rD4qNPdnxo4G0ayRVxi/TzhKOpoGJ3UnKSPtqCa9+
         Wkg2TvQtwcAXQqGpT3507Rl5oiwMpvIUqD74F3WtgOuboVSy5UbpMcfxhX1VvlIdcQ0d
         hjPseFdtg7czZbuHVg2VxDt/67/DA14X56RUdGKE6HAJLbGzPqQBg1Q2IZaVmLmyn+pN
         Sn6ejpt184oCQ6QVFmB0+GQU5nAMY6RYTxT7Ar0I119rnJ2ZMwXluqrbtvRwhzeIVSEa
         lPvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNogiC4CXnQuZsZEWQWsYJZXGyXcuayXS338piCZ731iisGh0X7mm+ksLVeG+tGPFFsKHT9OL9@vger.kernel.org
X-Gm-Message-State: AOJu0YytRc5eyRNkfTA0VjBWvfP/3WG3Lohhrc0KzzDpfgFpXQW0q/40
	prYV7Vih5AnLMxkMUtIqSbyMprnkW8qk4x8Vn5tvjBB75YzL7daWAuUwyQASIRk=
X-Gm-Gg: ASbGncsWfyFx/QBa4xe5ty7fdyI4vgIcUPlxofP3BgdpxhORSTBhQ30T79/J08yqgQq
	LMci8KKQ5EGWdfRJDY54d5V95T2Qc6XsghQXkYVkUZk8lZDq4VMA3QJ7r3jgO0Dps9V9IveUr2Y
	PE60oL23nuFQKmvwiblF2WXSC1nS28LAwFWPVBqnM7fVL5GqIOctK0WhGR48kwfyxpEZkyY1a3w
	4ILtU1IShzkVsHZRmU98+K3NVi9CrijonUWO3xBsw+FTClr1B2ArFFc2wxjZrZZBOn86CflH+Z7
	4mfzeFlAipT8cb0D0QY116vPq/sN8PnnTvXvVh8iEZLn9FjP3QUihA==
X-Google-Smtp-Source: AGHT+IHdwrLpQIpUiiyBR38B/ZttRSS4g/Wv80xkTkGlVkMPcowVbaa+12lFPhCvhIOfAu66scr/kQ==
X-Received: by 2002:a17:907:60c9:b0:ac7:cfcc:690d with SMTP id a640c23a62f3a-acec6ab3db1mr282121166b.40.1745927168683;
        Tue, 29 Apr 2025 04:46:08 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ecfa33csm760681066b.119.2025.04.29.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:46:08 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:46:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBC7_2Fv3NFuad4R@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-11-roman.gushchin@linux.dev>

On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> Only one OOM can be declared and handled in the system at once,
> so if the function is called in parallel to another OOM handling,
> it bails out with -EBUSY.

This makes sense for the global OOM handler because concurrent handlers
are cooperative. But is this really correct for memcg ooms which could
happen for different hierarchies? Currently we do block on oom_lock in
that case to make sure one oom doesn't starve others. Do we want the
same behavior for custom OOM handlers?

-- 
Michal Hocko
SUSE Labs

