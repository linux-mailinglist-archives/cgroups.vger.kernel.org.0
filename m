Return-Path: <cgroups+bounces-4015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC194230E
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 00:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EFDB2327B
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FE1917D2;
	Tue, 30 Jul 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCKBVcUL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117D1917CA;
	Tue, 30 Jul 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379279; cv=none; b=Nc008FySARUdNATfCy5nuqvmVJ2d1P/k6JEErpzMnVTJmXtZcbf4W/jumh+05QkYPUgnPZIMObxk0a5pAQ+5e+xNig7pb69xVtlJyBXRe0uIrBDURA06qVsXQ1a200kczXX/eEteDqaZDwuG9QSf2U4TyE15wGmV9GEd9+mIDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379279; c=relaxed/simple;
	bh=nyYoWTikdd5F3g5lkwaV5k57vFl0h4BL0ApfjjdP9II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7JJtFt30BD60LSdMZxgqx7R3y79LkR8kanpnpsY6WkNlT1eGu242ST3LK9oRBH7fzHvhkietEL9olG7bQ5POc5LQwcxTtoULd1hK74Qyc6ZOzJMDJOGp37N9L1dwYR4gxDf5/Np4/dPGjncOxYDd7Z9HcwdcUOmvhf8oIjuLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCKBVcUL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so3668873b3a.3;
        Tue, 30 Jul 2024 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722379277; x=1722984077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eEOay+uYGNiTgF/SzR522X66zTTOyCCNers18hIO1E=;
        b=GCKBVcULKD9RHlDbUGiFQGOnCuKQINiXnSL7+sr98Hp038LZOWtkrhkI7KeqeLmddc
         5j+LP2xxIV8jSHuAWZG2Y5zWs/XgZH+4Ep6UUsN1P99ADot5jVCZaPp1wY9+sdCUvQnJ
         nNEGV1399L3hJ66F4UStgsYVFVOYm9+c5aCFSS1gGkPOHdKJxmZZGVOsItGEYcEcAHjD
         nzPRFYG+lE89571FkRxOEJtTOUKVRLk7SVRt1SN96YDOACuU799gD3hRl4dDy8q1J6jO
         VsRpiv0zleXvIs1BfBk7x6sTpBqEr1OLWuC+ZWAbzaSMBvRnWSxlsVKw2Fp7Fv6cqwYR
         /fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379277; x=1722984077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eEOay+uYGNiTgF/SzR522X66zTTOyCCNers18hIO1E=;
        b=WJa3H+/OAk39bLO8dFaqXyUxj3mJLbG71ujU9aP6ruqaGSQo1+RmN7PSM4PXgsnzqm
         8q+LW/B+koRhSa85fvuXWPGg00mRfEMfLiXYu9miKz2iI8BgyvQFAVLq7TD1VAvhA5uu
         f3siOOPOax2qBXIECc/GgCfL77CuiWuDLABmlW/7NGcuDJ2xGzM6dfXO58NLm3WsDChJ
         CAK09M4U9jBjukDznZUH7QCy29uDWr3hP9Xhe2IZMH+ci38fOE7GTOLyVXe/600Z4qHZ
         wskbTSm/OefkSMP3R6DRyNB8QsRu8tzNW2RGCKnlOUmE3aegpODmrPrvfzw3KkYOy+Wu
         99kg==
X-Forwarded-Encrypted: i=1; AJvYcCVFev7SKDgTzCVtKsWCfCJL6QXBPZ7rli5VCgnkveGlyYv9Qul8vxUBm2Vpu+WEsDI7f1bowdgYJdyB4Mggx+WCHh34QNsnt/u75JLncWi1SOGoJhKBzrQDjGO7K9sUKxtYyWZ34A==
X-Gm-Message-State: AOJu0YzmZYqO6vu3TTL4QTKqHTxwXzQY2flIDOMnz5KBJV9TV7GhGAja
	LQ8aPOS8B/R8ic120ZpW+VRJUljCSwQAnY2zpdqv9IX+6ke8KnIt
X-Google-Smtp-Source: AGHT+IHNffvz/50Z32gzIQZQ1LwYdUxpB2Ll4Qhb+j+tqvNcj5mWrxP7g+I04GXcMQ7Iwmd1cm7EAw==
X-Received: by 2002:a05:6a20:bb1f:b0:1c0:f216:7f20 with SMTP id adf61e73a8af0-1c4a14e0186mr9281795637.49.1722379277075;
        Tue, 30 Jul 2024 15:41:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1078sm9218478b3a.16.2024.07.30.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:41:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 12:41:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup/cpuset: add decrease attach_in_progress
 helpers
Message-ID: <ZqlsCzyUh1PbuQgp@slm.duckdns.org>
References: <20240726010502.2226806-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726010502.2226806-1-chenridong@huawei.com>

On Fri, Jul 26, 2024 at 01:05:02AM +0000, Chen Ridong wrote:
> There are several functions to decrease attach_in_progress, and they
> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
> add a helper to make it concise.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

