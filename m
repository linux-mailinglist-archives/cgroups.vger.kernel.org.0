Return-Path: <cgroups+bounces-2837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543AB8C1229
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7E41F21F60
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD416F28B;
	Thu,  9 May 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="voXvVGm9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6313C68C
	for <cgroups@vger.kernel.org>; Thu,  9 May 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269518; cv=none; b=r1/9HH30xJu+VyeZi4J6VeUKedqBfLSvEW4RmSkXC2sq8QsfJHJ0CdHIW56AAOFnyTJPuu0jplNryHIfgghNm4gAM174M2ckpwL7qj/fYsq+BldbDKVJ8+bt2rvjRPogykCskLZXDKGFZ0HQksv80zzYrrbSMD/1yJDLb2tAqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269518; c=relaxed/simple;
	bh=DZNYdSr3PQT2Ytv6yKADnFDz0/6OYvMONIsLOfnnwGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OhzQk4Q9ivqImV7nXamTIvL+7MXNnIyJUHK5Ft4cuKx34BWpnOxqQtdMvMHlwY5rKFrF17Y6rgpZXEOFLE+Yjb7Sj/Qud5YQhdZS04D5tWBjuVKUOHtWLdbtHtb1rYKWvFCCPBaDKhm56zFN8/ThonKclNl0JFpdD/BEeHrj3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=voXvVGm9; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da55194b31so8046439f.3
        for <cgroups@vger.kernel.org>; Thu, 09 May 2024 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715269516; x=1715874316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gUCh8FY7gsl2h4E/kN2GFyVm9t1B96kSbiEPvae8u0=;
        b=voXvVGm9DxyhKNpswr3aTjHPpm7BA4skpcAlucDP/KtSdxGEdDPyL3Qcp56FU6CmBm
         XZZxBgORT6zm9Pw/DtGJrbf/4Q3rk1oJ52ZqJD83ILZF1C96Dsp0WOjOhUy8pDXbIzlu
         +y+9Ctw8VFDJLF8w4u0Tgbg+FW9qHIgGEB4HnxlIxP9LTiqs8MCCSz3unRnqYSsnznLA
         LURo9WWxwoaUb5QHSV+x5quV0diNqOIxmFrWBq3oLJm4Z//vdHfqY0jDuT0MUwuThWFp
         DOSgfAu1TFLNX7knZayA5ADJSEf02dBObEMJ0pHAZ+CjHPQeWAU9S6vXWkiote5Ul5+B
         AHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269516; x=1715874316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gUCh8FY7gsl2h4E/kN2GFyVm9t1B96kSbiEPvae8u0=;
        b=DxvWU5dKUJfUxTbx18IypEAjciaBu2zNh3AwChcwgxRepNwz1fC41x2TPw+2elNtr2
         2IcaVhgw5QU/Xs3PyHkJhvk2PRccM3KA6eJ947W8NEI3lzLR/KNZ7ATp2jkUIp5MkAC+
         Q+NuC/2tt8xLybWEmvUwjAQElPxtyUSflEAVbXKqc386e2hjXeV0MkCkNXl4y8KZh5Ns
         MvLWCVg6QChoHoWz86Jn41pjfFbqWMCe6fM3Ui+1VUCb93g7dKMMiHF+ojA7y+iWPP3Y
         JtdH/IJ+Rary+eTJ7HI+qjUwZoCLxfcwvnphG4cTY8Yg6M6qfQZ4wMnMxcl4hxm18Zde
         wnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWChqmCNqBXzE92lSAuUzBQ1U/eo5o67JXHdkS78KKEgGZKDQcz2dqElMWvshcurH6JROnQJM8t/2kMt8xIr/zbCp9nY1eEQg==
X-Gm-Message-State: AOJu0YzZaYrzWyoztV9DurRf08MGrGWQ3+AIqAR9hThyjYOZabP+z/qL
	jKo97nrnGJBt6agXGy5NNpZMTrA3ZowlOFw06SoLPVeHtcmtYf4aSAG9PRBcsks=
X-Google-Smtp-Source: AGHT+IEonISz5k6S+QhuL+vpC60UupW6zWwKsP/6j7LitGl0JXGDRiQ702VSRrcsV4zjn3bncreQ3Q==
X-Received: by 2002:a6b:d101:0:b0:7e1:86e1:cd46 with SMTP id ca18e2360f4ac-7e1b520b2f8mr8525739f.2.1715269514443;
        Thu, 09 May 2024 08:45:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de473sm416106173.154.2024.05.09.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:45:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: chenhuacai@kernel.org, tj@kernel.org, josef@toxicpanda.com, 
 victor@mojatatu.com, raven@themaw.net, yukuai3@huawei.com, 
 twoerner@gmail.com, zhaotianrui@loongson.cn, svenjoac@gmx.de, 
 jhs@mojatatu.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, cgroups@vger.kernel.org, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
References: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.10/block 0/2] blk-throtl: delete throtl low and
 lay initialization
Message-Id: <171526951316.85538.15766009475504777468.b4-ty@kernel.dk>
Date: Thu, 09 May 2024 09:45:13 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 20:11:05 +0800, Yu Kuai wrote:
> Tested with the new blktests:
> 
> https://lore.kernel.org/all/20240420084505.3624763-1-yukuai1@huaweicloud.com/
> 
> Changes from RFC:
>  - remove patches to support build blk-throtl as module;
>  - add ack tag for patch 1, also rebase on the top of for-6.10/block;
>  - some small changes for patch 2;
> 
> [...]

Applied, thanks!

[1/2] blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
      commit: bf20ab538c81bb32edab86f503fc0c55d8243bbc
[2/2] blk-throttle: delay initialization until configuration
      commit: a3166c51702bb00b8f8b84022090cbab8f37be1a

Best regards,
-- 
Jens Axboe




