Return-Path: <cgroups+bounces-763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EE8010A6
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0041C20BE3
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1F4D10B;
	Fri,  1 Dec 2023 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtQiTnMg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA09A2;
	Fri,  1 Dec 2023 08:59:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cddc59e731so2153369b3a.1;
        Fri, 01 Dec 2023 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449973; x=1702054773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dRbGatx1opBY03QMl1LAqDJ92qlmNckr8hscmiczpg=;
        b=DtQiTnMgqNMo0z3q2fRLNtShFxO0EEeHcKWuyKGSBUCuzlI+W3XIJqwNqzOkGkRMsP
         ixgbsV3z2QxkiUlzIFVnhVhY3s5FX7ZpuP79v7ys4j6iwhumc0C7Nkbbk5yn1vbd0ocp
         TcJS6U9nJSrfhuDOkqDaqBqHwYzlyH4jn9+rzBeWFnC5oJnZSYKLX9AUDbqSmw6HsGpP
         9YENVHpmFFR8Ot+A9yI/CRLa3yCqxrEgBRddnK5ScI2ndq/953fL5NJCsyJkE8Yxiys3
         9G4ca6z3vEjtn4w+OrScdUB/kkKMNGTHGyT1hx89MGwsmvfDJFgA6oPGDyipuf5Z8bxe
         fV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449973; x=1702054773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dRbGatx1opBY03QMl1LAqDJ92qlmNckr8hscmiczpg=;
        b=KwM6NhS2VYDhfr9Aq74HjTnCq95e2nTQWoJCZ+tvlO9VKKVwMS+mleaK/zSxqRuIMu
         Tac9cesDbfxwB8Fo3lh6C30UX3ObG1BDlspe1BQznlHdpvRpGe8y32opAK/Z112dTFH4
         XuJKNeoo5si/cdXU5DktKiRaUMLs+p6LWCCPVT/Eri0Xjwiv/Fy8s4sA7YD/P9RgTqY3
         83qXKHDQojnhnWARrrhoMRc7R0vAWyRqU3uz+SEdLVHuBie0McxTrX/qDTjcU0C+1z/X
         93tfj52fQIBD+v++gLAW5CTxDBL0pM1KIFwzNN5VhRtzMWHq4Db9wFdIybiwzFjmFvuz
         7L+g==
X-Gm-Message-State: AOJu0YxvY/H1SM6wJdReeRW19WamGEnlwydpiWePZ2Z8+5YvWLP96xts
	1i0TtkDYxlGK83pRDfeA5H4=
X-Google-Smtp-Source: AGHT+IHaQXt2nCWUoqLr98KVdxbGpPD4vg9+YHblnrEG2m0hzeYNXnZMAn3OXjQfLt95pfx/lMACwg==
X-Received: by 2002:a05:6a20:918e:b0:185:a90d:363d with SMTP id v14-20020a056a20918e00b00185a90d363dmr29094374pzd.2.1701449972533;
        Fri, 01 Dec 2023 08:59:32 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b006c4d86a259csm3222850pfh.28.2023.12.01.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:59:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 1 Dec 2023 06:59:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <ZWoQ8uroTtMDsBF8@slm.duckdns.org>
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125638.1699026-1-max.kellermann@ionos.com>

Hello,

On Fri, Dec 01, 2023 at 01:56:37PM +0100, Max Kellermann wrote:
> By passing the fsugid to kernfs_create_dir_ns(), we don't need
> cgroup_kn_set_ugid() any longer.  That function was added for exactly
> this purpose by commit 49957f8e2a ("cgroup: newly created dirs and
> files should be owned by the creator").
> 
> Eliminating this piece of duplicate code means we benefit from future
> improvements to kernfs_create_dir_ns(); for example, both are lacking
> S_ISGID support currently, which my next patch will add to
> kernfs_create_dir_ns().  It cannot (easily) be added to
> cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
> from there.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

 Acked-by: Tejun Heo <tj@kernel.org>

Greg, given that the two patches are related, it'd probably be less
confusing to route them together through your tree. If you want to route
them differently, please let me know.

Thanks.

-- 
tejun

