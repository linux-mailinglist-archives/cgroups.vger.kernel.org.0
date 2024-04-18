Return-Path: <cgroups+bounces-2591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088178A9F65
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395011C21359
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDC16F849;
	Thu, 18 Apr 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBidoEn9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D915D5AE;
	Thu, 18 Apr 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456048; cv=none; b=mjISVEvVtxIxqEUS0ML5y5at1Zk+4K6cWdjmO1SRezjcWBx0q/jEJvw13z0QDLDq0/T+Zz1DtY1cx6Kiyelyv6e5czJF2do9VtzNPRt5eA5kQTvblut/yfhvJYXz+ixu4ZDGRkfQIoZy0Bcap4qriFFutBfFPe5PdlxAIenwDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456048; c=relaxed/simple;
	bh=2tvjJQzckk7me2qDQz2+/czKkqYeyc4qjDGM18IMo/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIWgliBNdfKnradyvHu2pbYTzE3nLhVhN+jLK3gpBI/XgnQIHcJhf8yjE7epAnB5w8/HkwhYqZZ2hWweit7qz2q/OUYsxPjg4GmCSNKMrEFQJrWVgTkz61mgDwTehoNE+JC1q9Dsottb3crxwsTwixDwlWkkHYRIlwHra/cDDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBidoEn9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4266673bbso9560005ad.2;
        Thu, 18 Apr 2024 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713456045; x=1714060845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ8NnE95Wng2cbF08yApBUNklEsbuY7jF+Twef4QuI0=;
        b=VBidoEn9MxhUEdWJNlWJzYEkSoPovRp9yRuHYCa3e3WTRNg1plIC/etfwIDPKdF2wJ
         Oer4y+g5rPofSpcWRSqk6JS2I7IGCIi54c4bKAt3l5EiP3t+900ZcE/J/nHmW/xbTs8P
         zvzFy5Cca9kn+OwN3T937+RXdAm8rPHy1ozsYFi4GrjYr5KoAxhViBYVUIkeiWF8pIJk
         rLTaKWXAvmpLqiwtG0OrpZsrP91MhkYqlxjipNEUGlQA9oIlhqAZvmDK3mVrQXLETSIR
         7TWzrm56hVOf6OrbiOkQLSHqn9LwrB77OgAyYl8Uo07JeD9mxnhRFhgM2NTxSI5o1KST
         2DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456045; x=1714060845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ8NnE95Wng2cbF08yApBUNklEsbuY7jF+Twef4QuI0=;
        b=ObouYg0jC61OecC88ihVMEOKoV7UsRA/b2iUqmDaOf7zzC37bBNr0jkSLbxiHmPpcw
         xEsUGHPf4+0/Ud3KZbreTuiKk+d8rRQVYSFqtg+28l5VcEShDAX+tmepCeukWwj23HCW
         KDNQ6ef0WkWzdBTJ8roFfvHwAmmrTSCx2Ss2ycsILJyV4V7uDTBgetckvEcIUwKCt4Lh
         gZqoYLzq21CoiJUjM/w3keAp39/oxA7wuJDfVrTIYT+4CUNyQ4PPn84stK7cV8rJgZU1
         +lA4JAD3pXhbtcjGOtvzAihSnPGECDvTKfdSumoGTk29UmOck+Y3R7ah+uLMikOpxhVu
         jygA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8pM583nGABDmI6OMx0U5b6rHS/yA8U/OlH9p8Im6VjCK34opuV7p2R/QWDCaitCG2QOSY3fSDIHZHpM9tlaC9hx4yWE97qkZhOAxxpTSG/iAUx53GlWMUMrCBcEWODmd7xS6TlMg8EOFe+nG/izJ5+aM09wwPxOSvB4DY+OZMg==
X-Gm-Message-State: AOJu0YzigPnjsU8Btwgm7NARFaPjvr6hCIRtapNqkTumJaeYLkeeoFUx
	I/DV/F1PDH5yfHmSc9rS5FPtcPyemULtIs9xkH2hPSx3Ox3vfGUw
X-Google-Smtp-Source: AGHT+IE4e7zmJlTVm+rOJDjXS8ojKP/o+9OmVobTcNe+p/oMU7S06QGA/ADKTuXfUm0fMYIAFgeE+Q==
X-Received: by 2002:a17:902:e742:b0:1e5:4f00:3754 with SMTP id p2-20020a170902e74200b001e54f003754mr4096356plf.8.1713456045245;
        Thu, 18 Apr 2024 09:00:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001e4478e9b21sm1673804pll.244.2024.04.18.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:00:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 06:00:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH -next] docs, cgroup: add entries for pids to cgroup-v2.rst
Message-ID: <ZiFDq5NuAKLYslmn@slm.duckdns.org>
References: <20240418123012.916411-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418123012.916411-1-xiujianfeng@huawei.com>

(cc'ing Michal for potential conflict in the pids controller documentation)

On Thu, Apr 18, 2024 at 12:30:12PM +0000, Xiu Jianfeng wrote:
> This patch add two entries (pids.peak and pids.events) for pids
> controller, and also update pids.current because it's on non-root.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

