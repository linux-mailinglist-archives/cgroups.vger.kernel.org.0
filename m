Return-Path: <cgroups+bounces-8556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691EADCB1E
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7F188E9DB
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184E2D130C;
	Tue, 17 Jun 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/dwLbdq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2B218EB1
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162993; cv=none; b=KyA6GGKYn0X430FFxuBIdQLa+TuTdPI/8Y9yct8XVleaBlxdVv6cI4ehHBQkcJHRjnDEUeiCc+ghTuCpR6xorEuCfDvQM2WLx+otdz+UJFMV714FCzrjNdyo8nqakPFy6jPIS4T0U9Ct6hy/X/gQ5wJJAxGWjhOKntsN6G9oZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162993; c=relaxed/simple;
	bh=qfKqs81FRx7r4u3rTvzSKZpY15wIyvtyPSbbF+hvRF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYf3ctSINmeqqT40N3AbyWBdeiBT0ky5OHZZe5L01sUAXhhkUwI9Scp5l3w+zml670TV+gOFJi+ookP8wlWID2J/Ut6FflHkGbGNpBe+zx6pQVPFn2g6cVsipcGXGY7EJ9tM67RTjttVtD2qD2PN5DrUjJ1+f6oxBECHihZ77Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/dwLbdq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so46894495e9.1
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750162990; x=1750767790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21Go1wj0x49xdQOFnhkIKy1MZpMdJcDxWBqyIqwuot8=;
        b=O/dwLbdqRgCV3UX2tu9kiKgBGCP/E4fjWf1QSnLRmIcZQmoYGp0H8fMaysIIgMs7CJ
         1n4Z3+6xWyMYLCZ9a7xwny70dyFO80upCi01Mj7Zh+l1m+6ooD0xBv3X3gZ9ybkznwf7
         os8nGbe7ZDgCmibH0nNRBxPeGs8CFvoiiISGPlyEd6fUP2hCIuDXbfN6ddhquaUdqstK
         /vmTHrle/HN0kSf/vTWJZegMfIiEivlxmpefW3b0+mWcFL9aoFKKK+f2BW/+HJ4QesHO
         CHdV9IMCF6IeXyZB9ukF3130V/epTCBA55VoQLQ22zAVProNQMOrOJSHhHTFkLg+ztnw
         k5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162990; x=1750767790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21Go1wj0x49xdQOFnhkIKy1MZpMdJcDxWBqyIqwuot8=;
        b=osVUx+EG1BRqsfHf8oPkrN6OOEse63sT+/XPag8Bgd0NzFhHJlEh1JejTqx6+R4xbP
         dM713UvCBqaeMNsiuZD4tPqH1vjfnEuZmvKmRo7e2IB1aAV+1CH8AZoRIGThKfc/1iaF
         xQ7oqUmwpE7O8Iw4YfNPlq7Uq5aspuRMBxl9jYH5xb1zR47aVMjVBw6g4+wVteKU5Ler
         AHWU9Q/UYXbz5fom+RLz+KoxJYex9km8ZpE+rkBzlP1OmnkdOF7a79bcVGow6iay+JW7
         TNv9Xzhuy/a4g1Af6yFHINeE3AeQsuIOCULuHKUj5LCBR4rMcivrXHqc32PoWdVfj+tq
         OpGA==
X-Forwarded-Encrypted: i=1; AJvYcCX0kuJQgs2ovJTdKqRwtTU4rGjjmOKAHbbynKdXYLO0R/KVwzkeU3HSTDyUkQJN1p8kgtEdsYLv@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLCRYZmuHz2RVPS308x1qGcZTbaBZMMEIEVIXb0gOUuroHfo0
	s1nzpPHxCexfJOLoioWZtxQpq+6WUxwadFkLT2/XpY/k5DHhUCLRRriPqhIiuMuZnOo=
X-Gm-Gg: ASbGnctQR1CBb4OLzOzHerBb68RvDzTPvJaHjxe8++N8d5sCpvSOTgViwz5q5LV8amm
	GTDQQMrKKY9x4wd5IqKbxiDRobCA+6acbzkfGMaiPI7vW9Ipbt06N6EUO5LNP2bI2/QFLgUUAGm
	xXasF8vfBqsHavJ5GtdUOez4n28Ll2LDzGo+cpN0LXmL8UQzRCSQUk1OFqZXUUDn8g18eS+c/Kk
	9BPrlf0qagZSbKdEg6ODDU5rVUQKUUEYt3T/OkcsQbvqRNtkGoPSDbh2gRLOm84pXD4CgagwlYI
	vdT0BB8uqkHjIIkPbJuwrOJz/MaUDAGjMRL/k4yBXBI977lOKIV2oTUaCrLKvIeBZkfKDJ4tynA
	=
X-Google-Smtp-Source: AGHT+IHemldAx08RKX+2t2fiuYieKOkNAzOmNF3+c2oFhTT/lpYZSkgPImE52/XFg7cSXUZMXu6Gcw==
X-Received: by 2002:a05:600c:3587:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4533cb48951mr120152275e9.16.1750162990026;
        Tue, 17 Jun 2025 05:23:10 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224617sm176822635e9.2.2025.06.17.05.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:23:09 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:23:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: youngjun.park@lge.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxa6tdutywia4blb"
Content-Disposition: inline
In-Reply-To: <20250612103743.3385842-2-youngjun.park@lge.com>


--cxa6tdutywia4blb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
MIME-Version: 1.0

Hello.

On Thu, Jun 12, 2025 at 07:37:43PM +0900, youngjun.park@lge.com wrote:
> Example:
> cat memory.swap.priority
> Inactive
> /dev/sdb	unique:1	 prio:10
> /dev/sdc	unique:2	 prio:5
>=20
> - Creation
> echo  "unique id of swapdev 1: priority, unique id of swapdev 2: priority=
 ..."
> > memory.swap.priority
>=20
> - Destruction
> Reset through the memory.swap.priority interface.
> Example: echo "" > memory.swap.priority
>=20
> And also be destroyed when the mem_cgroup is removed.
>=20
> 3. Priority Mechanism
>=20
> - Follows the original concept of swap priority.
> (This includes automatic binding of swap devices to NUMA nodes.)

How is this supposed to work
cg1     /dev/sda	prio:10
        /dev/sdb	prio:5
` cg3     /dev/sda	  prio:5
   	  /dev/sdb	  prio:10
cg2     /dev/sda	prio:5
        /dev/sdb	prio:10
` cg4     /dev/sda	  prio:10
   	  /dev/sdb	  prio:5

when there are competitors from cg3 and cg4? Which device should be
preferred by each cgroup?

Interface note -- try to make it "Nested keyed" or "Flat keyed" as
described in Documentation/admin-guide/cgroup-v2.rst (like io.max or
io.weight), so that it is consistent with other cgroup v2 APIs.


HTH,
Michal

--cxa6tdutywia4blb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFFeKQAKCRB+PQLnlNv4
CM9nAQChEzdekCNE43fNB7rnSRjzNssuFzuex9JUVSGIfGo09QD/e/YzVdE7mQ7l
29U75wiBDcAwyoo351mIl2azH41iKgc=
=C+Kh
-----END PGP SIGNATURE-----

--cxa6tdutywia4blb--

