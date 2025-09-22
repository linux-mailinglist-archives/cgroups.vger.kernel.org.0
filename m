Return-Path: <cgroups+bounces-10329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D35B8FCCF
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C917F706
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADE2882B6;
	Mon, 22 Sep 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YvUCEHa8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518F28313F
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534114; cv=none; b=HOHPfGaS+Tck8nuKYJl8JkjRueejE8NKl4EjxmWThX91qkpTpe6puhOEaq3nfQXz5PAPKqp1UAH0H8QLjZmjFVL5D9w2ya4z45sW2QuxEFLOJJlEF3tjkmUjEPdSCiwX7bUV4Of9FwmJgFbDChADwF00JFwuOlvL3cT/8OVeMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534114; c=relaxed/simple;
	bh=12T+kg1WEnlpjNWioyO2nSnxhTXlq9cORsKc6oSrE8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0ObxESejDihsdIc8DxXE8haAoQtKcFN5gB3UXXgvo1mzGoPldMUSF4EA8UFtWKw2MgG6tcm6dh9W8Lb56buaIa9CwjCGFGJvk9fkqCNABZ+UI6cvOsDvUG1LmR6UTLxsjHGXSe4j9WnHuKosy2rPNN9o5um5jma5sdTbxWAOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YvUCEHa8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f454c57dbso261908b3a.2
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534112; x=1759138912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb1Ubbq8FQD3k+io1Te5PTmdOjRv6gyQY3TYHgxdom4=;
        b=YvUCEHa8HybVy9FglsCF0UZ6GrgLFKvLE24WKb6fQEeorKyHS/+Lamn7BJFWykgb1y
         70OLy2MACIV7QyI2l/3R/pvgpAJ6b5T1AXFYIPl3Usg/Re8m9lmtvQcBcX5E353Cr7pk
         bvsFSQRZ/wI7jBCmus07/BN0IuJzSb5EJ2vpwhTCGFYzsHT+b77xevFM7dOY1vQmJc/O
         Bj40Dtt2XwyybQoX9CSNI4MdRrvu7DlRNf9HFhGwPTglhaYrzajW0FqAmLXmmgxC8S3U
         HvQJcrb1bHcWd22DlsFy9ErqTrqhECM+zv8qMq2owfkE+1LT1Bm6rgn9qvUe2mLy2FZC
         ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534112; x=1759138912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb1Ubbq8FQD3k+io1Te5PTmdOjRv6gyQY3TYHgxdom4=;
        b=g8JDyo7DZzIrrcbwYyhTU+MzGWqKbsoyReB9r8VP92Ze4fzWqdbUezEZS9m4gtxdpF
         4XJ1BlP/hF1/DWkWgEBb07XMFqwyu8dW1mDiSw2BiCskkwa0623Dh1NAvsnt6bfOvwqq
         ZylBz5Jp06yPn1CDfKKgixiZskUuU4mWScGgor7ddNRA/p/1P/RLNpqOaaamKJ1Hqrc/
         PvOXSl9jG7RrWrK9LHNV4ZlAHjEahe0FxIos9VfAi05U6N9IB79C+DbiOwZw+U98dG8T
         gwtwMJIWIS85q5w8RxdK5RXXP+C5B2LUGRiQz6SzhNQ4ql5PiF+X27y9d1mSLXfIEblX
         SEZQ==
X-Gm-Message-State: AOJu0YxUtyM/MpQkmzPTRAB0AvBFu6WwpLKz77EA4BpkfPMHEZAafqRD
	/l4GEVnpz9wiJa2UZzDIz9l6LejdovDtuSt9guuDlnq1k9QSLGYsi6UQmKrGiZV4pG+thKJ4ofs
	tRL6M/m4=
X-Gm-Gg: ASbGncuOIgc2B6Hu5mQ6XOUrOY+eyh0GQRWQQv2sytgrR8eQrBsbAZVoNBeA3qmcl9H
	uScYxFq+Lzbv1675fyOVycGXdMHKCX3Z9QJrV/wBx5JQUTUk7DDOoK7RunRajeQoDWHHGb/e7vj
	pM9KdAZydiTKdhoyiKlFeRD1iHqH2TbOUNNhlMU1mSrwN8LujB2vh/CGGk+bWczt0kgyPFqSuJj
	sdt9wi4ovWto6AwnzB8Vav6Vb+NpPn5bmSfJ8MngZl0Rrei7TRaayT9ad0KoTLP1djkZZ6HgWAF
	yjb3uoM8EuTYTBEXQWoNYsFaZsIeEb/AgbVCqxXGMOd8JJP5/I0mDjDnYH120uHlaFXWTaR2H3P
	+Gsm8J2EPTI2Mk+AUnuh0yyybvQ1rGghU4ryJwQ==
X-Google-Smtp-Source: AGHT+IEtLgg4zeHMXHyciHj/+jOxGNRUrmic9Rw4+/nHq421LNnyymvdUyXFF6AF8uBt8EQUhHOCSA==
X-Received: by 2002:a05:6a20:728e:b0:262:e568:b92b with SMTP id adf61e73a8af0-2926f79d12amr19017914637.31.1758534111814;
        Mon, 22 Sep 2025 02:41:51 -0700 (PDT)
Received: from localhost ([106.38.226.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552882b177sm7455391a12.11.2025.09.22.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:41:51 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 0/3] Suppress undesirable hung task warnings.
Date: Mon, 22 Sep 2025 17:41:43 +0800
Message-Id: <20250922094146.708272-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrew Morton in [1], we need a general mechanism 
that allows the hung task detector to ignore unnecessary hung 
tasks. This patch set implements this functionality.

Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
ignores all tasks that have the PF_DONT_HUNG flag set.

Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
which enable the hung task detector to ignore hung tasks caused by these
wait events.

Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
teardown to eliminate the hung task warning.

Julian Sun (3):
  sched: Introduce a new flag PF_DONT_HUNG.
  writeback: Introduce wb_wait_for_completion_no_hung().
  memcg: Don't trigger hung task when memcg is releasing.

 fs/fs-writeback.c           | 15 +++++++++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/sched.h       | 12 +++++++++++-
 include/linux/wait.h        | 15 +++++++++++++++
 kernel/hung_task.c          |  6 ++++++
 mm/memcontrol.c             |  2 +-
 6 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.39.5


