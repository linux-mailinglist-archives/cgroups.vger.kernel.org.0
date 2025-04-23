Return-Path: <cgroups+bounces-7761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D7A99AEC
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 23:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF46B1B82F2E
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E41F5617;
	Wed, 23 Apr 2025 21:44:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BE46447
	for <cgroups@vger.kernel.org>; Wed, 23 Apr 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444685; cv=none; b=B/Be/O4kyzxyBt8udaI7e/Dm0fzS3+6cukJ+kp8qyhFDA95e9yZAh8xdonyATrB/DWjuLIv6WQr1EYVtzTAuF6tzbDYHmzgz58MAj2E416g5BKVTGXe73oV9fYlEDTeUoxvOAITs3XM1znZvoIyvf24QJ/n0Kvn5vwYsUWRtUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444685; c=relaxed/simple;
	bh=UdVx3MTKaG4DDfew+tj+fXDm/1EsUNQQ9VmmljgciNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Q+thgJTjpC+vX2M719RfT5U8coFPqlk/FKqrIlYN2b9EITDMlnUeNs+1G9i3L5FNSuafQOZi0EYqwKrmjSFCWhU0ukFMu7S0rSc17RF5ZaqJSO8A9PtowEeQH5qor5/xckY4Xp96G6QWBGGrz9vr38DHEmqEjEgn6LYdvY9ay8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-6vVTT7RnMV-wBLkCJW9S6g-1; Wed,
 23 Apr 2025 17:43:29 -0400
X-MC-Unique: 6vVTT7RnMV-wBLkCJW9S6g-1
X-Mimecast-MFC-AGG-ID: 6vVTT7RnMV-wBLkCJW9S6g_1745444608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8DF1800570;
	Wed, 23 Apr 2025 21:43:28 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37B9D19560A3;
	Wed, 23 Apr 2025 21:43:25 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com
Cc: cgroups@vger.kernel.org
Subject: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration
Date: Thu, 24 Apr 2025 07:37:02 +1000
Message-ID: <20250423214321.100440-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FDKX1XKSHuR1bi_hkE0X19er1locMsuHn-EmUDSBfTM_1745444608
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

Hey,

I've been tasked to look into this, and I'm going start from hopeless
naivety and see how far I can get. This is an initial attempt to hook
TTM system memory allocations into memcg and account for them.

It does:
1. Adds memcg GPU statistic,
2. Adds TTM memcg pointer for drivers to set on their user object
allocation paths
3. Adds a singular path where we account for memory in TTM on cached
non-pooled non-dma allocations. Cached memory allocations used to be
pooled but we dropped that a while back which makes them the best target
to start attacking this from.
4. It only accounts for memory that is allocated directly from a userspace
TTM operation (like page faults or validation). It *doesn't* account for
memory allocated in eviction paths due to device memory pressure.

This seems to work for me here on my hacked up tests systems at least, I
can see the GPU stats moving and they look sane.

Future work:
Account for pooled non-cached
Account for pooled dma allocations (no idea how that looks)
Figure out if accounting for eviction is possible, and what it might look
like.

Dave.


