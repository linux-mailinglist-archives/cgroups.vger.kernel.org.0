Return-Path: <cgroups+bounces-7398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F9A7EFBB
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C805C18954C2
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB032222D2;
	Mon,  7 Apr 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq6VJ+aa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D9219A7D
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060930; cv=none; b=bzef+p2AXKrTCSWp39cIb2kNNcrptJwC0LKix7G5XSjSLuKq67pjVKwbLH9gEgFJlB2IQoDEN0MwFtrGO48znKBJrA+5cN5O7S0OAPLUc7nHni3BCphWBphhi0GvdCYIt23a4KdPTMn9Ox/AwzwMpSzB8jjDIXmOQL8jzoX6Hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060930; c=relaxed/simple;
	bh=g5CFip42mFQqpEmbBM/+lzFmhN2ygnDKANEGd2AJ6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GStUyQUfO9GPH8AK7C9aqc/40CCrVfhdC4NfI6RnjpPMHxZpRrUVnQoEsr8LaHOKPgJl4dWcdZnz34Z3b+pybm5uFM6G1m9wpPlfrQIFxd0TSDdd9KZJaRJaE0NemBtaa8mJM0CREq5qSScpcySQLupIyZ3abYkWx0EgNcDml8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dq6VJ+aa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744060927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TnEDpx0qUE5Tyu5NVIbxJ4n/nTjH1L4vePOyeympb+0=;
	b=Dq6VJ+aaHeXwKSED1t7o6pAZg9zYk87xzAel52opKQZ2TKyRsgkLD4sgEbimmW4m/TLlph
	YO9qhp2LvLb26cG1ZUWYMgNOxu9ajFUDVp3tWEVxhZJ9MOM7oWaq5p2Y4O3QLa7ag04hu2
	4+R6B81M6KpC9kewuATRUzRaaSHCAVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-orbbIonaP7CpCAz-xQn1HA-1; Mon,
 07 Apr 2025 17:22:04 -0400
X-MC-Unique: orbbIonaP7CpCAz-xQn1HA-1
X-Mimecast-MFC-AGG-ID: orbbIonaP7CpCAz-xQn1HA_1744060923
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 699061800257;
	Mon,  7 Apr 2025 21:22:03 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C5DB180B487;
	Mon,  7 Apr 2025 21:22:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] cgroup/cpuset: Miscellaneous cleanup patches
Date: Mon,  7 Apr 2025 17:21:02 -0400
Message-ID: <20250407212127.1534285-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series contains a number of cpuset cleanup patches.

Waiman Long (3):
  cgroup/cpuset: Always use cpu_active_mask
  cgroup/cpuset: Fix obsolete comment in cpuset_css_offline()
  cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs

 kernel/cgroup/cpuset.c | 84 ++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 23 deletions(-)

-- 
2.48.1


