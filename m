Return-Path: <cgroups+bounces-5172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4F9A6E81
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E491F2456C
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBB1C4610;
	Mon, 21 Oct 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gooxrjkp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4871C460C
	for <cgroups@vger.kernel.org>; Mon, 21 Oct 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525460; cv=none; b=TkUrLHWe9Bm7Rse4WjVW4F9K1B9lqhwpuW002KZZhlqUfFtU3lnrvjsFSKecq0I4TR4YiUpQQ+t64ZtBPK6RgZ6VuSbnf1gGakwx8bYotpeMyQnPB7HQwtu50ct4AqLwkPKsNUtOfE4Njbj0MXWZk7V3wimCkhJThlQXbjN++ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525460; c=relaxed/simple;
	bh=EZnS51w1QN9LnkZGC/VRErZHu7YzAVSf1COlI+bY0t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1IS3vRZhsKInchqLU2mA/LBEF01Lf47rzUImPCeCjvHOcYIWc3GNmQ/tp8n+x23O8V3RlSIZWjJ/WyK5nfchjWbcEvUpIO/3kTH+7I0VT4dYYjcxZphV731lldxVHBDe9VwqZMmA9imnkNXXxKaaq+zecqV+hJzlAKwFojBrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gooxrjkp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so6271862a12.1
        for <cgroups@vger.kernel.org>; Mon, 21 Oct 2024 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729525456; x=1730130256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSEb+ymEnyGrSZp7cX2c6uEaBnPjBoaasTWPd/6WjFE=;
        b=gooxrjkpSom//dg6mW8PJpkozg5Wfwa+Ozgos5nWJdXM//3uAgUOHDjNyU5L3yk3f/
         jbvt3+hQpkV3/qeHot4ey4xDmHcg9T3pZqYvvu0P8GnszVfcdm4ixYSEuTsM55MYxN4x
         RLYyWRFbggwbrMmkDCGlG84oFCMRZl+RYdk1NIcplSxKnGVvccT2yJclhJYCl6sbYzVc
         +vQu+pA/8zdJbJh77a8ClruI39LNApLjzR9pJO4Q2cKns0sa2Ii8W+2jMqn8Glv21fQ9
         U5ebuROpXRwEFRjLrG0Jr1ls6nVC9faO9ezuy/jVRaUyCawfLc3K/dKDXf/YY8TuTI8g
         PS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525456; x=1730130256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSEb+ymEnyGrSZp7cX2c6uEaBnPjBoaasTWPd/6WjFE=;
        b=dzXqficcawQHuwKAEXzQpW4Yx6IdGUImKvwVLajqYfX/p7bUc2ND0+Iwpv/nCunGr3
         TQRbge+r1FXeBU5G9eghc9xivwjwI0psss6VWi+Hnr13HmC5Azj3kOEEUZUwCXwMRYA/
         22S58ayQrl+1trgvtEf30E+yowzzKLptgalLv8TtpX5k4Hj0jfDf7x90YBPXjYSy0hVZ
         LEJf1/lpyyuUAp840X0jVH9vZxdCBpeXL9e48ORrJ4LaqJlpthGOuU589I8NuEAVvlNz
         wqfqVXQNoGPljBPIS8yXvq+miRiv57cNEzVuNWrdnBkqSj1ef0D6ECLMDB5jnMI8P2TA
         5jXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6CEorkx1TBYUJJhl5KnKAYd1ZF9BieK0eDnH2f215nbKezFnGv9sz4phiZonqzOLEI5qxCQGv@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW+66UTdX9rsiW+uSsT+ukmjsU/5Y9aCQ8Mxq0qXGDmy7Y5lf
	gX/WhaDuzXaO7hLGzRMDVjHooxlqrSMPe9n8I4BKKmGf5IWbkBVtMlkbTmr3AOA=
X-Google-Smtp-Source: AGHT+IGj6Ce0bxqUPeEzNKA1yVTvwx2NhQ+jfM1ctq9xUAIhUZbv5kt1K1A/bnMh5GN+TfxgS7AQpA==
X-Received: by 2002:a05:6402:3509:b0:5c8:9f3e:e57 with SMTP id 4fb4d7f45d1cf-5ca0ac628c2mr9720000a12.18.1729525455746;
        Mon, 21 Oct 2024 08:44:15 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm2028599a12.96.2024.10.21.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:44:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:44:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <ZxZ2zlQ7t6fLhL1R@tiehlicka>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka>
 <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
 <CAN+CAwOHE_J3yO=uMjAGamNKHFc7WXETDutvU=uWzNv5d33zYg@mail.gmail.com>
 <ZxX_gvuo8hhPlzvb@tiehlicka>
 <CAN+CAwMCbX1BAmfBxFC6t75i5k6GVNKPR_QPCB5DDnYwHeCbnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+CAwMCbX1BAmfBxFC6t75i5k6GVNKPR_QPCB5DDnYwHeCbnA@mail.gmail.com>

On Mon 21-10-24 10:51:43, Joshua Hahn wrote:
> > On Mon, Oct 21, 2024 at 3:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > > On Fri 18-10-24 14:38:48, Joshua Hahn wrote:
> > > But even if we are okay with this, I think it might be overkill to
> > > enable the hugeTLB controller for the convenience of being able to inspect
> > > the hugeTLB usage for cgroups. This is especially true in workloads where
> > > we can predict what usage patterns will be like, and we do not need to enforce
> > > specific limits on hugeTLB usage.
> >
> > I am sorry but I do not understand the overkill part of the argument.
> > Is there any runtime or configuration cost that is visible?
> 
> I think an argument could be made that any amount of incremental overhead
> is unnecessary. With that said however, I think a bigger reason why this is
> overkill is that a user who wishes to use the hugeTLB counter (which this
> patch achieves in ~10 lines) should not have to enable a ~1000 line feature,
> as Johannes suggested.
> 
> A diligent user will have to spend time learning how the hugeTLB controller
> works and figuring out the settings that will basically make the controller
> do no enforcing (and basically, the same as if the feature was not enabled).
> A not-so-diligent user will not spend the time to make sure that the configs
> make sense, and may run into unexpected & unwanted hugeTLB behavior [1].

Heh, a lazy user would just enable the controller and hope for the best.
And it would actually worked out of the box because there is no limit
imposed by default so the only downside is a theoretical overhead due to
charging.

Anyway, I get the point and I guess it is fair to say the half baked
memcg accounting is not optimal because it only provides half baked
insight and you aim to fix that. This is fair intentention and
justification.

I have to say I really disliked this extension to the memcg when it was
proposed but it was claimed this was good enough for people who know
what they are doing. 

> > TL;DR
> > 1) you need to make the stats accounting aligned with the existing
> >    charge accounting.
> > 2) make the stat visible only when feature is enabled
> > 3) work more on the justification - i.e. changelog part and give us a
> >    better insight why a) hugetlb cgroup is seen is a bad choice and b) why
> >    the original limitation hasn't proven good since the feature was
> >    introduced.
> >
> > Makes sense?
> > --
> > Michal Hocko
> > SUSE Labs
> 
> Hi Michal,
> 
> Thank you for your input. Yes -- this makes sense to me. I apologize, as it
> seems that I definitely left a lot to be assumed & inferred, based on my
> original patch changelog.
> 
> In my next version of this patch, I am planning to add the changes that have
> been suggested by Johannes, write code with the try_charge cleanup that
> Shakeel suggested in mind, and change the behavior to make sense only when
> hugeTLB accounting is enabled, as you suggested as well. I'll also update
> the changelog & commit message and add any information that will hopefully
> make future reviewers aware of the motivation for this patch.

Thanks a lot!

> Please let me know if you have any remaining concerns with the implementation
> or motivation, and I will be happy to incorporate your ideas into the next
> version as well.

I think clarification and fixing the reporting is good enough. This
still won't make the hugetlb sneaking into memcg more likeable to me but
nothing that would force me awake during nights ;)

Thanks!
-- 
Michal Hocko
SUSE Labs

