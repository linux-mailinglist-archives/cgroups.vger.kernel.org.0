Return-Path: <cgroups+bounces-467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A697EF789
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449E31C20901
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528C34546;
	Fri, 17 Nov 2023 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydMXmX9V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC749E1
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 10:47:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3020799a12.3
        for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700246841; x=1700851641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UYHVGwHTVzVuxM8RzUzotfpguJIJGc4DIOwNG3E4Vo=;
        b=ydMXmX9VI6EETb+u2Ct3ykw6onSgLSTBPV6I3Nt2+wRlL49TArtxz3b6kcaoczcOjC
         DEnoHWJrh5UxwFNs00zo68OkG3nWYAe2n49QMmevlccktsP1pBNgTfyPWdpn4BnQTJ+s
         Pu8SIQ53JQNAJ/txJv9+dOyzxaO3c2Fd8+LL37+ydyZ9Yojq3ae0PbAuuObdRM0UU+SK
         3ADVpAC6Hz1boPA4RASDtrMHR2U46wGPjQh+4oGheai6gZvPLuI2zVVuyWfmnOdaOgXL
         KSSGzHWC5AkBLf3lkMH7g/uc5pjXebyaQmBxp30Bx8NMkSQiPwfpC97FQqFmIZ7wVqMA
         TV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700246841; x=1700851641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UYHVGwHTVzVuxM8RzUzotfpguJIJGc4DIOwNG3E4Vo=;
        b=bmGunlbsA7m089lNtvHuX3bJPrKOjn2TXN+eJSalvkw7CwLjxh2dxF/L0YvbUQxpmD
         AKi/txHzy5Y16jrV3EbSn0I5etvpN5KK4KSirGF4i8Rgg777JWjExae20zSKBmfTLJb7
         H+trmpQbgfiUtMojgkpJNY+MCG67HRViKj5BF+o6/QrZ2gsdRGvFaUSc5LXXuQGLo7I5
         gBN6DvQlbJ+kEVn1rRrWpGeMaZziDsrsbsT2YJegG9QPibWdp2wH/BqyR8sUghJAVO1y
         yi5130CJC9uAAVeLDWsC5c97mijYvxs/MmBB53r01s7Qyx0Lhz6agpCOwaCJmVAVzqaK
         xYPg==
X-Gm-Message-State: AOJu0YxnxCbtU+C3nLg8chfbnJFpzapT43QaaQseFxlp8MBZmsklSiHD
	dRKiv9IgWO5xsuiB9zAXm5OKEFX11vWhpg==
X-Google-Smtp-Source: AGHT+IELM4olyOpxFGTJoycJm0dmMIHlYYXJyWZCBmiWMx3xQe7D6wloetMKLDdP7EjqMkyPUX2yL468BKu59g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a02:691:b0:5bd:bec3:316f with SMTP
 id ca17-20020a056a02069100b005bdbec3316fmr1467745pgb.11.1700246841320; Fri,
 17 Nov 2023 10:47:21 -0800 (PST)
Date: Fri, 17 Nov 2023 18:47:19 +0000
In-Reply-To: <20231116022411.2250072-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com> <20231116022411.2250072-3-yosryahmed@google.com>
Message-ID: <20231117184719.2qz2ia6j7rlvq62o@google.com>
Subject: Re: [PATCH v3 2/5] mm: memcg: move vmstats structs definition above
 flushing code
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 16, 2023 at 02:24:07AM +0000, Yosry Ahmed wrote:
> The following patch will make use of those structs in the flushing code,
> so move their definitions (and a few other dependencies) a little bit up
> to reduce the diff noise in the following patch.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

