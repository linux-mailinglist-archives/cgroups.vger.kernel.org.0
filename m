Return-Path: <cgroups+bounces-7011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A262A5DE12
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AC07A41BB
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45D24DFE5;
	Wed, 12 Mar 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoxofxHc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6224C668
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786355; cv=none; b=FAqz27SjemMTjMsRHcuYXA2ITkotwaPA1QvCzsVamzxAEGhPnYtQEWNvQVhm55QsG6jue+KU1wTXIpJoxw6aU19CeXD6YNtr6MjqzN1/JizYdh4vGhUt3E3/h/fNY1fsTNs5HNbZ9jXDmOan7faGL3beGj7qsscnK9kMJSHsH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786355; c=relaxed/simple;
	bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MFh+iHL4Gi+G/elywNihjOzotAcni0sMmL0A3Kxr0Hklidvo7M7y5D/YOohjuwVRkY1kT98VPSs8gjI/LI1CUZ9bJ8HpuiLPFhsVMrDDHc1f343rK02vGJVnZtcqjyqCssZIFD/UUG8HIpUN2zURXKPfweulDWHCBCMpTiPWeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoxofxHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
	b=XoxofxHcIUHdY+khMoESypGjW14TNxlAG/KWDQArSUi2DGLNgI0kgqtPLdGO52E98Ws6bB
	ID434gMUK23E0qG5bLtZsoDe0v+MYw0Eu6k59iNDPu1AXZ0pCojesdogPPzCfoRkSVXboq
	EeaXkY76e1C5NdGILKct8JgxU2JGvz0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-hTOz4skjNNizIeHUAkY5vw-1; Wed, 12 Mar 2025 09:32:31 -0400
X-MC-Unique: hTOz4skjNNizIeHUAkY5vw-1
X-Mimecast-MFC-AGG-ID: hTOz4skjNNizIeHUAkY5vw_1741786348
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391492acb59so2143249f8f.3
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786348; x=1742391148;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
        b=UsyT5eIuwtyIRNkQAl+FogFX/HxP1woZm2EK6lINAscVfb3g0KoSRmFPkRoQ2bEYVL
         Yl9hIFpCTE860LrA4pMtRmwkKM8aqCzq5xU4TXyxCZwHcktX+Lw+lLaDgL0eBe0brwhv
         d8TSuGv/FlHwIp2itFFSc6MdR9W4NQEijeHvrjuosX9uBuiBEKDq/NsePz/uVIYGxLIi
         iT8ZpL/GCq9ULot97DSmP1ZbsnoaIV4NzAQHB26e+RVykRegGks//uLM630nIJw1kzfF
         TUm71i+ZgMYRFfOhn29W5rK2Sm7B8OJ290Iofb00qUGt87wW5k723V6jg8VdQzTQ1x9U
         2S/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpfOTYyxINacD49lm3U30rzdUhzlwZK0amiuIlLSBGu3KWigk4e76+Zo7JRUVZ1oJCGQ1MMJN+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52gs1YVOmwRY3lU8F6/p/16sTjRoK+eKGKtdBZgIr4/jtZS99
	bQ8VXz/aDtgECt58g0HFDewjDc4YAPYZiBd8KZk1ts5QsDF3H4sBz6FCFkRifFMcVheGq8iXViy
	d9h6cIbUkLGC1sRr3fntz85PVBuM2RpFjJTbNuY+by1fq8ZWjLhg92t0=
X-Gm-Gg: ASbGncsylm5kN0QdntUZX4DRnnpcnrI3xWonirbLUEOMUBPemXJIfiwe06bm1dro+WA
	kCOHjcpXq/OjHA3ISxdMdlF9dkdpKPI9xep+Xc4t0fRm0LEvvN1VnLBj7bVQcHPSqcIAYJKj3kG
	G/1O6YLrWEInUGggXWbkHpnkRg+iWHj/6/qRAANqrJL1r/kVlrj/Bf3ohXgfLTswH/pBa1yV885
	zRo1STHCL/91r9Eg7dsMDNOaT+xok7n0yjYqTVqCxH8ysH2JSVq49Prko/imy7q1ON0l8QaWqox
	/2RH/oT0cHKNiPiJ7qKNGujGJWkB225SpAVeUoHfYJxASLpi2g20gdIASevYpig8RvRdQZQuLnS
	w
X-Received: by 2002:a5d:64cd:0:b0:391:2995:5ef2 with SMTP id ffacd0b85a97d-39132dace0fmr16368599f8f.37.1741786347832;
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaxFj59P/gx27aef5+vL3NWzByOCREFSl/XlWQyAR9XNy1joOV+02tZso8UnuMgsytu5Tqg==
X-Received: by 2002:a5d:64cd:0:b0:391:2995:5ef2 with SMTP id ffacd0b85a97d-39132dace0fmr16368578f8f.37.1741786347457;
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1037b4sm21279510f8f.92.2025.03.12.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 5/8] sched/topology: Remove redundant
 dl_clear_root_domain call
In-Reply-To: <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:26 +0100
Message-ID: <xhsmhmsdqpe6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:38, Juri Lelli wrote:
> We completely clean and restore root domains bandwidth accounting after
> every root domains change, so the dl_clear_root_domain() call in
> partition_sched_domains_locked() is redundant.
>
> Remove it.
>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


