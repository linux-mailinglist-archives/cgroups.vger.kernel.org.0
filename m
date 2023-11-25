Return-Path: <cgroups+bounces-556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3D7F8CDA
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 18:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6565C2815DD
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC02D02B;
	Sat, 25 Nov 2023 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sb4za/p9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93AD5
	for <cgroups@vger.kernel.org>; Sat, 25 Nov 2023 09:38:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb6271b225so39753037b3.1
        for <cgroups@vger.kernel.org>; Sat, 25 Nov 2023 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700933884; x=1701538684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OjN2yjM4lGF+xoZzPeOmLggYv6X6PaCmv884vExzhQ=;
        b=Sb4za/p9PvTD0oIEk6DlS068u8izzt+Sbq6UOPQjqx4DXCVv3RzHfPPtGJvLBf9rEY
         gx3iWBUNixvRIlAXWhsJqAEWH/lDvJto9kE+a6x9TJTskmY5EDfzR2IFfD3egqbZ8WWY
         9vZKRKCQWjUxR2eOC4eKFtWqyYFL6QcpZwKE8lVHFIuhFyboHHyGXplhidwIClLPfVqB
         DVNX4I/6qtjEZsFqaCERd12IM72HcJxqdb05CIp1TkG5vxAGsXeQT/XWRRrKRAWBpddK
         hXY29g905eyC4DjR98qVwDL/n+f4BRWMcS840qldcg6y0MGMW2ZlBTuRJLUf/X6SIiwT
         Gbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933884; x=1701538684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OjN2yjM4lGF+xoZzPeOmLggYv6X6PaCmv884vExzhQ=;
        b=cCGoBYWma1Rz5S0/jLqsVPaSDy2xi5VI+p5fsFb/guM9WMeO5pr8DwmEbwT0W/z6x7
         fdoG7L1/Zbsj03o61E+PxlnbuFRsfKUj9WNCt7nQI2hOjDjSI9pBHyp7CIE3ONo+GVxQ
         tzgWkQvuQjw6fFkW/FQQ1D8AAQtSKe3LdnNcKUrF6bW6GGRkAP2sATPQcxPMa+rrJGer
         cnoVRl45ArS7KIvp5y72SLLoDsjBMLOekVhha2Ed0rGiauvO1JSGff2otsTjuZ8RhYSQ
         xuUznzGgZve4MYY/qlKh3ms2JDWx/vraYdHnouyChgmS2nXNf0nnDSZkrzR6mAYSubT5
         eb3w==
X-Gm-Message-State: AOJu0YxfOu/Awenb6nX8yB6PzfNWy0Dt6HtqHsfyR7jWE4QonJLZsyUV
	L/xuYa0JWzLq8fLsnJXHoJNIt6GNDv352A==
X-Google-Smtp-Source: AGHT+IHnGysxB/944b9w0n+byMEk08BlMdz921PvjzprbIkgHG0uwA4pdEh20uVwBEuI1Q+ppKReG75nHOmEVQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:3d44:0:b0:da0:567d:f819 with SMTP id
 k65-20020a253d44000000b00da0567df819mr220022yba.10.1700933884073; Sat, 25 Nov
 2023 09:38:04 -0800 (PST)
Date: Sat, 25 Nov 2023 17:38:02 +0000
In-Reply-To: <20231125080137.2fhmi4374yxqjyix@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com> <20231125063616.dex3kh3ea43ceyu3@google.com>
 <20231125080137.2fhmi4374yxqjyix@CAB-WSD-L081021>
Message-ID: <20231125173802.pfhalf27kxk3wavy@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru, 
	rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Nov 25, 2023 at 11:01:37AM +0300, Dmitry Rokosov wrote:
[...]
> > > +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> > > +						   sc->gfp_mask,
> > > +						   memcg);
> > > +
> > 
> > If you place the start of the trace here, you may have only the begin
> > trace for memcgs whose usage are below their min or low limits. Is that
> > fine? Otherwise you can put it just before shrink_lruvec() call.
> > 
> 
> From my point of view, it's fine. For situations like the one you
> described, when we only see the begin() tracepoint raised without the
> end(), we understand that reclaim requests are being made but cannot be
> satisfied due to certain conditions within memcg (such as limits).
> 
> There may be some spam tracepoints in the trace pipe, which is a disadvantage
> of this approach.
> 
> How important do you think it is to understand such situations? Or do
> you suggest moving the begin() tracepoint after the memcg limits checks
> and don't care about it?
> 

I was mainly wondering if that is intentional. It seems like you as
first user of this trace has a need to know that a reclaim for a given
memcg was triggered but due to min/low limits no reclaim was done. This
is a totally reasonable use-case.

