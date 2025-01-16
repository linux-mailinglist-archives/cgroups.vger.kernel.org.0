Return-Path: <cgroups+bounces-6193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B236A13BA8
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050D2188D57A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989B22A819;
	Thu, 16 Jan 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dUZa7aX8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06722A1EA
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036337; cv=none; b=ubTGrsBSTmhKvo3mKM+grhkk0wm9m2rykHj4h2EAD1toZdo2QNWXbqAynl3j3s1bRtUWqB9BJzZB26KcPfA8FkRY0boFqrBPJiHIZtNRmCG1pgF3kiMGUNQsLUKQ2EqJBaB9OlX57uHY/BvJ8aFvPZUesZm1vjYW6ZJ594QYD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036337; c=relaxed/simple;
	bh=SyqUeqqNalXA8XJghIn/qhfro0ohuCVATanAb15dvkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBtNLu0LM4/DUY47p7uP65JTkE471YK3ZjzX2Il2i7CsgoFL5KqP6FSFK3qUxWOjBB/kYS52/2nRuEUPc+q8c8XTg8hk93BZIXFhr0c7qvsfdaseMLHCXbN3v8UncW1m56fGhVJlGCVbvRtewNN4huXrFQVK6PzogzQbLHcQHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dUZa7aX8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a34e8410bso522317f8f.2
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737036334; x=1737641134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyqUeqqNalXA8XJghIn/qhfro0ohuCVATanAb15dvkw=;
        b=dUZa7aX8iE2DfGljYeAO9PH01aYS3aHQkU9gjxGTbI+E3rPTXhjkmICqZQWqZYdhdB
         nTDnDAKUkPSaTIsw9Qhnryus21FLWVImBooXcfUxuqi+X7wOkk8i/Q7viZTiyBA15akB
         3PWJOnAmboxwZL50taqX4PW0XQ2NkgA1pqwN/MZUsS/HnBJa7e7jOk9pC+btk3STkSA2
         DSUqviE3QrfSqLOr3mWoEJiwcQKx4mYs5LVeuGJx+Ao6d2lgeLH2apA1J2GcbNlnfXvZ
         eoxqUByqkvljsxsQ3CALI1rHiPN9LRSD0G3lIYCHTfJGnwJ+fuFu2xYMMz1oFbVWauPv
         iU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737036334; x=1737641134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyqUeqqNalXA8XJghIn/qhfro0ohuCVATanAb15dvkw=;
        b=gHhBy0Bdkwj1IpXuuSWR+eIXxwWqbBDRHikmPyh8yqkJx5A8UIsUYko0qfZjV9pwwz
         biEf5iu1NN97P+kjXv+2tcXy51J9pgC/iz9qvzKijf1YXwRL4wZ4TnI1JdmzErqSiGVV
         pHhZEjvL79Upyp6kPXBCSeBCYiUvY5RMWQbidw3VD1K3nfZU9F/0Tsq5pIKAfYzxbCKl
         WzG4QzsxugoTOmOCBEAamHIrnfjun1/P7zcCoVVUh6oiyfyWsSyhLy/A1RkWVQMeHqxH
         q1MrGaQ+u+vp9n1cOwSDukEyRjhaHDd2E6CJAJxBD0KJCMm0vKgjvhGXD8vVj9Ewt8mb
         JnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhRmMwGLun1CiM1wxmuRIRsY3ZXQ/CT0CNvH/SJ3/yISI+NrifflOrLlljaizu0dvYD26U0N9g@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxvo+TC6gth1vOt1pCSAe0I8j1myJsHGxjDcrU35txT/Z+89BE
	8fLRHAN1GhktJTBL8OUybO+Uw6TPoyt/Wa7mdRVoVuNeFlslxkAQigXmy0OP6zw=
X-Gm-Gg: ASbGncuGaV/jyJhEwiq5uIfKJ29xIhinGsO+g3fT3Hg1GTc9+moFFtRy+0KtjdwAa1M
	vBBAmQ6Yd6VzjnMKNb/Uxk9NiesCt1o49c3NS39MGjUFVv6/zSvJf5SjIJz8zglU4yUC0LsSNch
	ZLUTamsMXUMRJHJTxtO4PtgYH+ueRyRLs0CSXYyX5PB4SZhhU4ulP7Nz/EsVU2bfTXYgdHNZM3Z
	i1nactVzsq2sX/9AXWljiH/0+t2Y6lLWTY56F0vCBbfbPIP8JBfigPsQZY=
X-Google-Smtp-Source: AGHT+IFMmnZyKAiwU+Q2MGRH262yXFMAxcYu6K8VMkDZLbxtV2/u/LzzAkknBodqMku1eBIQtjzEKA==
X-Received: by 2002:a05:6000:471a:b0:385:db11:badf with SMTP id ffacd0b85a97d-38a872e1640mr30128213f8f.22.1737036333867;
        Thu, 16 Jan 2025 06:05:33 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3840bfsm20948850f8f.39.2025.01.16.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:05:33 -0800 (PST)
Date: Thu, 16 Jan 2025 15:05:32 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qh6gjs2cei26ojun"
Content-Disposition: inline
In-Reply-To: <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>


--qh6gjs2cei26ojun
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
MIME-Version: 1.0

On Thu, Jan 16, 2025 at 08:40:56AM -0500, Waiman Long <llong@redhat.com> wrote:
> I do have some reservation in taking out /proc/<pid>/cpuset by default as
> CPUSETS_V1 is off by default. This may break some existing user scripts.

Cannot be /proc/$pid/cpuset declared a v1 feature?
Similar to cpuset fs (that is under CPUSETS_V1). If there's a breakage,
the user is not non-v1 ready and CPUSETS_V1 must be enabled.

> Also the statement that the cpuset file is the same as the path in cgroup
> file in unified hierarchy is not true if that cgroup doesn't have cpuset
> enabled.

(I tried to capture that with the "effective path", I should reword it
more clearly.)

Thanks,
Michal

--qh6gjs2cei26ojun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4kSKQAKCRAt3Wney77B
ScqIAQCzkakWY9O9Baa9IRWwgzOyc+pYIDQ9Qm+SjE36UHvI3gEAuHJPHJ5vk91z
Zl3CLStzVag2VR1Q8Kw0AKGzAV4ELg4=
=ebgC
-----END PGP SIGNATURE-----

--qh6gjs2cei26ojun--

