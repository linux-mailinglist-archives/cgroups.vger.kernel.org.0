Return-Path: <cgroups+bounces-863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15709806F2E
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 12:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C366E281BED
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CA734CFD;
	Wed,  6 Dec 2023 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InChu4AC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79319BB;
	Wed,  6 Dec 2023 03:53:37 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so3900460fac.2;
        Wed, 06 Dec 2023 03:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863616; x=1702468416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDL4XnMPNRTgrDbtDUM+rO2flIW2ypF9QXqxL+83BYI=;
        b=InChu4AClZ336wluMZXoPF1gxUrkaBDsQsWn8lUuQ3VweHoAWJ7dtLoLTlg0lWcRi9
         Qnn+ZKmpQg4SrDDbA0CaThkMHVJauCTD+6FbpskFUxif+4mwvyIEorqK9XbG/o07xAYH
         sfrhDAIzrKNuJ1WOayq8vKRyOB7Zy8k9W7v5ZRTGHrTyEbgo+Ln+w33KgST84OhDATNI
         oEALSPIgpTH5St5ycejqjALIo39BOWvtVJG7nk/FZTWtHN7FIgjG7585vMAkoCzN0pe7
         YVxq5MxoVQ/YnUHI+rVZ9+vh19CMlIkE7diiy2OJUz/aKhNSVUmmdwnJ3h1PyeYV4kRV
         od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863616; x=1702468416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDL4XnMPNRTgrDbtDUM+rO2flIW2ypF9QXqxL+83BYI=;
        b=LlsPSOXVAZIl58a2HffNq5PWa297ezVeL/JJSmy2W9kTji7XVJhjMOmlGxwbhAIZoU
         3TJ0WSVsIgTR/sO4bUMtHRBx9ncqSp3nB89O6JO9eTkBcKsx9odexMSfRiPLtww4tEaG
         4NLbeVQTLpyfqI6cmZJsBjbAkb0FOlWq0f61W9G5ZOTO8pCjSXbgi5UmPoUqrSivxCdu
         OuhBFPjT6bXsbjYUxZGay50WpqWAzILYVPaQ07JyL4B26LG1rxfTuCebOKQNP3WSYXzF
         UZ9BPdhwr+nytLo4OGqy/V+k4O2iz6X28y9YcE5/qJg92qp5wMGzwQ1WRKUTMzolb8g5
         LwSw==
X-Gm-Message-State: AOJu0Yz9k+JWIx+YNYUihug1ujJb8YUpzA388n5pFNUP81pTPsO1meAY
	cd7XrGJaM58MuRTr6TifRQ0=
X-Google-Smtp-Source: AGHT+IFaSJ9DuKk7FlvXoE9upKIPEnCxrTxnwdtWRsQPPCeZoOHNkst/D6oOvcxuoNPxe7HukyCv0w==
X-Received: by 2002:a05:6870:a3d4:b0:1fa:261f:5336 with SMTP id h20-20020a056870a3d400b001fa261f5336mr810929oak.10.1701863616418;
        Wed, 06 Dec 2023 03:53:36 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5484665pgd.28.2023.12.06.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:35 -0800 (PST)
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
Subject: [PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support cgroup1 non-attach case
Date: Wed,  6 Dec 2023 11:53:23 +0000
Message-Id: <20231206115326.4295-1-laoar.shao@gmail.com>
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

Changes:
- RFC -> v1:
  - Collect acked-by
  - Avoid unnecessary is_cgroup1 check (Yonghong)
  - Keep the code patterns consistent (Yonghong)

Yafang Shao (3):
  bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
  selftests/bpf: Add a new cgroup helper open_classid()
  selftests/bpf: Add selftests for cgroup1 local storage

 kernel/bpf/bpf_cgrp_storage.c                      |  6 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       | 16 ++++
 tools/testing/selftests/bpf/cgroup_helpers.h       |  1 +
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  | 98 +++++++++++++++++++++-
 .../selftests/bpf/progs/cgrp_ls_recursion.c        | 84 +++++++++++++++----
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        | 61 ++++++++++++--
 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c | 82 +++++++++++++-----
 7 files changed, 298 insertions(+), 50 deletions(-)

-- 
1.8.3.1


