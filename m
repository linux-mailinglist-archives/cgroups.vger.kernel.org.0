Return-Path: <cgroups+bounces-6969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F6A5C184
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D62F1884FAA
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DD25B66E;
	Tue, 11 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsLYiDJZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4425A2DA
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696628; cv=none; b=j7ksMlQ1pfCkfaflphZD97VYLW9HzhdVd+dtHBdSKw/utT/LtlUsO8vo5If4CISNP+/KQfBtKlnbjFLCpZ1CPQuiWrvCum0ogFsihBvj3Ts84G7fHsKF5dCmi1HE2yaOr31HsftDWs0qsFumVUoHbTFwxL+o1ERfEUXLocV049w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696628; c=relaxed/simple;
	bh=zNk+oVMzTrxJrAV3YPS/mCKpQLRaGo/5NfuNYVLO0DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5zEZg1kN+qt+dyjl8cKCKS91NTpJnj17CISIgsFEIG0E3MSt0BNn3bO9pcQZycev13TCb0MLDsOlzzqYa22NBPeTCZykNZskZuwXC56G26K3i6fsHdksha01iXUyQrLTjGRfFQ9TqzMAI7BOro8Uwpl7l1eVoayy/pt/jejkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsLYiDJZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d45a148so2068499f8f.3
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696624; x=1742301424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOohSrQvPqKoJS058lh6ERBfYfFVZu79WxTYWxna9iQ=;
        b=NsLYiDJZXlp7X/saeDGXIS/Eaf+BKJNGesltZPBd8n7nt3ewjAG1USbmbfviciduEl
         sKGNWnhT1w4L1QLII2a2/uDNltVybXrv5eki9+Y4wEEAsqX0oyOgIJZcL8A6mmydItE2
         9UzKt3FhDdPAJUvm2sdwVV/ehIcVTRHtYe/MGvsT1qYtivvYqkXCsNnE95qUt1P1uVjW
         IO8+aTFlGyAJdW6n/SjUE5wOzTHxZUrUfHoRsyrNzuJVaVkm3GtJ4XDh04/VhzlwgpYR
         oA5LIMjNm0Jpat1DUiLsFg/bjQZQrPd0ddW9KQDbxc5bRDE3rfyCEf0n/2JX3yMhaZnf
         7yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696624; x=1742301424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOohSrQvPqKoJS058lh6ERBfYfFVZu79WxTYWxna9iQ=;
        b=ETxVULutRH5KTspLXpjMWyoczsEFfG+Tp5XMw6wl6ONkJsihFcicQUBJ2T/hle8sH4
         GkL9Cd+B11+k1+KbAk9R8MX2AM15KrX0B16pfFDs0Jsz149NF0lhObOp9Xklj+ODWvTS
         UXrw313qSIDDraVDkuSWOHI99tyFjVYXg9kvia60uZju2S6wi/dD/FH2hGssQ/GLlrt2
         7mE9/QAtSpSQP7J9WVe4v7O57D9xSi3oDe+e2ItjG5ulU8Ghv2zyS8NvS+SnJseLP8Ob
         QFYTA3P5G1+Fqb3GDv1v2O92F3Cz/0oUK6XWkz1r/H699v+EfVxL9wXxCb6TD0y2RL6P
         uA6A==
X-Gm-Message-State: AOJu0YxmIG39LohG0DzIgxhVTwylNOubT0S2LF1KSbhLSdfyG4OgqzDQ
	963ZK0KeAxA7ld6Ebfp+h3kttwIzF/2Mdu6A27DN6iTrJy0/NcsUXOVgGrBRVnFd3Vo5nzpk+qQ
	tHIk=
X-Gm-Gg: ASbGncuzfgT38CReO9XDzlXUbvSggxnXwgLaMOr0ncvURmi3r1aGxut2kDGuPpxigQU
	mTreZEhud32jYZd0BryFic9OAlJVdR/xzceTEYXaDJ0NTaFBJLwfnEPU72DZycR6IvZyXQbh8Qw
	vQwdK2r2hMJvfeBKqDfOGrxJsLj8DSGKzqJAgrkVQq3hDQ7XUd6NVLDWGgxg779yzfZG7AAVxm2
	89HP0faTcS2Z+gpJvMfXqPr+8uiBcsbxE76HUlMEDbiDW/oHdAleu6HouNVkbEjAecCQoYOhsYF
	qu6efcyMM6ktAr5SxUcjgV4nq2KZMOTj9Mej8wbgC/QVrZBBWm+o+og58Q==
X-Google-Smtp-Source: AGHT+IHTfCuQAPhrYhY9GiB9gvVm9rN3p4h2znVxLV21KfH9P21dIalFWV0Oc3AwmyqXz7qhPMYuCg==
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id ffacd0b85a97d-39132d8c768mr12227318f8f.32.1741696624554;
        Tue, 11 Mar 2025 05:37:04 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:04 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/11] cgroup: Add deprecation message to legacy freezer controller
Date: Tue, 11 Mar 2025 13:36:26 +0100
Message-ID: <20250311123640.530377-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As explained in the commit 76f969e8948d8 ("cgroup: cgroup v2 freezer"),
the original freezer is imperfect, some users may unwittingly rely on it
when there exists the alternative of v2. Print a message when it happens
and explain that in the docs.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst | 4 ++++
 kernel/cgroup/legacy_freezer.c                            | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
index 582d3427de3f8..a964aff373b19 100644
--- a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
+++ b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
@@ -125,3 +125,7 @@ to unfreeze all tasks in the container::
 
 This is the basic mechanism which should do the right thing for user space task
 in a simple scenario.
+
+This freezer implementation is affected by shortcomings (see commit
+76f969e8948d8 ("cgroup: cgroup v2 freezer")) and cgroup v2 freezer is
+recommended.
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 074653f964c1d..039d1eb2f215b 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -430,9 +430,11 @@ static ssize_t freezer_write(struct kernfs_open_file *of,
 
 	if (strcmp(buf, freezer_state_strs(0)) == 0)
 		freeze = false;
-	else if (strcmp(buf, freezer_state_strs(CGROUP_FROZEN)) == 0)
+	else if (strcmp(buf, freezer_state_strs(CGROUP_FROZEN)) == 0) {
+		pr_info_once("Freezing with imperfect legacy cgroup freezer. "
+			     "See cgroup.freeze of cgroup v2\n");
 		freeze = true;
-	else
+	} else
 		return -EINVAL;
 
 	freezer_change_state(css_freezer(of_css(of)), freeze);
-- 
2.48.1


