Return-Path: <cgroups+bounces-809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592BD805775
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895851C21053
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143E59E32;
	Tue,  5 Dec 2023 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqjOdgX+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930941B2;
	Tue,  5 Dec 2023 06:37:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so1254618a12.0;
        Tue, 05 Dec 2023 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787056; x=1702391856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5h/SbuONP4wuPNwT27Ivx9IPZWnlYKk8b9xx0pCx94=;
        b=HqjOdgX+UawD2cLcIr+Agwt3R0cV4PCQ/Jrz3Te+NP07c3LGnKKhBKhGK0wFJVKQ66
         ed8KeFbW/pnh85ZX/C4iDzrbTQEwy95siEVvwWv61A0HwjCJXiim/O3F2aQQ2ixSzOa4
         PY8xLGa7wUsX//QlcJXhmyKCFtHrzoPhrMvb0RqwReqTXVpltblLbeWM1WjetSqbnhlg
         x6BOJKT658Q9d9ZxcpyketTcYoNJMsYE4LMkO0jTDXjOR7fGi2unnaWf+XO3iVx6YJNu
         Jj/q1m0GU7wAgcOxrBCefQ2Qy5xwQIrzJQWjMFCXxxxNJjKAi5SYd+40OuTHD2J9N0HJ
         fUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787056; x=1702391856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5h/SbuONP4wuPNwT27Ivx9IPZWnlYKk8b9xx0pCx94=;
        b=TZKFrasa7kfQ3mY84r2e85NlFuL4Ay1p4uSAdUB1XcayaQPb4m5XKsFfakUM3HfHHq
         5eLos5vPxhbgj+q7deHqtzjUtexnnUZ6UVRiL6wbtc8OKD2fkOqlMJ95lvKaSvqr8axW
         yoa4kuf87dppD95dB3E0T3qyewCEu+HF533KypoJyJ7f5U5AI9WMAkivbRtCU00p0PYh
         lM9gydklz4bNjmTa7+US4pqYcJDhQJvQTdC02dDvnNYAHb+/Vxez/3u8QaAPg668ghSk
         ZilfBFuzGLadIm2dbwc5crL8cHJJr4AdsQjFUwgKL+4GS7VulVd72mCx0k0s+mXCO+Xb
         ITNA==
X-Gm-Message-State: AOJu0YxaWFjpIi7k/rd8CUYkKfKw6GQtV1vbVEAlA+R7bSKLCd/nEEnx
	ztfm1WugWlrh32dNmJuOUfA=
X-Google-Smtp-Source: AGHT+IEBhvtfry3nDq6e2KJgymolBNDGUAKDmFRILeSMjKJjyJZluXTuAzOOUh6UyBL8gQ9GTdfcDA==
X-Received: by 2002:a17:90b:1a86:b0:286:a454:6b44 with SMTP id ng6-20020a17090b1a8600b00286a4546b44mr1170570pjb.27.1701787055880;
        Tue, 05 Dec 2023 06:37:35 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001a9b29b6759sm10286502plt.183.2023.12.05.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:37:35 -0800 (PST)
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
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support cgroup1 non-attach case 
Date: Tue,  5 Dec 2023 14:37:22 +0000
Message-Id: <20231205143725.4224-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current cgroup1 environment, associating operations between a cgroup
and applications in a BPF program requires storing a mapping of cgroup_id
to application either in a hash map or maintaining it in userspace.
However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible to
conveniently store application-specific information in cgroup-local storage
and utilize it within BPF programs. Furthermore, enabling this feature for
cgroup1 involves minor modifications for the non-attach case, streamlining
the process.

However, when it comes to enabling this functionality for the cgroup1
attach case, it presents challenges. Therefore, the decision is to focus on
enabling it solely for the cgroup1 non-attach case at present. If
attempting to attach to a cgroup1 fd, the operation will simply fail with
the error code -EBADF.

Yafang Shao (3):
  bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
  selftests/bpf: Add a new cgroup helper open_classid()
  selftests/bpf: Add selftests for cgroup1 local storage

 kernel/bpf/bpf_cgrp_storage.c                      |  6 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       | 16 ++++
 tools/testing/selftests/bpf/cgroup_helpers.h       |  1 +
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  | 92 +++++++++++++++++++++-
 .../selftests/bpf/progs/cgrp_ls_recursion.c        | 84 ++++++++++++++++----
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        | 67 ++++++++++++++--
 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c | 82 +++++++++++++------
 7 files changed, 298 insertions(+), 50 deletions(-)

-- 
1.8.3.1


