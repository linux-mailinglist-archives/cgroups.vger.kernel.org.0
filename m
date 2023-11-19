Return-Path: <cgroups+bounces-470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0E7F0708
	for <lists+cgroups@lfdr.de>; Sun, 19 Nov 2023 16:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F17B2097B
	for <lists+cgroups@lfdr.de>; Sun, 19 Nov 2023 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D06134C5;
	Sun, 19 Nov 2023 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE6e3UU9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C421139;
	Sun, 19 Nov 2023 07:05:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc34c3420bso26576695ad.3;
        Sun, 19 Nov 2023 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700406333; x=1701011133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZunorBu+pSlhXgVxLKtqIO/zrvDIVnpRCfzitU3U4Kw=;
        b=RE6e3UU9As7x4DWzgzlHI0dbeoeAUfZPOW5W8wGDkcfA8ColiCtGruOh732B1XNSLy
         B8GPmbUL5zenValbIWl6vpSgxNDOh2dex+yGfih+pO3D0M+sF+dQBaCFh+KDb/oKnSEa
         lD3vy2VgpI4Je4NHgO/pP5JV9gf0pJKfBB9QFxnMCjIo9+TDrdYdpP/Jt2eopYrktsvr
         9u+VG7cnJfM/LLiG/A9kIW7hAN3b1m0scsTU7HhwCYk/xydPXoy5Y303pHvdH47KNWiW
         /Zn+iammuv6SIhoLpjl3rjm0P8pJHgr2/6a6n6UKO/amdj4dwI6EgXMxdLVkomzN5SfI
         V71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406333; x=1701011133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZunorBu+pSlhXgVxLKtqIO/zrvDIVnpRCfzitU3U4Kw=;
        b=efhM0pQ9thQmUBycdoT5PkVtJJNUUdMLLej1ezFos9U0S+BwevgRh+YYCJDX9OM1nG
         FLEbSgFWUD7nftgWpjbJgsq7yICmSsCPECWHSOsfLEqG5eA09Dm8Y57FvU/wa+bFstGY
         PMccIU2IkhRsz8l3H1Pyab3aNYH5CdyueR6RiGKMoDraa436JOtM6apih2brxlGVBO2U
         eG+J5ZAhDo5FKZPlAZuKPyKMs0VDD/GA1NA0XJ/w4ijdmNAEpteeLfLREYqRgi6f5VJW
         dF3iJIOgRb8qUhPAuSU/yKkNxNtZ2IyyWMn3EyJlxl+JwbsOLOk035LYVY3YPXFx6HDd
         I9jA==
X-Gm-Message-State: AOJu0YxnYD/LC+DSVOEEbyek172eUdS8YavjsErrflJleqPcj+Vd7P1j
	ULcK8qZVteTlnS+wxy+oAW0=
X-Google-Smtp-Source: AGHT+IGzH+/CjsKrHeKApvx47z5slzIAxpySHaRmP6Ect4tge+175o42wM4woX0wpMZ83M9ABOnGYA==
X-Received: by 2002:a17:902:e808:b0:1cf:5cb5:95c1 with SMTP id u8-20020a170902e80800b001cf5cb595c1mr476278plg.37.1700406332426;
        Sun, 19 Nov 2023 07:05:32 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001ce5b6de75esm4417057plg.160.2023.11.19.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:05:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 19 Nov 2023 05:05:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Tim Van Patten <timvp@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, markhas@google.com,
	Tim Van Patten <timvp@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Message-ID: <ZVokO6_4o07FU0xP@slm.duckdns.org>
References: <20231115162054.2896748-1-timvp@chromium.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115162054.2896748-1-timvp@chromium.org>

On Wed, Nov 15, 2023 at 09:20:43AM -0700, Tim Van Patten wrote:
> From: Tim Van Patten <timvp@google.com>
> 
> __thaw_task() was recently updated to warn if the task being thawed was
> part of a freezer cgroup that is still currently freezing:
> 
> 	void __thaw_task(struct task_struct *p)
> 	{
> 	...
> 		if (WARN_ON_ONCE(freezing(p)))
> 			goto unlock;
> 
> This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
> asserted, the CGROUP_FREEZING bits are not also cleared at the same
> time. Meaning, when a cgroup is marked FROZEN it continues to be marked
> FREEZING as well. This causes the WARNING to trigger, because
> cgroup_freezing() thinks the cgroup is still freezing.
> 
> There are two ways to fix this:
> 
> 1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
> children cgroups.
> 2. Update cgroup_freezing() to also verify that FROZEN is not set.
> 
> This patch implements option (2), since it's smaller and more
> straightforward.
> 
> Signed-off-by: Tim Van Patten <timvp@google.com>

Applied to cgroup/for-6.7-fixes.

Thanks.

-- 
tejun

