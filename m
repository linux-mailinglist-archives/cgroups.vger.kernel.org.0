Return-Path: <cgroups+bounces-8811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB8FB0CF2E
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C1D3B46ED
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C91A83E4;
	Tue, 22 Jul 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9XvHgFH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302172E370E;
	Tue, 22 Jul 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148448; cv=none; b=iJcM+GN4+ZSa7o0aI06JaKr8HCpxOOtClMvuZWDCENeqaYYhYVgcQomhn90uDSeObNcVKx7KYWeZ+mx8QtNSMfxkfIu9FE5B/B/G16IhRbF/B2UvlzyKcx6ue4WxGPrMK3/dsTNK8Ll27x5WmtSHhz1EYTUCVB9q91ESFtjw3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148448; c=relaxed/simple;
	bh=13RPCAsLtI9nm4MyBJcFasXryCJqgVO4pE7KY5hUjOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtHvjKI8Z0xvalDRwTjlZBPpstvl3SOy3fUpfo/KimchkrVuTpIMu/ykYY0HJwTgHb3zwMr+VL/yu+0JVSD3s1FR0oYh/cI7blwhqaCek+YaHSsJYinjXo72TL//F8r1BhMZfwFFP9wP12jnHx/2OS04jpgdnMptoSZTSUHvOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9XvHgFH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b54cead6cso3161365b3a.1;
        Mon, 21 Jul 2025 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148446; x=1753753246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0pf3DydH/ONPr9aS0eItlaO+S5/eq/f/rOH4YkGbpI=;
        b=I9XvHgFHLrb+brThEEuDSbQHSuyfa7I26mB62xLEoaHryckX2m0AgnLgUaCxfv4424
         +mh7YWKcSXaKi6k1pB7w1LH3LeSHONLCg6FM3Q8qaT9MYUJUZ0edVPo4mjikP/0u3mQ0
         4RCX1mrQhBwjKDzrEbwb4oyzEoZXPD2YUBw4g6dF5qBDbjTll6fdG01ZCPWoTxWipJB3
         iP2CNm8n77wlFfIPj+MHpGZDZU0q0uDdsp2XcGS78OKjC0Jbd3XhUuk44SDx7omwBab0
         9J8e1YBnp+pRUReQcEgmQimaHs5RIvAFWjCsIEnQyHnx+0G13Ij5NIHixhzxO6NyqfB8
         hcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148446; x=1753753246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0pf3DydH/ONPr9aS0eItlaO+S5/eq/f/rOH4YkGbpI=;
        b=V80Eteby/HpcMSOZLPd4gqeim5KEi9c+wTv1AlkKEDauMVN1K19MtESVS5a8j7GMaB
         H3666tWioNh1GejuabsA5R0zO/HOjAr7YUL6iP1lNulKynApHAy1Vg39MSL0g994Cgb4
         SRG4UHgYtA169oYU426TIFF/DE6vZK9+JZu5fOP154Fe63BtsYPGfQu8qscuQPI7t/sC
         HFE7IeISFiuZRDab1G4ePAIcO1qfVEAtHO81nkgznnSUwoNCp+ZxQ0avJXxuPNChGX4y
         DbxF9bNd1dM0jUVKiIll1g9tu0dIGRydXrJgkyKBW0YEMe72Gm8UbEMlIBgPpjEqjcwP
         DNug==
X-Forwarded-Encrypted: i=1; AJvYcCVPubCEBTf9EOs1BholT85rj+bScnlMvqnvKZHoCw0lBngvloGliFUZa+5W/t4nzjX1YAbiROIS@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6G2WfagIj0jlYVtekKxJXYNHd9QfR/00S3l6+R+UPMyCrncz
	viFYHP1e2ksvnoRIMhZxEAnhU2zKhfl6gAZG/JAahkDWK/9+KoFH0Za8
X-Gm-Gg: ASbGncvZJmxxetwuCxVZ2fkL/UqTL1F0qaI9kLgTfhv1IW2xrO99JxzjBQREjZwZd2j
	XeztxBWgwvOx3g0lKzsY0UqYnqYlBTFT6g88/6FEml2hykTH+rd3uOwwkk6mm9usPo9yoJ57pj6
	OBQzZw1mieGYdW1Axfe/Upvueom+FDWsL4GjYSYPnC+U3V6L5H6qzep2sliXeQOtP0CU8mGolI8
	R+d4MKA+yQxxkb+YmQDcDCHCHrI+nhdCQw6XS9HApz8JEX+kZAuQfuzu9tsyNvq8gVVjnx/Hpgi
	Q9f8WzXun8YZU/XE9URoXCKxdgvUudpDYlQEkyOj+F5lbt7DxPy3t6YCqr+6jSvhgXwVC9bKgfo
	chdL9fmraraGlhO6+l0hE9TeZye5T1Va3ooSndoL1fzCfXUszpkr78covBNI=
X-Google-Smtp-Source: AGHT+IE2GBejtqme21eN4aC3GHAnCJumMUySWozFtjpYk9U01dhgASg60k/B+QCFDlzVBQs0353iIg==
X-Received: by 2002:a05:6a00:aa89:b0:75a:c415:7804 with SMTP id d2e1a72fcca58-75ac41578c3mr19692983b3a.8.1753148446253;
        Mon, 21 Jul 2025 18:40:46 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:45 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe placement of call to css_rstat_init()
Date: Mon, 21 Jul 2025 18:40:25 -0700
Message-ID: <20250722014030.297537-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within css_create() there are several error paths that lead to async
cleanup of a given css. An warning was found [0] which appears to be the
result of calling css_rstat_exit() on this cleanup path with a css having
uninitialized rstat objects. This series makes adjustments to provide up a
place in css_create() where css_rstat_init() can both 1) fail gracefully
and 2) guarantee completion before async cleanup leading to
css_rstat_exit() occurs.

The core change is splitting init_and_link_css() into two separate
functions and calling css_rstat_init() between them. The reason for this is
that because of the refcount incrementing that occurs within, this function
puts a constraint on the error handling that follows. See excerpt below:

css_create(...)
{
	...
	init_and_link_css(css, ...);
	/* any subsequent error needs async css cleanup */

	err = percpu_ref_init(...);
	if (err)
		goto err_free_css;
	err = cgroup_idr_alloc(...);
	if (err)
		goto err_free_css;
	err = css_rstat_init(css, ...);
	if (err)
		goto err_free_css;
	...
err_free_css:
	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
	return ERR_PTR(err);
}

If any of the three goto jumps are taken, async cleanup will begin and
css_rstat_exit() will be invoked. But since css_rstat_init() would not have
succeeded, the warning will eventually be reached.

In this series, the code above changes to resemble something like this:

css_create(...)
{
	...
	init_css(css);
	if (css->css_rstat_flush) {
		err = css_rstat_init(css)
		if (err) {
			ss->css_free(css);
			return ERR_PTR(err);
		}
	}
	link_css(css, ...);
	...
}

There was some refactoring done to eliminate self-imposed constraints on
where css_rstat_init() may be called. For example, one previous constraint
was that css_rstat_init() could only be called after init_and_link_css()
since that is where it gets its subsystem and cgroup fields set, and
css->ss was used to determine how to allocate rstat (base or subsystem).
The changes in this series remove this constraint by eliminating the
dependency of subsystem/cgroup information in rstat init/exit. The
resulting init/exit routines can work exclusively on rstat entities and not
be concerned with other types of entities.

The refactoring may also improve maintainability. Existing code like this:

css_rstat_init(&cgrp->self); /* for base state */
css_rstat_init(css); /* for subsystems */

... will now look like this:

cgroup_rstat_base_init(cgrp); /* for base stats */
css_rstat_init(css); /* for subsystems */

Finally, the number of nested conditionals in two functions above has been
reduced compared to the amount previously in css_rstat_init/exit(). This
could help improve code readability.

[0] https://lore.kernel.org/all/684c5802.a00a0220.279073.0016.GAE@google.com/

JP Kobryn (5):
  cgroup: add exclusive css rstat init/exit api for base stats
  cgroup: check for rstat flush callback at css rstat init/exit call
    sites
  cgroup: split init_and_link_css()
  cgroup: initialize css rstat before linking to cgroups in css_create()
  cgroup: break up the internal rstat init/exit logic by subsys and base

 kernel/cgroup/cgroup-internal.h |  2 +
 kernel/cgroup/cgroup.c          | 57 ++++++++++++++++++----------
 kernel/cgroup/rstat.c           | 67 +++++++++++++++++----------------
 3 files changed, 74 insertions(+), 52 deletions(-)

-- 
2.47.1


