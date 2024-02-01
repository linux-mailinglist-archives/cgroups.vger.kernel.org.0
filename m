Return-Path: <cgroups+bounces-1300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BA845BA9
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E1A1F2C286
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1B62141;
	Thu,  1 Feb 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lDXRXzRD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34771626AD
	for <cgroups@vger.kernel.org>; Thu,  1 Feb 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801678; cv=none; b=s+sD828KwhpUQcJkDXpnIwtWOxa0gMlECu/SWgZz+cGKjTnInD8A1FrB5/BhsAJbXYVhvfsgNzHdiXT7V5adY56Iekx53DgjfAVlIfrRcYx/Zirp/e9JpCXEpUBWp2AI2ttNXzKv//cTlo/WEnt3UtNwGxCpeKSQ4FHJMTP2PX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801678; c=relaxed/simple;
	bh=13PcTdhaGFdTv+3l6uEyVq/w0uQbXHOvcDFwClNLKZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfLreZuFaze8GIu8gU/ODgAf0zwgf3ZjK5x1ql5ZWg8yWdmRAS30G1TYKXXr4a55fyPtvrmKeZkghoBGMG2XC/PuOa5JiTsPmhwjK67KV3kUr/fuTJIOkYf/mBwLCTJhmqwlRCV0ENF7LyC04cHLsyLB3VS8MbXoxN6cuWk0NDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lDXRXzRD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783ced0216aso54421985a.1
        for <cgroups@vger.kernel.org>; Thu, 01 Feb 2024 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706801675; x=1707406475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zPvZs4K/sfx3gwEPHE0K6OK7OOwWGbcE7kwIuj736Gk=;
        b=lDXRXzRDu4Hdu7j+0XXXm/fY+D/Q9NDZOGdiUVNlhMTZDii16yItoEX7zpLas6unVT
         QQFU6zy8RDuqiiF/xpO72sqIgyA0abeaIW9Ysx/f8DXpuX8jcVFv7JpVk6AucMzeNYjh
         Km2jpznZC+SGUA+NJexeHi1hq4p7RTJlLmQ2ZFxIUAItnI7SXtiZ5xwDflsPfW+RHnb7
         IoNw0yhMaiCMF44q0TZGYe1kFi8hYY8V5AdCITOCGDJGLEALb3PXU7miyoPf+zF7ZriM
         E8NC+yx42Ru6alCZC6fpZZGOElwyRucX0ovliA4nmaU6iM6gfKniz9CwJwu+T5zx7o5R
         DHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801675; x=1707406475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPvZs4K/sfx3gwEPHE0K6OK7OOwWGbcE7kwIuj736Gk=;
        b=kq7mWviQif8gV2KsdchoSUrXNFxGZaSptHTXCVNqPqa0Il8CosoB9nms3YHccB+EE9
         0eD/zl147EYxOU/nEzsQ8+LBDY9XUBHely00kQ1V7N5914GcVHzun3b+yjbYZyBrO9aq
         tppsmJQNDehBB0zMtAgA5SuSLNZEpTQL9kvCd9+6SUqrRZRya68jyFc4ZRoNq5YAJpFc
         70TSQIGPFx6QSOGGi2AkSn2I2+QXRv2rbHrglBezhMyo9/BPX0fAeiFK14A9mDwXNRrZ
         cqh4ySm9HJu7qZ46XNLyup7u5t8oOUeszgc+ya2S3vYK8ReuTUuwp2uqv4TkpOaiIxmj
         PUbA==
X-Gm-Message-State: AOJu0Yz2+28aiOjjAMOdkgFtQImNRw+OKA2B0Y+SmBDcOJQ6Cr0pD/es
	tDUaw9SzaFGWqrHT48N6/d17gmCV6dGbZGn4Q1NhOPvHeLQ+lj1TIGan14vIrFo=
X-Google-Smtp-Source: AGHT+IGi/XmGKqr5Cs1gVK8YipQ2XHKTRdRpKkoeUGmO9YOgPFP2kvzWajFfZcZoTktkg1gfV2ePmA==
X-Received: by 2002:a05:620a:26a2:b0:783:5b21:5746 with SMTP id c34-20020a05620a26a200b007835b215746mr3935847qkp.43.1706801674936;
        Thu, 01 Feb 2024 07:34:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJY1BAiTTEZMvicUpiSL9Kon6fKRwF3bWl6PwAZJC7iyhfRfrydfsJ5C+fXJA32s9ApqaBsBBEUHSHo+Kkzhp5r3fZeOOpdfU4yoeNqMjLSkqBvLpTGA+NCh7wpjyeS0dIhEriuuIqIg0XlRtefRk/FxGDcMT+LJ3nk9UrZ8+YDxTCeYS4HCV65LhB3VeDXyQLjxCuN43UvgZ4s3C07VVvH27WkDy02wbD4TIB90t8t01GhyO8NFCmWhrz8g1bfvvRi2zXbx0l7ONCw4n9pMZkgp2Su7ETPyA8mZxI6hVrywGoAd7GwZD5BdclWZjquE3kE1d8XMDVDzKuORnJ7nLiTwE3KbgWgr0+5ojToooEIB5Xb08GaDDWTwmCQqXczCpIp3eKjOUeaIOtORQcfOu8Fg==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id vy15-20020a05620a490f00b00784048d795asm2918077qkn.108.2024.02.01.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:34:34 -0800 (PST)
Date: Thu, 1 Feb 2024 10:34:28 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <20240201153428.GA307226@cmpxchg.org>
References: <20240131162442.3487473-1-tjmercier@google.com>
 <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl>

On Thu, Feb 01, 2024 at 02:57:22PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Wed, Jan 31, 2024 at 04:24:41PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> >  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> > +					max((nr_to_reclaim - nr_reclaimed) / 4,
> > +					    (nr_to_reclaim - nr_reclaimed) % 4),
> 
> The 1/4 factor looks like magic.

It's just cutting the work into quarters to balance throughput with
goal accuracy. It's no more or less magic than DEF_PRIORITY being 12,
or SWAP_CLUSTER_MAX being 32.

> Commit 0388536ac291 says:
> | In theory, the amount of reclaimed would be in [request, 2 * request).

Looking at the code, I'm not quite sure if this can be read this
literally. Efly might be able to elaborate, but we do a full loop of
all nodes and cgroups in the tree before checking nr_to_reclaimed, and
rely on priority level for granularity. So request size and complexity
of the cgroup tree play a role. I don't know where the exact factor
two would come from.

IMO it's more accurate to phrase it like this:

Reclaim tries to balance nr_to_reclaim fidelity with fairness across
nodes and cgroups over which the pages are spread. As such, the bigger
the request, the bigger the absolute overreclaim error. Historic
in-kernel users of reclaim have used fixed, small request batches to
approach an appropriate reclaim rate over time. When we reclaim a user
request of arbitrary size, use decaying batches to manage error while
maintaining reasonable throughput.

> Doesn't this suggest 1/2 as a better option? (I didn't pursue the
> theory.)

That was TJ's first suggestion as well, but as per above I suggested
quartering as a safer option.

> Also IMO importantly, when nr_to_reclaim - nr_reclaimed is less than 8,
> the formula gives arbitrary (unrelated to delta's magnitude) values.

try_to_free_mem_cgroup_pages() rounds up to SWAP_CLUSTER_MAX. So the
error margin is much higher at the smaller end of requests anyway.
But practically speaking, users care much less if you reclaim 32 pages
when 16 were requested than if you reclaim 2G when 1G was requested.

