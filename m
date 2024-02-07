Return-Path: <cgroups+bounces-1386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1E84CCE6
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EE71C210AB
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57E7E79F;
	Wed,  7 Feb 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5iqqdt6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E67E592
	for <cgroups@vger.kernel.org>; Wed,  7 Feb 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316516; cv=none; b=JNtvuLh/KrZTjHesu9JaJbsIyqOXm9jfnO78UkHjuZrRaG8vFKoHSWmiOzFGLp8Z0nTPSS8HaUVCNZYGrXx4DiJbKMCbaNJ0MAKFsjsa+QnlOB/rvYD+gjKtx4yFOS8hV4vq3T5L8oYH+TVVCAUinbwiNXery7yPxDZjbr/R6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316516; c=relaxed/simple;
	bh=gpczSAxiMi16s36upVGETQy331v3qZNDG6hZpWEIo9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mspDeil0ZSoq0EmV4gjTrhgv3k2mNM2KJUEybawXM/7Tgm1fYGNXHxbCDVLTfw6TD/hD1MsEfZHO68LTiP5XIBMwKhUPB9fnHjRPQWjfhEDZBZl6Q26T9YDAcefAmmCnGoCEQs+uRwGkdS3VqMr3L8ELsYtIJLvpJizX6qfjxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5iqqdt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707316513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS8oKSLwKnX/1OmCvP477VoPbNUPt8nzRLpvXwaBKqk=;
	b=M5iqqdt6fMOfUpJ7w/iD60/e/WCnJ4tmWJA+TEQ3KqKN4Sk5dLVoG8GruAsn1H9VYSvUEt
	C3oFqXfMrLEGrxOUwhLaqTn1w2/Bt2IZxcgVglisxYSuucJxW2x8Q1ubnywW7OZmPbSh1p
	pgw5CwNuEQGr2uLq/4OU1HDsWkmVnfo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-iMdCEAlcOdOMw-RUtoq42g-1; Wed, 07 Feb 2024 09:35:12 -0500
X-MC-Unique: iMdCEAlcOdOMw-RUtoq42g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5ee22efe5eeso11953537b3.3
        for <cgroups@vger.kernel.org>; Wed, 07 Feb 2024 06:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316512; x=1707921312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS8oKSLwKnX/1OmCvP477VoPbNUPt8nzRLpvXwaBKqk=;
        b=KOx2UUKKqr13tO8hMwIeuvX6+rquUS567D51CJ11uQe2zo7TgDF8gp4vpg+uAI9LVA
         fqU81AD6tBFFbsW88+f016W/YYXOvmnBilc8GzsDmc92WbXao3ngdrIPPniqlTIfCd2x
         vI46vEixe/EovpgrwIWkEjpTuSg8zkbF2lIPsYoK4mQpwNh4uTw+odHtl9fSqoiNL4Hc
         jwHBTmbsTVFs/1aK50F85duziIx3pzbewNiV80pSN1rp/yQFsyKxHQv/ZVvKvFsF3M4J
         q/cwzJx7k09cu7KUi0SjkTGAQLs35MEZXCbFahfCRb2/SkR4evzRJvAHbirLq8ozdxSQ
         AZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBvhibyfTlWcpK8DAmtYuZnV5q/VWJh2ik9+uOboX56+3E/U5NsiW30wZQ6GDcLU2mm260TVRdDcLbdJNMcN2Gh4s1bODuUA==
X-Gm-Message-State: AOJu0Yxm3S402+q3i0oBxJA80jVrKGLNzsahZfQmVNvYTv6QfVvd1uAX
	JtU6MQqlpNYx41mk8bhzS9aR4lHqohFkZNHHoBCktpDq6I3P/nAbkB5QoteNjzx8c4xkb0DNqgP
	QwTTUTmbDBQiCBz94Psp8wFrwSbEg/nhQz+CHewbtnZDeswVkTnv2FmmZlVu1HBZLGmmAeb/2pE
	6a/gf3k+J9B0KczoQ2nlISxzzQr4vbFQ==
X-Received: by 2002:a25:ac4a:0:b0:dc2:6698:2c7f with SMTP id r10-20020a25ac4a000000b00dc266982c7fmr4891916ybd.33.1707316512031;
        Wed, 07 Feb 2024 06:35:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE++5w1moQLuHaAqcodu9tX5wQSeMmoBwfQu91lEa9262GLOPvEjAZwMad0/0OUSEvws/4fl6Yzjr0KEw6orY=
X-Received: by 2002:a25:ac4a:0:b0:dc2:6698:2c7f with SMTP id
 r10-20020a25ac4a000000b00dc266982c7fmr4891893ybd.33.1707316511720; Wed, 07
 Feb 2024 06:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org> <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>
In-Reply-To: <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Feb 2024 15:34:59 +0100
Message-ID: <CABgObfaSVv=TFmwh+bxjaw3fpWAnemnf1Z5Us5kJtNN=oeGrag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] eventfd: simplify eventfd_signal()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Oded Gabbay <ogabbay@kernel.org>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Diana Craciun <diana.craciun@oss.nxp.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Fei Li <fei1.li@intel.com>, Benjamin LaHaise <bcrl@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fpga@vger.kernel.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-aio@kvack.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 1:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Ever since the evenfd type was introduced back in 2007 in commit
> e1ad7468c77d ("signal/timer/event: eventfd core") the eventfd_signal()
> function only ever passed 1 as a value for @n. There's no point in
> keeping that additional argument.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  arch/x86/kvm/hyperv.c                     |  2 +-
>  arch/x86/kvm/xen.c                        |  2 +-
>  virt/kvm/eventfd.c                        |  4 ++--
>  30 files changed, 60 insertions(+), 63 deletions(-)

For KVM:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


