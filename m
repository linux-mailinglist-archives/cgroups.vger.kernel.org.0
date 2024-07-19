Return-Path: <cgroups+bounces-3811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA401937A14
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D641F22751
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499A145A19;
	Fri, 19 Jul 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hGRntHaX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DE145A08
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403695; cv=none; b=RNYfJjagXWEUGLthGgTCHcf+mArc4/2O3sEH/gpP32L3E1yzTLFeUy5yKXYP7LcxLClPfZUBWXEL6KbDkSC0P+BFcqNlUSRfPQqxfkr6vnDoSjQkK0sLG/ycNLTV7temEZL5jkiyWtHyoOIbLgcR1ySoWA5BD4dmnXUnGv67lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403695; c=relaxed/simple;
	bh=QQoq6N067yrt/y8qeQyfNuF0R8Ry1rABV4f6knZiZqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/LPxMOohgX0qRv5zzJRaNLfzAlUuHm3bAxNIe+2+zm7mVI7LW+rJtebvNPa2sUKejPHLYU3mWo5SBSTEW+1FaNHVKIora9TJ8CSMlNDULnX9LrAABIrgrEG8gxl76j+dUsrtbYFKDh/dTrpNA1yqvPtJ6jBvsHg96eLKLs7Brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hGRntHaX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b0116588cso52504b3a.3
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403694; x=1722008494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=hGRntHaXYutPqYCtAEtV0MjB+bYk2bSQROLetr+74/u0D+L6GqYahFe8vHA3J/1m7U
         G+9uxy4s2qJ5wCDcyCPY2aTj3UahlyRWO1CuvwX7HVqssL+pw/bJpoLEoE3SYxmpNNrU
         vJnsQm7Ego3P7Daw+nd0aIeaI9LMVfL7LXAzruv1Lsg18GO3DR9t/VIKOzf2SnlPX8iZ
         wdW1nidNNNT2RfjdjavxywUWVd/tUWWu4vdyO8gQMz4I7upBQyg9DrNapWoaiGBjn0HA
         YIsWlfWGu2uE8D621g2VqiuHIU2/4HY2R3k3KmkiQlEyi5l3X3dbuY6xxOJg2DyHjBNG
         f3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403694; x=1722008494;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=ak+eXamT0psxlYN6s1db2o7lUBheHMTgyD4R2XOatcNknqKPhuzg4FXN6rSViypcul
         eou8AN1p29YQV9xsWhdIPAhceFZhK1BtebUvJCXIZilpLBxi7vQsf7UBsSIkAfUg39Sj
         pT9hKQopY6OHYcsipmZu+h4UQnKtv4ivk+wcIsZkaBwa5axejB21IxAjyWeAncpYXCn7
         jnc9EQ4V8i/tc/qWeyy9bvEok3xp7sxqHBcJ+tpYAZbPziHvvgMwgUskeOHiw+ElEJOz
         kgtBHWwVyNgJKRGMiTSf19xAzWyRYIfHMM0aFxgPGBSZk18uGGPMsOUBXWlRSzV+CKWh
         2B5w==
X-Gm-Message-State: AOJu0Yxobg4Pfj+Jfk3HJgYmD/ATcBoGd5QZmD8nBmraHU4AjlxxaXPd
	JFKnYA3ibdnBs+6J2zdFn1iFCNf9MR+p0Ja3rtwlsbHc/ifgn3VMLLel0ZQQE0s=
X-Google-Smtp-Source: AGHT+IGCPJf4uACUKwnddKZTp8XxBr73j8zaLpJGjhGEWSOurNMxyXPvSNi6Rqi6ya+v0VPj3gPgvw==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr242254b3a.3.1721403693595;
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49164bsm1380338b3a.18.2024.07.19.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, lizefan.x@bytedance.com, 
 hannes@cmpxchg.org, mkoutny@suse.com, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716133058.3491350-1-xiujianfeng@huawei.com>
References: <20240716133058.3491350-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH v2 -next] blk-cgroup: move congestion_count to struct
 blkcg
Message-Id: <172140369204.12552.9366107896766797330.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:41:32 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 16 Jul 2024 13:30:58 +0000, Xiu Jianfeng wrote:
> The congestion_count was introduced into the struct cgroup by
> commit d09d8df3a294 ("blkcg: add generic throttling mechanism"),
> but since it is closely related to the blkio subsys, it is not
> appropriate to put it in the struct cgroup, so let's move it to
> struct blkcg. There should be no functional changes because blkcg
> is per cgroup.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: move congestion_count to struct blkcg
      commit: 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca

Best regards,
-- 
Jens Axboe




