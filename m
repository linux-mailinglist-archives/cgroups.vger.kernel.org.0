Return-Path: <cgroups+bounces-2025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F9A877C7F
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6B1C20E8D
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252614F75;
	Mon, 11 Mar 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gui0JIOP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353017548;
	Mon, 11 Mar 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148816; cv=none; b=ZHGdAxi5xBb1esIcnBTw5FE2WnAq7M65VT2VLEACJzzeKAP/XEQmv7j/qff+zY/34GHUJ1VxxOeIt4p/2JZ0RHJ5poSJ4RF+c1V3NDYMDbzcdl1yGzVUkWxPUY1m9gqyp1KasvTvp1Qg23CcVfsVzizAN8iHiliPd4Am7fg0alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148816; c=relaxed/simple;
	bh=nmBmBVnPqJ2N+DmK4r1FSHVlgAjjOny7F6we7mlRXkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ofA2XTZPoRGnYb1aiub2ZW9qCTS3IHbSICFyKRRZmH9AIqlF2ICaVitLSyqDhy0yeNjwxRCxA2rYZDlbRowRmQ47cPjMP0eje/EYERV6DNWwBLjh/Lin3DvT/RgtqopeClgrToRWKdcx2NGdij52v5eSPxmqMlSLXwflgAhoVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gui0JIOP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e64cdf08e3so1750662b3a.3;
        Mon, 11 Mar 2024 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148814; x=1710753614; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PEdFwNEj9NiEV2imWkxjdIFM5A8FOXJbS9uIt5QsObI=;
        b=gui0JIOPEyRqmBABlAR6VR/1bqA+JvXZNSpbZMQCUibO/ypzvDwJpY2lSszlDcOUcp
         2xejr2MUG5zq9OBGxSpZ3lFIWbNPX+37U8fjawUufVpzZoYW35DSQRkJnaZmlm3szdN0
         CCIIyn9ih3T+Jb8r1LOMuQwzyteNPb9xjTSAFUJ2DflvqX/Don6miVLY00GQrprQajrc
         5eZCI2s/q/KcCrN87BpuA/qTnolSgE2ROh7FLLHL5J3aBgs3eizDAN0SRNWo+Tt48yu9
         u5B+Dwl0qvWk5MJLvZGLYePBamV41dcx5F1ntaX1wXOlZe6qFeG1xz4dFtSUJD/I96xM
         ZGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148814; x=1710753614;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEdFwNEj9NiEV2imWkxjdIFM5A8FOXJbS9uIt5QsObI=;
        b=o7Jo2PTjf4kcx/JniCHTdvbTF7ZKrY/5AJamdhFsaDS7ix/OJ5Mhh+Xcf2SlBXdl6Z
         gDtVuDmcL3CoEiFM/w16VhfRdb2Imoh+zVgxjmccA4tmOvnU6tQJc1F0DJ2Z4ZHu8ia8
         Ut/QIpCuYe/NncaA+VKNQBEJc+JlGdQmKmWphfTr2Yc4h+0hakSIGN8hfNgp9bIT5BlF
         raOANGt1B8T+C8Nz3JxmP5et0K+98thc2LCYDojwgz4R8s0YxtPY9tIQq3rdcPct85T6
         yeCZ9ANbqvFP2Dtm0z2+4zcAW9Q1BFrnsq+a7ZZ3CUPhoFDt4bPKxUybOQGa/t7/QYqX
         hVpA==
X-Forwarded-Encrypted: i=1; AJvYcCUAzvKfURhr83wEqaVltnyOJ/Pui5ng735DfvAHOqtrDAqyhPBciKj/298c2JU6rykweBUJyr7w6seV2bhdqv8bc/ausSl4YQ==
X-Gm-Message-State: AOJu0Yxb3lqo4+OhoOOPGll+O/JjYxU8astMyeCGMlOercZcRRRDm3P2
	pDORZjx+E/+1pjOHRqKBMrF+9sf4Sq76q5CQ0Q1fJuH0i3pc3Wwd24CdRkSh
X-Google-Smtp-Source: AGHT+IFO6gbWf3bpTTWva/VcKINhqbsDFEwx2df2IDRRr0x+AwhIhvO2MX4lN70SuleiV8LVpbZQ2g==
X-Received: by 2002:a05:6a20:3424:b0:19e:9c82:b139 with SMTP id i36-20020a056a20342400b0019e9c82b139mr2879035pzd.45.1710148814474;
        Mon, 11 Mar 2024 02:20:14 -0700 (PDT)
Received: from localhost ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b006e3f09fd6a5sm3912448pfa.163.2024.03.11.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:20:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 10 Mar 2024 23:20:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v6.9
Message-ID: <Ze7MzJUQZG41zx1w@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf:

  drm/ttm: fix ttm pool initialization for no-dma-device drivers (2024-01-22 17:25:46 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.9

for you to fetch changes up to 3ab67a9ce82ff22447b1dad53b49a91d1abbf1ff:

  cgroup/cpuset: Mark memory_spread_slab as obsolete (2024-02-29 10:28:19 -1000)

----------------------------------------------------------------
cgroup: Changes for 6.9

A quiet cycle. One trivial doc update patch. Two patches to drop now defunct
memory_spread_slab feature from cgroup1 cpuset.

----------------------------------------------------------------
Xinyu Li (1):
      docs: cgroup-v1: add missing code-block tags

Xiongwei Song (2):
      cgroup/cpuset: Remove cpuset_do_slab_mem_spread()
      cgroup/cpuset: Mark memory_spread_slab as obsolete

 Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
 Documentation/admin-guide/cgroup-v1/hugetlb.rst | 20 ++++++++++++--------
 include/linux/cpuset.h                          | 10 ----------
 kernel/cgroup/cpuset.c                          |  1 +
 4 files changed, 14 insertions(+), 19 deletions(-)

-- 
tejun

