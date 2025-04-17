Return-Path: <cgroups+bounces-7617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FBDA92088
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AD219E7B68
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D364253333;
	Thu, 17 Apr 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="QhOpWc30"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02492252909
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901911; cv=none; b=VzRxGByXfSr3VCGi8BV/EnuLWkrfj25eqgtXVunYQljUhWiscSJeoeXm/j4XnfsJSaR80htmf9xRZ8dE6Efxg4OmXE6+t1zJgoSOofwLT0FzCyAOAkj9eCTyme8jj+ofLvpGdjBGWj6U1uHPb9uffvAAVdsU8xUxvedP8nVUXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901911; c=relaxed/simple;
	bh=769yCdBlANwbmRIbTWde2f3Il2Ej+D8N39f2RDuMZf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abv2J6KcATIaz3m94Duzlw7gOSRo/gIEezA3lOHvmZwxMxpGORfituQMEaB73L2SNnzWLEicP5+fRq+i9L+2JNJhm+Y3StP+XxeWSRayKMFT3irBwoVQ1eilWPvnMDltKmZiGHK/mkIZbCiAvx4Tz1iyY+m34ihHKp0NQ8pOb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=QhOpWc30; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5aecec8f3so131583585a.1
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901908; x=1745506708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3gbCW+iQwhJd4DkAbGAG43g6uYzMnLXJAizDgyDC2w=;
        b=QhOpWc30txO2afWq9hNHPiiyFQTWO5MP9nXWwQM8qAZjnRO6BJwSknzy6MLlEcqCfU
         ntaKNO3HCuBzwVVfPLG3IY+LLnxo+DzJkNTccTAjKP9I5V12B1D0ZkH4ni0AQCaRfbw3
         xj/uhcVcIZWwRJ8jGH3L2+0+2tCONw0g3czIPH/s2wA/xZzoUunqUOl6m+oibUfApd0C
         a5ydjgpjBJYvmpBlEavn2Qc3F51MDM0dPru1PbhdR1fbPXhNNCtezFe1GGt+cvsKuREX
         HKBbS9m/Zzl7mYL91tJM45faIWB4N8ModB1ekT0fhqcjmVSnRaQxAsmQJMuRtfFJseKN
         ISuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901908; x=1745506708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3gbCW+iQwhJd4DkAbGAG43g6uYzMnLXJAizDgyDC2w=;
        b=gEXR7SPYqYW93DTx6Y73Q8mfJ0FIsPNM4JP/0z+pqAuTbO1zAWg87g17T04gvZyLM2
         HBypmSml4pZ+moLVgCSqeQBpR8fUoxQHzUisdMIpoFezNihl/CL7OlD/v91bbPOiCC5D
         JGf/Xifbo0lYWbT6yMVFxZT/zFEGe3sjRE5vGuvUgtcjQAqEYaha2TCCLl8MIRCN67IT
         /jHTlxX9NJdei9WTIl45R0kYHN92bZiZGqjYxcQ/FessCy6NA+JShKctgqHFwjHhmhNE
         W2kdmCqR9+vjuQqQHWxcGHIEzv8B3aNJ3mWakrdWIvtxnrQSsWApi0ban4YpLxJL6rcD
         E4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU9D5e3cRx0c5jda0YcRa3QyzTIZBT5Wb+hLzoceSW2a8rgjBGpJMeemQiynPf+Oq+aeh7aoTbv@vger.kernel.org
X-Gm-Message-State: AOJu0YxmaFWTyrsIZw/j8Ueu44O8/VzpMCD3e/nbPcKhoCfG6iOVIpxC
	oa+N1gGTiMgpE+4iWw/z3imuOUAlM3HZa0Clpn2NZiJG4hDF26/s/mazWGFOfRzG8+/x5UnWhu5
	i
X-Gm-Gg: ASbGncu08JS6K8BrgGt5KHP0b2vyDmOJEsDdnuBA5JaqFJgbgaufPTurw7YXGOpUEGg
	RL+OG4uKpBFBPHq9rlKmZB4BKlZf8KTY822N1BTCf/uHUj3wNjccqQF0ip6ahegG942EbW/A7aL
	FgMVDeoLpPA12ZhIpGYKLykep1cqlwNiOV3M0s52HyUCCl+OJdgzNiz2GHQ0YGx2DpLwo+mO5qV
	NP94ab+Yn9Q6EGZkNbzErYzZGd0bn9BaXOQvWs9dkzx4UN/6ZAmGSZZw2+9GHNx0AAJt0ZVJRdN
	gXg7MDjlIsaaBJw3HPV+l+4E+VyF2ivBdlkNbyM=
X-Google-Smtp-Source: AGHT+IG8pal8ArDJIAxk4zvmDxxTaWHTgc3rlYOQmxwiOrJrTtp4R4yKIBkfKdWD1Cu1lEd1pdGILQ==
X-Received: by 2002:a05:620a:472c:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7c918fcecfcmr833341285a.4.1744901907842;
        Thu, 17 Apr 2025 07:58:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a6ea26sm824585a.7.2025.04.17.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:58:27 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:58:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 06/28] mm: thp: introduce folio_split_queue_lock and
 its variants
Message-ID: <20250417145826.GI780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-7-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-7-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:10AM +0800, Muchun Song wrote:
> In future memcg removal, the binding between a folio and a memcg may change,
> making the split lock within the memcg unstable when held.
> 
> A new approach is required to reparent the split queue to its parent. This
> patch starts introducing a unified way to acquire the split lock for future
> work.
> 
> It's a code-only refactoring with no functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

