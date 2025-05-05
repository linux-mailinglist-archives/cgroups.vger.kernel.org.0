Return-Path: <cgroups+bounces-8012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24841AA9AF8
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600573BCACC
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0D26B978;
	Mon,  5 May 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WfoQlf4j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC861A23B9
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467202; cv=none; b=JhIVnwx9E8D0FVKWT8OpRDaEC5njaV82zkchdLetxKCMuGMK++dF2eiVsg2tjHQVYDvNEj+o9y0IKYAk/hY4wcOuvIXeXeKZeEuRfDAP3aMwexvr231Y7iprAcr30NPxgznoo9hbg9DXCOShKhMt/JIzLpWD+7Bm3L9+2LWcTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467202; c=relaxed/simple;
	bh=flx8Ljw5SKcwo6d908KI2oJJPOswRDybxWbQ0sBwqXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mej4aGffqRuefRO4oZcP5DXrbG+P7vfcL8uw7PV89CNUv/ahAQIIcS/CFZx0cbJN+mlnA0gYPFFYX9gGlA5LKlJ1cJ96m5P51K2TcdITNlCAhm/vGw7Q0NHF9frg2mWngbGE7lJEyN3CXjLkEazHWZv7i8J3usYMj8NciT9RNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WfoQlf4j; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so648135866b.1
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746467198; x=1747071998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43yWpaDFlvzQdOUfoFXBeY0L6VRPaAC57++Wqp89Ras=;
        b=WfoQlf4jXViXBpXOQLTbOnWIO5RZV2Gq/6MNcaBBHXu4feRPDHYy+ZYqykb+pQRd5e
         ktyZeAyaWz+4rvU6rZPnty17yBJGLz+r7LUq+655ZcDoreE+kmU3nMD1bVYO+hEYMz6m
         rsYoH5SU0KL8yErHMcDDDAfWSDcAt5fiAR2wSZJ1gfwWUXuaL27PrUoQ8bsoYa9OyBuf
         CKMoIFo071qwd0s46F9KJQVu9wXgj3FxQgjNdxy3anU+x2N+X6RX6DS/qXBoRGLfQcfE
         J6jTTChziU+sYdXTGraI/Hi4c/nIqeCg7ACy1FRDNJvDuMJEBFnqH9GYw0CaNf3dRZrL
         0NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746467198; x=1747071998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43yWpaDFlvzQdOUfoFXBeY0L6VRPaAC57++Wqp89Ras=;
        b=DedV3GZC2wIY4Hidax8F582XsCeygQA1C6YDIje/aqoIwTGu+B7eK3VyhBtm/ji1IL
         W2JqtskyReu3hEY0nQWHN+0SrRiEaI0bH+6UVihTyGmVmYS0e/HRnRWkAI087s8/cVMD
         83Fz8H+uOBUaa8cvlcim7oOQQWM0h5g1wuwXVPG+7v5PG6WsRpw1kfQVlT+p7uK3W+Hu
         NOPnK+eTprkBCTf5xD2XOepeXeit0hS0797JYP3i1L5QWIJvaBb/rmI27D1LyiVrGRUr
         aEgGzjM8rgQ3YXOoTcsT2HcRqmgIq9HnoPefZBToKZcDl+JoZY1YA41Ekz+h2+Rs/D29
         nNdw==
X-Forwarded-Encrypted: i=1; AJvYcCW2aec0OVvTHuYKfaV3p1hyuhiIbx8z9v9Od2hflhIoBQHSw0rxWghDBLJ9RNYZyXzepcfrX2yb@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKcbcRrWjqLAnfAvUN86oYlpOqA+06hSwEcyr1/uuJd8ClLsg
	gWTCkbSOITSQYPrUMIwT4wOqkJuG6N5aIEkOZn1O4ObZoYvROnfGVTvzmHdS8ZQ=
X-Gm-Gg: ASbGncvNWJ2oDzzF/Wr/w0AWeCpU0OEJZpaIfWyaNWHkBBRvusZIHGepHzOB5PkNauN
	U6N0FxuNzzYa968rq9QSKQO2JxRGJqSuZVWc8ZPKSFvRjDOaZ3bgriq2C3wDLLcb9XGxoGQ79Iq
	LGZHkM78kGk7u4g4wZwv80uF6DdzrwfspfXoLoHoP06Dave5ptaSDb/CunknABdkLCSu2ORqYAA
	wxH8uolGOYa4uk0gLYrA7EF5n76mvl5W8Mwg/UZn8paPS6WKFmxuwifyDOufVY2VydDPXsd2Vah
	4hZVkxmtSHNAANUCpXhDXLdIBq8Mq4Nm39UTlGhOe/E=
X-Google-Smtp-Source: AGHT+IHZlXsEPKMLo2zRS60G2WHXFj+ckZOv4p4jkB4sqgQ0nGSrOlorMH5olM9T7Zhs5WwmEyP8Cg==
X-Received: by 2002:a17:906:bf48:b0:ace:4197:9ac5 with SMTP id a640c23a62f3a-ad1906a9acdmr985756166b.27.1746467198490;
        Mon, 05 May 2025 10:46:38 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a311bsm532577666b.54.2025.05.05.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:46:38 -0700 (PDT)
Date: Mon, 5 May 2025 19:46:36 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Jain, Ayush" <ayushjai@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim C" <tim.c.chen@intel.com>, 
	Aubrey Li <aubrey.li@intel.com>, Libo Chen <libo.chen@oracle.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Neeraj.Upadhyay@amd.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
Message-ID: <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22qdon36iehurhxm"
Content-Disposition: inline
In-Reply-To: <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>


--22qdon36iehurhxm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
MIME-Version: 1.0

On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com=
> wrote:
> According to this address,
>    4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 =3D p->mm;
>    49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
> It seems that this task to be swapped has NULL mm_struct.

So it's likely a kernel thread. Does it make sense to NUMA balance
those? (I na=EFvely think it doesn't, please correct me.) ...

>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
>         __schedstat_inc(p->stats.numa_task_swapped);
> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
> +       if (p->mm)
> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);

=2E.. proper fix should likely guard this earlier, like the guard in
task_numa_fault() but for the other swapped task.

Michal

--22qdon36iehurhxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBj5egAKCRAt3Wney77B
SanGAPwNhmE23Z/0QW0JWDF2KTaNoo6f1GDl48W1opF0LxB1lQD+MNowOWLQ/L5v
tgd+J+GBmSPm7cJPRvC8MFMHKdQZTQE=
=EAuC
-----END PGP SIGNATURE-----

--22qdon36iehurhxm--

