Return-Path: <cgroups+bounces-10326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4DB8F782
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4347F3BA1E6
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930342ED16C;
	Mon, 22 Sep 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQfvSJs/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996F522F
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529259; cv=none; b=Idz0Jc77W8UISv6wr0DWwzaHoYvUpvNuM7xgvmIOe0h5GtETgEgr9DMw/6b87fWxUIKEGLSC5TAh516HoVtpAWI4eOiMZv/hk2T8cy36Fr1JX9GJ6dCVZWfjiUfHcFR1oDsxBZPE9lNX/bxWPJCHWAO2DWJ/TOU0z++iEZmZHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529259; c=relaxed/simple;
	bh=9bIui4T4fKjYkvkbJ4kHDpDLL+A+t7pTNzTpq8o3nzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6os6X/a7t7zUNxmpOqXocfHqr25WIpROvdGpnoLn6DVt2ewLtGyyUsR6M9lkNaCGCx4z3HO9P+IZbvCHj6J5jk7/FilUqk3PVG6J6Kkro7f9bwma6DpD4a2/dEgPkqUBOy2WuDp1g0plEvx4fD26pgHGakYXGoSbbmuIiaJNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQfvSJs/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6836428a12.0
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758529255; x=1759134055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWul91Ypvcl4/Z8/7o75pIG7A+MoT7DTZL7QIYZ08GM=;
        b=XQfvSJs/ZLEYY9ApKnmGKLgzTbfOlFzPHilMjJBNusAzRhILBXGK5+qd0qlJ49UgwD
         nhlUR7EML/0D5INQm8nW+yb+SBqMhrhMFMynRUy8O5lW40NY/8h4z1zZGNg9r1ZFwBp3
         HDe/8bmqh9KKLwTKeoGg3iIunJSUAxMhZm2zC1NaojL+samXZ8naSIHFEtpGgOtYgODP
         FX6MdtkgJLlFzxy1p+q0HE4dbdDNfbBf29hfRFd9PXBMRhiAe9sXidQwoQE1Ht7mLMJH
         VrkOHe0YzCjRxhQfYAp7K5qB+dEFrduse0qfp+lg+dKG94aNmF0pZesUcU5Z3xr+qgqv
         ARJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529255; x=1759134055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWul91Ypvcl4/Z8/7o75pIG7A+MoT7DTZL7QIYZ08GM=;
        b=vUaJenSqvCvaZAAm3fgWTibSYWuuStXqlrPeESIRZtbuUKIjovc2cFkYzJIx6KmGeP
         wCkJ9HUjXFnX+0n6+xTHzX/80ACPRT1nhPov7ZLAZ2KPe2g/Mn+h/FVs9rZKl9Ye6X13
         ohboLlcWZt0TUrHZHrBTLbLKBIc21A8x7B9+0ZqOo/jftUNfPvi6VviUXsipWPgmIfQa
         9IjSW1sK/EpYzHBNwPOI0Q44x4quzSbcq+7lZE6aAagGlHx7MFt3JGjIsApwTZ2swm7w
         xLEbuf6Pn0jVsEIr6lWp+HwW4E6t22oKxAgIhoctxMMlyprGDyPq0/JpI08G6Gyk6qvk
         wYew==
X-Forwarded-Encrypted: i=1; AJvYcCUGCCQZRYah9Wdmp20MaOofu+r7q26aNHQ4MGVM4uaUYUbkaaxqh1kueomh6aqUZUpsSaXyj2YU@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaTgZZe8j3LUwMf7NlJ8IelbrZ4HC3fGcH/Zfl8F2W+DK7QFq
	CJ7AdkPRv7Pdp+avviWpREBvdFmsbLIgKIMQYVFWy7KBwzHFmUmeBMtASEGq+ZDieTM=
X-Gm-Gg: ASbGncuVatP6COTSuBgba67Yj+oBnw7HEMh3Pjgmw82DRmFD6/44h8HierTZAqbUC/U
	TgKd4uLDm7ckc13eZEHPsrWOR7lbIZfwQ8v0SKDQqDNOMNvlbzzcXOUwYhuASjini0Lzs8yXQvY
	MGVNPaCSn96huO+GorX6cNoEWguJL5MaHdp6NwKbDDiLk7AEOZPGqaKK3HDmcOB9C6706r4fmg+
	1MoQmg/NcRFpGFIs6KEWJrTfPPWdCEv+iF4ZEoag4RwYhORT082ICNgjO81lS6QuC6YAt3OON+Q
	4f3LqhLqURAW2q/DXhywpJsx+jes951jWofcFX7rlh6yq/kDa5H4YSFudICz3+7jtN4DtG8/EKd
	Qpo35EKUEbzkPAUxPWJePtuQcqahGo1+c9NWBL5UXdwiw
X-Google-Smtp-Source: AGHT+IHxaY0GwSB34k5+NBnTaegItK7TZCUiH69yPauB/fSzm2ILNNKQYpIgAd49Vk4qkxbTnJOrIQ==
X-Received: by 2002:a17:907:970e:b0:b2c:15aa:ff4b with SMTP id a640c23a62f3a-b2c15ab1084mr303701066b.4.1758529255122;
        Mon, 22 Sep 2025 01:20:55 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b29b80eaec6sm426411666b.87.2025.09.22.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:20:54 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:20:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, david@redhat.com,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH linux-next v3 0/6] memcg: Support per-memcg KSM metrics
Message-ID: <aNEG5W0qLPKKflQA@tiehlicka>
References: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>

On Sun 21-09-25 23:07:26, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> v2->v3:
> ------
> Some fixes of compilation error due to missed inclusion of header or missed
> function definition on some kernel config.
> https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> 
> v1->v2:
> ------
> According to Shakeel's suggestion, expose these metric item into memory.stat
> instead of a new interface.
> https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> 
> Background
> ==========
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related metrics.

Could you be more specific why this is needed and what it will be used
for?
-- 
Michal Hocko
SUSE Labs

