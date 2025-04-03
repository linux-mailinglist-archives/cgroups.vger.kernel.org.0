Return-Path: <cgroups+bounces-7336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF5A7A8F0
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 19:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBDE188BC93
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED22528EB;
	Thu,  3 Apr 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N8XjXlR1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431C2528E2
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703063; cv=none; b=phj1zzFk5iMfyTIKJPNZDyWalnwyssmPFwGkdyUB47G1gBSM5pZ2Nmmre1hYuzPdI6S4gu6dq6GWJNRUJr8z/O9c7Ggj4MISo/1DKht4QMXEEJBGGacC3mk3PTqA3BLdiMJ5lYYa7/O5N6hyNQMjsM9x4GP0kiyvAwi+YLum1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703063; c=relaxed/simple;
	bh=aQe0dG2t2PdKaMN2uEpck+VEDItnqutZ4+rHhe9oGz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODZeTrh0NRG8ANGQoJSjQbBOGF0BIensiAqYWhAfbUpxILz2YiPMcqONOm3Tmv+6siJMH5oDqRNW4u04yO9g2QRbJwQj9UkXKRe/aqyFCOgiEwtSjH6VbP+tMS4S6oG8CkYsHLe+tkkQMoNz7WIb2fdJA3P6PCWjdftt8mjXTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N8XjXlR1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so1055498f8f.0
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743703060; x=1744307860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQe0dG2t2PdKaMN2uEpck+VEDItnqutZ4+rHhe9oGz4=;
        b=N8XjXlR1ESCMMPQdngHb9oJDOykJPsAndSIDLpxDnmHkwZMzVlW/UijEZaIHszsu6z
         1FRGCmC6gZpjIvJ1kCx6jQe4+gzVXTIdtmiMNv7Sih0tOvPMUo02t0zOtkZY2EumWvfX
         kil7Yqkg6p3M4sp1+Vs0aYw/pNlQ/p3/nGVHZTNTFsJOW5tbLfJ6FJ3yyJojDwfEZtvf
         zoorh7tD8kIwjUWTLOD+wNJTe2rbcM41ZHiZKXvroGXIFhhhrGy/LujGzQAUiB0xyuo1
         jGRTcSz2UGQE9AW5USCbN3r8d9JincYfy4EuBCJ1E7fG2YTo5Q5pMW18YK1/KhSssO11
         QqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743703060; x=1744307860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQe0dG2t2PdKaMN2uEpck+VEDItnqutZ4+rHhe9oGz4=;
        b=ugwaTP3QAaPmzcfq6HDDApUGKnICEQRXu9FcgFap9lXskOOsIBPHSVVoOvsdCZ+rMV
         TlkVwu8rhcQ0wkABcYxgjxh8Mp/NPiRM5ygaPCntTCPzsNTR8EPGXGasHjncGC6Cg/b2
         4Z67bSyfGXq5RWXK4U1nQIykI+Fq/ltBqhhP1oWrhcBuaLGwixePjR+ScJuyGtA39j6+
         IeuFTsWLb0ZPAz94s/6vhz3uI0QXfabjqXsADC8hN7RzbjeFeLzmNBviWQrtHVDElsjJ
         e46x2bQt3xjuCrdySWEUG1x+bW+maXEs4sVTndTgXSznjvamP5lWgSVEDyOIGjEp+Jvz
         5i9w==
X-Forwarded-Encrypted: i=1; AJvYcCX5oqoem6QG6qBRQLQ2QbFF17Iq8ngFCjC8u4gjYT3uV06IHfv8sifpYh548MejlJBfKkM17B0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy30GbR+GqlTiuhn6XNRvS6RPOfA34ElUlRwUcELhpsdX6Ql5W
	Vae61Pr3mF9nUzTPIzaj2md7HpuT+ZsoxIYgjRjf/VuU4oZeDHplBpEXaOAqlmY=
X-Gm-Gg: ASbGncvzSe3hKKMix39yq7r+I1xvlCbUxDUvA6DghoPma0xFw0fKT+FBqEuCTo53VPy
	cIlqI9njAO3qgmX2+qkp0osUYgGH/xoUx1/RfLYP9uNTnSUZLI0vocmMo2J1zOAyhBBY5aWl/Hd
	LH5yWFe3j6H+59M/+vH7eU0AI+K6B8kXHUHAVjeEsztTCdspCo17Fo3wus5RTk+Tr2OJKDvzJ9Z
	RLbQWt0aRNX8EdgAdLWVTGcq611FPSUWQX1JNzc7CeSJxy+f9gvP2O06BfmhbY0kXgPfIke2fbc
	kza9s2iieVo4aygIkRLkHjfpQN8Q4I0FWeRT3v84m/1x+Ko=
X-Google-Smtp-Source: AGHT+IGGLzZEpNqM6rKSLI7qiGvPhUOyR8Me69L/N0NVms1TUpJkn/DB/jchypOx5p6MFN/+/u0KoA==
X-Received: by 2002:a5d:64e6:0:b0:39c:1efb:ec93 with SMTP id ffacd0b85a97d-39cba98b7edmr195916f8f.48.1743703059686;
        Thu, 03 Apr 2025 10:57:39 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6ae5sm2415661f8f.32.2025.04.03.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:57:39 -0700 (PDT)
Date: Thu, 3 Apr 2025 19:57:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Rik van Riel <riel@surriel.com>, 
	Raghavendra K T <raghavendra.kt@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Chen Yu <yu.chen.surf@foxmail.com>
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task
 migration and swap
Message-ID: <rifx3cqihmywhslbnpy6ge3pvl3acvgaasxvwyurrip3ewljnn@xqb4lex7xpsn>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
 <7710c312-77da-4b8d-bb80-74598433ecd6@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5inkdjfgglli4fgy"
Content-Disposition: inline
In-Reply-To: <7710c312-77da-4b8d-bb80-74598433ecd6@amd.com>


--5inkdjfgglli4fgy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task
 migration and swap
MIME-Version: 1.0

On Wed, Apr 02, 2025 at 11:13:03PM +0530, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> The /proc/$pid/sched accounting is only done when schedstats are
> enabled. memcg users might want to track it separately without relying
> on schedstats which also enables a bunch of other scheduler related
> stats collection adding more overheads.

.oO(memory.[numa_]stat could end up with something similar since not all
users are interested in all fields but all users are affected by added
fields)

Thanks,
Michal

--5inkdjfgglli4fgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+7MDgAKCRAt3Wney77B
SSJtAP9y+6MLacyhDdxgIDeSpr9nE4pWSv811LCHFbY5X5xYSgD/VmDhJjTHW9mf
2qZ9YjklpUmxbrQuWSOTeWSJ/KvBug4=
=XD67
-----END PGP SIGNATURE-----

--5inkdjfgglli4fgy--

