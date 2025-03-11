Return-Path: <cgroups+bounces-6967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF93A5C167
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928073AA6A7
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736FB259C91;
	Tue, 11 Mar 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QRcCTAvk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17F258CC0
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696624; cv=none; b=Jr7TIV+eLL4JdVZesjzwtUNlMC0EvfCV4orJAS5hQdwlaimKUf8Wt3x0FriOlGn5PDIaAysABeOCetiwdoulaSwxRwxZWh8QZT2GfZS3146JJQP3+RlwP6A/AvBIKwUfytKLRk2CvILk9FYH7JnaQcEf6rv8eCeeiMyQkY+2u8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696624; c=relaxed/simple;
	bh=oQiH4s8dqqTPoXcsDEfEFf/h97UEWukoBg/fCNG79Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5Pxuy2c2Iuu/DenhPYCryckmZ8qDuEKgAEzj9EqxExkt5sb5PAGVNGhx34JY4pVuNHHMmS6QRNgRYC60HnzoNQ2Mp3/cxKwO2wQtRt7Q1cxHeR+oSfTvErd8EWhMPMyxk63RzOEXhe0DO78yQJgPcfpmj/elAjkefn3ovEmzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QRcCTAvk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39133f709f5so2074903f8f.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696621; x=1742301421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GirCFLl9Oa6UIyXIEajMTJx+vDKWVC1CpZz6XyjeJlQ=;
        b=QRcCTAvknEW63Tj34PTe4vXec5ix8J4yYreLHVrRcvXvOdiiaPxsC63gN2QNezvrC1
         e1f3vB/LuBaioCCwOEfR5wmio36G05wB49Y48ME7JyRdr66rRxSMcbLkNXK6UDp7VCxK
         J0st3bmPuafksihLjIwA+4aPVPUI5SyeGR9tiPjhK+CDYkudxaQHxz1KzeyHxdiK9pM8
         Ho8NlQDIlzENTsevsWkYYh5b33juFJc6MOdcD43g0KAc9krnN0JGp4+PGyOtd8WFK3NZ
         oK5PXUHsQLrGxjvM1DTqsO1NV+5fZ/QLVp2BlfvmSxlm1xy0dAoPbxotiLFHQq90kZ65
         kf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696621; x=1742301421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GirCFLl9Oa6UIyXIEajMTJx+vDKWVC1CpZz6XyjeJlQ=;
        b=I6UD881YY+pivWfx3ztgtQ/WvYKUMIYHyRrlV22HH/3w5LHHtsHUTN0VNzHYwvWN+n
         J4qG0fXqWaoCoDR35uNDAHi9oSXoD1P3uej8n4WJYV8dvVaZwqychdrTeYA6/aqMOdsS
         bMvFCxppF2ByxZhlUaz5THdU/JA4qHCVuyOB2e2INPgGkKJNxJ6Gg07aprYXxryK60in
         XfvO80M0jAmi8S9GEZylGZz5/378Qz96xvqYp3uac5fOufG3Hi7BjZH80l+92FtKnDi3
         kptePviUCEmiQBQMWUVSaI5zeiOeDQU5Bx1r7U0z9JEH7CtcH04WrnyE/JvPvR90j5rR
         ymAg==
X-Gm-Message-State: AOJu0Yw2pfeOc7I50PMUk9DSJiBqbStPyDTn+U2RKeWYxCKMFrsHOpgi
	noaafmGs4iX+OImlNkCMoByyLk/cBaJv6ljAFRa6Tp5g70Djt9GRh0F1CwUPmwmL2b+d3QuFdOI
	ce1o=
X-Gm-Gg: ASbGnctWKZ3nNMRRNzLTxM39ZpsSpCl5weWJOMfflzVrUQrKFkMpkcQmwwkyd2SXE7c
	dVOtyYWcRRQdppPrY9VuSvIWlOBtjQ8HX8sli/TXA0dUIfDy1ANbvjiJLvAgoregcplKyt7Hq8G
	vlr47MlRqh/Qdha/i4BLhwBCD1TzP1UUNK+h++pD0pxzYVQcsKIfXRzZAGy97Bhb/F3eVYM8G2I
	6KlSN3wuL9/Q9cJhRy6jlQDdo480LKjMBGATHQL0xqN8jc1h5/N9ZIpeuregHIsWwKqAhz7dHOo
	jNpVQyjn8bVqSTFkDClAP45vMtKcM+jcCUTqmT8yQwluv84=
X-Google-Smtp-Source: AGHT+IGScXuGUkBhL1X5gow1DaCbY9oCi5EpTUsqoNyHI3geIvP1EWLbpeg2VkBmjZnU7T6RnLfrpw==
X-Received: by 2002:a5d:47cd:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-39132d16d9fmr13476647f8f.3.1741696620818;
        Tue, 11 Mar 2025 05:37:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:00 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 06/11] cgroup/cpuset-v1: Add deprecation messages to memory_migrate
Date: Tue, 11 Mar 2025 13:36:23 +0100
Message-ID: <20250311123640.530377-7-mkoutny@suse.com>
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

Memory migration (between cgroups) was given up in v2 due to performance
reasons of its implementation. Migration between NUMA nodes within one
memcg may still make sense to modify affinity at runtime though.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b243bdd952d78..7c37fabcf0ba8 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
-- 
2.48.1


