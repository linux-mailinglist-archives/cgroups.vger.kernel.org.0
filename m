Return-Path: <cgroups+bounces-7379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B84A7D0B4
	for <lists+cgroups@lfdr.de>; Sun,  6 Apr 2025 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160203ACB77
	for <lists+cgroups@lfdr.de>; Sun,  6 Apr 2025 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C311B3934;
	Sun,  6 Apr 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFNDMnRu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031E195811
	for <cgroups@vger.kernel.org>; Sun,  6 Apr 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743975254; cv=none; b=GB/a/decKl+pbyJJmbmazsCgSTjkcLp6oWfTu03GlsB09zxssFJUlz5VGXnMmF5DD216qYGcQsjFyEAQtNsWP/l1zGkB3vx0Vi7d8210N1NIoBVxtmcQtoEzGmogF/09U5pmvwjg1cxOAHKmz39H7FkGd4JGwdLwgXfXUX13ELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743975254; c=relaxed/simple;
	bh=1thCHGzusRG1ZlrUII7P1iJSUsOlzC1ZFkjlxRYfWZA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fb0BpR2OQwiGhW5+proxl4QtgFb1ZML1wMt3j/iIkFkZdDYzJZc5/B0mvsRWpI6xodLesF4KnTX3JUsETor7BNSnCxlJZIm4n9FRrgs18C0IkaLu2kMRv3LCZYO/A8nohaOi8pdMOUAu3d8nXe1VhLrn6FGa2WCfTEPSmg+eYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFNDMnRu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso224565ad.1
        for <cgroups@vger.kernel.org>; Sun, 06 Apr 2025 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743975252; x=1744580052; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBPMncQ6TC7hw2oKsOjfoaHvrckjy1WxXt515TcLyfI=;
        b=MFNDMnRuyueVh6iVaVV4O3hMRKCYZWOjD/jUDThbaeOhTcEAK438Zbk/QUhGpFNSnG
         c7fryo3DSaA70vmFJZu+kF6PcwGST6wduQItZdgYqmim4qukZAJmeKXy1AFbuWplBbXS
         fBBONgcbBjq/3i0KMV09uGX2DGnOlkWCMcKQv8w6JYwfIQBGAlyqQURVgjD46Pt4+uL6
         opk1CBxusVxNBRiepx9p/NOXo6wrVoFmR9Ea9OD6/0bkK/JZgl3KoDQfUoZBNAr6gjpA
         Tq958V7a6R6sfbTCN+wTHBHhPegXbeEGcPc4f2r2J1ZE7zrt4mrM6BfHX8bBK38npmks
         atoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743975252; x=1744580052;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBPMncQ6TC7hw2oKsOjfoaHvrckjy1WxXt515TcLyfI=;
        b=p6LpvNhSAAx77XIfiAljtzoLfaOS3dMLeTYA4rELs5wIPcE5s/xm2vqTZjwuyfFHcx
         IlNX3bpXc/O63SFIxtLZ8+hNtLQitnsDqyOlYgQBi7GKn7L+gNGYFdyxEymcJOoHY161
         2+r43bnlb4PhoUBX+cexzXZlVZ4A0qhoL0aLBzA8fW3MbPX8GQB/V95Cdkf2fDuOiJ5K
         tDAUxZHvbbhFUrvKsHTuOJ1yOEjchxfVdqqKkl57y/vGluGmlLpX38/TPnzDtSjWkB6h
         EQKjhYeandIoxvhaFxCjH2BuwYqYIHKRKGAt/ec2wl0REIR60oNpVgz09RW+G/KSVGC4
         M1vA==
X-Forwarded-Encrypted: i=1; AJvYcCWDd4igOhD6G+KMc5GaqjcaJP6+8aAXM43cRITtPM3MpUxAkU7X8h7bDqq317mWP4RK+cgsImax@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFTyjr8pP3E3Xo2qjIqlhScb9YlIihpsupxTST69KlzC/AVl6
	wmNsv28qODQR6/i/8+kPKJkKsRyu6FW8QomSBS6MKWIHejiaMISM9G6dlAdvbA==
X-Gm-Gg: ASbGncsbByYYE5VLmslqld14R3q0QLp6Hs1TG8jsOdNHFLhgd0IBi1QVKUwdtonrWLE
	ljYgx4U1kgdKZq5eW0SDPRmeHhnrTE0ZtF+1s8eL0Sbmi+LgKKjc0P9NuvRHAQ1yqo0w0be5d3K
	iYntosSg8hHHP3SDB32wx8Ws9nTyKeAeyMxvYxJVfFLGrH8DTbnSvsvUmw5dS3h1l6ddIPRMtCS
	j31lAcx07JPYstDwysa75IfYYgjRKdk+T6AoJWsnrKa4hiJY63v+557SLwha49qM3nvIMcfNQUO
	Ew9wK3GrWVDGjH4jsHD7r35NdQmmjnphULFGlCzA93B4LEXKrtxAIU+DKw2y9XBnjjzbvBqKp1t
	EsQP/ps9KVAcw1pQTJaQ9alcK1rTC5LdMjETn
X-Google-Smtp-Source: AGHT+IHiRINMzxnjTrrhfoZBhhxSAkmIUO6KvhjzqPNAjX/wOWw4Id8jKa17QVFoK7hXxJREv7ldBA==
X-Received: by 2002:a17:902:d591:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-22a95daaff5mr3142305ad.0.1743975251735;
        Sun, 06 Apr 2025 14:34:11 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:2005:ca9c:736:e1f6] ([2a00:79e0:2eb0:8:2005:ca9c:736:e1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c27b3sm68020535ad.97.2025.04.06.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 14:34:10 -0700 (PDT)
Date: Sun, 6 Apr 2025 14:34:09 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    cgroups mailinglist <cgroups@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memcg, oom: do not bypass oom killer for dying tasks
In-Reply-To: <20250402090117.130245-1-mhocko@kernel.org>
Message-ID: <ad2ce9e6-1651-8170-f944-1ba4ce4c14c9@google.com>
References: <20250402090117.130245-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Apr 2025, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer") has added
> a bypass of the oom killer path for dying threads because a very
> specific workload (described in the changelog) could hit "no killable
> tasks" path. This itself is not fatal condition but it could be annoying
> if this was a common case.
> 
> On the other hand the bypass has some issues on its own. Without
> triggering oom killer we won't be able to trigger async oom reclaim
> (oom_reaper) which can operate on killed tasks as well as long as they
> still have their mm available. This could be the case during futex
> cleanup when the memory as pointed out by Johannes in [1]. The said case
> is still not fully understood but let's drop this bypass that was mostly
> driven by an artificial workload and allow dying tasks to go into oom
> path. This will make the code easier to reason about and also help
> corner cases where oom_reaper could help to release memory.
> 
> [1] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/T/#u
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>

