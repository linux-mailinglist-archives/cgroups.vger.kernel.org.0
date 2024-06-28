Return-Path: <cgroups+bounces-3457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B191C79D
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 22:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF704289942
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474F7FBA1;
	Fri, 28 Jun 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ziWuMZdc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1079DC7
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608122; cv=none; b=nPb7OXS4QrZRDzCW3NQcJXM1p8QAIsbQOyrPNo0FKZbeeEBjXL3+joHUL0FJDuy6JjSlcceu56zn6J659FxBRk6dUrJ8bwIDX+RYvDimXlUvaYMgAtUkrNb7Pm/DOO2kRof5bjlo4daPjZ24dVzOtxjh6dLCI+urn+jWbasz5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608122; c=relaxed/simple;
	bh=Svpfo/LO7xG0b+T/C7wXzLSpwwsNaUuX9O3157AiNWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q6ymCTNAsoFc4Ay/5rz6yNxrzVuSf8Tv8FcDtlB2/zfOHuKgt6XEQ+ICSjSmmdecPUrIdi+qlBj3gC/R1knRaaUJgLOaLJfBEwsR6F+OZejnhwbde931y9+GsJtltGWmxXqigpe+Lef66OjwDjhU9S5Q5ZD0eshwHBZ21/3QPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ziWuMZdc; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25989f87e20so121500fac.1
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719608119; x=1720212919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvEgWHlol+DGBYutrDW5Wj/dZdUnrf63FlBowwL1/u4=;
        b=ziWuMZdcguS2zZ8ucQHYCYqqApV9+E2y1v57K40f3ixfxc0i20uHZIwG+uN9c+qsut
         VOur1yAHtCepFoFjzQNNNL8qk/iiWwj3OvaXFkZnAQ7Dvu7JtE6ujmr0HifF/jLBWa4y
         L62UCmKw58ddG1gvKvYlbMo09pNP7UJ1C30jyozB/0Euh2X0C+2RgJiF1EXyxU0zi+Q1
         811Qpdf+LHXgyouxJFszFZP15U6SOTkA8ifY+tKyLFAONQopRsUWLJvJCD/UuIVTgfml
         kgdcvNhqTbaevMNIlRs9V1NChBM2Rm4gWBujB8RiwD1aZItW8WM33m2o7ffwjRG5/O+r
         j7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608119; x=1720212919;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvEgWHlol+DGBYutrDW5Wj/dZdUnrf63FlBowwL1/u4=;
        b=RHV6Tn23gjO2q5HtDZ6IbXIS3cFF3wHd52ul8S2qkkLirHE9ZpBm9RWQ6/klkOjEI9
         iinHG3Fcf2IefptvkSbBnUn3IKnD4U6ZD99O6jj+R4kp4JDCXnd2FGLGeaLKRbhb3ui2
         vk0I9jfHLVW+dyAGFsczbIXrkjksXrwdG2tuwqU3ubD5UITR8Ft/cXnLDnEelsvgcVNk
         92W5zvmuw2b6TwIAc+3LyetUKp7yFOmKJE/RZioFIP0kK8156Dr5FO/XbpXlsIDdgxGi
         632wxDETOXG4fKgMyYe4C4CUgt4bJD2dX+eeOZYICmKBbXgmsEKQECzFDUyGw0FUJ3ZU
         HCFg==
X-Gm-Message-State: AOJu0YzJZY532p+LJGooxyIWmvEootP8NbiSH9cK4MPQsK5Vvr9TPBtr
	HnPdr/neYfq8K+J85OIUaoZQEt2FqbpORstH9srSLESBjctJck047JuoxXYAVkA=
X-Google-Smtp-Source: AGHT+IHOrHK0Rz6XvUsgTR5CvGlJIHipE73E1BMvd4gM2EgON8ff++cWGZ67lwjV8sKJ4DV1NZE5Jw==
X-Received: by 2002:a05:6871:3324:b0:259:862f:b898 with SMTP id 586e51a60fabf-25cf03e224fmr19822041fac.5.1719608119266;
        Fri, 28 Jun 2024 13:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e37ee64sm595605fac.47.2024.06.28.13.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:55:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
References: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix lower control under super low
 iops limit
Message-Id: <171960811810.898565.9691388431635837442.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 14:55:18 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 18 Jun 2024 14:21:08 +0800, Yu Kuai wrote:
> User will configure allowed iops limit in 1s, and calculate_io_allowed()
> will calculate allowed iops in the slice by:
> 
> limit * HZ / throtl_slice
> 
> However, if limit is quite low, the result can be 0, then
> allowed IO in the slice is 0, this will cause missing dispatch and
> control will be lower than limit.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix lower control under super low iops limit
      commit: 1beabab88ecee0698ecee7b54afa9cce7046ef96

Best regards,
-- 
Jens Axboe




