Return-Path: <cgroups+bounces-6131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D34A109F6
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB821886F67
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AF1885A5;
	Tue, 14 Jan 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CYZOEmS5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA9156F21
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866410; cv=none; b=tDFyyHBfNiCCKupt3AgFT1W0KGqprQmoBuJ0NOyVHqgB3crv+eHhBbJfDnTtZ43zfgkJIr9KppaiDOUc4tmLJ4nftPpTsYNgdGZTxkpOpdeW0lxg/wDJf8NpZJYhA0dK9EAFXBZ41+2CY8YNRn5NtLlImbWdeiZ/QnCLcSDxjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866410; c=relaxed/simple;
	bh=/n980uasJNPwBTSyj//8E4RpeJAyj4uO4vG//D0FkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjyzczPBNSAYSK1jGx8OXNzzz47/XQmAtsugYu7EK/K6UxVhKSraUum1JmFiiU1IB6WVL0duDKVe+T/GFuTlS1RjgENS4Bqs5a0I6cA6dk6h7/vUpPJ5/S4yAUPbaUDdu5u1zANqsC3g/kdlscV8q2Znk6OvOl2jlWkHnk0jLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CYZOEmS5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso1076698666b.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736866407; x=1737471207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCOirKrbiLq6y9/fTWwoYFEfBlT6E37Uzm1BFuWRYpk=;
        b=CYZOEmS5usMLzpGJg7AlVY3xzOIVpU5a3LIP5fy+GQnXU6zzY5blv7gwh5YtsmABi8
         HJ1Ypow6C2BP6QmK/uDEIIIYJ8cVncF+/lcSVK/M6pQur97+HfQ+cFpzarEYttD1CfJV
         Scq3ZXrqD8AmFa3qu0jq8CN5ESBcTj2omm++o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866407; x=1737471207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCOirKrbiLq6y9/fTWwoYFEfBlT6E37Uzm1BFuWRYpk=;
        b=R1x4LZi0+uPhitZ6yltDe6NXAxkCL70WQ+BvSv/nn0SHOKohc/2FW2Q/X/M5kJoVi/
         Tsy2pStkFHypqA6q3KPAgVPKNqiG+ymDSbJDc7dUY/gqRkE03akYwtox3RAW5bmgGLxH
         kTtsKNhZEBTET9sK5c9aJwZI+PVy6aDwZIXorzPeZpAfGyuIei0N6f2y1TS1PaDtZ6bg
         P5QYAKG7gxXALE6sW/y5ypmLsONoTL0SIhLf7EE0falwLS11YRlnbbAOWJQNQaVSIxK7
         PR6peKeVPe0XM7AU7xYgOTRGR0yy8i/CGjeN6HI+JPu5i4TSla7YihI0TWgMdrruJiMs
         FMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWmX/nvD7ZVwLXzWdSXg5xrEnUV5ulO0vrGHPJHzbutVp+sZANB3/85fQVIych795gnuc5KNn5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxOv85V98m21SSEy/ZCrSdAnfmCRrovsny6NvCYvDQluCgdnaW7
	tezRhkmwRQwygdRRJr8usxZSFxYvSiYF1zuNDrbfKbT9khWM/mmWfqssnZuUtqw=
X-Gm-Gg: ASbGncvp1m8uhVw0cLucnQqrT/wB6A3+708eeOoUVyk93KnO/d9Dz6FB08U+H+IOUWK
	tYjts+3EcsTkZ+waYfoFv5Sz1VI9BwfQLA9B1lz5kbQyma36UEyOt4fu1fWAWzHRhQlbLXzVADH
	nFiUjDqJleMdlnxVG1kVH7PQHgOYXeXJ+ZResfxzxhEPd0StnqZHleWZJPQdi41jx1WuJle3CrK
	jDWpuARO6eXGLNvwutGJroYttiIKda3JDLAdyg1ewA1CG0nGnwwwACqVsSHdnicxhwI
X-Google-Smtp-Source: AGHT+IGU5TeEIBzEzAJgPNdJpH0ZZG3GI0EgSnrHTpDU5BnPdVxQTtaLSXu5JWn4mssCRDLIZPb7+A==
X-Received: by 2002:a17:906:7950:b0:aa6:7933:8b2f with SMTP id a640c23a62f3a-ab2ab16a302mr2076682066b.9.1736866406854;
        Tue, 14 Jan 2025 06:53:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c3328sm6354448a12.50.2025.01.14.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:53:26 -0800 (PST)
Date: Tue, 14 Jan 2025 15:53:23 +0100
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
	cgroups@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
Message-ID: <Z4Z6Y5Xy5m4wMu_l@phenom.ffwll.local>
References: <20250113092608.1349287-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113092608.1349287-1-mripard@kernel.org>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Mon, Jan 13, 2025 at 10:26:05AM +0100, Maxime Ripard wrote:
> The dmem cgroup the page counting API implemented behing the
> PAGE_COUNTER kconfig option. However, it doesn't select it, resulting in
> potential build breakages. Select PAGE_COUNTER.
> 
> Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501111330.3VuUx8vf-lkp@intel.com/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 61f50cafa815..5e5328506138 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1137,10 +1137,11 @@ config CGROUP_RDMA
>  	  Attaching processes with active RDMA resources to the cgroup
>  	  hierarchy is allowed even if can cross the hierarchy's limit.
>  
>  config CGROUP_DMEM
>  	bool "Device memory controller (DMEM)"
> +	select PAGE_COUNTER
>  	help
>  	  The DMEM controller allows compatible devices to restrict device
>  	  memory usage based on the cgroup hierarchy.
>  
>  	  As an example, it allows you to restrict VRAM usage for applications
> -- 
> 2.47.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

