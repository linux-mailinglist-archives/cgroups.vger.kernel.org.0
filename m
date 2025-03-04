Return-Path: <cgroups+bounces-6816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6DA4E621
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86B63B0231
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2A2836AB;
	Tue,  4 Mar 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2HYJLli"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81128369F
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102729; cv=none; b=Zp6mocbqIgk1o3wUNQoblDrEAh/jWEftCeQe3bmBbK0hp08daeA72S/gF9ecs7uZFXbrwSRUtuIPw1FqiXQvJdMsHXIU9zmYxuuRDoJ1Gtv9l7LGLwx7iqaMdDBxQfxT2SicXNGSHCHDRd8EOwcGjjPZ1fIAw58putRhI8qmHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102729; c=relaxed/simple;
	bh=j/4wLCwQln8i7pXmi4m03KiQwQyMuLnJxfUl/0RP5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJg8pvot9TmRQ+FoZ4mpsowAOHkQ38QP987aRcEK9dDX4mKiUJw1MxJZWhAKf7TFvwQtZkUsVhucBnzZiLIvZcZ/GhuCjYXQcwr6Kqk8zfLoS9XWpRgD4QL4DLpzZnzqhDJ4c2H2jE/vrMVrW9coqqPVQSkqSLp5oYRDlv+7/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2HYJLli; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so3210726f8f.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102726; x=1741707526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=N2HYJLliJ9A/Tj6vHsUxVN93UT6Fy84xy/lYFyQ6ldK6DNjsMaczFQGZMBa5eG3til
         TxjVJcEVt109Wx4/gTU7rImxV+PeSWDaAAZPLZ8IF7lrNqPHMhwBqva0pe3wU/rfMRf0
         A0cO8qitFhDk7ArJRt0GzDrNfy+8cUP9v3HdBFeinJIn3MTFE+NMe0BFFgRVbKMb7wEb
         FxJRXU7CFz0yeLT6Xh+yKL+NCGqb2SIO5c7DIq4iKi9ckOJOjXMXuI3AJ0HEAwt8wJ0s
         tUSYJc4nUVdesSKpY99OtF7rygHU51W7uItPGvwpXKmG1aV7Wv57WtRvJ401A80GcQoF
         PVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102726; x=1741707526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=xRVsi+GtUuCqfcHeBCfrZehjrqY0PZQNCyjyDhRH3hs2zwh057UmXRy+ahOpGFV2Am
         Xnx/xAmmF6/OyDKh6cwA3Wjj9SYDoqTctyrDD2jOW1+KP9mBVga4nor01yc6fOzAwV7f
         aLLt4/FYB+kJYiJh2xeotUccOL0xPvQvzvAkVX2JMqXSF8alk2j/rFP9AyPkoz5Fz6e0
         7DllLAdmQp0mw/QKKCRZSMLwBN6MDkeHwwWlS9RfQ9JF5CVqBBpeYukYGY1tgc8ohWXD
         hCPsWYMuGafbCImFB6P4J9R9c4PcDiKbi2QGtpCOhKNxJ1hc908v9CCLTIRy+z5zrMC6
         slZA==
X-Gm-Message-State: AOJu0YwyoRMrDRF4hEwcTzOpTyULAOkR4HtAL43uAwK/KnJ4Vn2iqW00
	wJ48ah0eRXbHidvY3W1aPiX88vlcBkDe/kfJ3FvoDWtRihxtmimjNtH+CaUNmalxCn2+2FdgYx3
	Q2Xg=
X-Gm-Gg: ASbGnctxpdy2n7LjRHwHklRaV7+qxGvUZaVVi2FXe+dh9VZUG6vdohntqcYzGJk//aM
	jTsucPPbUpKd9XWHbXoA2qRttWu9bAowMoFlM2lMsl5gPAmQjZF7/qHj7Gbo7aahJ7EVL+/Y4iM
	biJgWsTqMCbaTlPNGcy0s80Xg994YUemreWdi+iOTILhsPKWxewvkyHNCDpW/uql6g0l1Z0Dw1L
	ePR9AuDh2t7mLDAvphtumA8NYSrgglMJPdRgOZGbaU9iyzmuCs2oZC/c5wIe0IqEMZ5U6+zAhIy
	vImlPHMd6ocqdEvMC8zDBWtdNN/xVkS8juYRigVd2vPy1DM=
X-Google-Smtp-Source: AGHT+IFzh8tpm5PJ+6KB1qG+RR0gOraUB8vKw1xBf/Zc44nQ/d4j9J/DEIN5yaKw5Z2Ch0s1pQhPNw==
X-Received: by 2002:a5d:5849:0:b0:391:268:6475 with SMTP id ffacd0b85a97d-391026866f1mr5796830f8f.20.1741102725724;
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/9] cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and memory_spread_slab
Date: Tue,  4 Mar 2025 16:37:54 +0100
Message-ID: <20250304153801.597907-3-mkoutny@suse.com>
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

There is MPOL_INTERLEAVE for user explicit allocations.
Deprecate spreading of allocations that users carry out unwittingly.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 3e81ac76578c7..9aae6dabb0b56 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
-- 
2.48.1


