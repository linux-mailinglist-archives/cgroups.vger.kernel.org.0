Return-Path: <cgroups+bounces-5144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E583D9A101B
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841A8B2504F
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68320F5D3;
	Wed, 16 Oct 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="06m7mMH7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0A187344
	for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097614; cv=none; b=Pvzf2pYneqZiy5qihwjFdlpmqyMf0GWGkrnvrXTUaNcFX99dVhubXn5Lei9K9yp96m7cLCls511uunVRlq2sCkS2XLd8fudEX6x9Vy9ZH6vv2MgiB2lJO+BfIkOgPh6P8AiTL4HtCBnlQV/k9A9jRO8Jms3trCxzm3lM67kHG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097614; c=relaxed/simple;
	bh=8F/Pvnvvo4aXEO2mmzQwtSqupaz9Lzu4xAvFO71bhL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NYeu9a3/VbHc8f3iAac5hArExm43o2E9uJ0q0eJQ/Kx1QPW3zx+VsHNWP+bi4CrKSB1DD3upY5FphXW85YAFOnjGksVislRRfs+w5S9TSMYqzwNRPx1Tc74cwem3p0tW6X2gu7bmRifvG5JVHiYfhsvbdOPUEmgF0bAoM+zP6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=06m7mMH7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83493f2dda4so39640839f.1
        for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729097611; x=1729702411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBsB0g+DF7pSDBlqs4qVSsDFNgcBXLkZdRuPIBB/RZM=;
        b=06m7mMH7heCqYmDz+QVUaMfaolagSuAukFLQZ9wHQYmRxG5uAKZVgzOfcwauTsYXIf
         fNImx2CskFLY8hkpliD/COYSEiD8FXpEVPKmy/3z0ZBdXil9iDgZoef6DPB2c01LNV8J
         cWDCzO7EIhbCk7t1VdCN5FlhnnpiaqYZk4jXsy0mn+AJOhp+h2nCIHKLLl4b5mNE2E79
         Zsw6nqDxd4OkQ56sw6rNM1K0gte5sPKWANQ3mFYFfqvZV0knhtkpd7byR/0tGJlQS3xF
         Vdywo39xBHY/1vwyF4L3b4FaH58lLhdltUPVJTQt0rNTaOLPvYYsRHLmtfwcZfCypXxT
         PCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097611; x=1729702411;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBsB0g+DF7pSDBlqs4qVSsDFNgcBXLkZdRuPIBB/RZM=;
        b=vHCeCFK0n1wpNp4+BvrpdYGkfDQYUfJ2qbExk2zmjTDo8VHP7LH8c/74N2WK2RWO46
         atp7fNPm+BCdF/D8GHeRHjEO9Xy6/5zQkcE0SFuIJkR+/UGLrlmmmdnm1bmGH/hBlqWz
         7mF72fDhfTDZPJKsatJufRQVHmcq6XRJnqtsVUmfaNuhAit+t1sSSHwHXyyt0oOwyvJ3
         B7HZRbUnmuO0hhJ4GctzLwigwORC08dJ7dtZEv2Whv7gf8plqPE/HFNHKE74PgquQMNJ
         HAf0pJavln/PfPIlE4FjSnfmRTHDL2dFa/14cQNUOBtqNy7Xf8zn1lYU+3B6hszLx6IX
         8hwA==
X-Forwarded-Encrypted: i=1; AJvYcCVsDNmF+XXDbnUx4QxZ18RUcgpXCafC8wXxfuYBRNJIQG6gvwF7ZP+YUpgb19k7NZCoS3dvO60J@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEp31FijXk9YgTWSk5qm9Z2+JlB2+eHQtIoLjotUuIidKZ4Km
	UAZkNy38n/5XJO+LaEwSAH+VLudVGDXjk8gtpOZfEKvzIi2/wO/jsKNS2eU7osE=
X-Google-Smtp-Source: AGHT+IErsH0Wa5aCjqXBPJe7EsTSQ0iO69fRmSlLCteUVyrS+k6S6c4RoYwTWsep6CbELNWIhulsWQ==
X-Received: by 2002:a92:c56f:0:b0:39f:325f:78e6 with SMTP id e9e14a558f8ab-3a3e5231a55mr2431125ab.0.1729097610626;
        Wed, 16 Oct 2024 09:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70749fasm9015025ab.2.2024.10.16.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:53:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiuhong Wang <xiuhong.wang@unisoc.com>
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com
In-Reply-To: <20241016024508.3340330-1-xiuhong.wang@unisoc.com>
References: <20241016024508.3340330-1-xiuhong.wang@unisoc.com>
Subject: Re: [PATCH V2] Revert "blk-throttle: Fix IO hang for a corner
 case"
Message-Id: <172909760815.37494.11882632123992412435.b4-ty@kernel.dk>
Date: Wed, 16 Oct 2024 10:53:28 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 10:45:08 +0800, Xiuhong Wang wrote:
> This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.
> 
> The main purpose of this patch is cleanup.
> The throtl_adjusted_limit function was removed after
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
> able to scale after setting bps or iops to 1 will not occur.
> So revert this commit that bps/iops can be set to 1.
> 
> [...]

Applied, thanks!

[1/1] Revert "blk-throttle: Fix IO hang for a corner case"
      commit: 97550f7c11b566088a401f6e8b401886fda2cc5b

Best regards,
-- 
Jens Axboe




