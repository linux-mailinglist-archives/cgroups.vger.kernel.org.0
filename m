Return-Path: <cgroups+bounces-6232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E350DA15640
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 19:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA43A9448
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1751A256B;
	Fri, 17 Jan 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="1n9pdLfJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9D1A23AB
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136966; cv=none; b=QVis1mQgWk6mVR4eR5lZaw2Irz9ZFA7vDXWc+Vh5tNAZb9PHTOdzo2xGJHQFivfKXChBxsDXxYiSKHN9V1t/FbA6HIOsTKjA4kp2Walo0riu59qkrzzEa0Y6GSrYp0gOFFiHWa5+bqtUMTxAIZvOEEkwvaGCig0FiO92zJFhSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136966; c=relaxed/simple;
	bh=mcyQx8NfZnBeQRnwiQgg96RgN3d7RRvJHf6ideki/9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp7a6GrOs9z5D/q8xHI6WXWeAZPK88LP4Juw9ERFA0jiH96QN1Us2+0WaMKg7RlX3DrmlvS2SsKfmzywlpHqqn6/wggP7xxT7NHmKph4qi01J1Y76NX7bjSUYjqX7jV6ccXO9E7dO+Px2qptFDozDqLI0qJtGuEcIsI7nwxfSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=1n9pdLfJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d89a727a19so33526796d6.0
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737136963; x=1737741763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O7ShKX/oNrz6EaI/j7ptay4TtkYHf7Bfw1E66FPwCII=;
        b=1n9pdLfJsJMNkwWQ4llka/4pRVfkM/aB+4Mdu/vmU5I07h9FGt7KyvSb7J4q+Y53Wz
         voDxH0EkWYv4MrmXADpv7F714HLBQPwSFyc67q2LNr8ouj1Df1GpcPUo77qQ8rpXR3M+
         9tDmBNT2ZdqvzjgQpVKM5g8mvAPdQbVpScylITriX1XOVV2N5+r3DSm8s8aJjYyrBvU7
         j4GdY9dU4U99tq4/4S1G6sTCj5DqHLRLDSUseHbh3lc5xzeQHKKU/FDshnPYKGo4zdYl
         WA8W2RTuGTRUPMHSHNeUbinRrMDHMV9GQ5vn15JqmfLRj2LTvSqQ9t32k9FJCj/5AfkQ
         vFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136963; x=1737741763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ShKX/oNrz6EaI/j7ptay4TtkYHf7Bfw1E66FPwCII=;
        b=URkM+rxi1VLR/96Vzl7MJoplcKHssbT0GXfx1V+fbCvRkVrvSesTkjqsvOdOhbcQSs
         vPTCyXL0dgeC1+1xUbVvJUCfT6AjDIjXNIIPqo/Rdc/i1ZQ4UV7yxvI11CmAHgZ4eKgy
         IS1jESafaDck3NYcOFmpKRH5jFyECOQvT5wf98A0vVNTJLPmOSlhT8RPSnm54kbcnTeK
         0Uel1XpcS30b4aPdRie9TGXWPqMtq98moW7XQFL25sGtxAJmUoZMmlFzxn/rO7yLSAlQ
         GVMcZHn0E5XAPjTH7s/1XwprSDjwsYZVX2faiptF1G15HNsLiH5ww16NIK8aucO8fm/k
         AYfw==
X-Forwarded-Encrypted: i=1; AJvYcCU95j5MmcQPgMql6AOQu5134xtiOYUmZBLH9FoAxqqIx89i6QEkcgcY+vstikD8b3GSeUaZ+9sW@vger.kernel.org
X-Gm-Message-State: AOJu0YxaG1COTA8TrvS5/iKdZokzNnF0tdO3jTxM1lAa+HoOWAnLwfuD
	X+3lmnFpn1j9naj/joCTdP8wt4zc5gSejRi/h8SIBOTkTFMAPMMrs47vai92lF8=
X-Gm-Gg: ASbGncu9HZgvlDuwc1pr0QWCsOwsN/jsSTDdNfroiUPM2OK9Asz89j2wH4MkRnR5j3D
	A3fx160//pO4ZNqG94cG7wArwrNHJ032DOOSk6rRIuhRc0XuYP73t7N6EJYOq2D8xOfmxN7oN+6
	LFmJvrL1dld6vdjoU3D7c0NgjpwMhn4gLKyqqCF7FdXaK9iLpOlbz1Swa9iVQXXkxa6jV4Gpapj
	7KwDB/jiAGBhYANCu9NH24tCb0jd6rRYcPsH0y63wEZ50Gl7PmF7bM=
X-Google-Smtp-Source: AGHT+IGf2vrLmRzzMLXc88X7L+DzqQBJwkKLUbC45RspAH45M5Hbe9TUzOJLaI18Uxnh15lp7SeTww==
X-Received: by 2002:a05:6214:1c43:b0:6d9:87d:66f4 with SMTP id 6a1803df08f44-6e192b96debmr179722456d6.8.1737136963324;
        Fri, 17 Jan 2025 10:02:43 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e1afc11035sm13640616d6.42.2025.01.17.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 10:02:42 -0800 (PST)
Date: Fri, 17 Jan 2025 13:02:38 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 4/5] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
Message-ID: <20250117180238.GI182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com>
 <20250117165615.GF182896@cmpxchg.org>
 <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>

On Fri, Jan 17, 2025 at 09:01:59AM -0800, Yosry Ahmed wrote:
> On Fri, Jan 17, 2025 at 8:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
> > > From: Chen Ridong <chenridong@huawei.com>
> > >
> > > The only difference between 'lruvec_page_state' and
> > > 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> > > respectively. Factor out an inner functions to make the code more concise.
> > > Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> > >
> > > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >
> > bool parameters make for poor readability at the callsites :(
> >
> > With the next patch moving most of the duplication to memcontrol-v1.c,
> > I think it's probably not worth refactoring this.
> 
> Arguably the duplication would now be across two different files,
> making it more difficult to notice and keep the implementations in
> sync.

Dependencies between the files is a bigger pain. E.g. try_charge()
being defined in memcontrol-v1.h makes memcontrol.c more difficult to
work with. That shared state also immediately bitrotted when charge
moving was removed and the last cgroup1 caller disappeared.

The whole point of the cgroup1 split was to simplify cgroup2 code. The
tiny amount of duplication in this case doesn't warrant further
entanglement between the codebases.

