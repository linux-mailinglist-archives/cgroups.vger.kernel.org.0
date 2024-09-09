Return-Path: <cgroups+bounces-4766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE1971F46
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8F1F23B99
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB1168488;
	Mon,  9 Sep 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ObFN8+UA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E810165EE8
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899549; cv=none; b=cYDZjdBvSdzJ/Lm4NLx9soNR84bNHB/AI61TMQ5RSPrx0acPB8ZADNmmUAPP8kH988EoCIP+1YdrqASX0UwiarNpR4QsvfZR8P33XuEuAArmOjg7lQUR+atpVMpbNQoSbNKmC5w30TQPvHRklDPFZg3u2+1vTdKe3DrUY+T0Npg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899549; c=relaxed/simple;
	bh=2dl50MWEQzC24F83Se6WYTJB2+6Ho7Nrx7KziWZ9PfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdjlhcir/nI4p4ts5WKyu6yjfMIKkJ7MpeHRyDWdhqJKW/3oSztY6uFzKax2qJt7ClcNbuJC3Mj9+lhtrSdhkYIOPYDgLK9yxr+M/jiHjIVkTmCuLoaCzNN34gxoaXVogQ7XD+fBuVVp3ZL598tO3eCV6jGGL290Vklvbbka7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ObFN8+UA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso8001055e9.0
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899545; x=1726504345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01TvFQ8Q33lZ5OEXLtjKixrpDvHdGUhYpWD+3boosg0=;
        b=ObFN8+UA/cOYbahX9w7VMKtcrUNj8MwbCEcOEDk975Zos4MI9CdAlrZ0Qs3+xAYaLj
         ElaWQ20WbCstXDFQqD4wcsxypjNF6RT8/yg53YllAXpYv1xo+PDxnneUwNfGYAJ8qHOJ
         uAfRMr/eaFMQBE15b2yST3DAI5IZM4Y1z9NKTsj1ePqeaM8Iq+x8wYrNo2c+wjZ0GhZH
         0ZigccmrPL59vl6FgUbvMmomHFNbfcAZbhLf93LRRMvvSTGCc1pVjyeQxcezg677/fyz
         aXb9qgOqHdA+AzkIePO4liMP96LF8NWSKNXlx6o/Hs5CR7oz5mUrDWXx9AJe2T2YAOm+
         0X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899545; x=1726504345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01TvFQ8Q33lZ5OEXLtjKixrpDvHdGUhYpWD+3boosg0=;
        b=CQy4zmJ4VPGbWMNpuHBBfRxRscWh92JejZuXmHNvoashfTLDWKdZJG8oEXNgjLzk3h
         ZJw/6BhKKZMgxsy0GOYlJKfa/MYWnMm5IaB0w+FAgW507AqqIGE4j2vkaus7aFSHX387
         YOMoFHrfidsTxuvB9pJD4ZQBh6/BE4Pazz1GQIk7i/R4srfx+o3kIMTyfEOmM4U1Va6p
         FSNDN/KUUgHQxHPTlzgHsCaJiASj0XKrFiaxfSYnSEnAMaJjT3BjXfJZUK5wekjge2KA
         BQFDwihvfQZTeFGFkSgCsnp0Cnhr2QxRzEjucN45Bbm7i8yiLBGv9xYW30GiDHcryCMj
         oxUQ==
X-Gm-Message-State: AOJu0Ywo/ACsfSo65bX7154GpIcOruadGBiOBxqF3VeYRdiKJ5TPQLc5
	9DOp+3bPJT8/jL3KnmsYZ72XQWZa4xrD8uvlSFk2h29qYCy/q7JHlyH0t2kuQQz3qExn9OcGsRN
	7
X-Google-Smtp-Source: AGHT+IEoB20U25poJ8OoF6N2TSMoqHcMm3X67rhrGHHhO2tZ7wzs4+DbWWaBCovC49KP4Vwd5vxErg==
X-Received: by 2002:a5d:4ec9:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-378a89e6350mr137262f8f.3.1725899545364;
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 0/4] Followups to controllers' v1 compilation
Date: Mon,  9 Sep 2024 18:32:19 +0200
Message-ID: <20240909163223.3693529-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The group of patches builds upon recent dissection of memory and cpuset
controller v1 code to under a separate configuration option. The goal of
them patches is to produce behavior that appears to v1 controlelr users
same like if the controller wasn't compiled at all (and no change to v2
users).
Plus there are two preceding patches with cleanups I came across when
looking at the new code.

Michal Koutný (4):
  memcg: Cleanup with !CONFIG_MEMCG_V1
  cgroup/cpuset: Expose cpuset filesystem with cpuset v1 only
  cgroup: Disallow mounting v1 hierarchies without controller
    implementation
  cgroup: Do not report unavailable v1 controllers in /proc/cgroups

 kernel/cgroup/cgroup-v1.c | 17 ++++++++++++++---
 kernel/cgroup/cgroup.c    |  4 ++--
 mm/memcontrol-v1.h        |  2 --
 3 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 8c7e22fc917a0d76794ebf3fcd81f9d91cee4f5d
-- 
2.46.0


