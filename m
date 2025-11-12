Return-Path: <cgroups+bounces-11867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80AC52B55
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 15:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7058D5031B7
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F226D4CD;
	Wed, 12 Nov 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RcnkXanq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5625B2FA
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956138; cv=none; b=MO8/Kw7J2Swa4BZxJbxsX6VDRpp8mn6CvmQ4bgWTq0AiyuDCDIGWDMk9iNQw392KJJdEXemwJHtSYKgIcVG9z9LrZfQoejhErGPQSbo6cEx+GHA9VwIiBoofBUEE/HZiwkxG+nADSMYZhCmRuR2lnj9yMTt+jMpIyYksYwecr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956138; c=relaxed/simple;
	bh=SlEYDOScQZNVr1WYQjXUJKiqkkseqZPjckRYMu3nBoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIhrgVCCCGD8hMmlimr1lXk6/+ynHy+qYupj/VFMnk3rTHPX3OWXY6LI8P1Pky4pUo9o4z5lxJ9SuMTaNhtXOe54H+wpUuxH5TDabDUoXqQU1HqJRJsltTT/p0jQErEyFWMWaZJ1gu0YQ1K6+Iyn9aWoXpd2pD6GpACZhVmATkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RcnkXanq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so351509f8f.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762956135; x=1763560935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97+x+h8dQ4e8GUTjDZqoRrL1FA9+Qvtg5x2caP/F8R8=;
        b=RcnkXanqGjT8Whv4CCstturHR4uI5lkDApZuKUjhCQQ1GvnH/AWDLvN+8blXno9HBj
         uD43U+goT9He3rHbTnqXwmRB/QSEQK2hf96/xJij8GxaZdrR24oLPcFSOcurpgj7ynQr
         mMVHKgPMFxdw2HaBPDJIXxIeCs2Y4/FTpIHL8LJkunWvmHtvrD0+fYoXnMd8hdlWDcvM
         QcABsylAuLD/yp47dQVLPgjy1QNsJ9Xe0joC173EH9DJ6f/w2o8qppdE5EUI7wFfPH5i
         u2vU/JNPh5ICSPPMtaz8QZRsnJANH8M+Jt2L/6zmIDo8r39puVR7U0y4lC+dXDNpsmE2
         n3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956135; x=1763560935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97+x+h8dQ4e8GUTjDZqoRrL1FA9+Qvtg5x2caP/F8R8=;
        b=j9leqS19ocYU8QifsEKQp4/0BqPXa7wKjVmogjFB5u3xoo4EBPeFgEuyFDM73o+a7V
         ei7Gm0owwngpqGEfjFJVyqh/DmF3ORki9rttEr9UH04S3dEcgXRb43dBfb/g5pgTdfri
         YN2Jz7AjpeQOKf6Y+7ErYH4qXwqLeSSL9Xymc6YLqK7aoMqxtDBFr+3vCt28iSImY1rl
         GzggwdwLCa6lFlCzuXJLvAxtAAsYjmoMlWKs8PrNUWNWDfzDA8/GUyKHxy3c5p5f57TI
         N36L7lc3mBdRpKa/3/Wa17UwI7pRuvwoxHi8kR1nyuqOmE/4RT/kLYxT+Mtl/mubfs6v
         MPiw==
X-Forwarded-Encrypted: i=1; AJvYcCXb38uRYEPzrIa1RRiN/hyCcYSzVgneOdGZOr4I6Vxsho/XwvdQu1xUYBA6GDhJoWP7EwWKIHJm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42bZGd1Fir81lYKEYi9RToTMEZDQku9YZ0IOQDyi+vJF/3W4D
	EmHGn9uwQbbng5d9RV4971t1bkD8mwdAJMJUAhBRLSR8oi8Xq4g3VFact+yfKSqZYPE=
X-Gm-Gg: ASbGnct1oQEqWuCI+ZoP7AanNGY6nH0NUZzT2ZngP3obu436mJlC9/gYz18QlYSPkCk
	BXuJdapF16g/NyRSB5hcdpjm8qwSm6BqI7MRB59q0w8t5lThDGIVR3Z2IeOf89/nP0m2ur0axpO
	lXvHgyzwo+6uWV8WCSFRDGlKPIc9s0nLqdF0BF6ZgLLB8l7zP4mOwMbrE7LRCtSQ1VqjzkLsidp
	UPI4FA9GI2MU5eGgqgBNnHfPhb5MNy1MyqrefpKJnEhdw/eBtHAvzHJnI/J7WgCUfFqMMsuGCNB
	SVSQdepYmzh7PWiq1G9E5HSOjH9V1g/LBhheqBNYPUj2rpAI/SFzLE/TGubqBlXAlzADlUMh4nC
	QWYomRL7Gbon8aDHJm6Mfm3JoEN3dYX2HCoH9CD6qYnSco5+iE2WKVsY4zk9J5/y7a1s8lovK7C
	U8SLS/OnEN4s1esz4CjzUc
X-Google-Smtp-Source: AGHT+IF+oB8mjrQRe5QSu7EfBjAysEQG22PZLyD/6924dtA5Ki8nSfNI1qTwkRcog78mpQsXY/aLvQ==
X-Received: by 2002:a05:6000:615:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-42b4ba81c5fmr3242633f8f.23.1762956134571;
        Wed, 12 Nov 2025 06:02:14 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm38723673f8f.44.2025.11.12.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:02:14 -0800 (PST)
Date: Wed, 12 Nov 2025 15:02:12 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, corbet@lwn.net, hannes@cmpxchg.org, jack@suse.cz, 
	joel.granados@kernel.org, kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <chffrjnr5ebky6aytx6va4lptu7mbxclmzqvzdnjwa6hrb7fzw@ewpebokeqfzs>
References: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
 <20251111064415.75290-1-leon.huangfu@shopee.com>
 <2f43bdf7-5ce0-4835-9e60-39d91f637152@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrv7ktcycf6a43eq"
Content-Disposition: inline
In-Reply-To: <2f43bdf7-5ce0-4835-9e60-39d91f637152@huaweicloud.com>


--qrv7ktcycf6a43eq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
MIME-Version: 1.0

On Wed, Nov 12, 2025 at 08:56:28AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> However, this fails the LTP test quite easily. The error logs come direct=
ly from LTP. The issue
> occurs because the threshold isn=E2=80=99t reached, resulting in an RSS v=
alue of 0. We tried increasing the
> memory allocated by the LTP case, but that wasn=E2=80=99t the right solut=
ion.

You touched on a slightly different cause (other than  async flushing)
-- there are other fields/stats that are quantified by (basic) page
size. I.e. I think that might need different/more central solution, e.g.
working with absolute (not relative to pagesize) thresholds if absolute
precision is needed.


Thanks,
Michal

--qrv7ktcycf6a43eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRSTYhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiSagD/WULk3YU+JZ1RgyrGtBcK
Rk5AScqXYcflK31hxM9Cw9UA/3e8l571U4YVUYXkPQ44w97Y1nTKbxU0rJ7BHri1
sywP
=pSJv
-----END PGP SIGNATURE-----

--qrv7ktcycf6a43eq--

