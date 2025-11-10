Return-Path: <cgroups+bounces-11719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7AC45B5F
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215C7188C1D0
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B5302169;
	Mon, 10 Nov 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Af66f07N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C302143
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767980; cv=none; b=JSkYOoh/BCYPhmfxfW1z6GPAQ7WeDM0G8isvaf/N/ODyIdjmRgIjbyFCuHuINXlyt9/+CmfuX0B6DvJlwum6yxTFC88CnRFIlKSiaUYemixieBjU5fz0HqQ9sipzQZZcl9/bAbPHbJ7gnsVvhyDQiI2KZOvrWTtBhsI4EB108Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767980; c=relaxed/simple;
	bh=NMx+80RAtRR69xjJFiFNTuk6xFPiPToOmJjCwv8y9D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTOXIjYYxmTweSSaBVEQI3ioxkW882bJ7j08svtLbU/CGD34q/uFxvLoFnSNbF/CkLOFABZKer9KczHGQGSEjW64uhpoNLsA3NijYcFRX6zlkrvHYNcb1VgTmW/M5lES6MHiWDDiUraqOSfTzscuEta4jAeCaQMT79aS1cxwcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Af66f07N; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so2410566a12.0
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767977; x=1763372777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=Af66f07NTIFdPiwJPK3OpAEebehX3C63WUeCT8aMrKjlXeyPR95kfKf4evVzlI0q85
         NVEnXFpJnNl9t6U5VnFZKTAkjE0Ay7RdhsT08RRh+nt4Cz0UcKHD+JnmonIcFrqI2QzS
         dyTz3j7GQ8FlfOsRtAApdXSdgh8Y6MACXWEN0dWSiiQsl0saBfbb8lzemhx2YWZ2v5ak
         MlHIj4QjckjjFjqcbv87nlc7WXduJqj3BhM3uKCpHpLDN1yhBlbqCuuc4Cd8RXf3EcSs
         Cio697HK2urzJXhXJUK54/fesnsGcKioiAueNtCnbOrAfa51hfXCqe//ZmIT5P69BVHv
         2peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767977; x=1763372777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=GnXlIzm9T3uopf6ZeuVpGU7/a7i4ja0WShIjKQzC2zd+BUt3gQM1X0dUm26F3Ev4N5
         RCNPjaUM1VxgBcyQ9B2rEDrQ6MsWjieoLMAoDhW9UmRM4+KS5+N2pLCuP4H3cXjvX34p
         2qkygMT8Pbemf4P9L4ECrzZvhGn39UIn9rnr/bmult+SYK/oYN9GIAMpgqkrJKeCBpIl
         OhzNPV8YKGbAWP9TtMrQ55t+XLly1ynRQ5JNCDu94S8pl9nEZPPJGpAmoKM5lQZtpRAW
         KkBMPqzEMpdNzalSJbVEBcEu+fX0clAOJdph6EwMQlpz8rueNQkRATwdGvdByRwly3JO
         IwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjK9Gxy64f/7/btPLMEzLXzKN46GcfSM+n/P+QfOje2drJtGdo1ZOZsaDKY4KKY/PMNUU4oueD@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUMrhl41cgE9KuvTitauNStblJ02Q6cENOfOTcwmM7P0SQ32P
	kkiadEjg28xhHTP7HGaadDI5w6bv8wLLw45wwDJ7aHYFpPz1ZoiIb7qtMujnKIANzPI=
X-Gm-Gg: ASbGncsbFqzmXpH866wpr++SMqq5cl6rWbnwBF+r9kmvbfNRKmZVIHlmvm6L1KjzGB8
	4CAPYN1epIbmIh1h0pcbn3U7O4V+r0+jVyg+hkxrsX8YNFJl5yZT8BYFBi7iwTne2r58rQuCQGU
	+wOc9OjIs8/b1dFKhXXKZswDEkdDGFBiOxJMcLzVjSHztHrVE7y8rYwqYLK5BI3aitApu1ZBAwP
	lg46r5xPF3YvAgrtQyRLj/1lhgxzafJVGaDaRNDJjFsExukLdTAv2WZk93rnZF0EcASNyPMwJgh
	2a80rS+rs/qJwnyqBbUb6lns10yc74IWYjx3GkcZOxby0xxKBD7K6+QSQfjAMkT8iMLrcNpYajL
	mG69AmS/QiR2VujN3zZFdau6gf3eQOFJTLd36N61fC3z4pC9PEbfagCEmewbov2KYX5cAZ0VLzS
	Aefh/86HKpCzC8Ig==
X-Google-Smtp-Source: AGHT+IGmZmcainr9lTW69kXNHob9h7gFoRrMJ4orD0WaJEzcosAR93nxuffTYpmtgx+UXuB6Sga00g==
X-Received: by 2002:a05:6402:1d55:b0:640:ceef:7e4d with SMTP id 4fb4d7f45d1cf-6415e81207dmr6218186a12.32.1762767977000;
        Mon, 10 Nov 2025 01:46:17 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm3896343a12.8.2025.11.10.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:46:16 -0800 (PST)
Date: Mon, 10 Nov 2025 10:46:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
Message-ID: <aRG0ZyL93jWm4TAa@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-3-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> can be declared and handled in the system at once, so if the function
> is called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.

Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
sense to take the oom_lock based on the oc->memcg so that this is
completely transparent to specific oom bpf handlers?
-- 
Michal Hocko
SUSE Labs

