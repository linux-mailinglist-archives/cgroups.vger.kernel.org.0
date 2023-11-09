Return-Path: <cgroups+bounces-290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DE7E7378
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE322811F0
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4C374E8;
	Thu,  9 Nov 2023 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoVjHHH1"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA7374DE;
	Thu,  9 Nov 2023 21:19:46 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382BD65;
	Thu,  9 Nov 2023 13:19:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc53d0030fso11789475ad.0;
        Thu, 09 Nov 2023 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564785; x=1700169585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LX5y+iaQf1po/cv20bnKPKtRsqD9RuKdrMysiV1f6ro=;
        b=FoVjHHH1klIiYgtnhoCJf1sqt5xXSeo5yPmWRszEwIMdSwpN6ivUh17YGwRji/kiJt
         QduPjTTh3o52yPnpvtgDsGeMLYRej4DOYd0fN/lzcgmH9VDNDtQsvCPKfvfFGI8OKiFn
         54yp2OAfpHW3v9bRx3DTMAaxJzIC/tkVM+xpqqnN1NIIvN507EAVPRbeES6OIcJRauiq
         uIpEG9bQfpDe1uXKAfx3H3gos0pSG+JIXn5U3UzK03XydiVbN+BauvD7bPKNHy7V4zkF
         7GsLdLp1hxXc5kqnjs7JMm42o/2eV2uBmMArT7gqt5k89ZgVOWy6MG5WR+GY/hGai4od
         CkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564785; x=1700169585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX5y+iaQf1po/cv20bnKPKtRsqD9RuKdrMysiV1f6ro=;
        b=rRKFV3TqiK7TBotvUbQDbJeyya0R1gY3ByNdiliJcNRsZh36NOefDeWE1ehPxhR6Rn
         s1VyxVHIKuPMcAdbpG3hF9pANS1qoeDvaSbtGOrzQmajPg+8k6jWgcwyVJYnLSe2+bum
         79J4zM/IZuIzHh1xwJRsiAhCSybogpwpXzQIZo1RL/tXUSiKT+kp6TThwW3esVxyUhgx
         FfkVJIosJE6/9hvvqER9OYC0SKVpd08uWU0cGPv75964YXR3ixDHBtBFjJYqiiasgk10
         ZyXeIPjnJ6tTnL/ROC3FIfiuCNhBvXc7PSuNQlcsbGAKJPEyn2SEOYgTIZZeWYdBhwzX
         qB0g==
X-Gm-Message-State: AOJu0YxE0GN741eh2Zj7LZVMCH0cVHSdI/tWOst9CsKiHTRf5NAFTwEE
	6Rwc62ch2NJPg1rng5hjbLs=
X-Google-Smtp-Source: AGHT+IHHX6YpvE/k0cKYCEO0LlxVWGgM4jCuwPYoingJbCsdNuakGtzXA04rcGaVT2NFvbci1EJsGg==
X-Received: by 2002:a17:903:120d:b0:1bc:1e17:6d70 with SMTP id l13-20020a170903120d00b001bc1e176d70mr637433plh.24.1699564785332;
        Thu, 09 Nov 2023 13:19:45 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001c62b9a51a4sm3936632pll.239.2023.11.09.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:19:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:19:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 02/11] cgroup: Make operations on the cgroup
 root_list RCU safe
Message-ID: <ZU1M77i1VTvi1_zb@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-3-laoar.shao@gmail.com>

On Sun, Oct 29, 2023 at 06:14:29AM +0000, Yafang Shao wrote:
> At present, when we perform operations on the cgroup root_list, we must
> hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
> we can make operations on this list RCU-safe, eliminating the need to hold
> the cgroup_mutex during traversal. Modifications to the list only occur in
> the cgroup root setup and destroy paths, which should be infrequent in a
> production environment. In contrast, traversal may occur frequently.
> Therefore, making it RCU-safe would be beneficial.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

