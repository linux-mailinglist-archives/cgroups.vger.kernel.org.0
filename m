Return-Path: <cgroups+bounces-6971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC48A5C174
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BCE3A8D4C
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416825BAA8;
	Tue, 11 Mar 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkycBGfH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83625A624
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696630; cv=none; b=Ywqq7t8nXOW8HPMtSlKRpAMpJh69bKTWBIxLXUORVKfgshZYsRMlFg85boo/6FS/G6m7X8pbSBTpkCnV0dEJnwJ2QqYx/i7tAOVSRW0IbhrN43250HVmg2hWQKXDkd8FlAARj8/e4BPbIZkJ5Yt6yNOtlomYcu5TvLi8AZ5aA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696630; c=relaxed/simple;
	bh=H9SzSxgPt+9gHiJ2NrDb4AnmWvevwAa4/H9YK0jc134=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOs1zHTDjYHPvW9DsSJfb4N/FrIjtmJ5ldHVX1gVoinE5lX1Ogo169u6dpFp1Qufz4ZxN9ZfYO2R6AKwWg1V4bp6wRaUGAxo8cGDTk2bfhibmMBYvJMBI4SYNFTjFW5zlTM3vt2kdNuiCYgB30vudXvF1AYasVsoBnt3KK+DuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkycBGfH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so10961475e9.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696626; x=1742301426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg2GfKNIBA0xBc9t5SMBYlXXu+7/ZD43VLJh0o8WZ/4=;
        b=EkycBGfH1Q7dgMH5Ky2wMxRih9ADLtEI3vRC9GxRro1BghsZVAwOS/pnrAdpoVAV6c
         0lgYXd52YOjfiWbJJuNYPvpK27h82lpyhBPzm0GSCU4OuWfrcDtByaVkmJ5SyUqB4yg8
         gWv9nuCbi6J4gAJ+P8CesyUaMcuvn9PWrMGCKvqSn1UCk6WUsxCw/BxPCaWCZ/6yUJHa
         5HzHoR4qzNfYjA3xGWAGrdcfuE0dZEv5Fi8NvsQbAAjWIyICsyvLlvYpMa2J8dn6+v7I
         ISrCeEqUb6+4/MstXQhtTEvhVKAz9dH7+pv45Msz9R7DKdmck7PdAeMc0nMyd/2omE62
         otHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696626; x=1742301426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg2GfKNIBA0xBc9t5SMBYlXXu+7/ZD43VLJh0o8WZ/4=;
        b=CHlPLkqNbe8gp/P0W9DoUKhMCcFNoACuM5TWWV+KvJMwWLdwATSrpaJ/cDxfddmlLr
         Bm5friXYpZGu6SOgnfYPYFhEM8ndyMhHyOx52rbOul0n0sZxASJqlbcizptDn3+dVuBc
         0QmnONU8K3YPE8npgMMdx8DWiJve2G5XDH5yR+rRqVFgtEOOHjWXdxgIixO5P9ACDMS7
         vegmQ2/0FgJAh4kebWmDYMQ+Pl+jEJ6wAPKFGHSoI8Kswbk4bk/kvvmWunW6A2uJIE0h
         8Yb3qG6mLU9nyHRU32ML1ocsO0BhXWJwoX8HSEi35k1kmBw7YB8i0gdBVTZRTJPRmmvK
         lktQ==
X-Gm-Message-State: AOJu0YyspQ3vZgvplV6u648YJLI6AoZnq+2Sn9qUrXW6cn8S7DWLo5Da
	AwZeK0tPLmM4DkefW6cvNMt9sUhNQ/ZYuK7yAlrA4MoHxs7KuZEfC72Eq25kZwMGVaE9srPfjQj
	jRQE=
X-Gm-Gg: ASbGncu8XNI2+IvKUrKf7XuAgV3sfIi6GxlhcCoqirCaxij8bXa2XOEDG/4JSfTu6La
	vVYjLoNz9irG5Xk3yzpQDqYI5blIjKmu5+68s264gqyo/UQAaAvWQ1lo3nItSCkbCpAOTl0xyjP
	KamtsG7TwQHXNDvnPA/HdWlyRisqcC0BMZCJZtPsoZcBZSSFHWwNRuJnNDi1UyaFTQk3xwT+ofV
	95CDFvhWTzt6gIkOjy8WE97y1AzNHMmDBh0Sv5SLICpID9elK2YL8MnSRHE605Hde8xoWw/8BOV
	cCQGEB5APINpUnXY3JliOCxKW6IRXIsoZF6RkBrdxuUfmnE=
X-Google-Smtp-Source: AGHT+IFEs+y18tASfJQzBfnAofD11tP4m/kDNfpZXGz4WBh7pK/QCx+Nx6gHTTMr15yKyEisGcj1Ng==
X-Received: by 2002:a05:600c:474c:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-43d02092256mr45422675e9.30.1741696625747;
        Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:05 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 10/11] cgroup: Update file naming comment
Date: Tue, 11 Mar 2025 13:36:27 +0100
Message-ID: <20250311123640.530377-11-mkoutny@suse.com>
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

This changed long time ago in commit 8d7e6fb0a1db9 ("cgroup: update
cgroup name handling").

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17960a1e858db..485b651869d9b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -619,9 +619,8 @@ struct cgroup_root {
  */
 struct cftype {
 	/*
-	 * By convention, the name should begin with the name of the
-	 * subsystem, followed by a period.  Zero length string indicates
-	 * end of cftype array.
+	 * Name of the subsystem is prepended in cgroup_file_name().
+	 * Zero length string indicates end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
 	unsigned long private;
-- 
2.48.1


