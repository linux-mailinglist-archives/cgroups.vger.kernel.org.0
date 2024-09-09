Return-Path: <cgroups+bounces-4765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B617971D9E
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E54284D6B
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F2381C7;
	Mon,  9 Sep 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GginV7mD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735171B27D
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894582; cv=none; b=Pw5wKQq4Zl57eoAK97YZvaKfEdRogRdEYGIU8+gaXk63j1ojusTMIrTfql+lRwLsl8Ik/Vb48GN0621+whoKBzieNBvAxf6BWi/qAct5XiEG434G2ypsf3FzGzxlug07z7cUqF52V0k4sUttpUxTKD/vels7VfO4K2FMwou/zYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894582; c=relaxed/simple;
	bh=mVq9S72lk5b5xTO/FfOh3PUK79hfKisoPxEm6dY2/Zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADz9z/Q2jYehqHjEJs4Tqv34DFAS91TXRUO6SJeEKKrBKGBpXMcy+xCfKICe8mJO+c95YH+v4TYIvpHfLtVdMx0kSArQfqEZhq0a6ky0kSqzhfL6hnQ+PecgMcIGcLqZzYj+tFSVxqdARwURUW/vyjfG6/atI613FXQGykS0mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GginV7mD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718d91eef2eso1991281b3a.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725894580; x=1726499380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXq1QAWAAsQrYNlJmOFWR9qiaSyJPA0zyCX7aY9ZQ1w=;
        b=GginV7mDlum/PUuoJf13Wlfvv01cS3gr+aqN0e263izKQuL8U9nn0vG9gQIwykX1Jb
         uRB0y84NuBUfcQOmZTjgvsvNZHRcsHRn24j4aGIiD90RPj1oJDTxIAGkdRgIcyrY6LTT
         +Z2jChAARIITpoHdsctmhWyePoup4v7Jx+UXRsBfB8BxdBvNVv9ec2S/1mQk3PWj8/pg
         5a3qMDvZIi85yKz4LVioXGlg6FXtM3R9DpKHY4s7wpkiKAYH90RzZThnNCGUjNjzwvcx
         6g+o0T7YVWQzKh7YYBPzFShE4xzSaJJm3bOckmgnGpQy7W/hWSL0zlCYESmdY4as9LUN
         fFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894580; x=1726499380;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXq1QAWAAsQrYNlJmOFWR9qiaSyJPA0zyCX7aY9ZQ1w=;
        b=YnEDJh1a+Gg8Va8hYkTbkWG97Ix6i/399LIRYYKC9nl6yiJWV3Zb9A+Igo1lhhWznv
         VfFgaxY2lcOg+tgs3lD6j9GSOrSIBYqdChRUmU0lgUnQga8KNbqpcgaGWkDt7dGh7uRq
         VdJnMZEykYGo5D0B7SxCZ13PrRJ+/8eIuUEhQQykC8bSrvy14MxGgsGcFjAVFXTzV8LY
         O10f3wSs9ICKmSzlCdpXbr4XYMZBZcPldk/l9hnzA1C7VcOVSG+rsgi/J7rLSznBnfC3
         xfv5+9k1b4iIvDHYm5QkbgCAt/nFChNW6t0/EDpYNH8TZj9ks1LWRJ3UIi6EdFWB+Jsk
         QmQg==
X-Forwarded-Encrypted: i=1; AJvYcCVSyKNejZApvHKarigPkXA2sYL++69112vtvA8bbfLLASeAmY71A0M0l/BX1RG1wno/Uhr0u2Cp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7LyIViMqxhDBdtxwPqPAbp0q7Tr0yLKoEJH5hVnvuRE4QQUE
	2MipiD/1RKu9zzsYdXw07kTMZktQ8Sqf8j+Ayo7/Kthx7l3mZSX8oYbADOCNuPnY8sRnBHaqda5
	A
X-Google-Smtp-Source: AGHT+IEvd2jWK6AbqOEXtcOcRMgffXGRbsFWC1ymbvQmWwpnadQlLSPtVyBn+FRcmaDqcgaSeIBSdA==
X-Received: by 2002:a05:6a00:3213:b0:717:83bc:6df3 with SMTP id d2e1a72fcca58-71783bc6f5cmr23496474b3a.11.1725894580245;
        Mon, 09 Sep 2024 08:09:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c1d6esm3632805b3a.75.2024.09.09.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:09:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com, 
 longman@redhat.com, adriaan.schmidt@siemens.com, 
 florian.bezdeka@siemens.com, stable@vger.kernel.org
In-Reply-To: <20240909150036.55921-1-felix.moessbauer@siemens.com>
References: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Subject: Re: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of
 cpuset
Message-Id: <172589457900.297669.16381515839828801822.b4-ty@kernel.dk>
Date: Mon, 09 Sep 2024 09:09:39 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 17:00:36 +0200, Felix Moessbauer wrote:
> The submit queue polling threads are userland threads that just never
> exit to the userland. When creating the thread with IORING_SETUP_SQ_AFF,
> the affinity of the poller thread is set to the cpu specified in
> sq_thread_cpu. However, this CPU can be outside of the cpuset defined
> by the cgroup cpuset controller. This violates the rules defined by the
> cpuset controller and is a potential issue for realtime applications.
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: do not allow pinning outside of cpuset
      commit: f011c9cf04c06f16b24f583d313d3c012e589e50

Best regards,
-- 
Jens Axboe




