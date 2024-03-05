Return-Path: <cgroups+bounces-1967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1138729D5
	for <lists+cgroups@lfdr.de>; Tue,  5 Mar 2024 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDE91C22ADD
	for <lists+cgroups@lfdr.de>; Tue,  5 Mar 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BA12D1F1;
	Tue,  5 Mar 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipJ2Ttz0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8A12CDA8;
	Tue,  5 Mar 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675722; cv=none; b=u7AFFfwlEEwvJ/Psyo3ZK9RjN1tNEEurHqt+rZTiOw51G+HIjOLs1e6ytSM7Xes578GruKTK42jXwV8LvQaEz37Gwn5QH9tat92smuS9vWX6E8KIMzLesMACg51y8qPCuCbthouissiB2E4shbh2zjtXOMJrgFYxmCW0MwPASp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675722; c=relaxed/simple;
	bh=tt0IQ+huNNm8YGn7Z9m9XSYubGsR3C/E4EzPa+bLbSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gkRY3VMReHdXd+feBj3MGQ6VO28B+aUtX8gddZbOjhQossRzioBP0XcZqt61QaWO3k/VPWTpmAFcTYv2hfn7bLatsc66ePWd0zv6HPapkmL+Ks5vS7ksR7TBsMs+FmO2GgmTvHXFr30hhCrbiloTzP8nZiTEFBzcHFWRyeE7xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipJ2Ttz0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dca1efad59so5251448a12.2;
        Tue, 05 Mar 2024 13:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709675720; x=1710280520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uWiDzhAIJc9jHSt+iT09qg5BtL72WW/yBbSvdszABbM=;
        b=ipJ2Ttz0RYBDICeqVTMheVEySsev0fblVxBSRKFgv7BdgJ9AS7n363eHjrQMml8DP+
         ZvgUr7CcSnQt+1fDHXchKSrgXZPqyzVqcxPxECk7Zz59r7LU5Hzf+6E0KGBkrtF0wcw5
         umC6PpWue1mFsMaFQWpu8tdqS1J/US8wpiWnDC72GyKKVCB+Hok1NLDMctDUbZfsgcgL
         e5lHIBPiKo7AHpDGikzd7pMEDtGcHv9Gk9Ydg7f05j1Kq42+xPavdknrjL1Y71d1JRsV
         VrggrfvgfVT03Kn1t2SwzyZWOUbmNEsQP5Z+JnIrGtZkpN0uTCwOkjQv0gAkvkPs3CK8
         0CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709675720; x=1710280520;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWiDzhAIJc9jHSt+iT09qg5BtL72WW/yBbSvdszABbM=;
        b=sFo+BHpEcLcLtzdzKo8s/N+1GLUpWZ129XG5Z8TPynJMi0D0Q0Sw0CkC9IP9YJhwvO
         roDpUxoiCxPhwagPIJS40fAew1ZThzhZn81ZwzV2wDQUNfSs6cy0qZz49HwfH5CHaKkk
         QnRyGijouJN0Ks/fPwKFUkmY+Tw/ofQdq0vEzabkF7AULi6b+JFalYqn610arAumKslR
         jmPx7YqF9rj3mbw2nZ7dFkR4z0EcRSB++59LEaOBEyyKLj6Wu91Cx5j7Mkvx/JESniLI
         pHRW2nhJNBlFQ9MpNGaIn1PMdwfeWSrvhpKmdpfH3qIDkTaEhRPEi1uvKI5usCnK2S6n
         3pSw==
X-Forwarded-Encrypted: i=1; AJvYcCWW/fpFIbhjkTk8j3OVeIqdJaFP40oZOrc70wex4sA0GE/XVube5duyZnL5Ch8PIB5imVRqc0AoOnfoWjvpx3lQ8t9j1ZytiQ==
X-Gm-Message-State: AOJu0YxT2Hs0g+FohHreZ9MdGf9bJUYIzpyFTt04gSKt3/CEd/38H/2d
	MZ+1GqquS5rpmX+aFDNJdaVjxS1Y7Oin7X0gxigTRMCLA+dZZ8vt
X-Google-Smtp-Source: AGHT+IHs7whfnpxa5XO4a8RITJKeu6MCi3DyvxzBq9V0QsPO5Rnu/K5wm39oqmGiam4QuNWhgGVrjw==
X-Received: by 2002:a17:90a:f3c1:b0:299:560e:79a0 with SMTP id ha1-20020a17090af3c100b00299560e79a0mr11213356pjb.31.1709675719951;
        Tue, 05 Mar 2024 13:55:19 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bc9e])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a061000b0029a75e027f0sm13339129pjj.51.2024.03.05.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:55:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 5 Mar 2024 11:55:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.8-rc7
Message-ID: <ZeeUxivndz9IXJJD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e326df53af0021f48a481ce9d489efda636c2dc6:

  Merge tag 'v6.8-p5' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2024-02-28 09:30:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8-rc7-fixes

for you to fetch changes up to 25125a4762835d62ba1e540c1351d447fc1f6c7c:

  cgroup/cpuset: Fix retval in update_cpumask() (2024-02-29 10:30:35 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.8-rc7

Two cpuset fixes. Both are for bugs in error handling paths and low risk.

----------------------------------------------------------------
Kamalesh Babulal (1):
      cgroup/cpuset: Fix retval in update_cpumask()

Waiman Long (1):
      cgroup/cpuset: Fix a memory leak in update_exclusive_cpumask()

 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--
tejun

