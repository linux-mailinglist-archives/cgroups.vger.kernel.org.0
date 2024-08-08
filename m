Return-Path: <cgroups+bounces-4160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B431F94B427
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16751C2128C
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB63184E;
	Thu,  8 Aug 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlR4pESD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AE10E9;
	Thu,  8 Aug 2024 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076755; cv=none; b=XHTvvQtQYRlAUHrHSX5Fj3Ofpl79BSx2voyyaR7drkTMT7wkaQAXegHUm6g9FiagR0pLiP6fvt0vi4/bojbgwTaM8V4p4Is5lqt542mAA8/RxOCMjQSunTlAulh7IFgaGF6lWHIHV+/JNIKoZgUFiBV5Krwc5ujdD5lqbEph5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076755; c=relaxed/simple;
	bh=XwCuLJz2vRSgxBmOmVVSur+GWsOD6GC1ABmAoFsj120=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld3RMypiQMjGHIxwzj0Nr6MWDMk5wdcCvafrW3YEDde/av6Qr1/kr5bcm1bIHvPDTq2hHnK/fsDrlPw7frrK6BMq3DTTXNqTkbFmYAJ8JvbaILsyoHeZmSSxebtB0P/iLOgTkb2kVfdlEdoniU85WESn9mG822rW5c0C4VtOM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlR4pESD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-70b2421471aso301251a12.0;
        Wed, 07 Aug 2024 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076753; x=1723681553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3yyY5bnbVvqx7w3VIsJ5OcVXtAol8Ykco4UAozb63Ek=;
        b=IlR4pESDnppphBHolialWnVo4b+PkgzsHU3nYFoLOdtr2AgTfqbxpqIYsVVF2ii0PA
         viOWa4hD3n6hebLRGqzaRU2SLI9gMA4wc+WOE8o27pMuChtmUs40zyMtwz0HpkaTGvH3
         0DAsXfDqzJm4jfa14xEks5BtGKH71mTrWV4RO4Z56dOTEQ3rDs5OSCPxsh/Sq0OFVsmi
         THNqzskggTYL+GOaCyUH2pvQnf1pN/Zx32iHAESNbyRJjxkOu9v5tWk718tSTDo5ZzX5
         ZdyRdRp4VkdhfCSibcdayd6ZNqJ5nqHigmo8EjxUjWi9YW3U0h6vKfSPKnS6Y2yE8Kyu
         yo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076753; x=1723681553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yyY5bnbVvqx7w3VIsJ5OcVXtAol8Ykco4UAozb63Ek=;
        b=RUWVm8lGJ5sf42YYRly+DhgfQ+QTBLPxb1UhOWdr7hFG9jg7j+jDPH7kXaxYb8vJ8m
         PiYJBseqyzPVRDElQZFjMwcL8OCStkPkgqVELwgXF4GY/2vvMFmqpYyh7PBD5PrYhflb
         vNBvxFruFo6FFXqIwosnQvnfX1qDEaAUz/hhDEEMeBL4Rg4BU4bJPakVYCRagy3+gOja
         KlbmuuFy/s3SPxBnochT2Pl/LhRy/wbMkdeVRLO1xYL7SvU5BMbM8VB9v4mwjBEC/Dlo
         25ECviJ6b/hhB7zWNhAkwK3qrau1TA8kW8ftYP7cJR1SfIhBOxtA1L2YRbRfxkZuyPmU
         w/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXuE9GUODS/KgZK56nFTZ19HifV4tIpxTFqaVhSvEPFARvoqBTNEnndAL59s7ffYC0M7cjfk62eTQFS8ZADlXwZrEf3+OVtWtqKdm4/
X-Gm-Message-State: AOJu0YzF+gcEm8UX/q4ZH7A3PpOWkrDwvMIth2Uaxgwjw6/eXlmuIQWK
	JbTl4oBAuXUSf+hLpZSKaOImlmxM4AQLP76j8IzelSIASsP2Txm0
X-Google-Smtp-Source: AGHT+IGq3qvakJLFvMy/DvMMNihQC6H/6515cbo1GCxQVfsz6OfgcDvN7tjlyOh0OOdJ4/AU0mRa3A==
X-Received: by 2002:a17:903:2288:b0:1fb:8e00:e5e8 with SMTP id d9443c01a7336-2009521fa28mr4220105ad.10.1723076753251;
        Wed, 07 Aug 2024 17:25:53 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927efe8sm111866785ad.224.2024.08.07.17.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:25:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-6.12] sched_ext: Add cgroup support
Date: Wed,  7 Aug 2024 14:25:22 -1000
Message-ID: <20240808002550.731248-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is the cgroup integration part of the sched_ext v6 patchset:

  http://lkml.kernel.org/r/20240501151312.635565-1-tj@kernel.org

This patchset is on top of sched_ext/for-6.12 (2c390dda9e03 ("sched_ext:
Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()")) and
contains the following patches:

 0001-cgroup-Implement-cgroup_show_cftypes.patch
 0002-sched-Expose-css_tg.patch
 0003-sched-Enumerate-CPU-cgroup-file-types.patch
 0004-sched-Make-cpu_shares_read_u64-use-tg_weight.patch
 0005-sched-Introduce-CONFIG_GROUP_SCHED_WEIGHT.patch
 0006-sched_ext-Add-cgroup-support.patch
 0007-sched_ext-Add-a-cgroup-scheduler-which-uses-flattene.patch

 0001 implements cgroup_show_cftype() so that SCX schedulers can only show
 cgroup knobs that it implements.

 0002-0005 are sched core preparations. Should be pretty straightforward. No
 functional changes.

 0006 adds cgroup support to sched_ext.

 0007 implements an example scheduler which uses the cgroup support.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cgroup

diffstat follows. Thanks.

 include/linux/cgroup-defs.h                     |    8
 include/linux/cgroup.h                          |    1
 include/linux/sched/ext.h                       |    3
 init/Kconfig                                    |   10
 kernel/cgroup/cgroup.c                          |   97 ++++
 kernel/sched/core.c                             |  115 +++--
 kernel/sched/ext.c                              |  522 ++++++++++++++++++++++++-
 kernel/sched/ext.h                              |   20
 kernel/sched/sched.h                            |   35 +
 tools/sched_ext/Makefile                        |    2
 tools/sched_ext/README.md                       |   12
 tools/sched_ext/include/scx/common.bpf.h        |    1
 tools/sched_ext/scx_flatcg.bpf.c                |  949 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_flatcg.c                    |  233 +++++++++++
 tools/sched_ext/scx_flatcg.h                    |   51 ++
 tools/testing/selftests/sched_ext/maximal.bpf.c |   32 +
 16 files changed, 2035 insertions(+), 56 deletions(-)

--
tejun

