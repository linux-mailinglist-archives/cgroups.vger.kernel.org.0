Return-Path: <cgroups+bounces-7335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E8EA7A82A
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 18:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02343174DB0
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49792512E8;
	Thu,  3 Apr 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fiUhHyuY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC919CC39
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698867; cv=none; b=anxguwvQtpS6SIu7c8iFt350gOBiCraY5NLG+DavY+OEvxYcHnHje7sYm+12ocmMwNmBmuDSHJYmcfPrkoxuSQhUS97WDSGyo5yUNKeM+aQjrvxEGoLRHRcf5dcAXWbas0ISWm9oDKrPaol56/gXVIvNaMhXzACJPzpO1+icZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698867; c=relaxed/simple;
	bh=hDTReC1/mrfRfARGTXPr2AFJZNz3CIDF1/HOyaOPQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwjMAuy3mgJD6dsIMnrT2XxRHBRBOu9+g8KNoL/PTJ/IgeN3RsnC242QYWjONm6VxsveNixmMQfsN0fs0GJ2qcwPQvg345BlNnM7kkEp6RMFptGSxhNm/kpyMd98jfW5WhF12aU7QLWcxTqwU63bgPPVLr/AUigRnejoxppagP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fiUhHyuY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6eeb7589db4so11611236d6.1
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743698863; x=1744303663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nud2fc5RcW4evh9vy/G4Ts8NFlLn8W5YgcQMx1TJsk=;
        b=fiUhHyuY6IFVq3Avo+eX/Zt1DvpKrJWqObukeHkd9jBWHgZcebFF9zaSulluvFQ8K+
         /p2qIb6TrP7cu3ZaZV9zYjzlIZ06e64htc2D+ENki+EdMmTvVR++gsOz05VYVREJXZ78
         uHUM1gjJmDvXgoY4Vhrjuj8AZPdRCjAusY8mn3l3xZSPC+G1YwV8SzOFnZ5iqaQ0ATiP
         irEh0HDvEODv+AfYQ/7JrlItFJndjVHDRchLlFJOSWtUmoKXwUmOVjjtxTMGeeIH9lAh
         AOZcuc3tfGxAJGr7HaTTBUcvhyM14IQiPu7JJZ4yqYVQYsMrS9vkL1Q7cmQVP3rE0z7q
         FQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698863; x=1744303663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nud2fc5RcW4evh9vy/G4Ts8NFlLn8W5YgcQMx1TJsk=;
        b=irxfZhjZ2YtIIztyJumXr7MTSEt9Nxvm95TNHVlkcYXsk01Jp6tY84D3YIA2hnKKzx
         dzQAwOsJ14ZPWpQZpcHhA5sBtoUuOrCDK9pCmVtXHsKcJFdnOYZYA/Wjkddu49ilzaP8
         y2huh9MxZmLvDLwwqgDNS0xpTPIejSQXijCdojaW0HSsSCTutbQnHO/99KIFUMRHz27Z
         ZAmrl+laJHKlNWmo4woTV4O5bFV5qnvEvUIhMm+nxmshRBctmoqervyY8dMHAPcXN15W
         Jr65KC4ajTJ1jMRmfgfvU7GnTG1gu6CUUKdPqyn6JlebMq9wupodAgYJy9ILAGM5s5sg
         O1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUKdcT7B+d2B5RpAgGTQD+l596ckUIXneTbQWOzGxVDIxiUDXKlijzChpbO0E1DP6lBWkfOFRM4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vUXXQRiDjVGFn0SOU98oJVzhIi52OBiqV3Qi+VgLexQOXpfk
	wmY9lsO0GhZlKde7f8UPVYwdZq8Q3oPl2RMqHBXCG32SmDovHVV054EU57Mp1a4=
X-Gm-Gg: ASbGnctWeVwaRmzNFJT7f143O7MM4uHrXpEmsR5dJg3qDn2meV2H8/aG4N4sVlW7Bsr
	voxXzkUxxwNDb9jazxhY5fkEWTEpydrWXs6sbJeoG2l7jebvhSLCmUZ5rQkLz2lFi5fzqu+Q3qq
	5nxCrkbOW8Qny4BS78D8sx/K8sdPo28viOBR5GaENWaW0fkPRDMoNGtyI7pfsxXwSICf0CCZSIP
	ETVpJmINWhDUlEcwAwrsN5apvwt6dIIQFMpFmCwJuIU9n4SGcEnu7Ip+H/Xq6FHRYJpl1NbgUU7
	ma+1wf0T+D3/tj1URv0AvNihRJzkCTrPajR44kJIaviQr3oLFkJxIg==
X-Google-Smtp-Source: AGHT+IGn0LSk8HdIMSVIgWA75foWE+TwNl3UlrFotjqft5M0lp3yVrvEm+t6kj+IPVcJKWN1kUU2DA==
X-Received: by 2002:a05:6214:2241:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6eed629b6bamr345313326d6.33.1743698862969;
        Thu, 03 Apr 2025 09:47:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76ea59e42sm97209685a.77.2025.04.03.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:47:42 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:47:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Message-ID: <20250403164741.GB368504@cmpxchg.org>
References: <20250403053326.26860-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403053326.26860-1-shakeel.butt@linux.dev>

On Wed, Apr 02, 2025 at 10:33:26PM -0700, Shakeel Butt wrote:
> The vmalloc region can either be charged to a single memcg or none. At
> the moment kernel traverses all the pages backing the vmalloc region to
> update the MEMCG_VMALLOC stat. However there is no need to look at all
> the pages as all those pages will be charged to a single memcg or none.
> Simplify the MEMCG_VMALLOC update by just looking at the first page of
> the vmalloc region.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

It's definitely pointless to handle each page with the stat being
per-cgroup only. But I do wonder why it's not a regular vmstat item.

There is no real reason it *should* be a private memcg stat, is there?

