Return-Path: <cgroups+bounces-5340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570099B66F0
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 16:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0079E1F2193E
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D91FEFC8;
	Wed, 30 Oct 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z9qzvw2q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7B1FAC26
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300700; cv=none; b=b2r05QiNgnKJ7taqfdnCfvG9ieVaPTdQARMy4vuS2hQ+6e46qKdYxHiQuY7+RJinAT54LNUA5rUXIRVXS6abX7xRNU9FZchOpR/oDRCFlH8VYeuidn9lwsSzS/qQKG6BTE331hDgwC5oFpQ791VeBb5iqQTjtsLX6cVABXoD6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300700; c=relaxed/simple;
	bh=WLSXttbBN+Nchtr3DXS0Di4OQPiMn1CjhtNhKfp8TH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS8/ns4ib1Fu8R7P13rv3km4VZCQIO8aRMt8q9wjhTXrTqjrCg3crdVz3lqh4KTJCTy3x8ZnZiCpRTd7Uni2YJRGfLjFkn89w3J7KK5cO29MEsbkht1tYHT+EXZ3i3gPFnsSa//Fk4czropjS9XAcoHjk0+EpAccXT+UCJrlPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z9qzvw2q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so159819966b.0
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730300696; x=1730905496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvVdPi8ansOXvDJXtgFjdjSxu3XdMpqKtWClsI507QM=;
        b=Z9qzvw2q8Q9LNwJnIK8knRzPFiDU0Zg09LBpCY5GqxZvUVV3OxNYN3e30lrqsYQDld
         KwV9MNGKDqpaPQveVdjyF9R4c6mXPXp5OuxA9cJiF3+6oXUQ5rXDv7lDm35+0gTJMWsT
         ovMDAH9fT3wzZZo/drhGjIhfEiQdahiqEhgLI1UWwEiwXq69UfcXV/xHCd4u1xZ8pQ6L
         AkTdePyW+gVObvZse+fkuhB+tHCcx/UCv2Cs2kLuDAm560soq3Q7NxRVyXwS/xwoCaQ8
         sIZnQGm04CvpoJsHW8I4pbp6fmsCZAEIlsu+C0HdwIj3d9Lej7iDy9kUkaPYW8ZNltJs
         rV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300696; x=1730905496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvVdPi8ansOXvDJXtgFjdjSxu3XdMpqKtWClsI507QM=;
        b=OX5mAmESGAu7VvWxZLqN6oL/jz3AG/F51/cQe6n35J7Rw/NsNUNj23WjCFs33V9LW7
         mpWEzmzvSZZd9qWYdgVnyfJRnTauRIhqoplM0blFIWmPVxolh2eiJiWgrqrcL7hvESBH
         EdsRpPZj6/CT5l1KBnwbwXOArt6xFHM+KBy9+sdkmfyFk/hO9ARjAm7b/d9X2RvbAJOU
         q4Rwar944/4ysbDPNew42Xo55XWXthr+dxCaGSFnaPvTFtoX5CndtQnI1kAhUAsb/OMG
         LYQEiHwcqortn4uge40gJd6UsSVhp6qKI1XdcHLY0oPnw5uBjxcvQyMvcD8RlrK8t+lu
         v7ug==
X-Forwarded-Encrypted: i=1; AJvYcCW+SFT9A0sMc2JWgjpousP7bYw3hNMXgeRCSfuq5dSqpuB5N9L2ZBmDygi9lkHnisRKSe5fqZvc@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhY5gVtE89+wxIhWDUwStfv6agOpMFL/PgMElmlS5rhkDa/4y
	I24xPmAeBD/jYMPOj3sMitBuBm+umfDG8JK3V+qm3DC5lhJXEeFPmYZFcHE7Ebk=
X-Google-Smtp-Source: AGHT+IGPlZuIqSn11jkgKQPEzOuv92CbR8SdcSXqv4p+sYZbAqsDGdMUGuu2IPloDxzpWtDzRrTRrQ==
X-Received: by 2002:a17:907:2d86:b0:a9a:130e:11fd with SMTP id a640c23a62f3a-a9e40b99491mr228194566b.5.1730300695909;
        Wed, 30 Oct 2024 08:04:55 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e75ff3bsm576041266b.1.2024.10.30.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:04:55 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: gutierrez.asier@huawei-partners.com, akpm@linux-foundation.org,
	david@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	willy@infradead.org, peterx@redhat.com, hannes@cmpxchg.org,
	hocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyJLFv8TgoTyo5SH@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyJGhKu1FL1ZfCcs@chrisdown.name>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJGhKu1FL1ZfCcs@chrisdown.name>

On Wed 30-10-24 14:45:24, Chris Down wrote:
> gutierrez.asier@huawei-partners.com writes:
> > New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
> > have completely the same format as global THP enabled/defrag.
> 
> cgroup controls exist because there are things we want to do for an entire
> class of processes (group OOM, resource control, etc). Enabling or disabling
> some specific setting is generally not one of them, hence why we got rid of
> things like per-cgroup vm.swappiness. We know that these controls do not
> compose well and have caused a lot of pain in the past. So my immediate
> reaction is a nack on the general concept, unless there's some absolutely
> compelling case here.
> 
> I talked a little at Kernel Recipes last year about moving away from sysctl
> and other global interfaces and making things more granular. Don't get me
> wrong, I think that is a good thing (although, of course, a very large
> undertaking) -- but it is a mistake to overload the amount of controls we
> expose as part of the cgroup interface.

Completely agreed!

-- 
Michal Hocko
SUSE Labs

