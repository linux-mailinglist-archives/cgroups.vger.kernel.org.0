Return-Path: <cgroups+bounces-762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C3801089
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22A01C20BC2
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506E4CDF5;
	Fri,  1 Dec 2023 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUAy4dfT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3164CF;
	Fri,  1 Dec 2023 08:49:55 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso2141752b3a.0;
        Fri, 01 Dec 2023 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449395; x=1702054195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11ou66UluPNip5iPUEMz1bOTL6KFvy+e30+wBtqFO7k=;
        b=CUAy4dfTVnX5DrY48LOC1WY07/u6O1lv2J8O+QEgaP3tQM7+xUcdo4bVG1j3gfu/zw
         7qYss6g8R4ktwhrHZvoS/bKQHKTAWzBNQVsrPxI1gZnKy3ACr70adXBfaCbV/jfNZdvt
         y7f5jVV2n+caGywjHYdmU3TZ91gRoUhcm/CHx+LD5d295Fmof4Su1TT29b2yXgRPR5gH
         VDHc5Sy7T23lcoeuZKMCfsjNu5ORwEzggp4pyZiE8Fzg4lnaKXjehDN1DN5eGuGNwSE9
         vIgTD78QaQ6Ij5jMb9o9G/BAHv9jugObEWuwTZqB5b3hm6RKXpkzAGt4gblnAGfDU0M6
         fGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449395; x=1702054195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ou66UluPNip5iPUEMz1bOTL6KFvy+e30+wBtqFO7k=;
        b=cwIJxQD/6SdhFj1bvNih4twjowubSrxoFQomaPE6zrCmxKbZoEzLFIsgut9eScOvmv
         rIXjdHYOpT5blvtHlCu5Jo101pVRuPomzEjMs+XpBmmyo4EbpMFR9atR+Hhny249tDqY
         uoojtNuJnkouOAC/e79MvCX/VJyF825P/2pQHhyEVRB3QDiQJFrqApJ448g5Gmb75Tlh
         dCpdK6iDoq3KEvjyRdbKf8RaSE9luL139y963INp7p/EQ43VqgSYIGf4TBjLIVz8dozP
         AiaerbfvwIC4PTXzLpEOrmN9TArYQcnv7l6lWP8VoFEm1ivlxnHdZg7IjLI0p/GAQ3sQ
         i/jQ==
X-Gm-Message-State: AOJu0YzzzzCENSKbxqFd1gkUtyXZ/oFvR8TteU5wJshVKsaDBrMSC5yz
	Hu/mgWmSRb1VaOGgBLUvrNY=
X-Google-Smtp-Source: AGHT+IGmo9alJqDNAbyy72Z1TYkvlIwxF3W9YJmNJvz2d2NFr4GBdh4nRx8GimlOEVnVBiMStIaBHg==
X-Received: by 2002:a05:6a00:1d01:b0:6be:4228:698b with SMTP id a1-20020a056a001d0100b006be4228698bmr28845548pfx.20.1701449395051;
        Fri, 01 Dec 2023 08:49:55 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b006cbb56d4e58sm3195075pfo.65.2023.12.01.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:49:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 1 Dec 2023 06:49:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Josh Don <joshdon@google.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
Message-ID: <ZWoOsIH1QGW80kL6@slm.duckdns.org>
References: <20231201005203.309873-1-joshdon@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201005203.309873-1-joshdon@google.com>

On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
> Two problems:
> 	- cpu.idle cgroups show up with 0 weight, correct the
> 	  documentation to indicate this.
> 	- cpu.idle has no entry describing it.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun

