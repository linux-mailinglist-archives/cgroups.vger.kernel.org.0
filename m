Return-Path: <cgroups+bounces-7296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A629BA78FA9
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C49316C40D
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6A239573;
	Wed,  2 Apr 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PecP5oMa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7644238152
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600290; cv=none; b=R/BDO+/xsc2ioneJyrmTNSJBedLWpYw3JxVbO/CjuKbn4WxWPgQ2Px3HsLHvxJZ7TxHc2ziVU0QK0P5LM4ge7+Jqx3SYn/asHJOMfqlLHOxkhkNo4Qy5MR3H5JXx9vPATV2LXfhML2CnAd3dByfoeGa5PVvpv1sa8DBI+Gsp2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600290; c=relaxed/simple;
	bh=pYbm4oKrcbp95Dq1PTEEfwDfRZYpGx1EOdUtHv6e53Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is6tLarFYAQixjcjTteSbbphxMz51j4R2rg4XDrJlyf58MtQSCTQCE5C4DXDVjyIKE8apdJ+QPxisUKAEdd+JFbd7IuMT4X+4ldkX4T9kL1vqFzvnC7Bw8BJjb+O3n0N3zBGzAikPAIEIqUyQNUX6rd/UC+lFbBAapy3VShO4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PecP5oMa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so62812585e9.0
        for <cgroups@vger.kernel.org>; Wed, 02 Apr 2025 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743600287; x=1744205087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYbm4oKrcbp95Dq1PTEEfwDfRZYpGx1EOdUtHv6e53Q=;
        b=PecP5oMa8dowBg7EIkbM/rBwG1X7RkPAorXXoX7awMVINPcgk0Kpgr+YvwO8mdgmsc
         KTzuaRZ1R2tKeJ/leN299rSfYWDWyPku21Awh/ild1mpuC87+Vr471mitfeCLkZ155Xx
         rdmgEaSEioo5u0s0GaDlryIjkP3ejBNivSHiBtBW4WNimT0hfC7SFbwHc4J9hyJ1utPe
         YCG/k9LjUfq6gr04FPPbiizOhEvmoJkApvM/vpHYuVFLn5Ptcnvhd4Ce3mQQAV9XSg0r
         6UU4l/T/gY1llzpBEpBAzco0w3xQBd5Niua0c5KtHZg0Qf9SDjQ9drHuwotbmClPT+jP
         AKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743600287; x=1744205087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYbm4oKrcbp95Dq1PTEEfwDfRZYpGx1EOdUtHv6e53Q=;
        b=o0byhGxCi7RkTNPR3td8FYiWdtElJRWT+D8rNWjfFTyX11CrtiOnMpINuXx9BpNftT
         0iEL08izRYv9c/jcD/BGHB/uhHje+STbCxKnw4uqyao0GvN03l12qTcbpLz2aNoLa3Hu
         2i5Dfc7DCkQf/41kIAL8fe0d/3XM0p5ESfdKgEcZkEIUKIgV0dTODAKnH8R2wA89734X
         UjK909DbOyXKNIsq57Lm6HKkIWgM5xQQbdoFETG7rRtoXf1jPqgkHKCypeG3zJN4e6f9
         AFnu4InZPdZKllq+7PWcfyBwED1p60sHzqrQEE7W8pN/0orkY2zeCgB5U4F9KaPxmhAT
         vQjw==
X-Forwarded-Encrypted: i=1; AJvYcCXBXrslumtvd3g/fm2YW7j84gY1DN8sI2UVJJL7+vXQsVBgHN2iKG8CvfEuC+PdWi5nNeiA2RFQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sUT1OiAn5US440zdr5dlsdx9kkSeLGvO5gspCxacF+ZijFWU
	2nRsM44lj96ULlAH4mRHA3VMyMfoQQxZARL+qqftlywSc8OG3CZwX1HeqkHonQY=
X-Gm-Gg: ASbGncvaFSqXvHqa+z9ZG4JCQ0zKWlEK06aBBpepq0HFHkNDcQLsfrmNy8lQfI1nBpT
	qcvqYjKB8Unpn+dIG/hOBnwWJhd7HumKbDH3ATn7wert1Op4fFS4Y6EjidirCa5hWbSCIIkAo7t
	HnR6BrYhLQ8FAdtZOgct0ohgl+R72O6kqfYq8o1uz4BPDwQ8nOEBMhzBGl6rKBDuLSBxNSWzvi+
	qrVdS/O9JV8QvZi4p1JMEL2r1MExHmGEfChjXmpw2S0F0CK+YyEKFfLvFFYP/q4wq79jic79P5j
	47Ef1YyN6CvNSfAKBvHq348kH3fU5aQb+RgW4XESQucCs5g=
X-Google-Smtp-Source: AGHT+IEkZXhkt4dJXs5ZW/Wkxvhp30py7B3KBHkoW/nccx47rr6X5SfhnzuAV8/c487Johxbo/aSgw==
X-Received: by 2002:a05:600c:1f0e:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-43eb5c29e54mr28042485e9.15.1743600286855;
        Wed, 02 Apr 2025 06:24:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e467sm17067309f8f.79.2025.04.02.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:24:46 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:24:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Yu <yu.c.chen@intel.com>
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
Message-ID: <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tucdzeycj4q3iyr"
Content-Disposition: inline
In-Reply-To: <20250402010611.3204674-1-yu.c.chen@intel.com>


--4tucdzeycj4q3iyr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task
 migration and swap
MIME-Version: 1.0

Hello Chen.

On Wed, Apr 02, 2025 at 09:06:11AM +0800, Chen Yu <yu.c.chen@intel.com> wro=
te:
> On system with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful.
=2E..
> The following two new fields:
>=20
> numa_task_migrated
> numa_task_swapped
>=20
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched

Why is the field /proc/$pid/sched not enough?

Also, you may want to update Documentation/admin-guide/cgroup-v2.rst
too.

Thanks,
Michal

--4tucdzeycj4q3iyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+06mgAKCRAt3Wney77B
SW8CAQCXwIcQIqtvT1iWJCuoc6huUPtKvhF+cl6qPbYfLvIufwEAltSTP9q9VKKA
ptKpUW0AUPlg9fYltaInQYPUopxCJgk=
=/Gj8
-----END PGP SIGNATURE-----

--4tucdzeycj4q3iyr--

