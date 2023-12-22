Return-Path: <cgroups+bounces-999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0981C923
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2221C2859CB
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F661171B6;
	Fri, 22 Dec 2023 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2DorK30"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF8168B6;
	Fri, 22 Dec 2023 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so1061435b3a.2;
        Fri, 22 Dec 2023 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244685; x=1703849485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ5p6copPkHpf57S6j1DWHnc40HA5s5ja2uE8OM/MkU=;
        b=N2DorK30OGBAOTiR92htCxEmirL+5YeDAes/ZCs09utTgdHAKnDjZmv+vAvkyngFiF
         v15i2F8VlIAnBv8sCbhVOFq4L/FlGg2ULrb28IHEoCkVf0/9OwfUBx9zXmJWeQDBS6WY
         GfOhmfUlWcGbp8dQ5XMoKXwvAsxT9IlhyewJc3ToE+58gBogOhWxRMbRI47+Eix8R6vI
         P3Vu2EuUuqW3Y9c5IPFgRq+u0ctmxAwRoQWrJbsG2zr8xK49JPSQkGclRH0PwNzS62Xm
         uuKOzntq+to1KapjJoPCPxTCNBiVt2Rel36EhfaAGWspI1ueWx2DIirVer4k5SVobfSq
         nA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244685; x=1703849485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ5p6copPkHpf57S6j1DWHnc40HA5s5ja2uE8OM/MkU=;
        b=rEj6Q2P4wEiRr6uI4LUSNIEIzW9lpkOtxsybWBFJD4deIJvUNTRjrupPLejkcsvOcr
         el8Rzhrz8WJKu/O9bCVF+itd/KtS2eyNns3segAWWTWU6ZC03ZYD4aZpuSvaTOQnBh3H
         wnVUZY07AipZG1b2GvaBCjH5IzkXm0bjie590/WUhZvCCjyHumTTNVPnzAeNTvyBMR7L
         bMgWQg7+zLDXeaGrm5gQSZNjeQW5JCZXs2rUUL6OqNYAhPDVmAaJKvtZj4Ycg99Ctqb8
         4Rm0ARhRn3f1wmdSGqei+ur9HhqDRqhluF570rC++p/uqkMUFFYubvdVMRdotpUcHIRZ
         W2Gw==
X-Gm-Message-State: AOJu0YxRGoRkL9XoAEoiQmEF5QIm3Rs3Qd+kffxadbfYqMniUI4esb+k
	CQ8tDbObln9HVnEQtYdwGuQ=
X-Google-Smtp-Source: AGHT+IGBmahAdWW0Y36UPK6OE+VYKOoHkFIROJXf09qCeuyOo2UJow8Onzdcrx06aBKMndMxYGCMag==
X-Received: by 2002:a05:6a20:9144:b0:194:aced:f16e with SMTP id x4-20020a056a20914400b00194acedf16emr812968pzc.1.1703244685472;
        Fri, 22 Dec 2023 03:31:25 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm3232881pls.196.2023.12.22.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:25 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/4] bpf: Add bpf_iter_cpumask 
Date: Fri, 22 Dec 2023 11:30:58 +0000
Message-Id: <20231222113102.4148-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_cpumask_{new,next,destroy}, have been
added for the new bpf_iter_cpumask functionality. These kfuncs enable the
iteration of percpu data, such as runqueues, psi_group_cpu, and more.

Additionally, a new kfunc, bpf_cpumask_set_from_pid, has been introduced to
specify the cpumask for iteration. This function retrieves the cpumask from
a specific task, facilitating the iteration of percpu data associated with
these CPUs.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to the test cases in patch #4 for further context and examples.

Moreover, this patchset incorporates a change in the cgroup subsystem,
ensuring consistent access to PSI for all cgroups via the struct cgroup.

Changes:
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/ml/bpf/20230801142912.55078-1-laoar.shao@gmail.com/

Yafang Shao (4):
  cgroup, psi: Init PSI of root cgroup to psi_system
  bpf: Add bpf_iter_cpumask kfuncs
  bpf: Add new kfunc bpf_cpumask_set_from_pid
  selftests/bpf: Add selftests for cpumask iter

 include/linux/psi.h                                |   2 +-
 kernel/bpf/cpumask.c                               |  65 ++++++++++
 kernel/cgroup/cgroup.c                             |   5 +-
 .../selftests/bpf/prog_tests/cpumask_iter.c        | 132 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/cpumask_common.h |   4 +
 .../selftests/bpf/progs/test_cpumask_iter.c        |  50 ++++++++
 6 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

-- 
1.8.3.1


