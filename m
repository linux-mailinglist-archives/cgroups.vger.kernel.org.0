Return-Path: <cgroups+bounces-1084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F33824A8B
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 22:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E211F2544E
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9862C857;
	Thu,  4 Jan 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbdfzHOn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32012C850;
	Thu,  4 Jan 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so699872b3a.3;
        Thu, 04 Jan 2024 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704405472; x=1705010272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egHS+o8XmTRrz6Xl0CS5lT3RaLGscP5yKRKwuMkxu20=;
        b=HbdfzHOnhF0SMEdkzTVBeEXZYBShqGFA2EvcJsHC5I2GBP8NOoEmw7LMqh5J2Tm7sN
         bFq4nAnj1954lAd3RBLpaGr0SkoEGd6vJ+C60iubG4y7Dy6B+vDeX0IjxtnNRbafzxaT
         42e2O2k8hhnIY5TVwfUSwqg7p7aTgbevlNLny9JHfYBm52PZJE9rSW7jiU42IBpcPMqU
         TiFImo0u6LJJwIabpvQ3MFQ2LNjLin2JcUJLnbCf7So1XbuEc9miHE+J36to5qLeMmop
         KOrVIwtsdANdLx4dZDlrA+3KGJr8OH1fd22bu+4v8Pvh5928f061OZJuKJowXWhogbhi
         4stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405472; x=1705010272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egHS+o8XmTRrz6Xl0CS5lT3RaLGscP5yKRKwuMkxu20=;
        b=UCysPV11bhEiUTREuHNKPOqlqdFdzGR/FBApNsozduwF53u3TFJCArkgHO9rEYcwbY
         f0frQE45cPkIF+yDALSxbGru15gcdLVRTlnTwnidD9h3jFk6eft1APfaAopf373ayoHV
         5kv++4AezIZMLhF9lNyOgP89lQnMg4Zlqqu83NTljPQtOgwdSyxTs5o7RsGDtpeGkljv
         dGA+21S6OV/eEjwjwe/msN5WZ36Aj/abkGF8gMYzPG6QWAuswZk41nIpLq7KpNxJFjTI
         qN+YYwOLPb/GLNXAqkyK1M3PXDg7VHXsRPVYUVeznIfiKjvvxcFYqcvUwonJeVF4m/IY
         rv+Q==
X-Gm-Message-State: AOJu0YxEbJlfDsFougeV/sRTn7HEbnut7OHo0ZjiexFboWW0h28NvUl/
	OrtuXuqbQbPw35yMG0mPfYc=
X-Google-Smtp-Source: AGHT+IFjNZNufWHFTZQUVgsfqz2Mj/lvykqlgUgeQzS16YBpxT0iO7eliCi/lNUAkH396cD4SlGf3w==
X-Received: by 2002:a05:6a00:1949:b0:6da:e0a:9b19 with SMTP id s9-20020a056a00194900b006da0e0a9b19mr1332223pfk.63.1704405472083;
        Thu, 04 Jan 2024 13:57:52 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id y14-20020aa79e0e000000b006da04f1b884sm128318pfq.105.2024.01.04.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:57:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 4 Jan 2024 11:57:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Message-ID: <ZZcp3nKecqfxxH4Z@mtj.duckdns.org>
References: <20240104180031.148148-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>

On Thu, Jan 04, 2024 at 07:00:30PM +0100, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.
> 
> Signed-off-by: Daniel Vacek <neelx@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

