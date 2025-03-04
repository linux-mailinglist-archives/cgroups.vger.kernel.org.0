Return-Path: <cgroups+bounces-6820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CBA4E533
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B970B8A304C
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E528FFED;
	Tue,  4 Mar 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsTqcrWL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925228FFC0
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102741; cv=none; b=ZjUqsBFd3e0pqX0JjcEq8R0xjYYP50L2C0ttCi9Fh7+2UisMZCg1k2Ftkt62lpSmxMXOLbSen+B1HW0D3t8fVpeuwLAO1c1AFU1/C0vrndu2Q5Nb2K3dvhLT0946ZEE9id2wteOxD6XH1DIiKirSBxrZsyGHt5OVXBT8BXEAuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102741; c=relaxed/simple;
	bh=MdgvuPV/x8WhlRRCw7Trx9k9ojx5GfL3R2IFVSBLDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpCVLXhOREfGdNEtZuppCRwKmMizs6QRnGEn1CXVfEELo8jidKz9cuTyGCTh9f/DCxL0ejIH9OI4nrci+Cheuy3Df4gK+Qy34i/cXm1JFnkrwVmtyh4N3jLlTETxh1NEKdRDTlijE4OMO6xh1LFcR4CEOHmRiPfeNxdKYNQER7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsTqcrWL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so39904665e9.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102738; x=1741707538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=VsTqcrWLiRztdJqD+hckVkKPe1yjJ76YHIAWTRnEf737KnahCd6bqo1dAMJhSD/VSq
         4DqQnPNAKhRzX3Aiuw2/i0mBSgSDxhHYlcFJE1hAEabP7ANQgTGDT0PO1kYBuR48XpPR
         AS77lJoAKkkEL4LWLzf5vY9QXoEGyrZrV9bTL2apQMJJZN1DjVsNg2IW1h2XvQ4Jz8IS
         uUQMzvihGsce8JQ79fkjhCOLS4Sivt0c82bu8seSHuRQI6SqLzXJbnuf+iHkWSwa0kyJ
         RHuOVB+bgpMcJqNyaPTYocI+uPnPQ/trxh2ggCGW8iwzNejTjizmJuIi0Z/9Z8iPtyow
         hZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102738; x=1741707538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=bFaxDJjZoI4cfyk3x6Z1JxDfwmDRqWah3hRKuy9dZbMQrFpNzUrJ+DB+AgVPuynmed
         fcI9ue/oVFw6OqCvV9NC70ugir75jr3wfYRCsFvl7Jm/4z94N4jL43QXw4URnoKMRTsK
         2bYHbaUrD52a/xU0TO5LXJgoIxh7MSDVUNrmslYsfY1jaGIMHYpF/KuIUkQxrC/+zIQc
         GHkrKRO1IoYGwu5++xnjigK4C1nQoo5IZKiTUxUWEHUbSc9rh2sS2TuJpWWt9hBLrVHF
         BEYdi0QqDcCtS4OyjuJ+Bu/OEt/jMhhRZwh/+QBKi4UZSnkT28vhfYaURSPrvCUCMSUU
         omTw==
X-Gm-Message-State: AOJu0Yw1COvxFP8q/LCVd4WxIpM+P8RyHhF4xbIRLGTeD25LkBBSiEjZ
	Ifi99peIen1f14dYvopVbw6fl7sjEc2vtv8eiSGOQ7xjAiZME0DjMwKmgA1CfgifUB4PSFCH+5O
	pSPY=
X-Gm-Gg: ASbGnctK5kE8yi6PQkzeGLXqW0LmOrHQh9OBnwHCAA9oD50TvlCHu3GZhTidRoHwkEq
	kadjkc98Algu1d+ISQfgESEW9vBNFr81pQSjj2AtvrnLrQyaE2nSyxgzFS1OUvRjI8Gg1LLQ+QB
	iyjMGipzVoVvzlYzV87zjxdhzKMQGCGA5wrnxb+BZvSHOOmxjKqLlhXz2CKE3DZ1/a790m/LpZN
	hlHbx1FAwDhMFJpeZesMXcG/8pyJ5hfpDgLSmE/S72gMS+7nUoMhvnqqmZJH4Qn0uCNNVHH31Rv
	ftIUhxLQjpZNt47psW46bY89YVaH0X3rByx5Ku2+9CmeYf0=
X-Google-Smtp-Source: AGHT+IGFdMgALKsPh/yOBcPEpPtHnNxwQeHrF4SOqKDJXo/p70nI+zMPXEdR7SegUyRy3tSFD06IsQ==
X-Received: by 2002:a05:6000:2ce:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-390eca07164mr13871828f8f.42.1741102738265;
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Paul Jackson <pj@sgi.com>
Subject: [PATCH 6/9] RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
Date: Tue,  4 Mar 2025 16:37:58 +0100
Message-ID: <20250304153801.597907-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
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

Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 05d3622ea41e5..6155d890f10a4 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
-- 
2.48.1


