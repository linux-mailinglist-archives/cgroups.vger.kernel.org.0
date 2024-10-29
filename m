Return-Path: <cgroups+bounces-5315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7D9B5433
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 21:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721302851DA
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC6208223;
	Tue, 29 Oct 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TUO09Zr1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79217207A26
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234323; cv=none; b=CBR+MfS7RFI9bhEn4Tlw2kInfw1e6FfvJir2Sv6wp5kvSb6foqUnypJJy9RKn1Kl9AScuBpYkipy5o73sploTHKTRkEQevpukXGJ7D0kNI+4Qcb0UpYh7kubP2ejkRacuPQ6NGAcKKfJPCd/ilGqqib7uAn9jlfgGvJL36Xx5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234323; c=relaxed/simple;
	bh=PntJ7QKi3digXuH8oXnq/Fq/esGixZhxoXn7meGNK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRccyOmcvFAM6Rqmu4dAhC9LgxfGd03YTDsryjVPH+6Xn0lZ7LTAaKmLIthQ5RssZfOkk332nHwh9xFwMsjxlVkW95gbwkArXvWK3VEQgvpBmtdAe4wwpNfKJdePHzmcvAmHtG8F7+5WrKAcv2uejtX8FV+L72D3Yb2zfEM0P+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TUO09Zr1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf340fccaso2159426d6.1
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730234319; x=1730839119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHhE7+FsFDchxD8LtVUn2ccYddeUr5QRSaFaIZpCbLM=;
        b=TUO09Zr1KwcwvweMm1qYW5p4WDcGiBizVUFEtxz+41deVmilIDQKgbXMBxOwk8iiFV
         iA/Pv7D7t/UogEgsy4tRJd467Sy+KM/yiNeY9IZ3v7cOqM3DQ9jZCHyp4ObD9pLv5Qh9
         l1bkwH480/npCfLMZMxQXVuKJp0KZp1tnNtfzzIR7R3tVES1yc3yMIuVWbzyfCukvsTH
         EG4UcZHp4AhUybwCgb8o+fu6Y5CNjLjFAOvjrgx+1h3PNyjYVPfsrY09eup1FqoxC+nI
         A97hiSpOXjfQD2ugw+L6V9TVuPestJZ5cF3TRE49OfPWINu7IA6tkUcZdhReIxtn1USe
         ib3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234319; x=1730839119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHhE7+FsFDchxD8LtVUn2ccYddeUr5QRSaFaIZpCbLM=;
        b=cIj4S/qs/8wq0vFzlvtcVgo3x8YerdmQjSW6Xn76ZCmdAJNqzpeVTbys8PnI8A4aRn
         3BZ9UL2cUefJfb17vp3GxqV94ZIGIVoGxurbUxnygD+VSIWeDEXrgeBoFqPyK1M8/cWf
         2MRoKBwzPonxJXKgBgb757zFzKcd0cJcS4PrM6u6+JDcxdInxkIPg5EwCDC/cg0dJ+Yt
         7JM+bTQzMTNFPbY/iebQh5bZWak+13QAqFQZPCLW5/0Rba5MRURSlmfn6WtU7GODh25J
         rt+HgJNvfZMpg0HvEm7ktkStEHyv+kd9D8cCLL4Y4FhglHIc5aGgNGIfp9ubCQdSOj3p
         LK5g==
X-Forwarded-Encrypted: i=1; AJvYcCX2Q+FvyL1XvlmhLkMjfaEYFxyJ+lGG6YEnqUUemBUa2Pf4oddLDydZpeda4VL/5ljdf5aIyB9S@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxW/gqp/KmrcTxHYFUqjG/JL6PeG3Z1zHBikKN9eTj7C/IOdg
	tk/JpE5heCgOwvA/VX0PhGcj3Z2elQzVMM6vgXzoZbQ69DoHC2aIyYaWZ1l+5zY=
X-Google-Smtp-Source: AGHT+IGIGf+fLyqvRxEZUSRr0al4OL6PJFH2Lr2FvVUL+VpF7BsP3nR5JjnLPEDC4jbvktWXK39Ngg==
X-Received: by 2002:a05:6214:5d8f:b0:6d1:7455:9b0d with SMTP id 6a1803df08f44-6d2e7225ddcmr51294016d6.16.1730234319248;
        Tue, 29 Oct 2024 13:38:39 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a838fsm45773516d6.30.2024.10.29.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:38:38 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:38:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <20241029203834.GA636494@cmpxchg.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
 <20241028-meaty-mega-nuthatch-3d74b1@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-meaty-mega-nuthatch-3d74b1@houat>

On Mon, Oct 28, 2024 at 11:05:48AM +0100, Maxime Ripard wrote:
> On Thu, Oct 24, 2024 at 07:06:36AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Oct 24, 2024 at 09:20:43AM +0200, Maxime Ripard wrote:
> > ...
> > > > Yeah, let's not use "dev" name for this. As Waiman pointed out, it conflicts
> > > > with the devices controller from cgroup1. While cgroup1 is mostly
> > > > deprecated, the same features are provided through BPF in systemd using the
> > > > same terminologies, so this is going to be really confusing.
> > > 
> > > Yeah, I agree. We switched to dev because we want to support more than
> > > just DRM, but all DMA-able memory. We have patches to support for v4l2
> > > and dma-buf heaps, so using the name DRM didn't feel great either.
> > > 
> > > Do you have a better name in mind? "device memory"? "dma memory"?
> > 
> > Maybe just dma (I think the term isn't used heavily anymore, so the word is
> > kinda open)? But, hopefully, others have better ideas.
> > 
> > > > What happened with Tvrtko's weighted implementation? I've seen many proposed
> > > > patchsets in this area but as far as I could see none could establish
> > > > consensus among GPU crowd and that's one of the reasons why nothing ever
> > > > landed. Is the aim of this patchset establishing such consensus?
> > > 
> > > Yeah, we have a consensus by now I think. Valve, Intel, Google, and Red
> > > Hat have been involved in that series and we all agree on the implementation.
> > 
> > That's great to hear.
> > 
> > > Tvrtko aims at a different feature set though: this one is about memory
> > > allocation limits, Tvrtko's about scheduling.
> > > 
> > > Scheduling doesn't make much sense for things outside of DRM (and even
> > > for a fraction of all DRM devices), and it's pretty much orthogonal. So
> > > i guess you can expect another series from Tvrtko, but I don't think
> > > they should be considered equivalent or dependent on each other.
> > 
> > Yeah, I get that this is about memory and that is about processing capacity,
> > so the plan is going for separate controllers for each? Or would it be
> > better to present both under the same controller interface? Even if they're
> > going to be separate controllers, we at least want to be aligned on how
> > devices and their configurations are presented in the two controllers.
> 
> It's still up in the air, I think.
> 
> My personal opinion is that there's only DRM (and accel) devices that
> really care about scheduling constraints anyway, so it wouldn't (have
> to) be as generic as this one.

If they represent different resources that aren't always controlled in
conjunction, it makes sense to me to have separate controllers as well.

Especially if a merged version would have separate control files for
each resource anyway (dev.region.*, dev.weight etc.)

> And if we would call it dma, then the naming becomes a bit weird since
> DMA doesn't have much to do with scheduling.
> 
> But I guess it's just another instance of the "naming is hard" problem :)

Yes it would be good to have something catchy, easy on the eyes, and
vaguely familiar. devcomp(ute), devproc, devcpu, devcycles all kind of
suck. drm and gpu seem too specific for a set that includes npus and
potentially other accelerators in the future.

I don't think we want to go full devspace & devtime, either, though.

How about dmem for this one, and dpu for the other one. For device
memory and device processing unit, respectively.

