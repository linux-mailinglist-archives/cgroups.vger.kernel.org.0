Return-Path: <cgroups+bounces-3207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EB490B3A8
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85161F2781C
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FB1581EF;
	Mon, 17 Jun 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqG4OcjH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3F1581F6
	for <cgroups@vger.kernel.org>; Mon, 17 Jun 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634791; cv=none; b=l4FMnXC4F+tB9Ol22JmGEdkd1Kawe3UeyzLFoeJOhlnFZrjWr9iJ2vU9xwy7YxS+P1/CxsyZ32p+PSJ/hv9bJw40ykznAiLKl+4N69q8whKf6lqfIdBfvpfiyBoTa4GrOFXzR+cmJ3HNs+RPYbUxv0yEPSIG4+vVRNnyWMF5B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634791; c=relaxed/simple;
	bh=fWjqbpNutW3h0ilIV3YbKpiK5u8HlimcRO2ScyVu/wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cB3Z/i9qO+6KreNFJNJ79y9cK3TRE9Cl+HXw0iNg+9w3F5jL7OGIg+/zF6ZLrkVK/gNCF9lNOrtk9iWb+WFfp2Wjgy3PIdgrNBkNHH9Qx5+l8KoKn2+K0HVMK9zZq8EcqhO1TFnsH+PC/fUmozzFC0UmNtIAO8vVidv9IEL+MzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqG4OcjH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718634788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fWjqbpNutW3h0ilIV3YbKpiK5u8HlimcRO2ScyVu/wA=;
	b=hqG4OcjHtBZIPdhZAX8WTstH0VK84WAU2+vQ38IDwbH65I/QMMggWNeN1M/Ro0Qk1F9hTY
	Z0AED+1qKDr1tnP5/E96tLgdWUwD7XLqLCMhsVZfSW1xmF8elhw2EtzXcmDJa22XOPcwds
	zmnT+kledFq0ZIpq4BrfRUmz83M9j8Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-4R28uW_0N_e-gwwSv3TsXw-1; Mon,
 17 Jun 2024 10:33:05 -0400
X-MC-Unique: 4R28uW_0N_e-gwwSv3TsXw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3ACD19560BB;
	Mon, 17 Jun 2024 14:33:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.89])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 603FD19560AF;
	Mon, 17 Jun 2024 14:33:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 17 Jun 2024 16:31:32 +0200 (CEST)
Date: Mon, 17 Jun 2024 16:31:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] cgroup: avoid the unnecessary list_add(dying_tasks) in
 cgroup_exit()
Message-ID: <20240617143129.GA10395@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

Sorry for delay and for confusing you in our previous discussion
here https://lore.kernel.org/all/20240610105028.GA21586@redhat.com/

No, cgroup_exit() can't rely on group_dead, this is racy.

And no, we can't shift css_set_skip_task_iters/etc from cgroup_release()
to cgroup_exit(), an execing sub-thread can change the group leader.

Let me at least send the simple patch which looks "obviously good" to me.

I would really like to remove the usage of signal->live in cgroup.c, but
so far I do not see a simple solution.

With or without this change cgroup.procs can be empty but cgroup.threads
is not. But at least the exiting sub-threads which have already passed
atomic_dec_and_test() should call cgroup_exit() "soon".

Oleg.


