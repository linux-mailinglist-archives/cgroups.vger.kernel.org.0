Return-Path: <cgroups+bounces-5182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054669AB14F
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B36D1C224F4
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785501A264C;
	Tue, 22 Oct 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QceEMfXL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC81A257C
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608468; cv=none; b=Ew28tosi0ABEAmc0qCx4Be2+l/3oW+jm3iwcGA+P0JVYnIyehGr9zVNLGbpJ21p2loYK305yBIjKIFK7wLkNPEnreRo3amPjJ3MZq/aGtRbCTg+VRyHB6tXNeYjz6qLheZ5wYGuqRAijfSBgY4UoGl7i/0ZJAxf+JAqllywr8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608468; c=relaxed/simple;
	bh=AUnKd1M3xJOmg0hqJKHoR2GCQfujvFGd8uC2lbtp0O0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feRWF9WuNR0Lilucy52Y/0yXQUTdL7iuiVCQMztehU0AcL+SK9Fzdqyy4Vjgp7hnIZ6/ebXuoSCibzidrvmYayNyY3wGDLtDdygqWXOnbmhdoz/FxWYob5x2ozK2kGxFSh2K+AZIDGz2XJaYzIiy1wj3/qm2jleSp2rLlMtL5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QceEMfXL; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so219990039f.1
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729608465; x=1730213265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=QceEMfXLOui1NwL++tUN6xwq+ct9k0FdaM8IuzcaYfbowKPSrrVV1J17rUoqQBrk58
         EO7Umbe7SbrPnupj5acuyQIQp9+TOKoy+poSoKICwCzkdSs6YWxVWAPD1SUriIbb1+gV
         MOeR4hWmXIDXMjLHla4kdb0LoU8If/7ddP9OrE2ZrlXLHL3DoKpg75JpPQePQ5Fs8fnK
         AkOwGFdQj+SQNVCxWyOnfkaDtCBEnxH9L2D7LYEvmS7JygxTWR5q5F+jN/BnPrx1Qrs4
         YZakC9j7khvV5RwWXwaN8zZ6W0wt8DitxEClrKmnKwcTKOABzez3+E3+Ndm7SOAMwk3Y
         Pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608465; x=1730213265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=n9RGV/34NVz39W68NLbMjWuj7xtfz506FaAFP3jxp0bmeTirj8CIgdUI9wKz0mcx9h
         kPbLBZa9olKWWWZdCu4twxee66VOF3/NohlWOGaTIDCO+QeivI9mQ+oEt4Zosx9aVi6O
         KkRMisiZ8r2uRyViDkeqVHaF5lE8jMc1BlyjBlx5JatUijvOHdb/o8BdJtmE5ZZ1F0bw
         XY8YiqkXTjIDUteDEM3eHUMDcTfJEpXCVORpTVxMJG9v36GrUkIA5R++oGEFA4LvZWmB
         /+pssAUT7k1CDG3I69gyFbLYFr3AUKux3dMCM1PutyYVCp9H58NxeqjC4z0gLJyNU/j8
         zDBQ==
X-Gm-Message-State: AOJu0Yy5rptSrZBLuhPTDk0rireGMvgtxCC8FRMYXfTGrtMDQu31pBTz
	QP8+o69SevEfTTZtB3dcffdRhtjG0s9AXZakLQNDb7QsGI0q/hga2C6LDFXFqhg=
X-Google-Smtp-Source: AGHT+IFMA8/8XkeEa3fN1L/EdBNpDM5BgG5xlJL0Vg6Yh5CEnSh4WlfRGT4N951JDyO4WWAxrEdCjA==
X-Received: by 2002:a05:6e02:1ca5:b0:3a3:b559:5b92 with SMTP id e9e14a558f8ab-3a3f4060be5mr155339825ab.14.1729608465688;
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fc4fsm1600289173.22.2024.10.22.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, 
 Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
 lilingfeng3@huawei.com
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-Id: <172960846463.861462.5399495567961070618.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 08:47:44 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 17 Aug 2024 15:11:08 +0800, Li Lingfeng wrote:
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> [...]

Applied, thanks!

[1/1] block: flush all throttled bios when deleting the cgroup
      (no commit info)

Best regards,
-- 
Jens Axboe




