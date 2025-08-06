Return-Path: <cgroups+bounces-8989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9EB1C1CC
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192FB18848F0
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104B21CC68;
	Wed,  6 Aug 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALm63BO6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E221CA1C
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467505; cv=none; b=fF0ZywXlGGErmT9/7p9NPatjr0yBbuaZPb4BPL+2CWkydvhL4G4/aJnYJL9wYQ/6LPM5K9QsqzBEi7ekEDZRN8i630CBKMRq6HdirRUQAaMDQPdT4US5X7ApNAtJgMOgqindWzrJ+ryg+zMunkyZRrS856wXxTCYxWUvpNIgEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467505; c=relaxed/simple;
	bh=7lfJq40vXookEQU4AuQhMVhoimMhCpT5mTAqmMiyPBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SldzAjIlh7RE2AXPPc8rP7qyqjhhrCMfZxAFmNV+7IlCPT8+5ZyPTwWclUIWmQS0DbsSrUMWCkbSwQsLmR2HE7o4Uh48zzoNac8/jeiUIJg7iiHwYCEj3Ess/mkCvWbCEpEmEZhB4cpkGHef6crlHcissbZcbseSnkI2vO7ZUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALm63BO6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24009eeb2a7so51397115ad.0
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754467503; x=1755072303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBkZc2I8Xhg56runQwVtLH1Z+OvKKCEHpi3X5Ya02hU=;
        b=ALm63BO6nHkn2YmgDLb1LT6brMLWkJboxtGmdpUAOZbIoLoioVeFHyD6XcFP64kJru
         r/a5UjqFEG8OMCD+hKpp/NZ0Kb/HVBP2WQjJOgtDdt0iL3FrS6If054dpdtXaGTAT0Do
         kltr3G98CDFpdzAjTyudHw59iUh+OlkxIK7Br7sc9zvQWh7DdDxFHiiGPBedGdaqg8ct
         U3Fi8Uj0r+U251ti54C4wFbxAnok70SfTTL6Bd3wm3PkIJnHlcW9u2yUEO7ndlNB4I3O
         6/NQNXmYj2OqjQl/oQNse2gcr1O6RSs3JqizUgGakiasLwFqrhRUNrEtZzSYsG8kXeL0
         rVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467503; x=1755072303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBkZc2I8Xhg56runQwVtLH1Z+OvKKCEHpi3X5Ya02hU=;
        b=hxwNjepFVUlXc0gU3Etw1aHKD/TjnRLI3Ky0vxIFlstTJZHDmVQtUzhIzp0Wpx4DqG
         qolZCC9nQgtxcAGYpyT4PKLS+e4/SHDQYHBiAwNwnah6MVPmreXFgQ+XeqstAELHjUN8
         sfoq9iqxXk1kGyr+UP3mcrURQqUP2wLV1sxNN6Er8JNjLnm7kY8gfMVlkWz2zKa6akp7
         KN1IcM0oDSNTP4XXLIdaeBsG5znMuVbtygJZwfFn9LFJJlLN8PviDw/OAniwbSAGpDBU
         ONS1d7YHxV6AIUo9gThIeWjDSOINwFtw184WeicsYdV0EllV9jVnOJXQD8J6kVyvlYkg
         J4fA==
X-Gm-Message-State: AOJu0YwcvOgRBQ3UzHDtd259TURKTXPFaY+sGutSF/2uRxgzMuRfLtjS
	2NAkVA0FjqJ1MIe2r9gtVAZPG8ThrXWMsrUUb5aTOTtCI7FfYPkT/gEK2oKP3gsh
X-Gm-Gg: ASbGncuv3tH7kC2Vb5D/IrdbmnfjxPq7hZD/NJkk7w+l6O2Mvge3S0OUgsEVeaeN5lb
	HJZrVifqg8JfXMWOwQRgMG6Sjzbgg/d0pM+tG/q9JNecQmt7GB3Y4cdpLHPXgVIW/flUHBRGIkb
	QbBw2qcZQfptQWtLum2cm2yIKW49vyfk4Qd6j3y0B+OGC2ZvANgz6QWmkizN4OwMS1TOGhuZ+Rd
	dJ6sIopwS4qSQOsx+PWn6seO5lfnI0zawfR1xqtBl+80uDm/EpH0T+NEApchnK0nC7wTm2vF9s/
	7GZArtWkTRxJoNXiQvgtj7ImVN+26HNznWxCNlV3gva/GcqiotQB9z7BtcNuPt1c/jkY8WDZ01p
	3g3MJ9VMEPpvGir6TWD2yug2ZSbo=
X-Google-Smtp-Source: AGHT+IH2AtSV0fjce18tYyd7F5lY0WRPhj7QVCPNltlktHYTXQL47wG/EA1+FCB69Y8Qn5insVr+lA==
X-Received: by 2002:a17:902:ea08:b0:240:bf59:26bb with SMTP id d9443c01a7336-2429ee8be31mr29836415ad.19.1754467502895;
        Wed, 06 Aug 2025 01:05:02 -0700 (PDT)
Received: from localhost ([121.30.179.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e828sm151661695ad.44.2025.08.06.01.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:05:01 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
X-Google-Original-From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH] cgroup: Remove unused css_put_many().
Date: Wed,  6 Aug 2025 16:04:57 +0800
Message-Id: <20250806080457.3308817-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove css_put_many() as it's never called by any function.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/linux/cgroup.h        |  1 -
 include/linux/cgroup_refcnt.h | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..2e232eb8c897 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -322,7 +322,6 @@ void css_get_many(struct cgroup_subsys_state *css, unsigned int n);
 bool css_tryget(struct cgroup_subsys_state *css);
 bool css_tryget_online(struct cgroup_subsys_state *css);
 void css_put(struct cgroup_subsys_state *css);
-void css_put_many(struct cgroup_subsys_state *css, unsigned int n);
 #else
 #define CGROUP_REF_FN_ATTRS	static inline
 #define CGROUP_REF_EXPORT(fn)
diff --git a/include/linux/cgroup_refcnt.h b/include/linux/cgroup_refcnt.h
index 2eea0a69ecfc..1cede70a928c 100644
--- a/include/linux/cgroup_refcnt.h
+++ b/include/linux/cgroup_refcnt.h
@@ -79,18 +79,3 @@ void css_put(struct cgroup_subsys_state *css)
 		percpu_ref_put(&css->refcnt);
 }
 CGROUP_REF_EXPORT(css_put)
-
-/**
- * css_put_many - put css references
- * @css: target css
- * @n: number of references to put
- *
- * Put references obtained via css_get() and css_tryget_online().
- */
-CGROUP_REF_FN_ATTRS
-void css_put_many(struct cgroup_subsys_state *css, unsigned int n)
-{
-	if (!(css->flags & CSS_NO_REF))
-		percpu_ref_put_many(&css->refcnt, n);
-}
-CGROUP_REF_EXPORT(css_put_many)
-- 
2.20.1


