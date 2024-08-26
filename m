Return-Path: <cgroups+bounces-4448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260695F044
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878541F22477
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46A15B13A;
	Mon, 26 Aug 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AwhBIz1F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D7149018
	for <cgroups@vger.kernel.org>; Mon, 26 Aug 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673579; cv=none; b=LYEdNvfFC/xLiGVOug76u1axmlVUXjvdYUhBtAsdCtlYUg6/sJxF5TXj39TEWtgHR0xxUM+gmkT2mbTKEqOmGVEEsBxvzSBW/4DvsUGN62AGX722wsfMpBwGBtPTAIns6Anj37Y1VdHRDT+zIQXr0TrdQAS/AvZMgbUkqTUP/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673579; c=relaxed/simple;
	bh=2Gc4rUT89+kCaOVxsaKCmlkj9zfal6pMrdwtwEvIMKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB4K9vqt2pZKQ2iL/E3Zudc2eBnT46dtpqs8DczoN70ngy1BF6veFmrSzpSKYMDXderOn4I9TGANeyWol6L5aXAmKW9TY1XGwQt6sAGMUGhItTmiaBQksLg0hvMBbXlw4k7qtLC6wDX3Z2bel0cWoz0KnjS8D3FbuwlIl6ZpWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AwhBIz1F; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so5475287a12.2
        for <cgroups@vger.kernel.org>; Mon, 26 Aug 2024 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724673576; x=1725278376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ataFHi6wYyiiD9cTzzrRwByuJhJC70WggWtUT9kwKg=;
        b=AwhBIz1FCTyOlrdQk960BhhbgpbKvtxRP0gzAuTJS6ubTU/2h6b114P2zfIk/I3KFp
         YPjLUgu4miLcqpxyCppSSv05uzWQSqUdgEKKQbBo7OMEHG+lFNt6xkKIJngXRleicS/H
         auFk7/YT+6JUtD0uKlZfUiAUv6WVSD8SahfmFXRbojzPyWyl+nXiz9Z93GJw4JaQY7rj
         GOEDLkKS14oB7holt+fxW5EMjlCDaKI+hskhdr1OEd5Q5LC2Wj3rEhtSPn1yLxOEqti5
         /zb5UlayyCKORV9k3S/J43BBBz1UDqnprM34yZ6imtcAqn8Ax+lAL6efifqTIcEr+UHu
         LwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673576; x=1725278376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ataFHi6wYyiiD9cTzzrRwByuJhJC70WggWtUT9kwKg=;
        b=vmFhUCqX27KOrHyda2mSHPjghKF5UKvAm6OV67qOLtjtiYcEEHy0Sx2eRPhu8p25wR
         OtMtwe/JI5SfHbjrJH1xHoDz5vPBWzQ03IiDxHhgOv8O3Di/xI9dlVG2RxENVWQbqrGB
         pAlr4BhqcS5veVsp2UEasAmSmahTeseYO4F2ruYbBmeIv9T0v8hDVNnyXZd7+CwfvoE1
         WGfkq/its8c9amSZsoEeucN9S6LLN0MTm/9UT2bfF6UFiKfBLwU0WJrLC/81RKDimkXl
         KAdpbhdQHv13PxHsG7egMemrPTM/53oV9S9Gp4WuZIdTMudtJEmXyYnPpfic19r5Xrby
         QqOw==
X-Forwarded-Encrypted: i=1; AJvYcCV7qsonRAUajVFq0F9H0OQ2Z34mLkXTBqYkNfWDGyVzluKSEiksaCLYDqkwYdIq0CJMdtKpxkDp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pKhiHdLoD5aBIPWUjfUm93nOiqCQ1cIaseSR8SzTvMmhAmZm
	h0/lzx67OVsBuaa99CcnnhJivCe7cly4ydcikOxrcpmMUOAxPkHoT0BOSmibpoE=
X-Google-Smtp-Source: AGHT+IHJapUjUiMqfFgXQZN7btLnjR8mKnVNx99urgJ6GEY0QbCn3ebax3APSaYwnptj7nqVrP4y5g==
X-Received: by 2002:a05:6402:2754:b0:5c0:a9ae:d333 with SMTP id 4fb4d7f45d1cf-5c0a9aed520mr1578615a12.37.1724673576168;
        Mon, 26 Aug 2024 04:59:36 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a91afsm5529770a12.93.2024.08.26.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:59:35 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:59:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JoshuaHahnjoshua.hahn6@gmail.com
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	shuah@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] Exposing nice CPU usage to userspace
Message-ID: <tpqxx4hk45qkbt5e7sb3jlomfcqt5ickbor5gmclvbqxbrngp6@yqltckvwce3z>
References: <20240823201317.156379-1-joshua.hahn6@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823201317.156379-1-joshua.hahn6@gmail.com>

Hello.

On Fri, Aug 23, 2024 at 01:05:16PM GMT, JoshuaHahnjoshua.hahn6@gmail.com wrote:
> Niced CPU usage is a metric reported in host-level /proc/stat, but is
> not reported in cgroup-level statistics in cpu.stat. However, when a
> host contains multiple tasks across different workloads, it becomes
> difficult to gauage how much of the task is being spent on niced
> processes based on /proc/stat alone, since host-level metrics do not
> provide this cgroup-level granularity.

The difference between the two metrics is in cputime.c:
        index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;

> Exposing this metric will allow load balancers to correctly probe the
> niced CPU metric for each workload, and make more informed decisions
> when directing higher priority tasks.

How would this work? (E.g. if too little nice time -> reduce priority
of high prio tasks?)

Thanks,
Michal

