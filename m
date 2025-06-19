Return-Path: <cgroups+bounces-8605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B731AE083D
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCED33AC098
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8917278E40;
	Thu, 19 Jun 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LzSBQ1pv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FAA269B01
	for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341972; cv=none; b=F+0SpVZPsvEchsbFi1MrAiReriq6KqOUQiMRdSHM6wppnUZsnlDRiuGVW9/f9sjGEB4S8/SMGj/dh7NnIioZir+9u4oiekysrWIIFOH/aIZQcQCZT57ausvmLScdsTVipirMm4nF0kBPVZpwXHkoxSTnmiAf8KN4FeHWXKARguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341972; c=relaxed/simple;
	bh=TrQEbkPOhkr+wXxKi4QhmQRGh+BqEkZVvBvjASyKlYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyovka8O3XhAmRgdY76x6uY5GzWrnPSZStd84uInIP8ht6OpXWsKDmuu7v2/hWhxVPeAJkLOPqJutNYnd9Ex3Tx20jfzpoWfxWZ2w6Nfch/iAD9AzH4VLcZAbeWfGx0wJTzmmG6k3Swo949MsrL3D3d+6doZeNPARkeq4ko5UzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LzSBQ1pv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a528243636so556833f8f.3
        for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750341969; x=1750946769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrQEbkPOhkr+wXxKi4QhmQRGh+BqEkZVvBvjASyKlYw=;
        b=LzSBQ1pvPgzNdC/ZTrW29Q8bKLmiCf5MiOHKd+5V0Lp+MVZHSdyYZh9I37uTNd0q1v
         PH6Qd1J2dhu/QQVF+xqduoqOqUgmDOw4XYaWAWNPKuPBlXoH0EL7jmhLn8AcQcxaPNU5
         DGbmXOKQHlD2uFp3wquvtvaN2ml6joJCrUBxszl8pkujNvZ8MurKFbFvPBuEnnMcbQIt
         y5M41RAIMMIK7SjO0V4IBRwzCY4z5AY0qRaQmofoEnnEvYCdVW2a9DxJDzUkEUF9vc4g
         2epwphggVRDWkyTKfUpAmKYAfIpllRUy1lnRcH7omAR5kr0VdbP7vNStOtEfNV4gdfU4
         K9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341969; x=1750946769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrQEbkPOhkr+wXxKi4QhmQRGh+BqEkZVvBvjASyKlYw=;
        b=VrRVFg/AFCJ8UrihnG7DdpRhB1BNpG3W+SsQ68SZ3WrogP58GBRClEVmCDD3fLII3p
         aORmI+u8uoEzEB9TK5HmxUOIIBn+5QzvALCU54N0IWWmhPK4A1tOV0hABW/4EaxwwKWu
         JDrK8RnjoQ390DOoK5Fvk4Ito3fIbDJPc+opgfVfjXvXWYLAXNB+H7yNIQieeOfnKGH6
         7w3+vgCRNoAmYMPARitpgYMohj5Emw8DTr2pgN30uaMO7zp/vp/FEHpXU+DFOJDZ6Peu
         yGrdbkNRPDAMSuWtrvs4y+eGRP82MC6j/4vJEJewjBlWRarcxHuUU5RIsvf3/bed3nVG
         shsw==
X-Forwarded-Encrypted: i=1; AJvYcCX9wgRhB4AxWRyqMuDSdqPoyp0EuxEGFrZpRVaaGHl7hGZEsWhhmekDbJTa6Uripm7Pib7n+y8H@vger.kernel.org
X-Gm-Message-State: AOJu0YyRORM1dEFtEBOjVj5+Tsoz4pcI3xwcJV4qhTRcR68aphCzVIFj
	xQpYyG3gq5pu4ex5QX9Y/oDRibxzd/nPE/G/KX3v976J75jpx9+6/SWv+SCiO+0JGZA=
X-Gm-Gg: ASbGncux+teCVlY5YSbqvRA48IzPNNcTNGh/MUMQUXf+xGMDwLjepdhhQLrTGT2CKX9
	UGMD7ivPnv+VO/plkwN1lGGgy9NaVj4AGyLvCevhM7Z7z9YDtIAgx76UJquCBiicOgEK+YIVU3O
	QeY0dx9iFl6MRbKdi3HD5nXbv2K1hsmRyEGJV/+xtgFhuY+IhHBbslwMeqTo6UvDJeY7VIyUOQl
	GYWcMCAxhDZAPqJ9ZxOBCDoub96oaOhp64gBFaLQPF3kGhKoJLJpahbcQkMPyoTqcVtLdt/unDF
	zocDbVI9+egV3E2eIDzW1VD4bR0r2HXCNw97G+w/HBJLTUGHWng6EImU5ImXzlA6
X-Google-Smtp-Source: AGHT+IFYZ5Og/LPrj6v29fVm2BOf1qki8zUztiChQu5TWH5+YhTscmSrBeIdsgN0gGcw2f5/E2TFiA==
X-Received: by 2002:a05:6000:4a03:b0:3a4:fc0a:33ca with SMTP id ffacd0b85a97d-3a572397d6amr15059912f8f.4.1750341968150;
        Thu, 19 Jun 2025 07:06:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e9844a9sm30681385e9.12.2025.06.19.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:06:07 -0700 (PDT)
Date: Thu, 19 Jun 2025 16:06:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, peterz@infradead.org, 
	akpm@linux-foundation.org, mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	corbet@lwn.net, mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Message-ID: <zcabngubuvvlo7ddqhv734nmponyowtrtuerhcee25yk3cqxsd@gkyioppho5zt>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
 <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
 <fpa42ohp54ewxxymaclnmiafdlfs7lbddnqhtv7haksdd5jq6z@mb6jxk3pl2m2>
 <djkzirwswrvhuuloyitnhxcm3sh7ebk6i22tvq2zzm4cb6pl45@t64jvtpl3ys6>
 <c6bfa201-ed88-47df-9402-ead65d7be475@intel.com>
 <h4chrmiscs66vwl4icda2emof4pbhqabpkklpql2azc5iujilm@o2ttlcanwztc>
 <6e52340a-cabf-48db-b9f1-8300c1c13997@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqfju5slh7y3cmln"
Content-Disposition: inline
In-Reply-To: <6e52340a-cabf-48db-b9f1-8300c1c13997@intel.com>


--dqfju5slh7y3cmln
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
MIME-Version: 1.0

On Thu, Jun 19, 2025 at 09:03:55PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
> OK. Since this change has already been addressed in upstream kernel,

Oh, I missed that. (Otherwise I wouldn't have bothered responding
anymore in this case.)

> I can update the numa_task_migrated/numa_task_swapped fields in
> Documentation/admin-guide/cgroup-v2.rst to mention that, these
> activities are not memory related but put here because they are
> closer to numa balance's page statistics.
> Or do you want me to submit a patch to move the items from
> memory.stat to cpu.stat?

I leave it up to you. (It's become sunk cost for me.)

Michal

--dqfju5slh7y3cmln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFQZSwAKCRB+PQLnlNv4
CM3dAQCuYFm+JCgZpwkdQr6jIGP6Ax9dcl0VPZZyVPb3AipPYAEA7ouwjVSo7HYj
QQfbWU/k3DuXFPBdpkExqgZHN55LaQ8=
=gz+O
-----END PGP SIGNATURE-----

--dqfju5slh7y3cmln--

