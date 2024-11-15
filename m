Return-Path: <cgroups+bounces-5576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623069CF0A6
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008C528D494
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE41D5ABE;
	Fri, 15 Nov 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CUehZe47"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10E1E3760
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685529; cv=none; b=O5189roD14nBDUTGD16MClVgMfHcIiHBNbljElgUc2NTPtZpTFdym1qlKCO2jZhXgVxH21BbDMLUVO4oYNNK8mW/iKeVHU+mnoCGrlW7OP0WAKJ+fq0eVU8Zymlew5XqTe/HI6otW9FbL6fK1wn7etKDZ+ogSb4rLtQOmrw6HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685529; c=relaxed/simple;
	bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ+3SVypH3bni8bM/L3G03IrrlplxYWczb1RjTFscx91bUfNoWJjxNiXkg0ap0BQRFhg8uMK57MwO+a/CES+asG0NKSDabr0nUEaSkwnZg+Gvwa93CYjA1RryRLej5+lWwLFYETMcrwtpxGtcdaEjvTeXXZYaH2DNc/5g4klvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CUehZe47; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so16000495e9.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731685526; x=1732290326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
        b=CUehZe47+1TmPe9L6O/qxwhEDYj2TPtGXu6a68tBrHZXYs5+YULQmyOFvc9PuGL1Kd
         270IzO8ASD5Pn4mj/UZLg89FC1sgphhdXX4Q6/gRcFXLsXq7ADfrjdMrnnCmv1U2iWkg
         EmDmtVkiXup6Iu0DGR8BPNrre7r970qJeW4UEZAVLwrYTIJR35i0f/hRgsx2Vy6y97LS
         c8iD5IjV2DyU1xwSGqCbOl11qWdVXpf8ec+mYDXgN6bXqy6nchiIhYWd9bXxH20WjgAK
         LCyY7DumUBTV0r3uCnYa22V/N256AfXRl1o/eemV3gB6lW4jc5MY8o/yNczmeY8TuUpQ
         /yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685526; x=1732290326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
        b=ojKQ+x4Js5UnyH2NrVUeTfEgDPqD+ooZKo7tuRjkGUkBcIR25HOLZq332AUqCsBCt5
         nXq0YAp2oChvIrBq4olTJj+HgDjkeLDGOPZyU01NNmTPbVUAq+7ifLPSZO9zKn8jRxM9
         Yeq5dKkngASKwdg3DpPL3P5d2zoL1vYNFU4QpPWA/RIZXjiSiRnSe8QAj42+1r+WN6Vc
         6c0jCfq44c6FVkSC3ZrPqBuq44l6qbQEbXxyvGyjqczfkOUm8Y3StMiRnsSFiFY8UmLM
         nZ/mztNKNr82y374O7zgcrbdgYeM7w+NIaJXmr1LKWWhnQXMixsuWjeJLJlRdC03mlsF
         5o0w==
X-Forwarded-Encrypted: i=1; AJvYcCX5lAsP36i1kR7/zgXh30N4K5AyN3oS28ZjiE1J3rU1Z4MH+/hAN8eyttjWDqvlY27fZoDw25NM@vger.kernel.org
X-Gm-Message-State: AOJu0YxJx+A2TV3n4f7B+VXdNZzRsddpOwepFusRPs9s2H0T9bB/IoX4
	tCV2SbMVChDZPuxjiQ1ITJpCjlcyZKV8Fc2Qvj5mO09ZvDFdEjL0dTLcHO9CAFs=
X-Google-Smtp-Source: AGHT+IFMzkpB5ten8aStGI5U0itCRb9SQJnUjz1+wqgAB5ntNpoiOJeeloohYfL8pax+nnjaE0HMrg==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr27024635e9.5.1731685525955;
        Fri, 15 Nov 2024 07:45:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm58557685e9.28.2024.11.15.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:45:25 -0800 (PST)
Date: Fri, 15 Nov 2024 16:45:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, 
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
Message-ID: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3kcsrkvzzccsahc"
Content-Disposition: inline
In-Reply-To: <20241108054831.2094883-3-costa.shul@redhat.com>


--l3kcsrkvzzccsahc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redhat.=
com> wrote:
> Cgroups allow configuring isolated_cpus at runtime.
> However, blk-mq may still use managed interrupts on the
> newly isolated CPUs.
>=20
> Rebuild hctx->cpumask considering isolated CPUs to avoid
> managed interrupts on those CPUs and reclaim non-isolated ones.
>=20
> The patch is based on
> isolation: Exclude dynamically isolated CPUs from housekeeping masks:
> https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Even based on that this seems incomplete to me the CPUs that are part of
isolcpus mask on boot time won't be excluded from this?
IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
but not "statically" throught the cmdline option, or would it?

Thanks,
Michal

(-Cc: lizefan.x@bytedance.com)

--l3kcsrkvzzccsahc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzdskQAKCRAt3Wney77B
SVLLAQD/w8EP314EpkVv+CS8Q78tZha++i6qmCnttn45QJL5UQEA610FW1x1YqKu
ee7dMxr0W1ccS6lUwnBt6BpNAH//NAk=
=/uKX
-----END PGP SIGNATURE-----

--l3kcsrkvzzccsahc--

