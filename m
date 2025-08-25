Return-Path: <cgroups+bounces-9393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACAAB34AC2
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161D22A1303
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3787027FB3C;
	Mon, 25 Aug 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEZ3InvS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26913D503
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148796; cv=none; b=SA748F1j5jdzj7VjS3idfo6dwG3wj5PXEhRxOjjKZShe9mC2akTnZVcS03N3YOqRuxt8WCmZ6PLQXKBZhza94WVp3l+7u6WH2x6CnCCmpjg3oJZ21FZnhN1WctHw3GfSzcBjPSdIfoMYHC9RwrN0Sf8RLR3fOTbbeReZBbBsqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148796; c=relaxed/simple;
	bh=nXiXNC/n8XD4tIUmtofTDePq023F7QUJyqo+465Hjng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUUA4UoYhotpdIkceFvBuXt+yKjKlu5D4hVhOSgbXBvM66msoJ/EBRUAnzv2ckImQHivcO0k+d0tA17JGP1dcFImwqKuAt65j4nb0eZVqh9hqCn2ducJXifBqGxkLlW+yNSRPLWVTw0OH9+1+EDzHcuwVNchXRkCZdPzB9ylUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEZ3InvS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9537c4a2cdso1728830276.2
        for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756148793; x=1756753593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJCy6pMSth5ID8mVL8dsxoueMmqHKyc8szHkL4OXcuI=;
        b=KEZ3InvSCRa4aKJ7kuuRBns5B2ECBjq7e/rkawApTOedR18ol1aJacp/yhyNDP1OXb
         kzA5S2qh87p41xTIgVxaHhKo8cUoKE4ZCTUfaP993rMetBUERSDrL9RHtme2uwsjX3HG
         w8tlUNFleqSahOzKbniM3ubMe6EKvXKsrKxW69dojuu9dUQ85jol50pnIWOtvbva2XqU
         xEPHS9bD8B5zjnd7bmrh3NEhi3frXeO1fzZVE48h+67kHSwbPZgIN9rEUVuk1Xzdoza0
         z/wvH3YmFkS+I75S/yq4BvMk2jnKBR15Cn897P5iwMWLGKgD8DVhF2gUIRvkBdXxunEh
         4/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148793; x=1756753593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJCy6pMSth5ID8mVL8dsxoueMmqHKyc8szHkL4OXcuI=;
        b=GJ+z2sx2u4k1FBySIAOnvejkaU5NPUH0VtMxphWg1MwFM+3UzDgVrPa71gU79/qY+Q
         mRzjGIOsdcIm0AKm7PWL1E1sYtmnCq/TnizF8WL2mzgAVqmnUWuGXl5pQUYbPOOfDpGF
         CE2GdTNBbrllvwZlcBO9D2ZQ+ke2eM+kqC79tesgU2is+1pdHIUpieRoPoKoQ0fPh4cn
         LaFGsMABREoeF/ASA/xWJB8E7dWnBxWjpzld7qH3zbxEJOanUH7Vjfoy5Ch7ht+r6LyB
         ocvk1131qKjENA6bgZ/5sOqAWeDWIDSM2CV3rwvVPmzY4YPAPk/8NoAs/dbzrYa7zhfE
         vDOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvnswAY/fHZRLi+biSkcNFLYb/wgKZ2iy4dil37nwjetpxRPHGgvokD7Z3FUxEUgaTc7Dz1HXy@vger.kernel.org
X-Gm-Message-State: AOJu0YxACYGeAMcIWsS1isBp4x8YoiGb0OLKnQu/TZMTMzM8S/pfDquh
	TPUl2PW1P+PLv7QUOIHrFBjXHWLQAXu+Wv2XDN4DfyNbVWoNbrEmSOTpLh0dyP42bFl9T6STom/
	PvrnNsdm3bpuca0rPfhWDbLs2ZTyF/LJd3ltj45XdrA==
X-Gm-Gg: ASbGnct0mVd8HNJpYNsAh6NbyYGcb3iSxNIDdFCVpjvvqMjqplJP4OHbZz1lvqfckep
	LbD8HCXUWseEmqSfIjYq96vplIrvykE8vFWUw1SrFxjmy7rcuHbyPdCs8sVPf04EFdojinR3zIC
	14U3GvGvjQlXVnC6wlEDLtd5md2C9Fh1E9TN0TMpI/UpnCXOf2yAsT5SnR3rRvPFxL7NSUHMB87
	gjsFRkjfmLE
X-Google-Smtp-Source: AGHT+IHAgyL1whKyieTbABDi2quj1+wuaVqtUcIrZ53ZFQBjV5RtdnhIK0bQ7dnHbDffx2GPfxlJyS52gocXhCBCiEk=
X-Received: by 2002:a05:6902:3411:b0:e90:6c6c:dc3a with SMTP id
 3f1490d57ef6-e951c33207dmr12818324276.34.1756148793135; Mon, 25 Aug 2025
 12:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org> <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org> <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
 <aKivUT2fSetErPMJ@slm.duckdns.org> <CAHSKhtc3Y-c5aoycj06V-8WwOeofXt5EHGkr4GLrU9VJt_ckmw@mail.gmail.com>
 <aKyxE6QOR_PtQ0mT@slm.duckdns.org>
In-Reply-To: <aKyxE6QOR_PtQ0mT@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 26 Aug 2025 03:06:22 +0800
X-Gm-Features: Ac12FXxwKjce8jxJNNwjCY1pe1qCpWBlapoFKM06--smM3L7BAjrjrvgrdd62yE
Message-ID: <CAHSKhtcdRysJGAUOOXMUdm=dymQ3scJFUQ2nc+ShmXku+SAb0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 26, 2025 at 2:53=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 26, 2025 at 01:45:44AM +0800, Julian Sun wrote:
> ...
> > Sorry for having misunderstood what you meant before. I=E2=80=99m afrai=
d that
> > init_wait_func() cannot work the same way. Because calling
> > init_wait_func() presupposes that we are preparing to wait for an
> > event(like wb_wait_completion()), but waiting for such an event might
> > lead to a hung task.
> >
> > Please correct me if I'm wrong.
>
> Using init_wait_func() does not require someone waiting for it. AFAICS, y=
ou
> should be able to do the same thing that you did - allocating the done
> entries individually and freeing them when the done count reaches zero
> without anyone waiting for it. waitq doesn't really make many assumptions
> about how it's used - when you call wake_up() on it, it just walks the
> queued entries and invoke the callbacks there.

Ah, yeah, this sounds great, many thanks for your clarification.  I=E2=80=
=99ll
send v2 of the patch after testing.
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

