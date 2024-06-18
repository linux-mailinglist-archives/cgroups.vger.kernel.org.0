Return-Path: <cgroups+bounces-3232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67590D721
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0480D282510
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01A2557F;
	Tue, 18 Jun 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iTzjZ7pG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C22C6AF
	for <cgroups@vger.kernel.org>; Tue, 18 Jun 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724198; cv=none; b=QWrl3/NwQ6+AF0hCFcRwuzQpczGo7oJIdxmIxxoD8L8jf1zT5qo1WR4Q3/vvp410L+bw4jkFctiPEXRD5ZiFpjwkdDNQJStQKNSFF8AUbDY3e1W5B6x4LcMojQfTuNbOvSIr3F73tf3aTSTKKArHOUrbnETl18albkoaqXzJR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724198; c=relaxed/simple;
	bh=+UaewZqjCk5jggLlt8A+UFHLlspuoZhO4dFuoF9TpFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cItdY6P7Hk0CiGJrZu6/AowIP2B2ZWaTfkIAsHzJnXkC/GKcQ3I/HAH42tNAPMhIptzLnnFHhRVisxzJoNtZlM6UeuSc9vE2IeswpsLQXLiE7kO15ivUtvWqRJHwPvYE1tMtLKXeh1VmMsmI7MM1jksS/WpQNCSAFhAu0pBghJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iTzjZ7pG; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c582673a5so446157fac.2
        for <cgroups@vger.kernel.org>; Tue, 18 Jun 2024 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718724195; x=1719328995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=iTzjZ7pGwvyEpR7l+YBlSWG2eTwTEkabaTn/t/Yl13KhBBsSqepKBmYuKnaqrwJXkY
         Ulq68qJU+I7MMa+TQ3eyP+30xvypFj+KUJStruDvOH3boEIgp3m5nshVj7W6AwfXa5j3
         hUAgAxeNiREJzTtvpoD9mQCxkPftGdT5G/NRxjaNfgeacRzcIfleqxiutRhAm9i1RC74
         dOrK7uqqvmsaBE9wBsbU2Of2Qpsx2QeNpOEJN3SFTT8B8IYTG7f3ftkKkBHjEU04j6d5
         C9hJHxSbQMgIii5vDU5x0KLzspaVKaU++vMEsZOEiB2FNPqpaJCJqFVQ9puuVBCFtO7c
         PHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724195; x=1719328995;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=hbKckpKDdBSobcUSkd8jK8NQejp9cGfia5UMqUXfYigVoUMkCpu6Pdhz+/o0wlJ5Wb
         TwYJkw4hsuoL26MVYFY4OdZpdS3DBS26ykL3ow1fJ4x0UGWSDC2/31G2YmH+UjtOwEo6
         R2GSE2jm23h/tzT03bE9a2Y6wq10PxSnNDheTSH+DzU0R1hpRIWQXqJkup92xbNt/QYJ
         XPTolnxPdG2znJMzpQwgoQ60b/D2wx0SjJScLjnWFTteB6otbwrxI0y8EZ/wT9VW0Xi9
         dCECcs9AeifNfgy3era1rs/Dorr4GvP+/xoqlxi9OMjs0kTUodwhOhFgI2+z63i1RVJI
         uHhA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNnyJkjUcIVuSbACSxyDra4yrWQvUo7Mv6pxvyTBE3R0wMgihVxE+FIAu61lbfoNC/NNWuQzBZ6yDRhay2drgo47RCgevvA==
X-Gm-Message-State: AOJu0YwA034OXWBoUVnDvW0NDeZrkYnzHWle3uUeu4JCtGm7KRuJBGAH
	jsoT7vfe1nVJC427MSVNzgJp+8JD8Br9ZqpqaD6fX3qai0dUp58CU0wHRTDqtn8=
X-Google-Smtp-Source: AGHT+IGFP+kdLoxpKQx3u24Cy0x7mExeMSZbDQat0SWP9aQxiPjEJWd4R1hjeoSMC4kDIYRzSdOcQg==
X-Received: by 2002:a05:6870:1649:b0:254:a5dd:3772 with SMTP id 586e51a60fabf-25c94dd4630mr96618fac.4.1718724194955;
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afaa06asm1862377a34.6.2024.06.18.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, paolo.valente@unimore.it, tj@kernel.org, 
 josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
References: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block, bfq: remove blkg_path()
Message-Id: <171872419391.44295.6483908119531238372.b4-ty@kernel.dk>
Date: Tue, 18 Jun 2024 09:23:13 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Tue, 18 Jun 2024 11:27:53 +0800, Yu Kuai wrote:
> After commit 35fe6d763229 ("block: use standard blktrace API to output
> cgroup info for debug notes"), the field 'bfqg->blkg_path' is not used
> and hence can be removed, and therefor blkg_path() is not used anymore
> and can be removed.
> 
> 

Applied, thanks!

[1/1] block, bfq: remove blkg_path()
      commit: bb7e5a193d8becf3920e3848287f1b23c5fc9b24

Best regards,
-- 
Jens Axboe




