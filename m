Return-Path: <cgroups+bounces-7164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED8A696AA
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698DD7A5ECF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2920767E;
	Wed, 19 Mar 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kR8ICfbi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3707206F11
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405762; cv=none; b=F92ANrRG6FmQdborIHiEDJYM7bsjYJ2+uhm94OcMK8AaqnzKBtXuaPdsVollIL7gaZvANNuzAkVK9M7QpTCcsE9Vd0Hc7rm7MjGyA+Lg3Myy/ZKPVZK8eCdm2Ejqcda9NAZ87/YUcSPXdnN6+Te1PSPvoHHvuKnlL2Zu3kkkZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405762; c=relaxed/simple;
	bh=DcDE+MRTu6kEhaYNT5m8P6VQjWGqHKsVLZMTLd/6IUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ci7K1F0mPEvFpuUDncEKgYeWt1u1Ge/5rIoddHFm0kHxFrXrbeKKwoxb9T+MrI2yI7pxWhVVzNkDRI2w5ccvSWXpURTDK3h+gD2PWK+hUlNYX9fg0VNaky9R1dBP89VjVV/OQu3MY/tflVd0Ew4a36GcJOOIRrKH6IyhwRRFsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kR8ICfbi; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85dac9728cdso194924039f.0
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742405759; x=1743010559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrZFIfvp8oAO0Ubzp//Y7qhv70w3dwVAU93bLRb8Kfs=;
        b=kR8ICfbikoK+qgVBEmEUiC1M+J97IEFnHIUjuHzgB3lYvZrAFQlVJJAtytspDH9d2f
         W75JYUtbbTxPIWJGLk5wUaYEhJK0X+2ZFOzuo1vzV+hEHjbhacGNkk4VsPC373j/p2IC
         o+MueDAtyEtjQl5LitpUZwjTFUByKXbAL7F6wxO/4CluHwX/5IdqgB7vjhDZbZst4igv
         VIQgHMI8WoweGl1bLNO6VstmUQm6uhtOiKQGRl30/GrQIG4dvevQ9XPpaRGtABMXOCz8
         zFHt9WO2QL5JIbxp4u7jsrGpUUMOIuva/DXfQL20RL8PPw3AR9wXdfhlnol/t+k2PhOl
         Q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405759; x=1743010559;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrZFIfvp8oAO0Ubzp//Y7qhv70w3dwVAU93bLRb8Kfs=;
        b=ipwXvb9TDTbjbRhKaP0X30jpLlPAq6mvwbsMSy8LcgupomG02bjKPKzbT9Ye49TnMW
         PqsXtSdY/afeBWMxYu0s3VA+jFXz2V8R5gvlWDtMGc+xzV5hPh2R/AGHQ8EdcdCuEGxJ
         wGGmUuLOC66tVYtn88ZcFCrEz9l9A2bEW3uu5xuN3XHD+sMblwanCJS6004jzBqPO0iH
         3y9xWXeFTNM6y7HzPVOEiFaRP2VfewhQ5Jysmcf1NutWB5KPhRrdnFD80SoeEk5bYWfM
         Y2hEN1t5d6kGu9w9PeFFRIQg6t4T+0orI1f3TTKJmtn9+++dCizmSh2JfnIYkV3JOJRy
         9HkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR4HEU0+u8toy8E9EP/QrHEisq2gp6DYmxvwS7tSvghswKXWCoBtZ+JyZa4xcfTX/Jme0jZX49@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AZslm0RY2v34QtHFN9RuVpbCw8nzm8AWT8IP6eTHj59G4nQZ
	djzxetT4akCqDLACGIaHmBXMuKjWWXyUdoo8re1MaGxhKA9WHRvFH4IFUalV40w=
X-Gm-Gg: ASbGncvCkQwFTURQ7U87Yvzy6NJfBzp/qjb4cGH1SPJMPbzNNmhwVVhzySF+N0yFf/5
	uuiOrNj8WqECiuFDh4e4vi1z8E26mKu5w4jQOIQdjdITUAwpOhzjyW2lSufOnWiqbfRvK37MAgi
	O0unN6jxXRT9CSNAU8brQmyMNUYPr9wJbn3AVzCDQU5AkbzW6l14G6mH2HWVhYJhd23fe6FOv7T
	PCFfFvegbfCY5M5rHe2sBtfvCrdExCeOEwlt6Zo/u0xlN8MPbSL+OnvJSxMueBiHzobyKkH+yjp
	EB9qbLJ3UH7ZYo7eOiNaflb4g3O4IPu3+aU=
X-Google-Smtp-Source: AGHT+IGxIyPSKaGDDYnGXRkqb2ki9jF8MrBdNwNmODau3eoFPZFGsXbw6tVGRnc5ueu0X3NGoxTG4g==
X-Received: by 2002:a05:6e02:1aac:b0:3d5:8908:c388 with SMTP id e9e14a558f8ab-3d58ea973c8mr2843215ab.0.1742405758834;
        Wed, 19 Mar 2025 10:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a646ef8sm38572345ab.9.2025.03.19.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org, 
 tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com, lkp@intel.com, 
 oliver.sang@intel.com
In-Reply-To: <20250319105518.468941-1-nilay@linux.ibm.com>
References: <20250319105518.468941-1-nilay@linux.ibm.com>
Subject: Re: [PATCH 0/2] fix locking issues with blk-wbt parameters update
Message-Id: <174240575789.107020.18022154030332779642.b4-ty@kernel.dk>
Date: Wed, 19 Mar 2025 11:35:57 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 19 Mar 2025 16:23:44 +0530, Nilay Shroff wrote:
> This patchset contains two patches.
> 
> The first patch fixes a missed release of q->elevator_lock which was
> mistakenly omitted in one of the return code path of ioc_qos_write.
> 
> The second patch fixes the locdep splat reported due to the incorrect
> locking order between q->elevator_lock and q->rq_qos_mutex. The commit
> 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
> introduced q->elevator_lock to protect updates to blk-wbt parameters
> when writing to the sysfs attribute wbt_lat_usec and the cgroup attribute
> io.cost.qos. However, writes to these attributes also acquire q->rq_qos_
> mutex, creating a potential circular dependency if the locking order is
> not correctly followed. This patch ensures the correct locking sequence
> to prevent such issues. Unfortunately, blktests currently lacks a test
> case for writes to these attributes, which might have caught this issue
> earlier. I plan to submit a blktest to cover these cases.
> 
> [...]

Applied, thanks!

[1/2] block: release q->elevator_lock in ioc_qos_write
      commit: 89ed5fa3b5419f04452051fbcb6d3e5b801cdb1b
[2/2] block: correct locking order for protecting blk-wbt parameters
      commit: 9730763f4756e32520cb86778331465e8d063a8f

Best regards,
-- 
Jens Axboe




