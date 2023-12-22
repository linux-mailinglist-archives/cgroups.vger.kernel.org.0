Return-Path: <cgroups+bounces-996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2C81C40D
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 05:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BDB1F25CD2
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 04:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619D23D0;
	Fri, 22 Dec 2023 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5U4iH1T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A079E4
	for <cgroups@vger.kernel.org>; Fri, 22 Dec 2023 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3a9b9634dso94015ad.0
        for <cgroups@vger.kernel.org>; Thu, 21 Dec 2023 20:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703219922; x=1703824722; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyedNlCjbE+Q4bYx68krhasQrfrx8EhiaTfO6LvPL04=;
        b=Y5U4iH1THZn/kJmXH69IG8NL7xbHR+tOnRv5VqNnIA3pw1RYtpGq7pQzj8+bn0W7G6
         AyZDcRfWC2Xg1KYFnb+MpgtEAwaGOvi6L1Db0CMc84n7gTRJXu6VYu3R494hAJKgV3qC
         7F9aYM0nrvdSO8aMWIc3rTGq1XjDYroi5/DGpozG7Gu91CIWTksLE6XF38S3I5n1zFbm
         7KtvLhAayfQMrV/KsRIEGDovY3RUoDPfa/eMYBSSghxom6rPROmccyO7DJkXBzRCswoX
         NlcIK3ObGdlcbC2j7p4ki8oMTzE3y17PZSyk0mNl2oN/MCc5XaqvB1HNQxT2ZGsdkarP
         ZEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219922; x=1703824722;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyedNlCjbE+Q4bYx68krhasQrfrx8EhiaTfO6LvPL04=;
        b=pVnmK64fs5jXImvU3cDiwNJhJTJkRrwW+89jyDbtPy1XTCiMVU7yw8xXsZSTgrgbUe
         f5GzN70ptCyVUExrj+Fmw0a9iUT9v/30mu/koTi4nXihjmf1Z4xFdwgjg2U5ADSF3lpH
         VKw6fgOzrVoyRIw3Doqbu/ey7CRa96jbMlxxT8lqXV2vHWfvdD/NPnoLQAFqREtF787g
         OZ6ERsjMlP9wdXs3Qzo2aKMgpiz+QdF/d4s5TwE4SbIHnppoRA19fntf3D6oKJoKXDec
         bYD5p8sahfGl4dBvG1xQ+2PUbCnR0o8qJ1Ss5A+QDbCSiRxVhsPEDMLXinpffhPxCJ6G
         8ejw==
X-Gm-Message-State: AOJu0YxOYL1uI89UZhf1AjEOH7lS4Tl3gu8spzbsrak98cJ+Tn9a+OD7
	F7jQTUhc4Ttqp8IKjBNCLYBUZY2eg0yr
X-Google-Smtp-Source: AGHT+IGi06u5ImNRJFBga9p7VnAPha1sQjY12WynAwodGPZhh60I1bpfyFTprcdcFoDzb89iYeB4Vw==
X-Received: by 2002:a17:903:18c:b0:1d4:1430:139f with SMTP id z12-20020a170903018c00b001d41430139fmr58061plg.25.1703219921743;
        Thu, 21 Dec 2023 20:38:41 -0800 (PST)
Received: from [2620:0:1008:15:184:1476:510:6ea1] ([2620:0:1008:15:184:1476:510:6ea1])
        by smtp.gmail.com with ESMTPSA id ei8-20020a17090ae54800b0028bd9f88576sm2626083pjb.26.2023.12.21.20.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:38:41 -0800 (PST)
Date: Thu, 21 Dec 2023 20:38:40 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
cc: Johannes Weiner <hannes@cmpxchg.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, 
    linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
    Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
    Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
    Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
    "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
    Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
In-Reply-To: <20231220152653.3273778-3-schatzberg.dan@gmail.com>
Message-ID: <c93b217e-1983-1eb1-14ce-8377f94975a1@google.com>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-3-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Dec 2023, Dan Schatzberg wrote:

> Allow proactive reclaimers to submit an additional swappiness=<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
> 
> For example:
> 
> echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
> 
> Userspace proactive reclaimers use the memory.reclaim interface to
> trigger reclaim. The memory.reclaim interface does not allow for any way
> to effect the balance of file vs anon during proactive reclaim. The only
> approach is to adjust the vm.swappiness setting. However, there are a
> few reasons we look to control the balance of file vs anon during
> proactive reclaim, separately from reactive reclaim:
> 
> * Swapout should be limited to manage SSD write endurance. In near-OOM
> situations we are fine with lots of swap-out to avoid OOMs. As these are
> typically rare events, they have relatively little impact on write
> endurance. However, proactive reclaim runs continuously and so its
> impact on SSD write endurance is more significant. Therefore it is
> desireable to control swap-out for proactive reclaim separately from
> reactive reclaim
> 
> * Some userspace OOM killers like systemd-oomd[1] support OOM killing on
> swap exhaustion. This makes sense if the swap exhaustion is triggered
> due to reactive reclaim but less so if it is triggered due to proactive
> reclaim (e.g. one could see OOMs when free memory is ample but anon is
> just particularly cold). Therefore, it's desireable to have proactive
> reclaim reduce or stop swap-out before the threshold at which OOM
> killing occurs.
> 
> In the case of Meta's Senpai proactive reclaimer, we adjust
> vm.swappiness before writes to memory.reclaim[2]. This has been in
> production for nearly two years and has addressed our needs to control
> proactive vs reactive reclaim behavior but is still not ideal for a
> number of reasons:
> 
> * vm.swappiness is a global setting, adjusting it can race/interfere
> with other system administration that wishes to control vm.swappiness.
> In our case, we need to disable Senpai before adjusting vm.swappiness.
> 
> * vm.swappiness is stateful - so a crash or restart of Senpai can leave
> a misconfigured setting. This requires some additional management to
> record the "desired" setting and ensure Senpai always adjusts to it.
> 
> With this patch, we avoid these downsides of adjusting vm.swappiness
> globally.
> 
> [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/Senpai.cpp#L585-L598
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>

