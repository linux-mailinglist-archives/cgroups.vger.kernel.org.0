Return-Path: <cgroups+bounces-9789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D0B48C94
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CDA1B2739A
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0122FE11;
	Mon,  8 Sep 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfreQxUv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DA1E1E1C;
	Mon,  8 Sep 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332385; cv=none; b=ioGhLrPD3VpRy+lHRDvzkEJphk4Nyn4kxV8vhqctyF2w13hLKOsRcV5hvRDtpVhBYq3CTXL2yWGr+JL+2rFs7DxdM5y14HE5zNlhIGvYvwDYOwSToXiH2nNxfyNLtsJXHduNfNWBfXAeq98OOkseCcPn9C2M5GTIMn5uW7XjNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332385; c=relaxed/simple;
	bh=Qo2zIgqtHTQ1BKtkB9HKCKiZl/Wi8TsjKo7wvQsntiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwvgNSA/NjV5gkO2bXmQPgMDIG53enM7i8Kf7Y5kVP4OWMJsD8fE8OUknYwl4Lw3F035/ijpFbvAhnsS1DFaytlbY61vDvUt5SoDNOmDWcdJLsPvrCJSbfOuaz9giL+gT6Ff2bYTI/0D3tScoFsf+rK8AOir1VGtP5MdV4RhqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfreQxUv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so35253265e9.0;
        Mon, 08 Sep 2025 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757332382; x=1757937182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSIlMFrvVdUyAVeh4YN6Zqf6MEv5vRPNuRzsQeImS7s=;
        b=gfreQxUvDduIegnpFA0orDrQyh+ZFoLyPBhxsSSx23NQlplCF7JvPmqpl3ubc5y3Tz
         YVSZIogrXNw6RFOth/GnOHoBu3XjUj97ymf/8WSBdC/Cvf4jgb36OGhDgjfMMNdkDT7j
         9/DcG8M7WYlt4lynO8eZMo2cRsj94ZWGQEooANRsvNQRzuV6bm2QDzR+ccoCeCZnELqw
         u5FczyqwWUHR/Y9kxhuZzrdsP3Wtky5UD1OI9TpcE2vDTwQ6gAVWELGaPicloHqsTF1O
         7LWgEzSt4PA4UxytrUfq9UGDlHZUpLY8lVSt/Q2qkBQjgg7EU9Kdz6jClw1r1ptznpPH
         QHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757332382; x=1757937182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSIlMFrvVdUyAVeh4YN6Zqf6MEv5vRPNuRzsQeImS7s=;
        b=TZKFq9ERJD41Z3BzlHrQ9gVEkxow/+dLiTVRw3F2xsAeK8NAhIzy8vryPrXgTOtVUQ
         Lgf5UNg8Bzw7gYm6TZgyOI15Q7z3sof+Uu5ciST1c5kOPCV0PcVUydcRTmvM5MsBpTTV
         fBBKykmGncebcU6iQm2JcdV9Qz8hl881mZFA9Mpxe9NolqzGJ/iw7nYLLzuBZKqpNYSw
         z1tmXOrEmeSHFuJ87d+uPbBwg8rKn5KUeswpxgdKPXiT02seMV2240NQHGuRT8zbCuSY
         lo/+cMDI4BX0TKMa7YV3iNHabIS/7lSYF03IkfPgcxIry3RKlOtlLzl+aC1iVh6yZqQ2
         hlWg==
X-Forwarded-Encrypted: i=1; AJvYcCU/jFSRVl14/bQaEHBLohrCaK94k9W00xvjXhBd0ABaeMAelyoMAxdmi3zyCpdOV9BsYxtAEcii@vger.kernel.org, AJvYcCW31oAo9nIGGoRpo365o/Zy+0TtEgcgI7KqvlsP0EOWQGXhesv5lNcSlhiQ+Jgvusu68JHyqCci+0OeUsjx@vger.kernel.org, AJvYcCWOcS1jXOyBED2Fh6OE+PlzMjhH2Ur8BP5yK87ZA1eicRN1qnZKDrAGRabN3YGF22d6zpUUw0Qp/aBy2qEcCw7z@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIXJ0S8RoL0e1xF6NDL+ZdksbxnOJEGvipX0cBf+PQdraKuK+
	1kz5QNdPxjWO1T8BKHVFKesIXXxVqJzUzEbzxtT7C4/lmRV8aBq2ZKv1
X-Gm-Gg: ASbGncsZSZe7lb+l80R1dBKXBnippzk49xkyb18Xp0XKQsDKE/DxaifRIkb+9zXuvs6
	fj/lDg7Chl+EWRQLIkpsMkXBJxAnPKdLbZ5Gm5kw2ymdSRjiNd00nrChMiyxOiBKmcw9EXlQnnx
	3O3jZaa15eydi5qM8w84Z01d6ryhlAEkgzmwD3FnGTmKeKWvGtVvYtVAOIrdNO+327kBgLLAcrF
	sKO7ceuQQ+YLtp2VWojfCivCG1+XXKq+k3/LW79QE8don7SbtXwNopy2Yf5f+eWNa+ftsq+JORD
	qhK2vfO3XGmpG6hMZeAmAXrpccmDX+ddFSLPwdBnjplxmpipeKyOQUagefEJErbZ4LCklmVFbf3
	Bxsp0YuSqvNP5RtaMgX0jeLmLGVgJnGXw/o/DgqbdeZkjvbQIjBfC2ZPCeq21lNBxoOEGzqw=
X-Google-Smtp-Source: AGHT+IG1mCE2Wg0NzfAOz2qF7vpg1XyG/YnKrkNmXzBapGyeFoTq5/DKBkNtKWBSvGvW4tooP5vWCg==
X-Received: by 2002:a05:600c:3510:b0:45b:8543:c8c9 with SMTP id 5b1f17b1804b1-45dddeed951mr60289865e9.34.1757332382076;
        Mon, 08 Sep 2025 04:53:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm436258925e9.19.2025.09.08.04.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:53:01 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:53:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <20250908125300.25a2f475@pumpkin>
In-Reply-To: <5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
	<wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
	<d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
	<y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
	<92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
	<tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
	<5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sep 2025 14:37:40 +0200
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 9/2/25 13:17, Michal Koutn=C3=BD wrote:
> > On Tue, Sep 02, 2025 at 09:56:34AM +0200, "Gustavo A. R. Silva" <gustav=
o@embeddedor.com> wrote: =20
...=20
> >=20
> > (You seem to be well versed with flex arrays, I was wondering if
> > something like this could be rearranged to make it work (assuming the
> > union is at the end of its containers):
> >=20
> > 	union {
> > 		struct cgroup *ancestors[];
> > 		struct {
> > 			struct cgroup *_root_ancestor;
> > 			struct cgroup *_low_ancestors[];
> > 		};
> > 	};
> > ) =20
>=20
> Yep, that works (as long as it's always at the very end of any container
> or ends last in any nested structs, for instance in struct cgroup_root,
> it must also be at the end) for GCC-15+, but for older versions of GCC we
> have to use the DECLARE_FLEX_ARRAY() helper as below:

Could the warning be disabled for 'older versions of gcc'?
A build time warning doesn't need to happen for all builds.

	David

>=20
>          union {
>                  /* All ancestors including self */
>                  DECLARE_FLEX_ARRAY(struct cgroup *, ancestors);
>                  struct {
>                          struct cgroup *_root_ancestor;
>                          struct cgroup *_low_ancestors[];
>                  };
>          };
>=20
> Thanks
> -Gustavo
>=20


