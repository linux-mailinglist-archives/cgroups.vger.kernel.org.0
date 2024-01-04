Return-Path: <cgroups+bounces-1086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF0824BB3
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072A81F23667
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF72D025;
	Thu,  4 Jan 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s4rGAajc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D142D041
	for <cgroups@vger.kernel.org>; Thu,  4 Jan 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-58962bf3f89so196166a12.0
        for <cgroups@vger.kernel.org>; Thu, 04 Jan 2024 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409854; x=1705014654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=s4rGAajcagvdXTON4ibcIgMX5X4+HrGDFzDU7jr6tbabSPoI2Y4gU9qScJW079OaT+
         DQegsilY6JcWxrgiAC3fK65hPrDtRZYBMvalGiB1bRhiS10k3jbHne4qFP7/OBopYy3j
         cCrPEPCvWofbhqxGQWW7eGqphbpnbu0154m+ClbdJH2+mhDNIWy22n0K6L9grF0MJHa3
         6cJL93mzELrlmtUJ2Ht8wdmkkAOn+6OUhyufBN9/+3YIwslyOrTmEnOlVqEKukFpqpDG
         eCp+nAPiUwtKgmCleR72xNpKOVN4N88XviFvhpw3miS3T0qEip13NXQ5O8mjjbCx5W7g
         bUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409854; x=1705014654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=TclUzqcx1XlU7eh+W/eBrEZ4NXjhyiI61Yf/N0TUoNo7w88tIFZYmh4tuanLNgL6uK
         4RXy1gIod/1uFSjk4/wp3WCIvXluKZ5HJCH9Aj/ks8STUvyq959tS1F2socvGcjSAU8K
         l6BoRmKMSxx+uHwUpr8AcfIeL7cI58CcqRpKWYXuqdBHOUP3Zk5chEobtr2wjXk9AX5y
         3hL9pLQx9pFzJbeljnVntAd80V3WjmydTHqAD8M3iXqK7YH1B2Zyf3NVBsv9kkiim/fO
         WxfHHVSDMTmQkYT2VLE7QkA2VXn3nUbrnRQ61AEM9FBa0lF7ZSXK6WDtJLiddfIgEnSc
         C2fA==
X-Gm-Message-State: AOJu0YwPZqBtWVFOHhpYwk1VSXa18Z2egf2ifgyCG6R3MNFGgGKLRnnb
	IVn7ri/6nCI/cLeO6KhRhqJ6rX+EqebqJg==
X-Google-Smtp-Source: AGHT+IGU1glSIcKnbi9+C3kDPTLq7P1ixYqypmQFGI+x4/dzZR5aGRIoxmn66PhikKYpDvkjio+XDg==
X-Received: by 2002:a05:6a21:339d:b0:197:1c10:aa3 with SMTP id yy29-20020a056a21339d00b001971c100aa3mr2816239pzb.2.1704409853904;
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Daniel Vacek <neelx@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>
References: <20240104180031.148148-1-neelx@redhat.com>
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Message-Id: <170440985277.724469.7162918731895817738.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:52 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Thu, 04 Jan 2024 19:00:30 +0100, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: clean up after commit f1c006f1c685
      commit: fab4c16c527e24c804efa4992b3cf40438c9b227

Best regards,
-- 
Jens Axboe




