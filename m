Return-Path: <cgroups+bounces-1244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C2383E3A1
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DFD1C24193
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC92420C;
	Fri, 26 Jan 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2aqdI02e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC748249EC
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303207; cv=none; b=sJV06kuhg0ROOfU3d46F0fCnCMXwgOopltUFr+5dP51lOzDcpyy7JNjY3hFyQ3DOarVXkvmQjA5KUYKUj2D36TeYLVjm7MX+cJQwuOG4rV42VzDA9PS9kZCpriaI1LPI5C0eEJRPlHkFZYya77ZgXEw35mO3LFc4IIClAGFOkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303207; c=relaxed/simple;
	bh=DGuwcy7+t/oybW2DmRtk136XOg5k5hZpx3k/FLEeh1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDuwt4Sl6gzMwJDgK7nqvI96SF2Uhi/j1f+hLry9P/uzkxRu5QzlSOGLEn9qins4z+bc8qrFlKDgNxu5drHpZF3f8cz3CNhJ1lvShwzOIDXW3r8VjVYs20VOEsFY6u9BokRNr9VN7Cr4+1i+m3A/NFlvok0h7YTLfQBPXRsw944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2aqdI02e; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0d86d4659so567704a34.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706303203; x=1706908003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXLiZ/QkDFCOQ1THZJEDxzG3f4B+MGCbqeorNkMEFUA=;
        b=2aqdI02eCc3PAWaJMav8f9c/rFa8OVjTFDJqbPS/mqzDox6ndcHxA8J/LEXaO7bO1q
         aB1bSWDT9WTUmHhyfNXbCt9U9kIOqijHgj5ErOkhCOybPFTFyB4rPeM0LspqlqzfheUC
         A7jMv+l4orynVg9o8DE0MVg90DnS7NLlqNWst7zuiTzEDT3WtjLaJyE8NhKzeiDX7gYO
         Q/0GNkqj+y6LIfiCbd+sSIq9dRKLxjoMIgRixRGN+djGH+2b7ZQXnOmLjRSs8pfXlKB+
         9MEyM3xxaExOAf4EuUXqzr1g4TLGOKPEFJXArKLcgV2U9t6N9Qq5NgmyWYT5V8HA6FGp
         ZVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706303203; x=1706908003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXLiZ/QkDFCOQ1THZJEDxzG3f4B+MGCbqeorNkMEFUA=;
        b=VMnECwkPUJhMLB66YstSXziLKc2bwbczINXlnavur2LBoD6ai1vaRjWyNzD2fwu7Wa
         axc5MOQ7q89AdEjAiAQ5Ng+jVqXHn/nFQ9dUJzsWoCqW7RQ8PhX/c/HuXZsflM3aTidY
         EAeIdhMON18A773w/Krbg5fUhr31Afo9kCYQkSK0CMEnlIvpSAf/HrOONZj/LyDssmCy
         KaLMlrIKUvjvIuQOEU+3p8fgFzdFnnvkRYWQrJH5GwdFuch69dcr0sGaKfZM3iLVJYlO
         R1KqPlsaw4qU2w32UhNXHT4fSqs/rHqvOxfrztf5rPwmbn/whPWzJ9kVyvn4diw+gDeQ
         7QBg==
X-Gm-Message-State: AOJu0YxlJKurc8ZWz0k0y+LQuT5ZshuKdj7cuQeaFJwEByAFebDVUTVT
	TTbw0vaeZBciHGw5vaAulaMqrUErhrQxsc/CmGtvuPGGWcLWzkuDcl/Wx2uV++o=
X-Google-Smtp-Source: AGHT+IHR9d2RnaSnbK4TL5g+c7dwHZhhLVRgyKzjJnJpZcgI2qk0Hq9pBoMywVZyfybv5A2Pj+RdbA==
X-Received: by 2002:a9d:4d92:0:b0:6dc:776:2eb7 with SMTP id u18-20020a9d4d92000000b006dc07762eb7mr282095otk.60.1706303203640;
        Fri, 26 Jan 2024 13:06:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id nc6-20020a0562142dc600b00685ad9090basm830074qvb.97.2024.01.26.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:06:43 -0800 (PST)
Date: Fri, 26 Jan 2024 16:06:42 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Don't periodically flush stats when memcg is
 disabled
Message-ID: <20240126210642.GK1567330@cmpxchg.org>
References: <20240126203353.1163059-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126203353.1163059-1-tjmercier@google.com>

On Fri, Jan 26, 2024 at 08:33:52PM +0000, T.J. Mercier wrote:
> The root memcg is onlined even when memcg is disabled. When it's onlined
> a 2 second periodic stat flush is started, but no stat flushing is
> required when memcg is disabled because there can be no child memcgs.
> Most calls to flush memcg stats are avoided when memcg is disabled as a
> result of the mem_cgroup_disabled check [1] added in [2], but the
> periodic flushing started in mem_cgroup_css_online is not. Skip it.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memcontrol.c?h=v6.8-rc1#n753
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d7ef0a4686abe43cd76a141b340a348f45ecdf2
> 
> Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> Reported-by: Minchan Kim <minchan@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

With what Shakeel pointed out resolved:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

