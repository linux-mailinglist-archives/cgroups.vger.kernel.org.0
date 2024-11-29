Return-Path: <cgroups+bounces-5717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123269DE904
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559D5B2144D
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682ED142E7C;
	Fri, 29 Nov 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqCx954B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236B13D619
	for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892404; cv=none; b=M2yCRn0Bpeh4EExpB1vAoh0f0v8WoowE33R5SEG8b1elXEDyPgvE5nCITPr/scD314CmfqLV4bce5FwOZVGpjyYqbvy4M9ir3yxZFV2hUC+lSmWBZonK39yZs/9I61k7eC691bUtItaj/O/ichSY5S0GPYqKA8AOkA0SLc9hSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892404; c=relaxed/simple;
	bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqGLQ5EDI4A1v8R+7Q9J8sfL1iMmUVQ0YF5Cs+NNnZp8hwoyHYx68sxYDc2WIQUyj9fHYAYQUcowHJ4fuN4HfVYZf20PFKWdrOVnrcjitlPtc9t9f7RwGjQRo8pCfz6JJ1h/imW/o8MSLfR/jBLhe4jP/LAI0Exo5bZWQGjuN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqCx954B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dbf79881so615730f8f.1
        for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732892401; x=1733497201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
        b=pqCx954BagLF2FV0MPzc3ApQpcw9Yz80DovSXfiPn5RIKp0giwZyWfCnzB3R+gHn5p
         gHxpeyDnZaiW/IXTuuqsAdH2DLnoFwMufPebxiJIyC12nPN2ctdvUgwmkhqoniFCISnV
         TaP2sfdFIxN7l71sCwRpMR3TI5lVJpri1cOxZpnSUMzVS3gzlSj6SSDRTimtzhArs2Ow
         YZq8brfgpcif5bpj5aeLt4P5l1hpOY9+jMgwNkkF/xtdQUdh1vmy5vHW1DiJh4p74uDO
         aPSFezE0DSbnJhl2EjJ89thCkkdiZbKjgWde1Qu36DZrcjDacRBagT3vDDJ0B7t4BQiG
         CBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892401; x=1733497201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
        b=uFZr+hSVPuv/3fBDJhIpQQAOa4qB8GI3Duxpgrlw9GBWnmLgA8KmWi59Y7Zgi1yNDJ
         nsaBXz/gyfrxABWEGRcrWPVB/aOxMvEt1lVETQUnylAZm5qBB/8RA0uNkq2sdMj7LFEE
         CmLgl2WMDcBfWeSzESbfKjgNxC5lJ1cHf17lUEEXWxQFA7kAMvink22eZ8HtHJp0bqb3
         YweAIBpUqdqcqXZIMBwWVPvE7PbHBwhYdlhp3bKllNUSQR2YqCRm7x6E2pJYGkgHrTdc
         hv7q5wmRuK0UQW68eb4G0Gg2Dy/alBnMSTm3Rz2jOubfVLpll8DnemH2b1jOx8rjl5sc
         jHKA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/K3JYFj4wyfK0VoIUanKEcjbrMbUeeiMjndkA7T+dZGZSjTJvToZfUByrGVLA6+wBQwUUcWN@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+D+BCyO4gldg8xpF/kXsoGPhsB8eb4CHe6FcXUpSMPsBf9Dm
	SyDPIGWUAl962hR8JWXAY0cvzXMUN8IXL7ZKFqC3SL+ZM1VESD8GhJAxK4Yj7vLRsT/+ZbtXJ+3
	OVES0+GQdzXO2oc9C4kvKHJPxBkODWln3xsQ/
X-Gm-Gg: ASbGncvAcyAi7q6fwmJr6JsNjQeEbsCLbeKJVTrHzj92qm/S/vZ2LGNxvZBSR/rkaVT
	tGsYDeB/XW318oK5ONnX4e5MH3cJIMOM4fl6nVad8WNyL1QZTKArQxN+usJUNtA==
X-Google-Smtp-Source: AGHT+IHDi4K4lNAohQfNlceyKH9RUzPZtVMe3BZmZ2vxNmK7aM3ImmmIXciX3tmNHa7ia1ZHmeIkXE0xn4QwvOvwLsc=
X-Received: by 2002:a5d:5c05:0:b0:385:d7f9:f15f with SMTP id
 ffacd0b85a97d-385d7f9f229mr4841298f8f.19.1732892400847; Fri, 29 Nov 2024
 07:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
 <Z0j3Nfm_EXiGPObq@casper.infradead.org> <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>
 <Z0nReJHvBJS1IFAz@casper.infradead.org>
In-Reply-To: <Z0nReJHvBJS1IFAz@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 15:59:49 +0100
Message-ID: <CAH5fLgjosHfmOX5_8p04jGpOQSdR7UBf+ksugA+dSL9ZNTJ2sA@mail.gmail.com>
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about sublists
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 3:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 29, 2024 at 09:58:27AM +0100, Alice Ryhl wrote:
> > Oh I had not noticed the "Return"/"Return value" change. It must be a
> > copy-paste artifact from list_lru_del_obj() which already uses "Return
> > value". Would you like me to change that one to 'Return'?
>
> Yes please!

Done in v2:
https://lore.kernel.org/all/20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@=
google.com/

