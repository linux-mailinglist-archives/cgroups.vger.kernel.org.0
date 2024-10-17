Return-Path: <cgroups+bounces-5149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1F9A1CA8
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D182F1F225DC
	for <lists+cgroups@lfdr.de>; Thu, 17 Oct 2024 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE551D31BA;
	Thu, 17 Oct 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5dR7aqu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B501D2F73;
	Thu, 17 Oct 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152541; cv=none; b=nEUxrjOhXZ++TXdI9X9BkCakZiSEMYaCgq8l2f2w35aBHe9JfeeHhfhxJNUAC2NHeG6P4FTeDHbLMbe0Zf5yYChRXkW6SJmXAVZ5AKrmXF0mGZ5a40X3PVKf0svrLejm8UD7Ubaiug8Lt9VifeHRF7j6NVS3WYGOC4WG9CQHxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152541; c=relaxed/simple;
	bh=WgV1yPsQEfLVgIf7sUsDgNd1OB+7mFrwh0VC/JNEuvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJDbOqmc8Sb/Gr3C+q3KrXuIxT3LoZ0nrKSxmw/pJYsLU21Ga4hrbvkM9SalKUGmPKo2Ii3RM43lKsAmY8J4yt/BJF7dhL1MwutjCs3AkoWEI0RoqfYSmMOQxWxtNZSnM7YLMF+yjj62AVour8HiVFX2YS2RvX/JdTfEpGthuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5dR7aqu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso687915a12.2;
        Thu, 17 Oct 2024 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152540; x=1729757340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kMCKUVNZZJ5h5SBjiPpT+h3myf20vmvFyCYHe1J3PsU=;
        b=h5dR7aqu2AOKj0VzQio2C/XD8Y/4bmsU8lLDCffmZ6WCoICSJfOA9EHIVOGEX5fW6i
         Z6yxNQpjtLy6dy/A6l/obBnDVQQvHskvfYtWJhanyZKrTxDJJztCucnzokSszUIf+BI+
         /KjmRiG3m0mBALYKsmnjkGLgY6FPoX4DoFol1+RlBijugbhvjbkGOq5Us6kwwwQynMR/
         29RfdlELWmqlcVpDo7W1gtwNBsjkclyLpMUIaNRT5zFU64opSSmlCJ+dfZVOWLgcGW07
         rJSOMfIxQ7mn566uBFfY0WSbDHQKZRV3NpzOr1ss9x0Z9hY7hBAOrf6nyIMMItMcOsX9
         62eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152540; x=1729757340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMCKUVNZZJ5h5SBjiPpT+h3myf20vmvFyCYHe1J3PsU=;
        b=VkXAV9RuJrWm1ARjGApNGh7uMLPgFVrkQIf5ouhjJVWlmiPVwQ6MXBZX9i8GOouIYI
         52OpiRJKw3Yf2x0rPokjr1ORBU2rKppJqY9g4b5xz4s+bhM0Q+OUPci+JJELcj0wBeY7
         1lvL3DAhT1qXdC+E/NWPKIzC8PZs7iPShfqvPEqP8xtVaC9pQny16E/wkDMUbUYWGTxW
         0j6F06B0U+BZ4EZ7HYOxSTSeaplTCdT1Bg3gFsOmhwXiXhiBMWv+Uk/D9f2vc1rvSvvc
         p+4NGS5NHCg8wfQrLJbbZq/bbEMmZ+2bqPFrs345stSUBuknpPOIp919bn1p7Gi/g9wV
         m1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCURg1ANwDVh0LQu9arxGPTSSNyD6/SGRgTsqCXeuoKm73jZgREanYc5QORHuo3m+zyG9zaedyUkt9HW3eiD@vger.kernel.org, AJvYcCWQe7LtJlKna5r8aDsVxHiYiu4jdAXA3vIync2qdra7a389Vq1FlNELQK0hyd3SrToCG5rHtxvFfA==@vger.kernel.org, AJvYcCXIYJ5xayFaqiwbV4IUr4wFbsCGHjYqwFstOfsIX9xZJLqbVwSjQh1A8ADXCIrC8+JfjU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2aCtEtmwKKTRnyJoFiODPhbj92B/2DtDN+3LqdvIodQDX9hf
	aL4mxoBmawetAk9i+NIoNos2UDeCkO1ScRgkhfr3FlV8Mxqj+qN+
X-Google-Smtp-Source: AGHT+IGvD8b5wJYc30AU/sUF2r2o7tfDCtXDU2fL3wlXBG8Af8uuvrfgwFb9ZlCSNgycUFSSq2LAYA==
X-Received: by 2002:a17:90a:5107:b0:2c9:5a85:f8dd with SMTP id 98e67ed59e1d1-2e3ab820d71mr7598872a91.18.1729152539590;
        Thu, 17 Oct 2024 01:08:59 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d6b0csm1217487a91.31.2024.10.17.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:08:59 -0700 (PDT)
Message-ID: <af842df1791423386f3aef25f3f94c5b39b5e332.camel@gmail.com>
Subject: Re: Using union-find in BPF verifier (was: Enhance union-find with
 KUnit tests and optimization improvements)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>,  bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, xavier_qy@163.com, longman@redhat.com, 
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com, 
 akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org, Christoph Hellwig
 <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Date: Thu, 17 Oct 2024 01:08:54 -0700
In-Reply-To: <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
	 <ZwQJ_hQENEE7uj0q@slm.duckdns.org>
	 <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 15:10 +0800, Shung-Hsi Yu wrote:
> Michal mentioned lib/union_find.c during a discussion. I think we may
> have a use for in BPF verifier (kernel/bpf/verifier.c) that could
> further simplify the code. Eduard (who wrote the code shown below)
> probably would have a better idea.
>=20
> On Mon, Oct 07, 2024 at 06:19:10AM GMT, Tejun Heo wrote:
> > On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > > This patch series adds KUnit tests for the union-find implementation
> > > and optimizes the path compression in the uf_find() function to achie=
ve
> > > a lower tree height and improved efficiency. Additionally, it modifie=
s
> > > uf_union() to return a boolean value indicating whether a merge
> > > occurred, enhancing the process of calculating the number of groups i=
n
> > > the cgroup cpuset.
> >=20
> > I'm not necessarily against the patchset but this probably is becoming =
too
> > much polishing for something which is only used by cpuset in a pretty c=
old
> > path. It probably would be a good idea to concentrate on finding more u=
se
> > cases.

Hi Shung-Hsi,

[...]

> Squinting a bit get_loop_entry() looks quite like uf_find() and
> update_loop_entry() looks quite link uf_union(). So perhaps we could get
> a straight-forward conversion here.

I'll reply tomorrow, need to sleep on it.

> ---
>=20
> Another (comparatively worst) idea is to use it for tracking whether two
> register has the same content (this is currently done with struct
> bpf_reg_state.id).

Given that union-find data structure does not support element deletion
and only accumulates merged groups, for the following code:

  0: r0 =3D random()
  1: r1 =3D r0
  2: r0 =3D random()

It would be necessary to re-build sets of equivalent registers at
instruction (2). I'm not sure about this use case, tbh.

[...]

Thanks,
Eduard


