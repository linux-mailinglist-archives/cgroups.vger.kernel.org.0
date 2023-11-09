Return-Path: <cgroups+bounces-292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186917E7390
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C33B20F1F
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB699374FB;
	Thu,  9 Nov 2023 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfJ98Mw3"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD7374EF;
	Thu,  9 Nov 2023 21:22:55 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE03C05;
	Thu,  9 Nov 2023 13:22:54 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1f084cb8b54so805092fac.1;
        Thu, 09 Nov 2023 13:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564974; x=1700169774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9l8rMnrLS77Ww0OVaBo7dClbXZE01PHbsv02FqZtAQ=;
        b=HfJ98Mw3o9ywsOT8KxWnxpCUd3mer7jPX1EMe/xxXtN7F26e47iWFPOSc+FG59/YiH
         8i3GMJuygo6mUF7gG1OhQhPHRBrDnL4g+irgLNpvkDhtXfNVrM6YUiVVyYXBz9D7PUgJ
         01S9MkZg2KRUyvdj+MzLZPKBhE7enHmLYtyJVLOv1tjjQttSZDzKM02OUGF9zmCyPpvS
         yKTyuFA2ayFtkLGnV00OlBGEadPz1cO0GniL3Q2Wil9wv0LXBe9tOQagjxaxhhlB5t9R
         T6B7BAng9Ogxwa3ZxMk6SHAMm7JrR9GIIdwqRKrN0SnXeWYYrfi6RC+K2P71Ok5vSnha
         8nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564974; x=1700169774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9l8rMnrLS77Ww0OVaBo7dClbXZE01PHbsv02FqZtAQ=;
        b=N9gsrr0LvJPlPHiX3yskLnfvwTBga9NrF69aahCkk8WRIe0ZoI9N8H1J0Nhd47XlwT
         8dZnTyOVEeNhlsDAlozFhWwN/n/V48bpKYgCf6TD1LPMHD3br5cLoeqhrGnxkAb9pGaB
         ArW1X1seYvSRu/qIA3p9tvjgy7SFRv4NVfA5bIaCIzqy6unS60K1KiVQ/H+qecSvwg3P
         ruH55rd7/FjStMJILmwdGgkHUhRw3vB2pUup3xPv2EHUsV7ByPSDoWx4m+r9k1VkcWlh
         NSKWvodIWFvm2AEjcIZVIZbEcX56pRaL5HmIQ0nrRTBcESL2jleQblDMbPWBBbj+M2EE
         T22A==
X-Gm-Message-State: AOJu0YwUHo2KPmx5uzUvAKsds9Lk7LaQPwqRhRC3hl0LQLv6NO47swXP
	K6wukrefleYP30I6C3lSxtw=
X-Google-Smtp-Source: AGHT+IEF54SjnqE1JgjVGa+D6sPHSJXJSQFluQ+14qbTqX0uwGFlENvM5xjB1RXzR24QY9o4M/rRkw==
X-Received: by 2002:a05:6870:e154:b0:1ef:bacc:e4d2 with SMTP id z20-20020a056870e15400b001efbacce4d2mr5158827oaa.28.1699564973996;
        Thu, 09 Nov 2023 13:22:53 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a0002a900b006c33c82da66sm11168304pfs.75.2023.11.09.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:22:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:22:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 04/11] cgroup: Add annotation for holding
 namespace_sem in current_cgns_cgroup_from_root()
Message-ID: <ZU1NrPYbAPOnU7Hf@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231029061438.4215-5-laoar.shao@gmail.com>

On Sun, Oct 29, 2023 at 06:14:31AM +0000, Yafang Shao wrote:
> When I initially examined the function current_cgns_cgroup_from_root(), I
> was perplexed by its lack of holding cgroup_mutex. However, after Michal
> explained the reason[0] to me, I realized that it already holds the
> namespace_sem. I believe this intricacy could also confuse others, so it
> would be advisable to include an annotation for clarification.
> 
> After we replace the cgroup_mutex with RCU read lock, if current doesn't
> hold the namespace_sem, the root cgroup will be NULL. So let's add a
> WARN_ON_ONCE() for it.
> 
> [0]. https://lore.kernel.org/bpf/afdnpo3jz2ic2ampud7swd6so5carkilts2mkygcaw67vbw6yh@5b5mncf7qyet
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Michal Koutný <mkoutny@suse.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

