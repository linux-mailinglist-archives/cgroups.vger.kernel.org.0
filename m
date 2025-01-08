Return-Path: <cgroups+bounces-6068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922CA0642E
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948FF3A6528
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08A19AD8C;
	Wed,  8 Jan 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dX1uI8LU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B112DD8A
	for <cgroups@vger.kernel.org>; Wed,  8 Jan 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360213; cv=none; b=QKHpa4m7ZGcKLQX1MpOmoP5Ljv94Kqtl4am7+4+uGWG43qtSGTcOcFn6jFfWxtahNwmPdA3iUq1KRMSdrMzXBULLCd4ewinP5HOYlky5kOj1W+YI85+qrpKbIRlVGuFqiNCZS2mmqXH6g1LOPnlMuqahT/6ZhmOevjAKwi5YHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360213; c=relaxed/simple;
	bh=soU5Aara92WlnAsbyi1E7mvn0ItlsuKySKe7QRCs+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppBPc33j5vITYK0y4Doy3J5johVO715yabVnL9KEnLViZMI7G/TPBi3WA7YlmNviF+kE0GuC5hHNEqr9SesvDFFKwxhxlW/3ZVWK4aYydGgp67IV3CyurvvTM/R/TxgHtLRM3YoSWyrMZFVxse/vpZ9d06lpDXKZ8olnSjMDOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dX1uI8LU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43622267b2eso1624455e9.0
        for <cgroups@vger.kernel.org>; Wed, 08 Jan 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736360210; x=1736965010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soU5Aara92WlnAsbyi1E7mvn0ItlsuKySKe7QRCs+Ak=;
        b=dX1uI8LUL58vMr3cpWaF/ne77FU4Eh8wU2PgMA9n8uJngJQd/NFWvlbWYDQUzi5gYx
         7ZokO/Md0QnV7Ymiuwj4YcMe1B4ZPzFecCKu4a6kpuRK44SwfIVFo+ExMueGo7ex+Yw8
         bu6RCusMvmF/GPZjO0DbiSAb7aVZewYIIgpGV3hx6hJkZO0LRnl+8pGOzvd+47xVZ89t
         4WvwRvqjVgrUKY33HTzoEQPsxdpx6U1NazXrwXH1PqIkh8qWtXsQ9S2GA6PghyCPFiFI
         JTrmgIVTMUawactT8PG1Jb/lzS5lhlJGwCIrXEYuGilkgmksnSLai9eBTAoueKRK9dIO
         5cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360210; x=1736965010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soU5Aara92WlnAsbyi1E7mvn0ItlsuKySKe7QRCs+Ak=;
        b=auO+tvf5Q7lODin2MoL31sakMmvvgU1gTkb6q4J4cTwt9HFJM+0BdzcereWTKbHG+A
         f6b6b6a+qinqDd2TOWcG3G7gZsjIj7U2zLRWf50UoFblADdGL2pF+/6Z5iKR+pOAayCj
         KyfhOvk1StavYfLlNvReL072w0Qn5HnZW8hft/vsv3iQW4HLkWKB+g8XlaLLMM7Lb0gA
         aeREu0cXVDotrVMIwUFQDFWA+4nB+oKUaNYUDyult2CcGw3XzNfm4N8qC98TTU6MaIub
         5h/2hpva4ZGZ6w4LU2VptZcK7wppF63GlYvxFVoE+rXXug/lssgm62SsxXHd47tyXCn8
         KVoA==
X-Forwarded-Encrypted: i=1; AJvYcCWORZ7U526LBAS1cd48f9XoJtzCO7+YdqZhFw/SL1y/uAQTQvU/dRPL6Fj+kxaf0n03grZNsnUd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CvtYvX9QpimP6THprdBRIbqGFIw6jmq3hZka2oj3Xo6fQek9
	DTU4fmWs3X4MINj1IkE4pIetYc+lMvYkT9Iw9ENVIBxjse6ahyYD0XtQFtfqZFQ=
X-Gm-Gg: ASbGncvqxXWyi1c6CzMB8Z/vkG0A3busz7TGhnU+T8gQXQEUUULKEUK1m3zVPkROmzq
	nvjgcOGD9YonoYPT8sBS32/aftOd6JbjrNP5+vI2HIvfBkKQfiPgaT/wBTBK8uwmjx9k3KG+6qe
	6Mb4dsnrUb/JRY9equuzsua9iArIH6eOmdKJT0IlQPx/60eudUXU0LumjwoKuJVmlSndgJmN8ds
	n8Z9d8UufeHItP7/WO/8IusBDDm+21CQdz1welN/0WjGuydBAuGrqPU09Q=
X-Google-Smtp-Source: AGHT+IEIj31ue/KYTGsnJ4xBlyy9BFoFJWG4Omrb20HMlsr04n9iXARJ4xGdLE0yI+caz9zqtnlt/Q==
X-Received: by 2002:a5d:6d84:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-38a873140f6mr3329217f8f.33.1736360209807;
        Wed, 08 Jan 2025 10:16:49 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd15766fsm29236295e9.2.2025.01.08.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:16:49 -0800 (PST)
Date: Wed, 8 Jan 2025 19:16:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, yosryahmed@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
Message-ID: <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nuj5c5dsq4myygkn"
Content-Disposition: inline
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>


--nuj5c5dsq4myygkn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
MIME-Version: 1.0

Hello JP.

On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmail.com> wrote:
> I've been experimenting with these changes to allow for separate
> updating/flushing of cgroup stats per-subsystem.

Nice.

> I reached a point where this started to feel stable in my local testing, so I
> wanted to share and get feedback on this approach.

The split is not straight-forwardly an improvement -- there's at least
higher memory footprint and flushing efffectiveness depends on how
individual readers are correlated, OTOH writer correlation affects
updaters when extending the update tree. So a workload dependent effect
can go (in my theory) both sides.
There are also in-kernel consumers of stats, namely memory controller
that's been optimized over the years to balance the tradeoff between
precision and latency.

So do you have any measurements (or expectations) that show how readers
or writers are affected?

Thanks,
Michal

--nuj5c5dsq4myygkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ37BDQAKCRAt3Wney77B
Sb/pAQDFXBfAL18vECaAX4mKV0c7EJKLfQPefr+lla4tVBBf4gEAx2v1lATXxUtS
NVJ/+TlyaiAmzhgIgnL7DybzlPZ0RQM=
=048q
-----END PGP SIGNATURE-----

--nuj5c5dsq4myygkn--

