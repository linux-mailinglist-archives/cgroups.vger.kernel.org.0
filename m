Return-Path: <cgroups+bounces-7337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6CA7A907
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FCE1891E6A
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A5253352;
	Thu,  3 Apr 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cpabh8kB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC90253342
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703387; cv=none; b=CIb2J2AaYV4jnmPHuWbVULA9Ci4jOTSugdFMNT+rIcVU2Z659GZUEJbiLEkYy6eVSPxIetav1+sRbgk31mXiz47CrCfMxwOlztmzpOvhbZ6RyeLhKrOBpaNTZEXc8eV3IbKT7v0I7Ree0yTxa+Q5NZbP+suR/ETKHkGCQm5nuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703387; c=relaxed/simple;
	bh=8bqspJWW+gl6XkucNMvM8Ewl32Fobkcp8JB8eqmHRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE58cCfk5vC1xU1kgrU7rk2brzX9o+9ViqFcHmPUwN+0NRjl7t3qz6nowoM+4CScc4JcXEkJ9GRokAh0I6K0KUdrpbCb8aIxUsa5n0g1hisSlOuQzlz3Mws0NDV62Bs/MUr+C2b55xBULtC6Xz20fpXbXPdD5bqO8Cmz/NPN//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cpabh8kB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso8511835e9.2
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743703384; x=1744308184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bqspJWW+gl6XkucNMvM8Ewl32Fobkcp8JB8eqmHRw0=;
        b=cpabh8kBGt6hp1+H1xkLcgm10R2aF8iiBSj4u7Y0h2tx4OAqqovsCnY2zIcZ0zQ/ei
         O7BEg24PzFo3Z2yH2/EMtwWjF8kfCIDsHeNyitVzMk0Bw6mV4oAkmReL1EDc3oLbo3VZ
         y1Sw0uVZiKnrR6geeeIDBpBt7aKEQ3wFkpZfDIn+gzVhThmLCeZY3Q3TwIfzC3i2nuaS
         bnUFEpm81+uF/aVHIAC7LdYNixJiotxFZFqTAWROfYeG2SisZ+0cDF+kXeVIjEaPFAZ6
         9wE50iN5MchxxHNOT2iZx3Sz0r4LxwmeSUNhuQDKadH6hpJDXY0YnClC2ahHFTmF4djt
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743703384; x=1744308184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bqspJWW+gl6XkucNMvM8Ewl32Fobkcp8JB8eqmHRw0=;
        b=SEaxDEHmJuDjpJxPgLqHULVgVW3gjyR6h2hfWl3hvRV2fTkE5hDRlvv1+VhGaiG7/G
         eBRVkDwiKS4bTw77il5Pol4ncQmES5P+9MgYORDjRaqVz8SyCVs9A7MpxOEV1jf0rrxA
         6H5qEp2BQYTmRQH2DdTY9shbDfKbMH2Ou4gDbbBnvxMDH8/sZ0EuIoIl7XjD1nelBAJ7
         ynCXjbQkS9+WGB8Mab6zSjcpyDaRN43OMIWPj5okmPUIpTwPLm9b3sTtxu5aJODrCR0Q
         FNHyCzj1rtGa0rE1uYXABu2/vJofRAX4VALMQdRxYUBVLp0uWgVMFgnF/VBBO7M+xj4G
         jEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBp/eXV6WyvAqXgKcuMgHNxmCpgbdDjzlvKQbvGhG6nSgRGhth/huSk4xjYHUZCfxiDMRZbBj@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7Vp9UgGWXSEjCEFJBzx6LLTmIgEA03SxEgvMel8lf1koCBxu
	J76rdVuS7iNKaC6h18JzsmfBXNvlHQFGCPrm6Nsgl7kvoRXmAFPghotW/aoMFGc=
X-Gm-Gg: ASbGncvQHnThGEeOlWv5GUJXLjHPTlnilcXLNN26154i93uB0yAD321yQPXlRJ007gV
	OSePWCZQ4834uu4HhYlwaeDOT1SI5qaID6r+WL9zdTjKwOnFgGwHf8c7Y8IFVI0qkW0TqEs4jg5
	EbuHFqe07kSTS6WRiRnQuhrb0lRJ1eJLW+6iaMtXVCoJvsXii6nC0iPRGwwqVgXE96PqJs/kP+B
	yG7C83FAay2Mngw3hbuGLK5H3mbIowSR7Um4y2qIBo32FjQD3LjqIegP9113gf7UKcky4mmaCh8
	7xS6b6lN41sTciC9nEgMzgg+ZW6HswT9mDj/6Hj78JZ7xuMlOpE5R2dQVg==
X-Google-Smtp-Source: AGHT+IHc9+xcqKfnS5TtRa8ckiUJWDR/Q3sVK7iLIqV18S7EGnZzlO47g3UTmwdBkNHAhiFPjh7kpg==
X-Received: by 2002:a05:600c:1f86:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-43ecfa06ab0mr424785e9.32.1743703383971;
        Thu, 03 Apr 2025 11:03:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec169b8a3sm27842955e9.19.2025.04.03.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:03:03 -0700 (PDT)
Date: Thu, 3 Apr 2025 20:03:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, 
	Rik van Riel <riel@surriel.com>, Raghavendra K T <raghavendra.kt@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Chen Yu <yu.chen.surf@foxmail.com>
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task
 migration and swap
Message-ID: <ufnmsikyh6budl4qkhy5o4m76yldvlns3yja743bdwvxwsljer@ztbsqf7gx6oi>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
 <7cbbbd8f-a4b4-491d-bb60-97defff6007c@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmo6hhl6vnnkdo2y"
Content-Disposition: inline
In-Reply-To: <7cbbbd8f-a4b4-491d-bb60-97defff6007c@intel.com>


--cmo6hhl6vnnkdo2y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task
 migration and swap
MIME-Version: 1.0

On Thu, Apr 03, 2025 at 10:47:44AM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
> In the context of NUMA balancing, it would be helpful to not only monitor on
> the activities of individual task/thread but also the resource usage and
> task migrations at the group level - which helps us quickly evaluate the
> performance and resource usage of the container - like per memcg
> numa_pages_migrated, numa_pte_updates introduced in

Somehow I thought that these are the useful metrics (amount of misplaced
memory) and the aggregated task stats aren't interesting (they'd be more
or less proportion of total number of tasks in the group and you don't
know which task it was).

> Got it, will do in next version.

OK.

Thanks,
Michal

--cmo6hhl6vnnkdo2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+7NUwAKCRAt3Wney77B
SXyAAP9zRNbWyXvRY68kwReBWQwU+IWj9P0H4vV7txVVj+beHQD/Vl708/8cL+7h
OSXoRbmFYGoPx1rHTLM6MtQrJS4noAA=
=Vpoo
-----END PGP SIGNATURE-----

--cmo6hhl6vnnkdo2y--

