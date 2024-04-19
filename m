Return-Path: <cgroups+bounces-2624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821318AB239
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230E21F233DD
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2B12FF81;
	Fri, 19 Apr 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/kMuUQJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327C4D110;
	Fri, 19 Apr 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541524; cv=none; b=hhXuQcNNqrMPQBt48AG+bXZzqO27gpbJfCSU7zYo64jl66ZlunXsp6+dDVCPzPQojKI6gi0B8Lnkrx7fLwBdklb2mghdrBMVS5jn09VMTutbxFA5A/pf2LKWmACcR0D9qTwWzM+BWJaRc+d5FrKnf6ujN4ivk3m1/+fg3o/jP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541524; c=relaxed/simple;
	bh=XKKxD0ModasqLkselLDWffn9KcVeA66kmTmWcUDfDso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd5QKpc2kKyBMhPuX7LhFkj41KJR7ogHQNQdQwCBZ/czhzoUdhiWMIKjfhQrTLvxjkoCoMWgCEhs54RMltQD1Q+gY4fDjor+b11S6A6RPc1GARgFlWSh0EhpaQwSFPKtjvZCeI1teJDTuS8yNwBGl4SM0C4EaaGM0e6gO36NPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/kMuUQJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1499685a12.0;
        Fri, 19 Apr 2024 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541522; x=1714146322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1kinc+0DXgxna6CwZpUMHpChQRy85jYWGdTJPEU3gM=;
        b=M/kMuUQJmn1o8nwepsPNY9+mQdsAJ4BBgI80Bq8EF8weH+fCFvqhUZRQglX8oj4WXU
         ygIV+A/64aqZtARELG2IrJMHopW5f1Yvu3KvqAM6T5dO35CZnYE49ywi6LY8OohhVnN1
         pSInv9C3Mcb9welZVtHaVs3rjXqLFcS53bVUIVF8L22BCC/333Lb2PGvr7dQVIUKaQkZ
         Vlbbc5BFJelA1xATtlYSs2q7lpavDXeZYci2m9vp34WIIbE5SHweKwTx9rm2UESkl99d
         SVXDIMSln3vaCJapcqTMVpKZkw3sn+env9TmP80mtN7nAtUJdEoJOP1D9YAyjEkPSMDs
         THBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541522; x=1714146322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1kinc+0DXgxna6CwZpUMHpChQRy85jYWGdTJPEU3gM=;
        b=DfWIVgNjJ+8qBs5lUQTEa6uBM0fHV5OgoL8+HPFp7rmDgUKw02And4l48vRmvylsBX
         Lk2dDbEHH/uJYjTeyDoJ+yVBYbrOrQ843NNYiNQzK42Ssru8GMyxGS/TtAgLT/9INFPS
         o2jHvAfgZfT6GxWApsmCN7s8N3EUUj/2tBsOk/8MrjtP8gSsIGSJZUlVXs1vTuMO3gZ2
         AxDrMxoFo9b+zaU9suTHTqUgi3Gwe4nfZoe2/NtB2A1ToEg6OgMn9T+kgdAHgPccEoTs
         5DnsrdgXqjQ7yLTYH5jso+RlnT94Lz68T1CeS/VLydmDC695y6RwkgahOuX1xVBRp11T
         Kg9A==
X-Forwarded-Encrypted: i=1; AJvYcCWj18Rs1yKfRLYs/8MME2tlKD6Jj66s06WipbhMYLE6+wF61HAxz2mR069veY9XczeVS2Ytxxi0vMsYO+BaQcfMkZPAvRB9r0DOp47S1oBBqUKU38WsNzSPzPsaAJD18Bgh2e5k0A==
X-Gm-Message-State: AOJu0YxJJSlgdqIuiE9UcoACRaWMu7+ZtQHXtoSgvl0ZP0YhaAz4GUGe
	yfvhyZAdEnMoR+L76gDKjyR8zcDZB6E1tGbKOulm2eT2BZ0zGcq8
X-Google-Smtp-Source: AGHT+IEfBQPPlhmZVMLuGlhV4X3aWyDqdF6cUWKVHe1RFcg8zab9BjC6lGTliyf8zH0LpZk9W8r56Q==
X-Received: by 2002:a17:90a:fe07:b0:2ac:3c42:5839 with SMTP id ck7-20020a17090afe0700b002ac3c425839mr2441802pjb.1.1713541522442;
        Fri, 19 Apr 2024 08:45:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090ace0300b0029bf9969afbsm4977276pju.53.2024.04.19.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:45:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Apr 2024 05:45:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: avoid invalid loop in cgroup_no_v1()
Message-ID: <ZiKRheRBuSOTpSra@slm.duckdns.org>
References: <20240419085316.957277-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419085316.957277-1-xiujianfeng@huawei.com>

Hello,

Applied to cgroup/for-6.10 w/ title and commit message updates.

Thanks.

----- 8< -----
From 19fc8a896565ecebb3951664fd0eeab0a80314a1 Mon Sep 17 00:00:00 2001
From: Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Fri, 19 Apr 2024 08:53:16 +0000
Subject: [PATCH] cgroup: Avoid unnecessary looping in cgroup_no_v1()

No need to continue the for_each_subsys loop after the token matches the
name of subsys and cgroup_no_v1_mask is set.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..b9dbf6bf2779 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1335,6 +1335,7 @@ static int __init cgroup_no_v1(char *str)
 				continue;
 
 			cgroup_no_v1_mask |= 1 << i;
+			break;
 		}
 	}
 	return 1;
-- 
2.44.0


