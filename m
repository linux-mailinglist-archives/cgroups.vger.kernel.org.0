Return-Path: <cgroups+bounces-3667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DE9306BA
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BF81C21A0F
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D613D26B;
	Sat, 13 Jul 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZV8d5mF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9822097;
	Sat, 13 Jul 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720892130; cv=none; b=Agfka/HZuHskv1c1UAW4veymyzkIzxGVWsTCjRpmpM7T7CAJcPJgfNnmpja4ArwALWMjoV+GXAeVTOBvk6OvS5fjhhU92g+EGtCVM5hqM3mYSDXedoQij2GLN50BGH+tTaDjMQTxFqXDA43A299idbhLnSUWjVqe+/mgnuLBTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720892130; c=relaxed/simple;
	bh=+jnLG0Fr2OjsjvLbG9Ojqjh1KhRzmEHrMLuEQFOkJx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2B0Ers1xCy0PR3Oycw6Az8PF1LGoLtnhQha3qSobLmztJgdXDSNVGK0K65ouQkhXcjO0STNWJ+jvv+w5uE+40XrYwLazEaB3o1Icm9swI0Ke/eIpsX80gblVcvTGO2YrQd+gvyzELEWx0okOKeOFwoc1V854gjGW+Mf10O84Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZV8d5mF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc681ee4so1595379b6e.0;
        Sat, 13 Jul 2024 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720892128; x=1721496928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/z/MjDmwb7f1zxziuaLHYeOx76PjmytDEOERDpZ6t4=;
        b=gZV8d5mFCzl2FEDQSvzpdjTWYOjkOFb/5MLedDitBg0LFHVBNLnB1DJs0XU9G7VB+Z
         NgVVUQVDk7Oq17Oun/ZrtgILT5l5kcAfSVqUq5315sRvyHNkSSQTSFd+Sj3Qd+GlZ7Pc
         Evk2VriW+c2Trnssm1G44yf9/uqMtFu8sZ5M/OQk3ImolYCtJFy07by9Yc7BL20THEcm
         V3rpqOHsb6myDBudpXM4SznqzgbxiIA9qiwyMcbI4yP322gqbO92vDPCVsoCRLvT1YvO
         oznk2wml3aDoyKoh4ngrHHddP+xelotEyf8lfoZ7avsQQEMQCULOdRSclBEo8Y37fasI
         w0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720892128; x=1721496928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/z/MjDmwb7f1zxziuaLHYeOx76PjmytDEOERDpZ6t4=;
        b=L9q9H1klcEXMhLoaNZh+T4N+ZnyuoKjH84pTHMnIoT8LxIFe7/Cbpo2cHE5jTy+KpG
         tlcR5y1dZsy70LPil5ZLzHhkihkC94zOr7Z9Zy6/ZNY9omJADDJgc+WLiKvnMuXhAKl/
         6aydBL22e38u8F0FJoAqRBHZY7sGVieWuHSGngHQ46e9Pjo5n7+5rMK7uVYngiJBase1
         YB3xEalwRQY+sBHBTjxMfbUA94U0XUSCL7duAaDbhVpMLS3q+ajYFpqkTqc62cVdAOZ+
         OBR5SwicmN5u/6Ri9sWMNJgTXKW12J5KAfJ5RFjwKztFg1br2g354jl1f5ZcmH0HQdyD
         /CAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTiL6rFd8OceVlZbTSWT9XuL2GcxZRjl6T2U+WC0wfy2AkoeSEBmn8NTHn50GDnnQ0PkmRCsUwdx5F+1PGOJmcLHN+m1Pxa1Bh8gYnSis9H+EtaMPacDJ4QiWqZu8EyLA3Uu+RsUrPxCRMEbvNFxlaUQROpNi23CZdDVojX0YV6tP+
X-Gm-Message-State: AOJu0YxqEXsdKnOHSzxjB6gtpCN2ygUpGJCnmX/+FqN41APci0XGk2Mj
	yDQ3Q4l/+k49ddkxOunwcnUE/ovtTkD6OcuDxTPHR/Ab6k2JXDaO
X-Google-Smtp-Source: AGHT+IHoZqfQDPgzJUnfokLQqFz5qFXhiTmF1BuCY/zvSBWE7r65z6xFnJvI1G8KyRWXpUc80J0+gw==
X-Received: by 2002:a05:6808:148b:b0:3d9:385d:8747 with SMTP id 5614622812f47-3d93c04356bmr17627614b6e.32.1720892128043;
        Sat, 13 Jul 2024 10:35:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e32b6ba67sm1076129a12.11.2024.07.13.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 10:35:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 13 Jul 2024 07:35:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, josef@toxicpanda.com,
	axboe@kernel.dk, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
Message-ID: <ZpK63tsWBNMGFR2t@slm.duckdns.org>
References: <20240712085141.3288708-1-xiujianfeng@huawei.com>
 <ZpFlsrNMMUMnT_Lq@slm.duckdns.org>
 <a39656fd-f34c-fa69-7d20-8b86fc1cb0c4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a39656fd-f34c-fa69-7d20-8b86fc1cb0c4@huaweicloud.com>

Hello,

On Sat, Jul 13, 2024 at 06:56:57PM +0800, Yu Kuai wrote:
> 在 2024/07/13 1:19, Tejun Heo 写道:
> > Hello,
> > 
> > On Fri, Jul 12, 2024 at 08:51:41AM +0000, Xiu Jianfeng wrote:
> > > The congestion_count was introduced by commit d09d8df3a294 ("blkcg:
> > > add generic throttling mechanism"), but since it is closely related
> > > to the blkio subsys, it is not appropriate to put it in the struct
> > > cgroup, so move it to struct blkcg.
> > > 
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > > ---
> > > only compiling tested
> > 
> > blkcg is per cgroup and blkg is per cgroup-device pair, so the change isn't
> > just moving the field but updating what it means and how it works. The
> > change needs a lot more thinking, justification and testing
> I understand blkcg and blkg, however, maybe I'm being noob, I don't see
> how this patch is related to blkg, the change is that 'congestion_count'
> is moved from cgroup to blkcg. This look quite straightforward to me,
> maybe I'm missing something, can you explain more?

Oh, my apologies. That was me confidently misreading the patch. Sorry about
that. I'll re-read the patch.

Thanks.

-- 
tejun

