Return-Path: <cgroups+bounces-5871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B89EFB79
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3A716D8AB
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28A1891A9;
	Thu, 12 Dec 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZGr9K8KF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623A188A0E
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029331; cv=none; b=FcCvMUF8HmJERdJeNm6KpnDwucYBYeg3ioXOW0SnMGDD04FIhaXgUfWWDmadBPSu/xJOB6DTTPw+lcSYiS4kRud0f9rqA5dluAV+0CYK1fiTwGRXUqdObtb9GJ5xLQMLkj0lnGeRBUJg7K5Or6xouE6KXBhoOy/OwBf2u/VNqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029331; c=relaxed/simple;
	bh=QKQL4MS5nZa+ROMEXkXGLP2EpoqfuvY8r+Y2F7K489w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p5C69l/rpJfs8vXt1nEu3NiT/nPy78oFVS2JgBhGGOwbtFCHXwte7Tvv3LkBcGKuE1Xi4wUmMuHdnyLYQzIEVdGs0BnG99F6CPCUJxLMenGAg9b8PgjnofiE2JZSfJZgca5uzekg1piWOyj9RV2bg/cfTQ/QJKwZ/WSewwoQcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZGr9K8KF; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so38625739f.2
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734029326; x=1734634126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NEanoTkIUxCO+RPtP6A6ijL8u3YML6PUoYR1PXvvOM=;
        b=ZGr9K8KF6jzbh4QlihwqRMvktw/IL6nKVyTHU1qyW2/CU1xdPuAOV1PRyeVtu3tTCd
         zZJDaqZFsyRsYX6Pg6GzSppdxe+2q6jZQV387vx1Uw3NBjfMZ6qKuZpNc6TucqwahFtr
         ef7lZwP1DWziBEWUdeWRCN5mV+Gv9pCfHw3X3SIr0OAScNQ+d3ewVYRzGhPjlS0TVa79
         Kvc13rsbpWOfvxySgOm9zER29oZARlI6Wz/5uD0NDeWx3x685Q0Pqf+bp4DEpJD5+5Pr
         ND3e8pJ9CeW2L7ZH0o19oMohC8dP2X76W0c/AnerMrlc9g5X9xuKM+HZbF/cqe7qaj5e
         NwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029326; x=1734634126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NEanoTkIUxCO+RPtP6A6ijL8u3YML6PUoYR1PXvvOM=;
        b=P6IeVR5Sji/UIsDIiVPsWG0TEeh5hmjeNsx7tpUgSjB0poQl6CU5H3CLzmH37gkgyY
         toVteRJs85Fe7Yb/go+HUVllX3b8Ytn/EGoQxJidO9SI0/eZB6aTCG+VzmRkimgB8Exj
         kEF1nw1CStSFLf9NbIozRSqSh9l0IHI/BEpra1hgkgFbpmB7OyA056PLgvZ3b1UDQ6pd
         RJfomB3zfLKSdn62YbXI1TkzR5BfIp8zT1YNMwox4USzDzVh17mwfN0HOoBfPQYi0c9N
         eKpOqnQd7hsDw4vJ3ve96IN0BdWGJrgHcjLSXxSumFSs4I7A1dLLnzCBQzCMMwnQdYn1
         KupA==
X-Gm-Message-State: AOJu0YymXYFbeiD8U61U5gKDU+oTbfvtuymLgzlK8CvjGb1ECTm0JYHv
	YdA34qTp47+Dalsz97p1ij2e/v36O9coaS4lVOv5UdlAOomHu7DfotDqsoPOhAXGo7qcAseNTEb
	S
X-Gm-Gg: ASbGncv5Sxa6kAPAnm7Q4r+tQn2wf4o2TYMaRb04Riaa/SuNDAzbbV34jjgZKXr7R/N
	ZqyWF0xNABHIvhDJ6HMmXBamFtqR39qOkVdWYgtlvAwxK2MC+X0xjGRPlzFs2IrKYDU08JzJaF5
	FoluhGHgkBYHtblgUJvU6vwfzKRxzCR2pDOvIQ19x1yiBUe0wdM1FxDA2ambqNhhAWnp6d6f23n
	LQsckLCg9SGvePeFc8NmfheTHY4g5sqYEcZeWX3QAUN16o=
X-Google-Smtp-Source: AGHT+IGhhvkFg5+OlRRW7dAh+LXxFzeHxLNLeGbrpzVSX1Hr5klBw9D+P9RZ3N63ZKwQ7KiNLlXZng==
X-Received: by 2002:a05:6e02:1707:b0:3a7:fe8c:b015 with SMTP id e9e14a558f8ab-3ae5953b1fdmr15053365ab.24.1734029326669;
        Thu, 12 Dec 2024 10:48:46 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a819dd4ac9sm33682775ab.12.2024.12.12.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:48:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 David Laight <david.laight@aculab.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
Subject: Re: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Message-Id: <173402932544.982680.529127077152903218.b4-ty@kernel.dk>
Date: Thu, 12 Dec 2024 11:48:45 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 12 Dec 2024 10:13:29 -0700, Nathan Chancellor wrote:
> After a recent change to clamp() and its variants [1] that increases the
> coverage of the check that high is greater than low because it can be
> done through inlining, certain build configurations (such as s390
> defconfig) fail to build with clang with:
> 
>   block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit 1 greater than high limit active
>    1101 |                 inuse = clamp_t(u32, inuse, 1, active);
>         |                         ^
>   include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>     218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>         |                                    ^
>   include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>         |         ^
>   include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>     188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
>         |         ^
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Avoid using clamp() on inuse in __propagate_weights()
      commit: 57e420c84f9ab55ba4c5e2ae9c5f6c8e1ea834d2

Best regards,
-- 
Jens Axboe




