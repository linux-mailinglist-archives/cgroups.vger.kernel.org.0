Return-Path: <cgroups+bounces-3573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCC92A98A
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E2F1F226A7
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DE14B952;
	Mon,  8 Jul 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFmphMKP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CC1CA89;
	Mon,  8 Jul 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465512; cv=none; b=WArSWSC+jQ2/E6tJoLe9jLSVuohSU7UOnKnqhsT5Yk/eWURUIYEBsx6O6Nq44ruMmyPeos/7wYevAEJjvWb2iIgJz0i9zq/hYopQJFrulJkR5+a4ig3P+NuoQ0e3nbVQbhq1OiEXn4/R3riaVBTqGU6yaqQiPy2pcnu4z4OPX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465512; c=relaxed/simple;
	bh=0iBymYrWkkmoTq9FnAXynAzk/kzlSN9O/3+2oM/viis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p591we7/A20g9jSnDcWPJ/SdSuIBWBOdHxH9b383PFfIKqIJBr3J+ywK5WAmS9Lpv0RqoNHa6nkcK8ohilACBpChE5i6J371eB2gAHuw8C48ErW57u9RFEHvyOGC5aUg40ZJUtLPRdbiuxgGHfteYPd/kaIsuWuvdtvEoVMQaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFmphMKP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb4fa1bb34so13323235ad.0;
        Mon, 08 Jul 2024 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720465510; x=1721070310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xre36ZZNjN3Ue8/9bfJiOcBGQ5hErnqpQBLi118naP4=;
        b=iFmphMKPUXqrKL/gFk+1xLFLXzbMjKRwuUynd4w17qdXnvx6i9+3PBbwflRRxqzIPv
         mEylZwfHGmW23RLF0dXbZN+4gkKxXnIKz/RIOydvlGEDCXsEfT0FecUahJUW3oEyYHMk
         EOQWgrjkQn2CM5uFAN9E/pO15UNIe4I1id7N/88w6RZ4FJFff1aSadLPPrm3NpFmakYb
         44cevItR8DCR/fgE01RRSYRnBZokukkq4oNuQyBobAGsZ6yPV/EyMfRPr4xcy68IxQ5X
         4MLNp9V+Arm+xi8PzgnpJxGRBtwQcgP5NoId0ssx/p1Mi2+WuqezAT95i8YAseaw2HBx
         T5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720465510; x=1721070310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xre36ZZNjN3Ue8/9bfJiOcBGQ5hErnqpQBLi118naP4=;
        b=Ovxg72aqsMrFNeiWFlIT5zXC8HAYpd3eb1GA0am5oZR+NnZ3qTKxsTfD3qMvDYTtOe
         KO0qbBNLsXz/OLS4AXB2UWolpEcd8TAswVEtA6Qs/S8xdcdmKr6sYdlE/O7ilRQwARXs
         hfw26OwdHaYGJoesIJGqO9f/nwC39rPvCRJWEf8Fxyt2QfiKHoprPyIQB3iEdZbmNpeQ
         o3KcrqdYt3XUFEb/JWY4mtOWdN/ipMG8LZGnk+hd2QQL4qUDWzZHGgbpGbZbu1DVELsm
         ckDnn080I4CAItsAYPq0aMsCPR76HuU5K9Zd1+6cpHAlKAcp8Wd3G+VVPrTfYz6Y/cSO
         4Stg==
X-Forwarded-Encrypted: i=1; AJvYcCVVse/AZ2FRJbhqdexCjdb6IZYqZ0DTOluVGD9rtCxCEY01LqS51XN0ku6zErW9nvBwvSxMy/Xa/W00o18XaD7prOLbyBX+v1jrtADn013lidbck8VZblmBM2j089zB+ijHl1L6bw==
X-Gm-Message-State: AOJu0YygDZXeQthcwKUu5RSEGqe7tFAdZAzfsPik41gUyLEj/72DlepQ
	bOZULv3qPo4aHBWGVyj61Yx+XjJdmJDRQdrvsyKwcHSXej7GebH/
X-Google-Smtp-Source: AGHT+IFzmY+a1T/tJPzffyH3ovji1Eq8yak8AJTJdHzIvWmghELFUjKGRESBGVIZzrLSbGc9UsAbwg==
X-Received: by 2002:a17:902:6808:b0:1fb:a2c0:53b1 with SMTP id d9443c01a7336-1fbb6cd1951mr2712005ad.13.1720465509831;
        Mon, 08 Jul 2024 12:05:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad56d5sm1954435ad.291.2024.07.08.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:05:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 09:05:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in
 /proc/cgroups
Message-ID: <Zow4ZJFa6Kwz4BlO@slm.duckdns.org>
References: <20240706005622.2003606-1-longman@redhat.com>
 <Zowzvf2NEOzgXYr3@slm.duckdns.org>
 <b505c15b-8fd2-44f2-8e33-46ae29c2696e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b505c15b-8fd2-44f2-8e33-46ae29c2696e@redhat.com>

Hello,

On Mon, Jul 08, 2024 at 03:01:39PM -0400, Waiman Long wrote:
> That information is certainly useful to display to cgroup.stat which
> currently only shows nr_descendants and nr_dying_descendants. So does
> "nr_<subsys_name> <cnt>" for each cgroup subsystems look good to you or do
> you have other suggestion?

Yeah, something like that. Johannes, what do you think?

> The reason for this patch is because I got a bug report about leaking blkio
> cgroup due to the information shown in /proc/cgroups. I know you want do
> deprecate it for cgroup v2. How about adding a iine like "# Deprecated for
> cgroup v2, use cgroup.stats file for cgroup counts" at the top of
> /proc/cgroups when cgroup v2 is active?

I wonder whether that would break some parsers but we can try that and see
what happens.

Thanks.

-- 
tejun

