Return-Path: <cgroups+bounces-2450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707B8A355C
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211C6283130
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBD14F136;
	Fri, 12 Apr 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6wVugVI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAE14E2ED;
	Fri, 12 Apr 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945138; cv=none; b=F98WDN9D7FSRPljWPbHJWHrb5dSSzBoq6+XZxTSHy4lL3MrDIIjpG4qIU1HeVrbSGUVE/0A8hxUdsjoqiYjWZiuEjzdN0YzarvCAYfANU9LfjQiP8o/0dqkVbp7DQv4odoPg1FGieppZ+n8zhSZf5M6D/rWWlYv0j/Y1BnOHzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945138; c=relaxed/simple;
	bh=/F4Q9+7tbP9ySS1ScciWSXO7ebXpuvtEIyWrRaLQfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2yhzEjdv1RvVqahVrzEuMXfhNnxLMBduNydNlyV4QmMq9Spi/r0qXnCWT4AgYtfmYxAzOZYBXiImVrdZY1suFlAItKVrB6DjtTVBUmuuBR0+y95OWMn/uzu3iQ/1wOkP7LHhFsEYgKFg1TZes5u0iHAQGwW5/LpucYdoQSCse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6wVugVI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e51398cc4eso11726835ad.2;
        Fri, 12 Apr 2024 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945136; x=1713549936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49adEIqrpP0J1XcwnyVGewM/PJvauGE++ZVC/WjnIFs=;
        b=f6wVugVIjJFqYW/pwsiG3XsfpKdc1iNGd2n5QOehJw2Am6Z67BTGHATSDMOG5ythNM
         SUhBlysC/8VHEiFa5VbICoxM7vRY13dfXUiiPcnkyJ5puTRJUtUZrK77JSVbndnoCo01
         25LNK1kedGD3pVEV7uWrP+kcXILo8VeHbVQSb1Fyzp8LUH2Bnc2epx8W2O/fx5dfsxBw
         DOgQBgYOas1JaDZG//TNy85IUqacXKEBJtEVT8wZDKCssvXOd8O3yLsYLsTd+nbFke8C
         UzKMX2dHakY+nkC08azWDMytbGFRleB1/UWM0SJFN8lYysXl4PUHdrqLQAJ2eb5ApSv7
         g24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945136; x=1713549936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49adEIqrpP0J1XcwnyVGewM/PJvauGE++ZVC/WjnIFs=;
        b=WgZwL05vnbE4wbt0gDODQ3nGWrArJXQKSGrHdgwJ1zm3IKbHYAVUrNq4O9zzjFRlIn
         kK4lvmMagzoD9xP8NL6n8VXquUnUAPNJvrnA4dxShCEgxiHz1w4333YPVKN7774bI+wF
         CA1MqgcsIQLM60RGsFW6KkVWLxuYW8largZv5ong1gCrNsNqfOS6yacg8pCTWATBbJcT
         lLgBQGl5tn8HXLjOr/QjufAgZdf7cLbEv2ZVKq9eKCRZi9/Sdr2qrlsHCEUlSjbEUPBX
         dT8dFO8q+aOt5UkP4TpSZ5Z7nukD3i/AwQ9n/UYZRod+adaSJ22jjL9VWXu2wl1FvOFu
         +Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCWoKy9plTODS2he2bMTJphyY7dfijzIRUUm0NNkRn73rgfRUWn2IKtwlTYcW+W6jdC3VB7db66jaE15H/nqohxKBkaKS+DOEyluxxvSPgMhXPvPUvvw0TZsCvjBhNsXc5lNrNSXrp+py4m1atOiTnkcjAdsz8ipgYF7e6WURHOCfiCx
X-Gm-Message-State: AOJu0YwsKHDokGGqTfM0cJ9eVwxMpvdHD/wIycFwk3dkbv9D6jMF45EZ
	Qu2X/VNmjd4EuKzf2bXYjPyyOgZ5hpYekdxzXSjlVEb1Cmey6pA2
X-Google-Smtp-Source: AGHT+IHYepwYRiV7O2n571JUT01a7WtvHGmQaaatE8xYsUy/fnmFllAFfc3bbHk4zZ1c/m5U+E2KjQ==
X-Received: by 2002:a17:902:930c:b0:1e0:2977:9dfc with SMTP id bc12-20020a170902930c00b001e029779dfcmr3236218plb.55.1712945136393;
        Fri, 12 Apr 2024 11:05:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001e0e8e4f7e3sm3256013plt.206.2024.04.12.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:05:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 08:05:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de,
	zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
Message-ID: <Zhl37slglnnTSMO7@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-6-yukuai1@huaweicloud.com>

Hello,

On Sat, Apr 06, 2024 at 04:00:58PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently once blk-throttle is enabled, it can't be destroyed until disk
> removal, even it's disabled.
> 
> Also prepare to support building it as kernel module.

The benefit of doing this whenever the ruleset becomes empty seems marginal.
This isn't necessary to allow unloading blk-throttle and
blkg_conf_exit_blkg() is also necessary because of this, right?

Thanks.

-- 
tejun

