Return-Path: <cgroups+bounces-3688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F093C931C32
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD67281A2C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478713B5B6;
	Mon, 15 Jul 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="Va2dqn6A"
X-Original-To: cgroups@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3113B586
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076385; cv=none; b=qFz4oljQU2wT/qXDxp4u9J3IowOn8tecrZPiUnrIEZMjMzOk/Y7C1yYPVE0pJ5YQSbJi7RlkYqkUTwOBgJQxJcmqELn5lO90gZJ6wIFJD5lfrFqSY5L+/HVBt7M5lebFGz9jqikCeGtjziv2saVSWhJo2yRh/xd7fO5L4J5nbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076385; c=relaxed/simple;
	bh=60XeB4Y6cdSYT0bzY86psxuZFgQeK3RBilXsfgGxjq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYja8ke3qi79OI1Q73P+rVqE3M2uOV6PZrlt5mxAluLDO1035SFn+rXjIaaLD91bMvalqA2A/YNYVh0tLRULd+F02K+su9YS3v+eSPiLrUfA5GeF7BYnstFByhnexijzyrX3qTTPH0buGCVu+1CGg4bk4L12lH5jOcfPum7LgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=Va2dqn6A; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721076384; x=1721083584;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=60XeB4Y6cdSYT0bzY86psxuZFgQeK3RBilXsfgGxjq8=;
 b=Va2dqn6Akp21i4jZG7p9ivyj7aAB7Gsxe3vBNQ9bs96Om7ZNi+oc94kEpBbPH+CuMbm4ALiL8CCRi/9Gs4fDCTg8ieO2c5pIekhhkHzMGdmvTcBgwp6raaxKHIN6ibRkgIQ0/sFGjSqSvqGZZtoTkWC8Tlt7n8ikCBWsM3Fsfv0=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyIzY2RlYyIsImNncm91cHNAdmdlci5rZXJuZWwub3JnIiwiOWQyYTFjIl0=
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 12c5aac5a65f with SMTP id 66958aa044aa56963350d37e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jul 2024 20:46:24 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-c45160e0-vtn6.c.vimeo-core.internal [10.56.27.201])
	by smtp.vimeo.com (Postfix) with ESMTP id 732246011D;
	Mon, 15 Jul 2024 20:46:23 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id E104DB4070C; Mon, 15 Jul 2024 16:37:30 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 15 Jul 2024 16:36:25 -0400
Message-Id: <20240715203625.1462309-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rebase of a patch I sent a few months ago, on which I received
two acks, but the thread petered out:
https://www.spinics.net/lists/cgroups/msg40602.html.

I'm hoping that it can make it into the next LTS (and 6.11 if possible)

Thank you,

David Finkel

Sr. Principal Software Engineer, Vimeo


