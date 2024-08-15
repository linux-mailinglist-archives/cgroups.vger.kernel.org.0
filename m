Return-Path: <cgroups+bounces-4302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCDF95295C
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 08:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ADFB21426
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F04176FAE;
	Thu, 15 Aug 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VP/cqdyv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84A18D647
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703383; cv=none; b=t1e6LRfXE/68Gy2251k5ut+frqmqicajxN1y0nrbgkf8epB5WIE7Bmrki6qRBAWnmtUn5ETVkK95yF8sRLmUSL5bj9SsBpIOKLtE33fx/kWQ+JNjIvnIGgtI59xCpe+bnkRDuT4aetXpfwJ+2gywOfo+b8voPLoQry45O8tPS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703383; c=relaxed/simple;
	bh=GyFKytUfy0+tOp6N/GeQOqt1IV0b8dje4SEn+fVb64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcn0gjWdQZIMHf+wQ6EQxxWvPs8H5pwpSPvPVD3TqwS9NYsO75O59AXglK7P4QgWkEKkqm8LX07HvFr4mp9RCZwVo5fNZliU4E9Tk1c8EweQIKQXO/4SEmHar6PYV+V9wIPJtAnNLElE97+8BrUsDNZRZf7P2OIkHz4G3nUANaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VP/cqdyv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428101fa30aso3615265e9.3
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723703379; x=1724308179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rS3zSikqj+bYXDsc+ql3OeC2bdnsOqnPpeoipHUxNoM=;
        b=VP/cqdyvtQ1VlGNzFRElbgwMyZXmm7/zf9yDb+btseb/mttE68paZT0sCFg6jf1DyL
         S9FKvDlUC62BkpVYwaWhxto2koBtNiadeAYsWJMh1g4IafvFpqbTIqb4m+KqYTcm9G0k
         N+oYPpaV7k9lsZP5UqD59HO6k64fUeidWVz5mWtw1R2D0/Y8X9I5CNe4PBwA95h1BUZh
         UbE/cOCTKN+EowCymwURU7oya6PHUx9g8i+TkEji6bwsiXgUIJK5ZqIrZ36PrJOBbMQM
         vrNzwGM/4sBfTkfD2pCAtie5HqPlhDsAa1wMmShvvXfn1cR4po9eU6VTa2Glu2vl2jpa
         MQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723703379; x=1724308179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS3zSikqj+bYXDsc+ql3OeC2bdnsOqnPpeoipHUxNoM=;
        b=ONoqu3UpxLtKyK2h/oCsN1SR5KmnNMv6f1wjrmVx0xeHWIUplJ1+YErst/8cPR7jKC
         ODFiQmb72Ei0r13cs14AFxTyKTJ5P7ZmiyZnf0eYGiM8amA3CZHausMdUVBG5/egyCcW
         dVI9r0dgZnrIU5F8Ln0TJNDThzZf7iAfTUuNjT57pJfUIqzdba/lNZwau/HvVnrFT2Ks
         u+qLI1VYWex3RvzxuibpYhTp54jnO6SHs5gspnAiaLufjZAIl/ecfsSq25RpEgdpXWpa
         I6ifTUvWmnUiYgFiZocsL5Tl7C3DVAfJxboEZW4F/BqRflo7sA5c0m31wmOF5SLMXzCs
         I3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNebD1lBvDGOBMjuG7XwVYcWU0XlLZP1q2j34jvAS0spxuz4FCIFWdcVAcfuVeTsb1udYGlfAfxwwJqZCcSHHvoI+6AGUBAA==
X-Gm-Message-State: AOJu0Yw9AaDsDxM1sMWdCpx+NQ7gSuizhGmTJakeNlPnMbHXxWdSmeVj
	MqqEFlMRbfKLTiECCtXHuRYQNtFJGLrHm6Bq070g/uodtkLEhI02Vpp4KfKfayw=
X-Google-Smtp-Source: AGHT+IEwtK0IByHoEbcy8sKW7Ngi98OsSs4EFQDOyovER/7+6bNzNP8sXQM+liQExRPXVNMEzEFgUw==
X-Received: by 2002:adf:f5d1:0:b0:371:8d9d:d824 with SMTP id ffacd0b85a97d-3718d9dd877mr86901f8f.0.1723703379409;
        Wed, 14 Aug 2024 23:29:39 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac2d1sm702780f8f.109.2024.08.14.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 23:29:39 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:29:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/4] memcg: initiate deprecation of v1 features
Message-ID: <Zr2gUUo9xlaywq7P@tiehlicka>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>

On Wed 14-08-24 15:00:17, Shakeel Butt wrote:
> Let start the deprecation process of the memcg v1 features which we
> discussed during LSFMMBPF 2024 [1]. For now add the warnings to collect
> the information on how the current users are using these features. Next
> we will work on providing better alternatives in v2 (if needed) and
> fully deprecate these features.
> 
> Link: https://lwn.net/Articles/974575 [1]

Acked-by: Michal Hocko <mhocko@suse.com>

I will add these to our SLES kernels to catch our distribution users.

Thanks!

> 
> Shakeel Butt (4):
>   memcg: initiate deprecation of v1 tcp accounting
>   memcg: initiate deprecation of v1 soft limit
>   memcg: initiate deprecation of oom_control
>   memcg: initiate deprecation of pressure_level
> 
> Changes since v1:
> - Fix build (T.J. Mercier)
> - Fix documentation
> 
>  .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
>  mm/memcontrol-v1.c                            | 16 ++++++++++
>  2 files changed, 42 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

