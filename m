Return-Path: <cgroups+bounces-1924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A547B86D435
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BFE1F23ED7
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606E1428EF;
	Thu, 29 Feb 2024 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqTpmYdv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D113F447;
	Thu, 29 Feb 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238573; cv=none; b=agpULMY/5nE7y0dTHv04TkiMif9hY9fBR1diPfAjYXPQv+2OoqnhX9kJbuAYq61mmdcq7Wd0yGOGHlbA0NQkEtugoeuKjT4+YFqoEf7UbRcUq40r5JokW6RLM4RFhHYr+Z80WAvUOOuEUlNgj6vEGGLEcwhazmpEF8ioKYc/rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238573; c=relaxed/simple;
	bh=wDnbbqB5aUHpb6fJcebChgfzTyYFaOf22lmLVESnSNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/LyAcZT6b2vRZJHlp3m4xnKMLer2+Dqzb0L2rs0/pL2YDO5iRqYQFbYbltSc0r11eBiZeCdzrUH8OSX1eNHZXEUxMgDu2ADoxl599asIHyIkY6n0+vnTjEs6No0S3ymTgIkwocklbusSECdE6g098bc4UClV0wQi6dIDU0z+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqTpmYdv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1db6e0996ceso11501605ad.2;
        Thu, 29 Feb 2024 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709238571; x=1709843371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSz/dUHpTksrWDau7UTGPuG7xxZjtedv1CB25dUHJFg=;
        b=iqTpmYdvp+NG9qIiDF/WH1KQVbK++HHWcuO+hdchIRnpptzJDDtDwwcYt0298AJO1d
         CxaE8cwtEdk5cLvRjdotRVUmWK2ReeoBdsmmtc+5vTel8ksmRhVyB8ZF5FtIbPPnEqMF
         VH2Otyzw4+p8Hyts/aJKQhQfAw8+RMKdCjC4ssPsXmEj2U0X2/aVZojMscMPYTZZ+Dkc
         /bgc1bZkp6Kqb/IHfm/bXISSaI81t51CTr9VzZoBPt9VY+4OYL1vovJ/o6P+oWYNW+EB
         6btPOfsIZOWeZ80JdkYKcKAEbDBujprcqtryBNcnbd/cNJPwHDP9CxD7FB/u2pRrjGdS
         ukFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238571; x=1709843371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSz/dUHpTksrWDau7UTGPuG7xxZjtedv1CB25dUHJFg=;
        b=X3x1Rh5hPsWdBzeV9xNpowxNAtb9jUpeP0+DDxJzrF35b/f0eptKIAzYbdVgR52VQI
         wElMk8NYJudQ/5Ml113IFCVXx4dJFyqh1mrrL7R3us1no8qxoRHMY79EPwGKCjaDf6qu
         Q7vsEVrLDY/dlO8h86HTwL0pDO9XKoQhsv9wh5WeupP7hUC2SWhteCA8kL4bIIkbDdvc
         r30e6yjvvBMd3/7r08ozkQlLOM3sF7aCkOnMeMziwbrMV7la52TSoA7T6fpZD1W5Worc
         bF9LW+4T3f9JK0Rj2qZ558gseHoafzn3CzDIYk9Ow/f929Pkm/JPTOmZ9eEwkZxWVZmC
         Q9rg==
X-Forwarded-Encrypted: i=1; AJvYcCWbop5Pgh6RP1aYbET+O0t9VKQJzNEB/XZXBzzHvWBqG7WHZxt1DYx2q0GPaBW1J47s1yKByGbxYl0cbfG/JIkSDaAy4UVLZFPFFfTRLW1J2gaMDwIqX4WYjs8jgKnzcCPqO8sbL3xr/2qlPlD4CL77m3yjJ9HESmDFdM9Cn7Q8QI9osdiHX9Q30nt4aBOR3wy5XttVP7zFj5eZMw==
X-Gm-Message-State: AOJu0YynPHGr+J8QDwq1O01gKLDYveqAXk9DdgQR2KPK054JrxVPZQBW
	AGhhDNeDFGUiMaJWnRA/91prsn/eC/2k/p37lVyUe9YqkDuz1dP/bbdGpNo/m5o=
X-Google-Smtp-Source: AGHT+IEl3W5R3KIqZYg3g66+tVVU2vPgDmNnOp/Ux0a8p2pYOCsVOCjZol70UqtEdVEfLXXhxBd/8A==
X-Received: by 2002:a17:903:1208:b0:1d8:f129:a0bc with SMTP id l8-20020a170903120800b001d8f129a0bcmr3441334plh.13.1709238571238;
        Thu, 29 Feb 2024 12:29:31 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170902f94400b001d9aa663282sm1926375plb.266.2024.02.29.12.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:29:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Feb 2024 10:29:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiongwei Song <xiongwei.song@windriver.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	corbet@lwn.net, vbabka@suse.cz, yosryahmed@google.com,
	rostedt@goodmis.org, cl@linux.com, chengming.zhou@linux.dev,
	zhengyejian1@huawei.com, cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/cpuset: Mark memory_spread_slab as obsolete
Message-ID: <ZeDpKRX3mQqcoFJx@slm.duckdns.org>
References: <20240229142007.1278610-1-xiongwei.song@windriver.com>
 <20240229142007.1278610-2-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229142007.1278610-2-xiongwei.song@windriver.com>

Hello,

Applied to cgroup/for-6.9 with some adjustments.

Thanks.

----- 8< -----
From 3ab67a9ce82ff22447b1dad53b49a91d1abbf1ff Mon Sep 17 00:00:00 2001
From: Xiongwei Song <xiongwei.song@windriver.com>
Date: Thu, 29 Feb 2024 22:20:07 +0800
Subject: [PATCH] cgroup/cpuset: Mark memory_spread_slab as obsolete

We've removed the SLAB allocator, cpuset_do_slab_mem_spread() and
SLAB_MEM_SPREAD, memory_spread_slab is a no-op now. We can mark
memory_spread_slab as obsolete in case someone still wants to use it after
cpuset_do_slab_mem_spread() removed. For more details, please check [1].

[1] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#m8e292e21b00f95a4bb8086371fa7387fa4ea8f60

tj: Description and cosmetic updates.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 2 +-
 kernel/cgroup/cpuset.c                          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index ae646d621a8a..7d3415eea05d 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -179,7 +179,7 @@ containing (on top of the standard cgroup files) the following
  - cpuset.mem_hardwall flag:  is memory allocation hardwalled
  - cpuset.memory_pressure: measure of how much paging pressure in cpuset
  - cpuset.memory_spread_page flag: if set, spread page cache evenly on allowed nodes
- - cpuset.memory_spread_slab flag: if set, spread slab cache evenly on allowed nodes
+ - cpuset.memory_spread_slab flag: OBSOLETE. Doesn't have any function.
  - cpuset.sched_load_balance flag: if set, load balance within CPUs on that cpuset
  - cpuset.sched_relax_domain_level: the searching range when migrating tasks
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..c940cf01b148 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3897,6 +3897,7 @@ static struct cftype legacy_files[] = {
 	},
 
 	{
+		/* obsolete, may be removed in the future */
 		.name = "memory_spread_slab",
 		.read_u64 = cpuset_read_u64,
 		.write_u64 = cpuset_write_u64,
-- 
2.43.2


