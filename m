Return-Path: <cgroups+bounces-6257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE3A1B08A
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2079B3AA361
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF01DA63D;
	Fri, 24 Jan 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xyRS/gwX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AC1D88C1
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701600; cv=none; b=r1Pb53EXfRnasRqfi5LsHW1EB7yFe9lfc5uvDLQMtiTNWphqp9Din/ish+m+v/oI4f8tlPuEY6zN9SaINfiWwjU+vPIr2qAWBv4jZf4Mo6VTQluQZocnTg1R3TRKMUQo+gXBy+a+6zIYc4Sl64nf1SxrwWM+an18kz1Atlt/zYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701600; c=relaxed/simple;
	bh=SquPxaxN2LxzNqBYW9KvR5LRgVPLdyWaJrfRGxK7Uu8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CRNUIOMBaI5r9e2iNnoh64ERIOsl3d6pzpk//+/0F8xZJLVgzA1MwgGkVaGd9PsRahb9MOLG2eHOF7DkDrVZS7yG18jfz7YwZKrMQGNgu2f7/CGjM9zlkRA2c2N98AtbiclonYKQDycxtrFXdLcHNZ34/guJl5TJi4h9dx/TIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xyRS/gwX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-721d213e2aeso421882a34.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 22:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737701596; x=1738306396; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDu0gStk+UNY++uqdvEB6rkJOYse4rTEWttgGcD9Cno=;
        b=xyRS/gwXAG4vrHj95YyKrCwQuHPJ0SYmiFMWDK9edI1heSAeMTITzH1fGELz2hutcW
         /1LN9sclqGxnyL4IuDdHazLQtdF3iuUV+UhVlPE16Iu8dgb/gf3Ej1BTPTdxLWI/wTJE
         +62NWosO/G7Z7/rTbHdNCgW6K29eXnzcYij6UqPzPYWbxb54nOSax2d6Z35nbmROBNtU
         wyEEqKZFqK36/DybyIULh6mvXw2AyMAtGjt7BI3yNwPPREJzcFW8MdR+g6SxbfK8afL7
         q3keiBhX5RUEvMVbXGGo5phZR1xN4B8fNhxe54P7AgycwhiJY9DBEqxv7mqzRb0CG0DG
         NgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737701596; x=1738306396;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDu0gStk+UNY++uqdvEB6rkJOYse4rTEWttgGcD9Cno=;
        b=ckx/LUfm2yjqhAjwsy6ThCRjF1nLxsVGnOXiBtQeUnmHRSlI7ngtsvDjtqjwSFCQg4
         jB/+rTi9KhGPtmEig2bkrq6A8CwdFFsAJHyfAhlpaO/paG3+LqlhNxEeRbXN9RiBZA6L
         W9bQCjuqynakCPgk3SmMDpxbF3cGRNgXzgEXsilu2y8XiF1yL7bgQFTTzdNEpiWRDc75
         bqj+B6WsKE/kDOLpuOow5kMbMJjM+ZNoBDpHLxNDGVoMQfmZhd7gNCLws5oGjCLZcuN5
         fBV0SOtsUB4jLHgs+6dV5FBk+4XBWIX+XTiOw8iapB22MBOi+LuyNLmYHjAKmAfyXFrI
         19Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUUuQFtisJQ5omqvJTuUBbRPSAAynNUNtroAx/BJ9d0toRFJ58Rvf+9+aa5zz8RD7UTzrKoOPay@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxzeyK2GhWMdDO29TQHfYA6aSwDf2XjL9vdiycQVtQUpt85V6
	OnlS0QW5sgL431rHpvjOsjS0FgdZdRsvfp+faKpecn9jlJ/1AXtuaDXZ5ZtB7FsjS4Q9mH9LIyp
	aGg==
X-Gm-Gg: ASbGncubgHE7yFYMTp/LvEG01VVLBlKm4YYpwbhexYJMn1CL6+DiwyJjUnM+jF75W99
	4N89zyXFdkiQaVNsrUyLLEnxqBNBsPpLlGEJa686kGWYCdDlt9CAfDXktbtizRyXDyeQR/xMsZL
	752eN+9BF3PcRSseM3kbwQSwENW9GpZEvmrXaKQrGazN3lHyuCMDnuiKwrL6d/Her7om9XuugnB
	hW4TMFx9bLXvHunfRjRT0qT9iXilQaPxMPygkZpOyDuaIpb5BQHc6Bmk0K6bRJyzuEHJ+okcDak
	TLBemYekHiwgfCIvxrNYw7hlpMbhz2TTpoXVhfX3vYfRS4AvPFtO3/maES+Mjchg
X-Google-Smtp-Source: AGHT+IHAVDCUsF/BfZaOV9tq6XtbZ0z0JpadpK/l9o7VaS3dn9pmnpZqyXMEM6eyWzf78l/g0LwiQw==
X-Received: by 2002:a05:6830:6404:b0:71e:1fbe:db2a with SMTP id 46e09a7af769-7249da712e3mr19318325a34.12.1737701596499;
        Thu, 23 Jan 2025 22:53:16 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecdbc95fsm319107a34.18.2025.01.23.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:53:15 -0800 (PST)
Date: Thu, 23 Jan 2025 22:53:04 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>
Message-ID: <a90b33c3-7ea3-5375-3fcd-c97cc13c9964@google.com>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jan 2025, Johannes Weiner wrote:

> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I'm not really looking at this, but want to chime in that I found the
memcg1 swap stuff in mm/memcontrol.c, not in mm/memcontrol-v1.c, very
misleading when I was doing the folio_unqueue_deferred_split() business:
so, without looking into the details of it, strongly approve of the
direction you're taking here - thank you.

But thought you could go even further, given that
static inline bool do_memsw_account(void)
{
	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
}

I thought that amounted to do_memsw_account iff memcg_v1;
but I never did grasp cgroup_subsys_on_dfl very well,
so ignore me if I'm making no sense to you.

Hugh

