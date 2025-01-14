Return-Path: <cgroups+bounces-6133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E80A10A46
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176AC3A51FA
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA814F9ED;
	Tue, 14 Jan 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QpirACUF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C8232424
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867085; cv=none; b=rLjdUrlfVyL8H1Bv2p8AqAg/9EtEtvDavUFv4gg4ajsFryi+VBK2xAd6umBHaWSyjqRUjovkCnDkjWXx+ZHP/phkFb3q5LRRwdkkQQK6PsC/BcBAV+myKa082WuUTyH/nQ5+Nb/l5xmhl5X4TZBtkvujdmc94lCeGYL05rYQELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867085; c=relaxed/simple;
	bh=OzBgRFx4fTp6VNlvSBlUWiyBGdW0/IUTfAq6e9k2Cnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIMSw7vEqf4CDr53MYG3dIk0GbS0KEet9N5Cq1qAr641oJ1QMZJTCrtyR/+9tM+E/3d6WNnjY7x3IDBOzhS+10d7vqYoevsNIHIJbrF3CUtL1WI5yqWTge0/aB9CaE4/GXOdWzmWIDZDchnkNJ7wTsIhBf6oFpB/VrXHfJgyTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QpirACUF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso9829401a12.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736867081; x=1737471881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlzFzz9CnL3cnQzM4bidxHHVsjw7x7xEwR/iZezcWCU=;
        b=QpirACUFvLejNk0XvMp2vLnIzE75dgO7uFuJoAofl5VCscGTgpA72h+Mow+5He7j0+
         rP9j4pJ6CA+n/wvyqq9+EoZu2kpxY75WuWMHTKzWYqwDQx4j0oPQlAQqk8rkSFWRGPj4
         4jyh3JEj0ObfAjT9TQdZEKBkfCvBQkq4eBaow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736867081; x=1737471881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlzFzz9CnL3cnQzM4bidxHHVsjw7x7xEwR/iZezcWCU=;
        b=UPTLrAVuWkhwbGkmSP/irFYfLl0COD0y3ImY9FMwtxZ/HRtuizc0ni3+CGFXVwkLr/
         DOS82oW2VJZZMfW7FkV1fFCFo5mdyGQ6qOtTWpOJwLFJOUg16Ts0OYAcGNNf4RQ8WOaX
         gwRtepSEahPaBvhgfdZzdgqQYrN6mFLHPJAxaOJ3dLS7jvPUMryaLivv4/lJe6xu+lpC
         Ms4+6Z4OsXOvnjnVcWPAWHnGvQG3dzrICPffxOEnt5m0GRxYs2+pjHjre6QK/KHSQFHT
         /mTZEOY5AmhhawjN41gpRUOwrCTnGwSQQtLS6plNpqZckfiBSBmppeJ0xapbH7e0XuQJ
         EnBw==
X-Forwarded-Encrypted: i=1; AJvYcCXagiPNbT6wxFHM+FWFvlAgB1ZT1cdSsWpwx38AtGy23JViHDiXr96JrGMA8431ldroGTz7FDWK@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaAiecRHCGHu7MW6ij0sd9Y7geo+tvHL1+/WnB1Iu4IRTwAg2
	xulWJu6hHDb4MuW+VqnHVqAGlfhwTJEy0vTnH7VIgvEu6T+Q41xD38eaW557er4=
X-Gm-Gg: ASbGncuIhnHatnjZrqWJoWUhGU52yPar7c/hs/osSD1aiQ6pS7QEicKSZa33M8dtkwC
	5cHAVEwVM0OXavPbpGsYDlgsyjTTlXyyHeItfcQzHbEOH8K2dsISN7Za4NOtuKexP2a9F+v90qk
	OpCRQEKb+vC4263hUpmhXqLra7akG2XAW2OaB2UITi7UM+sWx137K6NqkGKHmLjl5nrYAp47gZE
	rd1PAvH3MzWI2WbZerNCV5HcjExN7Acucf/QyVB+Guc3ducoD4+i55CoCNuvgkS36o6
X-Google-Smtp-Source: AGHT+IH+UnsuMwr+XU0+iENq475M2f9Mz3g9fsBiqzqlUj2pYHNplby4nlIPDiPfP8/GQO+NFoPQDA==
X-Received: by 2002:a17:907:3f95:b0:aa6:8bb4:5030 with SMTP id a640c23a62f3a-ab2aad118aamr2488137166b.0.1736867079859;
        Tue, 14 Jan 2025 07:04:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c96468afsm646952566b.170.2025.01.14.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:04:38 -0800 (PST)
Date: Tue, 14 Jan 2025 16:04:36 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/4] doc/cgroup: Fix title underline length
Message-ID: <Z4Z9BENJm07M-mOO@phenom.ffwll.local>
References: <20250113092608.1349287-1-mripard@kernel.org>
 <20250113092608.1349287-4-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113092608.1349287-4-mripard@kernel.org>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Mon, Jan 13, 2025 at 10:26:08AM +0100, Maxime Ripard wrote:
> Commit
> 
> Commit b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting
> cgroup") introduced a new documentation file, with a shorter than
> expected underline. This results in a documentation build warning. Fix
> that underline length.
> 
> Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20250113154611.624256bf@canb.auug.org.au/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

On the three doc patches:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  Documentation/core-api/cgroup.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/cgroup.rst b/Documentation/core-api/cgroup.rst
> index 8696e9513f51..734ea21e1e17 100644
> --- a/Documentation/core-api/cgroup.rst
> +++ b/Documentation/core-api/cgroup.rst
> @@ -1,9 +1,9 @@
>  ==================
>  Cgroup Kernel APIs
>  ==================
>  
>  Device Memory Cgroup API (dmemcg)
> -=========================
> +=================================
>  .. kernel-doc:: kernel/cgroup/dmem.c
>     :export:
>  
> -- 
> 2.47.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

