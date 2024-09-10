Return-Path: <cgroups+bounces-4837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8C97460E
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44906B250A8
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277C1AC45D;
	Tue, 10 Sep 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ft3wyKVk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224451ABECB
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007980; cv=none; b=OON1UOSk6cvvkcPkRCcEpQ6cK+W2PLGsL+nycGlZzElfVVWaQlPBKjBYE5KxTWHEUJypFlDDBEfLqqT9vczZT8Npxc9Th6vupDeJZTBxrV5+7nsMJZeEfic95JRmG/S/vc9b37XjYP5JphTTwIc38nJWmjdds+p2egRN+24ujf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007980; c=relaxed/simple;
	bh=9lozWcbmWLbcepezHSOWbdICzaNXH073+Xycr1gGoPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=COZzmaz8/QlnjfrLyOmdgkzv80skEVoCMhOHmAS7RCpBRYCSNoTHANhwrm45LSWTvY9HyDqxSbPI5N0vdTEWEOz4xMa0YPajhqOkIhPGqy0j/5ql2ilw5Oxjw/YUfYk4S21MQGLdSdam58Dhuv+lPzV+pEvXfi2nG0vsji59mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ft3wyKVk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso3949932a91.2
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726007977; x=1726612777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEgf48d3Npdbvo6EbFMiLCDqMwGMD0QaDq1MPdaUUIE=;
        b=ft3wyKVk3aMT1GXHejUXbtmXvku6W/ZTXY/WOJH0UNfc+InzxSYO/BJDgdoepcnA8l
         MnOzvKDJTali7k4VBrlQhLUiNGa1J0mRQ2CI1c1sI7L/9r2WHKcbYWU5C0EeBhpVH3Vx
         VeyaoJ+PJRBVqKkizoOLKwKM3cKQwXtb2N9n/bZAcIw3zZLTeJdgypmhkbyS/O+8MMPX
         rzhPHOrdKJFWQ3HGCSAYW+TUSjLtX+F7mEUQds6RTwQEnL8mGUWueBxpawJD9Ny37Cqo
         MPVdtkuTWE9egvs7Mg0SiMgi/CA0yl1fH7rYXgZ0/IyqRItCfchsI8sZ5WpypJB2GcP/
         l81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726007977; x=1726612777;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEgf48d3Npdbvo6EbFMiLCDqMwGMD0QaDq1MPdaUUIE=;
        b=km7zKxzO46D5YQ6KsiuPPxGOBXy34isfoj6SIBTuKU7FD84IDZcB4g/wqgI/WmXQ0A
         lkM8DEgPFkxhKyu90SIZlzLu90YzrxMa+PSe7PFWFosDC8bG0i1rTd53uJPSdthE1D8+
         FSuqN4OPZqoDbLuhQQrTaoDjQKhYo6vOQl4gdtwGTykXTSNcK1zkDlVKSTkCs1PNCnlE
         +M1o1VdjihX+H+6GUJXwdy3OBE2bfvpQeOTpQh4mchPGtMYBPWxljqK3qOSV0ojFiPLs
         5yLDv8vjV1jV91rYZU+3Fs4QWk8raWlSREC8YLH13sn8o9c3iVRKiLFzREGs+xjZRoNZ
         14PQ==
X-Gm-Message-State: AOJu0YziBlpePUhg7UZ50eIKzBycOS1yNuKnUPQUi2tLOPS9B7ZR+JKW
	XaIF3+QzpQOAfgv0FSKbbES9zd9ZDH0hRRfiwVk+PeJNsFFJx2sxJTd+ntHe1A4=
X-Google-Smtp-Source: AGHT+IHCH2U+Pd8pCtG0FiLuc/i8oC84BPGovGTV+RXsztdpQ8wULTsd+XipxuU/K/xfaYWjQ1mgAA==
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr12858061a91.40.1726007977323;
        Tue, 10 Sep 2024 15:39:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc127c5bsm9023783a91.52.2024.09.10.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:39:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240909134154.954924-1-yukuai1@huaweicloud.com>
References: <20240909134154.954924-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.12 0/7] block, bfq: bfqq merge chain fixes and
 cleanup
Message-Id: <172600797599.158663.4657437776130763939.b4-ty@kernel.dk>
Date: Tue, 10 Sep 2024 16:39:35 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 21:41:47 +0800, Yu Kuai wrote:
> Patch 1 fixes a problem found by xfstests generic/323, tested on scsi
> disk with bfq.
> Patch 2 fixes a problem while digging the above problem, by a debug patch
> to print procress reference.
> Patch 3-7 are cleanups while reviewing code.
> 
> Yu Kuai (7):
>   block, bfq: fix uaf for accessing waker_bfqq after splitting
>   block, bfq: fix procress reference leakage for bfqq in merge chain
>   block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
>   block, bfq: remove bfq_log_bfqg()
>   block, bfq: remove local variable 'split' in bfq_init_rq()
>   block, bfq: remove local variable 'bfqq_already_existing' in
>     bfq_init_rq()
>   block, bfq: factor out a helper to split bfqq in bfq_init_rq()
> 
> [...]

Applied, thanks!

[1/7] block, bfq: fix uaf for accessing waker_bfqq after splitting
      commit: 1ba0403ac6447f2d63914fb760c44a3b19c44eaf
[2/7] block, bfq: fix procress reference leakage for bfqq in merge chain
      commit: 73aeab373557fa6ee4ae0b742c6211ccd9859280
[3/7] block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
      commit: bc3b1e9e7c50e1de0f573eea3871db61dd4787de
[4/7] block, bfq: remove bfq_log_bfqg()
      commit: 553a606c25f8ff5c518c7fcf488dd4dd5fbb4795
[5/7] block, bfq: remove local variable 'split' in bfq_init_rq()
      commit: e61e002a67da9ec36571af743c94a968cf1ce116
[6/7] block, bfq: remove local variable 'bfqq_already_existing' in bfq_init_rq()
      commit: 3c61429c297582e0da7231fb29fc5ec1d2c7d1b2
[7/7] block, bfq: factor out a helper to split bfqq in bfq_init_rq()
      commit: a7609d2aec67ec16220036a5b1b14610883cdbd3

Best regards,
-- 
Jens Axboe




