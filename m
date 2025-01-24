Return-Path: <cgroups+bounces-6273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE49A1B9D4
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8953A2773
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F015C158;
	Fri, 24 Jan 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zcATQE1D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30F157485
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734361; cv=none; b=m6tWJwu9lyxQs6jgj0Oq+Za/M5Zz7W+oY2hB5MxzFA+lEFRJkbtmNJhT2H1YLH7DOHsA+ydpA6XGYO9Bzjcs+z9j1El1mKF5GJcFWYamj+rB2wBu3ZC4H7BFB/g32LUigMYEirJaBJdYEmH7B7Qlroql+yG0m6cCGL3EVM9DjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734361; c=relaxed/simple;
	bh=6P4I/lgwjAC6gvYc44nBStz7raI7WB7D+vk8Kt8bSaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDxtutrBxKIbBVhBu/GegKTpmVhzvYd2q/AjJcFeJW1aqn7zDwsDFRDuNL4YjyWODqFgWKa7DHiwHTrJrhXSTTXzLOXK0f69tM+LPJGrWyABtI1RQ0bNv8p+Q53WVMyBsTlWIlOcyocy8s9g5i+pOWW6nm9zCw330tbDmNTGkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zcATQE1D; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8ece4937fso19400926d6.2
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737734358; x=1738339158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvtxMicx5gjN2JYPX7vs5+nnPf5Ib5DrIqnu6h+drcE=;
        b=zcATQE1DW21SxsMnBS/8nPJPkN91xHgpEu8gvjklkL2rcK/E8V0mDToWLQgHm6qLBc
         4opa/3Xazd7CFf0D8ZUyCIeiKZ+HhfAhjNWkKczN1Cjo7JyqMdXwRfG2rQEPOyVDwER0
         WoZ3t7RSUM0L/7yziAgetHatHykb5NKyG4nlQSn1YsgQEvb8RFVQ+hQ/l5Vp150jUpDY
         Haur1kZ6wmd75H2WiwqlAU7X77L0EPe9VCICzUyOb3H/r3MIMILItvJC7LqBDHh6dkih
         3mnhBfW3BpgbRaP5h0DEKoT/JhlWm2S2owwtIdxZ7r6BfUdCgNFGT7u9Wi3CyCDC6AE0
         gJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734358; x=1738339158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvtxMicx5gjN2JYPX7vs5+nnPf5Ib5DrIqnu6h+drcE=;
        b=req8kC3VHSic0t0R2F+c9FDD3AeM/CQYMpQy8Egh2fLqskjBlTGJpWiwD8jriV7Jq2
         k6GfgY4R7MTZuY50gAVW3LQzHm2xGlEzNwS0HXeCBQ+VpbvVU7YO2d5y0Rwcvt5ol5yi
         DDenQ/b2bPz8yqFOiSStV2Fhw4I37AHh0r2Fuh1EFX3z3CWmTSzhhKEYbF2ll9EiXETi
         13AgowVvvCGTPvabHO0fLsL0eTQd0o/L0NQNGlg2CxdYO9eMMwl+5KEunrMxFJO9Y689
         +iIi52Ph2WLaHT00vXNHRYS4QcUXu1rPyCIxr3vDBlWeySPwfzjUfBBZaZDM0HY9mtDD
         WADw==
X-Forwarded-Encrypted: i=1; AJvYcCWXtJyBK6QHYGGU41HHl8YlpyUiZq9HbncdKUFm/aKJHQeyARUKagBu7bzWFe7jI4diCRs6xfQU@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOjnsd26c/gmCNrACJ63InxfrWqEYQocI1N/EwwaK3oBde7RH
	cBJVfIeM0u11VCxJ3OSpKldxLFPQIWwMZqjmMazuH3yo9KRD26D5h0gRjKf9tRU=
X-Gm-Gg: ASbGncuhAKIYEbkC1r0uS/Ong6dTJgcz1/6eQxYT20PKsapMl+c53OLIZaDR+ubBLhZ
	XU//YWK41Wg5Qer7cpmzyA+g3hOYLVNhh9mQmlTBBOiQZcXKSx3MhqbxJAn5vCXXDxuWbbhLc6p
	1j6dFgmflBcZMhbbAriALF2T7+LtyF3GTen9Ljl6IkAfTHt0h5FSzq9e7ahEzM91w+fa0gd+1vq
	ENsj/E1aPm2flRXwSmy6KhnzWodSReYVqCzyQK9us54tCuWiVMwlTvTD3HSgwv9bOvCYEqwvAsU
	GhU=
X-Google-Smtp-Source: AGHT+IGEQ+V00ad4O0gxW0aBqYJrI/4yv7/W+3SmB2pTE0ctGdvjABs3b/VwSqMo8hM0XOHOuwQtPA==
X-Received: by 2002:a05:6214:54c9:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6e1b21ef52fmr520246016d6.27.1737734358487;
        Fri, 24 Jan 2025 07:59:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e205ac48dcsm9709696d6.123.2025.01.24.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:59:17 -0800 (PST)
Date: Fri, 24 Jan 2025 10:59:16 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v4 next 4/4] memcg: add CONFIG_MEMCG_V1 for 'local'
 functions
Message-ID: <20250124155916.GB1222@cmpxchg.org>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
 <20250124073514.2375622-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124073514.2375622-5-chenridong@huaweicloud.com>

On Fri, Jan 24, 2025 at 07:35:14AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Add CONFIG_MEMCG_V1 for the 'local' functions, which are only used in
> memcg v1, so that they won't be built for v2.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

